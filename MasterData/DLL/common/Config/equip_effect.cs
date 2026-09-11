using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class equip_effect : IMessage<equip_effect>, IMessage, IEquatable<equip_effect>, IDeepCloneable<equip_effect>
{
	private static readonly MessageParser<equip_effect> _parser = new MessageParser<equip_effect>(() => new equip_effect());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int ParamFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_param_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> param_ = new RepeatedField<int>();

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int SpecCharFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_specChar_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> specChar_ = new RepeatedField<int>();

	public const int FlowNameFieldNumber = 5;

	private string flowName_ = "";

	public const int TimelinePathFieldNumber = 6;

	private string timelinePath_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<equip_effect> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[84];

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
	public RepeatedField<int> Param => param_;

	[DebuggerNonUserCode]
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> SpecChar => specChar_;

	[DebuggerNonUserCode]
	public string FlowName
	{
		get
		{
			return flowName_;
		}
		set
		{
			flowName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TimelinePath
	{
		get
		{
			return timelinePath_;
		}
		set
		{
			timelinePath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public equip_effect()
	{
	}

	[DebuggerNonUserCode]
	public equip_effect(equip_effect other)
		: this()
	{
		iD_ = other.iD_;
		param_ = other.param_.Clone();
		desc_ = other.desc_;
		specChar_ = other.specChar_.Clone();
		flowName_ = other.flowName_;
		timelinePath_ = other.timelinePath_;
	}

	[DebuggerNonUserCode]
	public equip_effect Clone()
	{
		return new equip_effect(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as equip_effect);
	}

	[DebuggerNonUserCode]
	public bool Equals(equip_effect other)
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
		if (!param_.Equals(other.param_))
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (!specChar_.Equals(other.specChar_))
		{
			return false;
		}
		if (FlowName != other.FlowName)
		{
			return false;
		}
		if (TimelinePath != other.TimelinePath)
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
		num ^= param_.GetHashCode();
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		num ^= specChar_.GetHashCode();
		if (FlowName.Length != 0)
		{
			num ^= FlowName.GetHashCode();
		}
		if (TimelinePath.Length != 0)
		{
			num ^= TimelinePath.GetHashCode();
		}
		return num;
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
		param_.WriteTo(output, _repeated_param_codec);
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		specChar_.WriteTo(output, _repeated_specChar_codec);
		if (FlowName.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(FlowName);
		}
		if (TimelinePath.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(TimelinePath);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		num += param_.CalculateSize(_repeated_param_codec);
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		num += specChar_.CalculateSize(_repeated_specChar_codec);
		if (FlowName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FlowName);
		}
		if (TimelinePath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TimelinePath);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(equip_effect other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			param_.Add(other.param_);
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			specChar_.Add(other.specChar_);
			if (other.FlowName.Length != 0)
			{
				FlowName = other.FlowName;
			}
			if (other.TimelinePath.Length != 0)
			{
				TimelinePath = other.TimelinePath;
			}
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
			case 16u:
			case 18u:
				param_.AddEntriesFrom(input, _repeated_param_codec);
				break;
			case 26u:
				Desc = input.ReadString();
				break;
			case 32u:
			case 34u:
				specChar_.AddEntriesFrom(input, _repeated_specChar_codec);
				break;
			case 42u:
				FlowName = input.ReadString();
				break;
			case 50u:
				TimelinePath = input.ReadString();
				break;
			}
		}
	}
}
