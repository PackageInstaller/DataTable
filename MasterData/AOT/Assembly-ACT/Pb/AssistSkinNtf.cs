using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class AssistSkinNtf : IMessage<AssistSkinNtf>, IMessage, IEquatable<AssistSkinNtf>, IDeepCloneable<AssistSkinNtf>, IBufferMessage
{
	private static readonly MessageParser<AssistSkinNtf> _parser = new MessageParser<AssistSkinNtf>(() => new AssistSkinNtf());

	private UnknownFieldSet _unknownFields;

	public const int AssistFieldNumber = 1;

	private int assist_;

	public const int SkinFieldNumber = 2;

	private AssistSkin skin_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AssistSkinNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => AssistReflection.Descriptor.MessageTypes[1];

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
	public AssistSkin Skin
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
	public AssistSkinNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AssistSkinNtf(AssistSkinNtf other)
		: this()
	{
		assist_ = other.assist_;
		skin_ = ((other.skin_ != null) ? other.skin_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AssistSkinNtf Clone()
	{
		return new AssistSkinNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AssistSkinNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AssistSkinNtf other)
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
		if (!object.Equals(Skin, other.Skin))
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
		if (skin_ != null)
		{
			num ^= Skin.GetHashCode();
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
		if (skin_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(Skin);
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
		if (skin_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Skin);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AssistSkinNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Assist != 0)
		{
			Assist = other.Assist;
		}
		if (other.skin_ != null)
		{
			if (skin_ == null)
			{
				Skin = new AssistSkin();
			}
			Skin.MergeFrom(other.Skin);
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
				Assist = input.ReadInt32();
				break;
			case 18u:
				if (skin_ == null)
				{
					Skin = new AssistSkin();
				}
				input.ReadMessage(Skin);
				break;
			}
		}
	}
}
