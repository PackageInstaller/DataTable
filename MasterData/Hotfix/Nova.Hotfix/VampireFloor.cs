using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class VampireFloor : IMessage<VampireFloor>, IMessage, IEquatable<VampireFloor>, IDeepCloneable<VampireFloor>
{
	private static readonly MessageParser<VampireFloor> _parser = new MessageParser<VampireFloor>(() => new VampireFloor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MapIdFieldNumber = 2;

	private int mapId_;

	public const int WaveCountFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_waveCount_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> waveCount_ = new RepeatedField<int>();

	public const int FirstHalfPoolIdFieldNumber = 4;

	private int firstHalfPoolId_;

	public const int FHAffixIdFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_fHAffixId_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> fHAffixId_ = new RepeatedField<int>();

	public const int FHBossIdFieldNumber = 6;

	private int fHBossId_;

	public const int SecondHalfPoolIdFieldNumber = 7;

	private int secondHalfPoolId_;

	public const int SHAffixIdFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_sHAffixId_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> sHAffixId_ = new RepeatedField<int>();

	public const int SHBossIdFieldNumber = 9;

	private int sHBossId_;

	public const int SpecialEnemySetIdFieldNumber = 10;

	private string specialEnemySetId_ = "";

	public const int TreasureSetIdFieldNumber = 11;

	private string treasureSetId_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<VampireFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1054);

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
	public int MapId
	{
		get
		{
			return mapId_;
		}
		set
		{
			mapId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> WaveCount => waveCount_;

	[DebuggerNonUserCode]
	public int FirstHalfPoolId
	{
		get
		{
			return firstHalfPoolId_;
		}
		set
		{
			firstHalfPoolId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> FHAffixId => fHAffixId_;

	[DebuggerNonUserCode]
	public int FHBossId
	{
		get
		{
			return fHBossId_;
		}
		set
		{
			fHBossId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SecondHalfPoolId
	{
		get
		{
			return secondHalfPoolId_;
		}
		set
		{
			secondHalfPoolId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> SHAffixId => sHAffixId_;

	[DebuggerNonUserCode]
	public int SHBossId
	{
		get
		{
			return sHBossId_;
		}
		set
		{
			sHBossId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string SpecialEnemySetId
	{
		get
		{
			return specialEnemySetId_;
		}
		set
		{
			specialEnemySetId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TreasureSetId
	{
		get
		{
			return treasureSetId_;
		}
		set
		{
			treasureSetId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public VampireFloor()
	{
	}

	[DebuggerNonUserCode]
	public VampireFloor(VampireFloor other)
		: this()
	{
		id_ = other.id_;
		mapId_ = other.mapId_;
		waveCount_ = other.waveCount_.Clone();
		firstHalfPoolId_ = other.firstHalfPoolId_;
		fHAffixId_ = other.fHAffixId_.Clone();
		fHBossId_ = other.fHBossId_;
		secondHalfPoolId_ = other.secondHalfPoolId_;
		sHAffixId_ = other.sHAffixId_.Clone();
		sHBossId_ = other.sHBossId_;
		specialEnemySetId_ = other.specialEnemySetId_;
		treasureSetId_ = other.treasureSetId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public VampireFloor Clone()
	{
		return new VampireFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as VampireFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(VampireFloor other)
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
		if (MapId != other.MapId)
		{
			return false;
		}
		if (!waveCount_.Equals(other.waveCount_))
		{
			return false;
		}
		if (FirstHalfPoolId != other.FirstHalfPoolId)
		{
			return false;
		}
		if (!fHAffixId_.Equals(other.fHAffixId_))
		{
			return false;
		}
		if (FHBossId != other.FHBossId)
		{
			return false;
		}
		if (SecondHalfPoolId != other.SecondHalfPoolId)
		{
			return false;
		}
		if (!sHAffixId_.Equals(other.sHAffixId_))
		{
			return false;
		}
		if (SHBossId != other.SHBossId)
		{
			return false;
		}
		if (SpecialEnemySetId != other.SpecialEnemySetId)
		{
			return false;
		}
		if (TreasureSetId != other.TreasureSetId)
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
		if (MapId != 0)
		{
			num ^= MapId.GetHashCode();
		}
		num ^= waveCount_.GetHashCode();
		if (FirstHalfPoolId != 0)
		{
			num ^= FirstHalfPoolId.GetHashCode();
		}
		num ^= fHAffixId_.GetHashCode();
		if (FHBossId != 0)
		{
			num ^= FHBossId.GetHashCode();
		}
		if (SecondHalfPoolId != 0)
		{
			num ^= SecondHalfPoolId.GetHashCode();
		}
		num ^= sHAffixId_.GetHashCode();
		if (SHBossId != 0)
		{
			num ^= SHBossId.GetHashCode();
		}
		if (SpecialEnemySetId.Length != 0)
		{
			num ^= SpecialEnemySetId.GetHashCode();
		}
		if (TreasureSetId.Length != 0)
		{
			num ^= TreasureSetId.GetHashCode();
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
		if (MapId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MapId);
		}
		waveCount_.WriteTo(output, _repeated_waveCount_codec);
		if (FirstHalfPoolId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(FirstHalfPoolId);
		}
		fHAffixId_.WriteTo(output, _repeated_fHAffixId_codec);
		if (FHBossId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(FHBossId);
		}
		if (SecondHalfPoolId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(SecondHalfPoolId);
		}
		sHAffixId_.WriteTo(output, _repeated_sHAffixId_codec);
		if (SHBossId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(SHBossId);
		}
		if (SpecialEnemySetId.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(SpecialEnemySetId);
		}
		if (TreasureSetId.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(TreasureSetId);
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
		if (MapId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MapId);
		}
		num += waveCount_.CalculateSize(_repeated_waveCount_codec);
		if (FirstHalfPoolId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FirstHalfPoolId);
		}
		num += fHAffixId_.CalculateSize(_repeated_fHAffixId_codec);
		if (FHBossId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FHBossId);
		}
		if (SecondHalfPoolId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SecondHalfPoolId);
		}
		num += sHAffixId_.CalculateSize(_repeated_sHAffixId_codec);
		if (SHBossId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SHBossId);
		}
		if (SpecialEnemySetId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SpecialEnemySetId);
		}
		if (TreasureSetId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TreasureSetId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(VampireFloor other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.MapId != 0)
			{
				MapId = other.MapId;
			}
			waveCount_.Add(other.waveCount_);
			if (other.FirstHalfPoolId != 0)
			{
				FirstHalfPoolId = other.FirstHalfPoolId;
			}
			fHAffixId_.Add(other.fHAffixId_);
			if (other.FHBossId != 0)
			{
				FHBossId = other.FHBossId;
			}
			if (other.SecondHalfPoolId != 0)
			{
				SecondHalfPoolId = other.SecondHalfPoolId;
			}
			sHAffixId_.Add(other.sHAffixId_);
			if (other.SHBossId != 0)
			{
				SHBossId = other.SHBossId;
			}
			if (other.SpecialEnemySetId.Length != 0)
			{
				SpecialEnemySetId = other.SpecialEnemySetId;
			}
			if (other.TreasureSetId.Length != 0)
			{
				TreasureSetId = other.TreasureSetId;
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
				MapId = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				waveCount_.AddEntriesFrom(input, _repeated_waveCount_codec);
				break;
			case 32u:
				FirstHalfPoolId = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				fHAffixId_.AddEntriesFrom(input, _repeated_fHAffixId_codec);
				break;
			case 48u:
				FHBossId = input.ReadInt32();
				break;
			case 56u:
				SecondHalfPoolId = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				sHAffixId_.AddEntriesFrom(input, _repeated_sHAffixId_codec);
				break;
			case 72u:
				SHBossId = input.ReadInt32();
				break;
			case 82u:
				SpecialEnemySetId = input.ReadString();
				break;
			case 90u:
				TreasureSetId = input.ReadString();
				break;
			}
		}
	}
}
