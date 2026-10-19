using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class SaveUserReq : IMessage<SaveUserReq>, IMessage, IEquatable<SaveUserReq>, IDeepCloneable<SaveUserReq>, IBufferMessage
{
	private static readonly MessageParser<SaveUserReq> _parser = new MessageParser<SaveUserReq>(() => new SaveUserReq());

	private UnknownFieldSet _unknownFields;

	public const int UserFieldNumber = 1;

	private DBUser user_;

	public const int DbNameFieldNumber = 2;

	private string dbName_ = "";

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SaveUserReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => UserReflection.Descriptor.MessageTypes[6];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public SaveUserReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SaveUserReq(SaveUserReq other)
		: this()
	{
		user_ = ((other.user_ != null) ? other.user_.Clone() : null);
		dbName_ = other.dbName_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SaveUserReq Clone()
	{
		return new SaveUserReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SaveUserReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SaveUserReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(User, other.User))
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
		if (user_ != null)
		{
			num ^= User.GetHashCode();
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
		if (user_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(User);
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
		if (user_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(User);
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
	public void MergeFrom(SaveUserReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.user_ != null)
		{
			if (user_ == null)
			{
				User = new DBUser();
			}
			User.MergeFrom(other.User);
		}
		if (other.DbName.Length != 0)
		{
			DbName = other.DbName;
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
				if (user_ == null)
				{
					User = new DBUser();
				}
				input.ReadMessage(User);
				break;
			case 18u:
				DbName = input.ReadString();
				break;
			}
		}
	}
}
