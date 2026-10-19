using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using Unity.Collections.LowLevel.Unsafe;

namespace UnityEngine.ResourceManagement.Util;

internal class BinaryStorageBuffer
{
	private class BuiltinTypesSerializer : ISerializationAdapter<int>, ISerializationAdapter, ISerializationAdapter<bool>, ISerializationAdapter<long>, ISerializationAdapter<string>, ISerializationAdapter<Hash128>
	{
		private struct ObjectToStringRemap
		{
			public uint stringId;

			public char separator;
		}

		public IEnumerable<ISerializationAdapter> Dependencies => null;

		public object Deserialize(Reader reader, Type t, uint offset)
		{
			if (offset == uint.MaxValue)
			{
				return null;
			}
			if (t == typeof(int))
			{
				return reader.ReadValue<int>(offset);
			}
			if (t == typeof(bool))
			{
				return reader.ReadValue<bool>(offset);
			}
			if (t == typeof(long))
			{
				return reader.ReadValue<long>(offset);
			}
			if (t == typeof(Hash128))
			{
				return reader.ReadValue<Hash128>(offset);
			}
			if (t == typeof(string))
			{
				ObjectToStringRemap objectToStringRemap = reader.ReadValue<ObjectToStringRemap>(offset);
				return reader.ReadString(objectToStringRemap.stringId, objectToStringRemap.separator, cacheValue: false);
			}
			return null;
		}

		private char FindBestSeparator(string str, params char[] seps)
		{
			int num = 0;
			char c = '\0';
			foreach (char s in seps)
			{
				int num2 = str.Count((char c2) => c2 == s);
				if (num2 > num)
				{
					num = num2;
					c = s;
				}
			}
			string[] array = str.Split(c);
			int num3 = 0;
			string[] array2 = array;
			for (int i = 0; i < array2.Length; i++)
			{
				if (array2[i].Length > 8)
				{
					num3++;
				}
			}
			if (num3 < 2)
			{
				c = '\0';
			}
			return c;
		}

		public uint Serialize(Writer writer, object val)
		{
			if (val == null)
			{
				return uint.MaxValue;
			}
			Type type = val.GetType();
			if (type == typeof(int))
			{
				return writer.Write((int)val);
			}
			if (type == typeof(bool))
			{
				return writer.Write((bool)val);
			}
			if (type == typeof(long))
			{
				return writer.Write((long)val);
			}
			if (type == typeof(Hash128))
			{
				return writer.Write((Hash128)val);
			}
			if (type == typeof(string))
			{
				string str = val as string;
				char separator = FindBestSeparator(str, '/', '.', '-', '_', '\\', ',');
				return writer.Write(new ObjectToStringRemap
				{
					stringId = writer.WriteString((string)val),
					separator = separator
				});
			}
			return uint.MaxValue;
		}
	}

	private class TypeSerializer : ISerializationAdapter<Type>, ISerializationAdapter
	{
		private struct Data
		{
			public uint assemblyId;

			public uint classId;
		}

		public IEnumerable<ISerializationAdapter> Dependencies => null;

		public object Deserialize(Reader reader, Type type, uint offset)
		{
			try
			{
				Data data = reader.ReadValue<Data>(offset);
				string assemblyString = reader.ReadString(data.assemblyId, '.');
				string name = reader.ReadString(data.classId, '.');
				Assembly assembly = Assembly.Load(assemblyString);
				return (assembly == null) ? null : assembly.GetType(name);
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
				return null;
			}
		}

		public uint Serialize(Writer writer, object val)
		{
			if (val == null)
			{
				return uint.MaxValue;
			}
			Type type = val as Type;
			return writer.Write(new Data
			{
				assemblyId = writer.WriteString(type.Assembly.FullName, '.'),
				classId = writer.WriteString(type.FullName, '.')
			});
		}
	}

	private struct DynamicString
	{
		public uint stringId;

		public uint nextId;
	}

	private struct ObjectTypeData
	{
		public uint typeId;

		public uint objectId;
	}

	public interface ISerializationAdapter
	{
		IEnumerable<ISerializationAdapter> Dependencies { get; }

		uint Serialize(Writer writer, object val);

		object Deserialize(Reader reader, Type t, uint offset);
	}

	public interface ISerializationAdapter<T> : ISerializationAdapter
	{
	}

	public class Reader
	{
		private byte[] m_Buffer;

		private Dictionary<Type, ISerializationAdapter> m_Adapters;

		private LRUCache<uint, object> m_Cache;

