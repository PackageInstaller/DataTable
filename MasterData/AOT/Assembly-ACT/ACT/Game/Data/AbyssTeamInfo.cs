using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class AbyssTeamInfo : IMessage<AbyssTeamInfo>, IMessage, IEquatable<AbyssTeamInfo>, IDeepCloneable<AbyssTeamInfo>, IBufferMessage
{
	private static readonly MessageParser<AbyssTeamInfo> _parser = new MessageParser<AbyssTeamInfo>(() => new AbyssTeamInfo());

	private UnknownFieldSet _unknownFields;

	public const int CharacterIdsFieldNumber = 1;

	private static readonly FieldCodec<int> _repeated_characterIds_codec = FieldCodec.ForInt32(10u);

	private readonly RepeatedField<int> characterIds_ = new RepeatedField<int>();

	public const int PotionFieldNumber = 2;

	private PotionItem potion_;

	public const int PotionCurUseCountFieldNumber = 3;

	private int potionCurUseCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AbyssTeamInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[77];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> CharacterIds => characterIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PotionItem Potion
	{
		get
		{
			return potion_;
		}
		set
		{
			potion_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PotionCurUseCount
	{
		get
		{
			return potionCurUseCount_;
		}
		set
		{
			potionCurUseCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssTeamInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssTeamInfo(AbyssTeamInfo other)
		: this()
	{
		characterIds_ = other.characterIds_.Clone();
		potion_ = ((other.potion_ != null) ? other.potion_.Clone() : null);
		potionCurUseCount_ = other.potionCurUseCount_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssTeamInfo Clone()
	{
		return new AbyssTeamInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AbyssTeamInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AbyssTeamInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!characterIds_.Equals(other.characterIds_))
		{
			return false;
		}
		if (!object.Equals(Potion, other.Potion))
		{
			return false;
		}
		if (PotionCurUseCount != other.PotionCurUseCount)
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
		num ^= characterIds_.GetHashCode();
		if (potion_ != null)
		{
			num ^= Potion.GetHashCode();
		}
		if (PotionCurUseCount != 0)
		{
			num ^= PotionCurUseCount.GetHashCode();
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
		characterIds_.WriteTo(ref output, _repeated_characterIds_codec);
		if (potion_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(Potion);
		}
		if (PotionCurUseCount != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(PotionCurUseCount);
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
		num += characterIds_.CalculateSize(_repeated_characterIds_codec);
		if (potion_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Potion);
		}
		if (PotionCurUseCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PotionCurUseCount);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AbyssTeamInfo other)
	{
		if (other == null)
		{
			return;
		}
		characterIds_.Add(other.characterIds_);
		if (other.potion_ != null)
		{
			if (potion_ == null)
			{
				Potion = new PotionItem();
			}
			Potion.MergeFrom(other.Potion);
		}
		if (other.PotionCurUseCount != 0)
		{
			PotionCurUseCount = other.PotionCurUseCount;
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
				characterIds_.AddEntriesFrom(ref input, _repeated_characterIds_codec);
				break;
			case 18u:
				if (potion_ == null)
				{
					Potion = new PotionItem();
				}
				input.ReadMessage(Potion);
				break;
			case 24u:
				PotionCurUseCount = input.ReadInt32();
				break;
			}
		}
	}
}
