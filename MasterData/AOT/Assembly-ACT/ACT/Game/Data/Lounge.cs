using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Lounge : IMessage<Lounge>, IMessage, IEquatable<Lounge>, IDeepCloneable<Lounge>, IBufferMessage
{
	private static readonly MessageParser<Lounge> _parser = new MessageParser<Lounge>(() => new Lounge());

	private UnknownFieldSet _unknownFields;

	public const int CurrentGlobalStoryIDFieldNumber = 1;

	private int currentGlobalStoryID_;

	public const int LoungeInteractPointsFieldNumber = 2;

	private static readonly MapField<int, LoungeInteractPoint>.Codec _map_loungeInteractPoints_codec = new MapField<int, LoungeInteractPoint>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, LoungeInteractPoint.Parser), 18u);

	private readonly MapField<int, LoungeInteractPoint> loungeInteractPoints_ = new MapField<int, LoungeInteractPoint>();

	public const int TriggeredStoriesFieldNumber = 3;

	private static readonly MapField<int, bool>.Codec _map_triggeredStories_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 26u);

	private readonly MapField<int, bool> triggeredStories_ = new MapField<int, bool>();

	public const int TodayInvitationCountFieldNumber = 4;

	private int todayInvitationCount_;

	public const int GreetInfoFieldNumber = 6;

	private static readonly MapField<int, LoungeCharacterGreetInfo>.Codec _map_greetInfo_codec = new MapField<int, LoungeCharacterGreetInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, LoungeCharacterGreetInfo.Parser), 50u);

	private readonly MapField<int, LoungeCharacterGreetInfo> greetInfo_ = new MapField<int, LoungeCharacterGreetInfo>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Lounge> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[287];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurrentGlobalStoryID
	{
		get
		{
			return currentGlobalStoryID_;
		}
		set
		{
			currentGlobalStoryID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, LoungeInteractPoint> LoungeInteractPoints => loungeInteractPoints_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> TriggeredStories => triggeredStories_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TodayInvitationCount
	{
		get
		{
			return todayInvitationCount_;
		}
		set
		{
			todayInvitationCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, LoungeCharacterGreetInfo> GreetInfo => greetInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Lounge()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Lounge(Lounge other)
		: this()
	{
		currentGlobalStoryID_ = other.currentGlobalStoryID_;
		loungeInteractPoints_ = other.loungeInteractPoints_.Clone();
		triggeredStories_ = other.triggeredStories_.Clone();
		todayInvitationCount_ = other.todayInvitationCount_;
		greetInfo_ = other.greetInfo_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Lounge Clone()
	{
		return new Lounge(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Lounge);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Lounge other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (CurrentGlobalStoryID != other.CurrentGlobalStoryID)
		{
			return false;
		}
		if (!LoungeInteractPoints.Equals(other.LoungeInteractPoints))
		{
			return false;
		}
		if (!TriggeredStories.Equals(other.TriggeredStories))
		{
			return false;
		}
		if (TodayInvitationCount != other.TodayInvitationCount)
		{
			return false;
		}
		if (!GreetInfo.Equals(other.GreetInfo))
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
		if (CurrentGlobalStoryID != 0)
		{
			num ^= CurrentGlobalStoryID.GetHashCode();
		}
		num ^= LoungeInteractPoints.GetHashCode();
		num ^= TriggeredStories.GetHashCode();
		if (TodayInvitationCount != 0)
		{
			num ^= TodayInvitationCount.GetHashCode();
		}
		num ^= GreetInfo.GetHashCode();
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
		if (CurrentGlobalStoryID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(CurrentGlobalStoryID);
		}
		loungeInteractPoints_.WriteTo(ref output, _map_loungeInteractPoints_codec);
		triggeredStories_.WriteTo(ref output, _map_triggeredStories_codec);
		if (TodayInvitationCount != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(TodayInvitationCount);
		}
		greetInfo_.WriteTo(ref output, _map_greetInfo_codec);
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
		if (CurrentGlobalStoryID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurrentGlobalStoryID);
		}
		num += loungeInteractPoints_.CalculateSize(_map_loungeInteractPoints_codec);
		num += triggeredStories_.CalculateSize(_map_triggeredStories_codec);
		if (TodayInvitationCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TodayInvitationCount);
		}
		num += greetInfo_.CalculateSize(_map_greetInfo_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Lounge other)
	{
		if (other != null)
		{
			if (other.CurrentGlobalStoryID != 0)
			{
				CurrentGlobalStoryID = other.CurrentGlobalStoryID;
			}
			loungeInteractPoints_.Add(other.loungeInteractPoints_);
			triggeredStories_.Add(other.triggeredStories_);
			if (other.TodayInvitationCount != 0)
			{
				TodayInvitationCount = other.TodayInvitationCount;
			}
			greetInfo_.Add(other.greetInfo_);
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
				CurrentGlobalStoryID = input.ReadInt32();
				break;
			case 18u:
				loungeInteractPoints_.AddEntriesFrom(ref input, _map_loungeInteractPoints_codec);
				break;
			case 26u:
				triggeredStories_.AddEntriesFrom(ref input, _map_triggeredStories_codec);
				break;
			case 32u:
				TodayInvitationCount = input.ReadInt32();
				break;
			case 50u:
				greetInfo_.AddEntriesFrom(ref input, _map_greetInfo_codec);
				break;
			}
		}
	}
}
