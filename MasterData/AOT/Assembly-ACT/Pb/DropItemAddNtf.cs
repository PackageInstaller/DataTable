using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class DropItemAddNtf : IMessage<DropItemAddNtf>, IMessage, IEquatable<DropItemAddNtf>, IDeepCloneable<DropItemAddNtf>, IBufferMessage
{
	private static readonly MessageParser<DropItemAddNtf> _parser = new MessageParser<DropItemAddNtf>(() => new DropItemAddNtf());

	private UnknownFieldSet _unknownFields;

	public const int WidFieldNumber = 1;

	private int wid_;

	public const int DropSoureUidFieldNumber = 2;

	private int dropSoureUid_;

	public const int DitemsFieldNumber = 3;

	private static readonly FieldCodec<DropItem> _repeated_ditems_codec = FieldCodec.ForMessage(26u, DropItem.Parser);

	private readonly RepeatedField<DropItem> ditems_ = new RepeatedField<DropItem>();

	public const int PackageIdFieldNumber = 4;

	private uint packageId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<DropItemAddNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => DropitemReflection.Descriptor.MessageTypes[5];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Wid
	{
		get
		{
			return wid_;
		}
		set
		{
			wid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int DropSoureUid
	{
		get
		{
			return dropSoureUid_;
		}
		set
		{
			dropSoureUid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<DropItem> Ditems => ditems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public uint PackageId
	{
		get
		{
			return packageId_;
		}
		set
		{
			packageId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DropItemAddNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DropItemAddNtf(DropItemAddNtf other)
		: this()
	{
		wid_ = other.wid_;
		dropSoureUid_ = other.dropSoureUid_;
		ditems_ = other.ditems_.Clone();
		packageId_ = other.packageId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DropItemAddNtf Clone()
	{
		return new DropItemAddNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as DropItemAddNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(DropItemAddNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Wid != other.Wid)
		{
			return false;
		}
		if (DropSoureUid != other.DropSoureUid)
		{
			return false;
		}
		if (!ditems_.Equals(other.ditems_))
		{
			return false;
		}
		if (PackageId != other.PackageId)
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
		if (Wid != 0)
		{
			num ^= Wid.GetHashCode();
		}
		if (DropSoureUid != 0)
		{
			num ^= DropSoureUid.GetHashCode();
		}
		num ^= ditems_.GetHashCode();
		if (PackageId != 0)
		{
			num ^= PackageId.GetHashCode();
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
		if (Wid != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Wid);
		}
		if (DropSoureUid != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(DropSoureUid);
		}
		ditems_.WriteTo(ref output, _repeated_ditems_codec);
		if (PackageId != 0)
		{
			output.WriteRawTag(32);
			output.WriteUInt32(PackageId);
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
		if (Wid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Wid);
		}
		if (DropSoureUid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DropSoureUid);
		}
		num += ditems_.CalculateSize(_repeated_ditems_codec);
		if (PackageId != 0)
		{
			num += 1 + CodedOutputStream.ComputeUInt32Size(PackageId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(DropItemAddNtf other)
	{
		if (other != null)
		{
			if (other.Wid != 0)
			{
				Wid = other.Wid;
			}
			if (other.DropSoureUid != 0)
			{
				DropSoureUid = other.DropSoureUid;
			}
			ditems_.Add(other.ditems_);
			if (other.PackageId != 0)
			{
				PackageId = other.PackageId;
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
				Wid = input.ReadInt32();
				break;
			case 16u:
				DropSoureUid = input.ReadInt32();
				break;
			case 26u:
				ditems_.AddEntriesFrom(ref input, _repeated_ditems_codec);
				break;
			case 32u:
				PackageId = input.ReadUInt32();
				break;
			}
		}
	}
}
