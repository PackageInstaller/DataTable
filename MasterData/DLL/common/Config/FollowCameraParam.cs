using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class FollowCameraParam : IMessage<FollowCameraParam>, IMessage, IEquatable<FollowCameraParam>, IDeepCloneable<FollowCameraParam>
{
	private static readonly MessageParser<FollowCameraParam> _parser = new MessageParser<FollowCameraParam>(() => new FollowCameraParam());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int FollowHeightFieldNumber = 2;

	private float followHeight_;

	public const int FollowRadiusFieldNumber = 3;

	private float followRadius_;

	public const int LockHeightFieldNumber = 4;

	private float lockHeight_;

	public const int LockRadiusFieldNumber = 5;

	private float lockRadius_;

	public const int OffsetXFieldNumber = 6;

	private float offsetX_;

	public const int OffsetYFieldNumber = 7;

	private float offsetY_;

	public const int OffsetZFieldNumber = 8;

	private float offsetZ_;

	public const int RemarkFieldNumber = 9;

	private string remark_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<FollowCameraParam> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[28];

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
	public float FollowHeight
	{
		get
		{
			return followHeight_;
		}
		set
		{
			followHeight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float FollowRadius
	{
		get
		{
			return followRadius_;
		}
		set
		{
			followRadius_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float LockHeight
	{
		get
		{
			return lockHeight_;
		}
		set
		{
			lockHeight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float LockRadius
	{
		get
		{
			return lockRadius_;
		}
		set
		{
			lockRadius_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float OffsetX
	{
		get
		{
			return offsetX_;
		}
		set
		{
			offsetX_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float OffsetY
	{
		get
		{
			return offsetY_;
		}
		set
		{
			offsetY_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float OffsetZ
	{
		get
		{
			return offsetZ_;
		}
		set
		{
			offsetZ_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Remark
	{
		get
		{
			return remark_;
		}
		set
		{
			remark_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public FollowCameraParam()
	{
	}

	[DebuggerNonUserCode]
	public FollowCameraParam(FollowCameraParam other)
		: this()
	{
		iD_ = other.iD_;
		followHeight_ = other.followHeight_;
		followRadius_ = other.followRadius_;
		lockHeight_ = other.lockHeight_;
		lockRadius_ = other.lockRadius_;
		offsetX_ = other.offsetX_;
		offsetY_ = other.offsetY_;
		offsetZ_ = other.offsetZ_;
		remark_ = other.remark_;
	}

	[DebuggerNonUserCode]
	public FollowCameraParam Clone()
	{
		return new FollowCameraParam(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as FollowCameraParam);
	}

	[DebuggerNonUserCode]
	public bool Equals(FollowCameraParam other)
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
		if (FollowHeight != other.FollowHeight)
		{
			return false;
		}
		if (FollowRadius != other.FollowRadius)
		{
			return false;
		}
		if (LockHeight != other.LockHeight)
		{
			return false;
		}
		if (LockRadius != other.LockRadius)
		{
			return false;
		}
		if (OffsetX != other.OffsetX)
		{
			return false;
		}
		if (OffsetY != other.OffsetY)
		{
			return false;
		}
		if (OffsetZ != other.OffsetZ)
		{
			return false;
		}
		if (Remark != other.Remark)
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
		if (FollowHeight != 0f)
		{
			num ^= FollowHeight.GetHashCode();
		}
		if (FollowRadius != 0f)
		{
			num ^= FollowRadius.GetHashCode();
		}
		if (LockHeight != 0f)
		{
			num ^= LockHeight.GetHashCode();
		}
		if (LockRadius != 0f)
		{
			num ^= LockRadius.GetHashCode();
		}
		if (OffsetX != 0f)
		{
			num ^= OffsetX.GetHashCode();
		}
		if (OffsetY != 0f)
		{
			num ^= OffsetY.GetHashCode();
		}
		if (OffsetZ != 0f)
		{
			num ^= OffsetZ.GetHashCode();
		}
		if (Remark.Length != 0)
		{
			num ^= Remark.GetHashCode();
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
		if (FollowHeight != 0f)
		{
			output.WriteRawTag(21);
			output.WriteFloat(FollowHeight);
		}
		if (FollowRadius != 0f)
		{
			output.WriteRawTag(29);
			output.WriteFloat(FollowRadius);
		}
		if (LockHeight != 0f)
		{
			output.WriteRawTag(37);
			output.WriteFloat(LockHeight);
		}
		if (LockRadius != 0f)
		{
			output.WriteRawTag(45);
			output.WriteFloat(LockRadius);
		}
		if (OffsetX != 0f)
		{
			output.WriteRawTag(53);
			output.WriteFloat(OffsetX);
		}
		if (OffsetY != 0f)
		{
			output.WriteRawTag(61);
			output.WriteFloat(OffsetY);
		}
		if (OffsetZ != 0f)
		{
			output.WriteRawTag(69);
			output.WriteFloat(OffsetZ);
		}
		if (Remark.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Remark);
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
		if (FollowHeight != 0f)
		{
			num += 5;
		}
		if (FollowRadius != 0f)
		{
			num += 5;
		}
		if (LockHeight != 0f)
		{
			num += 5;
		}
		if (LockRadius != 0f)
		{
			num += 5;
		}
		if (OffsetX != 0f)
		{
			num += 5;
		}
		if (OffsetY != 0f)
		{
			num += 5;
		}
		if (OffsetZ != 0f)
		{
			num += 5;
		}
		if (Remark.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Remark);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(FollowCameraParam other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.FollowHeight != 0f)
			{
				FollowHeight = other.FollowHeight;
			}
			if (other.FollowRadius != 0f)
			{
				FollowRadius = other.FollowRadius;
			}
			if (other.LockHeight != 0f)
			{
				LockHeight = other.LockHeight;
			}
			if (other.LockRadius != 0f)
			{
				LockRadius = other.LockRadius;
			}
			if (other.OffsetX != 0f)
			{
				OffsetX = other.OffsetX;
			}
			if (other.OffsetY != 0f)
			{
				OffsetY = other.OffsetY;
			}
			if (other.OffsetZ != 0f)
			{
				OffsetZ = other.OffsetZ;
			}
			if (other.Remark.Length != 0)
			{
				Remark = other.Remark;
			}
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
			case 21u:
				FollowHeight = input.ReadFloat();
				break;
			case 29u:
				FollowRadius = input.ReadFloat();
				break;
			case 37u:
				LockHeight = input.ReadFloat();
				break;
			case 45u:
				LockRadius = input.ReadFloat();
				break;
			case 53u:
				OffsetX = input.ReadFloat();
				break;
			case 61u:
				OffsetY = input.ReadFloat();
				break;
			case 69u:
				OffsetZ = input.ReadFloat();
				break;
			case 74u:
				Remark = input.ReadString();
				break;
			}
		}
	}
}