		private StringBuilder stringBuilder;

		private void Init(byte[] data, int maxCachedObjects, params ISerializationAdapter[] adapters)
		{
			m_Buffer = data;
			stringBuilder = new StringBuilder(1024);
			m_Cache = new LRUCache<uint, object>(maxCachedObjects);
			m_Adapters = new Dictionary<Type, ISerializationAdapter>();
			foreach (ISerializationAdapter adapter in adapters)
			{
				BinaryStorageBuffer.AddSerializationAdapter(m_Adapters, adapter, false);
			}
			BinaryStorageBuffer.AddSerializationAdapter(m_Adapters, (ISerializationAdapter)new TypeSerializer(), false);
			BinaryStorageBuffer.AddSerializationAdapter(m_Adapters, (ISerializationAdapter)new BuiltinTypesSerializer(), false);
		}

		public void AddSerializationAdapter(ISerializationAdapter a)
		{
			BinaryStorageBuffer.AddSerializationAdapter(m_Adapters, a, false);
		}

		public Reader(byte[] data, int maxCachedObjects = 1024, params ISerializationAdapter[] adapters)
		{
			Init(data, maxCachedObjects, adapters);
		}

		internal byte[] GetBuffer()
		{
			return m_Buffer;
		}

		public Reader(Stream inputStream, uint bufferSize, int maxCachedObjects, params ISerializationAdapter[] adapters)
		{
			byte[] array = new byte[(bufferSize == 0) ? inputStream.Length : bufferSize];
			inputStream.Read(array, 0, array.Length);
			Init(array, maxCachedObjects, adapters);
		}

		private bool TryGetCachedValue<T>(uint offset, out T val)
		{
			if (m_Cache.TryGet(offset, out var val2))
			{
				val = (T)val2;
				return true;
			}
			val = default;
			return false;
		}

		public object[] ReadObjectArray(uint id, bool cacheValues = true)
		{
			if (id == uint.MaxValue)
			{
				return null;
			}
			uint[] array = ReadValueArray<uint>(id, cacheValues);
			object[] array2 = new object[array.Length];
			for (int i = 0; i < array.Length; i++)
			{
				array2[i] = ReadObject(array[i], cacheValues);
			}
			return array2;
		}

		public object[] ReadObjectArray(Type t, uint id, bool cacheValues = true)
		{
			if (id == uint.MaxValue)
			{
				return null;
			}
			uint[] array = ReadValueArray<uint>(id, cacheValues);
			object[] array2 = new object[array.Length];
			for (int i = 0; i < array.Length; i++)
			{
				array2[i] = ReadObject(t, array[i], cacheValues);
			}
			return array2;
		}

		public T[] ReadObjectArray<T>(uint id, bool cacheValues = true)
		{
			if (id == uint.MaxValue)
			{
				return null;
			}
			uint[] array = ReadValueArray<uint>(id, cacheValues);
			T[] array2 = new T[array.Length];
			for (int i = 0; i < array.Length; i++)
			{
				array2[i] = ReadObject<T>(array[i], cacheValues);
			}
			return array2;
		}

		public object ReadObject(uint id, bool cacheValue = true)
		{
			if (id == uint.MaxValue)
			{
				return null;
			}
			ObjectTypeData objectTypeData = ReadValue<ObjectTypeData>(id);
			Type t = ReadObject<Type>(objectTypeData.typeId);
			return ReadObject(t, objectTypeData.objectId, cacheValue);
		}

		public T ReadObject<T>(uint offset, bool cacheValue = true)
		{
			return (T)ReadObject(typeof(T), offset, cacheValue);
		}

		public object ReadObject(Type t, uint id, bool cacheValue = true)
		{
			if (id == uint.MaxValue)
			{
				return null;
			}
			if (TryGetCachedValue<object>(id, out var val))
			{
				return val;
			}
			if (!GetSerializationAdapter(m_Adapters, t, out var adapter))
			{
				return null;
			}
			object obj = null;
			try
			{
				obj = adapter.Deserialize(this, t, id);
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
				return null;
			}
			if (cacheValue && obj != null)
			{
				m_Cache.TryAdd(id, obj);
			}
			return obj;
		}

