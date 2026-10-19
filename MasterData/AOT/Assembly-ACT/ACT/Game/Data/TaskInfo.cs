using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TaskInfo : IMessage<TaskInfo>, IMessage, IEquatable<TaskInfo>, IDeepCloneable<TaskInfo>, IBufferMessage
{
	private static readonly MessageParser<TaskInfo> _parser = new MessageParser<TaskInfo>(() => new TaskInfo());

	private UnknownFieldSet _unknownFields;

	public const int TasksFieldNumber = 1;

	private static readonly MapField<int, Task>.Codec _map_tasks_codec = new MapField<int, Task>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Task.Parser), 10u);

	private readonly MapField<int, Task> tasks_ = new MapField<int, Task>();

	public const int TaskGroupsFieldNumber = 2;

	private static readonly MapField<int, TaskGroup>.Codec _map_taskGroups_codec = new MapField<int, TaskGroup>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, TaskGroup.Parser), 18u);

	private readonly MapField<int, TaskGroup> taskGroups_ = new MapField<int, TaskGroup>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TaskInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[281];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Task> Tasks => tasks_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, TaskGroup> TaskGroups => taskGroups_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TaskInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TaskInfo(TaskInfo other)
		: this()
	{
		tasks_ = other.tasks_.Clone();
		taskGroups_ = other.taskGroups_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TaskInfo Clone()
	{
		return new TaskInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TaskInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TaskInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Tasks.Equals(other.Tasks))
		{
			return false;
		}
		if (!TaskGroups.Equals(other.TaskGroups))
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
		num ^= Tasks.GetHashCode();
		num ^= TaskGroups.GetHashCode();
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
		tasks_.WriteTo(ref output, _map_tasks_codec);
		taskGroups_.WriteTo(ref output, _map_taskGroups_codec);
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
		num += tasks_.CalculateSize(_map_tasks_codec);
		num += taskGroups_.CalculateSize(_map_taskGroups_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TaskInfo other)
	{
		if (other != null)
		{
			tasks_.Add(other.tasks_);
			taskGroups_.Add(other.taskGroups_);
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
				tasks_.AddEntriesFrom(ref input, _map_tasks_codec);
				break;
			case 18u:
				taskGroups_.AddEntriesFrom(ref input, _map_taskGroups_codec);
				break;
			}
		}
	}
}
