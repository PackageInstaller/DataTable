using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Item : IMessage<Item>, IMessage, IEquatable<Item>, IDeepCloneable<Item>
{
	private static readonly MessageParser<Item> _parser = new MessageParser<Item>(() => new Item());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int LiteraryFieldNumber = 4;

	private string literary_ = "";

	public const int TypeFieldNumber = 5;

	private int type_;

	public const int StypeFieldNumber = 6;

	private int stype_;

	public const int RarityFieldNumber = 7;

	private int rarity_;

	public const int StackFieldNumber = 8;

	private bool stack_;

	public const int PositionLimitFieldNumber = 9;

	private int positionLimit_;

	public const int ExpireTypeFieldNumber = 10;

	private int expireType_;

	public const int ExpireDateFieldNumber = 11;

	private string expireDate_ = "";

	public const int UseModeFieldNumber = 12;

	private int useMode_;

	public const int UseActionFieldNumber = 13;

	private int useAction_;

	public const int UseArgsFieldNumber = 14;

	private string useArgs_ = "";

	public const int DisplayFieldNumber = 15;

	private bool display_;

	public const int DisHavingFieldNumber = 16;

	private bool disHaving_;

	public const int ObtainWaysFieldNumber = 17;

	private string obtainWays_ = "";

	public const int JumpToFieldNumber = 18;

	private static readonly FieldCodec<int> _repeated_jumpTo_codec = FieldCodec.ForInt32(146u);

	private readonly RepeatedField<int> jumpTo_ = new RepeatedField<int>();

	public const int IconFieldNumber = 19;

	private string icon_ = "";

	public const int Icon2FieldNumber = 20;

	private string icon2_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<Item> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(466);

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
	public string Literary
	{
		get
		{
			return literary_;
		}
		set
		{
			literary_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int Stype
	{
		get
		{
			return stype_;
		}
		set
		{
			stype_ = value;
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
	public bool Stack
	{
		get
		{
			return stack_;
		}
		set
		{
			stack_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PositionLimit
	{
		get
		{
			return positionLimit_;
		}
		set
		{
			positionLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ExpireType
	{
		get
		{
			return expireType_;
		}
		set
		{
			expireType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ExpireDate
	{
		get
		{
			return expireDate_;
		}
		set
		{
			expireDate_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int UseMode
	{
		get
		{
			return useMode_;
		}
		set
		{
			useMode_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UseAction
	{
		get
		{
			return useAction_;
		}
		set
		{
			useAction_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string UseArgs
	{
		get
		{
			return useArgs_;
		}
		set
		{
			useArgs_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool Display
	{
		get
		{
			return display_;
		}
		set
		{
			display_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool DisHaving
	{
		get
		{
			return disHaving_;
		}
		set
		{
			disHaving_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ObtainWays
	{
		get
		{
			return obtainWays_;
		}
		set
		{
			obtainWays_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> JumpTo => jumpTo_;

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
	public string Icon2
	{
		get
		{
			return icon2_;
		}
		set
		{
			icon2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public Item()
	{
	}

	[DebuggerNonUserCode]
	public Item(Item other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		desc_ = other.desc_;
		literary_ = other.literary_;
		type_ = other.type_;
		stype_ = other.stype_;
		rarity_ = other.rarity_;
		stack_ = other.stack_;
		positionLimit_ = other.positionLimit_;
		expireType_ = other.expireType_;
		expireDate_ = other.expireDate_;
		useMode_ = other.useMode_;
		useAction_ = other.useAction_;
		useArgs_ = other.useArgs_;
		display_ = other.display_;
		disHaving_ = other.disHaving_;
		obtainWays_ = other.obtainWays_;
		jumpTo_ = other.jumpTo_.Clone();
		icon_ = other.icon_;
		icon2_ = other.icon2_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Item Clone()
	{
		return new Item(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Item);
	}

	[DebuggerNonUserCode]
	public bool Equals(Item other)
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
		if (Literary != other.Literary)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Stype != other.Stype)
		{
			return false;
		}
		if (Rarity != other.Rarity)
		{
			return false;
		}
		if (Stack != other.Stack)
		{
			return false;
		}
		if (PositionLimit != other.PositionLimit)
		{
			return false;
		}
		if (ExpireType != other.ExpireType)
		{
			return false;
		}
		if (ExpireDate != other.ExpireDate)
		{
			return false;
		}
		if (UseMode != other.UseMode)
		{
			return false;
		}
		if (UseAction != other.UseAction)
		{
			return false;
		}
		if (UseArgs != other.UseArgs)
		{
			return false;
		}
		if (Display != other.Display)
		{
			return false;
		}
		if (DisHaving != other.DisHaving)
		{
			return false;
		}
		if (ObtainWays != other.ObtainWays)
		{
			return false;
		}
		if (!jumpTo_.Equals(other.jumpTo_))
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Icon2 != other.Icon2)
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
		if (Literary.Length != 0)
		{
			num ^= Literary.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Stype != 0)
		{
			num ^= Stype.GetHashCode();
		}
		if (Rarity != 0)
		{
			num ^= Rarity.GetHashCode();
		}
		if (Stack)
		{
			num ^= Stack.GetHashCode();
		}
		if (PositionLimit != 0)
		{
			num ^= PositionLimit.GetHashCode();
		}
		if (ExpireType != 0)
		{
			num ^= ExpireType.GetHashCode();
		}
		if (ExpireDate.Length != 0)
		{
			num ^= ExpireDate.GetHashCode();
		}
		if (UseMode != 0)
		{
			num ^= UseMode.GetHashCode();
		}
		if (UseAction != 0)
		{
			num ^= UseAction.GetHashCode();
		}
		if (UseArgs.Length != 0)
		{
			num ^= UseArgs.GetHashCode();
		}
		if (Display)
		{
			num ^= Display.GetHashCode();
		}
		if (DisHaving)
		{
			num ^= DisHaving.GetHashCode();
		}
		if (ObtainWays.Length != 0)
		{
			num ^= ObtainWays.GetHashCode();
		}
		num ^= jumpTo_.GetHashCode();
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Icon2.Length != 0)
		{
			num ^= Icon2.GetHashCode();
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
		if (Literary.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Literary);
		}
		if (Type != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Type);
		}
		if (Stype != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Stype);
		}
		if (Rarity != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Rarity);
		}
		if (Stack)
		{
			output.WriteRawTag(64);
			output.WriteBool(Stack);
		}
		if (PositionLimit != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(PositionLimit);
		}
		if (ExpireType != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(ExpireType);
		}
		if (ExpireDate.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(ExpireDate);
		}
		if (UseMode != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(UseMode);
		}
		if (UseAction != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(UseAction);
		}
		if (UseArgs.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(UseArgs);
		}
		if (Display)
		{
			output.WriteRawTag(120);
			output.WriteBool(Display);
		}
		if (DisHaving)
		{
			output.WriteRawTag(128, 1);
			output.WriteBool(DisHaving);
		}
		if (ObtainWays.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(ObtainWays);
		}
		jumpTo_.WriteTo(output, _repeated_jumpTo_codec);
		if (Icon.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(Icon);
		}
		if (Icon2.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(Icon2);
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
		if (Literary.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Literary);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Stype != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Stype);
		}
		if (Rarity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rarity);
		}
		if (Stack)
		{
			num += 2;
		}
		if (PositionLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PositionLimit);
		}
		if (ExpireType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ExpireType);
		}
		if (ExpireDate.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ExpireDate);
		}
		if (UseMode != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UseMode);
		}
		if (UseAction != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UseAction);
		}
		if (UseArgs.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UseArgs);
		}
		if (Display)
		{
			num += 2;
		}
		if (DisHaving)
		{
			num += 3;
		}
		if (ObtainWays.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(ObtainWays);
		}
		num += jumpTo_.CalculateSize(_repeated_jumpTo_codec);
		if (Icon.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Icon2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Icon2);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Item other)
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
			if (other.Literary.Length != 0)
			{
				Literary = other.Literary;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Stype != 0)
			{
				Stype = other.Stype;
			}
			if (other.Rarity != 0)
			{
				Rarity = other.Rarity;
			}
			if (other.Stack)
			{
				Stack = other.Stack;
			}
			if (other.PositionLimit != 0)
			{
				PositionLimit = other.PositionLimit;
			}
			if (other.ExpireType != 0)
			{
				ExpireType = other.ExpireType;
			}
			if (other.ExpireDate.Length != 0)
			{
				ExpireDate = other.ExpireDate;
			}
			if (other.UseMode != 0)
			{
				UseMode = other.UseMode;
			}
			if (other.UseAction != 0)
			{
				UseAction = other.UseAction;
			}
			if (other.UseArgs.Length != 0)
			{
				UseArgs = other.UseArgs;
			}
			if (other.Display)
			{
				Display = other.Display;
			}
			if (other.DisHaving)
			{
				DisHaving = other.DisHaving;
			}
			if (other.ObtainWays.Length != 0)
			{
				ObtainWays = other.ObtainWays;
			}
			jumpTo_.Add(other.jumpTo_);
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Icon2.Length != 0)
			{
				Icon2 = other.Icon2;
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
			case 34u:
				Literary = input.ReadString();
				break;
			case 40u:
				Type = input.ReadInt32();
				break;
			case 48u:
				Stype = input.ReadInt32();
				break;
			case 56u:
				Rarity = input.ReadInt32();
				break;
			case 64u:
				Stack = input.ReadBool();
				break;
			case 72u:
				PositionLimit = input.ReadInt32();
				break;
			case 80u:
				ExpireType = input.ReadInt32();
				break;
			case 90u:
				ExpireDate = input.ReadString();
				break;
			case 96u:
				UseMode = input.ReadInt32();
				break;
			case 104u:
				UseAction = input.ReadInt32();
				break;
			case 114u:
				UseArgs = input.ReadString();
				break;
			case 120u:
				Display = input.ReadBool();
				break;
			case 128u:
				DisHaving = input.ReadBool();
				break;
			case 138u:
				ObtainWays = input.ReadString();
				break;
			case 144u:
			case 146u:
				jumpTo_.AddEntriesFrom(input, _repeated_jumpTo_codec);
				break;
			case 154u:
				Icon = input.ReadString();
				break;
			case 162u:
				Icon2 = input.ReadString();
				break;
			}
		}
	}
}
