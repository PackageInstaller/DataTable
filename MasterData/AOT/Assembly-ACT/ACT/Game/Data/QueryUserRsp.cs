using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class QueryUserRsp : IMessage<QueryUserRsp>, IMessage, IEquatable<QueryUserRsp>, IDeepCloneable<QueryUserRsp>, IBufferMessage
{
	private static readonly MessageParser<QueryUserRsp> _parser = new MessageParser<QueryUserRsp>(() => new QueryUserRsp());

	private UnknownFieldSet _unknownFields;

	public const int ErrorFieldNumber = 1;

	private ErrorAck error_;

	public const int UserFieldNumber = 2;

	private DBUser user_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<QueryUserRsp> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => UserReflection.Descriptor.MessageTypes[5];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ErrorAck Error
	{
		get
		{
			return error_;
		}
		set
		{
			error_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DBUser User
	{
		get
		{
			return user_;
		}
		set
		{
			user_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public QueryUserRsp()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public QueryUserRsp(QueryUserRsp other)
		: this()
	{
		error_ = ((other.error_ != null) ? other.error_.Clone() : null);
		user_ = ((other.user_ != null) ? other.user_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public QueryUserRsp Clone()
	{
		return new QueryUserRsp(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as QueryUserRsp);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(QueryUserRsp other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Error, other.Error))
		{
			return false;
		}
		if (!object.Equals(User, other.User))
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
		if (error_ != null)
		{
			num ^= Error.GetHashCode();
		}
		if (user_ != null)
		{
			num ^= User.GetHashCode();
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
		if (error_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Error);
		}
		if (user_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(User);
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
		if (error_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Error);
		}
		if (user_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(User);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(QueryUserRsp other)
	{
		if (other == null)
		{
			return;
		}
		if (other.error_ != null)
		{
			if (error_ == null)
			{
				Error = new ErrorAck();
			}
			Error.MergeFrom(other.Error);
		}
		if (other.user_ != null)
		{
			if (user_ == null)
			{
				User = new DBUser();
			}
			User.MergeFrom(other.User);
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
				if (error_ == null)
				{
					Error = new ErrorAck();
				}
				input.ReadMessage(Error);
				break;
			case 18u:
				if (user_ == null)
				{
					User = new DBUser();
				}
				input.ReadMessage(User);
				break;
			}
		}
	}
}
