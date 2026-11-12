using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TestTeamData : IMessage<TestTeamData>, IMessage, IEquatable<TestTeamData>, IDeepCloneable<TestTeamData>
{
	private static readonly MessageParser<TestTeamData> _parser = new MessageParser<TestTeamData>(() => new TestTeamData());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DiscListMasterFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_discListMaster_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> discListMaster_ = new RepeatedField<int>();

	public const int DiscListSubFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_discListSub_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> discListSub_ = new RepeatedField<int>();

	public const int DiscLevelFieldNumber = 4;

	private int discLevel_;

	public const int DiscPromoteLevelFieldNumber = 5;

	private int discPromoteLevel_;

	public const int DiscLimitBreakLevelFieldNumber = 6;

	private int discLimitBreakLevel_;

	public const int SubNoteListFieldNumber = 7;

	private string subNoteList_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<TestTeamData> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(924);

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
	public RepeatedField<int> DiscListMaster => discListMaster_;

	[DebuggerNonUserCode]
	public RepeatedField<int> DiscListSub => discListSub_;

	[DebuggerNonUserCode]
	public int DiscLevel
	{
		get
		{
			return discLevel_;
		}
		set
		{
			discLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DiscPromoteLevel
	{
		get
		{
			return discPromoteLevel_;
		}
		set
		{
			discPromoteLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DiscLimitBreakLevel
	{
		get
		{
			return discLimitBreakLevel_;
		}
		set
		{
			discLimitBreakLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string SubNoteList
	{
		get
		{
			return subNoteList_;
		}
		set
		{
			subNoteList_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public TestTeamData()
	{
	}

	[DebuggerNonUserCode]
	public TestTeamData(TestTeamData other)
		: this()
	{
		id_ = other.id_;
		discListMaster_ = other.discListMaster_.Clone();
		discListSub_ = other.discListSub_.Clone();
		discLevel_ = other.discLevel_;
		discPromoteLevel_ = other.discPromoteLevel_;
		discLimitBreakLevel_ = other.discLimitBreakLevel_;
		subNoteList_ = other.subNoteList_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TestTeamData Clone()
	{
		return new TestTeamData(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TestTeamData);
	}

	[DebuggerNonUserCode]
	public bool Equals(TestTeamData other)
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
		if (!discListMaster_.Equals(other.discListMaster_))
		{
			return false;
		}
		if (!discListSub_.Equals(other.discListSub_))
		{
			return false;
		}
		if (DiscLevel != other.DiscLevel)
		{
			return false;
		}
		if (DiscPromoteLevel != other.DiscPromoteLevel)
		{
			return false;
		}
		if (DiscLimitBreakLevel != other.DiscLimitBreakLevel)
		{
			return false;
		}
		if (SubNoteList != other.SubNoteList)
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
		num ^= discListMaster_.GetHashCode();
		num ^= discListSub_.GetHashCode();
		if (DiscLevel != 0)
		{
			num ^= DiscLevel.GetHashCode();
		}
		if (DiscPromoteLevel != 0)
		{
			num ^= DiscPromoteLevel.GetHashCode();
		}
		if (DiscLimitBreakLevel != 0)
		{
			num ^= DiscLimitBreakLevel.GetHashCode();
		}
		if (SubNoteList.Length != 0)
		{
			num ^= SubNoteList.GetHashCode();
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
		discListMaster_.WriteTo(output, _repeated_discListMaster_codec);
		discListSub_.WriteTo(output, _repeated_discListSub_codec);
		if (DiscLevel != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(DiscLevel);
		}
		if (DiscPromoteLevel != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(DiscPromoteLevel);
		}
		if (DiscLimitBreakLevel != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(DiscLimitBreakLevel);
		}
		if (SubNoteList.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(SubNoteList);
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
		num += discListMaster_.CalculateSize(_repeated_discListMaster_codec);
		num += discListSub_.CalculateSize(_repeated_discListSub_codec);
		if (DiscLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DiscLevel);
		}
		if (DiscPromoteLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DiscPromoteLevel);
		}
		if (DiscLimitBreakLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DiscLimitBreakLevel);
		}
		if (SubNoteList.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SubNoteList);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TestTeamData other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			discListMaster_.Add(other.discListMaster_);
			discListSub_.Add(other.discListSub_);
			if (other.DiscLevel != 0)
			{
				DiscLevel = other.DiscLevel;
			}
			if (other.DiscPromoteLevel != 0)
			{
				DiscPromoteLevel = other.DiscPromoteLevel;
			}
			if (other.DiscLimitBreakLevel != 0)
			{
				DiscLimitBreakLevel = other.DiscLimitBreakLevel;
			}
			if (other.SubNoteList.Length != 0)
			{
				SubNoteList = other.SubNoteList;
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
			case 18u:
				discListMaster_.AddEntriesFrom(input, _repeated_discListMaster_codec);
				break;
			case 24u:
			case 26u:
				discListSub_.AddEntriesFrom(input, _repeated_discListSub_codec);
				break;
			case 32u:
				DiscLevel = input.ReadInt32();
				break;
			case 40u:
				DiscPromoteLevel = input.ReadInt32();
				break;
			case 48u:
				DiscLimitBreakLevel = input.ReadInt32();
				break;
			case 58u:
				SubNoteList = input.ReadString();
				break;
			}
		}
	}
}
