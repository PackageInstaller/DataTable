using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityStoryEvidence : IMessage<ActivityStoryEvidence>, IMessage, IEquatable<ActivityStoryEvidence>, IDeepCloneable<ActivityStoryEvidence>
{
	private static readonly MessageParser<ActivityStoryEvidence> _parser = new MessageParser<ActivityStoryEvidence>(() => new ActivityStoryEvidence());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int EvIdFieldNumber = 2;

	private string evId_ = "";

	public const int ActivityIdFieldNumber = 3;

	private int activityId_;

	public const int CommentFieldNumber = 4;

	private string comment_ = "";

	public const int NameFieldNumber = 5;

	private string name_ = "";

	public const int DescFieldNumber = 6;

	private string desc_ = "";

	public const int IconFieldNumber = 7;

	private string icon_ = "";

	public const int IconBgFieldNumber = 8;

	private string iconBg_ = "";

	public const int VisibleFieldNumber = 9;

	private int visible_;

	[DebuggerNonUserCode]
	public static MessageParser<ActivityStoryEvidence> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(64);

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
	public string EvId
	{
		get
		{
			return evId_;
		}
		set
		{
			evId_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string Comment
	{
		get
		{
			return comment_;
		}
		set
		{
			comment_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string IconBg
	{
		get
		{
			return iconBg_;
		}
		set
		{
			iconBg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Visible
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
	public ActivityStoryEvidence()
	{
	}

	[DebuggerNonUserCode]
	public ActivityStoryEvidence(ActivityStoryEvidence other)
		: this()
	{
		id_ = other.id_;
		evId_ = other.evId_;
		activityId_ = other.activityId_;
		comment_ = other.comment_;
		name_ = other.name_;
		desc_ = other.desc_;
		icon_ = other.icon_;
		iconBg_ = other.iconBg_;
		visible_ = other.visible_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityStoryEvidence Clone()
	{
		return new ActivityStoryEvidence(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityStoryEvidence);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityStoryEvidence other)
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
		if (EvId != other.EvId)
		{
			return false;
		}
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (Comment != other.Comment)
		{
			return false;
		}
		if (Name != other.Name)
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
		if (IconBg != other.IconBg)
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
		if (EvId.Length != 0)
		{
			num ^= EvId.GetHashCode();
		}
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (Comment.Length != 0)
		{
			num ^= Comment.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (IconBg.Length != 0)
		{
			num ^= IconBg.GetHashCode();
		}
		if (Visible != 0)
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
		if (EvId.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(EvId);
		}
		if (ActivityId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ActivityId);
		}
		if (Comment.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Comment);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Desc);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Icon);
		}
		if (IconBg.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(IconBg);
		}
		if (Visible != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Visible);
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
		if (EvId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EvId);
		}
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (Comment.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Comment);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (IconBg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconBg);
		}
		if (Visible != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Visible);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityStoryEvidence other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.EvId.Length != 0)
			{
				EvId = other.EvId;
			}
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.Comment.Length != 0)
			{
				Comment = other.Comment;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.IconBg.Length != 0)
			{
				IconBg = other.IconBg;
			}
			if (other.Visible != 0)
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
				EvId = input.ReadString();
				break;
			case 24u:
				ActivityId = input.ReadInt32();
				break;
			case 34u:
				Comment = input.ReadString();
				break;
			case 42u:
				Name = input.ReadString();
				break;
			case 50u:
				Desc = input.ReadString();
				break;
			case 58u:
				Icon = input.ReadString();
				break;
			case 66u:
				IconBg = input.ReadString();
				break;
			case 72u:
				Visible = input.ReadInt32();
				break;
			}
		}
	}
}
