using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class GmChat : IMessage<GmChat>, IMessage, IEquatable<GmChat>, IDeepCloneable<GmChat>, IBufferMessage
{
	private static readonly MessageParser<GmChat> _parser = new MessageParser<GmChat>(() => new GmChat());

	private UnknownFieldSet _unknownFields;

	public const int TsFieldNumber = 1;

	private int ts_;

	public const int MsgFieldNumber = 2;

	private string msg_ = "";

	public const int GmFieldNumber = 3;

	private bool gm_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GmChat> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => GmReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Ts
	{
		get
		{
			return ts_;
		}
		set
		{
			ts_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Msg
	{
		get
		{
			return msg_;
		}
		set
		{
			msg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Gm
	{
		get
		{
			return gm_;
		}
		set
		{
			gm_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GmChat()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GmChat(GmChat other)
		: this()
	{
		ts_ = other.ts_;
		msg_ = other.msg_;
		gm_ = other.gm_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GmChat Clone()
	{
		return new GmChat(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GmChat);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GmChat other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Ts != other.Ts)
		{
			return false;
		}
		if (Msg != other.Msg)
		{
			return false;
		}
		if (Gm != other.Gm)
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
		if (Ts != 0)
		{
			num ^= Ts.GetHashCode();
		}
		if (Msg.Length != 0)
		{
			num ^= Msg.GetHashCode();
		}
		if (Gm)
		{
			num ^= Gm.GetHashCode();
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
		if (Ts != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Ts);
		}
		if (Msg.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Msg);
		}
		if (Gm)
		{
			output.WriteRawTag(24);
			output.WriteBool(Gm);
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
		if (Ts != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Ts);
		}
		if (Msg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Msg);
		}
		if (Gm)
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
	public void MergeFrom(GmChat other)
	{
		if (other != null)
		{
			if (other.Ts != 0)
			{
				Ts = other.Ts;
			}
			if (other.Msg.Length != 0)
			{
				Msg = other.Msg;
			}
			if (other.Gm)
			{
				Gm = other.Gm;
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
				Ts = input.ReadInt32();
				break;
			case 18u:
				Msg = input.ReadString();
				break;
			case 24u:
				Gm = input.ReadBool();
				break;
			}
		}
	}
}
