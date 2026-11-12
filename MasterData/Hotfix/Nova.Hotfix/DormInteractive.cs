using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DormInteractive : IMessage<DormInteractive>, IMessage, IEquatable<DormInteractive>, IDeepCloneable<DormInteractive>
{
	private static readonly MessageParser<DormInteractive> _parser = new MessageParser<DormInteractive>(() => new DormInteractive());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CharIdFieldNumber = 2;

	private int charId_;

	public const int FurniturnIdFieldNumber = 3;

	private int furniturnId_;

	public const int DormInterTypeFieldNumber = 4;

	private int dormInterType_;

	public const int AnimationConfigFieldNumber = 5;

	private string animationConfig_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<DormInteractive> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(294);

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
	public int FurniturnId
	{
		get
		{
			return furniturnId_;
		}
		set
		{
			furniturnId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DormInterType
	{
		get
		{
			return dormInterType_;
		}
		set
		{
			dormInterType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string AnimationConfig
	{
		get
		{
			return animationConfig_;
		}
		set
		{
			animationConfig_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public DormInteractive()
	{
	}

	[DebuggerNonUserCode]
	public DormInteractive(DormInteractive other)
		: this()
	{
		id_ = other.id_;
		charId_ = other.charId_;
		furniturnId_ = other.furniturnId_;
		dormInterType_ = other.dormInterType_;
		animationConfig_ = other.animationConfig_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DormInteractive Clone()
	{
		return new DormInteractive(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DormInteractive);
	}

	[DebuggerNonUserCode]
	public bool Equals(DormInteractive other)
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
		if (FurniturnId != other.FurniturnId)
		{
			return false;
		}
		if (DormInterType != other.DormInterType)
		{
			return false;
		}
		if (AnimationConfig != other.AnimationConfig)
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
		if (FurniturnId != 0)
		{
			num ^= FurniturnId.GetHashCode();
		}
		if (DormInterType != 0)
		{
			num ^= DormInterType.GetHashCode();
		}
		if (AnimationConfig.Length != 0)
		{
			num ^= AnimationConfig.GetHashCode();
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
		if (FurniturnId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(FurniturnId);
		}
		if (DormInterType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(DormInterType);
		}
		if (AnimationConfig.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(AnimationConfig);
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
		if (FurniturnId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FurniturnId);
		}
		if (DormInterType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DormInterType);
		}
		if (AnimationConfig.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AnimationConfig);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DormInteractive other)
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
			if (other.FurniturnId != 0)
			{
				FurniturnId = other.FurniturnId;
			}
			if (other.DormInterType != 0)
			{
				DormInterType = other.DormInterType;
			}
			if (other.AnimationConfig.Length != 0)
			{
				AnimationConfig = other.AnimationConfig;
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
				FurniturnId = input.ReadInt32();
				break;
			case 32u:
				DormInterType = input.ReadInt32();
				break;
			case 42u:
				AnimationConfig = input.ReadString();
				break;
			}
		}
	}
}
