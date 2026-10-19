using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TextLibraryContent : IMessage<TextLibraryContent>, IMessage, IEquatable<TextLibraryContent>, IDeepCloneable<TextLibraryContent>, IBufferMessage
{
	private static readonly MessageParser<TextLibraryContent> _parser = new MessageParser<TextLibraryContent>(() => new TextLibraryContent());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int IsReadFieldNumber = 2;

	private bool isRead_;

	public const int UnlockTimeFieldNumber = 3;

	private long unlockTime_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TextLibraryContent> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[293];

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
	public bool IsRead
	{
		get
		{
			return isRead_;
		}
		set
		{
			isRead_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long UnlockTime
	{
		get
		{
			return unlockTime_;
		}
		set
		{
			unlockTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TextLibraryContent()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TextLibraryContent(TextLibraryContent other)
		: this()
	{
		id_ = other.id_;
		isRead_ = other.isRead_;
		unlockTime_ = other.unlockTime_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TextLibraryContent Clone()
	{
		return new TextLibraryContent(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TextLibraryContent);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TextLibraryContent other)
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
		if (IsRead != other.IsRead)
		{
			return false;
		}
		if (UnlockTime != other.UnlockTime)
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
		if (IsRead)
		{
			num ^= IsRead.GetHashCode();
		}
		if (UnlockTime != 0L)
		{
			num ^= UnlockTime.GetHashCode();
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
		if (IsRead)
		{
			output.WriteRawTag(16);
			output.WriteBool(IsRead);
		}
		if (UnlockTime != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(UnlockTime);
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
		if (IsRead)
		{
			num += 2;
		}
		if (UnlockTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(UnlockTime);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TextLibraryContent other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.IsRead)
			{
				IsRead = other.IsRead;
			}
			if (other.UnlockTime != 0L)
			{
				UnlockTime = other.UnlockTime;
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
			case 16u:
				IsRead = input.ReadBool();
				break;
			case 24u:
				UnlockTime = input.ReadInt64();
				break;
			}
		}
	}
}
