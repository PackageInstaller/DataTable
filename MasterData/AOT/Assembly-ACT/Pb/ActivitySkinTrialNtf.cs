using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivitySkinTrialNtf : IMessage<ActivitySkinTrialNtf>, IMessage, IEquatable<ActivitySkinTrialNtf>, IDeepCloneable<ActivitySkinTrialNtf>, IBufferMessage
{
	private static readonly MessageParser<ActivitySkinTrialNtf> _parser = new MessageParser<ActivitySkinTrialNtf>(() => new ActivitySkinTrialNtf());

	private UnknownFieldSet _unknownFields;

	public const int ActivitSkinTrialInfoFieldNumber = 1;

	private ActivitSkinTrialInfo activitSkinTrialInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivitySkinTrialNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[23];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitSkinTrialInfo ActivitSkinTrialInfo
	{
		get
		{
			return activitSkinTrialInfo_;
		}
		set
		{
			activitSkinTrialInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitySkinTrialNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitySkinTrialNtf(ActivitySkinTrialNtf other)
		: this()
	{
		activitSkinTrialInfo_ = ((other.activitSkinTrialInfo_ != null) ? other.activitSkinTrialInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitySkinTrialNtf Clone()
	{
		return new ActivitySkinTrialNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivitySkinTrialNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivitySkinTrialNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ActivitSkinTrialInfo, other.ActivitSkinTrialInfo))
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
		if (activitSkinTrialInfo_ != null)
		{
			num ^= ActivitSkinTrialInfo.GetHashCode();
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
		if (activitSkinTrialInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ActivitSkinTrialInfo);
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
		if (activitSkinTrialInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivitSkinTrialInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivitySkinTrialNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.activitSkinTrialInfo_ != null)
		{
			if (activitSkinTrialInfo_ == null)
			{
				ActivitSkinTrialInfo = new ActivitSkinTrialInfo();
			}
			ActivitSkinTrialInfo.MergeFrom(other.ActivitSkinTrialInfo);
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
			if (activitSkinTrialInfo_ == null)
			{
				ActivitSkinTrialInfo = new ActivitSkinTrialInfo();
			}
			input.ReadMessage(ActivitSkinTrialInfo);
		}
	}
}
