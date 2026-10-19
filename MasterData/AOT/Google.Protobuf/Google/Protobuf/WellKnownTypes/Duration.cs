using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using System.Globalization;
using System.Text;
using Google.Protobuf.Reflection;

namespace Google.Protobuf.WellKnownTypes;

public sealed class Duration : IMessage<Duration>, IMessage, IEquatable<Duration>, IDeepCloneable<Duration>, IBufferMessage, ICustomDiagnosticMessage
{
	private static readonly MessageParser<Duration> _parser = new MessageParser<Duration>(() => new Duration());

	private UnknownFieldSet _unknownFields;

	private long seconds_;

	private int nanos_;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageParser<Duration> Parser => _parser;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => DurationReflection.Descriptor.MessageTypes[0];

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public long Seconds
	{
		get
		{
			return seconds_;
		}
		set
		{
			seconds_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public int Nanos
	{
		get
		{
			return nanos_;
		}
		set
		{
			nanos_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Duration()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Duration(Duration other)
		: this()
	{
		seconds_ = other.seconds_;
		nanos_ = other.nanos_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Duration Clone()
	{
		return new Duration(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Duration);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool Equals(Duration other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Seconds != other.Seconds)
		{
			return false;
		}
		if (Nanos != other.Nanos)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Seconds != 0L)
		{
			num ^= Seconds.GetHashCode();
		}
		if (Nanos != 0)
		{
			num ^= Nanos.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (Seconds != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(Seconds);
		}
		if (Nanos != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Nanos);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Seconds != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Seconds);
		}
		if (Nanos != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Nanos);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public void MergeFrom(Duration other)
	{
		if (other != null)
		{
			if (other.Seconds != 0L)
			{
				Seconds = other.Seconds;
			}
			if (other.Nanos != 0)
			{
				Nanos = other.Nanos;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				Seconds = input.ReadInt64();
				break;
			case 16u:
				Nanos = input.ReadInt32();
				break;
			}
		}
	}

	internal static bool IsNormalized(long seconds, int nanoseconds)
	{
		if (seconds < -315576000000L || seconds > 315576000000L || nanoseconds < -999999999 || nanoseconds > 999999999)
		{
			return false;
		}
		return Math.Sign(seconds) * Math.Sign(nanoseconds) != -1;
	}

	internal static string ToJson(long seconds, int nanoseconds, bool diagnosticOnly)
	{
		if (IsNormalized(seconds, nanoseconds))
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.Append('"');
			if (seconds == 0L && nanoseconds < 0)
			{
				stringBuilder.Append('-');
			}
			stringBuilder.Append(seconds.ToString("d", CultureInfo.InvariantCulture));
			AppendNanoseconds(stringBuilder, Math.Abs(nanoseconds));
			stringBuilder.Append("s\"");
			return stringBuilder.ToString();
		}
		if (diagnosticOnly)
		{
			return string.Format(CultureInfo.InvariantCulture, "{{ \"@warning\": \"Invalid Duration\", \"seconds\": \"{0}\", \"nanos\": {1} }}", new object[2] { seconds, nanoseconds });
		}
		throw new InvalidOperationException("Non-normalized duration value");
	}

	public string ToDiagnosticString()
	{
		return ToJson(Seconds, Nanos, diagnosticOnly: true);
	}

	internal static void AppendNanoseconds(StringBuilder builder, int nanos)
	{
		if (nanos != 0)
		{
			builder.Append('.');
			if (nanos % 1000000 == 0)
			{
				builder.Append((nanos / 1000000).ToString("d3", CultureInfo.InvariantCulture));
			}
			else if (nanos % 1000 == 0)
			{
				builder.Append((nanos / 1000).ToString("d6", CultureInfo.InvariantCulture));
			}
			else
			{
				builder.Append(nanos.ToString("d9", CultureInfo.InvariantCulture));
			}
		}
	}
}
