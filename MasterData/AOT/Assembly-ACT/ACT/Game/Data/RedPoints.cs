using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class RedPoints : IMessage<RedPoints>, IMessage, IEquatable<RedPoints>, IDeepCloneable<RedPoints>, IBufferMessage
{
	private static readonly MessageParser<RedPoints> _parser = new MessageParser<RedPoints>(() => new RedPoints());

	private UnknownFieldSet _unknownFields;

	public const int MissionsFieldNumber = 1;

	private static readonly MapField<int, bool>.Codec _map_missions_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 10u);

	private readonly MapField<int, bool> missions_ = new MapField<int, bool>();

	public const int ItemsFieldNumber = 2;

	private static readonly MapField<int, bool>.Codec _map_items_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 18u);

	private readonly MapField<int, bool> items_ = new MapField<int, bool>();

	public const int CustomerComplaintFieldNumber = 3;

	private static readonly MapField<int, bool>.Codec _map_customerComplaint_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 26u);

	private readonly MapField<int, bool> customerComplaint_ = new MapField<int, bool>();

	public const int ActivitysFieldNumber = 4;

	private static readonly MapField<int, bool>.Codec _map_activitys_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 34u);

	private readonly MapField<int, bool> activitys_ = new MapField<int, bool>();

	public const int EquipsFieldNumber = 5;

	private static readonly MapField<int, bool>.Codec _map_equips_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 42u);

	private readonly MapField<int, bool> equips_ = new MapField<int, bool>();

	public const int GemsFieldNumber = 6;

	private static readonly MapField<int, bool>.Codec _map_gems_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 50u);

	private readonly MapField<int, bool> gems_ = new MapField<int, bool>();

	public const int CharactersFieldNumber = 7;

	private static readonly MapField<int, bool>.Codec _map_characters_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 58u);

	private readonly MapField<int, bool> characters_ = new MapField<int, bool>();

	public const int ActivityChallengesFieldNumber = 8;

	private static readonly MapField<int, bool>.Codec _map_activityChallenges_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 66u);

	private readonly MapField<int, bool> activityChallenges_ = new MapField<int, bool>();

	public const int SystemsFieldNumber = 9;

	private static readonly MapField<int, bool>.Codec _map_systems_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 74u);

	private readonly MapField<int, bool> systems_ = new MapField<int, bool>();

	public const int RaidRateFieldNumber = 10;

	private static readonly MapField<int, RaidRateRedPoint>.Codec _map_raidRate_codec = new MapField<int, RaidRateRedPoint>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, RaidRateRedPoint.Parser), 82u);

	private readonly MapField<int, RaidRateRedPoint> raidRate_ = new MapField<int, RaidRateRedPoint>();

	public const int BattlePassFieldNumber = 11;

	private static readonly MapField<int, bool>.Codec _map_battlePass_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 90u);

	private readonly MapField<int, bool> battlePass_ = new MapField<int, bool>();

	public const int AreaExploreRedPointFieldNumber = 12;

	private static readonly MapField<int, AreaExploreRedPoint>.Codec _map_areaExploreRedPoint_codec = new MapField<int, AreaExploreRedPoint>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ACT.Game.Data.AreaExploreRedPoint.Parser), 98u);

	private readonly MapField<int, AreaExploreRedPoint> areaExploreRedPoint_ = new MapField<int, AreaExploreRedPoint>();

	public const int AvatarsFieldNumber = 13;

	private static readonly MapField<int, bool>.Codec _map_avatars_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 106u);

	private readonly MapField<int, bool> avatars_ = new MapField<int, bool>();

	public const int AvatarFramesFieldNumber = 14;

	private static readonly MapField<int, bool>.Codec _map_avatarFrames_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 114u);

	private readonly MapField<int, bool> avatarFrames_ = new MapField<int, bool>();

	public const int TitlesFieldNumber = 15;

	private static readonly MapField<int, bool>.Codec _map_titles_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 122u);

	private readonly MapField<int, bool> titles_ = new MapField<int, bool>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RedPoints> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[226];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> Missions => missions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> Items => items_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> CustomerComplaint => customerComplaint_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> Activitys => activitys_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> Equips => equips_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> Gems => gems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> Characters => characters_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> ActivityChallenges => activityChallenges_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> Systems => systems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, RaidRateRedPoint> RaidRate => raidRate_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> BattlePass => battlePass_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, AreaExploreRedPoint> AreaExploreRedPoint => areaExploreRedPoint_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> Avatars => avatars_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> AvatarFrames => avatarFrames_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> Titles => titles_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RedPoints()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RedPoints(RedPoints other)
		: this()
	{
		missions_ = other.missions_.Clone();
		items_ = other.items_.Clone();
		customerComplaint_ = other.customerComplaint_.Clone();
		activitys_ = other.activitys_.Clone();
		equips_ = other.equips_.Clone();
		gems_ = other.gems_.Clone();
		characters_ = other.characters_.Clone();
		activityChallenges_ = other.activityChallenges_.Clone();
		systems_ = other.systems_.Clone();
		raidRate_ = other.raidRate_.Clone();
		battlePass_ = other.battlePass_.Clone();
		areaExploreRedPoint_ = other.areaExploreRedPoint_.Clone();
		avatars_ = other.avatars_.Clone();
		avatarFrames_ = other.avatarFrames_.Clone();
		titles_ = other.titles_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RedPoints Clone()
	{
		return new RedPoints(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RedPoints);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RedPoints other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Missions.Equals(other.Missions))
		{
			return false;
		}
		if (!Items.Equals(other.Items))
		{
			return false;
		}
		if (!CustomerComplaint.Equals(other.CustomerComplaint))
		{
			return false;
		}
		if (!Activitys.Equals(other.Activitys))
		{
			return false;
		}
		if (!Equips.Equals(other.Equips))
		{
			return false;
		}
		if (!Gems.Equals(other.Gems))
		{
			return false;
		}
		if (!Characters.Equals(other.Characters))
		{
			return false;
		}
		if (!ActivityChallenges.Equals(other.ActivityChallenges))
		{
			return false;
		}
		if (!Systems.Equals(other.Systems))
		{
			return false;
		}
		if (!RaidRate.Equals(other.RaidRate))
		{
			return false;
		}
		if (!BattlePass.Equals(other.BattlePass))
		{
			return false;
		}
		if (!AreaExploreRedPoint.Equals(other.AreaExploreRedPoint))
		{
			return false;
		}
		if (!Avatars.Equals(other.Avatars))
		{
			return false;
		}
		if (!AvatarFrames.Equals(other.AvatarFrames))
		{
			return false;
		}
		if (!Titles.Equals(other.Titles))
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
		num ^= Missions.GetHashCode();
		num ^= Items.GetHashCode();
		num ^= CustomerComplaint.GetHashCode();
		num ^= Activitys.GetHashCode();
		num ^= Equips.GetHashCode();
		num ^= Gems.GetHashCode();
		num ^= Characters.GetHashCode();
		num ^= ActivityChallenges.GetHashCode();
		num ^= Systems.GetHashCode();
		num ^= RaidRate.GetHashCode();
		num ^= BattlePass.GetHashCode();
		num ^= AreaExploreRedPoint.GetHashCode();
		num ^= Avatars.GetHashCode();
		num ^= AvatarFrames.GetHashCode();
		num ^= Titles.GetHashCode();
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
		missions_.WriteTo(ref output, _map_missions_codec);
		items_.WriteTo(ref output, _map_items_codec);
		customerComplaint_.WriteTo(ref output, _map_customerComplaint_codec);
		activitys_.WriteTo(ref output, _map_activitys_codec);
		equips_.WriteTo(ref output, _map_equips_codec);
		gems_.WriteTo(ref output, _map_gems_codec);
		characters_.WriteTo(ref output, _map_characters_codec);
		activityChallenges_.WriteTo(ref output, _map_activityChallenges_codec);
		systems_.WriteTo(ref output, _map_systems_codec);
		raidRate_.WriteTo(ref output, _map_raidRate_codec);
		battlePass_.WriteTo(ref output, _map_battlePass_codec);
		areaExploreRedPoint_.WriteTo(ref output, _map_areaExploreRedPoint_codec);
		avatars_.WriteTo(ref output, _map_avatars_codec);
		avatarFrames_.WriteTo(ref output, _map_avatarFrames_codec);
		titles_.WriteTo(ref output, _map_titles_codec);
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
		num += missions_.CalculateSize(_map_missions_codec);
		num += items_.CalculateSize(_map_items_codec);
		num += customerComplaint_.CalculateSize(_map_customerComplaint_codec);
		num += activitys_.CalculateSize(_map_activitys_codec);
		num += equips_.CalculateSize(_map_equips_codec);
		num += gems_.CalculateSize(_map_gems_codec);
		num += characters_.CalculateSize(_map_characters_codec);
		num += activityChallenges_.CalculateSize(_map_activityChallenges_codec);
		num += systems_.CalculateSize(_map_systems_codec);
		num += raidRate_.CalculateSize(_map_raidRate_codec);
		num += battlePass_.CalculateSize(_map_battlePass_codec);
		num += areaExploreRedPoint_.CalculateSize(_map_areaExploreRedPoint_codec);
		num += avatars_.CalculateSize(_map_avatars_codec);
		num += avatarFrames_.CalculateSize(_map_avatarFrames_codec);
		num += titles_.CalculateSize(_map_titles_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RedPoints other)
	{
		if (other != null)
		{
			missions_.Add(other.missions_);
			items_.Add(other.items_);
			customerComplaint_.Add(other.customerComplaint_);
			activitys_.Add(other.activitys_);
			equips_.Add(other.equips_);
			gems_.Add(other.gems_);
			characters_.Add(other.characters_);
			activityChallenges_.Add(other.activityChallenges_);
			systems_.Add(other.systems_);
			raidRate_.Add(other.raidRate_);
			battlePass_.Add(other.battlePass_);
			areaExploreRedPoint_.Add(other.areaExploreRedPoint_);
			avatars_.Add(other.avatars_);
			avatarFrames_.Add(other.avatarFrames_);
			titles_.Add(other.titles_);
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
				missions_.AddEntriesFrom(ref input, _map_missions_codec);
				break;
			case 18u:
				items_.AddEntriesFrom(ref input, _map_items_codec);
				break;
			case 26u:
				customerComplaint_.AddEntriesFrom(ref input, _map_customerComplaint_codec);
				break;
			case 34u:
				activitys_.AddEntriesFrom(ref input, _map_activitys_codec);
				break;
			case 42u:
				equips_.AddEntriesFrom(ref input, _map_equips_codec);
				break;
			case 50u:
				gems_.AddEntriesFrom(ref input, _map_gems_codec);
				break;
			case 58u:
				characters_.AddEntriesFrom(ref input, _map_characters_codec);
				break;
			case 66u:
				activityChallenges_.AddEntriesFrom(ref input, _map_activityChallenges_codec);
				break;
			case 74u:
				systems_.AddEntriesFrom(ref input, _map_systems_codec);
				break;
			case 82u:
				raidRate_.AddEntriesFrom(ref input, _map_raidRate_codec);
				break;
			case 90u:
				battlePass_.AddEntriesFrom(ref input, _map_battlePass_codec);
				break;
			case 98u:
				areaExploreRedPoint_.AddEntriesFrom(ref input, _map_areaExploreRedPoint_codec);
				break;
			case 106u:
				avatars_.AddEntriesFrom(ref input, _map_avatars_codec);
				break;
			case 114u:
				avatarFrames_.AddEntriesFrom(ref input, _map_avatarFrames_codec);
				break;
			case 122u:
				titles_.AddEntriesFrom(ref input, _map_titles_codec);
				break;
			}
		}
	}
}
