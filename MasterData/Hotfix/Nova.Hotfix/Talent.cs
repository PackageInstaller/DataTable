using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Talent : IMessage<Talent>, IMessage, IEquatable<Talent>, IDeepCloneable<Talent>
{
	private static readonly MessageParser<Talent> _parser = new MessageParser<Talent>(() => new Talent());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int IndexFieldNumber = 2;

	private int index_;

	public const int TitleFieldNumber = 3;

	private string title_ = "";

	public const int GroupIdFieldNumber = 4;

	private int groupId_;

	public const int TypeFieldNumber = 5;

	private int type_;

	public const int SubTypeFieldNumber = 6;

	private int subType_;

	public const int SortFieldNumber = 7;

	private int sort_;

	public const int NodesFieldNumber = 8;

	private int nodes_;

	public const int EffectIdFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_effectId_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> effectId_ = new RepeatedField<int>();

	public const int EnhanceSkillIdFieldNumber = 10;

	private int enhanceSkillId_;

	public const int EnhanceSkillLevelFieldNumber = 11;

	private int enhanceSkillLevel_;

	public const int EnhancePotentialIdFieldNumber = 12;

	private int enhancePotentialId_;

	public const int EnhancePotentialLevelFieldNumber = 13;

	private int enhancePotentialLevel_;

	public const int DescFieldNumber = 14;

	private string desc_ = "";

	public const int IconFieldNumber = 15;

	private string icon_ = "";

	public const int Param1FieldNumber = 16;

	private string param1_ = "";

	public const int Param2FieldNumber = 17;

	private string param2_ = "";

	public const int Param3FieldNumber = 18;

	private string param3_ = "";

	public const int Param4FieldNumber = 19;

	private string param4_ = "";

	public const int Param5FieldNumber = 20;

	private string param5_ = "";

	public const int Param6FieldNumber = 21;

	private string param6_ = "";

	public const int Param7FieldNumber = 22;

	private string param7_ = "";

	public const int Param8FieldNumber = 23;

	private string param8_ = "";

	public const int Param9FieldNumber = 24;

	private string param9_ = "";

	public const int Param10FieldNumber = 25;

	private string param10_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<Talent> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(916);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Index
	{
		get
		{
			return index_;
		}
		set
		{
			index_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SubType
	{
		get
		{
			return subType_;
		}
		set
		{
			subType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Sort
	{
		get
		{
			return sort_;
		}
		set
		{
			sort_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Nodes
	{
		get
		{
			return nodes_;
		}
		set
		{
			nodes_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> EffectId => effectId_;

	[DebuggerNonUserCode]
	public int EnhanceSkillId
	{
		get
		{
			return enhanceSkillId_;
		}
		set
		{
			enhanceSkillId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EnhanceSkillLevel
	{
		get
		{
			return enhanceSkillLevel_;
		}
		set
		{
			enhanceSkillLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EnhancePotentialId
	{
		get
		{
			return enhancePotentialId_;
		}
		set
		{
			enhancePotentialId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EnhancePotentialLevel
	{
		get
		{
			return enhancePotentialLevel_;
		}
		set
		{
			enhancePotentialLevel_ = value;
		}
	}

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
	public string Param1
	{
		get
		{
			return param1_;
		}
		set
		{
			param1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param2
	{
		get
		{
			return param2_;
		}
		set
		{
			param2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param3
	{
		get
		{
			return param3_;
		}
		set
		{
			param3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param4
	{
		get
		{
			return param4_;
		}
		set
		{
			param4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param5
	{
		get
		{
			return param5_;
		}
		set
		{
			param5_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param6
	{
		get
		{
			return param6_;
		}
		set
		{
			param6_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param7
	{
		get
		{
			return param7_;
		}
		set
		{
			param7_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param8
	{
		get
		{
			return param8_;
		}
		set
		{
			param8_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param9
	{
		get
		{
			return param9_;
		}
		set
		{
			param9_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param10
	{
		get
		{
			return param10_;
		}
		set
		{
			param10_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public Talent()
	{
	}

	[DebuggerNonUserCode]
	public Talent(Talent other)
		: this()
	{
		id_ = other.id_;
		index_ = other.index_;
		title_ = other.title_;
		groupId_ = other.groupId_;
		type_ = other.type_;
		subType_ = other.subType_;
		sort_ = other.sort_;
		nodes_ = other.nodes_;
		effectId_ = other.effectId_.Clone();
		enhanceSkillId_ = other.enhanceSkillId_;
		enhanceSkillLevel_ = other.enhanceSkillLevel_;
		enhancePotentialId_ = other.enhancePotentialId_;
		enhancePotentialLevel_ = other.enhancePotentialLevel_;
		desc_ = other.desc_;
		icon_ = other.icon_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
		param5_ = other.param5_;
		param6_ = other.param6_;
		param7_ = other.param7_;
		param8_ = other.param8_;
		param9_ = other.param9_;
		param10_ = other.param10_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Talent Clone()
	{
		return new Talent(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Talent);
	}

	[DebuggerNonUserCode]
	public bool Equals(Talent other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (Index != other.Index)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (SubType != other.SubType)
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (Nodes != other.Nodes)
		{
			return false;
		}
		if (!effectId_.Equals(other.effectId_))
		{
			return false;
		}
		if (EnhanceSkillId != other.EnhanceSkillId)
		{
			return false;
		}
		if (EnhanceSkillLevel != other.EnhanceSkillLevel)
		{
			return false;
		}
		if (EnhancePotentialId != other.EnhancePotentialId)
		{
			return false;
		}
		if (EnhancePotentialLevel != other.EnhancePotentialLevel)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Param1 != other.Param1)
		{
			return false;
		}
		if (Param2 != other.Param2)
		{
			return false;
		}
		if (Param3 != other.Param3)
		{
			return false;
		}
		if (Param4 != other.Param4)
		{
			return false;
		}
		if (Param5 != other.Param5)
		{
			return false;
		}
		if (Param6 != other.Param6)
		{
			return false;
		}
		if (Param7 != other.Param7)
		{
			return false;
		}
		if (Param8 != other.Param8)
		{
			return false;
		}
		if (Param9 != other.Param9)
		{
			return false;
		}
		if (Param10 != other.Param10)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Index != 0)
		{
			num ^= Index.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (SubType != 0)
		{
			num ^= SubType.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		if (Nodes != 0)
		{
			num ^= Nodes.GetHashCode();
		}
		num ^= effectId_.GetHashCode();
		if (EnhanceSkillId != 0)
		{
			num ^= EnhanceSkillId.GetHashCode();
		}
		if (EnhanceSkillLevel != 0)
		{
			num ^= EnhanceSkillLevel.GetHashCode();
		}
		if (EnhancePotentialId != 0)
		{
			num ^= EnhancePotentialId.GetHashCode();
		}
		if (EnhancePotentialLevel != 0)
		{
			num ^= EnhancePotentialLevel.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Param1.Length != 0)
		{
			num ^= Param1.GetHashCode();
		}
		if (Param2.Length != 0)
		{
			num ^= Param2.GetHashCode();
		}
		if (Param3.Length != 0)
		{
			num ^= Param3.GetHashCode();
		}
		if (Param4.Length != 0)
		{
			num ^= Param4.GetHashCode();
		}
		if (Param5.Length != 0)
		{
			num ^= Param5.GetHashCode();
		}
		if (Param6.Length != 0)
		{
			num ^= Param6.GetHashCode();
		}
		if (Param7.Length != 0)
		{
			num ^= Param7.GetHashCode();
		}
		if (Param8.Length != 0)
		{
			num ^= Param8.GetHashCode();
		}
		if (Param9.Length != 0)
		{
			num ^= Param9.GetHashCode();
		}
		if (Param10.Length != 0)
		{
			num ^= Param10.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (Index != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Index);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Title);
		}
		if (GroupId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(GroupId);
		}
		if (Type != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Type);
		}
		if (SubType != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(SubType);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Sort);
		}
		if (Nodes != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Nodes);
		}
		effectId_.WriteTo(output, _repeated_effectId_codec);
		if (EnhanceSkillId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(EnhanceSkillId);
		}
		if (EnhanceSkillLevel != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(EnhanceSkillLevel);
		}
		if (EnhancePotentialId != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(EnhancePotentialId);
		}
		if (EnhancePotentialLevel != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(EnhancePotentialLevel);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Desc);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(Icon);
		}
		if (Param1.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(Param1);
		}
		if (Param2.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(Param2);
		}
		if (Param3.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(Param3);
		}
		if (Param4.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(Param4);
		}
		if (Param5.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(Param5);
		}
		if (Param6.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(Param6);
		}
		if (Param7.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(Param7);
		}
		if (Param8.Length != 0)
		{
			output.WriteRawTag(186, 1);
			output.WriteString(Param8);
		}
		if (Param9.Length != 0)
		{
			output.WriteRawTag(194, 1);
			output.WriteString(Param9);
		}
		if (Param10.Length != 0)
		{
			output.WriteRawTag(202, 1);
			output.WriteString(Param10);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (Index != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Index);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (SubType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SubType);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (Nodes != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Nodes);
		}
		num += effectId_.CalculateSize(_repeated_effectId_codec);
		if (EnhanceSkillId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EnhanceSkillId);
		}
		if (EnhanceSkillLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EnhanceSkillLevel);
		}
		if (EnhancePotentialId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EnhancePotentialId);
		}
		if (EnhancePotentialLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EnhancePotentialLevel);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Param1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param1);
		}
		if (Param2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param2);
		}
		if (Param3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param3);
		}
		if (Param4.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param4);
		}
		if (Param5.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param5);
		}
		if (Param6.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param6);
		}
		if (Param7.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param7);
		}
		if (Param8.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param8);
		}
		if (Param9.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param9);
		}
		if (Param10.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param10);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Talent other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Index != 0)
			{
				Index = other.Index;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.SubType != 0)
			{
				SubType = other.SubType;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			if (other.Nodes != 0)
			{
				Nodes = other.Nodes;
			}
			effectId_.Add(other.effectId_);
			if (other.EnhanceSkillId != 0)
			{
				EnhanceSkillId = other.EnhanceSkillId;
			}
			if (other.EnhanceSkillLevel != 0)
			{
				EnhanceSkillLevel = other.EnhanceSkillLevel;
			}
			if (other.EnhancePotentialId != 0)
			{
				EnhancePotentialId = other.EnhancePotentialId;
			}
			if (other.EnhancePotentialLevel != 0)
			{
				EnhancePotentialLevel = other.EnhancePotentialLevel;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Param1.Length != 0)
			{
				Param1 = other.Param1;
			}
			if (other.Param2.Length != 0)
			{
				Param2 = other.Param2;
			}
			if (other.Param3.Length != 0)
			{
				Param3 = other.Param3;
			}
			if (other.Param4.Length != 0)
			{
				Param4 = other.Param4;
			}
			if (other.Param5.Length != 0)
			{
				Param5 = other.Param5;
			}
			if (other.Param6.Length != 0)
			{
				Param6 = other.Param6;
			}
			if (other.Param7.Length != 0)
			{
				Param7 = other.Param7;
			}
			if (other.Param8.Length != 0)
			{
				Param8 = other.Param8;
			}
			if (other.Param9.Length != 0)
			{
				Param9 = other.Param9;
			}
			if (other.Param10.Length != 0)
			{
				Param10 = other.Param10;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				Index = input.ReadInt32();
				break;
			case 26u:
				Title = input.ReadString();
				break;
			case 32u:
				GroupId = input.ReadInt32();
				break;
			case 40u:
				Type = input.ReadInt32();
				break;
			case 48u:
				SubType = input.ReadInt32();
				break;
			case 56u:
				Sort = input.ReadInt32();
				break;
			case 64u:
				Nodes = input.ReadInt32();
				break;
			case 72u:
			case 74u:
				effectId_.AddEntriesFrom(input, _repeated_effectId_codec);
				break;
			case 80u:
				EnhanceSkillId = input.ReadInt32();
				break;
			case 88u:
				EnhanceSkillLevel = input.ReadInt32();
				break;
			case 96u:
				EnhancePotentialId = input.ReadInt32();
				break;
			case 104u:
				EnhancePotentialLevel = input.ReadInt32();
				break;
			case 114u:
				Desc = input.ReadString();
				break;
			case 122u:
				Icon = input.ReadString();
				break;
			case 130u:
				Param1 = input.ReadString();
				break;
			case 138u:
				Param2 = input.ReadString();
				break;
			case 146u:
				Param3 = input.ReadString();
				break;
			case 154u:
				Param4 = input.ReadString();
				break;
			case 162u:
				Param5 = input.ReadString();
				break;
			case 170u:
				Param6 = input.ReadString();
				break;
			case 178u:
				Param7 = input.ReadString();
				break;
			case 186u:
				Param8 = input.ReadString();
				break;
			case 194u:
				Param9 = input.ReadString();
				break;
			case 202u:
				Param10 = input.ReadString();
				break;
			}
		}
	}
}
