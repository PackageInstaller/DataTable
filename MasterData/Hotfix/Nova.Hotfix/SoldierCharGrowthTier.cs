using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierCharGrowthTier : IMessage<SoldierCharGrowthTier>, IMessage, IEquatable<SoldierCharGrowthTier>, IDeepCloneable<SoldierCharGrowthTier>
{
	private static readonly MessageParser<SoldierCharGrowthTier> _parser = new MessageParser<SoldierCharGrowthTier>(() => new SoldierCharGrowthTier());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CharLevelFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_charLevel_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> charLevel_ = new RepeatedField<int>();

	public const int AFieldNumber = 3;

	private int a_;

	public const int NFieldNumber = 4;

	private int n_;

	public const int KFieldNumber = 5;

	private int k_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierCharGrowthTier> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(740);

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
	public RepeatedField<int> CharLevel => charLevel_;

	[DebuggerNonUserCode]
	public int A
	{
		get
		{
			return a_;
		}
		set
		{
			a_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int N
	{
		get
		{
			return n_;
		}
		set
		{
			n_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int K
	{
		get
		{
			return k_;
		}
		set
		{
			k_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierCharGrowthTier()
	{
	}

	[DebuggerNonUserCode]
	public SoldierCharGrowthTier(SoldierCharGrowthTier other)
		: this()
	{
		id_ = other.id_;
		charLevel_ = other.charLevel_.Clone();
		a_ = other.a_;
		n_ = other.n_;
		k_ = other.k_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierCharGrowthTier Clone()
	{
		return new SoldierCharGrowthTier(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierCharGrowthTier);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierCharGrowthTier other)
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
		if (!charLevel_.Equals(other.charLevel_))
		{
			return false;
		}
		if (A != other.A)
		{
			return false;
		}
		if (N != other.N)
		{
			return false;
		}
		if (K != other.K)
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
		num ^= charLevel_.GetHashCode();
		if (A != 0)
		{
			num ^= A.GetHashCode();
		}
		if (N != 0)
		{
			num ^= N.GetHashCode();
		}
		if (K != 0)
		{
			num ^= K.GetHashCode();
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
		charLevel_.WriteTo(output, _repeated_charLevel_codec);
		if (A != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(A);
		}
		if (N != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(N);
		}
		if (K != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(K);
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
		num += charLevel_.CalculateSize(_repeated_charLevel_codec);
		if (A != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(A);
		}
		if (N != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(N);
		}
		if (K != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(K);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierCharGrowthTier other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			charLevel_.Add(other.charLevel_);
			if (other.A != 0)
			{
				A = other.A;
			}
			if (other.N != 0)
			{
				N = other.N;
			}
			if (other.K != 0)
			{
				K = other.K;
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
			case 18u:
				charLevel_.AddEntriesFrom(input, _repeated_charLevel_codec);
				break;
			case 24u:
				A = input.ReadInt32();
				break;
			case 32u:
				N = input.ReadInt32();
				break;
			case 40u:
				K = input.ReadInt32();
				break;
			}
		}
	}
}
