using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ActivitDoubleDungeonInfo : IMessage<ActivitDoubleDungeonInfo>, IMessage, IEquatable<ActivitDoubleDungeonInfo>, IDeepCloneable<ActivitDoubleDungeonInfo>, IBufferMessage
{
	private static readonly MessageParser<ActivitDoubleDungeonInfo> _parser = new MessageParser<ActivitDoubleDungeonInfo>(() => new ActivitDoubleDungeonInfo());

	private UnknownFieldSet _unknownFields;

	public const int ActivityIdFieldNumber = 1;

	private int activityId_;

	public const int ActivityBaseInfoFieldNumber = 2;

	private ActivityBaseInfo activityBaseInfo_;

	public const int DungeonInfoFieldNumber = 3;

	private static readonly MapField<int, ActivityDungeonInfo>.Codec _map_dungeonInfo_codec = new MapField<int, ActivityDungeonInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivityDungeonInfo.Parser), 26u);

	private readonly MapField<int, ActivityDungeonInfo> dungeonInfo_ = new MapField<int, ActivityDungeonInfo>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivitDoubleDungeonInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[252];

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
	public MapField<int, ActivityDungeonInfo> DungeonInfo => dungeonInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitDoubleDungeonInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitDoubleDungeonInfo(ActivitDoubleDungeonInfo other)
		: this()
	{
		activityId_ = other.activityId_;
		activityBaseInfo_ = ((other.activityBaseInfo_ != null) ? other.activityBaseInfo_.Clone() : null);
		dungeonInfo_ = other.dungeonInfo_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitDoubleDungeonInfo Clone()
	{
		return new ActivitDoubleDungeonInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivitDoubleDungeonInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivitDoubleDungeonInfo other)
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
		if (!object.Equals(ActivityBaseInfo, other.ActivityBaseInfo))
		{
			return false;
		}
		if (!DungeonInfo.Equals(other.DungeonInfo))
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
		if (activityBaseInfo_ != null)
		{
			num ^= ActivityBaseInfo.GetHashCode();
		}
		num ^= DungeonInfo.GetHashCode();
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
		if (activityBaseInfo_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(ActivityBaseInfo);
		}
		dungeonInfo_.WriteTo(ref output, _map_dungeonInfo_codec);
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
		if (activityBaseInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivityBaseInfo);
		}
		num += dungeonInfo_.CalculateSize(_map_dungeonInfo_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivitDoubleDungeonInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.ActivityId != 0)
		{
			ActivityId = other.ActivityId;
		}
		if (other.activityBaseInfo_ != null)
		{
			if (activityBaseInfo_ == null)
			{
				ActivityBaseInfo = new ActivityBaseInfo();
			}
			ActivityBaseInfo.MergeFrom(other.ActivityBaseInfo);
		}
		dungeonInfo_.Add(other.dungeonInfo_);
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
				if (activityBaseInfo_ == null)
				{
					ActivityBaseInfo = new ActivityBaseInfo();
				}
				input.ReadMessage(ActivityBaseInfo);
				break;
			case 26u:
				dungeonInfo_.AddEntriesFrom(ref input, _map_dungeonInfo_codec);
				break;
			}
		}
	}
}
