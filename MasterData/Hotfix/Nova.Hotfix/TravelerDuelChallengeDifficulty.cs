using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TravelerDuelChallengeDifficulty : IMessage<TravelerDuelChallengeDifficulty>, IMessage, IEquatable<TravelerDuelChallengeDifficulty>, IDeepCloneable<TravelerDuelChallengeDifficulty>
{
	private static readonly MessageParser<TravelerDuelChallengeDifficulty> _parser = new MessageParser<TravelerDuelChallengeDifficulty>(() => new TravelerDuelChallengeDifficulty());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int AttrFieldNumber = 2;

	private int attr_;

	public const int EffectIdFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_effectId_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> effectId_ = new RepeatedField<int>();

	public const int RecommendBuildRankFieldNumber = 4;

	private int recommendBuildRank_;

	public const int RecommendLevelFieldNumber = 5;

	private int recommendLevel_;

	[DebuggerNonUserCode]
	public static MessageParser<TravelerDuelChallengeDifficulty> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1010);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
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
	public int Attr
	{
		get
		{
			return attr_;
		}
		set
		{
			attr_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> EffectId => effectId_;

	[DebuggerNonUserCode]
	public int RecommendBuildRank
	{
		get
		{
			return recommendBuildRank_;
		}
		set
		{
			recommendBuildRank_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RecommendLevel
	{
		get
		{
			return recommendLevel_;
		}
		set
		{
			recommendLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TravelerDuelChallengeDifficulty()
	{
	}

	[DebuggerNonUserCode]
	public TravelerDuelChallengeDifficulty(TravelerDuelChallengeDifficulty other)
		: this()
	{
		id_ = other.id_;
		attr_ = other.attr_;
		effectId_ = other.effectId_.Clone();
		recommendBuildRank_ = other.recommendBuildRank_;
		recommendLevel_ = other.recommendLevel_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TravelerDuelChallengeDifficulty Clone()
	{
		return new TravelerDuelChallengeDifficulty(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TravelerDuelChallengeDifficulty);
	}

	[DebuggerNonUserCode]
	public bool Equals(TravelerDuelChallengeDifficulty other)
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
		if (Attr != other.Attr)
		{
			return false;
		}
		if (!effectId_.Equals(other.effectId_))
		{
			return false;
		}
		if (RecommendBuildRank != other.RecommendBuildRank)
		{
			return false;
		}
		if (RecommendLevel != other.RecommendLevel)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Attr != 0)
		{
			num ^= Attr.GetHashCode();
		}
		num ^= effectId_.GetHashCode();
		if (RecommendBuildRank != 0)
		{
			num ^= RecommendBuildRank.GetHashCode();
		}
		if (RecommendLevel != 0)
		{
			num ^= RecommendLevel.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (Attr != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Attr);
		}
		effectId_.WriteTo(output, _repeated_effectId_codec);
		if (RecommendBuildRank != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(RecommendBuildRank);
		}
		if (RecommendLevel != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(RecommendLevel);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (Attr != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Attr);
		}
		num += effectId_.CalculateSize(_repeated_effectId_codec);
		if (RecommendBuildRank != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RecommendBuildRank);
		}
		if (RecommendLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RecommendLevel);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TravelerDuelChallengeDifficulty other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Attr != 0)
			{
				Attr = other.Attr;
			}
			effectId_.Add(other.effectId_);
			if (other.RecommendBuildRank != 0)
			{
				RecommendBuildRank = other.RecommendBuildRank;
			}
			if (other.RecommendLevel != 0)
			{
				RecommendLevel = other.RecommendLevel;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				Attr = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				effectId_.AddEntriesFrom(input, _repeated_effectId_codec);
				break;
			case 32u:
				RecommendBuildRank = input.ReadInt32();
				break;
			case 40u:
				RecommendLevel = input.ReadInt32();
				break;
			}
		}
	}
}
