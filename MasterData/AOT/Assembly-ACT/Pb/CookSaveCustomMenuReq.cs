using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class CookSaveCustomMenuReq : IMessage<CookSaveCustomMenuReq>, IMessage, IEquatable<CookSaveCustomMenuReq>, IDeepCloneable<CookSaveCustomMenuReq>, IBufferMessage
{
	private static readonly MessageParser<CookSaveCustomMenuReq> _parser = new MessageParser<CookSaveCustomMenuReq>(() => new CookSaveCustomMenuReq());

	private UnknownFieldSet _unknownFields;

	public const int MenuFieldNumber = 1;

	private CookMenu menu_;

	public const int IdxFieldNumber = 2;

	private int idx_;

	public const int FromBuffFieldNumber = 3;

	private bool fromBuff_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CookSaveCustomMenuReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[65];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CookMenu Menu
	{
		get
		{
			return menu_;
		}
		set
		{
			menu_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Idx
	{
		get
		{
			return idx_;
		}
		set
		{
			idx_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool FromBuff
	{
		get
		{
			return fromBuff_;
		}
		set
		{
			fromBuff_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CookSaveCustomMenuReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CookSaveCustomMenuReq(CookSaveCustomMenuReq other)
		: this()
	{
		menu_ = ((other.menu_ != null) ? other.menu_.Clone() : null);
		idx_ = other.idx_;
		fromBuff_ = other.fromBuff_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CookSaveCustomMenuReq Clone()
	{
		return new CookSaveCustomMenuReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CookSaveCustomMenuReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CookSaveCustomMenuReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Menu, other.Menu))
		{
			return false;
		}
		if (Idx != other.Idx)
		{
			return false;
		}
		if (FromBuff != other.FromBuff)
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
		if (menu_ != null)
		{
			num ^= Menu.GetHashCode();
		}
		if (Idx != 0)
		{
			num ^= Idx.GetHashCode();
		}
		if (FromBuff)
		{
			num ^= FromBuff.GetHashCode();
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
		if (menu_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Menu);
		}
		if (Idx != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Idx);
		}
		if (FromBuff)
		{
			output.WriteRawTag(24);
			output.WriteBool(FromBuff);
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
		if (menu_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Menu);
		}
		if (Idx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Idx);
		}
		if (FromBuff)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CookSaveCustomMenuReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.menu_ != null)
		{
			if (menu_ == null)
			{
				Menu = new CookMenu();
			}
			Menu.MergeFrom(other.Menu);
		}
		if (other.Idx != 0)
		{
			Idx = other.Idx;
		}
		if (other.FromBuff)
		{
			FromBuff = other.FromBuff;
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
				if (menu_ == null)
				{
					Menu = new CookMenu();
				}
				input.ReadMessage(Menu);
				break;
			case 16u:
				Idx = input.ReadInt32();
				break;
			case 24u:
				FromBuff = input.ReadBool();
				break;
			}
		}
	}
}
