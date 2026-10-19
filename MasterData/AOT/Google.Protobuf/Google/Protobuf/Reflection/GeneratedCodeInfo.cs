using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf.Collections;

namespace Google.Protobuf.Reflection;

public sealed class GeneratedCodeInfo : IMessage<GeneratedCodeInfo>, IMessage, IEquatable<GeneratedCodeInfo>, IDeepCloneable<GeneratedCodeInfo>, IBufferMessage
{
	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static class Types
	{
		public sealed class Annotation : IMessage<Annotation>, IMessage, IEquatable<Annotation>, IDeepCloneable<Annotation>, IBufferMessage
		{
			private static readonly MessageParser<Annotation> _parser = new MessageParser<Annotation>(() => new Annotation());

			private UnknownFieldSet _unknownFields;

			private int _hasBits0;

			private static readonly FieldCodec<int> _repeated_path_codec = FieldCodec.ForInt32(10u);

			private readonly RepeatedField<int> path_ = new RepeatedField<int>();

			private static readonly string SourceFileDefaultValue = "";

			private string sourceFile_;

			private static readonly int BeginDefaultValue = 0;

			private int begin_;

			private static readonly int EndDefaultValue = 0;

			private int end_;

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public static MessageParser<Annotation> Parser => _parser;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public static MessageDescriptor Descriptor => GeneratedCodeInfo.Descriptor.NestedTypes[0];

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public string SourceFile
			{
				get
				{
					return sourceFile_ ?? SourceFileDefaultValue;
				}
				set
				{
					sourceFile_ = ProtoPreconditions.CheckNotNull(value, "value");
				}
			}

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public bool HasSourceFile => sourceFile_ != null;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public int Begin
			{
				get
				{
					if ((_hasBits0 & 1) != 0)
					{
						return begin_;
					}
					return BeginDefaultValue;
				}
				set
				{
					_hasBits0 |= 1;
					begin_ = value;
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public bool HasBegin => (_hasBits0 & 1) != 0;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public int End
			{
				get
				{
					if ((_hasBits0 & 2) != 0)
					{
						return end_;
					}
					return EndDefaultValue;
				}
				set
				{
					_hasBits0 |= 2;
					end_ = value;
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public bool HasEnd => (_hasBits0 & 2) != 0;

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public Annotation()
			{
			}

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public Annotation(Annotation other)
				: this()
			{
				_hasBits0 = other._hasBits0;
				path_ = other.path_.Clone();
				sourceFile_ = other.sourceFile_;
				begin_ = other.begin_;
				end_ = other.end_;
				_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
			}

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public Annotation Clone()
			{
				return new Annotation(this);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public override bool Equals(object other)
			{
				return Equals(other as Annotation);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public bool Equals(Annotation other)
			{
				if (other == null)
				{
					return false;
				}
				if (other == this)
				{
					return true;
				}
				if (!path_.Equals(other.path_))
				{
					return false;
				}
				if (SourceFile != other.SourceFile)
				{
					return false;
				}
				if (Begin != other.Begin)
				{
					return false;
				}
				if (End != other.End)
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
				num ^= path_.GetHashCode();
				if (HasSourceFile)
				{
					num ^= SourceFile.GetHashCode();
				}
				if (HasBegin)
				{
					num ^= Begin.GetHashCode();
				}
				if (HasEnd)
				{
					num ^= End.GetHashCode();
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

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			void IBufferMessage.InternalWriteTo(ref WriteContext output)
			{
				path_.WriteTo(ref output, _repeated_path_codec);
				if (HasSourceFile)
				{
					output.WriteRawTag(18);
					output.WriteString(SourceFile);
				}
				if (HasBegin)
				{
					output.WriteRawTag(24);
					output.WriteInt32(Begin);
				}
				if (HasEnd)
				{
					output.WriteRawTag(32);
					output.WriteInt32(End);
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
				num += path_.CalculateSize(_repeated_path_codec);
				if (HasSourceFile)
				{
					num += 1 + CodedOutputStream.ComputeStringSize(SourceFile);
				}
				if (HasBegin)
				{
					num += 1 + CodedOutputStream.ComputeInt32Size(Begin);
				}
				if (HasEnd)
				{
					num += 1 + CodedOutputStream.ComputeInt32Size(End);
				}
				if (_unknownFields != null)
				{
					num += _unknownFields.CalculateSize();
				}
				return num;
			}

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public void MergeFrom(Annotation other)
			{
				if (other != null)
				{
					path_.Add(other.path_);
					if (other.HasSourceFile)
					{
						SourceFile = other.SourceFile;
					}
					if (other.HasBegin)
					{
						Begin = other.Begin;
					}
					if (other.HasEnd)
					{
						End = other.End;
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

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
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
					case 10u:
						path_.AddEntriesFrom(ref input, _repeated_path_codec);
						break;
					case 18u:
						SourceFile = input.ReadString();
						break;
					case 24u:
						Begin = input.ReadInt32();
						break;
					case 32u:
						End = input.ReadInt32();
						break;
					}
				}
			}
		}
	}

	private static readonly MessageParser<GeneratedCodeInfo> _parser = new MessageParser<GeneratedCodeInfo>(() => new GeneratedCodeInfo());

	private UnknownFieldSet _unknownFields;

	private static readonly FieldCodec<Types.Annotation> _repeated_annotation_codec = FieldCodec.ForMessage(10u, Types.Annotation.Parser);

	private readonly RepeatedField<Types.Annotation> annotation_ = new RepeatedField<Types.Annotation>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GeneratedCodeInfo> Parser => _parser;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => DescriptorReflection.Descriptor.MessageTypes[20];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public GeneratedCodeInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GeneratedCodeInfo(GeneratedCodeInfo other)
		: this()
	{
		annotation_ = other.annotation_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public GeneratedCodeInfo Clone()
	{
		return new GeneratedCodeInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GeneratedCodeInfo);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool Equals(GeneratedCodeInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!annotation_.Equals(other.annotation_))
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
		num ^= annotation_.GetHashCode();
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
		annotation_.WriteTo(ref output, _repeated_annotation_codec);
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		num += annotation_.CalculateSize(_repeated_annotation_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public void MergeFrom(GeneratedCodeInfo other)
	{
		if (other != null)
		{
			annotation_.Add(other.annotation_);
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
				annotation_.AddEntriesFrom(ref input, _repeated_annotation_codec);
			}
		}
	}
}
