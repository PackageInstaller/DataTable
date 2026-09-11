using System.IO;
using System.Runtime.CompilerServices;
using System.Text;

namespace System.Net.Mime;

internal class QEncodedStream : DelegatedStream, IEncodableStream
{
	private sealed class ReadStateInfo
	{
		internal bool IsEscaped { get; set; }

		internal short Byte { get; set; } = -1;
	}

	private class WriteAsyncResult : LazyAsyncResult
	{
		private static readonly AsyncCallback s_onWrite = OnWrite;

		private readonly QEncodedStream _parent;

		private readonly byte[] _buffer;

		private readonly int _offset;

		private readonly int _count;

		private int _written;

		internal WriteAsyncResult(QEncodedStream parent, byte[] buffer, int offset, int count, AsyncCallback callback, object state)
			: base(null, state, callback)
		{
			_parent = parent;
			_buffer = buffer;
			_offset = offset;
			_count = count;
		}

		private void CompleteWrite(IAsyncResult result)
		{
			_parent.BaseStream.EndWrite(result);
			_parent.WriteState.Reset();
		}

		internal static void End(IAsyncResult result)
		{
			((WriteAsyncResult)result).InternalWaitForCompletion();
		}

		private static void OnWrite(IAsyncResult result)
		{
			if (!result.CompletedSynchronously)
			{
				WriteAsyncResult writeAsyncResult = (WriteAsyncResult)result.AsyncState;
				try
				{
					writeAsyncResult.CompleteWrite(result);
					writeAsyncResult.Write();
				}
				catch (Exception result2)
				{
					writeAsyncResult.InvokeCallback(result2);
				}
			}
		}

		internal void Write()
		{
			while (true)
			{
				_written += _parent.EncodeBytes(_buffer, _offset + _written, _count - _written);
				if (_written < _count)
				{
					IAsyncResult asyncResult = _parent.BaseStream.BeginWrite(_parent.WriteState.Buffer, 0, _parent.WriteState.Length, s_onWrite, this);
					if (asyncResult.CompletedSynchronously)
					{
						CompleteWrite(asyncResult);
						continue;
					}
					break;
				}
				InvokeCallback();
				break;
			}
		}
	}

	private static readonly byte[] s_hexDecodeMap;

	private static readonly byte[] s_hexEncodeMap;

	private ReadStateInfo _readState;

	private WriteStateInfoBase _writeState;

	private ReadStateInfo ReadState => _readState ?? (_readState = new ReadStateInfo());

	internal WriteStateInfoBase WriteState => _writeState;

	internal QEncodedStream(WriteStateInfoBase wsi)
		: base(new MemoryStream())
	{
		_writeState = wsi;
	}

