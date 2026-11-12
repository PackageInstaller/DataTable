using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StoryPreview : IMessage<StoryPreview>, IMessage, IEquatable<StoryPreview>, IDeepCloneable<StoryPreview>
{
	private static readonly MessageParser<StoryPreview> _parser = new MessageParser<StoryPreview>(() => new StoryPreview());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TypeFieldNumber = 2;

	private int type_;

	public const int StoryIdFieldNumber = 3;

	private int storyId_;

	public const int ShowTimeFieldNumber = 4;

	private string showTime_ = "";

	public const int TitleFieldNumber = 5;

	private string title_ = "";

	public const int IconFieldNumber = 6;

	private string icon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<StoryPreview> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(900);

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
	public int StoryId
	{
		get
		{
			return storyId_;
		}
		set
		{
			storyId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ShowTime
	{
		get
		{
			return showTime_;
		}
		set
		{
			showTime_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public StoryPreview()
	{
	}

	[DebuggerNonUserCode]
	public StoryPreview(StoryPreview other)
		: this()
	{
		id_ = other.id_;
		type_ = other.type_;
		storyId_ = other.storyId_;
		showTime_ = other.showTime_;
		title_ = other.title_;
		icon_ = other.icon_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StoryPreview Clone()
	{
		return new StoryPreview(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StoryPreview);
	}

	[DebuggerNonUserCode]
	public bool Equals(StoryPreview other)
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
		if (Type != other.Type)
		{
			return false;
		}
		if (StoryId != other.StoryId)
		{
			return false;
		}
		if (ShowTime != other.ShowTime)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (Icon != other.Icon)
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
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (StoryId != 0)
		{
			num ^= StoryId.GetHashCode();
		}
		if (ShowTime.Length != 0)
		{
			num ^= ShowTime.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
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
		if (Type != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Type);
		}
		if (StoryId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(StoryId);
		}
		if (ShowTime.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(ShowTime);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Title);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Icon);
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
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (StoryId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StoryId);
		}
		if (ShowTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ShowTime);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StoryPreview other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.StoryId != 0)
			{
				StoryId = other.StoryId;
			}
			if (other.ShowTime.Length != 0)
			{
				ShowTime = other.ShowTime;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
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
				Type = input.ReadInt32();
				break;
			case 24u:
				StoryId = input.ReadInt32();
				break;
			case 34u:
				ShowTime = input.ReadString();
				break;
			case 42u:
				Title = input.ReadString();
				break;
			case 50u:
				Icon = input.ReadString();
				break;
			}
		}
	}
}
