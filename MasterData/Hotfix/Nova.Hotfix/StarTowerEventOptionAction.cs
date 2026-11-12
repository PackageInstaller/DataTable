using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerEventOptionAction : IMessage<StarTowerEventOptionAction>, IMessage, IEquatable<StarTowerEventOptionAction>, IDeepCloneable<StarTowerEventOptionAction>
{
	private static readonly MessageParser<StarTowerEventOptionAction> _parser = new MessageParser<StarTowerEventOptionAction>(() => new StarTowerEventOptionAction());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int OptionIdFieldNumber = 2;

	private int optionId_;

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int GroupFieldNumber = 4;

	private int group_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerEventOptionAction> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(846);

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
	public int OptionId
	{
		get
		{
			return optionId_;
		}
		set
		{
			optionId_ = value;
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
	public int Group
	{
		get
		{
			return group_;
		}
		set
		{
			group_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerEventOptionAction()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerEventOptionAction(StarTowerEventOptionAction other)
		: this()
	{
		id_ = other.id_;
		optionId_ = other.optionId_;
		desc_ = other.desc_;
		group_ = other.group_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerEventOptionAction Clone()
	{
		return new StarTowerEventOptionAction(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerEventOptionAction);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerEventOptionAction other)
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
		if (OptionId != other.OptionId)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Group != other.Group)
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
		if (OptionId != 0)
		{
			num ^= OptionId.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Group != 0)
		{
			num ^= Group.GetHashCode();
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
		if (OptionId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(OptionId);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		if (Group != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Group);
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
		if (OptionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OptionId);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Group != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Group);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerEventOptionAction other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.OptionId != 0)
			{
				OptionId = other.OptionId;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Group != 0)
			{
				Group = other.Group;
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
				OptionId = input.ReadInt32();
				break;
			case 26u:
				Desc = input.ReadString();
				break;
			case 32u:
				Group = input.ReadInt32();
				break;
			}
		}
	}
}
