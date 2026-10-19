using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf.Collections;

namespace Google.Protobuf.Reflection;

public sealed class SourceCodeInfo : IMessage<SourceCodeInfo>, IMessage, IEquatable<SourceCodeInfo>, IDeepCloneable<SourceCodeInfo>, IBufferMessage
{
	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static class Types
	{
		public sealed class Location : IMessage<Location>, IMessage, IEquatable<Location>, IDeepCloneable<Location>, IBufferMessage
		{
			private static readonly MessageParser<Location> _parser = new MessageParser<Location>(() => new Location());

			private UnknownFieldSet _unknownFields;

			private static readonly FieldCodec<int> _repeated_path_codec = FieldCodec.ForInt32(10u);

			private readonly RepeatedField<int> path_ = new RepeatedField<int>();

			private static readonly FieldCodec<int> _repeated_span_codec = FieldCodec.ForInt32(18u);

			private readonly RepeatedField<int> span_ = new RepeatedField<int>();

			private static readonly string LeadingCommentsDefaultValue = "";

			private string leadingComments_;

			private static readonly string TrailingCommentsDefaultValue = "";

			private string trailingComments_;

			private static readonly FieldCodec<string> _repeated_leadingDetachedComments_codec = FieldCodec.ForString(50u);

			private readonly RepeatedField<string> leadingDetachedComments_ = new RepeatedField<string>();

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public static MessageParser<Location> Parser => _parser;

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public static MessageDescriptor Descriptor => SourceCodeInfo.Descriptor.NestedTypes[0];

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public RepeatedField<int> Path => path_;

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public RepeatedField<int> Span => span_;

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public string LeadingComments
			{
				get
				{
					return leadingComments_ ?? LeadingCommentsDefaultValue;
				}
				set
				{
					leadingComments_ = ProtoPreconditions.CheckNotNull(value, "value");
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public bool HasLeadingComments => leadingComments_ != null;

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public string TrailingComments
			{
				get
				{
					return trailingComments_ ?? TrailingCommentsDefaultValue;
				}
				set
				{
					trailingComments_ = ProtoPreconditions.CheckNotNull(value, "value");
				}
			}

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public bool HasTrailingComments => trailingComments_ != null;

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public RepeatedField<string> LeadingDetachedComments => leadingDetachedComments_;

			[GeneratedCode("protoc", null)]
			[DebuggerNonUserCode]
			public Location()
			{
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public Location(Location other)
				: this()
			{
				path_ = other.path_.Clone();
				span_ = other.span_.Clone();
				leadingComments_ = other.leadingComments_;
				trailingComments_ = other.trailingComments_;
				leadingDetachedComments_ = other.leadingDetachedComments_.Clone();
				_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public Location Clone()
			{
				return new Location(this);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public override bool Equals(object other)
			{
				return Equals(other as Location);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public bool Equals(Location other)
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
				if (!span_.Equals(other.span_))
				{
					return false;
				}
				if (LeadingComments != other.LeadingComments)
				{
					return false;
				}
				if (TrailingComments != other.TrailingComments)
				{
					return false;
				}
				if (!leadingDetachedComments_.Equals(other.leadingDetachedComments_))
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
				num ^= span_.GetHashCode();
				if (HasLeadingComments)
				{
					num ^= LeadingComments.GetHashCode();
				}
				if (HasTrailingComments)
				{
					num ^= TrailingComments.GetHashCode();
				}
				num ^= leadingDetachedComments_.GetHashCode();
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

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			void IBufferMessage.InternalWriteTo(ref WriteContext output)
			{
				path_.WriteTo(ref output, _repeated_path_codec);
				span_.WriteTo(ref output, _repeated_span_codec);
				if (HasLeadingComments)
				{
					output.WriteRawTag(26);
					output.WriteString(LeadingComments);
				}
				if (HasTrailingComments)
				{
					output.WriteRawTag(34);
					output.WriteString(TrailingComments);
				}
				leadingDetachedComments_.WriteTo(ref output, _repeated_leadingDetachedComments_codec);
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
				num += span_.CalculateSize(_repeated_span_codec);
				if (HasLeadingComments)
				{
					num += 1 + CodedOutputStream.ComputeStringSize(LeadingComments);
				}
				if (HasTrailingComments)
				{
					num += 1 + CodedOutputStream.ComputeStringSize(TrailingComments);
				}
				num += leadingDetachedComments_.CalculateSize(_repeated_leadingDetachedComments_codec);
				if (_unknownFields != null)
				{
					num += _unknownFields.CalculateSize();
				}
				return num;
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public void MergeFrom(Location other)
			{
				if (other != null)
				{
					path_.Add(other.path_);
					span_.Add(other.span_);
					if (other.HasLeadingComments)
					{
						LeadingComments = other.LeadingComments;
					}
					if (other.HasTrailingComments)
					{
						TrailingComments = other.TrailingComments;
					}
					leadingDetachedComments_.Add(other.leadingDetachedComments_);
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
					case 10u:
						path_.AddEntriesFrom(ref input, _repeated_path_codec);
						break;
					case 16u:
					case 18u:
						span_.AddEntriesFrom(ref input, _repeated_span_codec);
						break;
					case 26u:
						LeadingComments = input.ReadString();
						break;
					case 34u:
						TrailingComments = input.ReadString();
						break;
					case 50u:
						leadingDetachedComments_.AddEntriesFrom(ref input, _repeated_leadingDetachedComments_codec);
						break;
					}
				}
			}
		}
	}

	private static readonly MessageParser<SourceCodeInfo> _parser = new MessageParser<SourceCodeInfo>(() => new SourceCodeInfo());

	private UnknownFieldSet _unknownFields;

	private static readonly FieldCodec<Types.Location> _repeated_location_codec = FieldCodec.ForMessage(10u, Types.Location.Parser);

	private readonly RepeatedField<Types.Location> location_ = new RepeatedField<Types.Location>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SourceCodeInfo> Parser => _parser;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => DescriptorReflection.Descriptor.MessageTypes[19];

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public RepeatedField<Types.Location> Location => location_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SourceCodeInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SourceCodeInfo(SourceCodeInfo other)
		: this()
	{
		location_ = other.location_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SourceCodeInfo Clone()
	{
		return new SourceCodeInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SourceCodeInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SourceCodeInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!location_.Equals(other.location_))
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
		num ^= location_.GetHashCode();
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

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		location_.WriteTo(ref output, _repeated_location_codec);
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
		num += location_.CalculateSize(_repeated_location_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public void MergeFrom(SourceCodeInfo other)
	{
		if (other != null)
		{
			location_.Add(other.location_);
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
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
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
			}
			else
			{
				location_.AddEntriesFrom(ref input, _repeated_location_codec);
			}
		}
	}
}
