using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text;

namespace System.Resources;

[ComVisible(true)]
public sealed class ResourceReader : IResourceReader, IEnumerable, IDisposable
{
	internal sealed class ResourceEnumerator : IDictionaryEnumerator, IEnumerator
	{
		private ResourceReader _reader;

		private bool _currentIsValid;

		private int _currentName;

		private int _dataPosition;

		public object Key
		{
			get
			{
				if (_currentName == int.MinValue)
				{
					throw new InvalidOperationException(Environment.GetResourceString("Enumeration already finished."));
				}
				if (!_currentIsValid)
				{
					throw new InvalidOperationException(Environment.GetResourceString("Enumeration has not started. Call MoveNext."));
				}
				if (_reader._resCache == null)
				{
					throw new InvalidOperationException(Environment.GetResourceString("ResourceReader is closed."));
				}
				return _reader.AllocateStringForNameIndex(_currentName, out _dataPosition);
			}
		}

		public object Current => Entry;

		internal int DataPosition => _dataPosition;

		public DictionaryEntry Entry
		{
			get
			{
				if (_currentName == int.MinValue)
				{
					throw new InvalidOperationException(Environment.GetResourceString("Enumeration already finished."));
				}
				if (!_currentIsValid)
				{
					throw new InvalidOperationException(Environment.GetResourceString("Enumeration has not started. Call MoveNext."));
				}
				if (_reader._resCache == null)
				{
					throw new InvalidOperationException(Environment.GetResourceString("ResourceReader is closed."));
				}
				object obj = null;
				string key;
				lock (_reader)
				{
					lock (_reader._resCache)
					{
						key = _reader.AllocateStringForNameIndex(_currentName, out _dataPosition);
						if (_reader._resCache.TryGetValue(key, out var value))
						{
							obj = value.Value;
						}
						if (obj == null)
						{
							obj = ((_dataPosition != -1) ? _reader.LoadObject(_dataPosition) : _reader.GetValueForNameIndex(_currentName));
						}
					}
				}
				return new DictionaryEntry(key, obj);
			}
		}

		public object Value
		{
			get
			{
				if (_currentName == int.MinValue)
				{
					throw new InvalidOperationException(Environment.GetResourceString("Enumeration already finished."));
				}
				if (!_currentIsValid)
				{
					throw new InvalidOperationException(Environment.GetResourceString("Enumeration has not started. Call MoveNext."));
				}
				if (_reader._resCache == null)
				{
					throw new InvalidOperationException(Environment.GetResourceString("ResourceReader is closed."));
				}
				return _reader.GetValueForNameIndex(_currentName);
			}
		}

		internal ResourceEnumerator(ResourceReader reader)
		{
			_currentName = -1;
			_reader = reader;
			_dataPosition = -2;
		}

		public bool MoveNext()
		{
			if (_currentName == _reader._numResources - 1 || _currentName == int.MinValue)
			{
				_currentIsValid = false;
				_currentName = int.MinValue;
				return false;
			}
			_currentIsValid = true;
			_currentName++;
			return true;
		}

		public void Reset()
		{
			if (_reader._resCache == null)
			{
				throw new InvalidOperationException(Environment.GetResourceString("ResourceReader is closed."));
			}
			_currentIsValid = false;
			_currentName = -1;
		}
	}

	private BinaryReader _store;

	internal Dictionary<string, ResourceLocator> _resCache;

	private long _nameSectionOffset;

	private long _dataSectionOffset;

	private int[] _nameHashes;

	private unsafe int* _nameHashesPtr;

	private int[] _namePositions;

	private unsafe int* _namePositionsPtr;

	private RuntimeType[] _typeTable;

	private int[] _typeNamePositions;

	private BinaryFormatter _objFormatter;

	private int _numResources;

	private UnmanagedMemoryStream _ums;

	private int _version;

	internal ResourceReader(Stream stream, Dictionary<string, ResourceLocator> resCache)
	{
		_resCache = resCache;
		_store = new BinaryReader(stream, Encoding.UTF8);
		_ums = stream as UnmanagedMemoryStream;
		ReadResources();
	}

	public void Close()
	{
		Dispose(disposing: true);
	}

