using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Bloodstain : IMessage<Bloodstain>, IMessage, IEquatable<Bloodstain>, IDeepCloneable<Bloodstain>, IBufferMessage
{
	private static readonly MessageParser<Bloodstain> _parser = new MessageParser<Bloodstain>(() => new Bloodstain());

	private UnknownFieldSet _unknownFields;

	public const int StateFieldNumber = 7;

	private BloodstainState state_;

	public const int IdFieldNumber = 1;

	private string id_ = "";

	public const int OwnerAccountIdFieldNumber = 2;

	private long ownerAccountId_;

	public const int ChunkIDFieldNumber = 3;

	private int chunkID_;

	public const int PositionFieldNumber = 4;

	private PBVector3 position_;

	public const int CreateTsFieldNumber = 5;

	private long createTs_;

	public const int ExpireTsFieldNumber = 6;

	private long expireTs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Bloodstain> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[175];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BloodstainState State
	{
		get
		{
			return state_;
		}
		set
		{
			state_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long OwnerAccountId
	{
		get
		{
			return ownerAccountId_;
		}
		set
		{
			ownerAccountId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ChunkID
	{
		get
		{
			return chunkID_;
		}
		set
		{
			chunkID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PBVector3 Position
	{
		get
		{
			return position_;
		}
		set
		{
			position_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long CreateTs
	{
		get
		{
			return createTs_;
		}
		set
		{
			createTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long ExpireTs
	{
		get
		{
			return expireTs_;
		}
		set
		{
			expireTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Bloodstain()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Bloodstain(Bloodstain other)
		: this()
	{
		state_ = other.state_;
		id_ = other.id_;
		ownerAccountId_ = other.ownerAccountId_;
		chunkID_ = other.chunkID_;
		position_ = ((other.position_ != null) ? other.position_.Clone() : null);
		createTs_ = other.createTs_;
		expireTs_ = other.expireTs_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Bloodstain Clone()
	{
		return new Bloodstain(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Bloodstain);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Bloodstain other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (State != other.State)
		{
			return false;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (OwnerAccountId != other.OwnerAccountId)
		{
			return false;
		}
		if (ChunkID != other.ChunkID)
		{
			return false;
		}
		if (!object.Equals(Position, other.Position))
		{
			return false;
		}
		if (CreateTs != other.CreateTs)
		{
			return false;
		}
		if (ExpireTs != other.ExpireTs)
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
		if (State != BloodstainState.Initial)
		{
			num ^= State.GetHashCode();
		}
		if (Id.Length != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (OwnerAccountId != 0L)
		{
			num ^= OwnerAccountId.GetHashCode();
		}
		if (ChunkID != 0)
		{
			num ^= ChunkID.GetHashCode();
		}
		if (position_ != null)
		{
			num ^= Position.GetHashCode();
		}
		if (CreateTs != 0L)
		{
			num ^= CreateTs.GetHashCode();
		}
		if (ExpireTs != 0L)
		{
			num ^= ExpireTs.GetHashCode();
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
		if (Id.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Id);
		}
		if (OwnerAccountId != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(OwnerAccountId);
		}
		if (ChunkID != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ChunkID);
		}
		if (position_ != null)
		{
			output.WriteRawTag(34);
			output.WriteMessage(Position);
		}
		if (CreateTs != 0L)
		{
			output.WriteRawTag(40);
			output.WriteInt64(CreateTs);
		}
		if (ExpireTs != 0L)
		{
			output.WriteRawTag(48);
			output.WriteInt64(ExpireTs);
		}
		if (State != BloodstainState.Initial)
		{
			output.WriteRawTag(56);
			output.WriteEnum((int)State);
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
		if (State != BloodstainState.Initial)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)State);
		}
		if (Id.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Id);
		}
		if (OwnerAccountId != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(OwnerAccountId);
		}
		if (ChunkID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChunkID);
		}
		if (position_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Position);
		}
		if (CreateTs != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(CreateTs);
		}
		if (ExpireTs != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ExpireTs);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Bloodstain other)
	{
		if (other == null)
		{
			return;
		}
		if (other.State != BloodstainState.Initial)
		{
			State = other.State;
		}
		if (other.Id.Length != 0)
		{
			Id = other.Id;
		}
		if (other.OwnerAccountId != 0L)
		{
			OwnerAccountId = other.OwnerAccountId;
		}
		if (other.ChunkID != 0)
		{
			ChunkID = other.ChunkID;
		}
		if (other.position_ != null)
		{
			if (position_ == null)
			{
				Position = new PBVector3();
			}
			Position.MergeFrom(other.Position);
		}
		if (other.CreateTs != 0L)
		{
			CreateTs = other.CreateTs;
		}
		if (other.ExpireTs != 0L)
		{
			ExpireTs = other.ExpireTs;
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
			case 10u:
				Id = input.ReadString();
				break;
			case 16u:
				OwnerAccountId = input.ReadInt64();
				break;
			case 24u:
				ChunkID = input.ReadInt32();
				break;
			case 34u:
				if (position_ == null)
				{
					Position = new PBVector3();
				}
				input.ReadMessage(Position);
				break;
			case 40u:
				CreateTs = input.ReadInt64();
				break;
			case 48u:
				ExpireTs = input.ReadInt64();
				break;
			case 56u:
				State = (BloodstainState)input.ReadEnum();
				break;
			}
		}
	}
}
