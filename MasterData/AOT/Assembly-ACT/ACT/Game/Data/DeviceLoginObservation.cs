using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class DeviceLoginObservation : IMessage<DeviceLoginObservation>, IMessage, IEquatable<DeviceLoginObservation>, IDeepCloneable<DeviceLoginObservation>, IBufferMessage
{
	private static readonly MessageParser<DeviceLoginObservation> _parser = new MessageParser<DeviceLoginObservation>(() => new DeviceLoginObservation());

	private UnknownFieldSet _unknownFields;

	public const int DeviceIdFieldNumber = 1;

	private string deviceId_ = "";

	public const int LastIpFieldNumber = 2;

	private string lastIp_ = "";

	public const int LastPlatformFieldNumber = 3;

	private string lastPlatform_ = "";

	public const int LastObservedAtFieldNumber = 4;

	private long lastObservedAt_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<DeviceLoginObservation> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[274];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string DeviceId
	{
		get
		{
			return deviceId_;
		}
		set
		{
			deviceId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string LastIp
	{
		get
		{
			return lastIp_;
		}
		set
		{
			lastIp_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string LastPlatform
	{
		get
		{
			return lastPlatform_;
		}
		set
		{
			lastPlatform_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long LastObservedAt
	{
		get
		{
			return lastObservedAt_;
		}
		set
		{
			lastObservedAt_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DeviceLoginObservation()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DeviceLoginObservation(DeviceLoginObservation other)
		: this()
	{
		deviceId_ = other.deviceId_;
		lastIp_ = other.lastIp_;
		lastPlatform_ = other.lastPlatform_;
		lastObservedAt_ = other.lastObservedAt_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DeviceLoginObservation Clone()
	{
		return new DeviceLoginObservation(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as DeviceLoginObservation);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(DeviceLoginObservation other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (DeviceId != other.DeviceId)
		{
			return false;
		}
		if (LastIp != other.LastIp)
		{
			return false;
		}
		if (LastPlatform != other.LastPlatform)
		{
			return false;
		}
		if (LastObservedAt != other.LastObservedAt)
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
		if (DeviceId.Length != 0)
		{
			num ^= DeviceId.GetHashCode();
		}
		if (LastIp.Length != 0)
		{
			num ^= LastIp.GetHashCode();
		}
		if (LastPlatform.Length != 0)
		{
			num ^= LastPlatform.GetHashCode();
		}
		if (LastObservedAt != 0L)
		{
			num ^= LastObservedAt.GetHashCode();
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

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (DeviceId.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(DeviceId);
		}
		if (LastIp.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(LastIp);
		}
		if (LastPlatform.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(LastPlatform);
		}
		if (LastObservedAt != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(LastObservedAt);
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
		if (DeviceId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DeviceId);
		}
		if (LastIp.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LastIp);
		}
		if (LastPlatform.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LastPlatform);
		}
		if (LastObservedAt != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(LastObservedAt);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(DeviceLoginObservation other)
	{
		if (other != null)
		{
			if (other.DeviceId.Length != 0)
			{
				DeviceId = other.DeviceId;
			}
			if (other.LastIp.Length != 0)
			{
				LastIp = other.LastIp;
			}
			if (other.LastPlatform.Length != 0)
			{
				LastPlatform = other.LastPlatform;
			}
			if (other.LastObservedAt != 0L)
			{
				LastObservedAt = other.LastObservedAt;
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
			case 10u:
				DeviceId = input.ReadString();
				break;
			case 18u:
				LastIp = input.ReadString();
				break;
			case 26u:
				LastPlatform = input.ReadString();
				break;
			case 32u:
				LastObservedAt = input.ReadInt64();
				break;
			}
		}
	}
}
