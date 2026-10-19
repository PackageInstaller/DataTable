using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class CharacterEliteInfo : IMessage<CharacterEliteInfo>, IMessage, IEquatable<CharacterEliteInfo>, IDeepCloneable<CharacterEliteInfo>, IBufferMessage
{
	private static readonly MessageParser<CharacterEliteInfo> _parser = new MessageParser<CharacterEliteInfo>(() => new CharacterEliteInfo());

	private UnknownFieldSet _unknownFields;

	public const int PointFieldNumber = 1;

	private int point_;

	public const int LevelsFieldNumber = 2;

	private static readonly MapField<int, int>.Codec _map_levels_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 18u);

	private readonly MapField<int, int> levels_ = new MapField<int, int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CharacterEliteInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[46];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Point
	{
		get
		{
			return point_;
		}
		set
		{
			point_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> Levels => levels_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterEliteInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterEliteInfo(CharacterEliteInfo other)
		: this()
	{
		point_ = other.point_;
		levels_ = other.levels_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterEliteInfo Clone()
	{
		return new CharacterEliteInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterEliteInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CharacterEliteInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Point != other.Point)
		{
			return false;
		}
		if (!Levels.Equals(other.Levels))
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
		if (Point != 0)
		{
			num ^= Point.GetHashCode();
		}
		num ^= Levels.GetHashCode();
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
		if (Point != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Point);
		}
		levels_.WriteTo(ref output, _map_levels_codec);
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
		if (Point != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Point);
		}
		num += levels_.CalculateSize(_map_levels_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CharacterEliteInfo other)
	{
		if (other != null)
		{
			if (other.Point != 0)
			{
				Point = other.Point;
			}
			levels_.Add(other.levels_);
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
				Point = input.ReadInt32();
				break;
			case 18u:
				levels_.AddEntriesFrom(ref input, _map_levels_codec);
				break;
			}
		}
	}
}
