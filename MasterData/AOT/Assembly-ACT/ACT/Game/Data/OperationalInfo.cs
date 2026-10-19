using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class OperationalInfo : IMessage<OperationalInfo>, IMessage, IEquatable<OperationalInfo>, IDeepCloneable<OperationalInfo>, IBufferMessage
{
	private static readonly MessageParser<OperationalInfo> _parser = new MessageParser<OperationalInfo>(() => new OperationalInfo());

	private UnknownFieldSet _unknownFields;

	public const int PlatformFieldNumber = 1;

	private string platform_ = "";

	public const int DeviceFieldNumber = 2;

	private string device_ = "";

	public const int OperatingSystemFieldNumber = 3;

	private string operatingSystem_ = "";

	public const int ClientVersionFieldNumber = 4;

	private string clientVersion_ = "";

	public const int DeviceIdFieldNumber = 5;

	private string deviceId_ = "";

	public const int ViolationRecordsFieldNumber = 6;

	private static readonly FieldCodec<ViolationRecord> _repeated_violationRecords_codec = FieldCodec.ForMessage(50u, ViolationRecord.Parser);

	private readonly RepeatedField<ViolationRecord> violationRecords_ = new RepeatedField<ViolationRecord>();

	public const int CountedBlackAccountIdsFieldNumber = 7;

	private static readonly FieldCodec<long> _repeated_countedBlackAccountIds_codec = FieldCodec.ForInt64(58u);

	private readonly RepeatedField<long> countedBlackAccountIds_ = new RepeatedField<long>();

	public const int DeviceLoginObservationsFieldNumber = 8;

	private static readonly FieldCodec<DeviceLoginObservation> _repeated_deviceLoginObservations_codec = FieldCodec.ForMessage(66u, DeviceLoginObservation.Parser);

	private readonly RepeatedField<DeviceLoginObservation> deviceLoginObservations_ = new RepeatedField<DeviceLoginObservation>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<OperationalInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[275];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Platform
	{
		get
		{
			return platform_;
		}
		set
		{
			platform_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Device
	{
		get
		{
			return device_;
		}
		set
		{
			device_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string OperatingSystem
	{
		get
		{
			return operatingSystem_;
		}
		set
		{
			operatingSystem_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string ClientVersion
	{
		get
		{
			return clientVersion_;
		}
		set
		{
			clientVersion_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

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
	public RepeatedField<ViolationRecord> ViolationRecords => violationRecords_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<long> CountedBlackAccountIds => countedBlackAccountIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<DeviceLoginObservation> DeviceLoginObservations => deviceLoginObservations_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OperationalInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OperationalInfo(OperationalInfo other)
		: this()
	{
		platform_ = other.platform_;
		device_ = other.device_;
		operatingSystem_ = other.operatingSystem_;
		clientVersion_ = other.clientVersion_;
		deviceId_ = other.deviceId_;
		violationRecords_ = other.violationRecords_.Clone();
		countedBlackAccountIds_ = other.countedBlackAccountIds_.Clone();
		deviceLoginObservations_ = other.deviceLoginObservations_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OperationalInfo Clone()
	{
		return new OperationalInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as OperationalInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(OperationalInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Platform != other.Platform)
		{
			return false;
		}
		if (Device != other.Device)
		{
			return false;
		}
		if (OperatingSystem != other.OperatingSystem)
		{
			return false;
		}
		if (ClientVersion != other.ClientVersion)
		{
			return false;
		}
		if (DeviceId != other.DeviceId)
		{
			return false;
		}
		if (!violationRecords_.Equals(other.violationRecords_))
		{
			return false;
		}
		if (!countedBlackAccountIds_.Equals(other.countedBlackAccountIds_))
		{
			return false;
		}
		if (!deviceLoginObservations_.Equals(other.deviceLoginObservations_))
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
		if (Platform.Length != 0)
		{
			num ^= Platform.GetHashCode();
		}
		if (Device.Length != 0)
		{
			num ^= Device.GetHashCode();
		}
		if (OperatingSystem.Length != 0)
		{
			num ^= OperatingSystem.GetHashCode();
		}
		if (ClientVersion.Length != 0)
		{
			num ^= ClientVersion.GetHashCode();
		}
		if (DeviceId.Length != 0)
		{
			num ^= DeviceId.GetHashCode();
		}
		num ^= violationRecords_.GetHashCode();
		num ^= countedBlackAccountIds_.GetHashCode();
		num ^= deviceLoginObservations_.GetHashCode();
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
		if (Platform.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Platform);
		}
		if (Device.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Device);
		}
		if (OperatingSystem.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(OperatingSystem);
		}
		if (ClientVersion.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(ClientVersion);
		}
		if (DeviceId.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(DeviceId);
		}
		violationRecords_.WriteTo(ref output, _repeated_violationRecords_codec);
		countedBlackAccountIds_.WriteTo(ref output, _repeated_countedBlackAccountIds_codec);
		deviceLoginObservations_.WriteTo(ref output, _repeated_deviceLoginObservations_codec);
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
		if (Platform.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Platform);
		}
		if (Device.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Device);
		}
		if (OperatingSystem.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OperatingSystem);
		}
		if (ClientVersion.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ClientVersion);
		}
		if (DeviceId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DeviceId);
		}
		num += violationRecords_.CalculateSize(_repeated_violationRecords_codec);
		num += countedBlackAccountIds_.CalculateSize(_repeated_countedBlackAccountIds_codec);
		num += deviceLoginObservations_.CalculateSize(_repeated_deviceLoginObservations_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(OperationalInfo other)
	{
		if (other != null)
		{
			if (other.Platform.Length != 0)
			{
				Platform = other.Platform;
			}
			if (other.Device.Length != 0)
			{
				Device = other.Device;
			}
			if (other.OperatingSystem.Length != 0)
			{
				OperatingSystem = other.OperatingSystem;
			}
			if (other.ClientVersion.Length != 0)
			{
				ClientVersion = other.ClientVersion;
			}
			if (other.DeviceId.Length != 0)
			{
				DeviceId = other.DeviceId;
			}
			violationRecords_.Add(other.violationRecords_);
			countedBlackAccountIds_.Add(other.countedBlackAccountIds_);
			deviceLoginObservations_.Add(other.deviceLoginObservations_);
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
				Platform = input.ReadString();
				break;
			case 18u:
				Device = input.ReadString();
				break;
			case 26u:
				OperatingSystem = input.ReadString();
				break;
			case 34u:
				ClientVersion = input.ReadString();
				break;
			case 42u:
				DeviceId = input.ReadString();
				break;
			case 50u:
				violationRecords_.AddEntriesFrom(ref input, _repeated_violationRecords_codec);
				break;
			case 56u:
			case 58u:
				countedBlackAccountIds_.AddEntriesFrom(ref input, _repeated_countedBlackAccountIds_codec);
				break;
			case 66u:
				deviceLoginObservations_.AddEntriesFrom(ref input, _repeated_deviceLoginObservations_codec);
				break;
			}
		}
	}
}
