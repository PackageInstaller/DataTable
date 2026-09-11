using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class weapon_effect : IMessage<weapon_effect>, IMessage, IEquatable<weapon_effect>, IDeepCloneable<weapon_effect>
{
	private static readonly MessageParser<weapon_effect> _parser = new MessageParser<weapon_effect>(() => new weapon_effect());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int DescriptionFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_description_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> description_ = new RepeatedField<int>();

	public const int LevelParamFieldNumber = 3;

	private static readonly FieldCodec<IntArray> _repeated_levelParam_codec = FieldCodec.ForMessage(26u, IntArray.Parser);

	private readonly RepeatedField<IntArray> levelParam_ = new RepeatedField<IntArray>();

	public const int SpecCharFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_specChar_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> specChar_ = new RepeatedField<int>();

	public const int FlowNameFieldNumber = 5;

	private static readonly FieldCodec<string> _repeated_flowName_codec = FieldCodec.ForString(42u);

	private readonly RepeatedField<string> flowName_ = new RepeatedField<string>();

	public const int TimelinePathFieldNumber = 6;

	private string timelinePath_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<weapon_effect> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[93];

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
	public RepeatedField<int> Description => description_;

	[DebuggerNonUserCode]
	public RepeatedField<IntArray> LevelParam => levelParam_;

	[DebuggerNonUserCode]
	public RepeatedField<int> SpecChar => specChar_;

	[DebuggerNonUserCode]
	public RepeatedField<string> FlowName => flowName_;

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
	public weapon_effect()
	{
	}

	[DebuggerNonUserCode]
	public weapon_effect(weapon_effect other)
		: this()
	{
		iD_ = other.iD_;
		description_ = other.description_.Clone();
		levelParam_ = other.levelParam_.Clone();
		specChar_ = other.specChar_.Clone();
		flowName_ = other.flowName_.Clone();
		timelinePath_ = other.timelinePath_;
	}

	[DebuggerNonUserCode]
	public weapon_effect Clone()
	{
		return new weapon_effect(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as weapon_effect);
	}

	[DebuggerNonUserCode]
	public bool Equals(weapon_effect other)
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
		if (!description_.Equals(other.description_))
		{
			return false;
		}
		if (!levelParam_.Equals(other.levelParam_))
		{
			return false;
		}
		if (!specChar_.Equals(other.specChar_))
		{
			return false;
		}
		if (!flowName_.Equals(other.flowName_))
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
		num ^= description_.GetHashCode();
		num ^= levelParam_.GetHashCode();
		num ^= specChar_.GetHashCode();
		num ^= flowName_.GetHashCode();
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
		description_.WriteTo(output, _repeated_description_codec);
		levelParam_.WriteTo(output, _repeated_levelParam_codec);
		specChar_.WriteTo(output, _repeated_specChar_codec);
		flowName_.WriteTo(output, _repeated_flowName_codec);
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
		num += description_.CalculateSize(_repeated_description_codec);
		num += levelParam_.CalculateSize(_repeated_levelParam_codec);
		num += specChar_.CalculateSize(_repeated_specChar_codec);
		num += flowName_.CalculateSize(_repeated_flowName_codec);
		if (TimelinePath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TimelinePath);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(weapon_effect other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			description_.Add(other.description_);
			levelParam_.Add(other.levelParam_);
			specChar_.Add(other.specChar_);
			flowName_.Add(other.flowName_);
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
				description_.AddEntriesFrom(input, _repeated_description_codec);
				break;
			case 26u:
				levelParam_.AddEntriesFrom(input, _repeated_levelParam_codec);
				break;
			case 32u:
			case 34u:
				specChar_.AddEntriesFrom(input, _repeated_specChar_codec);
				break;
			case 42u:
				flowName_.AddEntriesFrom(input, _repeated_flowName_codec);
				break;
			case 50u:
				TimelinePath = input.ReadString();
				break;
			}
		}
	}
}