	public override IAsyncResult BeginWrite(byte[] buffer, int offset, int count, AsyncCallback callback, object state)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		if (offset < 0 || offset > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("offset");
		}
		if (offset + count > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("count");
		}
		WriteAsyncResult writeAsyncResult = new WriteAsyncResult(this, buffer, offset, count, callback, state);
		writeAsyncResult.Write();
		return writeAsyncResult;
	}

	public override void Close()
	{
		FlushInternal();
		base.Close();
	}

	public unsafe int DecodeBytes(byte[] buffer, int offset, int count)
	{
		fixed (byte* ptr = buffer)
		{
			byte* ptr2 = ptr + offset;
			byte* ptr3 = ptr2;
			byte* ptr4 = ptr2;
			byte* ptr5 = ptr2 + count;
			if (ReadState.IsEscaped)
			{
				if (ReadState.Byte == -1)
				{
					if (count == 1)
					{
						ReadState.Byte = *ptr3;
						return 0;
					}
					if (*ptr3 != 13 || ptr3[1] != 10)
					{
						byte b = s_hexDecodeMap[*ptr3];
						byte b2 = s_hexDecodeMap[ptr3[1]];
						if (b == byte.MaxValue)
						{
							throw new FormatException(global::SR.Format("Invalid hex digit '{0}'.", b));
						}
						if (b2 == byte.MaxValue)
						{
							throw new FormatException(global::SR.Format("Invalid hex digit '{0}'.", b2));
						}
						*(ptr4++) = (byte)((b << 4) + b2);
					}
					ptr3 += 2;
				}
				else
				{
					if (ReadState.Byte != 13 || *ptr3 != 10)
					{
						byte b3 = s_hexDecodeMap[ReadState.Byte];
						byte b4 = s_hexDecodeMap[*ptr3];
						if (b3 == byte.MaxValue)
						{
							throw new FormatException(global::SR.Format("Invalid hex digit '{0}'.", b3));
						}
						if (b4 == byte.MaxValue)
						{
							throw new FormatException(global::SR.Format("Invalid hex digit '{0}'.", b4));
						}
						*(ptr4++) = (byte)((b3 << 4) + b4);
					}
					ptr3++;
				}
				ReadState.IsEscaped = false;
				ReadState.Byte = -1;
			}
			while (ptr3 < ptr5)
			{
				if (*ptr3 != 61)
				{
					if (*ptr3 == 95)
					{
						*(ptr4++) = 32;
						ptr3++;
					}
					else
					{
						*(ptr4++) = *(ptr3++);
					}
					continue;
				}
				long num = ptr5 - ptr3;
				if (num != 1)
				{
					if (num != 2)
					{
						if (ptr3[1] != 13 || ptr3[2] != 10)
						{
							byte b5 = s_hexDecodeMap[ptr3[1]];
							byte b6 = s_hexDecodeMap[ptr3[2]];
							if (b5 == byte.MaxValue)
							{
								throw new FormatException(global::SR.Format("Invalid hex digit '{0}'.", b5));
							}
							if (b6 == byte.MaxValue)
							{
								throw new FormatException(global::SR.Format("Invalid hex digit '{0}'.", b6));
							}
							*(ptr4++) = (byte)((b5 << 4) + b6);
						}
						ptr3 += 3;
						continue;
					}
					ReadState.Byte = ptr3[1];
				}
				ReadState.IsEscaped = true;
				break;
			}
			return (int)(ptr4 - ptr2);
		}
	}

	public int EncodeBytes(byte[] buffer, int offset, int count)
	{
		//IL_00b2: Field data (rva=0x8a8) could not be found in any section!
		//IL_00b2: Field data (rva=0x8a8) could not be found in any section!
		_writeState.AppendHeader();
		int i;
		for (i = offset; i < count + offset; i++)
		{
			if ((WriteState.CurrentLineLength + 3 + WriteState.FooterLength >= WriteState.MaxLineLength && (buffer[i] == 32 || buffer[i] == 9 || buffer[i] == 13 || buffer[i] == 10)) || WriteState.CurrentLineLength + _writeState.FooterLength >= WriteState.MaxLineLength)
			{
				WriteState.AppendCRLF(includeSpace: true);
			}
			if (buffer[i] == 13 && i + 1 < count + offset && buffer[i + 1] == 10)
			{
				i++;
				WriteStateInfoBase writeState = WriteState;
				byte[] array = new byte[6];
				RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
				writeState.Append(array);
			}
			else if (buffer[i] == 32)
			{
				WriteState.Append(95);
			}
			else if (IsAsciiLetterOrDigit((char)buffer[i]))
			{
				WriteState.Append(buffer[i]);
			}
			else
			{
				WriteState.Append(61);
				WriteState.Append(s_hexEncodeMap[buffer[i] >> 4]);
				WriteState.Append(s_hexEncodeMap[buffer[i] & 0xF]);
			}
		}
		WriteState.AppendFooter();
		return i - offset;
	}

	private static bool IsAsciiLetterOrDigit(char character)
	{
		if (!IsAsciiLetter(character))
		{
			if (character >= '0')
			{
				return character <= '9';
			}
			return false;
		}
		return true;
	}

	private static bool IsAsciiLetter(char character)
	{
		if (character < 'a' || character > 'z')
		{
			if (character >= 'A')
			{
				return character <= 'Z';
			}
			return false;
		}
		return true;
	}

	public string GetEncodedString()
	{
		return Encoding.ASCII.GetString(WriteState.Buffer, 0, WriteState.Length);
	}

	public override void EndWrite(IAsyncResult asyncResult)
	{
		WriteAsyncResult.End(asyncResult);
	}

	public override void Flush()
	{
		FlushInternal();
		base.Flush();
	}

	private void FlushInternal()
	{
		if (_writeState != null && _writeState.Length > 0)
		{
			base.Write(WriteState.Buffer, 0, WriteState.Length);
			WriteState.Reset();
		}
	}

	public override void Write(byte[] buffer, int offset, int count)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		if (offset < 0 || offset > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("offset");
		}
		if (offset + count > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("count");
		}
		int num = 0;
		while (true)
		{
			num += EncodeBytes(buffer, offset + num, count - num);
			if (num < count)
			{
				FlushInternal();
				continue;
			}
			break;
		}
	}

	static QEncodedStream()
	{
		//IL_0027: Field data (rva=0x6e8) could not be found in any section!
		//IL_0027: Field data (rva=0x6e8) could not be found in any section!
		//IL_0010: Field data (rva=0x5e8) could not be found in any section!
		//IL_0010: Field data (rva=0x5e8) could not be found in any section!
		byte[] array = new byte[256];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		s_hexDecodeMap = array;
		byte[] array2 = new byte[16];
		RuntimeHelpers.InitializeArray(array2, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		s_hexEncodeMap = array2;
	}
}
