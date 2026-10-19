using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MapCustomFlag : IMessage<MapCustomFlag>, IMessage, IEquatable<MapCustomFlag>, IDeepCloneable<MapCustomFlag>, IBufferMessage
{
	private static readonly MessageParser<MapCustomFlag> _parser = new MessageParser<MapCustomFlag>(() => new MapCustomFlag());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TidFieldNumber = 2;

	private int tid_;

	public const int PosFieldNumber = 3;

	private PBVector3 pos_;

	public const int AreaIDFieldNumber = 4;

	private int areaID_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapCustomFlag> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[89];

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
	public int Tid
	{
		get
		{
			return tid_;
		}
		set
		{
			tid_ = value;
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
	public int AreaID
	{
		get
		{
			return areaID_;
		}
		set
		{
			areaID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapCustomFlag()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapCustomFlag(MapCustomFlag other)
		: this()
	{
		id_ = other.id_;
		tid_ = other.tid_;
		pos_ = ((other.pos_ != null) ? other.pos_.Clone() : null);
		areaID_ = other.areaID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapCustomFlag Clone()
	{
		return new MapCustomFlag(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapCustomFlag);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapCustomFlag other)
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
		if (Tid != other.Tid)
		{
			return false;
		}
		if (!object.Equals(Pos, other.Pos))
		{
			return false;
		}
		if (AreaID != other.AreaID)
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
		if (Tid != 0)
		{
			num ^= Tid.GetHashCode();
		}
		if (pos_ != null)
		{
			num ^= Pos.GetHashCode();
		}
		if (AreaID != 0)
		{
			num ^= AreaID.GetHashCode();
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
		if (Tid != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Tid);
		}
		if (pos_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(Pos);
		}
		if (AreaID != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AreaID);
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
		if (Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tid);
		}
		if (pos_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Pos);
		}
		if (AreaID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AreaID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapCustomFlag other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Id != 0)
		{
			Id = other.Id;
		}
		if (other.Tid != 0)
		{
			Tid = other.Tid;
		}
		if (other.pos_ != null)
		{
			if (pos_ == null)
			{
				Pos = new PBVector3();
			}
			Pos.MergeFrom(other.Pos);
		}
		if (other.AreaID != 0)
		{
			AreaID = other.AreaID;
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
				Id = input.ReadInt32();
				break;
			case 16u:
				Tid = input.ReadInt32();
				break;
			case 26u:
				if (pos_ == null)
				{
					Pos = new PBVector3();
				}
				input.ReadMessage(Pos);
				break;
			case 32u:
				AreaID = input.ReadInt32();
				break;
			}
		}
	}
}
