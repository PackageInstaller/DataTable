using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class AbyssRechallengeAck : IMessage<AbyssRechallengeAck>, IMessage, IEquatable<AbyssRechallengeAck>, IDeepCloneable<AbyssRechallengeAck>, IBufferMessage
{
	private static readonly MessageParser<AbyssRechallengeAck> _parser = new MessageParser<AbyssRechallengeAck>(() => new AbyssRechallengeAck());

	private UnknownFieldSet _unknownFields;

	public const int TransNoFieldNumber = 1;

	private string transNo_ = "";

	public const int CharacterRepositoryFieldNumber = 2;

	private CharacterRepository characterRepository_;

	public const int AbyssDataFieldNumber = 3;

	private Abyss abyssData_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AbyssRechallengeAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => AbyssReflection.Descriptor.MessageTypes[7];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string TransNo
	{
		get
		{
			return transNo_;
		}
		set
		{
			transNo_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterRepository CharacterRepository
	{
		get
		{
			return characterRepository_;
		}
		set
		{
			characterRepository_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Abyss AbyssData
	{
		get
		{
			return abyssData_;
		}
		set
		{
			abyssData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssRechallengeAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssRechallengeAck(AbyssRechallengeAck other)
		: this()
	{
		transNo_ = other.transNo_;
		characterRepository_ = ((other.characterRepository_ != null) ? other.characterRepository_.Clone() : null);
		abyssData_ = ((other.abyssData_ != null) ? other.abyssData_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssRechallengeAck Clone()
	{
		return new AbyssRechallengeAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AbyssRechallengeAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AbyssRechallengeAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (TransNo != other.TransNo)
		{
			return false;
		}
		if (!object.Equals(CharacterRepository, other.CharacterRepository))
		{
			return false;
		}
		if (!object.Equals(AbyssData, other.AbyssData))
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
		if (TransNo.Length != 0)
		{
			num ^= TransNo.GetHashCode();
		}
		if (characterRepository_ != null)
		{
			num ^= CharacterRepository.GetHashCode();
		}
		if (abyssData_ != null)
		{
			num ^= AbyssData.GetHashCode();
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
		if (TransNo.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(TransNo);
		}
		if (characterRepository_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(CharacterRepository);
		}
		if (abyssData_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(AbyssData);
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
		if (TransNo.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TransNo);
		}
		if (characterRepository_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(CharacterRepository);
		}
		if (abyssData_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(AbyssData);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AbyssRechallengeAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.TransNo.Length != 0)
		{
			TransNo = other.TransNo;
		}
		if (other.characterRepository_ != null)
		{
			if (characterRepository_ == null)
			{
				CharacterRepository = new CharacterRepository();
			}
			CharacterRepository.MergeFrom(other.CharacterRepository);
		}
		if (other.abyssData_ != null)
		{
			if (abyssData_ == null)
			{
				AbyssData = new Abyss();
			}
			AbyssData.MergeFrom(other.AbyssData);
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
			case 10u:
				TransNo = input.ReadString();
				break;
			case 18u:
				if (characterRepository_ == null)
				{
					CharacterRepository = new CharacterRepository();
				}
				input.ReadMessage(CharacterRepository);
				break;
			case 26u:
				if (abyssData_ == null)
				{
					AbyssData = new Abyss();
				}
				input.ReadMessage(AbyssData);
				break;
			}
		}
	}
}
