using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ScoreBossLevel : IMessage<ScoreBossLevel>, IMessage, IEquatable<ScoreBossLevel>, IDeepCloneable<ScoreBossLevel>
{
	private static readonly MessageParser<ScoreBossLevel> _parser = new MessageParser<ScoreBossLevel>(() => new ScoreBossLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int FloorIdFieldNumber = 2;

	private int floorId_;

	public const int MonsterIdFieldNumber = 3;

	private int monsterId_;

	public const int NonDamageScoreGetFieldNumber = 4;

	private int nonDamageScoreGet_;

	public const int ScoreBossAbilityFieldNumber = 5;

	private int scoreBossAbility_;

	public const int ScoreGetSwitchGroupFieldNumber = 6;

	private int scoreGetSwitchGroup_;

	public const int EpisodeFieldNumber = 7;

	private string episode_ = "";

	public const int ImageFieldNumber = 8;

	private string image_ = "";

	public const int BGFieldNumber = 9;

	private string bG_ = "";

	public const int SummonLevelUpFieldNumber = 10;

	private bool summonLevelUp_;

	public const int ExtraImageFieldNumber = 11;

	private string extraImage_ = "";

	public const int ExtraImageAniFieldNumber = 12;

	private string extraImageAni_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<ScoreBossLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(698);

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
	public int FloorId
	{
		get
		{
			return floorId_;
		}
		set
		{
			floorId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MonsterId
	{
		get
		{
			return monsterId_;
		}
		set
		{
			monsterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NonDamageScoreGet
	{
		get
		{
			return nonDamageScoreGet_;
		}
		set
		{
			nonDamageScoreGet_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ScoreBossAbility
	{
		get
		{
			return scoreBossAbility_;
		}
		set
		{
			scoreBossAbility_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ScoreGetSwitchGroup
	{
		get
		{
			return scoreGetSwitchGroup_;
		}
		set
		{
			scoreGetSwitchGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Episode
	{
		get
		{
			return episode_;
		}
		set
		{
			episode_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Image
	{
		get
		{
			return image_;
		}
		set
		{
			image_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BG
	{
		get
		{
			return bG_;
		}
		set
		{
			bG_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool SummonLevelUp
	{
		get
		{
			return summonLevelUp_;
		}
		set
		{
			summonLevelUp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ExtraImage
	{
		get
		{
			return extraImage_;
		}
		set
		{
			extraImage_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ExtraImageAni
	{
		get
		{
			return extraImageAni_;
		}
		set
		{
			extraImageAni_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public ScoreBossLevel()
	{
	}

	[DebuggerNonUserCode]
	public ScoreBossLevel(ScoreBossLevel other)
		: this()
	{
		id_ = other.id_;
		floorId_ = other.floorId_;
		monsterId_ = other.monsterId_;
		nonDamageScoreGet_ = other.nonDamageScoreGet_;
		scoreBossAbility_ = other.scoreBossAbility_;
		scoreGetSwitchGroup_ = other.scoreGetSwitchGroup_;
		episode_ = other.episode_;
		image_ = other.image_;
		bG_ = other.bG_;
		summonLevelUp_ = other.summonLevelUp_;
		extraImage_ = other.extraImage_;
		extraImageAni_ = other.extraImageAni_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ScoreBossLevel Clone()
	{
		return new ScoreBossLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ScoreBossLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(ScoreBossLevel other)
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
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (MonsterId != other.MonsterId)
		{
			return false;
		}
		if (NonDamageScoreGet != other.NonDamageScoreGet)
		{
			return false;
		}
		if (ScoreBossAbility != other.ScoreBossAbility)
		{
			return false;
		}
		if (ScoreGetSwitchGroup != other.ScoreGetSwitchGroup)
		{
			return false;
		}
		if (Episode != other.Episode)
		{
			return false;
		}
		if (Image != other.Image)
		{
			return false;
		}
		if (BG != other.BG)
		{
			return false;
		}
		if (SummonLevelUp != other.SummonLevelUp)
		{
			return false;
		}
		if (ExtraImage != other.ExtraImage)
		{
			return false;
		}
		if (ExtraImageAni != other.ExtraImageAni)
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
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (MonsterId != 0)
		{
			num ^= MonsterId.GetHashCode();
		}
		if (NonDamageScoreGet != 0)
		{
			num ^= NonDamageScoreGet.GetHashCode();
		}
		if (ScoreBossAbility != 0)
		{
			num ^= ScoreBossAbility.GetHashCode();
		}
		if (ScoreGetSwitchGroup != 0)
		{
			num ^= ScoreGetSwitchGroup.GetHashCode();
		}
		if (Episode.Length != 0)
		{
			num ^= Episode.GetHashCode();
		}
		if (Image.Length != 0)
		{
			num ^= Image.GetHashCode();
		}
		if (BG.Length != 0)
		{
			num ^= BG.GetHashCode();
		}
		if (SummonLevelUp)
		{
			num ^= SummonLevelUp.GetHashCode();
		}
		if (ExtraImage.Length != 0)
		{
			num ^= ExtraImage.GetHashCode();
		}
		if (ExtraImageAni.Length != 0)
		{
			num ^= ExtraImageAni.GetHashCode();
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
		if (FloorId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(FloorId);
		}
		if (MonsterId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(MonsterId);
		}
		if (NonDamageScoreGet != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(NonDamageScoreGet);
		}
		if (ScoreBossAbility != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ScoreBossAbility);
		}
		if (ScoreGetSwitchGroup != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ScoreGetSwitchGroup);
		}
		if (Episode.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Episode);
		}
		if (Image.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Image);
		}
		if (BG.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(BG);
		}
		if (SummonLevelUp)
		{
			output.WriteRawTag(80);
			output.WriteBool(SummonLevelUp);
		}
		if (ExtraImage.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(ExtraImage);
		}
		if (ExtraImageAni.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(ExtraImageAni);
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
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (MonsterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterId);
		}
		if (NonDamageScoreGet != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NonDamageScoreGet);
		}
		if (ScoreBossAbility != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ScoreBossAbility);
		}
		if (ScoreGetSwitchGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ScoreGetSwitchGroup);
		}
		if (Episode.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Episode);
		}
		if (Image.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Image);
		}
		if (BG.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BG);
		}
		if (SummonLevelUp)
		{
			num += 2;
		}
		if (ExtraImage.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ExtraImage);
		}
		if (ExtraImageAni.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ExtraImageAni);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ScoreBossLevel other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.MonsterId != 0)
			{
				MonsterId = other.MonsterId;
			}
			if (other.NonDamageScoreGet != 0)
			{
				NonDamageScoreGet = other.NonDamageScoreGet;
			}
			if (other.ScoreBossAbility != 0)
			{
				ScoreBossAbility = other.ScoreBossAbility;
			}
			if (other.ScoreGetSwitchGroup != 0)
			{
				ScoreGetSwitchGroup = other.ScoreGetSwitchGroup;
			}
			if (other.Episode.Length != 0)
			{
				Episode = other.Episode;
			}
			if (other.Image.Length != 0)
			{
				Image = other.Image;
			}
			if (other.BG.Length != 0)
			{
				BG = other.BG;
			}
			if (other.SummonLevelUp)
			{
				SummonLevelUp = other.SummonLevelUp;
			}
			if (other.ExtraImage.Length != 0)
			{
				ExtraImage = other.ExtraImage;
			}
			if (other.ExtraImageAni.Length != 0)
			{
				ExtraImageAni = other.ExtraImageAni;
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
				FloorId = input.ReadInt32();
				break;
			case 24u:
				MonsterId = input.ReadInt32();
				break;
			case 32u:
				NonDamageScoreGet = input.ReadInt32();
				break;
			case 40u:
				ScoreBossAbility = input.ReadInt32();
				break;
			case 48u:
				ScoreGetSwitchGroup = input.ReadInt32();
				break;
			case 58u:
				Episode = input.ReadString();
				break;
			case 66u:
				Image = input.ReadString();
				break;
			case 74u:
				BG = input.ReadString();
				break;
			case 80u:
				SummonLevelUp = input.ReadBool();
				break;
			case 90u:
				ExtraImage = input.ReadString();
				break;
			case 98u:
				ExtraImageAni = input.ReadString();
				break;
			}
		}
	}
}
