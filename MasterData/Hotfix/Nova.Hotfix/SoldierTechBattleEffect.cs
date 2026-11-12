using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierTechBattleEffect : IMessage<SoldierTechBattleEffect>, IMessage, IEquatable<SoldierTechBattleEffect>, IDeepCloneable<SoldierTechBattleEffect>
{
	private static readonly MessageParser<SoldierTechBattleEffect> _parser = new MessageParser<SoldierTechBattleEffect>(() => new SoldierTechBattleEffect());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int EffectBattleBuffIdFieldNumber = 2;

	private int effectBattleBuffId_;

	public const int SoldierTechBattleBuffTargetFieldNumber = 3;

	private int soldierTechBattleBuffTarget_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierTechBattleEffect> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(810);

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
	public int EffectBattleBuffId
	{
		get
		{
			return effectBattleBuffId_;
		}
		set
		{
			effectBattleBuffId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SoldierTechBattleBuffTarget
	{
		get
		{
			return soldierTechBattleBuffTarget_;
		}
		set
		{
			soldierTechBattleBuffTarget_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierTechBattleEffect()
	{
	}

	[DebuggerNonUserCode]
	public SoldierTechBattleEffect(SoldierTechBattleEffect other)
		: this()
	{
		id_ = other.id_;
		effectBattleBuffId_ = other.effectBattleBuffId_;
		soldierTechBattleBuffTarget_ = other.soldierTechBattleBuffTarget_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierTechBattleEffect Clone()
	{
		return new SoldierTechBattleEffect(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierTechBattleEffect);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierTechBattleEffect other)
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
		if (EffectBattleBuffId != other.EffectBattleBuffId)
		{
			return false;
		}
		if (SoldierTechBattleBuffTarget != other.SoldierTechBattleBuffTarget)
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
		if (EffectBattleBuffId != 0)
		{
			num ^= EffectBattleBuffId.GetHashCode();
		}
		if (SoldierTechBattleBuffTarget != 0)
		{
			num ^= SoldierTechBattleBuffTarget.GetHashCode();
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
		if (EffectBattleBuffId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(EffectBattleBuffId);
		}
		if (SoldierTechBattleBuffTarget != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(SoldierTechBattleBuffTarget);
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
		if (EffectBattleBuffId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectBattleBuffId);
		}
		if (SoldierTechBattleBuffTarget != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SoldierTechBattleBuffTarget);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierTechBattleEffect other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.EffectBattleBuffId != 0)
			{
				EffectBattleBuffId = other.EffectBattleBuffId;
			}
			if (other.SoldierTechBattleBuffTarget != 0)
			{
				SoldierTechBattleBuffTarget = other.SoldierTechBattleBuffTarget;
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
				EffectBattleBuffId = input.ReadInt32();
				break;
			case 24u:
				SoldierTechBattleBuffTarget = input.ReadInt32();
				break;
			}
		}
	}
}
