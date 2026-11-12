using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TowerDefenseGuide : IMessage<TowerDefenseGuide>, IMessage, IEquatable<TowerDefenseGuide>, IDeepCloneable<TowerDefenseGuide>
{
	private static readonly MessageParser<TowerDefenseGuide> _parser = new MessageParser<TowerDefenseGuide>(() => new TowerDefenseGuide());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int GuideTypeFieldNumber = 3;

	private int guideType_;

	public const int ObjectIdFieldNumber = 4;

	private int objectId_;

	public const int StrFieldNumber = 5;

	private string str_ = "";

	public const int LevelIdFieldNumber = 6;

	private int levelId_;

	public const int IsShowFieldNumber = 7;

	private bool isShow_;

	[DebuggerNonUserCode]
	public static MessageParser<TowerDefenseGuide> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(956);

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
	public int GuideType
	{
		get
		{
			return guideType_;
		}
		set
		{
			guideType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ObjectId
	{
		get
		{
			return objectId_;
		}
		set
		{
			objectId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Str
	{
		get
		{
			return str_;
		}
		set
		{
			str_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int LevelId
	{
		get
		{
			return levelId_;
		}
		set
		{
			levelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsShow
	{
		get
		{
			return isShow_;
		}
		set
		{
			isShow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TowerDefenseGuide()
	{
	}

	[DebuggerNonUserCode]
	public TowerDefenseGuide(TowerDefenseGuide other)
		: this()
	{
		id_ = other.id_;
		activityId_ = other.activityId_;
		guideType_ = other.guideType_;
		objectId_ = other.objectId_;
		str_ = other.str_;
		levelId_ = other.levelId_;
		isShow_ = other.isShow_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TowerDefenseGuide Clone()
	{
		return new TowerDefenseGuide(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TowerDefenseGuide);
	}

	[DebuggerNonUserCode]
	public bool Equals(TowerDefenseGuide other)
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
		if (GuideType != other.GuideType)
		{
			return false;
		}
		if (ObjectId != other.ObjectId)
		{
			return false;
		}
		if (Str != other.Str)
		{
			return false;
		}
		if (LevelId != other.LevelId)
		{
			return false;
		}
		if (IsShow != other.IsShow)
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
		if (GuideType != 0)
		{
			num ^= GuideType.GetHashCode();
		}
		if (ObjectId != 0)
		{
			num ^= ObjectId.GetHashCode();
		}
		if (Str.Length != 0)
		{
			num ^= Str.GetHashCode();
		}
		if (LevelId != 0)
		{
			num ^= LevelId.GetHashCode();
		}
		if (IsShow)
		{
			num ^= IsShow.GetHashCode();
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
		if (GuideType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(GuideType);
		}
		if (ObjectId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ObjectId);
		}
		if (Str.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Str);
		}
		if (LevelId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(LevelId);
		}
		if (IsShow)
		{
			output.WriteRawTag(56);
			output.WriteBool(IsShow);
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
		if (GuideType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GuideType);
		}
		if (ObjectId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ObjectId);
		}
		if (Str.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Str);
		}
		if (LevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelId);
		}
		if (IsShow)
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
	public void MergeFrom(TowerDefenseGuide other)
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
			if (other.GuideType != 0)
			{
				GuideType = other.GuideType;
			}
			if (other.ObjectId != 0)
			{
				ObjectId = other.ObjectId;
			}
			if (other.Str.Length != 0)
			{
				Str = other.Str;
			}
			if (other.LevelId != 0)
			{
				LevelId = other.LevelId;
			}
			if (other.IsShow)
			{
				IsShow = other.IsShow;
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
				GuideType = input.ReadInt32();
				break;
			case 32u:
				ObjectId = input.ReadInt32();
				break;
			case 42u:
				Str = input.ReadString();
				break;
			case 48u:
				LevelId = input.ReadInt32();
				break;
			case 56u:
				IsShow = input.ReadBool();
				break;
			}
		}
	}
}
