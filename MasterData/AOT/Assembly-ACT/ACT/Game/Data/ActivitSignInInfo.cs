using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ActivitSignInInfo : IMessage<ActivitSignInInfo>, IMessage, IEquatable<ActivitSignInInfo>, IDeepCloneable<ActivitSignInInfo>, IBufferMessage
{
	private static readonly MessageParser<ActivitSignInInfo> _parser = new MessageParser<ActivitSignInInfo>(() => new ActivitSignInInfo());

	private UnknownFieldSet _unknownFields;

	public const int ActivityIdFieldNumber = 1;

	private int activityId_;

	public const int SignInGroupsFieldNumber = 2;

	private static readonly MapField<int, SignInGroup>.Codec _map_signInGroups_codec = new MapField<int, SignInGroup>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, SignInGroup.Parser), 18u);

	private readonly MapField<int, SignInGroup> signInGroups_ = new MapField<int, SignInGroup>();

	public const int ActivityBaseInfoFieldNumber = 3;

	private ActivityBaseInfo activityBaseInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivitSignInInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[253];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ActivityId
	{
		get
		{
			return activityId_;
		}
		set
		{
			activityId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, SignInGroup> SignInGroups => signInGroups_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityBaseInfo ActivityBaseInfo
	{
		get
		{
			return activityBaseInfo_;
		}
		set
		{
			activityBaseInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitSignInInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitSignInInfo(ActivitSignInInfo other)
		: this()
	{
		activityId_ = other.activityId_;
		signInGroups_ = other.signInGroups_.Clone();
		activityBaseInfo_ = ((other.activityBaseInfo_ != null) ? other.activityBaseInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitSignInInfo Clone()
	{
		return new ActivitSignInInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivitSignInInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivitSignInInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (!SignInGroups.Equals(other.SignInGroups))
		{
			return false;
		}
		if (!object.Equals(ActivityBaseInfo, other.ActivityBaseInfo))
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
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		num ^= SignInGroups.GetHashCode();
		if (activityBaseInfo_ != null)
		{
			num ^= ActivityBaseInfo.GetHashCode();
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
		if (ActivityId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ActivityId);
		}
		signInGroups_.WriteTo(ref output, _map_signInGroups_codec);
		if (activityBaseInfo_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(ActivityBaseInfo);
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
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		num += signInGroups_.CalculateSize(_map_signInGroups_codec);
		if (activityBaseInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivityBaseInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivitSignInInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.ActivityId != 0)
		{
			ActivityId = other.ActivityId;
		}
		signInGroups_.Add(other.signInGroups_);
		if (other.activityBaseInfo_ != null)
		{
			if (activityBaseInfo_ == null)
			{
				ActivityBaseInfo = new ActivityBaseInfo();
			}
			ActivityBaseInfo.MergeFrom(other.ActivityBaseInfo);
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
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				ActivityId = input.ReadInt32();
				break;
			case 18u:
				signInGroups_.AddEntriesFrom(ref input, _map_signInGroups_codec);
				break;
			case 26u:
				if (activityBaseInfo_ == null)
				{
					ActivityBaseInfo = new ActivityBaseInfo();
				}
				input.ReadMessage(ActivityBaseInfo);
				break;
			}
		}
	}
}
