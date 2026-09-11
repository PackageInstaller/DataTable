using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;

namespace System.Net;

internal class MonoChunkParser
{
	private enum State
	{
		None,
		PartialSize,
		Body,
		BodyFinished,
		Trailer
	}

	private class Chunk
	{
		public byte[] Bytes;

		public int Offset;

		public Chunk(byte[] chunk)
		{
			Bytes = chunk;
		}

		public int Read(byte[] buffer, int offset, int size)
		{
			int num = ((size > Bytes.Length - Offset) ? (Bytes.Length - Offset) : size);
			Buffer.BlockCopy(Bytes, Offset, buffer, offset, num);
			Offset += num;
			return num;
		}
	}

	private WebHeaderCollection headers;

	private int chunkSize;

	private int chunkRead;

	private int totalWritten;

	private State state;

	private StringBuilder saved;

	private bool sawCR;

	private bool gotit;

	private int trailerState;

	private ArrayList chunks;

	public bool WantMore
	{
		get
		{
			if (chunkRead == chunkSize && chunkSize == 0)
			{
				return state != State.None;
			}
			return true;
		}
	}

	public bool DataAvailable
	{
		get
		{
			int count = chunks.Count;
			for (int i = 0; i < count; i++)
			{
				Chunk chunk = (Chunk)chunks[i];
				if (chunk != null && chunk.Bytes != null && chunk.Bytes.Length != 0 && chunk.Offset < chunk.Bytes.Length)
				{
					return state != State.Body;
				}
			}
			return false;
		}
	}

	public int ChunkLeft => chunkSize - chunkRead;

	public MonoChunkParser(WebHeaderCollection headers)
	{
		this.headers = headers;
		saved = new StringBuilder();
		chunks = new ArrayList();
		chunkSize = -1;
		totalWritten = 0;
	}

	public int Read(byte[] buffer, int offset, int size)
	{
		return ReadFromChunks(buffer, offset, size);
	}

	private int ReadFromChunks(byte[] buffer, int offset, int size)
	{
		int count = chunks.Count;
		int num = 0;
		List<Chunk> list = new List<Chunk>(count);
		for (int i = 0; i < count; i++)
		{
			Chunk chunk = (Chunk)chunks[i];
			if (chunk.Offset == chunk.Bytes.Length)
			{
				list.Add(chunk);
				continue;
			}
			num += chunk.Read(buffer, offset + num, size - num);
			if (num == size)
			{
				break;
			}
		}
		foreach (Chunk item in list)
		{
			chunks.Remove(item);
		}
		return num;
	}

	public void Write(byte[] buffer, int offset, int size)
	{
		if (offset < size)
		{
			InternalWrite(buffer, ref offset, size);
		}
	}

	private void InternalWrite(byte[] buffer, ref int offset, int size)
	{
		if (state == State.None || state == State.PartialSize)
		{
			state = GetChunkSize(buffer, ref offset, size);
			if (state == State.PartialSize)
			{
				return;
			}
			saved.Length = 0;
			sawCR = false;
			gotit = false;
		}
		if (state == State.Body && offset < size)
		{
			state = ReadBody(buffer, ref offset, size);
			if (state == State.Body)
			{
				return;
			}
		}
		if (state == State.BodyFinished && offset < size)
		{
			state = ReadCRLF(buffer, ref offset, size);
			if (state == State.BodyFinished)
			{
				return;
			}
			sawCR = false;
		}
		if (state == State.Trailer && offset < size)
		{
			state = ReadTrailer(buffer, ref offset, size);
			if (state == State.Trailer)
			{
				return;
			}
			saved.Length = 0;
			sawCR = false;
			gotit = false;
		}
		if (offset < size)
		{
			InternalWrite(buffer, ref offset, size);
		}
	}

