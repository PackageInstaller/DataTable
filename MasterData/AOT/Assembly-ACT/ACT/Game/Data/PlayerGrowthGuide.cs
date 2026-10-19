using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class PlayerGrowthGuide : IMessage<PlayerGrowthGuide>, IMessage, IEquatable<PlayerGrowthGuide>, IDeepCloneable<PlayerGrowthGuide>, IBufferMessage
{
	private static readonly MessageParser<PlayerGrowthGuide> _parser = new MessageParser<PlayerGrowthGuide>(() => new PlayerGrowthGuide());

	private UnknownFieldSet _unknownFields;

	public const int ClaimedMissionRewardFieldNumber = 1;

	private static readonly MapField<int, bool>.Codec _map_claimedMissionReward_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 10u);

	private readonly MapField<int, bool> claimedMissionReward_ = new MapField<int, bool>();

	public const int ClaimedChapterRewardFieldNumber = 2;

	private static readonly MapField<int, bool>.Codec _map_claimedChapterReward_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 18u);

	private readonly MapField<int, bool> claimedChapterReward_ = new MapField<int, bool>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<PlayerGrowthGuide> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[128];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> ClaimedMissionReward => claimedMissionReward_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> ClaimedChapterReward => claimedChapterReward_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerGrowthGuide()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerGrowthGuide(PlayerGrowthGuide other)
		: this()
	{
		claimedMissionReward_ = other.claimedMissionReward_.Clone();
		claimedChapterReward_ = other.claimedChapterReward_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerGrowthGuide Clone()
	{
		return new PlayerGrowthGuide(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as PlayerGrowthGuide);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(PlayerGrowthGuide other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!ClaimedMissionReward.Equals(other.ClaimedMissionReward))
		{
			return false;
		}
		if (!ClaimedChapterReward.Equals(other.ClaimedChapterReward))
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
		num ^= ClaimedMissionReward.GetHashCode();
		num ^= ClaimedChapterReward.GetHashCode();
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
		claimedMissionReward_.WriteTo(ref output, _map_claimedMissionReward_codec);
		claimedChapterReward_.WriteTo(ref output, _map_claimedChapterReward_codec);
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
		num += claimedMissionReward_.CalculateSize(_map_claimedMissionReward_codec);
		num += claimedChapterReward_.CalculateSize(_map_claimedChapterReward_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(PlayerGrowthGuide other)
	{
		if (other != null)
		{
			claimedMissionReward_.Add(other.claimedMissionReward_);
			claimedChapterReward_.Add(other.claimedChapterReward_);
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
				claimedMissionReward_.AddEntriesFrom(ref input, _map_claimedMissionReward_codec);
				break;
			case 18u:
				claimedChapterReward_.AddEntriesFrom(ref input, _map_claimedChapterReward_codec);
				break;
			}
		}
	}
}
