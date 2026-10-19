using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Chip : IMessage<Chip>, IMessage, IEquatable<Chip>, IDeepCloneable<Chip>, IBufferMessage
{
	private static readonly MessageParser<Chip> _parser = new MessageParser<Chip>(() => new Chip());

	private UnknownFieldSet _unknownFields;

	public const int UidFieldNumber = 1;

	private int uid_;

	public const int IdFieldNumber = 2;

	private int id_;

	public const int LevelFieldNumber = 3;

	private int level_;

	public const int ExpFieldNumber = 4;

	private int exp_;

	public const int MainPropertyIdFieldNumber = 5;

	private int mainPropertyId_;

	public const int LockFieldNumber = 7;

	private bool lock_;

	public const int SourceFieldNumber = 9;

	private ItemsWays source_;

	public const int SidePropertiesFieldNumber = 10;

	private static readonly FieldCodec<ChipSideProperties> _repeated_sideProperties_codec = FieldCodec.ForMessage(82u, ChipSideProperties.Parser);

	private readonly RepeatedField<ChipSideProperties> sideProperties_ = new RepeatedField<ChipSideProperties>();

	public const int IsNewFieldNumber = 11;

	private bool isNew_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Chip> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[49];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Uid
	{
		get
		{
			return uid_;
		}
		set
		{
			uid_ = value;
		}
	}

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
	public int Exp
	{
		get
		{
			return exp_;
		}
		set
		{
			exp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int MainPropertyId
	{
		get
		{
			return mainPropertyId_;
		}
		set
		{
			mainPropertyId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Lock
	{
		get
		{
			return lock_;
		}
		set
		{
			lock_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemsWays Source
	{
		get
		{
			return source_;
		}
		set
		{
			source_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<ChipSideProperties> SideProperties => sideProperties_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsNew
	{
		get
		{
			return isNew_;
		}
		set
		{
			isNew_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Chip()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Chip(Chip other)
		: this()
	{
		uid_ = other.uid_;
		id_ = other.id_;
		level_ = other.level_;
		exp_ = other.exp_;
		mainPropertyId_ = other.mainPropertyId_;
		lock_ = other.lock_;
		source_ = other.source_;
		sideProperties_ = other.sideProperties_.Clone();
		isNew_ = other.isNew_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Chip Clone()
	{
		return new Chip(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Chip);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Chip other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Uid != other.Uid)
		{
			return false;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (Exp != other.Exp)
		{
			return false;
		}
		if (MainPropertyId != other.MainPropertyId)
		{
			return false;
		}
		if (Lock != other.Lock)
		{
			return false;
		}
		if (Source != other.Source)
		{
			return false;
		}
		if (!sideProperties_.Equals(other.sideProperties_))
		{
			return false;
		}
		if (IsNew != other.IsNew)
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
		if (Uid != 0)
		{
			num ^= Uid.GetHashCode();
		}
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (Exp != 0)
		{
			num ^= Exp.GetHashCode();
		}
		if (MainPropertyId != 0)
		{
			num ^= MainPropertyId.GetHashCode();
		}
		if (Lock)
		{
			num ^= Lock.GetHashCode();
		}
		if (Source != ItemsWays.ItemswayEntergame)
		{
			num ^= Source.GetHashCode();
		}
		num ^= sideProperties_.GetHashCode();
		if (IsNew)
		{
			num ^= IsNew.GetHashCode();
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
		if (Uid != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Uid);
		}
		if (Id != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Id);
		}
		if (Level != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Level);
		}
		if (Exp != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Exp);
		}
		if (MainPropertyId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(MainPropertyId);
		}
		if (Lock)
		{
			output.WriteRawTag(56);
			output.WriteBool(Lock);
		}
		if (Source != ItemsWays.ItemswayEntergame)
		{
			output.WriteRawTag(72);
			output.WriteEnum((int)Source);
		}
		sideProperties_.WriteTo(ref output, _repeated_sideProperties_codec);
		if (IsNew)
		{
			output.WriteRawTag(88);
			output.WriteBool(IsNew);
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
		if (Uid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Uid);
		}
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (Exp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Exp);
		}
		if (MainPropertyId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MainPropertyId);
		}
		if (Lock)
		{
			num += 2;
		}
		if (Source != ItemsWays.ItemswayEntergame)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Source);
		}
		num += sideProperties_.CalculateSize(_repeated_sideProperties_codec);
		if (IsNew)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Chip other)
	{
		if (other != null)
		{
			if (other.Uid != 0)
			{
				Uid = other.Uid;
			}
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.Exp != 0)
			{
				Exp = other.Exp;
			}
			if (other.MainPropertyId != 0)
			{
				MainPropertyId = other.MainPropertyId;
			}
			if (other.Lock)
			{
				Lock = other.Lock;
			}
			if (other.Source != ItemsWays.ItemswayEntergame)
			{
				Source = other.Source;
			}
			sideProperties_.Add(other.sideProperties_);
			if (other.IsNew)
			{
				IsNew = other.IsNew;
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
				Uid = input.ReadInt32();
				break;
			case 16u:
				Id = input.ReadInt32();
				break;
			case 24u:
				Level = input.ReadInt32();
				break;
			case 32u:
				Exp = input.ReadInt32();
				break;
			case 40u:
				MainPropertyId = input.ReadInt32();
				break;
			case 56u:
				Lock = input.ReadBool();
				break;
			case 72u:
				Source = (ItemsWays)input.ReadEnum();
				break;
			case 82u:
				sideProperties_.AddEntriesFrom(ref input, _repeated_sideProperties_codec);
				break;
			case 88u:
				IsNew = input.ReadBool();
				break;
			}
		}
	}
}