		public unsafe T[] ReadValueArray<T>(uint id, bool cacheValue = true) where T : unmanaged
		{
			if (id == uint.MaxValue)
			{
				return null;
			}
			if (id - 4 >= m_Buffer.Length)
			{
				throw new Exception($"Data offset {id} is out of bounds of buffer with length of {m_Buffer.Length}.");
			}
			fixed (byte* ptr = &m_Buffer[id - 4])
			{
				if (TryGetCachedValue<T[]>(id, out var val))
				{
					return val;
				}
				uint num = 0u;
				UnsafeUtility.MemCpy(&num, ptr, 4L);
				if (id + num > m_Buffer.Length)
				{
					throw new Exception($"Data size {num} is out of bounds of buffer with length of {m_Buffer.Length}.");
				}
				T[] array = new T[num / sizeof(T)];
				fixed (T* destination = array)
				{
					UnsafeUtility.MemCpy(destination, ptr + 4, num);
				}
				if (cacheValue)
				{
					m_Cache.TryAdd(id, array);
				}
				return array;
			}
		}

		public unsafe T ReadValue<T>(uint id) where T : unmanaged
		{
			if (id == uint.MaxValue)
			{
				return default;
			}
			if (id >= m_Buffer.Length)
			{
				throw new Exception($"Data offset {id} is out of bounds of buffer with length of {m_Buffer.Length}.");
			}
			fixed (byte* buffer = m_Buffer)
			{
				T result = default;
				UnsafeUtility.MemCpy(&result, buffer + id, sizeof(T));
				return result;
			}
		}

		public string ReadString(uint id, char sep = '\0', bool cacheValue = true)
		{
			if (id == uint.MaxValue)
			{
				return null;
			}
			if (sep == '\0')
			{
				return ReadAutoEncodedString(id, cacheValue);
			}
			return ReadDynamicString(id, sep, cacheValue);
		}

		private unsafe string ReadStringInternal(uint offset, Encoding enc, bool cacheValue = true)
		{
			if (offset - 4 >= m_Buffer.Length)
			{
				throw new Exception($"Data offset {offset} is out of bounds of buffer with length of {m_Buffer.Length}.");
			}
			if (TryGetCachedValue<string>(offset, out var val))
			{
				return val;
			}
			fixed (byte* buffer = m_Buffer)
			{
				uint num = *(uint*)(buffer + (offset - 4));
				if (offset + num > m_Buffer.Length)
				{
					throw new Exception($"Data offset {offset}, len {num} is out of bounds of buffer with length of {m_Buffer.Length}.");
				}
				string text = enc.GetString(buffer + offset, (int)num);
				if (cacheValue)
				{
					m_Cache.TryAdd(offset, text);
				}
				return text;
			}
		}

		private string ReadAutoEncodedString(uint id, bool cacheValue)
		{
			if ((id & 0x80000000u) == 2147483648u)
			{
				return ReadStringInternal(id & 0x3FFFFFFF, Encoding.Unicode, cacheValue);
			}
			return ReadStringInternal(id, Encoding.ASCII, cacheValue);
		}

		private string ReadDynamicString(uint id, char sep, bool cacheValue)
		{
			if ((id & 0x40000000) == 1073741824)
			{
				if (!TryGetCachedValue<string>(id, out var val))
				{
					DynamicString dynamicString = ReadValue<DynamicString>(id & 0x3FFFFFFF);
					stringBuilder.Append(ReadAutoEncodedString(dynamicString.stringId, cacheValue));
					while (dynamicString.nextId != uint.MaxValue)
					{
						dynamicString = ReadValue<DynamicString>(dynamicString.nextId);
						stringBuilder.Append(sep);
						stringBuilder.Append(ReadAutoEncodedString(dynamicString.stringId, cacheValue));
					}
					val = stringBuilder.ToString();
					stringBuilder.Clear();
					if (cacheValue)
					{
						m_Cache.TryAdd(id, val);
					}
				}
				return val;
			}
			return ReadAutoEncodedString(id, cacheValue);
		}
	}

	public class Writer
	{
		private class Chunk
		{
			public uint position;

			public byte[] data;
		}

		private struct StringParts
		{
			public string str;

			public uint dataSize;

			public bool isUnicode;
		}

		private uint totalBytes;

		private uint defaulChunkSize;

		private List<Chunk> chunks;

		private Dictionary<Hash128, uint> existingValues;

		private Dictionary<Type, ISerializationAdapter> serializationAdapters;

		public uint Length => totalBytes;

