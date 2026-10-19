using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivitySignInNtf : IMessage<ActivitySignInNtf>, IMessage, IEquatable<ActivitySignInNtf>, IDeepCloneable<ActivitySignInNtf>, IBufferMessage
{
	private static readonly MessageParser<ActivitySignInNtf> _parser = new MessageParser<ActivitySignInNtf>(() => new ActivitySignInNtf());

	private UnknownFieldSet _unknownFields;

	public const int ActivitSignInInfoFieldNumber = 1;

	private ActivitSignInInfo activitSignInInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivitySignInNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[8];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitSignInInfo ActivitSignInInfo
	{
		get
		{
			return activitSignInInfo_;
		}
		set
		{
			activitSignInInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitySignInNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitySignInNtf(ActivitySignInNtf other)
		: this()
	{
		activitSignInInfo_ = ((other.activitSignInInfo_ != null) ? other.activitSignInInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitySignInNtf Clone()
	{
		return new ActivitySignInNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivitySignInNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivitySignInNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ActivitSignInInfo, other.ActivitSignInInfo))
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
		if (activitSignInInfo_ != null)
		{
			num ^= ActivitSignInInfo.GetHashCode();
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
		if (activitSignInInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ActivitSignInInfo);
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
		if (activitSignInInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivitSignInInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivitySignInNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.activitSignInInfo_ != null)
		{
			if (activitSignInInfo_ == null)
			{
				ActivitSignInInfo = new ActivitSignInInfo();
			}
			ActivitSignInInfo.MergeFrom(other.ActivitSignInInfo);
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
			if (activitSignInInfo_ == null)
			{
				ActivitSignInInfo = new ActivitSignInInfo();
			}
			input.ReadMessage(ActivitSignInInfo);
		}
	}
}
