using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class WeightParameter : IMessage<WeightParameter>, IMessage, IEquatable<WeightParameter>, IDeepCloneable<WeightParameter>
{
	private static readonly MessageParser<WeightParameter> _parser = new MessageParser<WeightParameter>(() => new WeightParameter());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ProportionFieldNumber = 2;

	private int proportion_;

	public const int EffectFieldNumber = 3;

	private int effect_;

	[DebuggerNonUserCode]
	public static MessageParser<WeightParameter> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1086);

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
	public int Proportion
	{
		get
		{
			return proportion_;
		}
		set
		{
			proportion_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Effect
	{
		get
		{
			return effect_;
		}
		set
		{
			effect_ = value;
		}
	}

	[DebuggerNonUserCode]
	public WeightParameter()
	{
	}

	[DebuggerNonUserCode]
	public WeightParameter(WeightParameter other)
		: this()
	{
		id_ = other.id_;
		proportion_ = other.proportion_;
		effect_ = other.effect_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public WeightParameter Clone()
	{
		return new WeightParameter(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as WeightParameter);
	}

	[DebuggerNonUserCode]
	public bool Equals(WeightParameter other)
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
		if (Proportion != other.Proportion)
		{
			return false;
		}
		if (Effect != other.Effect)
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
		if (Proportion != 0)
		{
			num ^= Proportion.GetHashCode();
		}
		if (Effect != 0)
		{
			num ^= Effect.GetHashCode();
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
		if (Proportion != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Proportion);
		}
		if (Effect != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Effect);
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
		if (Proportion != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Proportion);
		}
		if (Effect != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Effect);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(WeightParameter other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Proportion != 0)
			{
				Proportion = other.Proportion;
			}
			if (other.Effect != 0)
			{
				Effect = other.Effect;
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
				Proportion = input.ReadInt32();
				break;
			case 24u:
				Effect = input.ReadInt32();
				break;
			}
		}
	}
}
