using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerEnemySet : IMessage<StarTowerEnemySet>, IMessage, IEquatable<StarTowerEnemySet>, IDeepCloneable<StarTowerEnemySet>
{
	private static readonly MessageParser<StarTowerEnemySet> _parser = new MessageParser<StarTowerEnemySet>(() => new StarTowerEnemySet());

	private UnknownFieldSet _unknownFields;

	public const int SetIdFieldNumber = 1;

	private int setId_;

	public const int WaveNumFieldNumber = 2;

	private int waveNum_;

	public const int MaxNumFieldNumber = 3;

	private int maxNum_;

	public const int MaxNumPerWaveFieldNumber = 4;

	private int maxNumPerWave_;

	public const int MonsterIdFieldNumber = 5;

	private int monsterId_;

	public const int RefIntervalFieldNumber = 6;

	private float refInterval_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerEnemySet> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(840);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int SetId
	{
		get
		{
			return setId_;
		}
		set
		{
			setId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WaveNum
	{
		get
		{
			return waveNum_;
		}
		set
		{
			waveNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MaxNum
	{
		get
		{
			return maxNum_;
		}
		set
		{
			maxNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MaxNumPerWave
	{
		get
		{
			return maxNumPerWave_;
		}
		set
		{
			maxNumPerWave_ = value;
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
	public float RefInterval
	{
		get
		{
			return refInterval_;
		}
		set
		{
			refInterval_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerEnemySet()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerEnemySet(StarTowerEnemySet other)
		: this()
	{
		setId_ = other.setId_;
		waveNum_ = other.waveNum_;
		maxNum_ = other.maxNum_;
		maxNumPerWave_ = other.maxNumPerWave_;
		monsterId_ = other.monsterId_;
		refInterval_ = other.refInterval_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerEnemySet Clone()
	{
		return new StarTowerEnemySet(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerEnemySet);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerEnemySet other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (SetId != other.SetId)
		{
			return false;
		}
		if (WaveNum != other.WaveNum)
		{
			return false;
		}
		if (MaxNum != other.MaxNum)
		{
			return false;
		}
		if (MaxNumPerWave != other.MaxNumPerWave)
		{
			return false;
		}
		if (MonsterId != other.MonsterId)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(RefInterval, other.RefInterval))
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (SetId != 0)
		{
			num ^= SetId.GetHashCode();
		}
		if (WaveNum != 0)
		{
			num ^= WaveNum.GetHashCode();
		}
		if (MaxNum != 0)
		{
			num ^= MaxNum.GetHashCode();
		}
		if (MaxNumPerWave != 0)
		{
			num ^= MaxNumPerWave.GetHashCode();
		}
		if (MonsterId != 0)
		{
			num ^= MonsterId.GetHashCode();
		}
		if (RefInterval != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(RefInterval);
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
		if (SetId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(SetId);
		}
		if (WaveNum != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(WaveNum);
		}
		if (MaxNum != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(MaxNum);
		}
		if (MaxNumPerWave != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(MaxNumPerWave);
		}
		if (MonsterId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(MonsterId);
		}
		if (RefInterval != 0f)
		{
			output.WriteRawTag(53);
			output.WriteFloat(RefInterval);
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
		if (SetId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SetId);
		}
		if (WaveNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WaveNum);
		}
		if (MaxNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxNum);
		}
		if (MaxNumPerWave != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxNumPerWave);
		}
		if (MonsterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterId);
		}
		if (RefInterval != 0f)
		{
			num += 5;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerEnemySet other)
	{
		if (other != null)
		{
			if (other.SetId != 0)
			{
				SetId = other.SetId;
			}
			if (other.WaveNum != 0)
			{
				WaveNum = other.WaveNum;
			}
			if (other.MaxNum != 0)
			{
				MaxNum = other.MaxNum;
			}
			if (other.MaxNumPerWave != 0)
			{
				MaxNumPerWave = other.MaxNumPerWave;
			}
			if (other.MonsterId != 0)
			{
				MonsterId = other.MonsterId;
			}
			if (other.RefInterval != 0f)
			{
				RefInterval = other.RefInterval;
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
				SetId = input.ReadInt32();
				break;
			case 16u:
				WaveNum = input.ReadInt32();
				break;
			case 24u:
				MaxNum = input.ReadInt32();
				break;
			case 32u:
				MaxNumPerWave = input.ReadInt32();
				break;
			case 40u:
				MonsterId = input.ReadInt32();
				break;
			case 53u:
				RefInterval = input.ReadFloat();
				break;
			}
		}
	}
}
