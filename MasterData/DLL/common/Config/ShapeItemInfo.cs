using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class ShapeItemInfo : IMessage<ShapeItemInfo>, IMessage, IEquatable<ShapeItemInfo>, IDeepCloneable<ShapeItemInfo>
{
	private static readonly MessageParser<ShapeItemInfo> _parser = new MessageParser<ShapeItemInfo>(() => new ShapeItemInfo());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int ShapePartTypeFieldNumber = 2;

	private ShapePartType shapePartType_;

	public const int OffsetFieldNumber = 3;

	private VectorInt3 offset_;

	public const int SizeFieldNumber = 4;

	private int size_;

	public const int EnableFieldNumber = 5;

	private bool enable_;

	[DebuggerNonUserCode]
	public static MessageParser<ShapeItemInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[55];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ShapePartType ShapePartType
	{
		get
		{
			return shapePartType_;
		}
		set
		{
			shapePartType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public VectorInt3 Offset
	{
		get
		{
			return offset_;
		}
		set
		{
			offset_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Size
	{
		get
		{
			return size_;
		}
		set
		{
			size_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Enable
	{
		get
		{
			return enable_;
		}
		set
		{
			enable_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ShapeItemInfo()
	{
	}

	[DebuggerNonUserCode]
	public ShapeItemInfo(ShapeItemInfo other)
		: this()
	{
		iD_ = other.iD_;
		shapePartType_ = other.shapePartType_;
		Offset = ((other.offset_ != null) ? other.Offset.Clone() : null);
		size_ = other.size_;
		enable_ = other.enable_;
	}

	[DebuggerNonUserCode]
	public ShapeItemInfo Clone()
	{
		return new ShapeItemInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ShapeItemInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(ShapeItemInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (ShapePartType != other.ShapePartType)
		{
			return false;
		}
		if (!object.Equals(Offset, other.Offset))
		{
			return false;
		}
		if (Size != other.Size)
		{
			return false;
		}
		if (Enable != other.Enable)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (ShapePartType != ShapePartType.Body)
		{
			num ^= ShapePartType.GetHashCode();
		}
		if (offset_ != null)
		{
			num ^= Offset.GetHashCode();
		}
		if (Size != 0)
		{
			num ^= Size.GetHashCode();
		}
		if (Enable)
		{
			num ^= Enable.GetHashCode();
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
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (ShapePartType != ShapePartType.Body)
		{
			output.WriteRawTag(16);
			output.WriteEnum((int)ShapePartType);
		}
		if (offset_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(Offset);
		}
		if (Size != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Size);
		}
		if (Enable)
		{
			output.WriteRawTag(40);
			output.WriteBool(Enable);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (ShapePartType != ShapePartType.Body)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)ShapePartType);
		}
		if (offset_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Offset);
		}
		if (Size != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Size);
		}
		if (Enable)
		{
			num += 2;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ShapeItemInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.ID != 0)
		{
			ID = other.ID;
		}
		if (other.ShapePartType != ShapePartType.Body)
		{
			ShapePartType = other.ShapePartType;
		}
		if (other.offset_ != null)
		{
			if (offset_ == null)
			{
				offset_ = new VectorInt3();
			}
			Offset.MergeFrom(other.Offset);
		}
		if (other.Size != 0)
		{
			Size = other.Size;
		}
		if (other.Enable)
		{
			Enable = other.Enable;
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
				input.SkipLastField();
				break;
			case 8u:
				ID = input.ReadInt32();
				break;
			case 16u:
				shapePartType_ = (ShapePartType)input.ReadEnum();
				break;
			case 26u:
				if (offset_ == null)
				{
					offset_ = new VectorInt3();
				}
				input.ReadMessage(offset_);
				break;
			case 32u:
				Size = input.ReadInt32();
				break;
			case 40u:
				Enable = input.ReadBool();
				break;
			}
		}
	}
}
