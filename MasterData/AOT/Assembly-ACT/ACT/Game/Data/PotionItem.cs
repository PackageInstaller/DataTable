using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class PotionItem : IMessage<PotionItem>, IMessage, IEquatable<PotionItem>, IDeepCloneable<PotionItem>, IBufferMessage
{
	private static readonly MessageParser<PotionItem> _parser = new MessageParser<PotionItem>(() => new PotionItem());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int LevelFieldNumber = 2;

	private int level_;

	public const int AdditivesFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_additives_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> additives_ = new RepeatedField<int>();

	public const int UseCountFieldNumber = 4;

	private int useCount_;

	public const int MaxUseFieldNumber = 5;

	private int maxUse_;

	private int[] soltType;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<PotionItem> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[33];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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
	[GeneratedCode("protoc", null)]
	public int Level
	{
		get
		{
			return level_;
		}
		set
		{
			level_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> Additives => additives_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int UseCount
	{
		get
		{
			return useCount_;
		}
		set
		{
			useCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int MaxUse
	{
		get
		{
			return maxUse_;
		}
		set
		{
			maxUse_ = value;
		}
	}

	public int[] SoltType
	{
		get
		{
			if (soltType == null)
			{
				soltType = new int[3];
				UpdateSoltType();
			}
			return soltType;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PotionItem()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PotionItem(PotionItem other)
		: this()
	{
		id_ = other.id_;
		level_ = other.level_;
		additives_ = other.additives_.Clone();
		useCount_ = other.useCount_;
		maxUse_ = other.maxUse_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PotionItem Clone()
	{
		return new PotionItem(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as PotionItem);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(PotionItem other)
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
		if (Level != other.Level)
		{
			return false;
		}
		if (!additives_.Equals(other.additives_))
		{
			return false;
		}
		if (UseCount != other.UseCount)
		{
			return false;
		}
		if (MaxUse != other.MaxUse)
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
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		num ^= additives_.GetHashCode();
		if (UseCount != 0)
		{
			num ^= UseCount.GetHashCode();
		}
		if (MaxUse != 0)
		{
			num ^= MaxUse.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (Level != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Level);
		}
		additives_.WriteTo(ref output, _repeated_additives_codec);
		if (UseCount != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(UseCount);
		}
		if (MaxUse != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(MaxUse);
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		num += additives_.CalculateSize(_repeated_additives_codec);
		if (UseCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UseCount);
		}
		if (MaxUse != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxUse);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(PotionItem other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			additives_.Add(other.additives_);
			if (other.UseCount != 0)
			{
				UseCount = other.UseCount;
			}
			if (other.MaxUse != 0)
			{
				MaxUse = other.MaxUse;
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
				Id = input.ReadInt32();
				break;
			case 16u:
				Level = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				additives_.AddEntriesFrom(ref input, _repeated_additives_codec);
				break;
			case 32u:
				UseCount = input.ReadInt32();
				break;
			case 40u:
				MaxUse = input.ReadInt32();
				break;
			}
		}
	}

	private void UpdateSoltType()
	{
	}
}
