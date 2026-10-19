using System;
using System.CodeDom.Compiler;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Google.Protobuf.WellKnownTypes;

public sealed class FieldMask : IMessage<FieldMask>, IMessage, IEquatable<FieldMask>, IDeepCloneable<FieldMask>, IBufferMessage, ICustomDiagnosticMessage
{
	private static readonly MessageParser<FieldMask> _parser = new MessageParser<FieldMask>(() => new FieldMask());

	private UnknownFieldSet _unknownFields;

	private static readonly FieldCodec<string> _repeated_paths_codec = FieldCodec.ForString(10u);

	private readonly RepeatedField<string> paths_ = new RepeatedField<string>();

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageParser<FieldMask> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => FieldMaskReflection.Descriptor.MessageTypes[0];

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<string> Paths => paths_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FieldMask()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FieldMask(FieldMask other)
		: this()
	{
		paths_ = other.paths_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FieldMask Clone()
	{
		return new FieldMask(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as FieldMask);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(FieldMask other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!paths_.Equals(other.paths_))
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
		num ^= paths_.GetHashCode();
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

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		paths_.WriteTo(ref output, _repeated_paths_codec);
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
		num += paths_.CalculateSize(_repeated_paths_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(FieldMask other)
	{
		if (other != null)
		{
			paths_.Add(other.paths_);
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
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
			}
			else
			{
				paths_.AddEntriesFrom(ref input, _repeated_paths_codec);
			}
		}
	}

	internal static string ToJson(IList<string> paths, bool diagnosticOnly)
	{
		string text = paths.FirstOrDefault((string p) => !IsPathValid(p));
		if (text == null)
		{
			StringWriter stringWriter = new StringWriter();
			JsonFormatter.WriteString(stringWriter, string.Join(",", paths.Select(JsonFormatter.ToJsonName)));
			return stringWriter.ToString();
		}
		if (diagnosticOnly)
		{
			StringWriter stringWriter2 = new StringWriter();
			stringWriter2.Write("{ \"@warning\": \"Invalid FieldMask\", \"paths\": ");
			JsonFormatter.Default.WriteList(stringWriter2, (IList)paths);
			stringWriter2.Write(" }");
			return stringWriter2.ToString();
		}
		throw new InvalidOperationException("Invalid field mask to be converted to JSON: " + text);
	}

	public string ToDiagnosticString()
	{
		return ToJson(Paths, diagnosticOnly: true);
	}

	private static bool IsPathValid(string input)
	{
		for (int i = 0; i < input.Length; i++)
		{
			char c = input[i];
			if (c >= 'A' && c <= 'Z')
			{
				return false;
			}
			if (c == '_' && i < input.Length - 1)
			{
				char c2 = input[i + 1];
				if (c2 < 'a' || c2 > 'z')
				{
					return false;
				}
			}
		}
		return true;
	}
}