		public Writer(int chunkSize = 1048576, params ISerializationAdapter[] adapters)
		{
			defaulChunkSize = ((chunkSize > 0) ? ((uint)chunkSize) : 1048576u);
			existingValues = new Dictionary<Hash128, uint>();
			chunks = new List<Chunk>(10);
			chunks.Add(new Chunk
			{
				position = 0u
			});
			serializationAdapters = new Dictionary<Type, ISerializationAdapter>();
			AddSerializationAdapter(serializationAdapters, new TypeSerializer());
			AddSerializationAdapter(serializationAdapters, new BuiltinTypesSerializer());
			foreach (ISerializationAdapter adapter in adapters)
			{
				AddSerializationAdapter(serializationAdapters, adapter, forceOverride: true);
			}
		}

		private Chunk FindChunkWithSpace(uint length)
		{
			Chunk chunk = chunks[chunks.Count - 1];
			if (chunk.data == null)
			{
				chunk.data = new byte[(length > defaulChunkSize) ? length : defaulChunkSize];
			}
			if (length > chunk.data.Length - chunk.position)
			{
				chunk = new Chunk
				{
					position = 0u,
					data = new byte[(length > defaulChunkSize) ? length : defaulChunkSize]
				};
				chunks.Add(chunk);
			}
			return chunk;
		}

		private unsafe uint WriteInternal(void* pData, uint dataSize, bool prefixSize)
		{
			Hash128 key = default;
			ComputeHash(pData, dataSize, &key);
			if (existingValues.TryGetValue(key, out var value))
			{
				return value;
			}
			uint num = (prefixSize ? (dataSize + 4) : dataSize);
			Chunk chunk = FindChunkWithSpace(num);
			fixed (byte* ptr = &chunk.data[chunk.position])
			{
				uint num2 = totalBytes;
				if (prefixSize)
				{
					UnsafeUtility.MemCpy(ptr, &dataSize, 4L);
					if (dataSize != 0)
					{
						UnsafeUtility.MemCpy(ptr + 4, pData, dataSize);
					}
					num2 += 4;
				}
				else
				{
					if (dataSize == 0)
					{
						return uint.MaxValue;
					}
					UnsafeUtility.MemCpy(ptr, pData, dataSize);
				}
				totalBytes += num;
				chunk.position += num;
				existingValues[key] = num2;
				return num2;
			}
		}

		private uint ReserveInternal(uint dataSize, bool prefixSize)
		{
			uint num = (prefixSize ? (dataSize + 4) : dataSize);
			Chunk chunk = FindChunkWithSpace(num);
			totalBytes += num;
			chunk.position += num;
			return totalBytes - dataSize;
		}

		private unsafe void WriteInternal(uint id, void* pData, uint dataSize, bool prefixSize)
		{
			Hash128 key = default;
			ComputeHash(pData, dataSize, &key);
			existingValues[key] = id;
			uint num = id;
			foreach (Chunk chunk in chunks)
			{
				if (num < chunk.position)
				{
					fixed (byte* data = chunk.data)
					{
						if (prefixSize)
						{
							UnsafeUtility.MemCpy(data + (num - 4), &dataSize, 4L);
						}
						UnsafeUtility.MemCpy(data + num, pData, dataSize);
						break;
					}
				}
				num -= chunk.position;
			}
		}

		public unsafe uint Reserve<T>() where T : unmanaged
		{
			return ReserveInternal((uint)sizeof(T), prefixSize: false);
		}

		public unsafe uint Write<T>(in T val) where T : unmanaged
		{
			fixed (T* pData = &val)
			{
				return WriteInternal(pData, (uint)sizeof(T), prefixSize: false);
			}
		}

		public unsafe uint Write<T>(T val) where T : unmanaged
		{
			return WriteInternal(&val, (uint)sizeof(T), prefixSize: false);
		}

		public unsafe uint Write<T>(uint offset, in T val) where T : unmanaged
		{
			fixed (T* pData = &val)
			{
				WriteInternal(offset, pData, (uint)sizeof(T), prefixSize: false);
			}
			return offset;
		}

		public unsafe uint Write<T>(uint offset, T val) where T : unmanaged
		{
			WriteInternal(offset, &val, (uint)sizeof(T), prefixSize: false);
			return offset;
		}

		public unsafe uint Reserve<T>(uint count) where T : unmanaged
		{
			return ReserveInternal((uint)sizeof(T) * count, prefixSize: true);
		}

