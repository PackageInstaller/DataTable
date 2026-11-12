using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StorySetSection : IMessage<StorySetSection>, IMessage, IEquatable<StorySetSection>, IDeepCloneable<StorySetSection>
{
	private static readonly MessageParser<StorySetSection> _parser = new MessageParser<StorySetSection>(() => new StorySetSection());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ChapterIdFieldNumber = 2;

	private int chapterId_;

	public const int RewardItem1TidFieldNumber = 3;

	private int rewardItem1Tid_;

	public const int RewardItem1QtyFieldNumber = 4;

	private int rewardItem1Qty_;

	public const int TitleFieldNumber = 5;

	private string title_ = "";

	public const int DescFieldNumber = 6;

	private string desc_ = "";

	public const int AVGIdFieldNumber = 7;

	private string aVGId_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<StorySetSection> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(906);

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
	public int ChapterId
	{
		get
		{
			return chapterId_;
		}
		set
		{
			chapterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardItem1Tid
	{
		get
		{
			return rewardItem1Tid_;
		}
		set
		{
			rewardItem1Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardItem1Qty
	{
		get
		{
			return rewardItem1Qty_;
		}
		set
		{
			rewardItem1Qty_ = value;
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
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AVGId
	{
		get
		{
			return aVGId_;
		}
		set
		{
			aVGId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public StorySetSection()
	{
	}

	[DebuggerNonUserCode]
	public StorySetSection(StorySetSection other)
		: this()
	{
		id_ = other.id_;
		chapterId_ = other.chapterId_;
		rewardItem1Tid_ = other.rewardItem1Tid_;
		rewardItem1Qty_ = other.rewardItem1Qty_;
		title_ = other.title_;
		desc_ = other.desc_;
		aVGId_ = other.aVGId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StorySetSection Clone()
	{
		return new StorySetSection(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StorySetSection);
	}

	[DebuggerNonUserCode]
	public bool Equals(StorySetSection other)
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
		if (ChapterId != other.ChapterId)
		{
			return false;
		}
		if (RewardItem1Tid != other.RewardItem1Tid)
		{
			return false;
		}
		if (RewardItem1Qty != other.RewardItem1Qty)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (AVGId != other.AVGId)
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
		if (ChapterId != 0)
		{
			num ^= ChapterId.GetHashCode();
		}
		if (RewardItem1Tid != 0)
		{
			num ^= RewardItem1Tid.GetHashCode();
		}
		if (RewardItem1Qty != 0)
		{
			num ^= RewardItem1Qty.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (AVGId.Length != 0)
		{
			num ^= AVGId.GetHashCode();
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
		if (ChapterId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ChapterId);
		}
		if (RewardItem1Tid != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(RewardItem1Tid);
		}
		if (RewardItem1Qty != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(RewardItem1Qty);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Title);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Desc);
		}
		if (AVGId.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(AVGId);
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
		if (ChapterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChapterId);
		}
		if (RewardItem1Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardItem1Tid);
		}
		if (RewardItem1Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardItem1Qty);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (AVGId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AVGId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StorySetSection other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ChapterId != 0)
			{
				ChapterId = other.ChapterId;
			}
			if (other.RewardItem1Tid != 0)
			{
				RewardItem1Tid = other.RewardItem1Tid;
			}
			if (other.RewardItem1Qty != 0)
			{
				RewardItem1Qty = other.RewardItem1Qty;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.AVGId.Length != 0)
			{
				AVGId = other.AVGId;
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
				ChapterId = input.ReadInt32();
				break;
			case 24u:
				RewardItem1Tid = input.ReadInt32();
				break;
			case 32u:
				RewardItem1Qty = input.ReadInt32();
				break;
			case 42u:
				Title = input.ReadString();
				break;
			case 50u:
				Desc = input.ReadString();
				break;
			case 58u:
				AVGId = input.ReadString();
				break;
			}
		}
	}
}
