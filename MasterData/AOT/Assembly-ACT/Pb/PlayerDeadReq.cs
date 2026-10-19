using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class PlayerDeadReq : IMessage<PlayerDeadReq>, IMessage, IEquatable<PlayerDeadReq>, IDeepCloneable<PlayerDeadReq>, IBufferMessage
{
	private static readonly MessageParser<PlayerDeadReq> _parser = new MessageParser<PlayerDeadReq>(() => new PlayerDeadReq());

	private UnknownFieldSet _unknownFields;

	public const int PositionFieldNumber = 1;

	private PBVector3 position_;

	public const int ChunkIdFieldNumber = 2;

	private int chunkId_;

	public const int CreateBloodstainFieldNumber = 3;

	private bool createBloodstain_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<PlayerDeadReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[150];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public int ChunkId
	{
		get
		{
			return chunkId_;
		}
		set
		{
			chunkId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool CreateBloodstain
	{
		get
		{
			return createBloodstain_;
		}
		set
		{
			createBloodstain_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerDeadReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerDeadReq(PlayerDeadReq other)
		: this()
	{
		position_ = ((other.position_ != null) ? other.position_.Clone() : null);
		chunkId_ = other.chunkId_;
		createBloodstain_ = other.createBloodstain_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerDeadReq Clone()
	{
		return new PlayerDeadReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as PlayerDeadReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(PlayerDeadReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Position, other.Position))
		{
			return false;
		}
		if (ChunkId != other.ChunkId)
		{
			return false;
		}
		if (CreateBloodstain != other.CreateBloodstain)
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
		if (position_ != null)
		{
			num ^= Position.GetHashCode();
		}
		if (ChunkId != 0)
		{
			num ^= ChunkId.GetHashCode();
		}
		if (CreateBloodstain)
		{
			num ^= CreateBloodstain.GetHashCode();
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
		if (position_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Position);
		}
		if (ChunkId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ChunkId);
		}
		if (CreateBloodstain)
		{
			output.WriteRawTag(24);
			output.WriteBool(CreateBloodstain);
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
		if (position_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Position);
		}
		if (ChunkId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChunkId);
		}
		if (CreateBloodstain)
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
	public void MergeFrom(PlayerDeadReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.position_ != null)
		{
			if (position_ == null)
			{
				Position = new PBVector3();
			}
			Position.MergeFrom(other.Position);
		}
		if (other.ChunkId != 0)
		{
			ChunkId = other.ChunkId;
		}
		if (other.CreateBloodstain)
		{
			CreateBloodstain = other.CreateBloodstain;
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
				if (position_ == null)
				{
					Position = new PBVector3();
				}
				input.ReadMessage(Position);
				break;
			case 16u:
				ChunkId = input.ReadInt32();
				break;
			case 24u:
				CreateBloodstain = input.ReadBool();
				break;
			}
		}
	}
}
