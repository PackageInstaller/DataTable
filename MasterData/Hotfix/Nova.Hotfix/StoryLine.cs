using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StoryLine : IMessage<StoryLine>, IMessage, IEquatable<StoryLine>, IDeepCloneable<StoryLine>
{
	private static readonly MessageParser<StoryLine> _parser = new MessageParser<StoryLine>(() => new StoryLine());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleMainFieldNumber = 2;

	private string titleMain_ = "";

	public const int TitleSubFieldNumber = 3;

	private string titleSub_ = "";

	public const int IconFieldNumber = 4;

	private string icon_ = "";

	public const int SortIndexFieldNumber = 5;

	private int sortIndex_;

	public const int VisibleFieldNumber = 6;

	private bool visible_;

	[DebuggerNonUserCode]
	public static MessageParser<StoryLine> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(896);

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
	public string TitleMain
	{
		get
		{
			return titleMain_;
		}
		set
		{
			titleMain_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TitleSub
	{
		get
		{
			return titleSub_;
		}
		set
		{
			titleSub_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int SortIndex
	{
		get
		{
			return sortIndex_;
		}
		set
		{
			sortIndex_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Visible
	{
		get
		{
			return visible_;
		}
		set
		{
			visible_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StoryLine()
	{
	}

	[DebuggerNonUserCode]
	public StoryLine(StoryLine other)
		: this()
	{
		id_ = other.id_;
		titleMain_ = other.titleMain_;
		titleSub_ = other.titleSub_;
		icon_ = other.icon_;
		sortIndex_ = other.sortIndex_;
		visible_ = other.visible_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StoryLine Clone()
	{
		return new StoryLine(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StoryLine);
	}

	[DebuggerNonUserCode]
	public bool Equals(StoryLine other)
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
		if (TitleMain != other.TitleMain)
		{
			return false;
		}
		if (TitleSub != other.TitleSub)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (SortIndex != other.SortIndex)
		{
			return false;
		}
		if (Visible != other.Visible)
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
		if (TitleMain.Length != 0)
		{
			num ^= TitleMain.GetHashCode();
		}
		if (TitleSub.Length != 0)
		{
			num ^= TitleSub.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (SortIndex != 0)
		{
			num ^= SortIndex.GetHashCode();
		}
		if (Visible)
		{
			num ^= Visible.GetHashCode();
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
		if (TitleMain.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(TitleMain);
		}
		if (TitleSub.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(TitleSub);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Icon);
		}
		if (SortIndex != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(SortIndex);
		}
		if (Visible)
		{
			output.WriteRawTag(48);
			output.WriteBool(Visible);
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
		if (TitleMain.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TitleMain);
		}
		if (TitleSub.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TitleSub);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (SortIndex != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SortIndex);
		}
		if (Visible)
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
	public void MergeFrom(StoryLine other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.TitleMain.Length != 0)
			{
				TitleMain = other.TitleMain;
			}
			if (other.TitleSub.Length != 0)
			{
				TitleSub = other.TitleSub;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.SortIndex != 0)
			{
				SortIndex = other.SortIndex;
			}
			if (other.Visible)
			{
				Visible = other.Visible;
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
				TitleMain = input.ReadString();
				break;
			case 26u:
				TitleSub = input.ReadString();
				break;
			case 34u:
				Icon = input.ReadString();
				break;
			case 40u:
				SortIndex = input.ReadInt32();
				break;
			case 48u:
				Visible = input.ReadBool();
				break;
			}
		}
	}
}
