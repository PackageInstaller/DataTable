using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerMapMaxNumPerStage : IMessage<StarTowerMapMaxNumPerStage>, IMessage, IEquatable<StarTowerMapMaxNumPerStage>, IDeepCloneable<StarTowerMapMaxNumPerStage>
{
	private static readonly MessageParser<StarTowerMapMaxNumPerStage> _parser = new MessageParser<StarTowerMapMaxNumPerStage>(() => new StarTowerMapMaxNumPerStage());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MaxNumPerStageFieldNumber = 2;

	private int maxNumPerStage_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerMapMaxNumPerStage> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(862);

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
	public int MaxNumPerStage
	{
		get
		{
			return maxNumPerStage_;
		}
		set
		{
			maxNumPerStage_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerMapMaxNumPerStage()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerMapMaxNumPerStage(StarTowerMapMaxNumPerStage other)
		: this()
	{
		id_ = other.id_;
		maxNumPerStage_ = other.maxNumPerStage_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerMapMaxNumPerStage Clone()
	{
		return new StarTowerMapMaxNumPerStage(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerMapMaxNumPerStage);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerMapMaxNumPerStage other)
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
		if (MaxNumPerStage != other.MaxNumPerStage)
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
		if (MaxNumPerStage != 0)
		{
			num ^= MaxNumPerStage.GetHashCode();
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
		if (MaxNumPerStage != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MaxNumPerStage);
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
		if (MaxNumPerStage != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxNumPerStage);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerMapMaxNumPerStage other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.MaxNumPerStage != 0)
			{
				MaxNumPerStage = other.MaxNumPerStage;
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
				MaxNumPerStage = input.ReadInt32();
				break;
			}
		}
	}
}