	public void Dispose()
	{
		Close();
	}

	private unsafe void Dispose(bool disposing)
	{
		if (_store != null)
		{
			_resCache = null;
			if (disposing)
			{
				BinaryReader store = _store;
				_store = null;
				store?.Close();
			}
			_store = null;
			_namePositions = null;
			_nameHashes = null;
			_ums = null;
			_namePositionsPtr = null;
			_nameHashesPtr = null;
		}
	}

	internal unsafe static int ReadUnalignedI4(int* p)
	{
		return *(byte*)p | (((byte*)p)[1] << 8) | (((byte*)p)[2] << 16) | (((byte*)p)[3] << 24);
	}

	private void SkipString()
	{
		int num = _store.Read7BitEncodedInt();
		if (num < 0)
		{
			throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file. String length must be non-negative."));
		}
		_store.BaseStream.Seek(num, SeekOrigin.Current);
	}

	private unsafe int GetNameHash(int index)
	{
		if (_ums == null)
		{
			return _nameHashes[index];
		}
		return ReadUnalignedI4(_nameHashesPtr + index);
	}

	private unsafe int GetNamePosition(int index)
	{
		int num = ((_ums != null) ? ReadUnalignedI4(_namePositionsPtr + index) : _namePositions[index]);
		if (num < 0 || num > _dataSectionOffset - _nameSectionOffset)
		{
			throw new FormatException(Environment.GetResourceString("Corrupt .resources file. Invalid offset '{0}' into name section.", num));
		}
		return num;
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public IDictionaryEnumerator GetEnumerator()
	{
		if (_resCache == null)
		{
			throw new InvalidOperationException(Environment.GetResourceString("ResourceReader is closed."));
		}
		return new ResourceEnumerator(this);
	}

	internal ResourceEnumerator GetEnumeratorInternal()
	{
		return new ResourceEnumerator(this);
	}

	internal int FindPosForResource(string name)
	{
		int num = FastResourceComparer.HashFunction(name);
		int num2 = 0;
		int i = _numResources - 1;
		int num3 = -1;
		bool flag = false;
		while (num2 <= i)
		{
			num3 = num2 + i >> 1;
			int nameHash = GetNameHash(num3);
			int num4 = ((nameHash != num) ? ((nameHash >= num) ? 1 : (-1)) : 0);
			if (num4 == 0)
			{
				flag = true;
				break;
			}
			if (num4 < 0)
			{
				num2 = num3 + 1;
			}
			else
			{
				i = num3 - 1;
			}
		}
		if (!flag)
		{
			return -1;
		}
		if (num2 != num3)
		{
			num2 = num3;
			while (num2 > 0 && GetNameHash(num2 - 1) == num)
			{
				num2--;
			}
		}
		if (i != num3)
		{
			for (i = num3; i < _numResources - 1 && GetNameHash(i + 1) == num; i++)
			{
			}
		}
		lock (this)
		{
			for (int j = num2; j <= i; j++)
			{
				_store.BaseStream.Seek(_nameSectionOffset + GetNamePosition(j), SeekOrigin.Begin);
				if (CompareStringEqualsName(name))
				{
					int num5 = _store.ReadInt32();
					if (num5 < 0 || num5 >= _store.BaseStream.Length - _dataSectionOffset)
					{
						throw new FormatException(Environment.GetResourceString("Corrupt .resources file. Invalid offset '{0}' into data section.", num5));
					}
					return num5;
				}
			}
		}
		return -1;
	}

	private unsafe bool CompareStringEqualsName(string name)
	{
		int num = _store.Read7BitEncodedInt();
		if (num < 0)
		{
			throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file. String length must be non-negative."));
		}
		if (_ums != null)
		{
			byte* positionPointer = _ums.PositionPointer;
			_ums.Seek(num, SeekOrigin.Current);
			if (_ums.Position > _ums.Length)
			{
				throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file. Resource name extends past the end of the file."));
			}
			return FastResourceComparer.CompareOrdinal(positionPointer, num, name) == 0;
		}
		byte[] array = new byte[num];
		int num2 = num;
		while (num2 > 0)
		{
			int num3 = _store.Read(array, num - num2, num2);
			if (num3 == 0)
			{
				throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file. A resource name extends past the end of the stream."));
			}
			num2 -= num3;
		}
		return FastResourceComparer.CompareOrdinal(array, num / 2, name) == 0;
	}

	private unsafe string AllocateStringForNameIndex(int index, out int dataOffset)
	{
		long num = GetNamePosition(index);
		int num2;
		byte[] array2;
		lock (this)
		{
			_store.BaseStream.Seek(num + _nameSectionOffset, SeekOrigin.Begin);
			num2 = _store.Read7BitEncodedInt();
			if (num2 < 0)
			{
				throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file. String length must be non-negative."));
			}
			if (_ums != null)
			{
				if (_ums.Position > _ums.Length - num2)
				{
					throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file. String for name index '{0}' extends past the end of the file.", index));
				}
				string text = null;
				char* positionPointer = (char*)_ums.PositionPointer;
				if (!BitConverter.IsLittleEndian)
				{
					byte* ptr = (byte*)positionPointer;
					byte[] array = new byte[num2];
					for (int i = 0; i < num2; i += 2)
					{
						array[i] = (ptr + i)[1];
						array[i + 1] = ptr[i];
					}
					fixed (byte* value = array)
					{
						text = new string((char*)value, 0, num2 / 2);
					}
				}
				else
				{
					text = new string(positionPointer, 0, num2 / 2);
				}
				_ums.Position += num2;
				dataOffset = _store.ReadInt32();
				if (dataOffset < 0 || dataOffset >= _store.BaseStream.Length - _dataSectionOffset)
				{
					throw new FormatException(Environment.GetResourceString("Corrupt .resources file. Invalid offset '{0}' into data section.", dataOffset));
				}
				return text;
			}
			array2 = new byte[num2];
			int num3 = num2;
			while (num3 > 0)
			{
				int num4 = _store.Read(array2, num2 - num3, num3);
				if (num4 == 0)
				{
					throw new EndOfStreamException(Environment.GetResourceString("Corrupt .resources file. The resource name for name index {0} extends past the end of the stream.", index));
				}
				num3 -= num4;
			}
			dataOffset = _store.ReadInt32();
			if (dataOffset < 0 || dataOffset >= _store.BaseStream.Length - _dataSectionOffset)
			{
				throw new FormatException(Environment.GetResourceString("Corrupt .resources file. Invalid offset '{0}' into data section.", dataOffset));
			}
		}
		return Encoding.Unicode.GetString(array2, 0, num2);
	}

	private object GetValueForNameIndex(int index)
	{
		long num = GetNamePosition(index);
		lock (this)
		{
			_store.BaseStream.Seek(num + _nameSectionOffset, SeekOrigin.Begin);
			SkipString();
			int num2 = _store.ReadInt32();
			if (num2 < 0 || num2 >= _store.BaseStream.Length - _dataSectionOffset)
			{
				throw new FormatException(Environment.GetResourceString("Corrupt .resources file. Invalid offset '{0}' into data section.", num2));
			}
			if (_version == 1)
			{
				return LoadObjectV1(num2);
			}
			ResourceTypeCode typeCode;
			return LoadObjectV2(num2, out typeCode);
		}
	}

	internal string LoadString(int pos)
	{
		_store.BaseStream.Seek(_dataSectionOffset + pos, SeekOrigin.Begin);
		string result = null;
		int num = _store.Read7BitEncodedInt();
		if (_version == 1)
		{
			if (num == -1)
			{
				return null;
			}
			if (FindType(num) != typeof(string))
			{
				throw new InvalidOperationException(Environment.GetResourceString("Resource was of type '{0}' instead of String - call GetObject instead.", FindType(num).FullName));
			}
			result = _store.ReadString();
		}
		else
		{
			ResourceTypeCode resourceTypeCode = (ResourceTypeCode)num;
			if (resourceTypeCode != ResourceTypeCode.String && resourceTypeCode != ResourceTypeCode.Null)
			{
				string text = ((resourceTypeCode >= ResourceTypeCode.StartOfUserTypes) ? FindType((int)(resourceTypeCode - 64)).FullName : resourceTypeCode.ToString());
				throw new InvalidOperationException(Environment.GetResourceString("Resource was of type '{0}' instead of String - call GetObject instead.", text));
			}
			if (resourceTypeCode == ResourceTypeCode.String)
			{
				result = _store.ReadString();
			}
		}
		return result;
	}

	internal object LoadObject(int pos)
	{
		if (_version == 1)
		{
			return LoadObjectV1(pos);
		}
		ResourceTypeCode typeCode;
		return LoadObjectV2(pos, out typeCode);
	}

	internal object LoadObject(int pos, out ResourceTypeCode typeCode)
	{
		if (_version == 1)
		{
			object obj = LoadObjectV1(pos);
			typeCode = ((obj is string) ? ResourceTypeCode.String : ResourceTypeCode.StartOfUserTypes);
			return obj;
		}
		return LoadObjectV2(pos, out typeCode);
	}

	internal object LoadObjectV1(int pos)
	{
		try
		{
			return _LoadObjectV1(pos);
		}
		catch (EndOfStreamException inner)
		{
			throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file.  The specified type doesn't match the available data in the stream."), inner);
		}
		catch (ArgumentOutOfRangeException inner2)
		{
			throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file.  The specified type doesn't match the available data in the stream."), inner2);
		}
	}

	private object _LoadObjectV1(int pos)
	{
		_store.BaseStream.Seek(_dataSectionOffset + pos, SeekOrigin.Begin);
		int num = _store.Read7BitEncodedInt();
		if (num == -1)
		{
			return null;
		}
		RuntimeType runtimeType = FindType(num);
		if (runtimeType == typeof(string))
		{
			return _store.ReadString();
		}
		if (runtimeType == typeof(int))
		{
			return _store.ReadInt32();
		}
		if (runtimeType == typeof(byte))
		{
			return _store.ReadByte();
		}
		if (runtimeType == typeof(sbyte))
		{
			return _store.ReadSByte();
		}
		if (runtimeType == typeof(short))
		{
			return _store.ReadInt16();
		}
		if (runtimeType == typeof(long))
		{
			return _store.ReadInt64();
		}
		if (runtimeType == typeof(ushort))
		{
			return _store.ReadUInt16();
		}
		if (runtimeType == typeof(uint))
		{
			return _store.ReadUInt32();
		}
		if (runtimeType == typeof(ulong))
		{
			return _store.ReadUInt64();
		}
		if (runtimeType == typeof(float))
		{
			return _store.ReadSingle();
		}
		if (runtimeType == typeof(double))
		{
			return _store.ReadDouble();
		}
		if (runtimeType == typeof(DateTime))
		{
			return new DateTime(_store.ReadInt64());
		}
		if (runtimeType == typeof(TimeSpan))
		{
			return new TimeSpan(_store.ReadInt64());
		}
		if (runtimeType == typeof(decimal))
		{
			int[] array = new int[4];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = _store.ReadInt32();
			}
			return new decimal(array);
		}
		return DeserializeObject(num);
	}

