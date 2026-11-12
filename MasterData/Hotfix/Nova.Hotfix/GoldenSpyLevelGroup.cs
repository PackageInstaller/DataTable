using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GoldenSpyLevelGroup : IMessage<GoldenSpyLevelGroup>, IMessage, IEquatable<GoldenSpyLevelGroup>, IDeepCloneable<GoldenSpyLevelGroup>
{
	private static readonly MessageParser<GoldenSpyLevelGroup> _parser = new MessageParser<GoldenSpyLevelGroup>(() => new GoldenSpyLevelGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DayOpenFieldNumber = 2;

	private int dayOpen_;

	public const int GroupNameFieldNumber = 3;

	private string groupName_ = "";

	public const int IconPathFieldNumber = 4;

	private string iconPath_ = "";

	public const int LevelListFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_levelList_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> levelList_ = new RepeatedField<int>();

	public const int LightNameFieldNumber = 6;

	private string lightName_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<GoldenSpyLevelGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(404);

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
	public int DayOpen
	{
		get
		{
			return dayOpen_;
		}
		set
		{
			dayOpen_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string GroupName
	{
		get
		{
			return groupName_;
		}
		set
		{
			groupName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string IconPath
	{
		get
		{
			return iconPath_;
		}
		set
		{
			iconPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> LevelList => levelList_;

	[DebuggerNonUserCode]
	public string LightName
	{
		get
		{
			return lightName_;
		}
		set
		{
			lightName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public GoldenSpyLevelGroup()
	{
	}

	[DebuggerNonUserCode]
	public GoldenSpyLevelGroup(GoldenSpyLevelGroup other)
		: this()
	{
		id_ = other.id_;
		dayOpen_ = other.dayOpen_;
		groupName_ = other.groupName_;
		iconPath_ = other.iconPath_;
		levelList_ = other.levelList_.Clone();
		lightName_ = other.lightName_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GoldenSpyLevelGroup Clone()
	{
		return new GoldenSpyLevelGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GoldenSpyLevelGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(GoldenSpyLevelGroup other)
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
		if (DayOpen != other.DayOpen)
		{
			return false;
		}
		if (GroupName != other.GroupName)
		{
			return false;
		}
		if (IconPath != other.IconPath)
		{
			return false;
		}
		if (!levelList_.Equals(other.levelList_))
		{
			return false;
		}
		if (LightName != other.LightName)
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
		if (DayOpen != 0)
		{
			num ^= DayOpen.GetHashCode();
		}
		if (GroupName.Length != 0)
		{
			num ^= GroupName.GetHashCode();
		}
		if (IconPath.Length != 0)
		{
			num ^= IconPath.GetHashCode();
		}
		num ^= levelList_.GetHashCode();
		if (LightName.Length != 0)
		{
			num ^= LightName.GetHashCode();
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
		if (DayOpen != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(DayOpen);
		}
		if (GroupName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(GroupName);
		}
		if (IconPath.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(IconPath);
		}
		levelList_.WriteTo(output, _repeated_levelList_codec);
		if (LightName.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(LightName);
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
		if (DayOpen != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DayOpen);
		}
		if (GroupName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(GroupName);
		}
		if (IconPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconPath);
		}
		num += levelList_.CalculateSize(_repeated_levelList_codec);
		if (LightName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LightName);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GoldenSpyLevelGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.DayOpen != 0)
			{
				DayOpen = other.DayOpen;
			}
			if (other.GroupName.Length != 0)
			{
				GroupName = other.GroupName;
			}
			if (other.IconPath.Length != 0)
			{
				IconPath = other.IconPath;
			}
			levelList_.Add(other.levelList_);
			if (other.LightName.Length != 0)
			{
				LightName = other.LightName;
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
				DayOpen = input.ReadInt32();
				break;
			case 26u:
				GroupName = input.ReadString();
				break;
			case 34u:
				IconPath = input.ReadString();
				break;
			case 40u:
			case 42u:
				levelList_.AddEntriesFrom(input, _repeated_levelList_codec);
				break;
			case 50u:
				LightName = input.ReadString();
				break;
			}
		}
	}
}
