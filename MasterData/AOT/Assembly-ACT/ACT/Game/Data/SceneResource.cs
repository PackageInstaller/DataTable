using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class SceneResource : IMessage<SceneResource>, IMessage, IEquatable<SceneResource>, IDeepCloneable<SceneResource>, IBufferMessage
{
	private static readonly MessageParser<SceneResource> _parser = new MessageParser<SceneResource>(() => new SceneResource());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int StateFieldNumber = 2;

	private int state_;

	public const int MiddleStateFieldNumber = 3;

	private int middleState_;

	public const int BehaviorIDFieldNumber = 7;

	private int behaviorID_;

	public const int CleanedFieldNumber = 8;

	private bool cleaned_;

	public const int CleanedTsFieldNumber = 9;

	private int cleanedTs_;

	public const int StopRefreshFieldNumber = 10;

	private bool stopRefresh_;

	public const int ExtraInfoFieldNumber = 11;

	private ByteString extraInfo_ = ByteString.Empty;

	public const int LastRefreshTsFieldNumber = 12;

	private int lastRefreshTs_;

	public const int RewardedFieldNumber = 13;

	private bool rewarded_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SceneResource> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[191];

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
	public int State
	{
		get
		{
			return state_;
		}
		set
		{
			state_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int MiddleState
	{
		get
		{
			return middleState_;
		}
		set
		{
			middleState_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int BehaviorID
	{
		get
		{
			return behaviorID_;
		}
		set
		{
			behaviorID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Cleaned
	{
		get
		{
			return cleaned_;
		}
		set
		{
			cleaned_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CleanedTs
	{
		get
		{
			return cleanedTs_;
		}
		set
		{
			cleanedTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool StopRefresh
	{
		get
		{
			return stopRefresh_;
		}
		set
		{
			stopRefresh_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ByteString ExtraInfo
	{
		get
		{
			return extraInfo_;
		}
		set
		{
			extraInfo_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LastRefreshTs
	{
		get
		{
			return lastRefreshTs_;
		}
		set
		{
			lastRefreshTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Rewarded
	{
		get
		{
			return rewarded_;
		}
		set
		{
			rewarded_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneResource()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneResource(SceneResource other)
		: this()
	{
		id_ = other.id_;
		state_ = other.state_;
		middleState_ = other.middleState_;
		behaviorID_ = other.behaviorID_;
		cleaned_ = other.cleaned_;
		cleanedTs_ = other.cleanedTs_;
		stopRefresh_ = other.stopRefresh_;
		extraInfo_ = other.extraInfo_;
		lastRefreshTs_ = other.lastRefreshTs_;
		rewarded_ = other.rewarded_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneResource Clone()
	{
		return new SceneResource(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SceneResource);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SceneResource other)
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
		if (State != other.State)
		{
			return false;
		}
		if (MiddleState != other.MiddleState)
		{
			return false;
		}
		if (BehaviorID != other.BehaviorID)
		{
			return false;
		}
		if (Cleaned != other.Cleaned)
		{
			return false;
		}
		if (CleanedTs != other.CleanedTs)
		{
			return false;
		}
		if (StopRefresh != other.StopRefresh)
		{
			return false;
		}
		if (ExtraInfo != other.ExtraInfo)
		{
			return false;
		}
		if (LastRefreshTs != other.LastRefreshTs)
		{
			return false;
		}
		if (Rewarded != other.Rewarded)
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
		if (State != 0)
		{
			num ^= State.GetHashCode();
		}
		if (MiddleState != 0)
		{
			num ^= MiddleState.GetHashCode();
		}
		if (BehaviorID != 0)
		{
			num ^= BehaviorID.GetHashCode();
		}
		if (Cleaned)
		{
			num ^= Cleaned.GetHashCode();
		}
		if (CleanedTs != 0)
		{
			num ^= CleanedTs.GetHashCode();
		}
		if (StopRefresh)
		{
			num ^= StopRefresh.GetHashCode();
		}
		if (ExtraInfo.Length != 0)
		{
			num ^= ExtraInfo.GetHashCode();
		}
		if (LastRefreshTs != 0)
		{
			num ^= LastRefreshTs.GetHashCode();
		}
		if (Rewarded)
		{
			num ^= Rewarded.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (State != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(State);
		}
		if (MiddleState != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(MiddleState);
		}
		if (BehaviorID != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(BehaviorID);
		}
		if (Cleaned)
		{
			output.WriteRawTag(64);
			output.WriteBool(Cleaned);
		}
		if (CleanedTs != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(CleanedTs);
		}
		if (StopRefresh)
		{
			output.WriteRawTag(80);
			output.WriteBool(StopRefresh);
		}
		if (ExtraInfo.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteBytes(ExtraInfo);
		}
		if (LastRefreshTs != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(LastRefreshTs);
		}
		if (Rewarded)
		{
			output.WriteRawTag(104);
			output.WriteBool(Rewarded);
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (State != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(State);
		}
		if (MiddleState != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MiddleState);
		}
		if (BehaviorID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BehaviorID);
		}
		if (Cleaned)
		{
			num += 2;
		}
		if (CleanedTs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CleanedTs);
		}
		if (StopRefresh)
		{
			num += 2;
		}
		if (ExtraInfo.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeBytesSize(ExtraInfo);
		}
		if (LastRefreshTs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LastRefreshTs);
		}
		if (Rewarded)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SceneResource other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.State != 0)
			{
				State = other.State;
			}
			if (other.MiddleState != 0)
			{
				MiddleState = other.MiddleState;
			}
			if (other.BehaviorID != 0)
			{
				BehaviorID = other.BehaviorID;
			}
			if (other.Cleaned)
			{
				Cleaned = other.Cleaned;
			}
			if (other.CleanedTs != 0)
			{
				CleanedTs = other.CleanedTs;
			}
			if (other.StopRefresh)
			{
				StopRefresh = other.StopRefresh;
			}
			if (other.ExtraInfo.Length != 0)
			{
				ExtraInfo = other.ExtraInfo;
			}
			if (other.LastRefreshTs != 0)
			{
				LastRefreshTs = other.LastRefreshTs;
			}
			if (other.Rewarded)
			{
				Rewarded = other.Rewarded;
			}
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
				State = input.ReadInt32();
				break;
			case 24u:
				MiddleState = input.ReadInt32();
				break;
			case 56u:
				BehaviorID = input.ReadInt32();
				break;
			case 64u:
				Cleaned = input.ReadBool();
				break;
			case 72u:
				CleanedTs = input.ReadInt32();
				break;
			case 80u:
				StopRefresh = input.ReadBool();
				break;
			case 90u:
				ExtraInfo = input.ReadBytes();
				break;
			case 96u:
				LastRefreshTs = input.ReadInt32();
				break;
			case 104u:
				Rewarded = input.ReadBool();
				break;
			}
		}
	}
}
