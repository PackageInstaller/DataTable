using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class DemandDataReq : IMessage<DemandDataReq>, IMessage, IEquatable<DemandDataReq>, IDeepCloneable<DemandDataReq>, IBufferMessage
{
	private static readonly MessageParser<DemandDataReq> _parser = new MessageParser<DemandDataReq>(() => new DemandDataReq());

	private UnknownFieldSet _unknownFields;

	public const int IndexsFieldNumber = 1;

	private static readonly FieldCodec<string> _repeated_indexs_codec = FieldCodec.ForString(10u);

	private readonly RepeatedField<string> indexs_ = new RepeatedField<string>();

	public const int TableNameFieldNumber = 2;

	private string tableName_ = "";

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<DemandDataReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<string> Indexs => indexs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string TableName
	{
		get
		{
			return tableName_;
		}
		set
		{
			tableName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DemandDataReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DemandDataReq(DemandDataReq other)
		: this()
	{
		indexs_ = other.indexs_.Clone();
		tableName_ = other.tableName_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DemandDataReq Clone()
	{
		return new DemandDataReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as DemandDataReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(DemandDataReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!indexs_.Equals(other.indexs_))
		{
			return false;
		}
		if (TableName != other.TableName)
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
		num ^= indexs_.GetHashCode();
		if (TableName.Length != 0)
		{
			num ^= TableName.GetHashCode();
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
		indexs_.WriteTo(ref output, _repeated_indexs_codec);
		if (TableName.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(TableName);
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
		num += indexs_.CalculateSize(_repeated_indexs_codec);
		if (TableName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TableName);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(DemandDataReq other)
	{
		if (other != null)
		{
			indexs_.Add(other.indexs_);
			if (other.TableName.Length != 0)
			{
				TableName = other.TableName;
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
				indexs_.AddEntriesFrom(ref input, _repeated_indexs_codec);
				break;
			case 18u:
				TableName = input.ReadString();
				break;
			}
		}
	}
}
