using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Achievement : IMessage<Achievement>, IMessage, IEquatable<Achievement>, IDeepCloneable<Achievement>
{
	private static readonly MessageParser<Achievement> _parser = new MessageParser<Achievement>(() => new Achievement());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int AchieveIdFieldNumber = 2;

	private int achieveId_;

	public const int TitleFieldNumber = 3;

	private string title_ = "";

	public const int DescFieldNumber = 4;

	private string desc_ = "";

	public const int RarityFieldNumber = 5;

	private int rarity_;

	public const int TypeFieldNumber = 6;

	private int type_;

	public const int HideFieldNumber = 7;

	private bool hide_;

	public const int JumpToFieldNumber = 8;

	private int jumpTo_;

	public const int CompleteCondFieldNumber = 9;

	private int completeCond_;

	public const int CompleteCondClientFieldNumber = 10;

	private int completeCondClient_;

	public const int AimNumShowFieldNumber = 11;

	private int aimNumShow_;

	public const int PrerequisitesFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_prerequisites_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> prerequisites_ = new RepeatedField<int>();

	public const int LevelTypeFieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_levelType_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> levelType_ = new RepeatedField<int>();

	public const int ClientCompleteParams1FieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_clientCompleteParams1_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> clientCompleteParams1_ = new RepeatedField<int>();

	public const int ClientCompleteParams2FieldNumber = 15;

	private static readonly FieldCodec<int> _repeated_clientCompleteParams2_codec = FieldCodec.ForInt32(122u);

	private readonly RepeatedField<int> clientCompleteParams2_ = new RepeatedField<int>();

	public const int Tid1FieldNumber = 16;

	private int tid1_;

	public const int Qty1FieldNumber = 17;

	private int qty1_;

	public const int Tid2FieldNumber = 18;

	private int tid2_;

	public const int Qty2FieldNumber = 19;

	private int qty2_;

	public const int Tid3FieldNumber = 20;

	private int tid3_;

	public const int Qty3FieldNumber = 21;

	private int qty3_;

	[DebuggerNonUserCode]
	public static MessageParser<Achievement> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(0);

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
	public int AchieveId
	{
		get
		{
			return achieveId_;
		}
		set
		{
			achieveId_ = value;
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
	public int Rarity
	{
		get
		{
			return rarity_;
		}
		set
		{
			rarity_ = value;
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
	public bool Hide
	{
		get
		{
			return hide_;
		}
		set
		{
			hide_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int JumpTo
	{
		get
		{
			return jumpTo_;
		}
		set
		{
			jumpTo_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CompleteCond
	{
		get
		{
			return completeCond_;
		}
		set
		{
			completeCond_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CompleteCondClient
	{
		get
		{
			return completeCondClient_;
		}
		set
		{
			completeCondClient_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AimNumShow
	{
		get
		{
			return aimNumShow_;
		}
		set
		{
			aimNumShow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Prerequisites => prerequisites_;

	[DebuggerNonUserCode]
	public RepeatedField<int> LevelType => levelType_;

	[DebuggerNonUserCode]
	public RepeatedField<int> ClientCompleteParams1 => clientCompleteParams1_;

	[DebuggerNonUserCode]
	public RepeatedField<int> ClientCompleteParams2 => clientCompleteParams2_;

	[DebuggerNonUserCode]
	public int Tid1
	{
		get
		{
			return tid1_;
		}
		set
		{
			tid1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty1
	{
		get
		{
			return qty1_;
		}
		set
		{
			qty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Tid2
	{
		get
		{
			return tid2_;
		}
		set
		{
			tid2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty2
	{
		get
		{
			return qty2_;
		}
		set
		{
			qty2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Tid3
	{
		get
		{
			return tid3_;
		}
		set
		{
			tid3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty3
	{
		get
		{
			return qty3_;
		}
		set
		{
			qty3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Achievement()
	{
	}

	[DebuggerNonUserCode]
	public Achievement(Achievement other)
		: this()
	{
		id_ = other.id_;
		achieveId_ = other.achieveId_;
		title_ = other.title_;
		desc_ = other.desc_;
		rarity_ = other.rarity_;
		type_ = other.type_;
		hide_ = other.hide_;
		jumpTo_ = other.jumpTo_;
		completeCond_ = other.completeCond_;
		completeCondClient_ = other.completeCondClient_;
		aimNumShow_ = other.aimNumShow_;
		prerequisites_ = other.prerequisites_.Clone();
		levelType_ = other.levelType_.Clone();
		clientCompleteParams1_ = other.clientCompleteParams1_.Clone();
		clientCompleteParams2_ = other.clientCompleteParams2_.Clone();
		tid1_ = other.tid1_;
		qty1_ = other.qty1_;
		tid2_ = other.tid2_;
		qty2_ = other.qty2_;
		tid3_ = other.tid3_;
		qty3_ = other.qty3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Achievement Clone()
	{
		return new Achievement(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Achievement);
	}

	[DebuggerNonUserCode]
	public bool Equals(Achievement other)
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
		if (AchieveId != other.AchieveId)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Rarity != other.Rarity)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Hide != other.Hide)
		{
			return false;
		}
		if (JumpTo != other.JumpTo)
		{
			return false;
		}
		if (CompleteCond != other.CompleteCond)
		{
			return false;
		}
		if (CompleteCondClient != other.CompleteCondClient)
		{
			return false;
		}
		if (AimNumShow != other.AimNumShow)
		{
			return false;
		}
		if (!prerequisites_.Equals(other.prerequisites_))
		{
			return false;
		}
		if (!levelType_.Equals(other.levelType_))
		{
			return false;
		}
		if (!clientCompleteParams1_.Equals(other.clientCompleteParams1_))
		{
			return false;
		}
		if (!clientCompleteParams2_.Equals(other.clientCompleteParams2_))
		{
			return false;
		}
		if (Tid1 != other.Tid1)
		{
			return false;
		}
		if (Qty1 != other.Qty1)
		{
			return false;
		}
		if (Tid2 != other.Tid2)
		{
			return false;
		}
		if (Qty2 != other.Qty2)
		{
			return false;
		}
		if (Tid3 != other.Tid3)
		{
			return false;
		}
		if (Qty3 != other.Qty3)
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
		if (AchieveId != 0)
		{
			num ^= AchieveId.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Rarity != 0)
		{
			num ^= Rarity.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Hide)
		{
			num ^= Hide.GetHashCode();
		}
		if (JumpTo != 0)
		{
			num ^= JumpTo.GetHashCode();
		}
		if (CompleteCond != 0)
		{
			num ^= CompleteCond.GetHashCode();
		}
		if (CompleteCondClient != 0)
		{
			num ^= CompleteCondClient.GetHashCode();
		}
		if (AimNumShow != 0)
		{
			num ^= AimNumShow.GetHashCode();
		}
		num ^= prerequisites_.GetHashCode();
		num ^= levelType_.GetHashCode();
		num ^= clientCompleteParams1_.GetHashCode();
		num ^= clientCompleteParams2_.GetHashCode();
		if (Tid1 != 0)
		{
			num ^= Tid1.GetHashCode();
		}
		if (Qty1 != 0)
		{
			num ^= Qty1.GetHashCode();
		}
		if (Tid2 != 0)
		{
			num ^= Tid2.GetHashCode();
		}
		if (Qty2 != 0)
		{
			num ^= Qty2.GetHashCode();
		}
		if (Tid3 != 0)
		{
			num ^= Tid3.GetHashCode();
		}
		if (Qty3 != 0)
		{
			num ^= Qty3.GetHashCode();
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
		if (AchieveId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(AchieveId);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Title);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Desc);
		}
		if (Rarity != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Rarity);
		}
		if (Type != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Type);
		}
		if (Hide)
		{
			output.WriteRawTag(56);
			output.WriteBool(Hide);
		}
		if (JumpTo != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(JumpTo);
		}
		if (CompleteCond != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(CompleteCond);
		}
		if (CompleteCondClient != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(CompleteCondClient);
		}
		if (AimNumShow != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(AimNumShow);
		}
		prerequisites_.WriteTo(output, _repeated_prerequisites_codec);
		levelType_.WriteTo(output, _repeated_levelType_codec);
		clientCompleteParams1_.WriteTo(output, _repeated_clientCompleteParams1_codec);
		clientCompleteParams2_.WriteTo(output, _repeated_clientCompleteParams2_codec);
		if (Tid1 != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(Tid1);
		}
		if (Qty1 != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(Qty1);
		}
		if (Tid2 != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(Tid2);
		}
		if (Qty2 != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(Qty2);
		}
		if (Tid3 != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(Tid3);
		}
		if (Qty3 != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(Qty3);
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
		if (AchieveId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AchieveId);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Rarity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rarity);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Hide)
		{
			num += 2;
		}
		if (JumpTo != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(JumpTo);
		}
		if (CompleteCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompleteCond);
		}
		if (CompleteCondClient != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompleteCondClient);
		}
		if (AimNumShow != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AimNumShow);
		}
		num += prerequisites_.CalculateSize(_repeated_prerequisites_codec);
		num += levelType_.CalculateSize(_repeated_levelType_codec);
		num += clientCompleteParams1_.CalculateSize(_repeated_clientCompleteParams1_codec);
		num += clientCompleteParams2_.CalculateSize(_repeated_clientCompleteParams2_codec);
		if (Tid1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Tid1);
		}
		if (Qty1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Qty1);
		}
		if (Tid2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Tid2);
		}
		if (Qty2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Qty2);
		}
		if (Tid3 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Tid3);
		}
		if (Qty3 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Qty3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Achievement other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.AchieveId != 0)
			{
				AchieveId = other.AchieveId;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Rarity != 0)
			{
				Rarity = other.Rarity;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Hide)
			{
				Hide = other.Hide;
			}
			if (other.JumpTo != 0)
			{
				JumpTo = other.JumpTo;
			}
			if (other.CompleteCond != 0)
			{
				CompleteCond = other.CompleteCond;
			}
			if (other.CompleteCondClient != 0)
			{
				CompleteCondClient = other.CompleteCondClient;
			}
			if (other.AimNumShow != 0)
			{
				AimNumShow = other.AimNumShow;
			}
			prerequisites_.Add(other.prerequisites_);
			levelType_.Add(other.levelType_);
			clientCompleteParams1_.Add(other.clientCompleteParams1_);
			clientCompleteParams2_.Add(other.clientCompleteParams2_);
			if (other.Tid1 != 0)
			{
				Tid1 = other.Tid1;
			}
			if (other.Qty1 != 0)
			{
				Qty1 = other.Qty1;
			}
			if (other.Tid2 != 0)
			{
				Tid2 = other.Tid2;
			}
			if (other.Qty2 != 0)
			{
				Qty2 = other.Qty2;
			}
			if (other.Tid3 != 0)
			{
				Tid3 = other.Tid3;
			}
			if (other.Qty3 != 0)
			{
				Qty3 = other.Qty3;
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
				AchieveId = input.ReadInt32();
				break;
			case 26u:
				Title = input.ReadString();
				break;
			case 34u:
				Desc = input.ReadString();
				break;
			case 40u:
				Rarity = input.ReadInt32();
				break;
			case 48u:
				Type = input.ReadInt32();
				break;
			case 56u:
				Hide = input.ReadBool();
				break;
			case 64u:
				JumpTo = input.ReadInt32();
				break;
			case 72u:
				CompleteCond = input.ReadInt32();
				break;
			case 80u:
				CompleteCondClient = input.ReadInt32();
				break;
			case 88u:
				AimNumShow = input.ReadInt32();
				break;
			case 96u:
			case 98u:
				prerequisites_.AddEntriesFrom(input, _repeated_prerequisites_codec);
				break;
			case 104u:
			case 106u:
				levelType_.AddEntriesFrom(input, _repeated_levelType_codec);
				break;
			case 112u:
			case 114u:
				clientCompleteParams1_.AddEntriesFrom(input, _repeated_clientCompleteParams1_codec);
				break;
			case 120u:
			case 122u:
				clientCompleteParams2_.AddEntriesFrom(input, _repeated_clientCompleteParams2_codec);
				break;
			case 128u:
				Tid1 = input.ReadInt32();
				break;
			case 136u:
				Qty1 = input.ReadInt32();
				break;
			case 144u:
				Tid2 = input.ReadInt32();
				break;
			case 152u:
				Qty2 = input.ReadInt32();
				break;
			case 160u:
				Tid3 = input.ReadInt32();
				break;
			case 168u:
				Qty3 = input.ReadInt32();
				break;
			}
		}
	}
}
