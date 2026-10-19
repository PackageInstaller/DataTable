using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class LoungeTriggerPointReq : IMessage<LoungeTriggerPointReq>, IMessage, IEquatable<LoungeTriggerPointReq>, IDeepCloneable<LoungeTriggerPointReq>, IBufferMessage
{
	private static readonly MessageParser<LoungeTriggerPointReq> _parser = new MessageParser<LoungeTriggerPointReq>(() => new LoungeTriggerPointReq());

	private UnknownFieldSet _unknownFields;

	public const int PointIDFieldNumber = 1;

	private int pointID_;

	public const int TriggerTypeFieldNumber = 2;

	private LoungeTriggerPointType triggerType_;

	public const int CharacterIDFieldNumber = 3;

	private int characterID_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<LoungeTriggerPointReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => LoungeReflection.Descriptor.MessageTypes[6];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PointID
	{
		get
		{
			return pointID_;
		}
		set
		{
			pointID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeTriggerPointType TriggerType
	{
		get
		{
			return triggerType_;
		}
		set
		{
			triggerType_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CharacterID
	{
		get
		{
			return characterID_;
		}
		set
		{
			characterID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeTriggerPointReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeTriggerPointReq(LoungeTriggerPointReq other)
		: this()
	{
		pointID_ = other.pointID_;
		triggerType_ = other.triggerType_;
		characterID_ = other.characterID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeTriggerPointReq Clone()
	{
		return new LoungeTriggerPointReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as LoungeTriggerPointReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(LoungeTriggerPointReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PointID != other.PointID)
		{
			return false;
		}
		if (TriggerType != other.TriggerType)
		{
			return false;
		}
		if (CharacterID != other.CharacterID)
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
		if (PointID != 0)
		{
			num ^= PointID.GetHashCode();
		}
		if (TriggerType != LoungeTriggerPointType.InviteCharacter)
		{
			num ^= TriggerType.GetHashCode();
		}
		if (CharacterID != 0)
		{
			num ^= CharacterID.GetHashCode();
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
		if (PointID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(PointID);
		}
		if (TriggerType != LoungeTriggerPointType.InviteCharacter)
		{
			output.WriteRawTag(16);
			output.WriteEnum((int)TriggerType);
		}
		if (CharacterID != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CharacterID);
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
		if (PointID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PointID);
		}
		if (TriggerType != LoungeTriggerPointType.InviteCharacter)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)TriggerType);
		}
		if (CharacterID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(LoungeTriggerPointReq other)
	{
		if (other != null)
		{
			if (other.PointID != 0)
			{
				PointID = other.PointID;
			}
			if (other.TriggerType != LoungeTriggerPointType.InviteCharacter)
			{
				TriggerType = other.TriggerType;
			}
			if (other.CharacterID != 0)
			{
				CharacterID = other.CharacterID;
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
				PointID = input.ReadInt32();
				break;
			case 16u:
				TriggerType = (LoungeTriggerPointType)input.ReadEnum();
				break;
			case 24u:
				CharacterID = input.ReadInt32();
				break;
			}
		}
	}
}
