using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class LockedCameraParam : IMessage<LockedCameraParam>, IMessage, IEquatable<LockedCameraParam>, IDeepCloneable<LockedCameraParam>
{
	private static readonly MessageParser<LockedCameraParam> _parser = new MessageParser<LockedCameraParam>(() => new LockedCameraParam());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int LockHeightFieldNumber = 2;

	private float lockHeight_;

	public const int LockRadiusFieldNumber = 3;

	private float lockRadius_;

	public const int ScreenYFieldNumber = 4;

	private float screenY_;

	public const int RemarkFieldNumber = 5;

	private string remark_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<LockedCameraParam> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[40];

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
	public float ScreenY
	{
		get
		{
			return screenY_;
		}
		set
		{
			screenY_ = value;
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
	public LockedCameraParam()
	{
	}

	[DebuggerNonUserCode]
	public LockedCameraParam(LockedCameraParam other)
		: this()
	{
		iD_ = other.iD_;
		lockHeight_ = other.lockHeight_;
		lockRadius_ = other.lockRadius_;
		screenY_ = other.screenY_;
		remark_ = other.remark_;
	}

	[DebuggerNonUserCode]
	public LockedCameraParam Clone()
	{
		return new LockedCameraParam(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as LockedCameraParam);
	}

	[DebuggerNonUserCode]
	public bool Equals(LockedCameraParam other)
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
		if (LockHeight != other.LockHeight)
		{
			return false;
		}
		if (LockRadius != other.LockRadius)
		{
			return false;
		}
		if (ScreenY != other.ScreenY)
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
		if (LockHeight != 0f)
		{
			num ^= LockHeight.GetHashCode();
		}
		if (LockRadius != 0f)
		{
			num ^= LockRadius.GetHashCode();
		}
		if (ScreenY != 0f)
		{
			num ^= ScreenY.GetHashCode();
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
		if (LockHeight != 0f)
		{
			output.WriteRawTag(21);
			output.WriteFloat(LockHeight);
		}
		if (LockRadius != 0f)
		{
			output.WriteRawTag(29);
			output.WriteFloat(LockRadius);
		}
		if (ScreenY != 0f)
		{
			output.WriteRawTag(37);
			output.WriteFloat(ScreenY);
		}
		if (Remark.Length != 0)
		{
			output.WriteRawTag(42);
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
		if (LockHeight != 0f)
		{
			num += 5;
		}
		if (LockRadius != 0f)
		{
			num += 5;
		}
		if (ScreenY != 0f)
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
	public void MergeFrom(LockedCameraParam other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.LockHeight != 0f)
			{
				LockHeight = other.LockHeight;
			}
			if (other.LockRadius != 0f)
			{
				LockRadius = other.LockRadius;
			}
			if (other.ScreenY != 0f)
			{
				ScreenY = other.ScreenY;
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
				LockHeight = input.ReadFloat();
				break;
			case 29u:
				LockRadius = input.ReadFloat();
				break;
			case 37u:
				ScreenY = input.ReadFloat();
				break;
			case 42u:
				Remark = input.ReadString();
				break;
			}
		}
	}
}
