using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class QueryUserBySDKAidReq : IMessage<QueryUserBySDKAidReq>, IMessage, IEquatable<QueryUserBySDKAidReq>, IDeepCloneable<QueryUserBySDKAidReq>, IBufferMessage
{
	private static readonly MessageParser<QueryUserBySDKAidReq> _parser = new MessageParser<QueryUserBySDKAidReq>(() => new QueryUserBySDKAidReq());

	private UnknownFieldSet _unknownFields;

	public const int SdkAidFieldNumber = 1;

	private long sdkAid_;

	public const int DbNameFieldNumber = 2;

	private string dbName_ = "";

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<QueryUserBySDKAidReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => UserReflection.Descriptor.MessageTypes[4];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long SdkAid
	{
		get
		{
			return sdkAid_;
		}
		set
		{
			sdkAid_ = value;
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
	public QueryUserBySDKAidReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public QueryUserBySDKAidReq(QueryUserBySDKAidReq other)
		: this()
	{
		sdkAid_ = other.sdkAid_;
		dbName_ = other.dbName_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public QueryUserBySDKAidReq Clone()
	{
		return new QueryUserBySDKAidReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as QueryUserBySDKAidReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(QueryUserBySDKAidReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (SdkAid != other.SdkAid)
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
		if (SdkAid != 0L)
		{
			num ^= SdkAid.GetHashCode();
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
		if (SdkAid != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(SdkAid);
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
		if (SdkAid != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(SdkAid);
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
	public void MergeFrom(QueryUserBySDKAidReq other)
	{
		if (other != null)
		{
			if (other.SdkAid != 0L)
			{
				SdkAid = other.SdkAid;
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
			case 8u:
				SdkAid = input.ReadInt64();
				break;
			case 18u:
				DbName = input.ReadString();
				break;
			}
		}
	}
}