	internal object LoadObjectV2(int pos, out ResourceTypeCode typeCode)
	{
		try
		{
			return _LoadObjectV2(pos, out typeCode);
		}
		catch (EndOfStreamException inner)
		{
			throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file.  The specified type doesn't match the available data in the stream."), inner);
		}
		catch (ArgumentOutOfRangeException inner2)
		{
			throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file.  The specified type doesn't match the available data in the stream."), inner2);
		}
	}

	private unsafe object _LoadObjectV2(int pos, out ResourceTypeCode typeCode)
	{
		_store.BaseStream.Seek(_dataSectionOffset + pos, SeekOrigin.Begin);
		typeCode = (ResourceTypeCode)_store.Read7BitEncodedInt();
		switch (typeCode)
		{
		case ResourceTypeCode.Null:
			return null;
		case ResourceTypeCode.String:
			return _store.ReadString();
		case ResourceTypeCode.Boolean:
			return _store.ReadBoolean();
		case ResourceTypeCode.Char:
			return (char)_store.ReadUInt16();
		case ResourceTypeCode.Byte:
			return _store.ReadByte();
		case ResourceTypeCode.SByte:
			return _store.ReadSByte();
		case ResourceTypeCode.Int16:
			return _store.ReadInt16();
		case ResourceTypeCode.UInt16:
			return _store.ReadUInt16();
		case ResourceTypeCode.Int32:
			return _store.ReadInt32();
		case ResourceTypeCode.UInt32:
			return _store.ReadUInt32();
		case ResourceTypeCode.Int64:
			return _store.ReadInt64();
		case ResourceTypeCode.UInt64:
			return _store.ReadUInt64();
		case ResourceTypeCode.Single:
			return _store.ReadSingle();
		case ResourceTypeCode.Double:
			return _store.ReadDouble();
		case ResourceTypeCode.Decimal:
			return _store.ReadDecimal();
		case ResourceTypeCode.DateTime:
			return DateTime.FromBinary(_store.ReadInt64());
		case ResourceTypeCode.TimeSpan:
			return new TimeSpan(_store.ReadInt64());
		case ResourceTypeCode.ByteArray:
		{
			int num2 = _store.ReadInt32();
			if (num2 < 0)
			{
				throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file.  The specified data length '{0}' is not a valid position in the stream.", num2));
			}
			if (_ums == null)
			{
				if (num2 > _store.BaseStream.Length)
				{
					throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file.  The specified data length '{0}' is not a valid position in the stream.", num2));
				}
				return _store.ReadBytes(num2);
			}
			if (num2 > _ums.Length - _ums.Position)
			{
				throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file.  The specified data length '{0}' is not a valid position in the stream.", num2));
			}
			byte[] array = new byte[num2];
			_ums.Read(array, 0, num2);
			return array;
		}
		case ResourceTypeCode.Stream:
		{
			int num = _store.ReadInt32();
			if (num < 0)
			{
				throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file.  The specified data length '{0}' is not a valid position in the stream.", num));
			}
			if (_ums == null)
			{
				return new PinnedBufferMemoryStream(_store.ReadBytes(num));
			}
			if (num > _ums.Length - _ums.Position)
			{
				throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file.  The specified data length '{0}' is not a valid position in the stream.", num));
			}
			return new UnmanagedMemoryStream(_ums.PositionPointer, num, num, FileAccess.Read);
		}
		default:
		{
			if (typeCode < ResourceTypeCode.StartOfUserTypes)
			{
				throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file.  The specified type doesn't match the available data in the stream."));
			}
			int typeIndex = (int)(typeCode - 64);
			return DeserializeObject(typeIndex);
		}
		}
	}

