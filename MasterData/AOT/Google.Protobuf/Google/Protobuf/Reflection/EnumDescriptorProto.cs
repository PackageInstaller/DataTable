using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf.Collections;

namespace Google.Protobuf.Reflection;

public sealed class EnumDescriptorProto : IMessage<EnumDescriptorProto>, IMessage, IEquatable<EnumDescriptorProto>, IDeepCloneable<EnumDescriptorProto>, IBufferMessage
{
	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static class Types
	{
		public sealed class EnumReservedRange : IMessage<EnumReservedRange>, IMessage, IEquatable<EnumReservedRange>, IDeepCloneable<EnumReservedRange>, IBufferMessage
		{
			private static readonly MessageParser<EnumReservedRange> _parser = new MessageParser<EnumReservedRange>(() => new EnumReservedRange());

			private UnknownFieldSet _unknownFields;

			private int _hasBits0;

			private static readonly int StartDefaultValue = 0;

			private int start_;

			private static readonly int EndDefaultValue = 0;

			private int end_;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public static MessageParser<EnumReservedRange> Parser => _parser;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public static MessageDescriptor Descriptor => EnumDescriptorProto.Descriptor.NestedTypes[0];

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public int Start
			{
				get
				{
					if ((_hasBits0 & 1) != 0)
					{
						return start_;
					}
					return StartDefaultValue;
				}
				set
				{
					_hasBits0 |= 1;
					start_ = value;
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public bool HasStart => (_hasBits0 & 1) != 0;

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
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

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public bool HasEnd => (_hasBits0 & 2) != 0;

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public EnumReservedRange()
			{
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public EnumReservedRange(EnumReservedRange other)
				: this()
			{
				_hasBits0 = other._hasBits0;
				start_ = other.start_;
				end_ = other.end_;
				_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
			}

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public EnumReservedRange Clone()
			{
				return new EnumReservedRange(this);
			}

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public override bool Equals(object other)
			{
				return Equals(other as EnumReservedRange);
			}

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public bool Equals(EnumReservedRange other)
			{
				if (other == null)
				{
					return false;
				}
				if (other == this)
				{
					return true;
				}
				if (Start != other.Start)
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
				if (HasStart)
				{
					num ^= Start.GetHashCode();
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
				if (HasStart)
				{
					output.WriteRawTag(8);
					output.WriteInt32(Start);
				}
				if (HasEnd)
				{
					output.WriteRawTag(16);
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
				if (HasStart)
				{
					num += 1 + CodedOutputStream.ComputeInt32Size(Start);
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

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public void MergeFrom(EnumReservedRange other)
			{
				if (other != null)
				{
					if (other.HasStart)
					{
						Start = other.Start;
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
						Start = input.ReadInt32();
						break;
					case 16u:
						End = input.ReadInt32();
						break;
					}
				}
			}
		}
	}

	private static readonly MessageParser<EnumDescriptorProto> _parser = new MessageParser<EnumDescriptorProto>(() => new EnumDescriptorProto());

	private UnknownFieldSet _unknownFields;

	private static readonly string NameDefaultValue = "";

	private string name_;

	private static readonly FieldCodec<EnumValueDescriptorProto> _repeated_value_codec = FieldCodec.ForMessage(18u, EnumValueDescriptorProto.Parser);

	private readonly RepeatedField<EnumValueDescriptorProto> value_ = new RepeatedField<EnumValueDescriptorProto>();

	private EnumOptions options_;

	private static readonly FieldCodec<Types.EnumReservedRange> _repeated_reservedRange_codec = FieldCodec.ForMessage(34u, Types.EnumReservedRange.Parser);

	private readonly RepeatedField<Types.EnumReservedRange> reservedRange_ = new RepeatedField<Types.EnumReservedRange>();

	private static readonly FieldCodec<string> _repeated_reservedName_codec = FieldCodec.ForString(42u);

	private readonly RepeatedField<string> reservedName_ = new RepeatedField<string>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<EnumDescriptorProto> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => DescriptorReflection.Descriptor.MessageTypes[6];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public string Name
	{
		get
		{
			return name_ ?? NameDefaultValue;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasName => name_ != null;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public RepeatedField<EnumValueDescriptorProto> Value => value_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EnumOptions Options
	{
		get
		{
			return options_;
		}
		set
		{
			options_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public EnumDescriptorProto()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EnumDescriptorProto(EnumDescriptorProto other)
		: this()
	{
		name_ = other.name_;
		value_ = other.value_.Clone();
		options_ = ((other.options_ != null) ? other.options_.Clone() : null);
		reservedRange_ = other.reservedRange_.Clone();
		reservedName_ = other.reservedName_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public EnumDescriptorProto Clone()
	{
		return new EnumDescriptorProto(this);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as EnumDescriptorProto);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool Equals(EnumDescriptorProto other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (!value_.Equals(other.value_))
		{
			return false;
		}
		if (!object.Equals(Options, other.Options))
		{
			return false;
		}
		if (!reservedRange_.Equals(other.reservedRange_))
		{
			return false;
		}
		if (!reservedName_.Equals(other.reservedName_))
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
		if (HasName)
		{
			num ^= Name.GetHashCode();
		}
		num ^= value_.GetHashCode();
		if (options_ != null)
		{
			num ^= Options.GetHashCode();
		}
		num ^= reservedRange_.GetHashCode();
		num ^= reservedName_.GetHashCode();
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
		if (HasName)
		{
			output.WriteRawTag(10);
			output.WriteString(Name);
		}
		value_.WriteTo(ref output, _repeated_value_codec);
		if (options_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(Options);
		}
		reservedRange_.WriteTo(ref output, _repeated_reservedRange_codec);
		reservedName_.WriteTo(ref output, _repeated_reservedName_codec);
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
		if (HasName)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		num += value_.CalculateSize(_repeated_value_codec);
		if (options_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Options);
		}
		num += reservedRange_.CalculateSize(_repeated_reservedRange_codec);
		num += reservedName_.CalculateSize(_repeated_reservedName_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public void MergeFrom(EnumDescriptorProto other)
	{
		if (other == null)
		{
			return;
		}
		if (other.HasName)
		{
			Name = other.Name;
		}
		value_.Add(other.value_);
		if (other.options_ != null)
		{
			if (options_ == null)
			{
				Options = new EnumOptions();
			}
			Options.MergeFrom(other.Options);
		}
		reservedRange_.Add(other.reservedRange_);
		reservedName_.Add(other.reservedName_);
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
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
			case 10u:
				Name = input.ReadString();
				break;
			case 18u:
				value_.AddEntriesFrom(ref input, _repeated_value_codec);
				break;
			case 26u:
				if (options_ == null)
				{
					Options = new EnumOptions();
				}
				input.ReadMessage(Options);
				break;
			case 34u:
				reservedRange_.AddEntriesFrom(ref input, _repeated_reservedRange_codec);
				break;
			case 42u:
				reservedName_.AddEntriesFrom(ref input, _repeated_reservedName_codec);
				break;
			}
		}
	}
}