		public unsafe uint Write<T>(T[] values, bool hashElements = true) where T : unmanaged
		{
			fixed (T* ptr = values)
			{
				uint num = (uint)(values.Length * sizeof(T));
				Hash128 key = default;
				ComputeHash(ptr, num, &key);
				if (existingValues.TryGetValue(key, out var value))
				{
					return value;
				}
				Chunk chunk = FindChunkWithSpace(num + 4);
				fixed (byte* ptr2 = &chunk.data[chunk.position])
				{
					uint num2 = totalBytes + 4;
					UnsafeUtility.MemCpy(ptr2, &num, 4L);
					UnsafeUtility.MemCpy(ptr2 + 4, ptr, num);
					uint num3 = num + 4;
					totalBytes += num3;
					chunk.position += num3;
					existingValues[key] = num2;
					if (hashElements && sizeof(T) > 4)
					{
						for (int i = 0; i < values.Length; i++)
						{
							key = default;
							ComputeHash(ptr + i, (ulong)sizeof(T), &key);
							existingValues[key] = num2 + (uint)(i * sizeof(T));
						}
					}
					return num2;
				}
			}
		}

		public unsafe uint Write<T>(uint offset, T[] values, bool hashElements = true) where T : unmanaged
		{
			uint num = (uint)(values.Length * sizeof(T));
			uint num2 = offset;
			fixed (T* source = values)
			{
				Hash128 key = default;
				foreach (Chunk chunk in chunks)
				{
					if (num2 < chunk.position)
					{
						fixed (byte* data = chunk.data)
						{
							UnsafeUtility.MemCpy(data + (num2 - 4), &num, 4L);
							UnsafeUtility.MemCpy(data + num2, source, num);
							if (hashElements && sizeof(T) > 4)
							{
								for (int i = 0; i < values.Length; i++)
								{
									T val = values[i];
									ComputeHash(&val, (ulong)sizeof(T), &key);
									existingValues[key] = offset + (uint)(i * sizeof(T));
								}
							}
							return offset;
						}
					}
					num2 -= chunk.position;
				}
			}
			return uint.MaxValue;
		}

		public uint WriteObjects<T>(IEnumerable<T> objs, bool serizalizeTypeData)
		{
			if (objs == null)
			{
				return uint.MaxValue;
			}
			uint[] array = new uint[objs.Count()];
			int num = 0;
			foreach (T obj in objs)
			{
				array[num++] = WriteObject(obj, serizalizeTypeData);
			}
			return Write(array, true);
		}

		public uint WriteObject(object obj, bool serializeTypeData)
		{
			if (obj == null)
			{
				return uint.MaxValue;
			}
			Type type = obj.GetType();
			if (!GetSerializationAdapter(serializationAdapters, type, out var adapter))
			{
				return uint.MaxValue;
			}
			uint num = adapter.Serialize(this, obj);
			if (serializeTypeData)
			{
				num = Write(new ObjectTypeData
				{
					typeId = WriteObject(type, serializeTypeData: false),
					objectId = num
				});
			}
			return num;
		}

		public uint WriteString(string str, char sep = '\0')
		{
			if (str == null)
			{
				return uint.MaxValue;
			}
			if (sep != '\0')
			{
				return WriteDynamicString(str, sep);
			}
			return WriteAutoEncodedString(str);
		}

		private unsafe uint WriteStringInternal(string val, Encoding enc)
		{
			if (val == null)
			{
				return uint.MaxValue;
			}
			byte[] bytes = enc.GetBytes(val);
			fixed (byte* pData = bytes)
			{
				return WriteInternal(pData, (uint)bytes.Length, prefixSize: true);
			}
		}

		public unsafe byte[] SerializeToByteArray()
		{
			byte[] array = new byte[totalBytes];
			fixed (byte* ptr = array)
			{
				uint num = 0u;
				foreach (Chunk chunk in chunks)
				{
					fixed (byte* data = chunk.data)
					{
						UnsafeUtility.MemCpy(ptr + num, data, chunk.position);
					}
					num += chunk.position;
				}
			}
			return array;
		}

		public uint SerializeToStream(Stream str)
		{
			foreach (Chunk chunk in chunks)
			{
				str.Write(chunk.data, 0, (int)chunk.position);
			}
			return totalBytes;
		}

		private static bool IsUnicode(string str)
		{
			for (int i = 0; i < str.Length; i++)
			{
				if (str[i] > 'ÿ')
				{
					return true;
				}
			}
			return false;
		}

		private uint WriteAutoEncodedString(string str)
		{
			if (str == null)
			{
				return uint.MaxValue;
			}
			if (IsUnicode(str))
			{
				return WriteUnicodeString(str);
			}
			return WriteStringInternal(str, Encoding.ASCII);
		}

		private uint WriteUnicodeString(string str)
		{
			uint num = WriteStringInternal(str, Encoding.Unicode);
			return 0x80000000u | num;
		}

