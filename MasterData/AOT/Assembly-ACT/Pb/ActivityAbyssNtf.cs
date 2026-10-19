using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivityAbyssNtf : IMessage<ActivityAbyssNtf>, IMessage, IEquatable<ActivityAbyssNtf>, IDeepCloneable<ActivityAbyssNtf>, IBufferMessage
{
	private static readonly MessageParser<ActivityAbyssNtf> _parser = new MessageParser<ActivityAbyssNtf>(() => new ActivityAbyssNtf());

	private UnknownFieldSet _unknownFields;

	public const int ActivitAbyssInfoFieldNumber = 1;

	private ActivitAbyssInfo activitAbyssInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityAbyssNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[13];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitAbyssInfo ActivitAbyssInfo
	{
		get
		{
			return activitAbyssInfo_;
		}
		set
		{
			activitAbyssInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityAbyssNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityAbyssNtf(ActivityAbyssNtf other)
		: this()
	{
		activitAbyssInfo_ = ((other.activitAbyssInfo_ != null) ? other.activitAbyssInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityAbyssNtf Clone()
	{
		return new ActivityAbyssNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityAbyssNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityAbyssNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ActivitAbyssInfo, other.ActivitAbyssInfo))
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
		if (activitAbyssInfo_ != null)
		{
			num ^= ActivitAbyssInfo.GetHashCode();
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
		if (activitAbyssInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ActivitAbyssInfo);
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
		if (activitAbyssInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivitAbyssInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityAbyssNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.activitAbyssInfo_ != null)
		{
			if (activitAbyssInfo_ == null)
			{
				ActivitAbyssInfo = new ActivitAbyssInfo();
			}
			ActivitAbyssInfo.MergeFrom(other.ActivitAbyssInfo);
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
			if (activitAbyssInfo_ == null)
			{
				ActivitAbyssInfo = new ActivitAbyssInfo();
			}
			input.ReadMessage(ActivitAbyssInfo);
		}
	}
}
