using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharacterArchiveContent : IMessage<CharacterArchiveContent>, IMessage, IEquatable<CharacterArchiveContent>, IDeepCloneable<CharacterArchiveContent>
{
	private static readonly MessageParser<CharacterArchiveContent> _parser = new MessageParser<CharacterArchiveContent>(() => new CharacterArchiveContent());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int ContentFieldNumber = 3;

	private string content_ = "";

	public const int UpdateContent1FieldNumber = 4;

	private string updateContent1_ = "";

	public const int UpdateAff1FieldNumber = 5;

	private int updateAff1_;

	public const int UpdateStory1FieldNumber = 6;

	private int updateStory1_;

	public const int UpdatePlot1FieldNumber = 7;

	private int updatePlot1_;

	[DebuggerNonUserCode]
	public static MessageParser<CharacterArchiveContent> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(158);

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
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Content
	{
		get
		{
			return content_;
		}
		set
		{
			content_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string UpdateContent1
	{
		get
		{
			return updateContent1_;
		}
		set
		{
			updateContent1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int UpdateAff1
	{
		get
		{
			return updateAff1_;
		}
		set
		{
			updateAff1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UpdateStory1
	{
		get
		{
			return updateStory1_;
		}
		set
		{
			updateStory1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UpdatePlot1
	{
		get
		{
			return updatePlot1_;
		}
		set
		{
			updatePlot1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CharacterArchiveContent()
	{
	}

	[DebuggerNonUserCode]
	public CharacterArchiveContent(CharacterArchiveContent other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		content_ = other.content_;
		updateContent1_ = other.updateContent1_;
		updateAff1_ = other.updateAff1_;
		updateStory1_ = other.updateStory1_;
		updatePlot1_ = other.updatePlot1_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharacterArchiveContent Clone()
	{
		return new CharacterArchiveContent(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterArchiveContent);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharacterArchiveContent other)
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
		if (Title != other.Title)
		{
			return false;
		}
		if (Content != other.Content)
		{
			return false;
		}
		if (UpdateContent1 != other.UpdateContent1)
		{
			return false;
		}
		if (UpdateAff1 != other.UpdateAff1)
		{
			return false;
		}
		if (UpdateStory1 != other.UpdateStory1)
		{
			return false;
		}
		if (UpdatePlot1 != other.UpdatePlot1)
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
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Content.Length != 0)
		{
			num ^= Content.GetHashCode();
		}
		if (UpdateContent1.Length != 0)
		{
			num ^= UpdateContent1.GetHashCode();
		}
		if (UpdateAff1 != 0)
		{
			num ^= UpdateAff1.GetHashCode();
		}
		if (UpdateStory1 != 0)
		{
			num ^= UpdateStory1.GetHashCode();
		}
		if (UpdatePlot1 != 0)
		{
			num ^= UpdatePlot1.GetHashCode();
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
		if (Title.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Title);
		}
		if (Content.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Content);
		}
		if (UpdateContent1.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(UpdateContent1);
		}
		if (UpdateAff1 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(UpdateAff1);
		}
		if (UpdateStory1 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(UpdateStory1);
		}
		if (UpdatePlot1 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(UpdatePlot1);
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
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Content.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Content);
		}
		if (UpdateContent1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UpdateContent1);
		}
		if (UpdateAff1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UpdateAff1);
		}
		if (UpdateStory1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UpdateStory1);
		}
		if (UpdatePlot1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UpdatePlot1);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharacterArchiveContent other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Content.Length != 0)
			{
				Content = other.Content;
			}
			if (other.UpdateContent1.Length != 0)
			{
				UpdateContent1 = other.UpdateContent1;
			}
			if (other.UpdateAff1 != 0)
			{
				UpdateAff1 = other.UpdateAff1;
			}
			if (other.UpdateStory1 != 0)
			{
				UpdateStory1 = other.UpdateStory1;
			}
			if (other.UpdatePlot1 != 0)
			{
				UpdatePlot1 = other.UpdatePlot1;
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
				Title = input.ReadString();
				break;
			case 26u:
				Content = input.ReadString();
				break;
			case 34u:
				UpdateContent1 = input.ReadString();
				break;
			case 40u:
				UpdateAff1 = input.ReadInt32();
				break;
			case 48u:
				UpdateStory1 = input.ReadInt32();
				break;
			case 56u:
				UpdatePlot1 = input.ReadInt32();
				break;
			}
		}
	}
}
