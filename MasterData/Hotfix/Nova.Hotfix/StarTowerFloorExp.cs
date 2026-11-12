using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerFloorExp : IMessage<StarTowerFloorExp>, IMessage, IEquatable<StarTowerFloorExp>, IDeepCloneable<StarTowerFloorExp>
{
	private static readonly MessageParser<StarTowerFloorExp> _parser = new MessageParser<StarTowerFloorExp>(() => new StarTowerFloorExp());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int StarTowerIdFieldNumber = 2;

	private int starTowerId_;

	public const int StageFieldNumber = 3;

	private int stage_;

	public const int NormalExpFieldNumber = 4;

	private int normalExp_;

	public const int EliteExpFieldNumber = 5;

	private int eliteExp_;

	public const int BossExpFieldNumber = 6;

	private int bossExp_;

	public const int FinalBossExpFieldNumber = 7;

	private int finalBossExp_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerFloorExp> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(850);

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
	public int StarTowerId
	{
		get
		{
			return starTowerId_;
		}
		set
		{
			starTowerId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Stage
	{
		get
		{
			return stage_;
		}
		set
		{
			stage_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NormalExp
	{
		get
		{
			return normalExp_;
		}
		set
		{
			normalExp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EliteExp
	{
		get
		{
			return eliteExp_;
		}
		set
		{
			eliteExp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BossExp
	{
		get
		{
			return bossExp_;
		}
		set
		{
			bossExp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FinalBossExp
	{
		get
		{
			return finalBossExp_;
		}
		set
		{
			finalBossExp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerFloorExp()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerFloorExp(StarTowerFloorExp other)
		: this()
	{
		id_ = other.id_;
		starTowerId_ = other.starTowerId_;
		stage_ = other.stage_;
		normalExp_ = other.normalExp_;
		eliteExp_ = other.eliteExp_;
		bossExp_ = other.bossExp_;
		finalBossExp_ = other.finalBossExp_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerFloorExp Clone()
	{
		return new StarTowerFloorExp(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerFloorExp);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerFloorExp other)
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
		if (StarTowerId != other.StarTowerId)
		{
			return false;
		}
		if (Stage != other.Stage)
		{
			return false;
		}
		if (NormalExp != other.NormalExp)
		{
			return false;
		}
		if (EliteExp != other.EliteExp)
		{
			return false;
		}
		if (BossExp != other.BossExp)
		{
			return false;
		}
		if (FinalBossExp != other.FinalBossExp)
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
		if (StarTowerId != 0)
		{
			num ^= StarTowerId.GetHashCode();
		}
		if (Stage != 0)
		{
			num ^= Stage.GetHashCode();
		}
		if (NormalExp != 0)
		{
			num ^= NormalExp.GetHashCode();
		}
		if (EliteExp != 0)
		{
			num ^= EliteExp.GetHashCode();
		}
		if (BossExp != 0)
		{
			num ^= BossExp.GetHashCode();
		}
		if (FinalBossExp != 0)
		{
			num ^= FinalBossExp.GetHashCode();
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
		if (StarTowerId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(StarTowerId);
		}
		if (Stage != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Stage);
		}
		if (NormalExp != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(NormalExp);
		}
		if (EliteExp != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(EliteExp);
		}
		if (BossExp != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(BossExp);
		}
		if (FinalBossExp != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(FinalBossExp);
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
		if (StarTowerId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StarTowerId);
		}
		if (Stage != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Stage);
		}
		if (NormalExp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NormalExp);
		}
		if (EliteExp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EliteExp);
		}
		if (BossExp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BossExp);
		}
		if (FinalBossExp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FinalBossExp);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerFloorExp other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.StarTowerId != 0)
			{
				StarTowerId = other.StarTowerId;
			}
			if (other.Stage != 0)
			{
				Stage = other.Stage;
			}
			if (other.NormalExp != 0)
			{
				NormalExp = other.NormalExp;
			}
			if (other.EliteExp != 0)
			{
				EliteExp = other.EliteExp;
			}
			if (other.BossExp != 0)
			{
				BossExp = other.BossExp;
			}
			if (other.FinalBossExp != 0)
			{
				FinalBossExp = other.FinalBossExp;
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
				StarTowerId = input.ReadInt32();
				break;
			case 24u:
				Stage = input.ReadInt32();
				break;
			case 32u:
				NormalExp = input.ReadInt32();
				break;
			case 40u:
				EliteExp = input.ReadInt32();
				break;
			case 48u:
				BossExp = input.ReadInt32();
				break;
			case 56u:
				FinalBossExp = input.ReadInt32();
				break;
			}
		}
	}
}
