using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Mission : IMessage<Mission>, IMessage, IEquatable<Mission>, IDeepCloneable<Mission>, IBufferMessage
{
	private static readonly MessageParser<Mission> _parser = new MessageParser<Mission>(() => new Mission());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int StateFieldNumber = 2;

	private int state_;

	public const int CurSubMissionFieldNumber = 3;

	private SubMission curSubMission_;

	public const int AppliedItemsFieldNumber = 4;

	private static readonly MapField<int, SubMissionAppliedItem>.Codec _map_appliedItems_codec = new MapField<int, SubMissionAppliedItem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, SubMissionAppliedItem.Parser), 34u);

	private readonly MapField<int, SubMissionAppliedItem> appliedItems_ = new MapField<int, SubMissionAppliedItem>();

	public const int CompletedSubMissionsFieldNumber = 5;

	private static readonly MapField<int, SubMission>.Codec _map_completedSubMissions_codec = new MapField<int, SubMission>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, SubMission.Parser), 42u);

	private readonly MapField<int, SubMission> completedSubMissions_ = new MapField<int, SubMission>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Mission> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[187];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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
	[GeneratedCode("protoc", null)]
	public int State
	{
		get
		{
			return state_;
		}
		set
		{
			state_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SubMission CurSubMission
	{
		get
		{
			return curSubMission_;
		}
		set
		{
			curSubMission_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, SubMissionAppliedItem> AppliedItems => appliedItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, SubMission> CompletedSubMissions => completedSubMissions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Mission()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Mission(Mission other)
		: this()
	{
		id_ = other.id_;
		state_ = other.state_;
		curSubMission_ = ((other.curSubMission_ != null) ? other.curSubMission_.Clone() : null);
		appliedItems_ = other.appliedItems_.Clone();
		completedSubMissions_ = other.completedSubMissions_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Mission Clone()
	{
		return new Mission(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Mission);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Mission other)
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
		if (State != other.State)
		{
			return false;
		}
		if (!object.Equals(CurSubMission, other.CurSubMission))
		{
			return false;
		}
		if (!AppliedItems.Equals(other.AppliedItems))
		{
			return false;
		}
		if (!CompletedSubMissions.Equals(other.CompletedSubMissions))
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (State != 0)
		{
			num ^= State.GetHashCode();
		}
		if (curSubMission_ != null)
		{
			num ^= CurSubMission.GetHashCode();
		}
		num ^= AppliedItems.GetHashCode();
		num ^= CompletedSubMissions.GetHashCode();
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (State != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(State);
		}
		if (curSubMission_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(CurSubMission);
		}
		appliedItems_.WriteTo(ref output, _map_appliedItems_codec);
		completedSubMissions_.WriteTo(ref output, _map_completedSubMissions_codec);
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (State != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(State);
		}
		if (curSubMission_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(CurSubMission);
		}
		num += appliedItems_.CalculateSize(_map_appliedItems_codec);
		num += completedSubMissions_.CalculateSize(_map_completedSubMissions_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Mission other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Id != 0)
		{
			Id = other.Id;
		}
		if (other.State != 0)
		{
			State = other.State;
		}
		if (other.curSubMission_ != null)
		{
			if (curSubMission_ == null)
			{
				CurSubMission = new SubMission();
			}
			CurSubMission.MergeFrom(other.CurSubMission);
		}
		appliedItems_.Add(other.appliedItems_);
		completedSubMissions_.Add(other.completedSubMissions_);
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				State = input.ReadInt32();
				break;
			case 26u:
				if (curSubMission_ == null)
				{
					CurSubMission = new SubMission();
				}
				input.ReadMessage(CurSubMission);
				break;
			case 34u:
				appliedItems_.AddEntriesFrom(ref input, _map_appliedItems_codec);
				break;
			case 42u:
				completedSubMissions_.AddEntriesFrom(ref input, _map_completedSubMissions_codec);
				break;
			}
		}
	}
}
