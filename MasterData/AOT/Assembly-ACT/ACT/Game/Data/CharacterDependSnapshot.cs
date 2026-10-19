using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class CharacterDependSnapshot : IMessage<CharacterDependSnapshot>, IMessage, IEquatable<CharacterDependSnapshot>, IDeepCloneable<CharacterDependSnapshot>, IBufferMessage
{
	private static readonly MessageParser<CharacterDependSnapshot> _parser = new MessageParser<CharacterDependSnapshot>(() => new CharacterDependSnapshot());

	private UnknownFieldSet _unknownFields;

	public const int EquipSnapshotFieldNumber = 1;

	private static readonly MapField<int, Equip>.Codec _map_equipSnapshot_codec = new MapField<int, Equip>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Equip.Parser), 10u);

	private readonly MapField<int, Equip> equipSnapshot_ = new MapField<int, Equip>();

	public const int GemSnapshotFieldNumber = 2;

	private static readonly MapField<int, Gem>.Codec _map_gemSnapshot_codec = new MapField<int, Gem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Gem.Parser), 18u);

	private readonly MapField<int, Gem> gemSnapshot_ = new MapField<int, Gem>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CharacterDependSnapshot> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[70];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Equip> EquipSnapshot => equipSnapshot_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Gem> GemSnapshot => gemSnapshot_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterDependSnapshot()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterDependSnapshot(CharacterDependSnapshot other)
		: this()
	{
		equipSnapshot_ = other.equipSnapshot_.Clone();
		gemSnapshot_ = other.gemSnapshot_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterDependSnapshot Clone()
	{
		return new CharacterDependSnapshot(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterDependSnapshot);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CharacterDependSnapshot other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!EquipSnapshot.Equals(other.EquipSnapshot))
		{
			return false;
		}
		if (!GemSnapshot.Equals(other.GemSnapshot))
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
		num ^= EquipSnapshot.GetHashCode();
		num ^= GemSnapshot.GetHashCode();
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
		equipSnapshot_.WriteTo(ref output, _map_equipSnapshot_codec);
		gemSnapshot_.WriteTo(ref output, _map_gemSnapshot_codec);
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
		num += equipSnapshot_.CalculateSize(_map_equipSnapshot_codec);
		num += gemSnapshot_.CalculateSize(_map_gemSnapshot_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CharacterDependSnapshot other)
	{
		if (other != null)
		{
			equipSnapshot_.Add(other.equipSnapshot_);
			gemSnapshot_.Add(other.gemSnapshot_);
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
				equipSnapshot_.AddEntriesFrom(ref input, _map_equipSnapshot_codec);
				break;
			case 18u:
				gemSnapshot_.AddEntriesFrom(ref input, _map_gemSnapshot_codec);
				break;
			}
		}
	}
}
