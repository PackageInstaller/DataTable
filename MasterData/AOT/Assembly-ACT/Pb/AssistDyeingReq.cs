using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class AssistDyeingReq : IMessage<AssistDyeingReq>, IMessage, IEquatable<AssistDyeingReq>, IDeepCloneable<AssistDyeingReq>, IBufferMessage
{
	private static readonly MessageParser<AssistDyeingReq> _parser = new MessageParser<AssistDyeingReq>(() => new AssistDyeingReq());

	private UnknownFieldSet _unknownFields;

	public const int AssistFieldNumber = 1;

	private int assist_;

	public const int SkinFieldNumber = 2;

	private int skin_;

	public const int ColorFieldNumber = 3;

	private int color_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AssistDyeingReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => AssistReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Assist
	{
		get
		{
			return assist_;
		}
		set
		{
			assist_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Skin
	{
		get
		{
			return skin_;
		}
		set
		{
			skin_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Color
	{
		get
		{
			return color_;
		}
		set
		{
			color_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AssistDyeingReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AssistDyeingReq(AssistDyeingReq other)
		: this()
	{
		assist_ = other.assist_;
		skin_ = other.skin_;
		color_ = other.color_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AssistDyeingReq Clone()
	{
		return new AssistDyeingReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AssistDyeingReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AssistDyeingReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Assist != other.Assist)
		{
			return false;
		}
		if (Skin != other.Skin)
		{
			return false;
		}
		if (Color != other.Color)
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
		if (Assist != 0)
		{
			num ^= Assist.GetHashCode();
		}
		if (Skin != 0)
		{
			num ^= Skin.GetHashCode();
		}
		if (Color != 0)
		{
			num ^= Color.GetHashCode();
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
		if (Assist != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Assist);
		}
		if (Skin != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Skin);
		}
		if (Color != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Color);
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
		if (Assist != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Assist);
		}
		if (Skin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Skin);
		}
		if (Color != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Color);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AssistDyeingReq other)
	{
		if (other != null)
		{
			if (other.Assist != 0)
			{
				Assist = other.Assist;
			}
			if (other.Skin != 0)
			{
				Skin = other.Skin;
			}
			if (other.Color != 0)
			{
				Color = other.Color;
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
				Assist = input.ReadInt32();
				break;
			case 16u:
				Skin = input.ReadInt32();
				break;
			case 24u:
				Color = input.ReadInt32();
				break;
			}
		}
	}
}
