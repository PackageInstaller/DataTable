using System;
using System.Buffers;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using Nerdbank.Streams;

namespace MessagePack;

public class MessagePackStreamReader : IDisposable
{
	private readonly Stream stream;

	private readonly bool leaveOpen;

	private SequencePool.Rental sequenceRental;

	private SequencePosition? endOfLastMessage;

	public ReadOnlySequence<byte> RemainingBytes
	{
		get
		{
			if (!endOfLastMessage.HasValue)
			{
				return ReadData.AsReadOnlySequence;
			}
			return ReadData.AsReadOnlySequence.Slice(endOfLastMessage.Value);
		}
	}

	private Sequence<byte> ReadData => sequenceRental.Value;

	public MessagePackStreamReader(Stream stream)
		: this(stream, leaveOpen: false)
	{
	}

	public MessagePackStreamReader(Stream stream, bool leaveOpen)
		: this(stream, leaveOpen, SequencePool.Shared)
	{
	}

	public MessagePackStreamReader(Stream stream, bool leaveOpen, SequencePool sequencePool)
	{
		if (sequencePool == null)
		{
			throw new ArgumentNullException("sequencePool");
		}
		this.stream = stream ?? throw new ArgumentNullException("stream");
		this.leaveOpen = leaveOpen;
		sequenceRental = sequencePool.Rent();
	}

	public async ValueTask<ReadOnlySequence<byte>?> ReadAsync(CancellationToken cancellationToken)
	{
		RecycleLastMessage();
		do
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (TryReadNextMessage(out var completeMessage))
			{
				return completeMessage;
			}
		}
		while (await TryReadMoreDataAsync(cancellationToken).ConfigureAwait(continueOnCapturedContext: false));
		return null;
	}

	public void DiscardBufferedData()
	{
		sequenceRental.Value.Reset();
		endOfLastMessage = null;
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
		if (disposing)
		{
			if (!leaveOpen)
			{
				stream.Dispose();
			}
			sequenceRental.Dispose();
			sequenceRental = default(SequencePool.Rental);
		}
	}

	private void RecycleLastMessage()
	{
		if (endOfLastMessage.HasValue)
		{
			ReadData.AdvanceTo(endOfLastMessage.Value);
			endOfLastMessage = null;
		}
	}

	private async Task<bool> TryReadMoreDataAsync(CancellationToken cancellationToken)
	{
		cancellationToken.ThrowIfCancellationRequested();
		Memory<byte> memory = ReadData.GetMemory(0);
		int bytesRead = 0;
		try
		{
			bytesRead = await stream.ReadAsync(memory, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			return bytesRead > 0;
		}
		finally
		{
			ReadData.Advance(bytesRead);
		}
	}

	private bool TryReadNextMessage(out ReadOnlySequence<byte> completeMessage)
	{
		if (ReadData.Length > 0)
		{
			ReadOnlySequence<byte> readOnlySequence = ReadData;
			MessagePackReader messagePackReader = new MessagePackReader(in readOnlySequence);
			if (messagePackReader.TrySkip())
			{
				endOfLastMessage = messagePackReader.Position;
				readOnlySequence = messagePackReader.Sequence;
				completeMessage = readOnlySequence.Slice(0, messagePackReader.Position);
				return true;
			}
		}
		completeMessage = default(ReadOnlySequence<byte>);
		return false;
	}
}
