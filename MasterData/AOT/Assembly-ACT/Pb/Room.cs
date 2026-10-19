using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class Room : IMessage<Room>, IMessage, IEquatable<Room>, IDeepCloneable<Room>, IBufferMessage
{
	private static readonly MessageParser<Room> _parser = new MessageParser<Room>(() => new Room());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private ulong id_;

	public const int OwnerPIDFieldNumber = 2;

	private long ownerPID_;

	public const int PidsFieldNumber = 3;

	private static readonly FieldCodec<long> _repeated_pids_codec = FieldCodec.ForInt64(26u);

	private readonly RepeatedField<long> pids_ = new RepeatedField<long>();

	public const int CreateStampFieldNumber = 4;

	private long createStamp_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Room> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RoomReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ulong Id
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
	public long OwnerPID
	{
		get
		{
			return ownerPID_;
		}
		set
		{
			ownerPID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<long> Pids => pids_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long CreateStamp
	{
		get
		{
			return createStamp_;
		}
		set
		{
			createStamp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Room()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Room(Room other)
		: this()
	{
		id_ = other.id_;
		ownerPID_ = other.ownerPID_;
		pids_ = other.pids_.Clone();
		createStamp_ = other.createStamp_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Room Clone()
	{
		return new Room(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Room);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Room other)
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
		if (OwnerPID != other.OwnerPID)
		{
			return false;
		}
		if (!pids_.Equals(other.pids_))
		{
			return false;
		}
		if (CreateStamp != other.CreateStamp)
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
		if (Id != 0L)
		{
			num ^= Id.GetHashCode();
		}
		if (OwnerPID != 0L)
		{
			num ^= OwnerPID.GetHashCode();
		}
		num ^= pids_.GetHashCode();
		if (CreateStamp != 0L)
		{
			num ^= CreateStamp.GetHashCode();
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
		if (Id != 0L)
		{
			output.WriteRawTag(8);
			output.WriteUInt64(Id);
		}
		if (OwnerPID != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(OwnerPID);
		}
		pids_.WriteTo(ref output, _repeated_pids_codec);
		if (CreateStamp != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(CreateStamp);
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
		if (Id != 0L)
		{
			num += 1 + CodedOutputStream.ComputeUInt64Size(Id);
		}
		if (OwnerPID != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(OwnerPID);
		}
		num += pids_.CalculateSize(_repeated_pids_codec);
		if (CreateStamp != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(CreateStamp);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Room other)
	{
		if (other != null)
		{
			if (other.Id != 0L)
			{
				Id = other.Id;
			}
			if (other.OwnerPID != 0L)
			{
				OwnerPID = other.OwnerPID;
			}
			pids_.Add(other.pids_);
			if (other.CreateStamp != 0L)
			{
				CreateStamp = other.CreateStamp;
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
				Id = input.ReadUInt64();
				break;
			case 16u:
				OwnerPID = input.ReadInt64();
				break;
			case 24u:
			case 26u:
				pids_.AddEntriesFrom(ref input, _repeated_pids_codec);
				break;
			case 32u:
				CreateStamp = input.ReadInt64();
				break;
			}
		}
	}
}
