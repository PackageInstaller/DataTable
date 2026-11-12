using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DictionaryTab : IMessage<DictionaryTab>, IMessage, IEquatable<DictionaryTab>, IDeepCloneable<DictionaryTab>
{
	private static readonly MessageParser<DictionaryTab> _parser = new MessageParser<DictionaryTab>(() => new DictionaryTab());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int IconFieldNumber = 2;

	private string icon_ = "";

	public const int Icon2FieldNumber = 3;

	private string icon2_ = "";

	public const int TitleFieldNumber = 4;

	private string title_ = "";

	public const int HideInBattleFieldNumber = 5;

	private bool hideInBattle_;

	[DebuggerNonUserCode]
	public static MessageParser<DictionaryTab> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(268);

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
	public bool HideInBattle
	{
		get
		{
			return hideInBattle_;
		}
		set
		{
			hideInBattle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public DictionaryTab()
	{
	}

	[DebuggerNonUserCode]
	public DictionaryTab(DictionaryTab other)
		: this()
	{
		id_ = other.id_;
		icon_ = other.icon_;
		icon2_ = other.icon2_;
		title_ = other.title_;
		hideInBattle_ = other.hideInBattle_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DictionaryTab Clone()
	{
		return new DictionaryTab(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DictionaryTab);
	}

	[DebuggerNonUserCode]
	public bool Equals(DictionaryTab other)
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
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Icon2 != other.Icon2)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (HideInBattle != other.HideInBattle)
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
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Icon2.Length != 0)
		{
			num ^= Icon2.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (HideInBattle)
		{
			num ^= HideInBattle.GetHashCode();
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
		if (Icon.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Icon);
		}
		if (Icon2.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Icon2);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Title);
		}
		if (HideInBattle)
		{
			output.WriteRawTag(40);
			output.WriteBool(HideInBattle);
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
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Icon2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon2);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (HideInBattle)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DictionaryTab other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Icon2.Length != 0)
			{
				Icon2 = other.Icon2;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.HideInBattle)
			{
				HideInBattle = other.HideInBattle;
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
				Icon = input.ReadString();
				break;
			case 26u:
				Icon2 = input.ReadString();
				break;
			case 34u:
				Title = input.ReadString();
				break;
			case 40u:
				HideInBattle = input.ReadBool();
				break;
			}
		}
	}
}
