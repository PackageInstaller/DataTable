using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityReturneeTrialBuild : IMessage<ActivityReturneeTrialBuild>, IMessage, IEquatable<ActivityReturneeTrialBuild>, IDeepCloneable<ActivityReturneeTrialBuild>
{
	private static readonly MessageParser<ActivityReturneeTrialBuild> _parser = new MessageParser<ActivityReturneeTrialBuild>(() => new ActivityReturneeTrialBuild());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupFieldNumber = 2;

	private int group_;

	public const int IndexFieldNumber = 3;

	private int index_;

	public const int TrialBuildIdFieldNumber = 4;

	private int trialBuildId_;

	[DebuggerNonUserCode]
	public static MessageParser<ActivityReturneeTrialBuild> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(50);

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
	public int Group
	{
		get
		{
			return group_;
		}
		set
		{
			group_ = value;
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
	public int TrialBuildId
	{
		get
		{
			return trialBuildId_;
		}
		set
		{
			trialBuildId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ActivityReturneeTrialBuild()
	{
	}

	[DebuggerNonUserCode]
	public ActivityReturneeTrialBuild(ActivityReturneeTrialBuild other)
		: this()
	{
		id_ = other.id_;
		group_ = other.group_;
		index_ = other.index_;
		trialBuildId_ = other.trialBuildId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityReturneeTrialBuild Clone()
	{
		return new ActivityReturneeTrialBuild(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityReturneeTrialBuild);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityReturneeTrialBuild other)
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
		if (Group != other.Group)
		{
			return false;
		}
		if (Index != other.Index)
		{
			return false;
		}
		if (TrialBuildId != other.TrialBuildId)
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
		if (Group != 0)
		{
			num ^= Group.GetHashCode();
		}
		if (Index != 0)
		{
			num ^= Index.GetHashCode();
		}
		if (TrialBuildId != 0)
		{
			num ^= TrialBuildId.GetHashCode();
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
		if (Group != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Group);
		}
		if (Index != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Index);
		}
		if (TrialBuildId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(TrialBuildId);
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
		if (Group != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Group);
		}
		if (Index != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Index);
		}
		if (TrialBuildId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TrialBuildId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityReturneeTrialBuild other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Group != 0)
			{
				Group = other.Group;
			}
			if (other.Index != 0)
			{
				Index = other.Index;
			}
			if (other.TrialBuildId != 0)
			{
				TrialBuildId = other.TrialBuildId;
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
				Group = input.ReadInt32();
				break;
			case 24u:
				Index = input.ReadInt32();
				break;
			case 32u:
				TrialBuildId = input.ReadInt32();
				break;
			}
		}
	}
}
