using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DatingCharResponse : IMessage<DatingCharResponse>, IMessage, IEquatable<DatingCharResponse>, IDeepCloneable<DatingCharResponse>
{
	private static readonly MessageParser<DatingCharResponse> _parser = new MessageParser<DatingCharResponse>(() => new DatingCharResponse());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CharIdFieldNumber = 2;

	private int charId_;

	public const int TypeFieldNumber = 3;

	private string type_ = "";

	public const int VoiceKeyFieldNumber = 4;

	private string voiceKey_ = "";

	public const int ActionFieldNumber = 5;

	private string action_ = "";

	public const int WordsFieldNumber = 6;

	private string words_ = "";

	public const int BubbleEmojiFieldNumber = 7;

	private string bubbleEmoji_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<DatingCharResponse> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(246);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CharId
	{
		get
		{
			return charId_;
		}
		set
		{
			charId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string VoiceKey
	{
		get
		{
			return voiceKey_;
		}
		set
		{
			voiceKey_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Action
	{
		get
		{
			return action_;
		}
		set
		{
			action_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Words
	{
		get
		{
			return words_;
		}
		set
		{
			words_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BubbleEmoji
	{
		get
		{
			return bubbleEmoji_;
		}
		set
		{
			bubbleEmoji_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public DatingCharResponse()
	{
	}

	[DebuggerNonUserCode]
	public DatingCharResponse(DatingCharResponse other)
		: this()
	{
		id_ = other.id_;
		charId_ = other.charId_;
		type_ = other.type_;
		voiceKey_ = other.voiceKey_;
		action_ = other.action_;
		words_ = other.words_;
		bubbleEmoji_ = other.bubbleEmoji_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DatingCharResponse Clone()
	{
		return new DatingCharResponse(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DatingCharResponse);
	}

	[DebuggerNonUserCode]
	public bool Equals(DatingCharResponse other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (CharId != other.CharId)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (VoiceKey != other.VoiceKey)
		{
			return false;
		}
		if (Action != other.Action)
		{
			return false;
		}
		if (Words != other.Words)
		{
			return false;
		}
		if (BubbleEmoji != other.BubbleEmoji)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (CharId != 0)
		{
			num ^= CharId.GetHashCode();
		}
		if (Type.Length != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (VoiceKey.Length != 0)
		{
			num ^= VoiceKey.GetHashCode();
		}
		if (Action.Length != 0)
		{
			num ^= Action.GetHashCode();
		}
		if (Words.Length != 0)
		{
			num ^= Words.GetHashCode();
		}
		if (BubbleEmoji.Length != 0)
		{
			num ^= BubbleEmoji.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (CharId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CharId);
		}
		if (Type.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Type);
		}
		if (VoiceKey.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(VoiceKey);
		}
		if (Action.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Action);
		}
		if (Words.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Words);
		}
		if (BubbleEmoji.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(BubbleEmoji);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (CharId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharId);
		}
		if (Type.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Type);
		}
		if (VoiceKey.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(VoiceKey);
		}
		if (Action.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Action);
		}
		if (Words.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Words);
		}
		if (BubbleEmoji.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BubbleEmoji);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DatingCharResponse other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.CharId != 0)
			{
				CharId = other.CharId;
			}
			if (other.Type.Length != 0)
			{
				Type = other.Type;
			}
			if (other.VoiceKey.Length != 0)
			{
				VoiceKey = other.VoiceKey;
			}
			if (other.Action.Length != 0)
			{
				Action = other.Action;
			}
			if (other.Words.Length != 0)
			{
				Words = other.Words;
			}
			if (other.BubbleEmoji.Length != 0)
			{
				BubbleEmoji = other.BubbleEmoji;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				CharId = input.ReadInt32();
				break;
			case 26u:
				Type = input.ReadString();
				break;
			case 34u:
				VoiceKey = input.ReadString();
				break;
			case 42u:
				Action = input.ReadString();
				break;
			case 50u:
				Words = input.ReadString();
				break;
			case 58u:
				BubbleEmoji = input.ReadString();
				break;
			}
		}
	}
}
