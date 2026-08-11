using System;
using System.Diagnostics.CodeAnalysis;

namespace MemoryPack;

internal sealed class ErrorMemoryPackFormatter : IMemoryPackFormatter
{
	private readonly Type type;

	private readonly string? message;

	public ErrorMemoryPackFormatter(Type type)
	{
		this.type = type;
		message = null;
	}

	public ErrorMemoryPackFormatter(Type type, string message)
	{
		this.type = type;
		this.message = message;
	}

	public void Serialize(ref MemoryPackWriter writer, ref object? value)
	{
		Throw();
	}

	public void Deserialize(ref MemoryPackReader reader, ref object? value)
	{
		Throw();
	}

	[DoesNotReturn]
	private void Throw()
	{
		if (message != null)
		{
			MemoryPackSerializationException.ThrowMessage(message);
		}
		else
		{
			MemoryPackSerializationException.ThrowNotRegisteredInProvider(type);
		}
	}
}
internal sealed class ErrorMemoryPackFormatter<T> : MemoryPackFormatter<T>
{
	private readonly Exception? exception;

	private readonly string? message;

	public ErrorMemoryPackFormatter()
	{
		exception = null;
		message = null;
	}

	public ErrorMemoryPackFormatter(Exception exception)
	{
		this.exception = exception;
		message = null;
	}

	public ErrorMemoryPackFormatter(string message)
	{
		exception = null;
		this.message = message;
	}

	public override void Serialize(ref MemoryPackWriter writer, ref T? value)
	{
		Throw();
	}

	public override void Deserialize(ref MemoryPackReader reader, ref T? value)
	{
		Throw();
	}

	[DoesNotReturn]
	private void Throw()
	{
		if (exception != null)
		{
			MemoryPackSerializationException.ThrowRegisterInProviderFailed(typeof(T), exception);
		}
		else if (message != null)
		{
			MemoryPackSerializationException.ThrowMessage(message);
		}
		else
		{
			MemoryPackSerializationException.ThrowNotRegisteredInProvider(typeof(T));
		}
	}
}
