using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ContentWord : IMessage<ContentWord>, IMessage, IEquatable<ContentWord>, IDeepCloneable<ContentWord>
{
	private static readonly MessageParser<ContentWord> _parser = new MessageParser<ContentWord>(() => new ContentWord());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int PresetColorFieldNumber = 2;

	private string presetColor_ = "";

	public const int WordFieldNumber = 3;

	private string word_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<ContentWord> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(214);

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
	public string PresetColor
	{
		get
		{
			return presetColor_;
		}
		set
		{
			presetColor_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Word
	{
		get
		{
			return word_;
		}
		set
		{
			word_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public ContentWord()
	{
	}

	[DebuggerNonUserCode]
	public ContentWord(ContentWord other)
		: this()
	{
		id_ = other.id_;
		presetColor_ = other.presetColor_;
		word_ = other.word_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ContentWord Clone()
	{
		return new ContentWord(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ContentWord);
	}

	[DebuggerNonUserCode]
	public bool Equals(ContentWord other)
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
		if (PresetColor != other.PresetColor)
		{
			return false;
		}
		if (Word != other.Word)
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
		if (PresetColor.Length != 0)
		{
			num ^= PresetColor.GetHashCode();
		}
		if (Word.Length != 0)
		{
			num ^= Word.GetHashCode();
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
		if (PresetColor.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(PresetColor);
		}
		if (Word.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Word);
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
		if (PresetColor.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PresetColor);
		}
		if (Word.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Word);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ContentWord other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.PresetColor.Length != 0)
			{
				PresetColor = other.PresetColor;
			}
			if (other.Word.Length != 0)
			{
				Word = other.Word;
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
			case 18u:
				PresetColor = input.ReadString();
				break;
			case 26u:
				Word = input.ReadString();
				break;
			}
		}
	}
}
