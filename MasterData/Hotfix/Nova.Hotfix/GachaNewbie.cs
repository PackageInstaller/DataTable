using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GachaNewbie : IMessage<GachaNewbie>, IMessage, IEquatable<GachaNewbie>, IDeepCloneable<GachaNewbie>
{
	private static readonly MessageParser<GachaNewbie> _parser = new MessageParser<GachaNewbie>(() => new GachaNewbie());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SpinCountFieldNumber = 2;

	private int spinCount_;

	public const int SaveCountFieldNumber = 3;

	private int saveCount_;

	[DebuggerNonUserCode]
	public static MessageParser<GachaNewbie> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(366);

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
	public int SpinCount
	{
		get
		{
			return spinCount_;
		}
		set
		{
			spinCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SaveCount
	{
		get
		{
			return saveCount_;
		}
		set
		{
			saveCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public GachaNewbie()
	{
	}

	[DebuggerNonUserCode]
	public GachaNewbie(GachaNewbie other)
		: this()
	{
		id_ = other.id_;
		spinCount_ = other.spinCount_;
		saveCount_ = other.saveCount_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GachaNewbie Clone()
	{
		return new GachaNewbie(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GachaNewbie);
	}

	[DebuggerNonUserCode]
	public bool Equals(GachaNewbie other)
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
		if (SpinCount != other.SpinCount)
		{
			return false;
		}
		if (SaveCount != other.SaveCount)
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
		if (SpinCount != 0)
		{
			num ^= SpinCount.GetHashCode();
		}
		if (SaveCount != 0)
		{
			num ^= SaveCount.GetHashCode();
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
		if (SpinCount != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(SpinCount);
		}
		if (SaveCount != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(SaveCount);
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
		if (SpinCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpinCount);
		}
		if (SaveCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SaveCount);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GachaNewbie other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.SpinCount != 0)
			{
				SpinCount = other.SpinCount;
			}
			if (other.SaveCount != 0)
			{
				SaveCount = other.SaveCount;
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
				SpinCount = input.ReadInt32();
				break;
			case 24u:
				SaveCount = input.ReadInt32();
				break;
			}
		}
	}
}
