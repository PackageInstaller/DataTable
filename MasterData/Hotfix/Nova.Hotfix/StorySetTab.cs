using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StorySetTab : IMessage<StorySetTab>, IMessage, IEquatable<StorySetTab>, IDeepCloneable<StorySetTab>
{
	private static readonly MessageParser<StorySetTab> _parser = new MessageParser<StorySetTab>(() => new StorySetTab());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TabNameFieldNumber = 2;

	private string tabName_ = "";

	public const int IsShowFieldNumber = 3;

	private bool isShow_;

	public const int OpenTimeFieldNumber = 4;

	private string openTime_ = "";

	public const int IsAllFieldNumber = 5;

	private bool isAll_;

	[DebuggerNonUserCode]
	public static MessageParser<StorySetTab> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(908);

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
	public string TabName
	{
		get
		{
			return tabName_;
		}
		set
		{
			tabName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool IsShow
	{
		get
		{
			return isShow_;
		}
		set
		{
			isShow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string OpenTime
	{
		get
		{
			return openTime_;
		}
		set
		{
			openTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool IsAll
	{
		get
		{
			return isAll_;
		}
		set
		{
			isAll_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StorySetTab()
	{
	}

	[DebuggerNonUserCode]
	public StorySetTab(StorySetTab other)
		: this()
	{
		id_ = other.id_;
		tabName_ = other.tabName_;
		isShow_ = other.isShow_;
		openTime_ = other.openTime_;
		isAll_ = other.isAll_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StorySetTab Clone()
	{
		return new StorySetTab(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StorySetTab);
	}

	[DebuggerNonUserCode]
	public bool Equals(StorySetTab other)
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
		if (TabName != other.TabName)
		{
			return false;
		}
		if (IsShow != other.IsShow)
		{
			return false;
		}
		if (OpenTime != other.OpenTime)
		{
			return false;
		}
		if (IsAll != other.IsAll)
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
		if (TabName.Length != 0)
		{
			num ^= TabName.GetHashCode();
		}
		if (IsShow)
		{
			num ^= IsShow.GetHashCode();
		}
		if (OpenTime.Length != 0)
		{
			num ^= OpenTime.GetHashCode();
		}
		if (IsAll)
		{
			num ^= IsAll.GetHashCode();
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
		if (TabName.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(TabName);
		}
		if (IsShow)
		{
			output.WriteRawTag(24);
			output.WriteBool(IsShow);
		}
		if (OpenTime.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(OpenTime);
		}
		if (IsAll)
		{
			output.WriteRawTag(40);
			output.WriteBool(IsAll);
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
		if (TabName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TabName);
		}
		if (IsShow)
		{
			num += 2;
		}
		if (OpenTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OpenTime);
		}
		if (IsAll)
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
	public void MergeFrom(StorySetTab other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.TabName.Length != 0)
			{
				TabName = other.TabName;
			}
			if (other.IsShow)
			{
				IsShow = other.IsShow;
			}
			if (other.OpenTime.Length != 0)
			{
				OpenTime = other.OpenTime;
			}
			if (other.IsAll)
			{
				IsAll = other.IsAll;
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
				TabName = input.ReadString();
				break;
			case 24u:
				IsShow = input.ReadBool();
				break;
			case 34u:
				OpenTime = input.ReadString();
				break;
			case 40u:
				IsAll = input.ReadBool();
				break;
			}
		}
	}
}
