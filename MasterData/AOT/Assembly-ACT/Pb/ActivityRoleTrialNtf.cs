using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivityRoleTrialNtf : IMessage<ActivityRoleTrialNtf>, IMessage, IEquatable<ActivityRoleTrialNtf>, IDeepCloneable<ActivityRoleTrialNtf>, IBufferMessage
{
	private static readonly MessageParser<ActivityRoleTrialNtf> _parser = new MessageParser<ActivityRoleTrialNtf>(() => new ActivityRoleTrialNtf());

	private UnknownFieldSet _unknownFields;

	public const int ActivitRoleTrialInfoFieldNumber = 1;

	private ActivitRoleTrialInfo activitRoleTrialInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityRoleTrialNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[20];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitRoleTrialInfo ActivitRoleTrialInfo
	{
		get
		{
			return activitRoleTrialInfo_;
		}
		set
		{
			activitRoleTrialInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityRoleTrialNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityRoleTrialNtf(ActivityRoleTrialNtf other)
		: this()
	{
		activitRoleTrialInfo_ = ((other.activitRoleTrialInfo_ != null) ? other.activitRoleTrialInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityRoleTrialNtf Clone()
	{
		return new ActivityRoleTrialNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityRoleTrialNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityRoleTrialNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ActivitRoleTrialInfo, other.ActivitRoleTrialInfo))
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
		if (activitRoleTrialInfo_ != null)
		{
			num ^= ActivitRoleTrialInfo.GetHashCode();
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
		if (activitRoleTrialInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ActivitRoleTrialInfo);
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
		if (activitRoleTrialInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivitRoleTrialInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityRoleTrialNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.activitRoleTrialInfo_ != null)
		{
			if (activitRoleTrialInfo_ == null)
			{
				ActivitRoleTrialInfo = new ActivitRoleTrialInfo();
			}
			ActivitRoleTrialInfo.MergeFrom(other.ActivitRoleTrialInfo);
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
			if (activitRoleTrialInfo_ == null)
			{
				ActivitRoleTrialInfo = new ActivitRoleTrialInfo();
			}
			input.ReadMessage(ActivitRoleTrialInfo);
		}
	}
}
