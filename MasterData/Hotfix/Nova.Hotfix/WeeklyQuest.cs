using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class WeeklyQuest : IMessage<WeeklyQuest>, IMessage, IEquatable<WeeklyQuest>, IDeepCloneable<WeeklyQuest>
{
	private static readonly MessageParser<WeeklyQuest> _parser = new MessageParser<WeeklyQuest>(() => new WeeklyQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int JumpToFieldNumber = 4;

	private int jumpTo_;

	public const int ActiveFieldNumber = 5;

	private int active_;

	public const int OrderFieldNumber = 6;

	private int order_;

	public const int PrerequisitesFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_prerequisites_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> prerequisites_ = new RepeatedField<int>();

	public const int ApearFieldNumber = 8;

	private bool apear_;

	public const int AcceptParams2FieldNumber = 9;

	private string acceptParams2_ = "";

	public const int CompleteCondFieldNumber = 10;

	private int completeCond_;

	public const int CompleteCondParamsFieldNumber = 11;

	private string completeCondParams_ = "";

	public const int CompleteCondClientFieldNumber = 12;

	private int completeCondClient_;

	public const int ClientCompleteParams1FieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_clientCompleteParams1_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> clientCompleteParams1_ = new RepeatedField<int>();

	public const int ClientCompleteParams2FieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_clientCompleteParams2_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> clientCompleteParams2_ = new RepeatedField<int>();

	public const int ItemTidFieldNumber = 15;

	private int itemTid_;

	public const int ItemQtyFieldNumber = 16;

	private int itemQty_;

	[DebuggerNonUserCode]
	public static MessageParser<WeeklyQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1082);

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
	public int Active
	{
		get
		{
			return active_;
		}
		set
		{
			active_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Order
	{
		get
		{
			return order_;
		}
		set
		{
			order_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Prerequisites => prerequisites_;

	[DebuggerNonUserCode]
	public bool Apear
	{
		get
		{
			return apear_;
		}
		set
		{
			apear_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string AcceptParams2
	{
		get
		{
			return acceptParams2_;
		}
		set
		{
			acceptParams2_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string CompleteCondParams
	{
		get
		{
			return completeCondParams_;
		}
		set
		{
			completeCondParams_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public RepeatedField<int> ClientCompleteParams1 => clientCompleteParams1_;

	[DebuggerNonUserCode]
	public RepeatedField<int> ClientCompleteParams2 => clientCompleteParams2_;

	[DebuggerNonUserCode]
	public int ItemTid
	{
		get
		{
			return itemTid_;
		}
		set
		{
			itemTid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemQty
	{
		get
		{
			return itemQty_;
		}
		set
		{
			itemQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public WeeklyQuest()
	{
	}

	[DebuggerNonUserCode]
	public WeeklyQuest(WeeklyQuest other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		desc_ = other.desc_;
		jumpTo_ = other.jumpTo_;
		active_ = other.active_;
		order_ = other.order_;
		prerequisites_ = other.prerequisites_.Clone();
		apear_ = other.apear_;
		acceptParams2_ = other.acceptParams2_;
		completeCond_ = other.completeCond_;
		completeCondParams_ = other.completeCondParams_;
		completeCondClient_ = other.completeCondClient_;
		clientCompleteParams1_ = other.clientCompleteParams1_.Clone();
		clientCompleteParams2_ = other.clientCompleteParams2_.Clone();
		itemTid_ = other.itemTid_;
		itemQty_ = other.itemQty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public WeeklyQuest Clone()
	{
		return new WeeklyQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as WeeklyQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(WeeklyQuest other)
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
		if (Title != other.Title)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (JumpTo != other.JumpTo)
		{
			return false;
		}
		if (Active != other.Active)
		{
			return false;
		}
		if (Order != other.Order)
		{
			return false;
		}
		if (!prerequisites_.Equals(other.prerequisites_))
		{
			return false;
		}
		if (Apear != other.Apear)
		{
			return false;
		}
		if (AcceptParams2 != other.AcceptParams2)
		{
			return false;
		}
		if (CompleteCond != other.CompleteCond)
		{
			return false;
		}
		if (CompleteCondParams != other.CompleteCondParams)
		{
			return false;
		}
		if (CompleteCondClient != other.CompleteCondClient)
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
		if (ItemTid != other.ItemTid)
		{
			return false;
		}
		if (ItemQty != other.ItemQty)
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
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (JumpTo != 0)
		{
			num ^= JumpTo.GetHashCode();
		}
		if (Active != 0)
		{
			num ^= Active.GetHashCode();
		}
		if (Order != 0)
		{
			num ^= Order.GetHashCode();
		}
		num ^= prerequisites_.GetHashCode();
		if (Apear)
		{
			num ^= Apear.GetHashCode();
		}
		if (AcceptParams2.Length != 0)
		{
			num ^= AcceptParams2.GetHashCode();
		}
		if (CompleteCond != 0)
		{
			num ^= CompleteCond.GetHashCode();
		}
		if (CompleteCondParams.Length != 0)
		{
			num ^= CompleteCondParams.GetHashCode();
		}
		if (CompleteCondClient != 0)
		{
			num ^= CompleteCondClient.GetHashCode();
		}
		num ^= clientCompleteParams1_.GetHashCode();
		num ^= clientCompleteParams2_.GetHashCode();
		if (ItemTid != 0)
		{
			num ^= ItemTid.GetHashCode();
		}
		if (ItemQty != 0)
		{
			num ^= ItemQty.GetHashCode();
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
		if (Title.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Title);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		if (JumpTo != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(JumpTo);
		}
		if (Active != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Active);
		}
		if (Order != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Order);
		}
		prerequisites_.WriteTo(output, _repeated_prerequisites_codec);
		if (Apear)
		{
			output.WriteRawTag(64);
			output.WriteBool(Apear);
		}
		if (AcceptParams2.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(AcceptParams2);
		}
		if (CompleteCond != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(CompleteCond);
		}
		if (CompleteCondParams.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(CompleteCondParams);
		}
		if (CompleteCondClient != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(CompleteCondClient);
		}
		clientCompleteParams1_.WriteTo(output, _repeated_clientCompleteParams1_codec);
		clientCompleteParams2_.WriteTo(output, _repeated_clientCompleteParams2_codec);
		if (ItemTid != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(ItemTid);
		}
		if (ItemQty != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(ItemQty);
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
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (JumpTo != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(JumpTo);
		}
		if (Active != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Active);
		}
		if (Order != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Order);
		}
		num += prerequisites_.CalculateSize(_repeated_prerequisites_codec);
		if (Apear)
		{
			num += 2;
		}
		if (AcceptParams2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AcceptParams2);
		}
		if (CompleteCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompleteCond);
		}
		if (CompleteCondParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CompleteCondParams);
		}
		if (CompleteCondClient != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompleteCondClient);
		}
		num += clientCompleteParams1_.CalculateSize(_repeated_clientCompleteParams1_codec);
		num += clientCompleteParams2_.CalculateSize(_repeated_clientCompleteParams2_codec);
		if (ItemTid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemTid);
		}
		if (ItemQty != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ItemQty);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(WeeklyQuest other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.JumpTo != 0)
			{
				JumpTo = other.JumpTo;
			}
			if (other.Active != 0)
			{
				Active = other.Active;
			}
			if (other.Order != 0)
			{
				Order = other.Order;
			}
			prerequisites_.Add(other.prerequisites_);
			if (other.Apear)
			{
				Apear = other.Apear;
			}
			if (other.AcceptParams2.Length != 0)
			{
				AcceptParams2 = other.AcceptParams2;
			}
			if (other.CompleteCond != 0)
			{
				CompleteCond = other.CompleteCond;
			}
			if (other.CompleteCondParams.Length != 0)
			{
				CompleteCondParams = other.CompleteCondParams;
			}
			if (other.CompleteCondClient != 0)
			{
				CompleteCondClient = other.CompleteCondClient;
			}
			clientCompleteParams1_.Add(other.clientCompleteParams1_);
			clientCompleteParams2_.Add(other.clientCompleteParams2_);
			if (other.ItemTid != 0)
			{
				ItemTid = other.ItemTid;
			}
			if (other.ItemQty != 0)
			{
				ItemQty = other.ItemQty;
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
			case 18u:
				Title = input.ReadString();
				break;
			case 26u:
				Desc = input.ReadString();
				break;
			case 32u:
				JumpTo = input.ReadInt32();
				break;
			case 40u:
				Active = input.ReadInt32();
				break;
			case 48u:
				Order = input.ReadInt32();
				break;
			case 56u:
			case 58u:
				prerequisites_.AddEntriesFrom(input, _repeated_prerequisites_codec);
				break;
			case 64u:
				Apear = input.ReadBool();
				break;
			case 74u:
				AcceptParams2 = input.ReadString();
				break;
			case 80u:
				CompleteCond = input.ReadInt32();
				break;
			case 90u:
				CompleteCondParams = input.ReadString();
				break;
			case 96u:
				CompleteCondClient = input.ReadInt32();
				break;
			case 104u:
			case 106u:
				clientCompleteParams1_.AddEntriesFrom(input, _repeated_clientCompleteParams1_codec);
				break;
			case 112u:
			case 114u:
				clientCompleteParams2_.AddEntriesFrom(input, _repeated_clientCompleteParams2_codec);
				break;
			case 120u:
				ItemTid = input.ReadInt32();
				break;
			case 128u:
				ItemQty = input.ReadInt32();
				break;
			}
		}
	}
}
