using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class CharacterStatus : IMessage<CharacterStatus>, IMessage, IEquatable<CharacterStatus>, IDeepCloneable<CharacterStatus>, IBufferMessage
{
	private static readonly MessageParser<CharacterStatus> _parser = new MessageParser<CharacterStatus>(() => new CharacterStatus());

	private UnknownFieldSet _unknownFields;

	public const int HpFieldNumber = 1;

	private int hp_;

	public const int ExPowerFieldNumber = 2;

	private float exPower_;

	public const int AssistPowerFieldNumber = 3;

	private float assistPower_;

	public const int EnergyPowerFieldNumber = 4;

	private float energyPower_;

	public const int SpecialEnergyPowerFieldNumber = 5;

	private float specialEnergyPower_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CharacterStatus> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[42];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Hp
	{
		get
		{
			return hp_;
		}
		set
		{
			hp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public float ExPower
	{
		get
		{
			return exPower_;
		}
		set
		{
			exPower_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public float AssistPower
	{
		get
		{
			return assistPower_;
		}
		set
		{
			assistPower_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public float EnergyPower
	{
		get
		{
			return energyPower_;
		}
		set
		{
			energyPower_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public float SpecialEnergyPower
	{
		get
		{
			return specialEnergyPower_;
		}
		set
		{
			specialEnergyPower_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterStatus()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterStatus(CharacterStatus other)
		: this()
	{
		hp_ = other.hp_;
		exPower_ = other.exPower_;
		assistPower_ = other.assistPower_;
		energyPower_ = other.energyPower_;
		specialEnergyPower_ = other.specialEnergyPower_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterStatus Clone()
	{
		return new CharacterStatus(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterStatus);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CharacterStatus other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Hp != other.Hp)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(ExPower, other.ExPower))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(AssistPower, other.AssistPower))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(EnergyPower, other.EnergyPower))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(SpecialEnergyPower, other.SpecialEnergyPower))
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
		if (Hp != 0)
		{
			num ^= Hp.GetHashCode();
		}
		if (ExPower != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(ExPower);
		}
		if (AssistPower != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(AssistPower);
		}
		if (EnergyPower != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(EnergyPower);
		}
		if (SpecialEnergyPower != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(SpecialEnergyPower);
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
		if (Hp != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Hp);
		}
		if (ExPower != 0f)
		{
			output.WriteRawTag(21);
			output.WriteFloat(ExPower);
		}
		if (AssistPower != 0f)
		{
			output.WriteRawTag(29);
			output.WriteFloat(AssistPower);
		}
		if (EnergyPower != 0f)
		{
			output.WriteRawTag(37);
			output.WriteFloat(EnergyPower);
		}
		if (SpecialEnergyPower != 0f)
		{
			output.WriteRawTag(45);
			output.WriteFloat(SpecialEnergyPower);
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
		if (Hp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Hp);
		}
		if (ExPower != 0f)
		{
			num += 5;
		}
		if (AssistPower != 0f)
		{
			num += 5;
		}
		if (EnergyPower != 0f)
		{
			num += 5;
		}
		if (SpecialEnergyPower != 0f)
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
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CharacterStatus other)
	{
		if (other != null)
		{
			if (other.Hp != 0)
			{
				Hp = other.Hp;
			}
			if (other.ExPower != 0f)
			{
				ExPower = other.ExPower;
			}
			if (other.AssistPower != 0f)
			{
				AssistPower = other.AssistPower;
			}
			if (other.EnergyPower != 0f)
			{
				EnergyPower = other.EnergyPower;
			}
			if (other.SpecialEnergyPower != 0f)
			{
				SpecialEnergyPower = other.SpecialEnergyPower;
			}
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
			case 8u:
				Hp = input.ReadInt32();
				break;
			case 21u:
				ExPower = input.ReadFloat();
				break;
			case 29u:
				AssistPower = input.ReadFloat();
				break;
			case 37u:
				EnergyPower = input.ReadFloat();
				break;
			case 45u:
				SpecialEnergyPower = input.ReadFloat();
				break;
			}
		}
	}
}
