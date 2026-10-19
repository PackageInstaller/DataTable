using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class DetailUserInfo : IMessage<DetailUserInfo>, IMessage, IEquatable<DetailUserInfo>, IDeepCloneable<DetailUserInfo>, IBufferMessage
{
	private static readonly MessageParser<DetailUserInfo> _parser = new MessageParser<DetailUserInfo>(() => new DetailUserInfo());

	private UnknownFieldSet _unknownFields;

	public const int BriefFieldNumber = 1;

	private BriefUserInfo brief_;

	public const int AttributesFieldNumber = 2;

	private static readonly MapField<int, long>.Codec _map_attributes_codec = new MapField<int, long>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt64(16u, 0L), 18u);

	private readonly MapField<int, long> attributes_ = new MapField<int, long>();

	public const int CountsFieldNumber = 3;

	private static readonly MapField<int, long>.Codec _map_counts_codec = new MapField<int, long>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt64(16u, 0L), 26u);

	private readonly MapField<int, long> counts_ = new MapField<int, long>();

	public const int DailyCountsFieldNumber = 4;

	private static readonly MapField<int, long>.Codec _map_dailyCounts_codec = new MapField<int, long>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt64(16u, 0L), 34u);

	private readonly MapField<int, long> dailyCounts_ = new MapField<int, long>();

	public const int ConditionsFieldNumber = 5;

	private static readonly MapField<int, long>.Codec _map_conditions_codec = new MapField<int, long>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt64(16u, 0L), 42u);

	private readonly MapField<int, long> conditions_ = new MapField<int, long>();

	public const int DailyConditionsFieldNumber = 6;

	private static readonly MapField<int, long>.Codec _map_dailyConditions_codec = new MapField<int, long>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt64(16u, 0L), 50u);

	private readonly MapField<int, long> dailyConditions_ = new MapField<int, long>();

	public const int WeekCountsFieldNumber = 7;

	private static readonly MapField<int, long>.Codec _map_weekCounts_codec = new MapField<int, long>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt64(16u, 0L), 58u);

	private readonly MapField<int, long> weekCounts_ = new MapField<int, long>();

	public const int ProfileFieldNumber = 8;

	private PlayerProfile profile_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<DetailUserInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[8];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BriefUserInfo Brief
	{
		get
		{
			return brief_;
		}
		set
		{
			brief_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, long> Attributes => attributes_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, long> Counts => counts_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, long> DailyCounts => dailyCounts_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, long> Conditions => conditions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, long> DailyConditions => dailyConditions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, long> WeekCounts => weekCounts_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerProfile Profile
	{
		get
		{
			return profile_;
		}
		set
		{
			profile_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DetailUserInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DetailUserInfo(DetailUserInfo other)
		: this()
	{
		brief_ = ((other.brief_ != null) ? other.brief_.Clone() : null);
		attributes_ = other.attributes_.Clone();
		counts_ = other.counts_.Clone();
		dailyCounts_ = other.dailyCounts_.Clone();
		conditions_ = other.conditions_.Clone();
		dailyConditions_ = other.dailyConditions_.Clone();
		weekCounts_ = other.weekCounts_.Clone();
		profile_ = ((other.profile_ != null) ? other.profile_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DetailUserInfo Clone()
	{
		return new DetailUserInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as DetailUserInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(DetailUserInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Brief, other.Brief))
		{
			return false;
		}
		if (!Attributes.Equals(other.Attributes))
		{
			return false;
		}
		if (!Counts.Equals(other.Counts))
		{
			return false;
		}
		if (!DailyCounts.Equals(other.DailyCounts))
		{
			return false;
		}
		if (!Conditions.Equals(other.Conditions))
		{
			return false;
		}
		if (!DailyConditions.Equals(other.DailyConditions))
		{
			return false;
		}
		if (!WeekCounts.Equals(other.WeekCounts))
		{
			return false;
		}
		if (!object.Equals(Profile, other.Profile))
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
		if (brief_ != null)
		{
			num ^= Brief.GetHashCode();
		}
		num ^= Attributes.GetHashCode();
		num ^= Counts.GetHashCode();
		num ^= DailyCounts.GetHashCode();
		num ^= Conditions.GetHashCode();
		num ^= DailyConditions.GetHashCode();
		num ^= WeekCounts.GetHashCode();
		if (profile_ != null)
		{
			num ^= Profile.GetHashCode();
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
		if (brief_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Brief);
		}
		attributes_.WriteTo(ref output, _map_attributes_codec);
		counts_.WriteTo(ref output, _map_counts_codec);
		dailyCounts_.WriteTo(ref output, _map_dailyCounts_codec);
		conditions_.WriteTo(ref output, _map_conditions_codec);
		dailyConditions_.WriteTo(ref output, _map_dailyConditions_codec);
		weekCounts_.WriteTo(ref output, _map_weekCounts_codec);
		if (profile_ != null)
		{
			output.WriteRawTag(66);
			output.WriteMessage(Profile);
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
		if (brief_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Brief);
		}
		num += attributes_.CalculateSize(_map_attributes_codec);
		num += counts_.CalculateSize(_map_counts_codec);
		num += dailyCounts_.CalculateSize(_map_dailyCounts_codec);
		num += conditions_.CalculateSize(_map_conditions_codec);
		num += dailyConditions_.CalculateSize(_map_dailyConditions_codec);
		num += weekCounts_.CalculateSize(_map_weekCounts_codec);
		if (profile_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Profile);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(DetailUserInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.brief_ != null)
		{
			if (brief_ == null)
			{
				Brief = new BriefUserInfo();
			}
			Brief.MergeFrom(other.Brief);
		}
		attributes_.Add(other.attributes_);
		counts_.Add(other.counts_);
		dailyCounts_.Add(other.dailyCounts_);
		conditions_.Add(other.conditions_);
		dailyConditions_.Add(other.dailyConditions_);
		weekCounts_.Add(other.weekCounts_);
		if (other.profile_ != null)
		{
			if (profile_ == null)
			{
				Profile = new PlayerProfile();
			}
			Profile.MergeFrom(other.Profile);
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
			case 10u:
				if (brief_ == null)
				{
					Brief = new BriefUserInfo();
				}
				input.ReadMessage(Brief);
				break;
			case 18u:
				attributes_.AddEntriesFrom(ref input, _map_attributes_codec);
				break;
			case 26u:
				counts_.AddEntriesFrom(ref input, _map_counts_codec);
				break;
			case 34u:
				dailyCounts_.AddEntriesFrom(ref input, _map_dailyCounts_codec);
				break;
			case 42u:
				conditions_.AddEntriesFrom(ref input, _map_conditions_codec);
				break;
			case 50u:
				dailyConditions_.AddEntriesFrom(ref input, _map_dailyConditions_codec);
				break;
			case 58u:
				weekCounts_.AddEntriesFrom(ref input, _map_weekCounts_codec);
				break;
			case 66u:
				if (profile_ == null)
				{
					Profile = new PlayerProfile();
				}
				input.ReadMessage(Profile);
				break;
			}
		}
	}

	public void ApplyChanges(AttributeNtf attributeNtf, bool reset)
	{
		foreach (KeyValuePair<int, long> change in attributeNtf.Changes)
		{
			attributes_[change.Key] = change.Value;
		}
	}
}
