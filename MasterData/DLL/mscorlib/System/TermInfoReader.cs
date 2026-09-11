using System.IO;
using System.Text;

namespace System;

internal class TermInfoReader
{
	private int boolSize;

	private int numSize;

	private int strOffsets;

	private byte[] buffer;

	private int booleansOffset;

	private int intOffset;

	public TermInfoReader(string term, string filename)
	{
		using FileStream fileStream = File.OpenRead(filename);
		long length = fileStream.Length;
		if (length > 4096)
		{
			throw new Exception("File must be smaller than 4K");
		}
		buffer = new byte[(int)length];
		if (fileStream.Read(buffer, 0, buffer.Length) != buffer.Length)
		{
			throw new Exception("Short read");
		}
		ReadHeader(buffer, ref booleansOffset);
		ReadNames(buffer, ref booleansOffset);
	}

	public TermInfoReader(string term, byte[] buffer)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		this.buffer = buffer;
		ReadHeader(buffer, ref booleansOffset);
		ReadNames(buffer, ref booleansOffset);
	}

	private void DetermineVersion(short magic)
	{
		switch (magic)
		{
		case 282:
			intOffset = 2;
			break;
		case 542:
			intOffset = 4;
			break;
		default:
			throw new Exception($"Magic number is unexpected: {magic}");
		}
	}

	private void ReadHeader(byte[] buffer, ref int position)
	{
		short @int = GetInt16(buffer, position);
		position += 2;
		DetermineVersion(@int);
		GetInt16(buffer, position);
		position += 2;
		boolSize = GetInt16(buffer, position);
		position += 2;
		numSize = GetInt16(buffer, position);
		position += 2;
		strOffsets = GetInt16(buffer, position);
		position += 2;
		GetInt16(buffer, position);
		position += 2;
	}

	private void ReadNames(byte[] buffer, ref int position)
	{
		string text = GetString(buffer, position);
		position += text.Length + 1;
	}

	public int Get(TermInfoNumbers number)
	{
		if (number < TermInfoNumbers.Columns || number >= TermInfoNumbers.Last || (int)number > numSize)
		{
			return -1;
		}
		int num = booleansOffset + boolSize;
		if (num % 2 == 1)
		{
			num++;
		}
		num += (int)number * intOffset;
		return GetInt16(buffer, num);
	}

	public string Get(TermInfoStrings tstr)
	{
		if (tstr < TermInfoStrings.BackTab || tstr >= TermInfoStrings.Last || (int)tstr > strOffsets)
		{
			return null;
		}
		int num = booleansOffset + boolSize;
		if (num % 2 == 1)
		{
			num++;
		}
		num += numSize * intOffset;
		int @int = GetInt16(buffer, num + (int)tstr * 2);
		if (@int == -1)
		{
			return null;
		}
		return GetString(buffer, num + strOffsets * 2 + @int);
	}

	public byte[] GetStringBytes(TermInfoStrings tstr)
	{
		if (tstr < TermInfoStrings.BackTab || tstr >= TermInfoStrings.Last || (int)tstr > strOffsets)
		{
			return null;
		}
		int num = booleansOffset + boolSize;
		if (num % 2 == 1)
		{
			num++;
		}
		num += numSize * intOffset;
		int @int = GetInt16(buffer, num + (int)tstr * 2);
		if (@int == -1)
		{
			return null;
		}
		return GetStringBytes(buffer, num + strOffsets * 2 + @int);
	}

	private short GetInt16(byte[] buffer, int offset)
	{
		int num = buffer[offset];
		int num2 = buffer[offset + 1];
		if (num == 255 && num2 == 255)
		{
			return -1;
		}
		return (short)(num + num2 * 256);
	}

	private string GetString(byte[] buffer, int offset)
	{
		int num = 0;
		int num2 = offset;
		while (buffer[num2++] != 0)
		{
			num++;
		}
		return Encoding.ASCII.GetString(buffer, offset, num);
	}

	private byte[] GetStringBytes(byte[] buffer, int offset)
	{
		int num = 0;
		int num2 = offset;
		while (buffer[num2++] != 0)
		{
			num++;
		}
		byte[] array = new byte[num];
		Buffer.InternalBlockCopy(buffer, offset, array, 0, num);
		return array;
	}
}
