using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ScenePosParam : IMessage<ScenePosParam>, IMessage, IEquatable<ScenePosParam>, IDeepCloneable<ScenePosParam>, IBufferMessage
{
	private static readonly MessageParser<ScenePosParam> _parser = new MessageParser<ScenePosParam>(() => new ScenePosParam());

	private UnknownFieldSet _unknownFields;

	public const int GameworldIDFieldNumber = 1;

	private int gameworldID_;

	public const int ChunkIDFieldNumber = 2;

	private int chunkID_;

	public const int PosFieldNumber = 3;

	private PBVector3 pos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ScenePosParam> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[61];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int GameworldID
	{
		get
		{
			return gameworldID_;
		}
		set
		{
			gameworldID_ = value;
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
	public ScenePosParam()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ScenePosParam(ScenePosParam other)
		: this()
	{
		gameworldID_ = other.gameworldID_;
		chunkID_ = other.chunkID_;
		pos_ = ((other.pos_ != null) ? other.pos_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ScenePosParam Clone()
	{
		return new ScenePosParam(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ScenePosParam);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ScenePosParam other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (GameworldID != other.GameworldID)
		{
			return false;
		}
		if (ChunkID != other.ChunkID)
		{
			return false;
		}
		if (!object.Equals(Pos, other.Pos))
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
		if (GameworldID != 0)
		{
			num ^= GameworldID.GetHashCode();
		}
		if (ChunkID != 0)
		{
			num ^= ChunkID.GetHashCode();
		}
		if (pos_ != null)
		{
			num ^= Pos.GetHashCode();
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
		if (GameworldID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(GameworldID);
		}
		if (ChunkID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ChunkID);
		}
		if (pos_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(Pos);
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
		if (GameworldID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GameworldID);
		}
		if (ChunkID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChunkID);
		}
		if (pos_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Pos);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ScenePosParam other)
	{
		if (other == null)
		{
			return;
		}
		if (other.GameworldID != 0)
		{
			GameworldID = other.GameworldID;
		}
		if (other.ChunkID != 0)
		{
			ChunkID = other.ChunkID;
		}
		if (other.pos_ != null)
		{
			if (pos_ == null)
			{
				Pos = new PBVector3();
			}
			Pos.MergeFrom(other.Pos);
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
			case 8u:
				GameworldID = input.ReadInt32();
				break;
			case 16u:
				ChunkID = input.ReadInt32();
				break;
			case 26u:
				if (pos_ == null)
				{
					Pos = new PBVector3();
				}
				input.ReadMessage(Pos);
				break;
			}
		}
	}
}
