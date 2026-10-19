using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using System.Globalization;
using System.Text;
using Google.Protobuf.Reflection;

namespace Google.Protobuf.WellKnownTypes;

public sealed class Timestamp : IMessage<Timestamp>, IMessage, IEquatable<Timestamp>, IDeepCloneable<Timestamp>, IBufferMessage, ICustomDiagnosticMessage, IComparable<Timestamp>
{
	private static readonly MessageParser<Timestamp> _parser = new MessageParser<Timestamp>(() => new Timestamp());

	private UnknownFieldSet _unknownFields;

	private long seconds_;

	private int nanos_;

	private static readonly DateTime UnixEpoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageParser<Timestamp> Parser => _parser;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => TimestampReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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
	public Timestamp()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Timestamp(Timestamp other)
		: this()
	{
		seconds_ = other.seconds_;
		nanos_ = other.nanos_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Timestamp Clone()
	{
		return new Timestamp(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Timestamp);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Timestamp other)
	{
		if ((object)other == null)
		{
			return false;
		}
		if ((object)other == this)
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

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Timestamp other)
	{
		if (!(other == null))
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

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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

	private static bool IsNormalized(long seconds, int nanoseconds)
	{
		if (nanoseconds >= 0 && nanoseconds <= 999999999 && seconds >= -62135596800L)
		{
			return seconds <= 253402300799L;
		}
		return false;
	}

	public static Timestamp operator +(Timestamp lhs, Duration rhs)
	{
		ProtoPreconditions.CheckNotNull(lhs, "lhs");
		ProtoPreconditions.CheckNotNull(rhs, "rhs");
		return checked(Normalize(lhs.Seconds + rhs.Seconds, lhs.Nanos + rhs.Nanos));
	}

	public static Timestamp FromDateTime(DateTime dateTime)
	{
		if (dateTime.Kind != DateTimeKind.Utc)
		{
			throw new ArgumentException("Conversion from DateTime to Timestamp requires the DateTime kind to be Utc", "dateTime");
		}
		long num = dateTime.Ticks / 10000000;
		int nanos = (int)(dateTime.Ticks % 10000000) * 100;
		return new Timestamp
		{
			Seconds = num - 62135596800L,
			Nanos = nanos
		};
	}

	internal static Timestamp Normalize(long seconds, int nanoseconds)
	{
		int num = nanoseconds / 1000000000;
		seconds += num;
		nanoseconds -= num * 1000000000;
		if (nanoseconds < 0)
		{
			nanoseconds += 1000000000;
			seconds--;
		}
		return new Timestamp
		{
			Seconds = seconds,
			Nanos = nanoseconds
		};
	}

	internal static string ToJson(long seconds, int nanoseconds, bool diagnosticOnly)
	{
		if (IsNormalized(seconds, nanoseconds))
		{
			DateTime unixEpoch = UnixEpoch;
			DateTime dateTime = unixEpoch.AddSeconds(seconds);
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.Append('"');
			stringBuilder.Append(dateTime.ToString("yyyy'-'MM'-'dd'T'HH:mm:ss", CultureInfo.InvariantCulture));
			Duration.AppendNanoseconds(stringBuilder, nanoseconds);
			stringBuilder.Append("Z\"");
			return stringBuilder.ToString();
		}
		if (diagnosticOnly)
		{
			return string.Format(CultureInfo.InvariantCulture, "{{ \"@warning\": \"Invalid Timestamp\", \"seconds\": \"{0}\", \"nanos\": {1} }}", new object[2] { seconds, nanoseconds });
		}
		throw new InvalidOperationException("Non-normalized timestamp value");
	}

	public int CompareTo(Timestamp other)
	{
		if (!(other == null))
		{
			if (Seconds >= other.Seconds)
			{
				if (Seconds <= other.Seconds)
				{
					if (Nanos >= other.Nanos)
					{
						if (Nanos <= other.Nanos)
						{
							return 0;
						}
						return 1;
					}
					return -1;
				}
				return 1;
			}
			return -1;
		}
		return 1;
	}

	public static bool operator ==(Timestamp a, Timestamp b)
	{
		if (a != b)
		{
			if (a != null)
			{
				return a.Equals(b);
			}
			if (b != null)
			{
				return false;
			}
			return true;
		}
		return true;
	}

	public string ToDiagnosticString()
	{
		return ToJson(Seconds, Nanos, diagnosticOnly: true);
	}
}