	private object DeserializeObject(int typeIndex)
	{
		RuntimeType runtimeType = FindType(typeIndex);
		object obj = _objFormatter.Deserialize(_store.BaseStream);
		if (obj.GetType() != runtimeType)
		{
			throw new BadImageFormatException(Environment.GetResourceString("The type serialized in the .resources file was not the same type that the .resources file said it contained. Expected '{0}' but read '{1}'.", runtimeType.FullName, obj.GetType().FullName));
		}
		return obj;
	}

	private void ReadResources()
	{
		BinaryFormatter objFormatter = new BinaryFormatter(null, new StreamingContext(StreamingContextStates.File | StreamingContextStates.Persistence));
		_objFormatter = objFormatter;
		try
		{
			_ReadResources();
		}
		catch (EndOfStreamException inner)
		{
			throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file. Unable to read resources from this file because of invalid header information. Try regenerating the .resources file."), inner);
		}
		catch (IndexOutOfRangeException inner2)
		{
			throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file. Unable to read resources from this file because of invalid header information. Try regenerating the .resources file."), inner2);
		}
	}

	private unsafe void _ReadResources()
	{
		if (_store.ReadInt32() != ResourceManager.MagicNumber)
		{
			throw new ArgumentException(Environment.GetResourceString("Stream is not a valid resource file."));
		}
		int num = _store.ReadInt32();
		int num2 = _store.ReadInt32();
		if (num2 < 0 || num < 0)
		{
			throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file. Unable to read resources from this file because of invalid header information. Try regenerating the .resources file."));
		}
		if (num > 1)
		{
			_store.BaseStream.Seek(num2, SeekOrigin.Current);
		}
		else
		{
			string text = _store.ReadString();
			AssemblyName asmName = new AssemblyName(ResourceManager.MscorlibName);
			if (!ResourceManager.CompareNames(text, ResourceManager.ResReaderTypeName, asmName))
			{
				throw new NotSupportedException(Environment.GetResourceString("This .resources file should not be read with this reader. The resource reader type is \"{0}\".", text));
			}
			SkipString();
		}
		int num3 = _store.ReadInt32();
		if (num3 != 2 && num3 != 1)
		{
			throw new ArgumentException(Environment.GetResourceString("The ResourceReader class does not know how to read this version of .resources files. Expected version: {0}  This file: {1}", 2, num3));
		}
		_version = num3;
		_numResources = _store.ReadInt32();
		if (_numResources < 0)
		{
			throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file. Unable to read resources from this file because of invalid header information. Try regenerating the .resources file."));
		}
		int num4 = _store.ReadInt32();
		if (num4 < 0)
		{
			throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file. Unable to read resources from this file because of invalid header information. Try regenerating the .resources file."));
		}
		_typeTable = new RuntimeType[num4];
		_typeNamePositions = new int[num4];
		for (int i = 0; i < num4; i++)
		{
			_typeNamePositions[i] = (int)_store.BaseStream.Position;
			SkipString();
		}
		int num5 = (int)_store.BaseStream.Position & 7;
		if (num5 != 0)
		{
			for (int j = 0; j < 8 - num5; j++)
			{
				_store.ReadByte();
			}
		}
		if (_ums == null)
		{
			_nameHashes = new int[_numResources];
			for (int k = 0; k < _numResources; k++)
			{
				_nameHashes[k] = _store.ReadInt32();
			}
		}
		else
		{
			if ((_numResources & 0xE0000000u) != 0L)
			{
				throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file. Unable to read resources from this file because of invalid header information. Try regenerating the .resources file."));
			}
			int num6 = 4 * _numResources;
			_nameHashesPtr = (int*)_ums.PositionPointer;
			_ums.Seek(num6, SeekOrigin.Current);
			_ = _ums.PositionPointer;
		}
		if (_ums == null)
		{
			_namePositions = new int[_numResources];
			for (int l = 0; l < _numResources; l++)
			{
				int num7 = _store.ReadInt32();
				if (num7 < 0)
				{
					throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file. Unable to read resources from this file because of invalid header information. Try regenerating the .resources file."));
				}
				_namePositions[l] = num7;
			}
		}
		else
		{
			if ((_numResources & 0xE0000000u) != 0L)
			{
				throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file. Unable to read resources from this file because of invalid header information. Try regenerating the .resources file."));
			}
			int num8 = 4 * _numResources;
			_namePositionsPtr = (int*)_ums.PositionPointer;
			_ums.Seek(num8, SeekOrigin.Current);
			_ = _ums.PositionPointer;
		}
		_dataSectionOffset = _store.ReadInt32();
		if (_dataSectionOffset < 0)
		{
			throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file. Unable to read resources from this file because of invalid header information. Try regenerating the .resources file."));
		}
		_nameSectionOffset = _store.BaseStream.Position;
		if (_dataSectionOffset < _nameSectionOffset)
		{
			throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file. Unable to read resources from this file because of invalid header information. Try regenerating the .resources file."));
		}
	}

	private RuntimeType FindType(int typeIndex)
	{
		if (typeIndex < 0 || typeIndex >= _typeTable.Length)
		{
			throw new BadImageFormatException(Environment.GetResourceString("Corrupt .resources file.  The specified type doesn't exist."));
		}
		if (_typeTable[typeIndex] == null)
		{
			long position = _store.BaseStream.Position;
			try
			{
				_store.BaseStream.Position = _typeNamePositions[typeIndex];
				string typeName = _store.ReadString();
				_typeTable[typeIndex] = (RuntimeType)Type.GetType(typeName, throwOnError: true);
			}
			finally
			{
				_store.BaseStream.Position = position;
			}
		}
		return _typeTable[typeIndex];
	}
}
