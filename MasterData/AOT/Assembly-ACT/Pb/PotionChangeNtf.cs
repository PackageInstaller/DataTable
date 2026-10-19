using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class PotionChangeNtf : IMessage<PotionChangeNtf>, IMessage, IEquatable<PotionChangeNtf>, IDeepCloneable<PotionChangeNtf>, IBufferMessage
{
	private static readonly MessageParser<PotionChangeNtf> _parser = new MessageParser<PotionChangeNtf>(() => new PotionChangeNtf());

	private UnknownFieldSet _unknownFields;

	public const int SceneEnumFieldNumber = 1;

	private int sceneEnum_;

	public const int PotionsFieldNumber = 2;

	private static readonly MapField<int, PotionItem>.Codec _map_potions_codec = new MapField<int, PotionItem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, PotionItem.Parser), 18u);

	private readonly MapField<int, PotionItem> potions_ = new MapField<int, PotionItem>();

	public const int RemoveFieldNumber = 3;

	private bool remove_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<PotionChangeNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ItemReflection.Descriptor.MessageTypes[21];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SceneEnum
	{
		get
		{
			return sceneEnum_;
		}
		set
		{
			sceneEnum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, PotionItem> Potions => potions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Remove
	{
		get
		{
			return remove_;
		}
		set
		{
			remove_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PotionChangeNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PotionChangeNtf(PotionChangeNtf other)
		: this()
	{
		sceneEnum_ = other.sceneEnum_;
		potions_ = other.potions_.Clone();
		remove_ = other.remove_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PotionChangeNtf Clone()
	{
		return new PotionChangeNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as PotionChangeNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(PotionChangeNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (SceneEnum != other.SceneEnum)
		{
			return false;
		}
		if (!Potions.Equals(other.Potions))
		{
			return false;
		}
		if (Remove != other.Remove)
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
		if (SceneEnum != 0)
		{
			num ^= SceneEnum.GetHashCode();
		}
		num ^= Potions.GetHashCode();
		if (Remove)
		{
			num ^= Remove.GetHashCode();
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

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (SceneEnum != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(SceneEnum);
		}
		potions_.WriteTo(ref output, _map_potions_codec);
		if (Remove)
		{
			output.WriteRawTag(24);
			output.WriteBool(Remove);
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
		if (SceneEnum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SceneEnum);
		}
		num += potions_.CalculateSize(_map_potions_codec);
		if (Remove)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(PotionChangeNtf other)
	{
		if (other != null)
		{
			if (other.SceneEnum != 0)
			{
				SceneEnum = other.SceneEnum;
			}
			potions_.Add(other.potions_);
			if (other.Remove)
			{
				Remove = other.Remove;
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
				SceneEnum = input.ReadInt32();
				break;
			case 18u:
				potions_.AddEntriesFrom(ref input, _map_potions_codec);
				break;
			case 24u:
				Remove = input.ReadBool();
				break;
			}
		}
	}
}
