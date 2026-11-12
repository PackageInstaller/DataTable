using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TalentGroup : IMessage<TalentGroup>, IMessage, IEquatable<TalentGroup>, IDeepCloneable<TalentGroup>
{
	private static readonly MessageParser<TalentGroup> _parser = new MessageParser<TalentGroup>(() => new TalentGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CharIdFieldNumber = 2;

	private int charId_;

	public const int PreGroupFieldNumber = 3;

	private int preGroup_;

	public const int NodeLimitFieldNumber = 4;

	private int nodeLimit_;

	public const int BackgroundFieldNumber = 5;

	private int background_;

	public const int TitleFieldNumber = 6;

	private string title_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<TalentGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(918);

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
	public int PreGroup
	{
		get
		{
			return preGroup_;
		}
		set
		{
			preGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NodeLimit
	{
		get
		{
			return nodeLimit_;
		}
		set
		{
			nodeLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Background
	{
		get
		{
			return background_;
		}
		set
		{
			background_ = value;
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
	public TalentGroup()
	{
	}

	[DebuggerNonUserCode]
	public TalentGroup(TalentGroup other)
		: this()
	{
		id_ = other.id_;
		charId_ = other.charId_;
		preGroup_ = other.preGroup_;
		nodeLimit_ = other.nodeLimit_;
		background_ = other.background_;
		title_ = other.title_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TalentGroup Clone()
	{
		return new TalentGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TalentGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(TalentGroup other)
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
		if (PreGroup != other.PreGroup)
		{
			return false;
		}
		if (NodeLimit != other.NodeLimit)
		{
			return false;
		}
		if (Background != other.Background)
		{
			return false;
		}
		if (Title != other.Title)
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
		if (PreGroup != 0)
		{
			num ^= PreGroup.GetHashCode();
		}
		if (NodeLimit != 0)
		{
			num ^= NodeLimit.GetHashCode();
		}
		if (Background != 0)
		{
			num ^= Background.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
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
		if (PreGroup != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(PreGroup);
		}
		if (NodeLimit != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(NodeLimit);
		}
		if (Background != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Background);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Title);
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
		if (PreGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreGroup);
		}
		if (NodeLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NodeLimit);
		}
		if (Background != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Background);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TalentGroup other)
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
			if (other.PreGroup != 0)
			{
				PreGroup = other.PreGroup;
			}
			if (other.NodeLimit != 0)
			{
				NodeLimit = other.NodeLimit;
			}
			if (other.Background != 0)
			{
				Background = other.Background;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
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
			case 24u:
				PreGroup = input.ReadInt32();
				break;
			case 32u:
				NodeLimit = input.ReadInt32();
				break;
			case 40u:
				Background = input.ReadInt32();
				break;
			case 50u:
				Title = input.ReadString();
				break;
			}
		}
	}
}
