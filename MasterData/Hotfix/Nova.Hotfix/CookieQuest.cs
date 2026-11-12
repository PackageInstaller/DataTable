using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CookieQuest : IMessage<CookieQuest>, IMessage, IEquatable<CookieQuest>, IDeepCloneable<CookieQuest>
{
	private static readonly MessageParser<CookieQuest> _parser = new MessageParser<CookieQuest>(() => new CookieQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int CookieQuestLabelFieldNumber = 3;

	private int cookieQuestLabel_;

	public const int CookieQuestNameFieldNumber = 4;

	private string cookieQuestName_ = "";

	public const int TitleFieldNumber = 5;

	private string title_ = "";

	public const int DescFieldNumber = 6;

	private string desc_ = "";

	public const int RarityFieldNumber = 7;

	private int rarity_;

	public const int HideFieldNumber = 8;

	private bool hide_;

	public const int CompleteCondFieldNumber = 9;

	private int completeCond_;

	public const int CompleteCondParamsFieldNumber = 10;

	private string completeCondParams_ = "";

	public const int Reward1TidFieldNumber = 11;

	private int reward1Tid_;

	public const int Reward1QtyFieldNumber = 12;

	private int reward1Qty_;

	public const int Reward2TidFieldNumber = 13;

	private int reward2Tid_;

	public const int Reward2QtyFieldNumber = 14;

	private int reward2Qty_;

	[DebuggerNonUserCode]
	public static MessageParser<CookieQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(224);

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
	public int ActivityId
	{
		get
		{
			return activityId_;
		}
		set
		{
			activityId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CookieQuestLabel
	{
		get
		{
			return cookieQuestLabel_;
		}
		set
		{
			cookieQuestLabel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string CookieQuestName
	{
		get
		{
			return cookieQuestName_;
		}
		set
		{
			cookieQuestName_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int Reward1Tid
	{
		get
		{
			return reward1Tid_;
		}
		set
		{
			reward1Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward1Qty
	{
		get
		{
			return reward1Qty_;
		}
		set
		{
			reward1Qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward2Tid
	{
		get
		{
			return reward2Tid_;
		}
		set
		{
			reward2Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward2Qty
	{
		get
		{
			return reward2Qty_;
		}
		set
		{
			reward2Qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CookieQuest()
	{
	}

	[DebuggerNonUserCode]
	public CookieQuest(CookieQuest other)
		: this()
	{
		id_ = other.id_;
		activityId_ = other.activityId_;
		cookieQuestLabel_ = other.cookieQuestLabel_;
		cookieQuestName_ = other.cookieQuestName_;
		title_ = other.title_;
		desc_ = other.desc_;
		rarity_ = other.rarity_;
		hide_ = other.hide_;
		completeCond_ = other.completeCond_;
		completeCondParams_ = other.completeCondParams_;
		reward1Tid_ = other.reward1Tid_;
		reward1Qty_ = other.reward1Qty_;
		reward2Tid_ = other.reward2Tid_;
		reward2Qty_ = other.reward2Qty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CookieQuest Clone()
	{
		return new CookieQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CookieQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(CookieQuest other)
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
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (CookieQuestLabel != other.CookieQuestLabel)
		{
			return false;
		}
		if (CookieQuestName != other.CookieQuestName)
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
		if (Hide != other.Hide)
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
		if (Reward1Tid != other.Reward1Tid)
		{
			return false;
		}
		if (Reward1Qty != other.Reward1Qty)
		{
			return false;
		}
		if (Reward2Tid != other.Reward2Tid)
		{
			return false;
		}
		if (Reward2Qty != other.Reward2Qty)
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
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (CookieQuestLabel != 0)
		{
			num ^= CookieQuestLabel.GetHashCode();
		}
		if (CookieQuestName.Length != 0)
		{
			num ^= CookieQuestName.GetHashCode();
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
		if (Hide)
		{
			num ^= Hide.GetHashCode();
		}
		if (CompleteCond != 0)
		{
			num ^= CompleteCond.GetHashCode();
		}
		if (CompleteCondParams.Length != 0)
		{
			num ^= CompleteCondParams.GetHashCode();
		}
		if (Reward1Tid != 0)
		{
			num ^= Reward1Tid.GetHashCode();
		}
		if (Reward1Qty != 0)
		{
			num ^= Reward1Qty.GetHashCode();
		}
		if (Reward2Tid != 0)
		{
			num ^= Reward2Tid.GetHashCode();
		}
		if (Reward2Qty != 0)
		{
			num ^= Reward2Qty.GetHashCode();
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
		if (ActivityId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ActivityId);
		}
		if (CookieQuestLabel != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CookieQuestLabel);
		}
		if (CookieQuestName.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(CookieQuestName);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Title);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Desc);
		}
		if (Rarity != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Rarity);
		}
		if (Hide)
		{
			output.WriteRawTag(64);
			output.WriteBool(Hide);
		}
		if (CompleteCond != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(CompleteCond);
		}
		if (CompleteCondParams.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(CompleteCondParams);
		}
		if (Reward1Tid != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Reward1Tid);
		}
		if (Reward1Qty != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Reward1Qty);
		}
		if (Reward2Tid != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(Reward2Tid);
		}
		if (Reward2Qty != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(Reward2Qty);
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
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (CookieQuestLabel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CookieQuestLabel);
		}
		if (CookieQuestName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CookieQuestName);
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
		if (Hide)
		{
			num += 2;
		}
		if (CompleteCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompleteCond);
		}
		if (CompleteCondParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CompleteCondParams);
		}
		if (Reward1Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1Tid);
		}
		if (Reward1Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1Qty);
		}
		if (Reward2Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward2Tid);
		}
		if (Reward2Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward2Qty);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CookieQuest other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.CookieQuestLabel != 0)
			{
				CookieQuestLabel = other.CookieQuestLabel;
			}
			if (other.CookieQuestName.Length != 0)
			{
				CookieQuestName = other.CookieQuestName;
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
			if (other.Hide)
			{
				Hide = other.Hide;
			}
			if (other.CompleteCond != 0)
			{
				CompleteCond = other.CompleteCond;
			}
			if (other.CompleteCondParams.Length != 0)
			{
				CompleteCondParams = other.CompleteCondParams;
			}
			if (other.Reward1Tid != 0)
			{
				Reward1Tid = other.Reward1Tid;
			}
			if (other.Reward1Qty != 0)
			{
				Reward1Qty = other.Reward1Qty;
			}
			if (other.Reward2Tid != 0)
			{
				Reward2Tid = other.Reward2Tid;
			}
			if (other.Reward2Qty != 0)
			{
				Reward2Qty = other.Reward2Qty;
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
				ActivityId = input.ReadInt32();
				break;
			case 24u:
				CookieQuestLabel = input.ReadInt32();
				break;
			case 34u:
				CookieQuestName = input.ReadString();
				break;
			case 42u:
				Title = input.ReadString();
				break;
			case 50u:
				Desc = input.ReadString();
				break;
			case 56u:
				Rarity = input.ReadInt32();
				break;
			case 64u:
				Hide = input.ReadBool();
				break;
			case 72u:
				CompleteCond = input.ReadInt32();
				break;
			case 82u:
				CompleteCondParams = input.ReadString();
				break;
			case 88u:
				Reward1Tid = input.ReadInt32();
				break;
			case 96u:
				Reward1Qty = input.ReadInt32();
				break;
			case 104u:
				Reward2Tid = input.ReadInt32();
				break;
			case 112u:
				Reward2Qty = input.ReadInt32();
				break;
			}
		}
	}
}
