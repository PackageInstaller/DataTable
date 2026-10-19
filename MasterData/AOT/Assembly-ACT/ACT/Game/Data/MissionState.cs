using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MissionState : IMessage<MissionState>, IMessage, IEquatable<MissionState>, IDeepCloneable<MissionState>, IBufferMessage
{
	private static readonly MessageParser<MissionState> _parser = new MessageParser<MissionState>(() => new MissionState());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ReadyFieldNumber = 2;

	private bool ready_;

	public const int FinishedFieldNumber = 3;

	private bool finished_;

	public const int SubMissionIdFieldNumber = 4;

	private int subMissionId_;

	public const int SubMissionProgressFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_subMissionProgress_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> subMissionProgress_ = new RepeatedField<int>();

	public const int SubmitItemsFieldNumber = 6;

	private static readonly FieldCodec<Item> _repeated_submitItems_codec = FieldCodec.ForMessage(50u, Item.Parser);

	private readonly RepeatedField<Item> submitItems_ = new RepeatedField<Item>();

	public const int BluePrintIdsFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_bluePrintIds_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> bluePrintIds_ = new RepeatedField<int>();

	public const int CompletedSubmissionsFieldNumber = 8;

	private static readonly MapField<int, bool>.Codec _map_completedSubmissions_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 66u);

	private readonly MapField<int, bool> completedSubmissions_ = new MapField<int, bool>();

	public bool isOld;

	public bool isNew;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MissionState> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[56];

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
	public bool Ready
	{
		get
		{
			return ready_;
		}
		set
		{
			ready_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Finished
	{
		get
		{
			return finished_;
		}
		set
		{
			finished_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SubMissionId
	{
		get
		{
			return subMissionId_;
		}
		set
		{
			subMissionId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> SubMissionProgress => subMissionProgress_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> SubmitItems => submitItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> BluePrintIds => bluePrintIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> CompletedSubmissions => completedSubmissions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionState()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionState(MissionState other)
		: this()
	{
		id_ = other.id_;
		ready_ = other.ready_;
		finished_ = other.finished_;
		subMissionId_ = other.subMissionId_;
		subMissionProgress_ = other.subMissionProgress_.Clone();
		submitItems_ = other.submitItems_.Clone();
		bluePrintIds_ = other.bluePrintIds_.Clone();
		completedSubmissions_ = other.completedSubmissions_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionState Clone()
	{
		return new MissionState(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MissionState);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MissionState other)
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
		if (Ready != other.Ready)
		{
			return false;
		}
		if (Finished != other.Finished)
		{
			return false;
		}
		if (SubMissionId != other.SubMissionId)
		{
			return false;
		}
		if (!subMissionProgress_.Equals(other.subMissionProgress_))
		{
			return false;
		}
		if (!submitItems_.Equals(other.submitItems_))
		{
			return false;
		}
		if (!bluePrintIds_.Equals(other.bluePrintIds_))
		{
			return false;
		}
		if (!CompletedSubmissions.Equals(other.CompletedSubmissions))
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
		if (Ready)
		{
			num ^= Ready.GetHashCode();
		}
		if (Finished)
		{
			num ^= Finished.GetHashCode();
		}
		if (SubMissionId != 0)
		{
			num ^= SubMissionId.GetHashCode();
		}
		num ^= subMissionProgress_.GetHashCode();
		num ^= submitItems_.GetHashCode();
		num ^= bluePrintIds_.GetHashCode();
		num ^= CompletedSubmissions.GetHashCode();
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
		if (Ready)
		{
			output.WriteRawTag(16);
			output.WriteBool(Ready);
		}
		if (Finished)
		{
			output.WriteRawTag(24);
			output.WriteBool(Finished);
		}
		if (SubMissionId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(SubMissionId);
		}
		subMissionProgress_.WriteTo(ref output, _repeated_subMissionProgress_codec);
		submitItems_.WriteTo(ref output, _repeated_submitItems_codec);
		bluePrintIds_.WriteTo(ref output, _repeated_bluePrintIds_codec);
		completedSubmissions_.WriteTo(ref output, _map_completedSubmissions_codec);
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
		if (Ready)
		{
			num += 2;
		}
		if (Finished)
		{
			num += 2;
		}
		if (SubMissionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SubMissionId);
		}
		num += subMissionProgress_.CalculateSize(_repeated_subMissionProgress_codec);
		num += submitItems_.CalculateSize(_repeated_submitItems_codec);
		num += bluePrintIds_.CalculateSize(_repeated_bluePrintIds_codec);
		num += completedSubmissions_.CalculateSize(_map_completedSubmissions_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MissionState other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Ready)
			{
				Ready = other.Ready;
			}
			if (other.Finished)
			{
				Finished = other.Finished;
			}
			if (other.SubMissionId != 0)
			{
				SubMissionId = other.SubMissionId;
			}
			subMissionProgress_.Add(other.subMissionProgress_);
			submitItems_.Add(other.submitItems_);
			bluePrintIds_.Add(other.bluePrintIds_);
			completedSubmissions_.Add(other.completedSubmissions_);
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
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
				Ready = input.ReadBool();
				break;
			case 24u:
				Finished = input.ReadBool();
				break;
			case 32u:
				SubMissionId = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				subMissionProgress_.AddEntriesFrom(ref input, _repeated_subMissionProgress_codec);
				break;
			case 50u:
				submitItems_.AddEntriesFrom(ref input, _repeated_submitItems_codec);
				break;
			case 56u:
			case 58u:
				bluePrintIds_.AddEntriesFrom(ref input, _repeated_bluePrintIds_codec);
				break;
			case 66u:
				completedSubmissions_.AddEntriesFrom(ref input, _map_completedSubmissions_codec);
				break;
			}
		}
	}

	public void CopyFrom(MissionState change)
	{
		id_ = change.id_;
		ready_ = change.ready_;
		finished_ = change.finished_;
		subMissionId_ = change.subMissionId_;
		subMissionProgress_.CopyValueFrom(change.subMissionProgress_);
		submitItems_.CopyValueFrom(change.submitItems_);
		bluePrintIds_.CopyValueFrom(change.bluePrintIds_);
		completedSubmissions_.CopyValueFrom(change.completedSubmissions_);
	}
}
