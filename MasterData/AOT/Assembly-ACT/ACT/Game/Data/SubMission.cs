using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class SubMission : IMessage<SubMission>, IMessage, IEquatable<SubMission>, IDeepCloneable<SubMission>, IBufferMessage
{
	private static readonly MessageParser<SubMission> _parser = new MessageParser<SubMission>(() => new SubMission());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int StartTsFieldNumber = 2;

	private int startTs_;

	public const int CompletedTsFieldNumber = 3;

	private int completedTs_;

	public const int ProgressFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_progress_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> progress_ = new RepeatedField<int>();

	public const int BluePrintsFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_bluePrints_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> bluePrints_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SubMission> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[132];

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
	public int StartTs
	{
		get
		{
			return startTs_;
		}
		set
		{
			startTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CompletedTs
	{
		get
		{
			return completedTs_;
		}
		set
		{
			completedTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> Progress => progress_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> BluePrints => bluePrints_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SubMission()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SubMission(SubMission other)
		: this()
	{
		id_ = other.id_;
		startTs_ = other.startTs_;
		completedTs_ = other.completedTs_;
		progress_ = other.progress_.Clone();
		bluePrints_ = other.bluePrints_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SubMission Clone()
	{
		return new SubMission(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SubMission);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SubMission other)
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
		if (StartTs != other.StartTs)
		{
			return false;
		}
		if (CompletedTs != other.CompletedTs)
		{
			return false;
		}
		if (!progress_.Equals(other.progress_))
		{
			return false;
		}
		if (!bluePrints_.Equals(other.bluePrints_))
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
		if (StartTs != 0)
		{
			num ^= StartTs.GetHashCode();
		}
		if (CompletedTs != 0)
		{
			num ^= CompletedTs.GetHashCode();
		}
		num ^= progress_.GetHashCode();
		num ^= bluePrints_.GetHashCode();
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
		if (StartTs != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(StartTs);
		}
		if (CompletedTs != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CompletedTs);
		}
		progress_.WriteTo(ref output, _repeated_progress_codec);
		bluePrints_.WriteTo(ref output, _repeated_bluePrints_codec);
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
		if (StartTs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StartTs);
		}
		if (CompletedTs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompletedTs);
		}
		num += progress_.CalculateSize(_repeated_progress_codec);
		num += bluePrints_.CalculateSize(_repeated_bluePrints_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SubMission other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.StartTs != 0)
			{
				StartTs = other.StartTs;
			}
			if (other.CompletedTs != 0)
			{
				CompletedTs = other.CompletedTs;
			}
			progress_.Add(other.progress_);
			bluePrints_.Add(other.bluePrints_);
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
				StartTs = input.ReadInt32();
				break;
			case 24u:
				CompletedTs = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				progress_.AddEntriesFrom(ref input, _repeated_progress_codec);
				break;
			case 40u:
			case 42u:
				bluePrints_.AddEntriesFrom(ref input, _repeated_bluePrints_codec);
				break;
			}
		}
	}
}
