using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class KickUserNtf : IMessage<KickUserNtf>, IMessage, IEquatable<KickUserNtf>, IDeepCloneable<KickUserNtf>, IBufferMessage
{
	private static readonly MessageParser<KickUserNtf> _parser = new MessageParser<KickUserNtf>(() => new KickUserNtf());

	private UnknownFieldSet _unknownFields;

	public const int ReasonFieldNumber = 1;

	private string reason_ = "";

	public const int ErrCodeFieldNumber = 2;

	private string errCode_ = "";

	public const int InfoFieldNumber = 3;

	private ErrorAck info_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<KickUserNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[7];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Reason
	{
		get
		{
			return reason_;
		}
		set
		{
			reason_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string ErrCode
	{
		get
		{
			return errCode_;
		}
		set
		{
			errCode_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ErrorAck Info
	{
		get
		{
			return info_;
		}
		set
		{
			info_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public KickUserNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public KickUserNtf(KickUserNtf other)
		: this()
	{
		reason_ = other.reason_;
		errCode_ = other.errCode_;
		info_ = ((other.info_ != null) ? other.info_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public KickUserNtf Clone()
	{
		return new KickUserNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as KickUserNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(KickUserNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Reason != other.Reason)
		{
			return false;
		}
		if (ErrCode != other.ErrCode)
		{
			return false;
		}
		if (!object.Equals(Info, other.Info))
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
		if (Reason.Length != 0)
		{
			num ^= Reason.GetHashCode();
		}
		if (ErrCode.Length != 0)
		{
			num ^= ErrCode.GetHashCode();
		}
		if (info_ != null)
		{
			num ^= Info.GetHashCode();
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
		if (Reason.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Reason);
		}
		if (ErrCode.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(ErrCode);
		}
		if (info_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(Info);
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
		if (Reason.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Reason);
		}
		if (ErrCode.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ErrCode);
		}
		if (info_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Info);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(KickUserNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Reason.Length != 0)
		{
			Reason = other.Reason;
		}
		if (other.ErrCode.Length != 0)
		{
			ErrCode = other.ErrCode;
		}
		if (other.info_ != null)
		{
			if (info_ == null)
			{
				Info = new ErrorAck();
			}
			Info.MergeFrom(other.Info);
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
				Reason = input.ReadString();
				break;
			case 18u:
				ErrCode = input.ReadString();
				break;
			case 26u:
				if (info_ == null)
				{
					Info = new ErrorAck();
				}
				input.ReadMessage(Info);
				break;
			}
		}
	}
}
