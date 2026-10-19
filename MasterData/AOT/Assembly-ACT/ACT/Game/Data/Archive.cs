using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Archive : IMessage<Archive>, IMessage, IEquatable<Archive>, IDeepCloneable<Archive>, IBufferMessage
{
	private static readonly MessageParser<Archive> _parser = new MessageParser<Archive>(() => new Archive());

	private UnknownFieldSet _unknownFields;

	public const int ItemsFieldNumber = 1;

	private static readonly MapField<int, ArchiveItem>.Codec _map_items_codec = new MapField<int, ArchiveItem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ArchiveItem.Parser), 10u);

	private readonly MapField<int, ArchiveItem> items_ = new MapField<int, ArchiveItem>();

	public const int CharactersFieldNumber = 2;

	private static readonly MapField<int, ArchiveItem>.Codec _map_characters_codec = new MapField<int, ArchiveItem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ArchiveItem.Parser), 18u);

	private readonly MapField<int, ArchiveItem> characters_ = new MapField<int, ArchiveItem>();

	public const int MonstersFieldNumber = 3;

	private static readonly MapField<int, ArchiveItem>.Codec _map_monsters_codec = new MapField<int, ArchiveItem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ArchiveItem.Parser), 26u);

	private readonly MapField<int, ArchiveItem> monsters_ = new MapField<int, ArchiveItem>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Archive> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[131];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ArchiveItem> Items => items_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ArchiveItem> Characters => characters_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ArchiveItem> Monsters => monsters_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Archive()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Archive(Archive other)
		: this()
	{
		items_ = other.items_.Clone();
		characters_ = other.characters_.Clone();
		monsters_ = other.monsters_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Archive Clone()
	{
		return new Archive(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Archive);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Archive other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Items.Equals(other.Items))
		{
			return false;
		}
		if (!Characters.Equals(other.Characters))
		{
			return false;
		}
		if (!Monsters.Equals(other.Monsters))
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
		num ^= Items.GetHashCode();
		num ^= Characters.GetHashCode();
		num ^= Monsters.GetHashCode();
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
		items_.WriteTo(ref output, _map_items_codec);
		characters_.WriteTo(ref output, _map_characters_codec);
		monsters_.WriteTo(ref output, _map_monsters_codec);
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
		num += items_.CalculateSize(_map_items_codec);
		num += characters_.CalculateSize(_map_characters_codec);
		num += monsters_.CalculateSize(_map_monsters_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Archive other)
	{
		if (other != null)
		{
			items_.Add(other.items_);
			characters_.Add(other.characters_);
			monsters_.Add(other.monsters_);
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
				items_.AddEntriesFrom(ref input, _map_items_codec);
				break;
			case 18u:
				characters_.AddEntriesFrom(ref input, _map_characters_codec);
				break;
			case 26u:
				monsters_.AddEntriesFrom(ref input, _map_monsters_codec);
				break;
			}
		}
	}
}
