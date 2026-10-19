using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TDClientData : IMessage<TDClientData>, IMessage, IEquatable<TDClientData>, IDeepCloneable<TDClientData>, IBufferMessage
{
	private static readonly MessageParser<TDClientData> _parser = new MessageParser<TDClientData>(() => new TDClientData());

	private UnknownFieldSet _unknownFields;

	public const int OsFieldNumber = 1;

	private string os_ = "";

	public const int OsVersionFieldNumber = 2;

	private string osVersion_ = "";

	public const int BundleIdFieldNumber = 3;

	private string bundleId_ = "";

	public const int DeviceIdFieldNumber = 4;

	private string deviceId_ = "";

	public const int DeviceModelFieldNumber = 5;

	private string deviceModel_ = "";

	public const int ScreenHeightFieldNumber = 6;

	private int screenHeight_;

	public const int ScreenWidthFieldNumber = 7;

	private int screenWidth_;

	public const int SystemLanFieldNumber = 8;

	private string systemLan_ = "";

	public const int CpuFieldNumber = 9;

	private string cpu_ = "";

	public const int GpuFieldNumber = 10;

	private string gpu_ = "";

	public const int ChannelIdFieldNumber = 11;

	private string channelId_ = "";

	public const int CpsFieldNumber = 12;

	private string cps_ = "";

	public const int PlatformFieldNumber = 13;

	private string platform_ = "";

	public const int ClientVersionFieldNumber = 14;

	private string clientVersion_ = "";

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TDClientData> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[272];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Os
	{
		get
		{
			return os_;
		}
		set
		{
			os_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string OsVersion
	{
		get
		{
			return osVersion_;
		}
		set
		{
			osVersion_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string BundleId
	{
		get
		{
			return bundleId_;
		}
		set
		{
			bundleId_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string DeviceModel
	{
		get
		{
			return deviceModel_;
		}
		set
		{
			deviceModel_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ScreenHeight
	{
		get
		{
			return screenHeight_;
		}
		set
		{
			screenHeight_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ScreenWidth
	{
		get
		{
			return screenWidth_;
		}
		set
		{
			screenWidth_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string SystemLan
	{
		get
		{
			return systemLan_;
		}
		set
		{
			systemLan_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Cpu
	{
		get
		{
			return cpu_;
		}
		set
		{
			cpu_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Gpu
	{
		get
		{
			return gpu_;
		}
		set
		{
			gpu_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string ChannelId
	{
		get
		{
			return channelId_;
		}
		set
		{
			channelId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Cps
	{
		get
		{
			return cps_;
		}
		set
		{
			cps_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

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
	public TDClientData()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TDClientData(TDClientData other)
		: this()
	{
		os_ = other.os_;
		osVersion_ = other.osVersion_;
		bundleId_ = other.bundleId_;
		deviceId_ = other.deviceId_;
		deviceModel_ = other.deviceModel_;
		screenHeight_ = other.screenHeight_;
		screenWidth_ = other.screenWidth_;
		systemLan_ = other.systemLan_;
		cpu_ = other.cpu_;
		gpu_ = other.gpu_;
		channelId_ = other.channelId_;
		cps_ = other.cps_;
		platform_ = other.platform_;
		clientVersion_ = other.clientVersion_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TDClientData Clone()
	{
		return new TDClientData(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TDClientData);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TDClientData other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Os != other.Os)
		{
			return false;
		}
		if (OsVersion != other.OsVersion)
		{
			return false;
		}
		if (BundleId != other.BundleId)
		{
			return false;
		}
		if (DeviceId != other.DeviceId)
		{
			return false;
		}
		if (DeviceModel != other.DeviceModel)
		{
			return false;
		}
		if (ScreenHeight != other.ScreenHeight)
		{
			return false;
		}
		if (ScreenWidth != other.ScreenWidth)
		{
			return false;
		}
		if (SystemLan != other.SystemLan)
		{
			return false;
		}
		if (Cpu != other.Cpu)
		{
			return false;
		}
		if (Gpu != other.Gpu)
		{
			return false;
		}
		if (ChannelId != other.ChannelId)
		{
			return false;
		}
		if (Cps != other.Cps)
		{
			return false;
		}
		if (Platform != other.Platform)
		{
			return false;
		}
		if (ClientVersion != other.ClientVersion)
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
		if (Os.Length != 0)
		{
			num ^= Os.GetHashCode();
		}
		if (OsVersion.Length != 0)
		{
			num ^= OsVersion.GetHashCode();
		}
		if (BundleId.Length != 0)
		{
			num ^= BundleId.GetHashCode();
		}
		if (DeviceId.Length != 0)
		{
			num ^= DeviceId.GetHashCode();
		}
		if (DeviceModel.Length != 0)
		{
			num ^= DeviceModel.GetHashCode();
		}
		if (ScreenHeight != 0)
		{
			num ^= ScreenHeight.GetHashCode();
		}
		if (ScreenWidth != 0)
		{
			num ^= ScreenWidth.GetHashCode();
		}
		if (SystemLan.Length != 0)
		{
			num ^= SystemLan.GetHashCode();
		}
		if (Cpu.Length != 0)
		{
			num ^= Cpu.GetHashCode();
		}
		if (Gpu.Length != 0)
		{
			num ^= Gpu.GetHashCode();
		}
		if (ChannelId.Length != 0)
		{
			num ^= ChannelId.GetHashCode();
		}
		if (Cps.Length != 0)
		{
			num ^= Cps.GetHashCode();
		}
		if (Platform.Length != 0)
		{
			num ^= Platform.GetHashCode();
		}
		if (ClientVersion.Length != 0)
		{
			num ^= ClientVersion.GetHashCode();
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
		if (Os.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Os);
		}
		if (OsVersion.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(OsVersion);
		}
		if (BundleId.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(BundleId);
		}
		if (DeviceId.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(DeviceId);
		}
		if (DeviceModel.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(DeviceModel);
		}
		if (ScreenHeight != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ScreenHeight);
		}
		if (ScreenWidth != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ScreenWidth);
		}
		if (SystemLan.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(SystemLan);
		}
		if (Cpu.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Cpu);
		}
		if (Gpu.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Gpu);
		}
		if (ChannelId.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(ChannelId);
		}
		if (Cps.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Cps);
		}
		if (Platform.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Platform);
		}
		if (ClientVersion.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(ClientVersion);
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
		if (Os.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Os);
		}
		if (OsVersion.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OsVersion);
		}
		if (BundleId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BundleId);
		}
		if (DeviceId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DeviceId);
		}
		if (DeviceModel.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DeviceModel);
		}
		if (ScreenHeight != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ScreenHeight);
		}
		if (ScreenWidth != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ScreenWidth);
		}
		if (SystemLan.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SystemLan);
		}
		if (Cpu.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Cpu);
		}
		if (Gpu.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Gpu);
		}
		if (ChannelId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ChannelId);
		}
		if (Cps.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Cps);
		}
		if (Platform.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Platform);
		}
		if (ClientVersion.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ClientVersion);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TDClientData other)
	{
		if (other != null)
		{
			if (other.Os.Length != 0)
			{
				Os = other.Os;
			}
			if (other.OsVersion.Length != 0)
			{
				OsVersion = other.OsVersion;
			}
			if (other.BundleId.Length != 0)
			{
				BundleId = other.BundleId;
			}
			if (other.DeviceId.Length != 0)
			{
				DeviceId = other.DeviceId;
			}
			if (other.DeviceModel.Length != 0)
			{
				DeviceModel = other.DeviceModel;
			}
			if (other.ScreenHeight != 0)
			{
				ScreenHeight = other.ScreenHeight;
			}
			if (other.ScreenWidth != 0)
			{
				ScreenWidth = other.ScreenWidth;
			}
			if (other.SystemLan.Length != 0)
			{
				SystemLan = other.SystemLan;
			}
			if (other.Cpu.Length != 0)
			{
				Cpu = other.Cpu;
			}
			if (other.Gpu.Length != 0)
			{
				Gpu = other.Gpu;
			}
			if (other.ChannelId.Length != 0)
			{
				ChannelId = other.ChannelId;
			}
			if (other.Cps.Length != 0)
			{
				Cps = other.Cps;
			}
			if (other.Platform.Length != 0)
			{
				Platform = other.Platform;
			}
			if (other.ClientVersion.Length != 0)
			{
				ClientVersion = other.ClientVersion;
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
				Os = input.ReadString();
				break;
			case 18u:
				OsVersion = input.ReadString();
				break;
			case 26u:
				BundleId = input.ReadString();
				break;
			case 34u:
				DeviceId = input.ReadString();
				break;
			case 42u:
				DeviceModel = input.ReadString();
				break;
			case 48u:
				ScreenHeight = input.ReadInt32();
				break;
			case 56u:
				ScreenWidth = input.ReadInt32();
				break;
			case 66u:
				SystemLan = input.ReadString();
				break;
			case 74u:
				Cpu = input.ReadString();
				break;
			case 82u:
				Gpu = input.ReadString();
				break;
			case 90u:
				ChannelId = input.ReadString();
				break;
			case 98u:
				Cps = input.ReadString();
				break;
			case 106u:
				Platform = input.ReadString();
				break;
			case 114u:
				ClientVersion = input.ReadString();
				break;
			}
		}
	}
}
