using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class QueryUserByOpenIdReq : IMessage<QueryUserByOpenIdReq>, IMessage, IEquatable<QueryUserByOpenIdReq>, IDeepCloneable<QueryUserByOpenIdReq>, IBufferMessage
{
	private static readonly MessageParser<QueryUserByOpenIdReq> _parser = new MessageParser<QueryUserByOpenIdReq>(() => new QueryUserByOpenIdReq());

	private UnknownFieldSet _unknownFields;

	public const int OpenIdFieldNumber = 1;

	private string openId_ = "";

	public const int DbNameFieldNumber = 2;

	private string dbName_ = "";

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<QueryUserByOpenIdReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => UserReflection.Descriptor.MessageTypes[3];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string OpenId
	{
		get
		{
			return openId_;
		}
		set
		{
			openId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string DbName
	{
		get
		{
			return dbName_;
		}
		set
		{
			dbName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public QueryUserByOpenIdReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public QueryUserByOpenIdReq(QueryUserByOpenIdReq other)
		: this()
	{
		openId_ = other.openId_;
		dbName_ = other.dbName_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public QueryUserByOpenIdReq Clone()
	{
		return new QueryUserByOpenIdReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as QueryUserByOpenIdReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(QueryUserByOpenIdReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (OpenId != other.OpenId)
		{
			return false;
		}
		if (DbName != other.DbName)
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
		if (OpenId.Length != 0)
		{
			num ^= OpenId.GetHashCode();
		}
		if (DbName.Length != 0)
		{
			num ^= DbName.GetHashCode();
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
		if (OpenId.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(OpenId);
		}
		if (DbName.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(DbName);
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
		if (OpenId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OpenId);
		}
		if (DbName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DbName);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(QueryUserByOpenIdReq other)
	{
		if (other != null)
		{
			if (other.OpenId.Length != 0)
			{
				OpenId = other.OpenId;
			}
			if (other.DbName.Length != 0)
			{
				DbName = other.DbName;
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
			case 10u:
				OpenId = input.ReadString();
				break;
			case 18u:
				DbName = input.ReadString();
				break;
			}
		}
	}
}
