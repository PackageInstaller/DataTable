using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class SystemTakeLevelRewardNtf : IMessage<SystemTakeLevelRewardNtf>, IMessage, IEquatable<SystemTakeLevelRewardNtf>, IDeepCloneable<SystemTakeLevelRewardNtf>, IBufferMessage
{
	private static readonly MessageParser<SystemTakeLevelRewardNtf> _parser = new MessageParser<SystemTakeLevelRewardNtf>(() => new SystemTakeLevelRewardNtf());

	private UnknownFieldSet _unknownFields;

	public const int LevelsFieldNumber = 1;

	private static readonly FieldCodec<int> _repeated_levels_codec = FieldCodec.ForInt32(10u);

	private readonly RepeatedField<int> levels_ = new RepeatedField<int>();

	public const int SystemGuideChapterFieldNumber = 2;

	private static readonly MapField<int, bool>.Codec _map_systemGuideChapter_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 18u);

	private readonly MapField<int, bool> systemGuideChapter_ = new MapField<int, bool>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SystemTakeLevelRewardNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => SystemReflection.Descriptor.MessageTypes[9];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> Levels => levels_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> SystemGuideChapter => systemGuideChapter_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SystemTakeLevelRewardNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SystemTakeLevelRewardNtf(SystemTakeLevelRewardNtf other)
		: this()
	{
		levels_ = other.levels_.Clone();
		systemGuideChapter_ = other.systemGuideChapter_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SystemTakeLevelRewardNtf Clone()
	{
		return new SystemTakeLevelRewardNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SystemTakeLevelRewardNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SystemTakeLevelRewardNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!levels_.Equals(other.levels_))
		{
			return false;
		}
		if (!SystemGuideChapter.Equals(other.SystemGuideChapter))
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
		num ^= levels_.GetHashCode();
		num ^= SystemGuideChapter.GetHashCode();
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
		levels_.WriteTo(ref output, _repeated_levels_codec);
		systemGuideChapter_.WriteTo(ref output, _map_systemGuideChapter_codec);
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
		num += levels_.CalculateSize(_repeated_levels_codec);
		num += systemGuideChapter_.CalculateSize(_map_systemGuideChapter_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SystemTakeLevelRewardNtf other)
	{
		if (other != null)
		{
			levels_.Add(other.levels_);
			systemGuideChapter_.Add(other.systemGuideChapter_);
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
				levels_.AddEntriesFrom(ref input, _repeated_levels_codec);
				break;
			case 18u:
				systemGuideChapter_.AddEntriesFrom(ref input, _map_systemGuideChapter_codec);
				break;
			}
		}
	}
}
