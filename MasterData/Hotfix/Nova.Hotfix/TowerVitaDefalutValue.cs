using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TowerVitaDefalutValue : IMessage<TowerVitaDefalutValue>, IMessage, IEquatable<TowerVitaDefalutValue>, IDeepCloneable<TowerVitaDefalutValue>
{
	private static readonly MessageParser<TowerVitaDefalutValue> _parser = new MessageParser<TowerVitaDefalutValue>(() => new TowerVitaDefalutValue());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int OptionIdFieldNumber = 2;

	private int optionId_;

	public const int DefaultValueFieldNumber = 3;

	private string defaultValue_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<TowerVitaDefalutValue> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(974);

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
	public string DefaultValue
	{
		get
		{
			return defaultValue_;
		}
		set
		{
			defaultValue_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public TowerVitaDefalutValue()
	{
	}

	[DebuggerNonUserCode]
	public TowerVitaDefalutValue(TowerVitaDefalutValue other)
		: this()
	{
		id_ = other.id_;
		optionId_ = other.optionId_;
		defaultValue_ = other.defaultValue_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TowerVitaDefalutValue Clone()
	{
		return new TowerVitaDefalutValue(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TowerVitaDefalutValue);
	}

	[DebuggerNonUserCode]
	public bool Equals(TowerVitaDefalutValue other)
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
		if (DefaultValue != other.DefaultValue)
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
		if (DefaultValue.Length != 0)
		{
			num ^= DefaultValue.GetHashCode();
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
		if (DefaultValue.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(DefaultValue);
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
		if (DefaultValue.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DefaultValue);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TowerVitaDefalutValue other)
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
			if (other.DefaultValue.Length != 0)
			{
				DefaultValue = other.DefaultValue;
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
				DefaultValue = input.ReadString();
				break;
			}
		}
	}
}
