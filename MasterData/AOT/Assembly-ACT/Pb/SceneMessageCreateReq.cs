using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class SceneMessageCreateReq : IMessage<SceneMessageCreateReq>, IMessage, IEquatable<SceneMessageCreateReq>, IDeepCloneable<SceneMessageCreateReq>, IBufferMessage
{
	private static readonly MessageParser<SceneMessageCreateReq> _parser = new MessageParser<SceneMessageCreateReq>(() => new SceneMessageCreateReq());

	private UnknownFieldSet _unknownFields;

	public const int SyntaxIdFieldNumber = 1;

	private int syntaxId_;

	public const int ContentIdsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_contentIds_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> contentIds_ = new RepeatedField<int>();

	public const int StyleIdFieldNumber = 3;

	private int styleId_;

	public const int PositionFieldNumber = 4;

	private PBVector3 position_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SceneMessageCreateReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MessageboardReflection.Descriptor.MessageTypes[4];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SyntaxId
	{
		get
		{
			return syntaxId_;
		}
		set
		{
			syntaxId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> ContentIds => contentIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int StyleId
	{
		get
		{
			return styleId_;
		}
		set
		{
			styleId_ = value;
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
	public SceneMessageCreateReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneMessageCreateReq(SceneMessageCreateReq other)
		: this()
	{
		syntaxId_ = other.syntaxId_;
		contentIds_ = other.contentIds_.Clone();
		styleId_ = other.styleId_;
		position_ = ((other.position_ != null) ? other.position_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneMessageCreateReq Clone()
	{
		return new SceneMessageCreateReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SceneMessageCreateReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SceneMessageCreateReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (SyntaxId != other.SyntaxId)
		{
			return false;
		}
		if (!contentIds_.Equals(other.contentIds_))
		{
			return false;
		}
		if (StyleId != other.StyleId)
		{
			return false;
		}
		if (!object.Equals(Position, other.Position))
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
		if (SyntaxId != 0)
		{
			num ^= SyntaxId.GetHashCode();
		}
		num ^= contentIds_.GetHashCode();
		if (StyleId != 0)
		{
			num ^= StyleId.GetHashCode();
		}
		if (position_ != null)
		{
			num ^= Position.GetHashCode();
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
		if (SyntaxId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(SyntaxId);
		}
		contentIds_.WriteTo(ref output, _repeated_contentIds_codec);
		if (StyleId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(StyleId);
		}
		if (position_ != null)
		{
			output.WriteRawTag(34);
			output.WriteMessage(Position);
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
		if (SyntaxId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SyntaxId);
		}
		num += contentIds_.CalculateSize(_repeated_contentIds_codec);
		if (StyleId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StyleId);
		}
		if (position_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Position);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SceneMessageCreateReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.SyntaxId != 0)
		{
			SyntaxId = other.SyntaxId;
		}
		contentIds_.Add(other.contentIds_);
		if (other.StyleId != 0)
		{
			StyleId = other.StyleId;
		}
		if (other.position_ != null)
		{
			if (position_ == null)
			{
				Position = new PBVector3();
			}
			Position.MergeFrom(other.Position);
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
				SyntaxId = input.ReadInt32();
				break;
			case 16u:
			case 18u:
				contentIds_.AddEntriesFrom(ref input, _repeated_contentIds_codec);
				break;
			case 24u:
				StyleId = input.ReadInt32();
				break;
			case 34u:
				if (position_ == null)
				{
					Position = new PBVector3();
				}
				input.ReadMessage(Position);
				break;
			}
		}
	}
}
