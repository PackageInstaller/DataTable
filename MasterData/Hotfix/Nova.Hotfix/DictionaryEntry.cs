using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DictionaryEntry : IMessage<DictionaryEntry>, IMessage, IEquatable<DictionaryEntry>, IDeepCloneable<DictionaryEntry>
{
	private static readonly MessageParser<DictionaryEntry> _parser = new MessageParser<DictionaryEntry>(() => new DictionaryEntry());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int IndexFieldNumber = 2;

	private int index_;

	public const int TitleFieldNumber = 3;

	private string title_ = "";

	public const int TabFieldNumber = 4;

	private int tab_;

	public const int ItemIdFieldNumber = 5;

	private int itemId_;

	public const int QtyFieldNumber = 6;

	private int qty_;

	public const int DiagramListFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_diagramList_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> diagramList_ = new RepeatedField<int>();

	public const int SortFieldNumber = 8;

	private int sort_;

	public const int PopupFieldNumber = 9;

	private bool popup_;

	[DebuggerNonUserCode]
	public static MessageParser<DictionaryEntry> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(266);

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
	public int Tab
	{
		get
		{
			return tab_;
		}
		set
		{
			tab_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemId
	{
		get
		{
			return itemId_;
		}
		set
		{
			itemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty
	{
		get
		{
			return qty_;
		}
		set
		{
			qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> DiagramList => diagramList_;

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
	public bool Popup
	{
		get
		{
			return popup_;
		}
		set
		{
			popup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public DictionaryEntry()
	{
	}

	[DebuggerNonUserCode]
	public DictionaryEntry(DictionaryEntry other)
		: this()
	{
		id_ = other.id_;
		index_ = other.index_;
		title_ = other.title_;
		tab_ = other.tab_;
		itemId_ = other.itemId_;
		qty_ = other.qty_;
		diagramList_ = other.diagramList_.Clone();
		sort_ = other.sort_;
		popup_ = other.popup_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DictionaryEntry Clone()
	{
		return new DictionaryEntry(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DictionaryEntry);
	}

	[DebuggerNonUserCode]
	public bool Equals(DictionaryEntry other)
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
		if (Tab != other.Tab)
		{
			return false;
		}
		if (ItemId != other.ItemId)
		{
			return false;
		}
		if (Qty != other.Qty)
		{
			return false;
		}
		if (!diagramList_.Equals(other.diagramList_))
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (Popup != other.Popup)
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
		if (Tab != 0)
		{
			num ^= Tab.GetHashCode();
		}
		if (ItemId != 0)
		{
			num ^= ItemId.GetHashCode();
		}
		if (Qty != 0)
		{
			num ^= Qty.GetHashCode();
		}
		num ^= diagramList_.GetHashCode();
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		if (Popup)
		{
			num ^= Popup.GetHashCode();
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
		if (Tab != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Tab);
		}
		if (ItemId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ItemId);
		}
		if (Qty != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Qty);
		}
		diagramList_.WriteTo(output, _repeated_diagramList_codec);
		if (Sort != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Sort);
		}
		if (Popup)
		{
			output.WriteRawTag(72);
			output.WriteBool(Popup);
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
		if (Tab != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tab);
		}
		if (ItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId);
		}
		if (Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty);
		}
		num += diagramList_.CalculateSize(_repeated_diagramList_codec);
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (Popup)
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
	public void MergeFrom(DictionaryEntry other)
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
			if (other.Tab != 0)
			{
				Tab = other.Tab;
			}
			if (other.ItemId != 0)
			{
				ItemId = other.ItemId;
			}
			if (other.Qty != 0)
			{
				Qty = other.Qty;
			}
			diagramList_.Add(other.diagramList_);
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			if (other.Popup)
			{
				Popup = other.Popup;
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
				Tab = input.ReadInt32();
				break;
			case 40u:
				ItemId = input.ReadInt32();
				break;
			case 48u:
				Qty = input.ReadInt32();
				break;
			case 56u:
			case 58u:
				diagramList_.AddEntriesFrom(input, _repeated_diagramList_codec);
				break;
			case 64u:
				Sort = input.ReadInt32();
				break;
			case 72u:
				Popup = input.ReadBool();
				break;
			}
		}
	}
}
