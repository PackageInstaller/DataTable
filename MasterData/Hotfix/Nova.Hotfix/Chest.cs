using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Chest : IMessage<Chest>, IMessage, IEquatable<Chest>, IDeepCloneable<Chest>
{
	private static readonly MessageParser<Chest> _parser = new MessageParser<Chest>(() => new Chest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupFieldNumber = 2;

	private int group_;

	public const int LabelFieldNumber = 3;

	private int label_;

	public const int LowFloorFieldNumber = 4;

	private int lowFloor_;

	public const int HighFloorFieldNumber = 5;

	private int highFloor_;

	public const int TnteractionTypeFieldNumber = 6;

	private int tnteractionType_;

	public const int AutoOpenFieldNumber = 7;

	private int autoOpen_;

	public const int ModelPathFieldNumber = 8;

	private string modelPath_ = "";

	public const int Item1FieldNumber = 9;

	private int item1_;

	public const int Number1FieldNumber = 10;

	private int number1_;

	public const int Item2FieldNumber = 11;

	private int item2_;

	public const int Number2FieldNumber = 12;

	private int number2_;

	public const int Item3FieldNumber = 13;

	private int item3_;

	public const int Number3FieldNumber = 14;

	private int number3_;

	public const int Item4FieldNumber = 15;

	private int item4_;

	public const int Number4FieldNumber = 16;

	private int number4_;

	[DebuggerNonUserCode]
	public static MessageParser<Chest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(212);

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
	public int Label
	{
		get
		{
			return label_;
		}
		set
		{
			label_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LowFloor
	{
		get
		{
			return lowFloor_;
		}
		set
		{
			lowFloor_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HighFloor
	{
		get
		{
			return highFloor_;
		}
		set
		{
			highFloor_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TnteractionType
	{
		get
		{
			return tnteractionType_;
		}
		set
		{
			tnteractionType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AutoOpen
	{
		get
		{
			return autoOpen_;
		}
		set
		{
			autoOpen_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ModelPath
	{
		get
		{
			return modelPath_;
		}
		set
		{
			modelPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Item1
	{
		get
		{
			return item1_;
		}
		set
		{
			item1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Number1
	{
		get
		{
			return number1_;
		}
		set
		{
			number1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Item2
	{
		get
		{
			return item2_;
		}
		set
		{
			item2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Number2
	{
		get
		{
			return number2_;
		}
		set
		{
			number2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Item3
	{
		get
		{
			return item3_;
		}
		set
		{
			item3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Number3
	{
		get
		{
			return number3_;
		}
		set
		{
			number3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Item4
	{
		get
		{
			return item4_;
		}
		set
		{
			item4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Number4
	{
		get
		{
			return number4_;
		}
		set
		{
			number4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Chest()
	{
	}

	[DebuggerNonUserCode]
	public Chest(Chest other)
		: this()
	{
		id_ = other.id_;
		group_ = other.group_;
		label_ = other.label_;
		lowFloor_ = other.lowFloor_;
		highFloor_ = other.highFloor_;
		tnteractionType_ = other.tnteractionType_;
		autoOpen_ = other.autoOpen_;
		modelPath_ = other.modelPath_;
		item1_ = other.item1_;
		number1_ = other.number1_;
		item2_ = other.item2_;
		number2_ = other.number2_;
		item3_ = other.item3_;
		number3_ = other.number3_;
		item4_ = other.item4_;
		number4_ = other.number4_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Chest Clone()
	{
		return new Chest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Chest);
	}

	[DebuggerNonUserCode]
	public bool Equals(Chest other)
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
		if (Group != other.Group)
		{
			return false;
		}
		if (Label != other.Label)
		{
			return false;
		}
		if (LowFloor != other.LowFloor)
		{
			return false;
		}
		if (HighFloor != other.HighFloor)
		{
			return false;
		}
		if (TnteractionType != other.TnteractionType)
		{
			return false;
		}
		if (AutoOpen != other.AutoOpen)
		{
			return false;
		}
		if (ModelPath != other.ModelPath)
		{
			return false;
		}
		if (Item1 != other.Item1)
		{
			return false;
		}
		if (Number1 != other.Number1)
		{
			return false;
		}
		if (Item2 != other.Item2)
		{
			return false;
		}
		if (Number2 != other.Number2)
		{
			return false;
		}
		if (Item3 != other.Item3)
		{
			return false;
		}
		if (Number3 != other.Number3)
		{
			return false;
		}
		if (Item4 != other.Item4)
		{
			return false;
		}
		if (Number4 != other.Number4)
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
		if (Group != 0)
		{
			num ^= Group.GetHashCode();
		}
		if (Label != 0)
		{
			num ^= Label.GetHashCode();
		}
		if (LowFloor != 0)
		{
			num ^= LowFloor.GetHashCode();
		}
		if (HighFloor != 0)
		{
			num ^= HighFloor.GetHashCode();
		}
		if (TnteractionType != 0)
		{
			num ^= TnteractionType.GetHashCode();
		}
		if (AutoOpen != 0)
		{
			num ^= AutoOpen.GetHashCode();
		}
		if (ModelPath.Length != 0)
		{
			num ^= ModelPath.GetHashCode();
		}
		if (Item1 != 0)
		{
			num ^= Item1.GetHashCode();
		}
		if (Number1 != 0)
		{
			num ^= Number1.GetHashCode();
		}
		if (Item2 != 0)
		{
			num ^= Item2.GetHashCode();
		}
		if (Number2 != 0)
		{
			num ^= Number2.GetHashCode();
		}
		if (Item3 != 0)
		{
			num ^= Item3.GetHashCode();
		}
		if (Number3 != 0)
		{
			num ^= Number3.GetHashCode();
		}
		if (Item4 != 0)
		{
			num ^= Item4.GetHashCode();
		}
		if (Number4 != 0)
		{
			num ^= Number4.GetHashCode();
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
		if (Group != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Group);
		}
		if (Label != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Label);
		}
		if (LowFloor != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(LowFloor);
		}
		if (HighFloor != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(HighFloor);
		}
		if (TnteractionType != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(TnteractionType);
		}
		if (AutoOpen != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(AutoOpen);
		}
		if (ModelPath.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(ModelPath);
		}
		if (Item1 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Item1);
		}
		if (Number1 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Number1);
		}
		if (Item2 != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Item2);
		}
		if (Number2 != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Number2);
		}
		if (Item3 != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(Item3);
		}
		if (Number3 != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(Number3);
		}
		if (Item4 != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(Item4);
		}
		if (Number4 != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(Number4);
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
		if (Group != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Group);
		}
		if (Label != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Label);
		}
		if (LowFloor != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LowFloor);
		}
		if (HighFloor != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HighFloor);
		}
		if (TnteractionType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TnteractionType);
		}
		if (AutoOpen != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AutoOpen);
		}
		if (ModelPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ModelPath);
		}
		if (Item1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Item1);
		}
		if (Number1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Number1);
		}
		if (Item2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Item2);
		}
		if (Number2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Number2);
		}
		if (Item3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Item3);
		}
		if (Number3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Number3);
		}
		if (Item4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Item4);
		}
		if (Number4 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Number4);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Chest other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Group != 0)
			{
				Group = other.Group;
			}
			if (other.Label != 0)
			{
				Label = other.Label;
			}
			if (other.LowFloor != 0)
			{
				LowFloor = other.LowFloor;
			}
			if (other.HighFloor != 0)
			{
				HighFloor = other.HighFloor;
			}
			if (other.TnteractionType != 0)
			{
				TnteractionType = other.TnteractionType;
			}
			if (other.AutoOpen != 0)
			{
				AutoOpen = other.AutoOpen;
			}
			if (other.ModelPath.Length != 0)
			{
				ModelPath = other.ModelPath;
			}
			if (other.Item1 != 0)
			{
				Item1 = other.Item1;
			}
			if (other.Number1 != 0)
			{
				Number1 = other.Number1;
			}
			if (other.Item2 != 0)
			{
				Item2 = other.Item2;
			}
			if (other.Number2 != 0)
			{
				Number2 = other.Number2;
			}
			if (other.Item3 != 0)
			{
				Item3 = other.Item3;
			}
			if (other.Number3 != 0)
			{
				Number3 = other.Number3;
			}
			if (other.Item4 != 0)
			{
				Item4 = other.Item4;
			}
			if (other.Number4 != 0)
			{
				Number4 = other.Number4;
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
				Group = input.ReadInt32();
				break;
			case 24u:
				Label = input.ReadInt32();
				break;
			case 32u:
				LowFloor = input.ReadInt32();
				break;
			case 40u:
				HighFloor = input.ReadInt32();
				break;
			case 48u:
				TnteractionType = input.ReadInt32();
				break;
			case 56u:
				AutoOpen = input.ReadInt32();
				break;
			case 66u:
				ModelPath = input.ReadString();
				break;
			case 72u:
				Item1 = input.ReadInt32();
				break;
			case 80u:
				Number1 = input.ReadInt32();
				break;
			case 88u:
				Item2 = input.ReadInt32();
				break;
			case 96u:
				Number2 = input.ReadInt32();
				break;
			case 104u:
				Item3 = input.ReadInt32();
				break;
			case 112u:
				Number3 = input.ReadInt32();
				break;
			case 120u:
				Item4 = input.ReadInt32();
				break;
			case 128u:
				Number4 = input.ReadInt32();
				break;
			}
		}
	}
}
