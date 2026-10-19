using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MapModifyCustomFlagTypeReq : IMessage<MapModifyCustomFlagTypeReq>, IMessage, IEquatable<MapModifyCustomFlagTypeReq>, IDeepCloneable<MapModifyCustomFlagTypeReq>, IBufferMessage
{
	private static readonly MessageParser<MapModifyCustomFlagTypeReq> _parser = new MessageParser<MapModifyCustomFlagTypeReq>(() => new MapModifyCustomFlagTypeReq());

	private UnknownFieldSet _unknownFields;

	public const int AreaIDFieldNumber = 1;

	private int areaID_;

	public const int FlagIDFieldNumber = 2;

	private int flagID_;

	public const int NewTypFieldNumber = 3;

	private int newTyp_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapModifyCustomFlagTypeReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MapReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public int FlagID
	{
		get
		{
			return flagID_;
		}
		set
		{
			flagID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int NewTyp
	{
		get
		{
			return newTyp_;
		}
		set
		{
			newTyp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapModifyCustomFlagTypeReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapModifyCustomFlagTypeReq(MapModifyCustomFlagTypeReq other)
		: this()
	{
		areaID_ = other.areaID_;
		flagID_ = other.flagID_;
		newTyp_ = other.newTyp_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapModifyCustomFlagTypeReq Clone()
	{
		return new MapModifyCustomFlagTypeReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapModifyCustomFlagTypeReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapModifyCustomFlagTypeReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (AreaID != other.AreaID)
		{
			return false;
		}
		if (FlagID != other.FlagID)
		{
			return false;
		}
		if (NewTyp != other.NewTyp)
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
		if (AreaID != 0)
		{
			num ^= AreaID.GetHashCode();
		}
		if (FlagID != 0)
		{
			num ^= FlagID.GetHashCode();
		}
		if (NewTyp != 0)
		{
			num ^= NewTyp.GetHashCode();
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
		if (AreaID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(AreaID);
		}
		if (FlagID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(FlagID);
		}
		if (NewTyp != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(NewTyp);
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
		if (AreaID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AreaID);
		}
		if (FlagID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FlagID);
		}
		if (NewTyp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NewTyp);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapModifyCustomFlagTypeReq other)
	{
		if (other != null)
		{
			if (other.AreaID != 0)
			{
				AreaID = other.AreaID;
			}
			if (other.FlagID != 0)
			{
				FlagID = other.FlagID;
			}
			if (other.NewTyp != 0)
			{
				NewTyp = other.NewTyp;
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
				AreaID = input.ReadInt32();
				break;
			case 16u:
				FlagID = input.ReadInt32();
				break;
			case 24u:
				NewTyp = input.ReadInt32();
				break;
			}
		}
	}
}
