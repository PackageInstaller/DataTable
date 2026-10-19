using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TookLevelRewards : IMessage<TookLevelRewards>, IMessage, IEquatable<TookLevelRewards>, IDeepCloneable<TookLevelRewards>, IBufferMessage
{
	private static readonly MessageParser<TookLevelRewards> _parser = new MessageParser<TookLevelRewards>(() => new TookLevelRewards());

	private UnknownFieldSet _unknownFields;

	public const int LevelsFieldNumber = 1;

	private static readonly MapField<int, bool>.Codec _map_levels_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 10u);

	private readonly MapField<int, bool> levels_ = new MapField<int, bool>();

	public const int SystemGuideChapterFieldNumber = 2;

	private static readonly MapField<int, bool>.Codec _map_systemGuideChapter_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 18u);

	private readonly MapField<int, bool> systemGuideChapter_ = new MapField<int, bool>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TookLevelRewards> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[115];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> Levels => levels_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> SystemGuideChapter => systemGuideChapter_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TookLevelRewards()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TookLevelRewards(TookLevelRewards other)
		: this()
	{
		levels_ = other.levels_.Clone();
		systemGuideChapter_ = other.systemGuideChapter_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TookLevelRewards Clone()
	{
		return new TookLevelRewards(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TookLevelRewards);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TookLevelRewards other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Levels.Equals(other.Levels))
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
		num ^= Levels.GetHashCode();
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
		levels_.WriteTo(ref output, _map_levels_codec);
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
		num += levels_.CalculateSize(_map_levels_codec);
		num += systemGuideChapter_.CalculateSize(_map_systemGuideChapter_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TookLevelRewards other)
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
			case 10u:
				levels_.AddEntriesFrom(ref input, _map_levels_codec);
				break;
			case 18u:
				systemGuideChapter_.AddEntriesFrom(ref input, _map_systemGuideChapter_codec);
				break;
			}
		}
	}
}
