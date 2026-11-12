using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TutorialLevel : IMessage<TutorialLevel>, IMessage, IEquatable<TutorialLevel>, IDeepCloneable<TutorialLevel>
{
	private static readonly MessageParser<TutorialLevel> _parser = new MessageParser<TutorialLevel>(() => new TutorialLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TutorialTypeFieldNumber = 2;

	private int tutorialType_;

	public const int TitleFieldNumber = 3;

	private string title_ = "";

	public const int TutorialBuildFieldNumber = 4;

	private int tutorialBuild_;

	public const int FloorIdFieldNumber = 5;

	private int floorId_;

	public const int PreLevelIdFieldNumber = 6;

	private int preLevelId_;

	public const int WorldClassFieldNumber = 7;

	private int worldClass_;

	public const int Item1FieldNumber = 8;

	private int item1_;

	public const int Qty1FieldNumber = 9;

	private int qty1_;

	[DebuggerNonUserCode]
	public static MessageParser<TutorialLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1040);

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
	public int TutorialType
	{
		get
		{
			return tutorialType_;
		}
		set
		{
			tutorialType_ = value;
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
	public int TutorialBuild
	{
		get
		{
			return tutorialBuild_;
		}
		set
		{
			tutorialBuild_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FloorId
	{
		get
		{
			return floorId_;
		}
		set
		{
			floorId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PreLevelId
	{
		get
		{
			return preLevelId_;
		}
		set
		{
			preLevelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WorldClass
	{
		get
		{
			return worldClass_;
		}
		set
		{
			worldClass_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Item1
	{
		get
		{
			return item1_;
		}
		set
		{
			item1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty1
	{
		get
		{
			return qty1_;
		}
		set
		{
			qty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TutorialLevel()
	{
	}

	[DebuggerNonUserCode]
	public TutorialLevel(TutorialLevel other)
		: this()
	{
		id_ = other.id_;
		tutorialType_ = other.tutorialType_;
		title_ = other.title_;
		tutorialBuild_ = other.tutorialBuild_;
		floorId_ = other.floorId_;
		preLevelId_ = other.preLevelId_;
		worldClass_ = other.worldClass_;
		item1_ = other.item1_;
		qty1_ = other.qty1_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TutorialLevel Clone()
	{
		return new TutorialLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TutorialLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(TutorialLevel other)
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
		if (TutorialType != other.TutorialType)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (TutorialBuild != other.TutorialBuild)
		{
			return false;
		}
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (PreLevelId != other.PreLevelId)
		{
			return false;
		}
		if (WorldClass != other.WorldClass)
		{
			return false;
		}
		if (Item1 != other.Item1)
		{
			return false;
		}
		if (Qty1 != other.Qty1)
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
		if (TutorialType != 0)
		{
			num ^= TutorialType.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (TutorialBuild != 0)
		{
			num ^= TutorialBuild.GetHashCode();
		}
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (PreLevelId != 0)
		{
			num ^= PreLevelId.GetHashCode();
		}
		if (WorldClass != 0)
		{
			num ^= WorldClass.GetHashCode();
		}
		if (Item1 != 0)
		{
			num ^= Item1.GetHashCode();
		}
		if (Qty1 != 0)
		{
			num ^= Qty1.GetHashCode();
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
		if (TutorialType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TutorialType);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Title);
		}
		if (TutorialBuild != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(TutorialBuild);
		}
		if (FloorId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(FloorId);
		}
		if (PreLevelId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(PreLevelId);
		}
		if (WorldClass != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(WorldClass);
		}
		if (Item1 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Item1);
		}
		if (Qty1 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Qty1);
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
		if (TutorialType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TutorialType);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (TutorialBuild != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TutorialBuild);
		}
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (PreLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelId);
		}
		if (WorldClass != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WorldClass);
		}
		if (Item1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Item1);
		}
		if (Qty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty1);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TutorialLevel other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.TutorialType != 0)
			{
				TutorialType = other.TutorialType;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.TutorialBuild != 0)
			{
				TutorialBuild = other.TutorialBuild;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.PreLevelId != 0)
			{
				PreLevelId = other.PreLevelId;
			}
			if (other.WorldClass != 0)
			{
				WorldClass = other.WorldClass;
			}
			if (other.Item1 != 0)
			{
				Item1 = other.Item1;
			}
			if (other.Qty1 != 0)
			{
				Qty1 = other.Qty1;
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
				TutorialType = input.ReadInt32();
				break;
			case 26u:
				Title = input.ReadString();
				break;
			case 32u:
				TutorialBuild = input.ReadInt32();
				break;
			case 40u:
				FloorId = input.ReadInt32();
				break;
			case 48u:
				PreLevelId = input.ReadInt32();
				break;
			case 56u:
				WorldClass = input.ReadInt32();
				break;
			case 64u:
				Item1 = input.ReadInt32();
				break;
			case 72u:
				Qty1 = input.ReadInt32();
				break;
			}
		}
	}
}
