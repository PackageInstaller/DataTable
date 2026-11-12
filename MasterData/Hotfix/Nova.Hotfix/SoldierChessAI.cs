using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierChessAI : IMessage<SoldierChessAI>, IMessage, IEquatable<SoldierChessAI>, IDeepCloneable<SoldierChessAI>
{
	private static readonly MessageParser<SoldierChessAI> _parser = new MessageParser<SoldierChessAI>(() => new SoldierChessAI());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ComboGroupPathFieldNumber = 2;

	private string comboGroupPath_ = "";

	public const int ActionAIPathFieldNumber = 3;

	private string actionAIPath_ = "";

	public const int ParallelAIPathFieldNumber = 4;

	private string parallelAIPath_ = "";

	public const int SpawnSkill1FieldNumber = 5;

	private int spawnSkill1_;

	public const int SpawnSkill2FieldNumber = 6;

	private int spawnSkill2_;

	public const int SpawnSkill3FieldNumber = 7;

	private int spawnSkill3_;

	public const int DeathSkill1FieldNumber = 8;

	private int deathSkill1_;

	public const int DeathSkill2FieldNumber = 9;

	private int deathSkill2_;

	public const int DeathSkill3FieldNumber = 10;

	private int deathSkill3_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierChessAI> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(746);

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
	public string ComboGroupPath
	{
		get
		{
			return comboGroupPath_;
		}
		set
		{
			comboGroupPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ActionAIPath
	{
		get
		{
			return actionAIPath_;
		}
		set
		{
			actionAIPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ParallelAIPath
	{
		get
		{
			return parallelAIPath_;
		}
		set
		{
			parallelAIPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SpawnSkill1
	{
		get
		{
			return spawnSkill1_;
		}
		set
		{
			spawnSkill1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SpawnSkill2
	{
		get
		{
			return spawnSkill2_;
		}
		set
		{
			spawnSkill2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SpawnSkill3
	{
		get
		{
			return spawnSkill3_;
		}
		set
		{
			spawnSkill3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DeathSkill1
	{
		get
		{
			return deathSkill1_;
		}
		set
		{
			deathSkill1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DeathSkill2
	{
		get
		{
			return deathSkill2_;
		}
		set
		{
			deathSkill2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DeathSkill3
	{
		get
		{
			return deathSkill3_;
		}
		set
		{
			deathSkill3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierChessAI()
	{
	}

	[DebuggerNonUserCode]
	public SoldierChessAI(SoldierChessAI other)
		: this()
	{
		id_ = other.id_;
		comboGroupPath_ = other.comboGroupPath_;
		actionAIPath_ = other.actionAIPath_;
		parallelAIPath_ = other.parallelAIPath_;
		spawnSkill1_ = other.spawnSkill1_;
		spawnSkill2_ = other.spawnSkill2_;
		spawnSkill3_ = other.spawnSkill3_;
		deathSkill1_ = other.deathSkill1_;
		deathSkill2_ = other.deathSkill2_;
		deathSkill3_ = other.deathSkill3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierChessAI Clone()
	{
		return new SoldierChessAI(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierChessAI);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierChessAI other)
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
		if (ComboGroupPath != other.ComboGroupPath)
		{
			return false;
		}
		if (ActionAIPath != other.ActionAIPath)
		{
			return false;
		}
		if (ParallelAIPath != other.ParallelAIPath)
		{
			return false;
		}
		if (SpawnSkill1 != other.SpawnSkill1)
		{
			return false;
		}
		if (SpawnSkill2 != other.SpawnSkill2)
		{
			return false;
		}
		if (SpawnSkill3 != other.SpawnSkill3)
		{
			return false;
		}
		if (DeathSkill1 != other.DeathSkill1)
		{
			return false;
		}
		if (DeathSkill2 != other.DeathSkill2)
		{
			return false;
		}
		if (DeathSkill3 != other.DeathSkill3)
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
		if (ComboGroupPath.Length != 0)
		{
			num ^= ComboGroupPath.GetHashCode();
		}
		if (ActionAIPath.Length != 0)
		{
			num ^= ActionAIPath.GetHashCode();
		}
		if (ParallelAIPath.Length != 0)
		{
			num ^= ParallelAIPath.GetHashCode();
		}
		if (SpawnSkill1 != 0)
		{
			num ^= SpawnSkill1.GetHashCode();
		}
		if (SpawnSkill2 != 0)
		{
			num ^= SpawnSkill2.GetHashCode();
		}
		if (SpawnSkill3 != 0)
		{
			num ^= SpawnSkill3.GetHashCode();
		}
		if (DeathSkill1 != 0)
		{
			num ^= DeathSkill1.GetHashCode();
		}
		if (DeathSkill2 != 0)
		{
			num ^= DeathSkill2.GetHashCode();
		}
		if (DeathSkill3 != 0)
		{
			num ^= DeathSkill3.GetHashCode();
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
		if (ComboGroupPath.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(ComboGroupPath);
		}
		if (ActionAIPath.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(ActionAIPath);
		}
		if (ParallelAIPath.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(ParallelAIPath);
		}
		if (SpawnSkill1 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(SpawnSkill1);
		}
		if (SpawnSkill2 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(SpawnSkill2);
		}
		if (SpawnSkill3 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(SpawnSkill3);
		}
		if (DeathSkill1 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(DeathSkill1);
		}
		if (DeathSkill2 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(DeathSkill2);
		}
		if (DeathSkill3 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(DeathSkill3);
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
		if (ComboGroupPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ComboGroupPath);
		}
		if (ActionAIPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ActionAIPath);
		}
		if (ParallelAIPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ParallelAIPath);
		}
		if (SpawnSkill1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpawnSkill1);
		}
		if (SpawnSkill2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpawnSkill2);
		}
		if (SpawnSkill3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpawnSkill3);
		}
		if (DeathSkill1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DeathSkill1);
		}
		if (DeathSkill2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DeathSkill2);
		}
		if (DeathSkill3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DeathSkill3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierChessAI other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ComboGroupPath.Length != 0)
			{
				ComboGroupPath = other.ComboGroupPath;
			}
			if (other.ActionAIPath.Length != 0)
			{
				ActionAIPath = other.ActionAIPath;
			}
			if (other.ParallelAIPath.Length != 0)
			{
				ParallelAIPath = other.ParallelAIPath;
			}
			if (other.SpawnSkill1 != 0)
			{
				SpawnSkill1 = other.SpawnSkill1;
			}
			if (other.SpawnSkill2 != 0)
			{
				SpawnSkill2 = other.SpawnSkill2;
			}
			if (other.SpawnSkill3 != 0)
			{
				SpawnSkill3 = other.SpawnSkill3;
			}
			if (other.DeathSkill1 != 0)
			{
				DeathSkill1 = other.DeathSkill1;
			}
			if (other.DeathSkill2 != 0)
			{
				DeathSkill2 = other.DeathSkill2;
			}
			if (other.DeathSkill3 != 0)
			{
				DeathSkill3 = other.DeathSkill3;
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
			case 18u:
				ComboGroupPath = input.ReadString();
				break;
			case 26u:
				ActionAIPath = input.ReadString();
				break;
			case 34u:
				ParallelAIPath = input.ReadString();
				break;
			case 40u:
				SpawnSkill1 = input.ReadInt32();
				break;
			case 48u:
				SpawnSkill2 = input.ReadInt32();
				break;
			case 56u:
				SpawnSkill3 = input.ReadInt32();
				break;
			case 64u:
				DeathSkill1 = input.ReadInt32();
				break;
			case 72u:
				DeathSkill2 = input.ReadInt32();
				break;
			case 80u:
				DeathSkill3 = input.ReadInt32();
				break;
			}
		}
	}
}
