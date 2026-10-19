using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class SceneSwitchReq : IMessage<SceneSwitchReq>, IMessage, IEquatable<SceneSwitchReq>, IDeepCloneable<SceneSwitchReq>, IBufferMessage
{
	private static readonly MessageParser<SceneSwitchReq> _parser = new MessageParser<SceneSwitchReq>(() => new SceneSwitchReq());

	private UnknownFieldSet _unknownFields;

	public const int WidFieldNumber = 1;

	private int wid_;

	public const int PositionFieldNumber = 2;

	private PBVector3 position_;

	public const int CidFieldNumber = 3;

	private int cid_;

	public const int AreaIdFieldNumber = 4;

	private int areaId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SceneSwitchReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[109];

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
	public int Cid
	{
		get
		{
			return cid_;
		}
		set
		{
			cid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int AreaId
	{
		get
		{
			return areaId_;
		}
		set
		{
			areaId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneSwitchReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneSwitchReq(SceneSwitchReq other)
		: this()
	{
		wid_ = other.wid_;
		position_ = ((other.position_ != null) ? other.position_.Clone() : null);
		cid_ = other.cid_;
		areaId_ = other.areaId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneSwitchReq Clone()
	{
		return new SceneSwitchReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SceneSwitchReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SceneSwitchReq other)
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
		if (!object.Equals(Position, other.Position))
		{
			return false;
		}
		if (Cid != other.Cid)
		{
			return false;
		}
		if (AreaId != other.AreaId)
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
		if (position_ != null)
		{
			num ^= Position.GetHashCode();
		}
		if (Cid != 0)
		{
			num ^= Cid.GetHashCode();
		}
		if (AreaId != 0)
		{
			num ^= AreaId.GetHashCode();
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
		if (position_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(Position);
		}
		if (Cid != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Cid);
		}
		if (AreaId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AreaId);
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
		if (position_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Position);
		}
		if (Cid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cid);
		}
		if (AreaId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AreaId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SceneSwitchReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Wid != 0)
		{
			Wid = other.Wid;
		}
		if (other.position_ != null)
		{
			if (position_ == null)
			{
				Position = new PBVector3();
			}
			Position.MergeFrom(other.Position);
		}
		if (other.Cid != 0)
		{
			Cid = other.Cid;
		}
		if (other.AreaId != 0)
		{
			AreaId = other.AreaId;
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
				Wid = input.ReadInt32();
				break;
			case 18u:
				if (position_ == null)
				{
					Position = new PBVector3();
				}
				input.ReadMessage(Position);
				break;
			case 24u:
				Cid = input.ReadInt32();
				break;
			case 32u:
				AreaId = input.ReadInt32();
				break;
			}
		}
	}
}
