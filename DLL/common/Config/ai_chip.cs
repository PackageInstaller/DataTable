using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class ai_chip : IMessage<ai_chip>, IMessage, IEquatable<ai_chip>, IDeepCloneable<ai_chip>
{
	private static readonly MessageParser<ai_chip> _parser = new MessageParser<ai_chip>(() => new ai_chip());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int TypeIdFieldNumber = 2;

	private int typeId_;

	public const int SpecCharFieldNumber = 3;

	private int specChar_;

	public const int SuitNameFieldNumber = 4;

	private string suitName_ = "";

	public const int PictureIdFieldNumber = 5;

	private string pictureId_ = "";

	public const int PortraitFieldNumber = 6;

	private string portrait_ = "";

	public const int NewConditionFieldNumber = 7;

	private int newCondition_;

	public const int CostConditionFieldNumber = 8;

	private static readonly FieldCodec<IntArray> _repeated_costCondition_codec = FieldCodec.ForMessage(66u, IntArray.Parser);

	private readonly RepeatedField<IntArray> costCondition_ = new RepeatedField<IntArray>();

	public const int FlowNameFieldNumber = 9;

	private static readonly FieldCodec<string> _repeated_flowName_codec = FieldCodec.ForString(74u);

	private readonly RepeatedField<string> flowName_ = new RepeatedField<string>();

	public const int DescFieldNumber = 10;

	private string desc_ = "";

	public const int ProfileFieldNumber = 11;

	private string profile_ = "";

	public const int StoryFieldNumber = 12;

	private string story_ = "";

	public const int CooldownFirstFieldNumber = 13;

	private int cooldownFirst_;

	public const int CooldownComFieldNumber = 14;

	private int cooldownCom_;

	[DebuggerNonUserCode]
	public static MessageParser<ai_chip> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[77];

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
	public int TypeId
	{
		get
		{
			return typeId_;
		}
		set
		{
			typeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SpecChar
	{
		get
		{
			return specChar_;
		}
		set
		{
			specChar_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string SuitName
	{
		get
		{
			return suitName_;
		}
		set
		{
			suitName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PictureId
	{
		get
		{
			return pictureId_;
		}
		set
		{
			pictureId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Portrait
	{
		get
		{
			return portrait_;
		}
		set
		{
			portrait_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int NewCondition
	{
		get
		{
			return newCondition_;
		}
		set
		{
			newCondition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<IntArray> CostCondition => costCondition_;

	[DebuggerNonUserCode]
	public RepeatedField<string> FlowName => flowName_;

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
	public string Profile
	{
		get
		{
			return profile_;
		}
		set
		{
			profile_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Story
	{
		get
		{
			return story_;
		}
		set
		{
			story_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int CooldownFirst
	{
		get
		{
			return cooldownFirst_;
		}
		set
		{
			cooldownFirst_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CooldownCom
	{
		get
		{
			return cooldownCom_;
		}
		set
		{
			cooldownCom_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ai_chip()
	{
	}

	[DebuggerNonUserCode]
	public ai_chip(ai_chip other)
		: this()
	{
		iD_ = other.iD_;
		typeId_ = other.typeId_;
		specChar_ = other.specChar_;
		suitName_ = other.suitName_;
		pictureId_ = other.pictureId_;
		portrait_ = other.portrait_;
		newCondition_ = other.newCondition_;
		costCondition_ = other.costCondition_.Clone();
		flowName_ = other.flowName_.Clone();
		desc_ = other.desc_;
		profile_ = other.profile_;
		story_ = other.story_;
		cooldownFirst_ = other.cooldownFirst_;
		cooldownCom_ = other.cooldownCom_;
	}

	[DebuggerNonUserCode]
	public ai_chip Clone()
	{
		return new ai_chip(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ai_chip);
	}

	[DebuggerNonUserCode]
	public bool Equals(ai_chip other)
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
		if (TypeId != other.TypeId)
		{
			return false;
		}
		if (SpecChar != other.SpecChar)
		{
			return false;
		}
		if (SuitName != other.SuitName)
		{
			return false;
		}
		if (PictureId != other.PictureId)
		{
			return false;
		}
		if (Portrait != other.Portrait)
		{
			return false;
		}
		if (NewCondition != other.NewCondition)
		{
			return false;
		}
		if (!costCondition_.Equals(other.costCondition_))
		{
			return false;
		}
		if (!flowName_.Equals(other.flowName_))
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Profile != other.Profile)
		{
			return false;
		}
		if (Story != other.Story)
		{
			return false;
		}
		if (CooldownFirst != other.CooldownFirst)
		{
			return false;
		}
		if (CooldownCom != other.CooldownCom)
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
		if (TypeId != 0)
		{
			num ^= TypeId.GetHashCode();
		}
		if (SpecChar != 0)
		{
			num ^= SpecChar.GetHashCode();
		}
		if (SuitName.Length != 0)
		{
			num ^= SuitName.GetHashCode();
		}
		if (PictureId.Length != 0)
		{
			num ^= PictureId.GetHashCode();
		}
		if (Portrait.Length != 0)
		{
			num ^= Portrait.GetHashCode();
		}
		if (NewCondition != 0)
		{
			num ^= NewCondition.GetHashCode();
		}
		num ^= costCondition_.GetHashCode();
		num ^= flowName_.GetHashCode();
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Profile.Length != 0)
		{
			num ^= Profile.GetHashCode();
		}
		if (Story.Length != 0)
		{
			num ^= Story.GetHashCode();
		}
		if (CooldownFirst != 0)
		{
			num ^= CooldownFirst.GetHashCode();
		}
		if (CooldownCom != 0)
		{
			num ^= CooldownCom.GetHashCode();
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
		if (TypeId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TypeId);
		}
		if (SpecChar != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(SpecChar);
		}
		if (SuitName.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(SuitName);
		}
		if (PictureId.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(PictureId);
		}
		if (Portrait.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Portrait);
		}
		if (NewCondition != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(NewCondition);
		}
		costCondition_.WriteTo(output, _repeated_costCondition_codec);
		flowName_.WriteTo(output, _repeated_flowName_codec);
		if (Desc.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Desc);
		}
		if (Profile.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Profile);
		}
		if (Story.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Story);
		}
		if (CooldownFirst != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(CooldownFirst);
		}
		if (CooldownCom != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(CooldownCom);
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
		if (TypeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TypeId);
		}
		if (SpecChar != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpecChar);
		}
		if (SuitName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SuitName);
		}
		if (PictureId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PictureId);
		}
		if (Portrait.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Portrait);
		}
		if (NewCondition != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NewCondition);
		}
		num += costCondition_.CalculateSize(_repeated_costCondition_codec);
		num += flowName_.CalculateSize(_repeated_flowName_codec);
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Profile.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Profile);
		}
		if (Story.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Story);
		}
		if (CooldownFirst != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CooldownFirst);
		}
		if (CooldownCom != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CooldownCom);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ai_chip other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.TypeId != 0)
			{
				TypeId = other.TypeId;
			}
			if (other.SpecChar != 0)
			{
				SpecChar = other.SpecChar;
			}
			if (other.SuitName.Length != 0)
			{
				SuitName = other.SuitName;
			}
			if (other.PictureId.Length != 0)
			{
				PictureId = other.PictureId;
			}
			if (other.Portrait.Length != 0)
			{
				Portrait = other.Portrait;
			}
			if (other.NewCondition != 0)
			{
				NewCondition = other.NewCondition;
			}
			costCondition_.Add(other.costCondition_);
			flowName_.Add(other.flowName_);
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Profile.Length != 0)
			{
				Profile = other.Profile;
			}
			if (other.Story.Length != 0)
			{
				Story = other.Story;
			}
			if (other.CooldownFirst != 0)
			{
				CooldownFirst = other.CooldownFirst;
			}
			if (other.CooldownCom != 0)
			{
				CooldownCom = other.CooldownCom;
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
				TypeId = input.ReadInt32();
				break;
			case 24u:
				SpecChar = input.ReadInt32();
				break;
			case 34u:
				SuitName = input.ReadString();
				break;
			case 42u:
				PictureId = input.ReadString();
				break;
			case 50u:
				Portrait = input.ReadString();
				break;
			case 56u:
				NewCondition = input.ReadInt32();
				break;
			case 66u:
				costCondition_.AddEntriesFrom(input, _repeated_costCondition_codec);
				break;
			case 74u:
				flowName_.AddEntriesFrom(input, _repeated_flowName_codec);
				break;
			case 82u:
				Desc = input.ReadString();
				break;
			case 90u:
				Profile = input.ReadString();
				break;
			case 98u:
				Story = input.ReadString();
				break;
			case 104u:
				CooldownFirst = input.ReadInt32();
				break;
			case 112u:
				CooldownCom = input.ReadInt32();
				break;
			}
		}
	}
}
