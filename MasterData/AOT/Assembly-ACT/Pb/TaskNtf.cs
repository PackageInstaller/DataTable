using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class TaskNtf : IMessage<TaskNtf>, IMessage, IEquatable<TaskNtf>, IDeepCloneable<TaskNtf>, IBufferMessage
{
	private static readonly MessageParser<TaskNtf> _parser = new MessageParser<TaskNtf>(() => new TaskNtf());

	private UnknownFieldSet _unknownFields;

	public const int ChangesFieldNumber = 1;

	private static readonly FieldCodec<Task> _repeated_changes_codec = FieldCodec.ForMessage(10u, Task.Parser);

	private readonly RepeatedField<Task> changes_ = new RepeatedField<Task>();

	public const int TargetsFieldNumber = 2;

	private static readonly MapField<int, int>.Codec _map_targets_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 18u);

	private readonly MapField<int, int> targets_ = new MapField<int, int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TaskNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[134];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Task> Changes => changes_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> Targets => targets_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TaskNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TaskNtf(TaskNtf other)
		: this()
	{
		changes_ = other.changes_.Clone();
		targets_ = other.targets_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TaskNtf Clone()
	{
		return new TaskNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TaskNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TaskNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!changes_.Equals(other.changes_))
		{
			return false;
		}
		if (!Targets.Equals(other.Targets))
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
		num ^= changes_.GetHashCode();
		num ^= Targets.GetHashCode();
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
		changes_.WriteTo(ref output, _repeated_changes_codec);
		targets_.WriteTo(ref output, _map_targets_codec);
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
		num += changes_.CalculateSize(_repeated_changes_codec);
		num += targets_.CalculateSize(_map_targets_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TaskNtf other)
	{
		if (other != null)
		{
			changes_.Add(other.changes_);
			targets_.Add(other.targets_);
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
			case 10u:
				changes_.AddEntriesFrom(ref input, _repeated_changes_codec);
				break;
			case 18u:
				targets_.AddEntriesFrom(ref input, _map_targets_codec);
				break;
			}
		}
	}
}
