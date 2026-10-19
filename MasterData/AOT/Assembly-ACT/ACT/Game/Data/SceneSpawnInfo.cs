using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class SceneSpawnInfo : IMessage<SceneSpawnInfo>, IMessage, IEquatable<SceneSpawnInfo>, IDeepCloneable<SceneSpawnInfo>, IBufferMessage
{
	private static readonly MessageParser<SceneSpawnInfo> _parser = new MessageParser<SceneSpawnInfo>(() => new SceneSpawnInfo());

	private UnknownFieldSet _unknownFields;

	public const int PosFieldNumber = 1;

	private PBVector3 pos_;

	public const int InteractionObjUIDFieldNumber = 2;

	private int interactionObjUID_;

	public const int ChunkIDFieldNumber = 3;

	private int chunkID_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SceneSpawnInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[59];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PBVector3 Pos
	{
		get
		{
			return pos_;
		}
		set
		{
			pos_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int InteractionObjUID
	{
		get
		{
			return interactionObjUID_;
		}
		set
		{
			interactionObjUID_ = value;
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
	public SceneSpawnInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneSpawnInfo(SceneSpawnInfo other)
		: this()
	{
		pos_ = ((other.pos_ != null) ? other.pos_.Clone() : null);
		interactionObjUID_ = other.interactionObjUID_;
		chunkID_ = other.chunkID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneSpawnInfo Clone()
	{
		return new SceneSpawnInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SceneSpawnInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SceneSpawnInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Pos, other.Pos))
		{
			return false;
		}
		if (InteractionObjUID != other.InteractionObjUID)
		{
			return false;
		}
		if (ChunkID != other.ChunkID)
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
		if (pos_ != null)
		{
			num ^= Pos.GetHashCode();
		}
		if (InteractionObjUID != 0)
		{
			num ^= InteractionObjUID.GetHashCode();
		}
		if (ChunkID != 0)
		{
			num ^= ChunkID.GetHashCode();
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
		if (pos_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Pos);
		}
		if (InteractionObjUID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(InteractionObjUID);
		}
		if (ChunkID != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ChunkID);
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
		if (pos_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Pos);
		}
		if (InteractionObjUID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(InteractionObjUID);
		}
		if (ChunkID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChunkID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SceneSpawnInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.pos_ != null)
		{
			if (pos_ == null)
			{
				Pos = new PBVector3();
			}
			Pos.MergeFrom(other.Pos);
		}
		if (other.InteractionObjUID != 0)
		{
			InteractionObjUID = other.InteractionObjUID;
		}
		if (other.ChunkID != 0)
		{
			ChunkID = other.ChunkID;
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
				if (pos_ == null)
				{
					Pos = new PBVector3();
				}
				input.ReadMessage(Pos);
				break;
			case 16u:
				InteractionObjUID = input.ReadInt32();
				break;
			case 24u:
				ChunkID = input.ReadInt32();
				break;
			}
		}
	}
}
