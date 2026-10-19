using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivityDoubleDungeonNtf : IMessage<ActivityDoubleDungeonNtf>, IMessage, IEquatable<ActivityDoubleDungeonNtf>, IDeepCloneable<ActivityDoubleDungeonNtf>, IBufferMessage
{
	private static readonly MessageParser<ActivityDoubleDungeonNtf> _parser = new MessageParser<ActivityDoubleDungeonNtf>(() => new ActivityDoubleDungeonNtf());

	private UnknownFieldSet _unknownFields;

	public const int ActivitDoubleDungeonInfoFieldNumber = 1;

	private ActivitDoubleDungeonInfo activitDoubleDungeonInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityDoubleDungeonNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[5];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitDoubleDungeonInfo ActivitDoubleDungeonInfo
	{
		get
		{
			return activitDoubleDungeonInfo_;
		}
		set
		{
			activitDoubleDungeonInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityDoubleDungeonNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityDoubleDungeonNtf(ActivityDoubleDungeonNtf other)
		: this()
	{
		activitDoubleDungeonInfo_ = ((other.activitDoubleDungeonInfo_ != null) ? other.activitDoubleDungeonInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityDoubleDungeonNtf Clone()
	{
		return new ActivityDoubleDungeonNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityDoubleDungeonNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityDoubleDungeonNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ActivitDoubleDungeonInfo, other.ActivitDoubleDungeonInfo))
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
		if (activitDoubleDungeonInfo_ != null)
		{
			num ^= ActivitDoubleDungeonInfo.GetHashCode();
		}
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
		if (activitDoubleDungeonInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ActivitDoubleDungeonInfo);
		}
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
		if (activitDoubleDungeonInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivitDoubleDungeonInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityDoubleDungeonNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.activitDoubleDungeonInfo_ != null)
		{
			if (activitDoubleDungeonInfo_ == null)
			{
				ActivitDoubleDungeonInfo = new ActivitDoubleDungeonInfo();
			}
			ActivitDoubleDungeonInfo.MergeFrom(other.ActivitDoubleDungeonInfo);
		}
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
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				continue;
			}
			if (activitDoubleDungeonInfo_ == null)
			{
				ActivitDoubleDungeonInfo = new ActivitDoubleDungeonInfo();
			}
			input.ReadMessage(ActivitDoubleDungeonInfo);
		}
	}
}
