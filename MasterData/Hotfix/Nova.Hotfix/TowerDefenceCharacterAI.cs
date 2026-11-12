using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TowerDefenceCharacterAI : IMessage<TowerDefenceCharacterAI>, IMessage, IEquatable<TowerDefenceCharacterAI>, IDeepCloneable<TowerDefenceCharacterAI>
{
	private static readonly MessageParser<TowerDefenceCharacterAI> _parser = new MessageParser<TowerDefenceCharacterAI>(() => new TowerDefenceCharacterAI());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ComboGroupPathFieldNumber = 2;

	private string comboGroupPath_ = "";

	public const int SpawnShowSkillIdFieldNumber = 3;

	private int spawnShowSkillId_;

	public const int DieSkillIdFieldNumber = 4;

	private int dieSkillId_;

	public const int ActionAIPathFieldNumber = 5;

	private string actionAIPath_ = "";

	public const int ParallelAIPathFieldNumber = 6;

	private string parallelAIPath_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<TowerDefenceCharacterAI> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(948);

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
	public int SpawnShowSkillId
	{
		get
		{
			return spawnShowSkillId_;
		}
		set
		{
			spawnShowSkillId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DieSkillId
	{
		get
		{
			return dieSkillId_;
		}
		set
		{
			dieSkillId_ = value;
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
	public TowerDefenceCharacterAI()
	{
	}

	[DebuggerNonUserCode]
	public TowerDefenceCharacterAI(TowerDefenceCharacterAI other)
		: this()
	{
		id_ = other.id_;
		comboGroupPath_ = other.comboGroupPath_;
		spawnShowSkillId_ = other.spawnShowSkillId_;
		dieSkillId_ = other.dieSkillId_;
		actionAIPath_ = other.actionAIPath_;
		parallelAIPath_ = other.parallelAIPath_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TowerDefenceCharacterAI Clone()
	{
		return new TowerDefenceCharacterAI(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TowerDefenceCharacterAI);
	}

	[DebuggerNonUserCode]
	public bool Equals(TowerDefenceCharacterAI other)
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
		if (SpawnShowSkillId != other.SpawnShowSkillId)
		{
			return false;
		}
		if (DieSkillId != other.DieSkillId)
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
		if (SpawnShowSkillId != 0)
		{
			num ^= SpawnShowSkillId.GetHashCode();
		}
		if (DieSkillId != 0)
		{
			num ^= DieSkillId.GetHashCode();
		}
		if (ActionAIPath.Length != 0)
		{
			num ^= ActionAIPath.GetHashCode();
		}
		if (ParallelAIPath.Length != 0)
		{
			num ^= ParallelAIPath.GetHashCode();
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
		if (SpawnShowSkillId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(SpawnShowSkillId);
		}
		if (DieSkillId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(DieSkillId);
		}
		if (ActionAIPath.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(ActionAIPath);
		}
		if (ParallelAIPath.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(ParallelAIPath);
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
		if (SpawnShowSkillId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpawnShowSkillId);
		}
		if (DieSkillId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DieSkillId);
		}
		if (ActionAIPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ActionAIPath);
		}
		if (ParallelAIPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ParallelAIPath);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TowerDefenceCharacterAI other)
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
			if (other.SpawnShowSkillId != 0)
			{
				SpawnShowSkillId = other.SpawnShowSkillId;
			}
			if (other.DieSkillId != 0)
			{
				DieSkillId = other.DieSkillId;
			}
			if (other.ActionAIPath.Length != 0)
			{
				ActionAIPath = other.ActionAIPath;
			}
			if (other.ParallelAIPath.Length != 0)
			{
				ParallelAIPath = other.ParallelAIPath;
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
			case 24u:
				SpawnShowSkillId = input.ReadInt32();
				break;
			case 32u:
				DieSkillId = input.ReadInt32();
				break;
			case 42u:
				ActionAIPath = input.ReadString();
				break;
			case 50u:
				ParallelAIPath = input.ReadString();
				break;
			}
		}
	}
}
