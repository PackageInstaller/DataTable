using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class activity_reforge_skill : IMessage<activity_reforge_skill>, IMessage, IEquatable<activity_reforge_skill>, IDeepCloneable<activity_reforge_skill>
{
	private static readonly MessageParser<activity_reforge_skill> _parser = new MessageParser<activity_reforge_skill>(() => new activity_reforge_skill());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int IconFieldNumber = 2;

	private string icon_ = "";

	public const int FlowIdFieldNumber = 3;

	private string flowId_ = "";

	public const int CdFieldNumber = 4;

	private int cd_;

	public const int UseCountFieldNumber = 5;

	private int useCount_;

	public const int ParamFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_param_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> param_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<activity_reforge_skill> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[73];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string FlowId
	{
		get
		{
			return flowId_;
		}
		set
		{
			flowId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Cd
	{
		get
		{
			return cd_;
		}
		set
		{
			cd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UseCount
	{
		get
		{
			return useCount_;
		}
		set
		{
			useCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Param => param_;

	[DebuggerNonUserCode]
	public activity_reforge_skill()
	{
	}

	[DebuggerNonUserCode]
	public activity_reforge_skill(activity_reforge_skill other)
		: this()
	{
		iD_ = other.iD_;
		icon_ = other.icon_;
		flowId_ = other.flowId_;
		cd_ = other.cd_;
		useCount_ = other.useCount_;
		param_ = other.param_.Clone();
	}

	[DebuggerNonUserCode]
	public activity_reforge_skill Clone()
	{
		return new activity_reforge_skill(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as activity_reforge_skill);
	}

	[DebuggerNonUserCode]
	public bool Equals(activity_reforge_skill other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (FlowId != other.FlowId)
		{
			return false;
		}
		if (Cd != other.Cd)
		{
			return false;
		}
		if (UseCount != other.UseCount)
		{
			return false;
		}
		if (!param_.Equals(other.param_))
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (FlowId.Length != 0)
		{
			num ^= FlowId.GetHashCode();
		}
		if (Cd != 0)
		{
			num ^= Cd.GetHashCode();
		}
		if (UseCount != 0)
		{
			num ^= UseCount.GetHashCode();
		}
		return num ^ param_.GetHashCode();
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Icon);
		}
		if (FlowId.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(FlowId);
		}
		if (Cd != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Cd);
		}
		if (UseCount != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(UseCount);
		}
		param_.WriteTo(output, _repeated_param_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (FlowId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FlowId);
		}
		if (Cd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cd);
		}
		if (UseCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UseCount);
		}
		return num + param_.CalculateSize(_repeated_param_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(activity_reforge_skill other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.FlowId.Length != 0)
			{
				FlowId = other.FlowId;
			}
			if (other.Cd != 0)
			{
				Cd = other.Cd;
			}
			if (other.UseCount != 0)
			{
				UseCount = other.UseCount;
			}
			param_.Add(other.param_);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				input.SkipLastField();
				break;
			case 8u:
				ID = input.ReadInt32();
				break;
			case 18u:
				Icon = input.ReadString();
				break;
			case 26u:
				FlowId = input.ReadString();
				break;
			case 32u:
				Cd = input.ReadInt32();
				break;
			case 40u:
				UseCount = input.ReadInt32();
				break;
			case 48u:
			case 50u:
				param_.AddEntriesFrom(input, _repeated_param_codec);
				break;
			}
		}
	}
}