	private State ReadBody(byte[] buffer, ref int offset, int size)
	{
		if (chunkSize == 0)
		{
			return State.BodyFinished;
		}
		int num = size - offset;
		if (num + chunkRead > chunkSize)
		{
			num = chunkSize - chunkRead;
		}
		byte[] array = new byte[num];
		Buffer.BlockCopy(buffer, offset, array, 0, num);
		chunks.Add(new Chunk(array));
		offset += num;
		chunkRead += num;
		totalWritten += num;
		if (chunkRead != chunkSize)
		{
			return State.Body;
		}
		return State.BodyFinished;
	}

	private State GetChunkSize(byte[] buffer, ref int offset, int size)
	{
		chunkRead = 0;
		chunkSize = 0;
		char c = '\0';
		while (offset < size)
		{
			c = (char)buffer[offset++];
			if (c == '\r')
			{
				if (sawCR)
				{
					ThrowProtocolViolation("2 CR found");
				}
				sawCR = true;
				continue;
			}
			if (sawCR && c == '\n')
			{
				break;
			}
			if (c == ' ')
			{
				gotit = true;
			}
			if (!gotit)
			{
				saved.Append(c);
			}
			if (saved.Length > 20)
			{
				ThrowProtocolViolation("chunk size too long.");
			}
		}
		if (!sawCR || c != '\n')
		{
			if (offset < size)
			{
				ThrowProtocolViolation("Missing \\n");
			}
			try
			{
				if (saved.Length > 0)
				{
					chunkSize = int.Parse(RemoveChunkExtension(saved.ToString()), NumberStyles.HexNumber);
				}
			}
			catch (Exception)
			{
				ThrowProtocolViolation("Cannot parse chunk size.");
			}
			return State.PartialSize;
		}
		chunkRead = 0;
		try
		{
			chunkSize = int.Parse(RemoveChunkExtension(saved.ToString()), NumberStyles.HexNumber);
		}
		catch (Exception)
		{
			ThrowProtocolViolation("Cannot parse chunk size.");
		}
		if (chunkSize == 0)
		{
			trailerState = 2;
			return State.Trailer;
		}
		return State.Body;
	}

	private static string RemoveChunkExtension(string input)
	{
		int num = input.IndexOf(';');
		if (num == -1)
		{
			return input;
		}
		return input.Substring(0, num);
	}

	private State ReadCRLF(byte[] buffer, ref int offset, int size)
	{
		if (!sawCR)
		{
			if (buffer[offset++] != 13)
			{
				ThrowProtocolViolation("Expecting \\r");
			}
			sawCR = true;
			if (offset == size)
			{
				return State.BodyFinished;
			}
		}
		if (sawCR && buffer[offset++] != 10)
		{
			ThrowProtocolViolation("Expecting \\n");
		}
		return State.None;
	}

	private State ReadTrailer(byte[] buffer, ref int offset, int size)
	{
		char c = '\0';
		if (trailerState == 2 && buffer[offset] == 13 && saved.Length == 0)
		{
			offset++;
			if (offset < size && buffer[offset] == 10)
			{
				offset++;
				return State.None;
			}
			offset--;
		}
		int num = trailerState;
		while (offset < size && num < 4)
		{
			c = (char)buffer[offset++];
			if ((num == 0 || num == 2) && c == '\r')
			{
				num++;
			}
			else if ((num == 1 || num == 3) && c == '\n')
			{
				num++;
			}
			else if (num >= 0)
			{
				saved.Append(c);
				num = 0;
				if (saved.Length > 4196)
				{
					ThrowProtocolViolation("Error reading trailer (too long).");
				}
			}
		}
		if (num < 4)
		{
			trailerState = num;
			if (offset < size)
			{
				ThrowProtocolViolation("Error reading trailer.");
			}
			return State.Trailer;
		}
		StringReader stringReader = new StringReader(saved.ToString());
		string text;
		while ((text = stringReader.ReadLine()) != null && text != "")
		{
			headers.Add(text);
		}
		return State.None;
	}

	private static void ThrowProtocolViolation(string message)
	{
		throw new WebException(message, null, WebExceptionStatus.ServerProtocolViolation, null);
	}
}
