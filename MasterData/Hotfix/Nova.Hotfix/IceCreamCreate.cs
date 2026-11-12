using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class IceCreamCreate : IMessage<IceCreamCreate>, IMessage, IEquatable<IceCreamCreate>, IDeepCloneable<IceCreamCreate>
{
	private static readonly MessageParser<IceCreamCreate> _parser = new MessageParser<IceCreamCreate>(() => new IceCreamCreate());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int PathFieldNumber = 3;

	private string path_ = "";

	public const int OptionTypeFieldNumber = 4;

	private int optionType_;

	public const int LocalParmFieldNumber = 5;

	private int localParm_;

	public const int IsStackFieldNumber = 6;

	private bool isStack_;

	public const int StackMaxFieldNumber = 7;

	private int stackMax_;

	[DebuggerNonUserCode]
	public static MessageParser<IceCreamCreate> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(440);

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
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Path
	{
		get
		{
			return path_;
		}
		set
		{
			path_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int OptionType
	{
		get
		{
			return optionType_;
		}
		set
		{
			optionType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LocalParm
	{
		get
		{
			return localParm_;
		}
		set
		{
			localParm_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsStack
	{
		get
		{
			return isStack_;
		}
		set
		{
			isStack_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int StackMax
	{
		get
		{
			return stackMax_;
		}
		set
		{
			stackMax_ = value;
		}
	}

	[DebuggerNonUserCode]
	public IceCreamCreate()
	{
	}

	[DebuggerNonUserCode]
	public IceCreamCreate(IceCreamCreate other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		path_ = other.path_;
		optionType_ = other.optionType_;
		localParm_ = other.localParm_;
		isStack_ = other.isStack_;
		stackMax_ = other.stackMax_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public IceCreamCreate Clone()
	{
		return new IceCreamCreate(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as IceCreamCreate);
	}

	[DebuggerNonUserCode]
	public bool Equals(IceCreamCreate other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (Path != other.Path)
		{
			return false;
		}
		if (OptionType != other.OptionType)
		{
			return false;
		}
		if (LocalParm != other.LocalParm)
		{
			return false;
		}
		if (IsStack != other.IsStack)
		{
			return false;
		}
		if (StackMax != other.StackMax)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Path.Length != 0)
		{
			num ^= Path.GetHashCode();
		}
		if (OptionType != 0)
		{
			num ^= OptionType.GetHashCode();
		}
		if (LocalParm != 0)
		{
			num ^= LocalParm.GetHashCode();
		}
		if (IsStack)
		{
			num ^= IsStack.GetHashCode();
		}
		if (StackMax != 0)
		{
			num ^= StackMax.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (Path.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Path);
		}
		if (OptionType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(OptionType);
		}
		if (LocalParm != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(LocalParm);
		}
		if (IsStack)
		{
			output.WriteRawTag(48);
			output.WriteBool(IsStack);
		}
		if (StackMax != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(StackMax);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Path.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Path);
		}
		if (OptionType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OptionType);
		}
		if (LocalParm != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LocalParm);
		}
		if (IsStack)
		{
			num += 2;
		}
		if (StackMax != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StackMax);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(IceCreamCreate other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Path.Length != 0)
			{
				Path = other.Path;
			}
			if (other.OptionType != 0)
			{
				OptionType = other.OptionType;
			}
			if (other.LocalParm != 0)
			{
				LocalParm = other.LocalParm;
			}
			if (other.IsStack)
			{
				IsStack = other.IsStack;
			}
			if (other.StackMax != 0)
			{
				StackMax = other.StackMax;
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
				Name = input.ReadString();
				break;
			case 26u:
				Path = input.ReadString();
				break;
			case 32u:
				OptionType = input.ReadInt32();
				break;
			case 40u:
				LocalParm = input.ReadInt32();
				break;
			case 48u:
				IsStack = input.ReadBool();
				break;
			case 56u:
				StackMax = input.ReadInt32();
				break;
			}
		}
	}
}
