using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MiningTreasure : IMessage<MiningTreasure>, IMessage, IEquatable<MiningTreasure>, IDeepCloneable<MiningTreasure>
{
	private static readonly MessageParser<MiningTreasure> _parser = new MessageParser<MiningTreasure>(() => new MiningTreasure());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int IconFieldNumber = 3;

	private string icon_ = "";

	public const int SelfRotateFieldNumber = 4;

	private int selfRotate_;

	public const int NameFieldNumber = 5;

	private string name_ = "";

	public const int DesFieldNumber = 6;

	private string des_ = "";

	public const int MiningItemTypeFieldNumber = 7;

	private int miningItemType_;

	public const int MiningItemRarityFieldNumber = 8;

	private int miningItemRarity_;

	public const int ScoreFieldNumber = 9;

	private int score_;

	[DebuggerNonUserCode]
	public static MessageParser<MiningTreasure> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(564);

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
	public int SelfRotate
	{
		get
		{
			return selfRotate_;
		}
		set
		{
			selfRotate_ = value;
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
	public int MiningItemType
	{
		get
		{
			return miningItemType_;
		}
		set
		{
			miningItemType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MiningItemRarity
	{
		get
		{
			return miningItemRarity_;
		}
		set
		{
			miningItemRarity_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Score
	{
		get
		{
			return score_;
		}
		set
		{
			score_ = value;
		}
	}

	[DebuggerNonUserCode]
	public MiningTreasure()
	{
	}

	[DebuggerNonUserCode]
	public MiningTreasure(MiningTreasure other)
		: this()
	{
		id_ = other.id_;
		activityId_ = other.activityId_;
		icon_ = other.icon_;
		selfRotate_ = other.selfRotate_;
		name_ = other.name_;
		des_ = other.des_;
		miningItemType_ = other.miningItemType_;
		miningItemRarity_ = other.miningItemRarity_;
		score_ = other.score_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MiningTreasure Clone()
	{
		return new MiningTreasure(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MiningTreasure);
	}

	[DebuggerNonUserCode]
	public bool Equals(MiningTreasure other)
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
		if (Icon != other.Icon)
		{
			return false;
		}
		if (SelfRotate != other.SelfRotate)
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
		if (MiningItemType != other.MiningItemType)
		{
			return false;
		}
		if (MiningItemRarity != other.MiningItemRarity)
		{
			return false;
		}
		if (Score != other.Score)
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
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (SelfRotate != 0)
		{
			num ^= SelfRotate.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Des.Length != 0)
		{
			num ^= Des.GetHashCode();
		}
		if (MiningItemType != 0)
		{
			num ^= MiningItemType.GetHashCode();
		}
		if (MiningItemRarity != 0)
		{
			num ^= MiningItemRarity.GetHashCode();
		}
		if (Score != 0)
		{
			num ^= Score.GetHashCode();
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
		if (Icon.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Icon);
		}
		if (SelfRotate != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(SelfRotate);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Name);
		}
		if (Des.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Des);
		}
		if (MiningItemType != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(MiningItemType);
		}
		if (MiningItemRarity != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(MiningItemRarity);
		}
		if (Score != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Score);
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
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (SelfRotate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SelfRotate);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Des.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Des);
		}
		if (MiningItemType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MiningItemType);
		}
		if (MiningItemRarity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MiningItemRarity);
		}
		if (Score != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Score);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MiningTreasure other)
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
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.SelfRotate != 0)
			{
				SelfRotate = other.SelfRotate;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Des.Length != 0)
			{
				Des = other.Des;
			}
			if (other.MiningItemType != 0)
			{
				MiningItemType = other.MiningItemType;
			}
			if (other.MiningItemRarity != 0)
			{
				MiningItemRarity = other.MiningItemRarity;
			}
			if (other.Score != 0)
			{
				Score = other.Score;
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
			case 26u:
				Icon = input.ReadString();
				break;
			case 32u:
				SelfRotate = input.ReadInt32();
				break;
			case 42u:
				Name = input.ReadString();
				break;
			case 50u:
				Des = input.ReadString();
				break;
			case 56u:
				MiningItemType = input.ReadInt32();
				break;
			case 64u:
				MiningItemRarity = input.ReadInt32();
				break;
			case 72u:
				Score = input.ReadInt32();
				break;
			}
		}
	}
}
