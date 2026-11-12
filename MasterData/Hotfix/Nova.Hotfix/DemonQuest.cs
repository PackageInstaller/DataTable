using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DemonQuest : IMessage<DemonQuest>, IMessage, IEquatable<DemonQuest>, IDeepCloneable<DemonQuest>
{
	private static readonly MessageParser<DemonQuest> _parser = new MessageParser<DemonQuest>(() => new DemonQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int AdvanceGroupFieldNumber = 2;

	private int advanceGroup_;

	public const int TitleFieldNumber = 3;

	private string title_ = "";

	public const int JumpToFieldNumber = 4;

	private int jumpTo_;

	public const int FinishTypeFieldNumber = 5;

	private int finishType_;

	public const int FInishParamsFieldNumber = 6;

	private string fInishParams_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<DemonQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(258);

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
	public int AdvanceGroup
	{
		get
		{
			return advanceGroup_;
		}
		set
		{
			advanceGroup_ = value;
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
	public int JumpTo
	{
		get
		{
			return jumpTo_;
		}
		set
		{
			jumpTo_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FinishType
	{
		get
		{
			return finishType_;
		}
		set
		{
			finishType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string FInishParams
	{
		get
		{
			return fInishParams_;
		}
		set
		{
			fInishParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public DemonQuest()
	{
	}

	[DebuggerNonUserCode]
	public DemonQuest(DemonQuest other)
		: this()
	{
		id_ = other.id_;
		advanceGroup_ = other.advanceGroup_;
		title_ = other.title_;
		jumpTo_ = other.jumpTo_;
		finishType_ = other.finishType_;
		fInishParams_ = other.fInishParams_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DemonQuest Clone()
	{
		return new DemonQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DemonQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(DemonQuest other)
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
		if (AdvanceGroup != other.AdvanceGroup)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (JumpTo != other.JumpTo)
		{
			return false;
		}
		if (FinishType != other.FinishType)
		{
			return false;
		}
		if (FInishParams != other.FInishParams)
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
		if (AdvanceGroup != 0)
		{
			num ^= AdvanceGroup.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (JumpTo != 0)
		{
			num ^= JumpTo.GetHashCode();
		}
		if (FinishType != 0)
		{
			num ^= FinishType.GetHashCode();
		}
		if (FInishParams.Length != 0)
		{
			num ^= FInishParams.GetHashCode();
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
		if (AdvanceGroup != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(AdvanceGroup);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Title);
		}
		if (JumpTo != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(JumpTo);
		}
		if (FinishType != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(FinishType);
		}
		if (FInishParams.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(FInishParams);
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
		if (AdvanceGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AdvanceGroup);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (JumpTo != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(JumpTo);
		}
		if (FinishType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FinishType);
		}
		if (FInishParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FInishParams);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DemonQuest other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.AdvanceGroup != 0)
			{
				AdvanceGroup = other.AdvanceGroup;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.JumpTo != 0)
			{
				JumpTo = other.JumpTo;
			}
			if (other.FinishType != 0)
			{
				FinishType = other.FinishType;
			}
			if (other.FInishParams.Length != 0)
			{
				FInishParams = other.FInishParams;
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
				AdvanceGroup = input.ReadInt32();
				break;
			case 26u:
				Title = input.ReadString();
				break;
			case 32u:
				JumpTo = input.ReadInt32();
				break;
			case 40u:
				FinishType = input.ReadInt32();
				break;
			case 50u:
				FInishParams = input.ReadString();
				break;
			}
		}
	}
}
