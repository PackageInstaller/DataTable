using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TipNotice : IMessage<TipNotice>, IMessage, IEquatable<TipNotice>, IDeepCloneable<TipNotice>, IBufferMessage
{
	private static readonly MessageParser<TipNotice> _parser = new MessageParser<TipNotice>(() => new TipNotice());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ContentFieldNumber = 2;

	private string content_ = "";

	public const int BeginTimeFieldNumber = 3;

	private long beginTime_;

	public const int EndTimeFieldNumber = 4;

	private long endTime_;

	public const int ShowNumFieldNumber = 5;

	private int showNum_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TipNotice> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[241];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Content
	{
		get
		{
			return content_;
		}
		set
		{
			content_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long BeginTime
	{
		get
		{
			return beginTime_;
		}
		set
		{
			beginTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long EndTime
	{
		get
		{
			return endTime_;
		}
		set
		{
			endTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ShowNum
	{
		get
		{
			return showNum_;
		}
		set
		{
			showNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TipNotice()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TipNotice(TipNotice other)
		: this()
	{
		id_ = other.id_;
		content_ = other.content_;
		beginTime_ = other.beginTime_;
		endTime_ = other.endTime_;
		showNum_ = other.showNum_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TipNotice Clone()
	{
		return new TipNotice(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TipNotice);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TipNotice other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (Content != other.Content)
		{
			return false;
		}
		if (BeginTime != other.BeginTime)
		{
			return false;
		}
		if (EndTime != other.EndTime)
		{
			return false;
		}
		if (ShowNum != other.ShowNum)
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
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Content.Length != 0)
		{
			num ^= Content.GetHashCode();
		}
		if (BeginTime != 0L)
		{
			num ^= BeginTime.GetHashCode();
		}
		if (EndTime != 0L)
		{
			num ^= EndTime.GetHashCode();
		}
		if (ShowNum != 0)
		{
			num ^= ShowNum.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (Content.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Content);
		}
		if (BeginTime != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(BeginTime);
		}
		if (EndTime != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(EndTime);
		}
		if (ShowNum != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ShowNum);
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (Content.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Content);
		}
		if (BeginTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(BeginTime);
		}
		if (EndTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(EndTime);
		}
		if (ShowNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ShowNum);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TipNotice other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Content.Length != 0)
			{
				Content = other.Content;
			}
			if (other.BeginTime != 0L)
			{
				BeginTime = other.BeginTime;
			}
			if (other.EndTime != 0L)
			{
				EndTime = other.EndTime;
			}
			if (other.ShowNum != 0)
			{
				ShowNum = other.ShowNum;
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
				Id = input.ReadInt32();
				break;
			case 18u:
				Content = input.ReadString();
				break;
			case 24u:
				BeginTime = input.ReadInt64();
				break;
			case 32u:
				EndTime = input.ReadInt64();
				break;
			case 40u:
				ShowNum = input.ReadInt32();
				break;
			}
		}
	}
}