		private static uint ComputeStringSize(string str, out bool isUnicode)
		{
			if (isUnicode = IsUnicode(str))
			{
				return (uint)Encoding.Unicode.GetByteCount(str);
			}
			return (uint)Encoding.ASCII.GetByteCount(str);
		}

		private uint RecurseDynamicStringParts(StringParts[] parts, int index, char sep, uint minSize)
		{
			while (index < parts.Length - 1)
			{
				uint dataSize = parts[index].dataSize;
				uint dataSize2 = parts[index + 1].dataSize;
				if (dataSize >= minSize && dataSize2 >= minSize)
				{
					break;
				}
				parts[index + 1].str = $"{parts[index].str}{sep}{parts[index + 1].str}";
				index++;
			}
			uint stringId = (parts[index].isUnicode ? WriteUnicodeString(parts[index].str) : WriteStringInternal(parts[index].str, Encoding.ASCII));
			uint nextId = ((index < parts.Length - 1) ? RecurseDynamicStringParts(parts, index + 1, sep, minSize) : uint.MaxValue);
			return Write(new DynamicString
			{
				stringId = stringId,
				nextId = nextId
			});
		}

		private unsafe uint WriteDynamicString(string str, char sep)
		{
			if (str == null)
			{
				return uint.MaxValue;
			}
			uint num = (uint)sizeof(DynamicString);
			string[] array = str.Split(sep);
			StringParts[] array2 = new StringParts[array.Length];
			for (int i = 0; i < array2.Length; i++)
			{
				uint dataSize = ComputeStringSize(array[i], out var isUnicode);
				array2[i] = new StringParts
				{
					str = array[i],
					dataSize = dataSize,
					isUnicode = isUnicode
				};
			}
			if (array2.Length < 2 || (array2.Length == 2 && array2[0].dataSize + array2[1].dataSize < num))
			{
				return WriteAutoEncodedString(str);
			}
			return 0x40000000 | RecurseDynamicStringParts(array2, 0, sep, num);
		}
	}

	private const uint kUnicodeStringFlag = 2147483648u;

	private const uint kDynamicStringFlag = 1073741824u;

	private const uint kClearFlagsMask = 1073741823u;

	private unsafe static void ComputeHash(void* pData, ulong size, Hash128* hash)
	{
		if (pData == null || size == 0L)
		{
			*hash = default;
		}
		else
		{
			HashUnsafeUtilities.ComputeHash128(pData, size, hash);
		}
	}

	private static void AddSerializationAdapter(Dictionary<Type, ISerializationAdapter> serializationAdapters, ISerializationAdapter adapter, bool forceOverride = false)
	{
		bool flag = false;
		Type[] interfaces = adapter.GetType().GetInterfaces();
		foreach (Type type in interfaces)
		{
			if (!type.IsGenericType || !typeof(ISerializationAdapter).IsAssignableFrom(type))
			{
				continue;
			}
			Type type2 = type.GenericTypeArguments[0];
			if (serializationAdapters.ContainsKey(type2))
			{
				if (forceOverride)
				{
					ISerializationAdapter arg = serializationAdapters[type2];
					serializationAdapters.Remove(type2);
					serializationAdapters[type2] = adapter;
					flag = true;
					Debug.Log($"Replacing adapter for type {type2}: {arg} -> {adapter}");
				}
				else
				{
					Debug.Log($"Failed to register adapter for type {type2}: {adapter}, {serializationAdapters[type2]} is already registered.");
				}
			}
			else
			{
				serializationAdapters[type2] = adapter;
				flag = true;
			}
		}
		if (!flag)
		{
			return;
		}
		IEnumerable<ISerializationAdapter> dependencies = adapter.Dependencies;
		if (dependencies == null)
		{
			return;
		}
		foreach (ISerializationAdapter item in dependencies)
		{
			AddSerializationAdapter(serializationAdapters, item);
		}
	}

	private static bool GetSerializationAdapter(Dictionary<Type, ISerializationAdapter> serializationAdapters, Type t, out ISerializationAdapter adapter)
	{
		if (!serializationAdapters.TryGetValue(t, out adapter))
		{
			foreach (KeyValuePair<Type, ISerializationAdapter> serializationAdapter in serializationAdapters)
			{
				if (serializationAdapter.Key.IsAssignableFrom(t))
				{
					return (adapter = serializationAdapter.Value) != null;
				}
			}
			Debug.LogError($"Unable to find serialization adapter for type {t}.");
		}
		return adapter != null;
	}
}
