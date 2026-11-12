using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TraceHuntScoreSwitch : IMessage<TraceHuntScoreSwitch>, IMessage, IEquatable<TraceHuntScoreSwitch>, IDeepCloneable<TraceHuntScoreSwitch>
{
	private static readonly MessageParser<TraceHuntScoreSwitch> _parser = new MessageParser<TraceHuntScoreSwitch>(() => new TraceHuntScoreSwitch());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int LvFieldNumber = 3;

	private int lv_;

	public const int SwitchRateFieldNumber = 4;

	private float switchRate_;

	[DebuggerNonUserCode]
	public static MessageParser<TraceHuntScoreSwitch> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(992);

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
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Lv
	{
		get
		{
			return lv_;
		}
		set
		{
			lv_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float SwitchRate
	{
		get
		{
			return switchRate_;
		}
		set
		{
			switchRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TraceHuntScoreSwitch()
	{
	}

	[DebuggerNonUserCode]
	public TraceHuntScoreSwitch(TraceHuntScoreSwitch other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		lv_ = other.lv_;
		switchRate_ = other.switchRate_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TraceHuntScoreSwitch Clone()
	{
		return new TraceHuntScoreSwitch(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TraceHuntScoreSwitch);
	}

	[DebuggerNonUserCode]
	public bool Equals(TraceHuntScoreSwitch other)
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
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (Lv != other.Lv)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(SwitchRate, other.SwitchRate))
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
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (Lv != 0)
		{
			num ^= Lv.GetHashCode();
		}
		if (SwitchRate != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(SwitchRate);
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
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (Lv != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Lv);
		}
		if (SwitchRate != 0f)
		{
			output.WriteRawTag(37);
			output.WriteFloat(SwitchRate);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Lv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Lv);
		}
		if (SwitchRate != 0f)
		{
			num += 5;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TraceHuntScoreSwitch other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.Lv != 0)
			{
				Lv = other.Lv;
			}
			if (other.SwitchRate != 0f)
			{
				SwitchRate = other.SwitchRate;
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
				GroupId = input.ReadInt32();
				break;
			case 24u:
				Lv = input.ReadInt32();
				break;
			case 37u:
				SwitchRate = input.ReadFloat();
				break;
			}
		}
	}
}
