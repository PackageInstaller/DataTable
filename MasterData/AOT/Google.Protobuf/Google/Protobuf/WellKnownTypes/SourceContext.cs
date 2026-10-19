using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf.Reflection;

namespace Google.Protobuf.WellKnownTypes;

public sealed class SourceContext : IMessage<SourceContext>, IMessage, IEquatable<SourceContext>, IDeepCloneable<SourceContext>, IBufferMessage
{
	private static readonly MessageParser<SourceContext> _parser = new MessageParser<SourceContext>(() => new SourceContext());

	private UnknownFieldSet _unknownFields;

	private string fileName_ = "";

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageParser<SourceContext> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => SourceContextReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string FileName
	{
		get
		{
			return fileName_;
		}
		set
		{
			fileName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SourceContext()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SourceContext(SourceContext other)
		: this()
	{
		fileName_ = other.fileName_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SourceContext Clone()
	{
		return new SourceContext(this);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SourceContext);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SourceContext other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (FileName != other.FileName)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (FileName.Length != 0)
		{
			num ^= FileName.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
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

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (FileName.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(FileName);
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
		if (FileName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FileName);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SourceContext other)
	{
		if (other != null)
		{
			if (other.FileName.Length != 0)
			{
				FileName = other.FileName;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
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
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
			}
			else
			{
				FileName = input.ReadString();
			}
		}
	}
}
