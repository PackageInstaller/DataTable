using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class AchievementProgressData : IMessage<AchievementProgressData>, IMessage, IEquatable<AchievementProgressData>, IDeepCloneable<AchievementProgressData>, IBufferMessage
{
	private static readonly MessageParser<AchievementProgressData> _parser = new MessageParser<AchievementProgressData>(() => new AchievementProgressData());

	private UnknownFieldSet _unknownFields;

	public const int AchievementsProgressFieldNumber = 1;

	private static readonly MapField<int, AchievementProgress>.Codec _map_achievementsProgress_codec = new MapField<int, AchievementProgress>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, AchievementProgress.Parser), 10u);

	private readonly MapField<int, AchievementProgress> achievementsProgress_ = new MapField<int, AchievementProgress>();

	public const int TookAchievementGroupRewardsFieldNumber = 2;

	private static readonly MapField<int, bool>.Codec _map_tookAchievementGroupRewards_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 18u);

	private readonly MapField<int, bool> tookAchievementGroupRewards_ = new MapField<int, bool>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AchievementProgressData> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[214];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, AchievementProgress> AchievementsProgress => achievementsProgress_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> TookAchievementGroupRewards => tookAchievementGroupRewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementProgressData()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementProgressData(AchievementProgressData other)
		: this()
	{
		achievementsProgress_ = other.achievementsProgress_.Clone();
		tookAchievementGroupRewards_ = other.tookAchievementGroupRewards_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementProgressData Clone()
	{
		return new AchievementProgressData(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AchievementProgressData);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AchievementProgressData other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!AchievementsProgress.Equals(other.AchievementsProgress))
		{
			return false;
		}
		if (!TookAchievementGroupRewards.Equals(other.TookAchievementGroupRewards))
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
		num ^= AchievementsProgress.GetHashCode();
		num ^= TookAchievementGroupRewards.GetHashCode();
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
		achievementsProgress_.WriteTo(ref output, _map_achievementsProgress_codec);
		tookAchievementGroupRewards_.WriteTo(ref output, _map_tookAchievementGroupRewards_codec);
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
		num += achievementsProgress_.CalculateSize(_map_achievementsProgress_codec);
		num += tookAchievementGroupRewards_.CalculateSize(_map_tookAchievementGroupRewards_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AchievementProgressData other)
	{
		if (other != null)
		{
			achievementsProgress_.Add(other.achievementsProgress_);
			tookAchievementGroupRewards_.Add(other.tookAchievementGroupRewards_);
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
				achievementsProgress_.AddEntriesFrom(ref input, _map_achievementsProgress_codec);
				break;
			case 18u:
				tookAchievementGroupRewards_.AddEntriesFrom(ref input, _map_tookAchievementGroupRewards_codec);
				break;
			}
		}
	}
}
