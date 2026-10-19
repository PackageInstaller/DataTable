using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class CookAck : IMessage<CookAck>, IMessage, IEquatable<CookAck>, IDeepCloneable<CookAck>, IBufferMessage
{
	private static readonly MessageParser<CookAck> _parser = new MessageParser<CookAck>(() => new CookAck());

	private UnknownFieldSet _unknownFields;

	public const int RelatedMenuFieldNumber = 1;

	private int relatedMenu_;

	public const int UnlockedMenuFieldNumber = 2;

	private int unlockedMenu_;

	public const int BuffFieldNumber = 3;

	private FoodBuff buff_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CookAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[62];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int RelatedMenu
	{
		get
		{
			return relatedMenu_;
		}
		set
		{
			relatedMenu_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int UnlockedMenu
	{
		get
		{
			return unlockedMenu_;
		}
		set
		{
			unlockedMenu_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FoodBuff Buff
	{
		get
		{
			return buff_;
		}
		set
		{
			buff_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CookAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CookAck(CookAck other)
		: this()
	{
		relatedMenu_ = other.relatedMenu_;
		unlockedMenu_ = other.unlockedMenu_;
		buff_ = ((other.buff_ != null) ? other.buff_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CookAck Clone()
	{
		return new CookAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CookAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CookAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (RelatedMenu != other.RelatedMenu)
		{
			return false;
		}
		if (UnlockedMenu != other.UnlockedMenu)
		{
			return false;
		}
		if (!object.Equals(Buff, other.Buff))
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
		if (RelatedMenu != 0)
		{
			num ^= RelatedMenu.GetHashCode();
		}
		if (UnlockedMenu != 0)
		{
			num ^= UnlockedMenu.GetHashCode();
		}
		if (buff_ != null)
		{
			num ^= Buff.GetHashCode();
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
		if (RelatedMenu != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(RelatedMenu);
		}
		if (UnlockedMenu != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(UnlockedMenu);
		}
		if (buff_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(Buff);
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
		if (RelatedMenu != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RelatedMenu);
		}
		if (UnlockedMenu != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockedMenu);
		}
		if (buff_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Buff);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CookAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.RelatedMenu != 0)
		{
			RelatedMenu = other.RelatedMenu;
		}
		if (other.UnlockedMenu != 0)
		{
			UnlockedMenu = other.UnlockedMenu;
		}
		if (other.buff_ != null)
		{
			if (buff_ == null)
			{
				Buff = new FoodBuff();
			}
			Buff.MergeFrom(other.Buff);
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
				RelatedMenu = input.ReadInt32();
				break;
			case 16u:
				UnlockedMenu = input.ReadInt32();
				break;
			case 26u:
				if (buff_ == null)
				{
					Buff = new FoodBuff();
				}
				input.ReadMessage(Buff);
				break;
			}
		}
	}
}
