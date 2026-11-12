using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TowerDefenseItem : IMessage<TowerDefenseItem>, IMessage, IEquatable<TowerDefenseItem>, IDeepCloneable<TowerDefenseItem>
{
	private static readonly MessageParser<TowerDefenseItem> _parser = new MessageParser<TowerDefenseItem>(() => new TowerDefenseItem());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DesFieldNumber = 3;

	private string des_ = "";

	public const int ItemTipsFieldNumber = 4;

	private string itemTips_ = "";

	public const int AmountFieldNumber = 5;

	private int amount_;

	public const int CdFieldNumber = 6;

	private int cd_;

	public const int ChargeScriptFieldNumber = 7;

	private string chargeScript_ = "";

	public const int ChargeParam1FieldNumber = 8;

	private int chargeParam1_;

	public const int ChargeParam2FieldNumber = 9;

	private int chargeParam2_;

	public const int ChargeParam3FieldNumber = 10;

	private int chargeParam3_;

	public const int ScriptFieldNumber = 11;

	private string script_ = "";

	public const int CardIconFieldNumber = 12;

	private string cardIcon_ = "";

	public const int HeadFieldNumber = 13;

	private string head_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<TowerDefenseItem> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(958);

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
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Des
	{
		get
		{
			return des_;
		}
		set
		{
			des_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ItemTips
	{
		get
		{
			return itemTips_;
		}
		set
		{
			itemTips_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Amount
	{
		get
		{
			return amount_;
		}
		set
		{
			amount_ = value;
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
	public string ChargeScript
	{
		get
		{
			return chargeScript_;
		}
		set
		{
			chargeScript_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ChargeParam1
	{
		get
		{
			return chargeParam1_;
		}
		set
		{
			chargeParam1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ChargeParam2
	{
		get
		{
			return chargeParam2_;
		}
		set
		{
			chargeParam2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ChargeParam3
	{
		get
		{
			return chargeParam3_;
		}
		set
		{
			chargeParam3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Script
	{
		get
		{
			return script_;
		}
		set
		{
			script_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CardIcon
	{
		get
		{
			return cardIcon_;
		}
		set
		{
			cardIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Head
	{
		get
		{
			return head_;
		}
		set
		{
			head_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public TowerDefenseItem()
	{
	}

	[DebuggerNonUserCode]
	public TowerDefenseItem(TowerDefenseItem other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		des_ = other.des_;
		itemTips_ = other.itemTips_;
		amount_ = other.amount_;
		cd_ = other.cd_;
		chargeScript_ = other.chargeScript_;
		chargeParam1_ = other.chargeParam1_;
		chargeParam2_ = other.chargeParam2_;
		chargeParam3_ = other.chargeParam3_;
		script_ = other.script_;
		cardIcon_ = other.cardIcon_;
		head_ = other.head_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TowerDefenseItem Clone()
	{
		return new TowerDefenseItem(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TowerDefenseItem);
	}

	[DebuggerNonUserCode]
	public bool Equals(TowerDefenseItem other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (Des != other.Des)
		{
			return false;
		}
		if (ItemTips != other.ItemTips)
		{
			return false;
		}
		if (Amount != other.Amount)
		{
			return false;
		}
		if (Cd != other.Cd)
		{
			return false;
		}
		if (ChargeScript != other.ChargeScript)
		{
			return false;
		}
		if (ChargeParam1 != other.ChargeParam1)
		{
			return false;
		}
		if (ChargeParam2 != other.ChargeParam2)
		{
			return false;
		}
		if (ChargeParam3 != other.ChargeParam3)
		{
			return false;
		}
		if (Script != other.Script)
		{
			return false;
		}
		if (CardIcon != other.CardIcon)
		{
			return false;
		}
		if (Head != other.Head)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Des.Length != 0)
		{
			num ^= Des.GetHashCode();
		}
		if (ItemTips.Length != 0)
		{
			num ^= ItemTips.GetHashCode();
		}
		if (Amount != 0)
		{
			num ^= Amount.GetHashCode();
		}
		if (Cd != 0)
		{
			num ^= Cd.GetHashCode();
		}
		if (ChargeScript.Length != 0)
		{
			num ^= ChargeScript.GetHashCode();
		}
		if (ChargeParam1 != 0)
		{
			num ^= ChargeParam1.GetHashCode();
		}
		if (ChargeParam2 != 0)
		{
			num ^= ChargeParam2.GetHashCode();
		}
		if (ChargeParam3 != 0)
		{
			num ^= ChargeParam3.GetHashCode();
		}
		if (Script.Length != 0)
		{
			num ^= Script.GetHashCode();
		}
		if (CardIcon.Length != 0)
		{
			num ^= CardIcon.GetHashCode();
		}
		if (Head.Length != 0)
		{
			num ^= Head.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (Des.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Des);
		}
		if (ItemTips.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(ItemTips);
		}
		if (Amount != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Amount);
		}
		if (Cd != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Cd);
		}
		if (ChargeScript.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(ChargeScript);
		}
		if (ChargeParam1 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ChargeParam1);
		}
		if (ChargeParam2 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(ChargeParam2);
		}
		if (ChargeParam3 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(ChargeParam3);
		}
		if (Script.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Script);
		}
		if (CardIcon.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(CardIcon);
		}
		if (Head.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Head);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Des.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Des);
		}
		if (ItemTips.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ItemTips);
		}
		if (Amount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Amount);
		}
		if (Cd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cd);
		}
		if (ChargeScript.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ChargeScript);
		}
		if (ChargeParam1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChargeParam1);
		}
		if (ChargeParam2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChargeParam2);
		}
		if (ChargeParam3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChargeParam3);
		}
		if (Script.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Script);
		}
		if (CardIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CardIcon);
		}
		if (Head.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Head);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TowerDefenseItem other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Des.Length != 0)
			{
				Des = other.Des;
			}
			if (other.ItemTips.Length != 0)
			{
				ItemTips = other.ItemTips;
			}
			if (other.Amount != 0)
			{
				Amount = other.Amount;
			}
			if (other.Cd != 0)
			{
				Cd = other.Cd;
			}
			if (other.ChargeScript.Length != 0)
			{
				ChargeScript = other.ChargeScript;
			}
			if (other.ChargeParam1 != 0)
			{
				ChargeParam1 = other.ChargeParam1;
			}
			if (other.ChargeParam2 != 0)
			{
				ChargeParam2 = other.ChargeParam2;
			}
			if (other.ChargeParam3 != 0)
			{
				ChargeParam3 = other.ChargeParam3;
			}
			if (other.Script.Length != 0)
			{
				Script = other.Script;
			}
			if (other.CardIcon.Length != 0)
			{
				CardIcon = other.CardIcon;
			}
			if (other.Head.Length != 0)
			{
				Head = other.Head;
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
				Name = input.ReadString();
				break;
			case 26u:
				Des = input.ReadString();
				break;
			case 34u:
				ItemTips = input.ReadString();
				break;
			case 40u:
				Amount = input.ReadInt32();
				break;
			case 48u:
				Cd = input.ReadInt32();
				break;
			case 58u:
				ChargeScript = input.ReadString();
				break;
			case 64u:
				ChargeParam1 = input.ReadInt32();
				break;
			case 72u:
				ChargeParam2 = input.ReadInt32();
				break;
			case 80u:
				ChargeParam3 = input.ReadInt32();
				break;
			case 90u:
				Script = input.ReadString();
				break;
			case 98u:
				CardIcon = input.ReadString();
				break;
			case 106u:
				Head = input.ReadString();
				break;
			}
		}
	}
}
