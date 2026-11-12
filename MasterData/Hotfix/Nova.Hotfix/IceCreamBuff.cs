using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class IceCreamBuff : IMessage<IceCreamBuff>, IMessage, IEquatable<IceCreamBuff>, IDeepCloneable<IceCreamBuff>
{
	private static readonly MessageParser<IceCreamBuff> _parser = new MessageParser<IceCreamBuff>(() => new IceCreamBuff());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int BuffTypeFieldNumber = 3;

	private int buffType_;

	public const int ParamFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_param_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> param_ = new RepeatedField<int>();

	public const int DescFieldNumber = 5;

	private string desc_ = "";

	public const int IconFieldNumber = 6;

	private string icon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<IceCreamBuff> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(432);

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
	public int BuffType
	{
		get
		{
			return buffType_;
		}
		set
		{
			buffType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Param => param_;

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
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public IceCreamBuff()
	{
	}

	[DebuggerNonUserCode]
	public IceCreamBuff(IceCreamBuff other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		buffType_ = other.buffType_;
		param_ = other.param_.Clone();
		desc_ = other.desc_;
		icon_ = other.icon_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public IceCreamBuff Clone()
	{
		return new IceCreamBuff(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as IceCreamBuff);
	}

	[DebuggerNonUserCode]
	public bool Equals(IceCreamBuff other)
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
		if (BuffType != other.BuffType)
		{
			return false;
		}
		if (!param_.Equals(other.param_))
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Icon != other.Icon)
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
		if (BuffType != 0)
		{
			num ^= BuffType.GetHashCode();
		}
		num ^= param_.GetHashCode();
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
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
		if (BuffType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(BuffType);
		}
		param_.WriteTo(output, _repeated_param_codec);
		if (Desc.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Desc);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Icon);
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
		if (BuffType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffType);
		}
		num += param_.CalculateSize(_repeated_param_codec);
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(IceCreamBuff other)
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
			if (other.BuffType != 0)
			{
				BuffType = other.BuffType;
			}
			param_.Add(other.param_);
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
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
			case 24u:
				BuffType = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				param_.AddEntriesFrom(input, _repeated_param_codec);
				break;
			case 42u:
				Desc = input.ReadString();
				break;
			case 50u:
				Icon = input.ReadString();
				break;
			}
		}
	}
}
