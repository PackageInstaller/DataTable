using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class CameraTypeInfo : IMessage<CameraTypeInfo>, IMessage, IEquatable<CameraTypeInfo>, IDeepCloneable<CameraTypeInfo>
{
	private static readonly MessageParser<CameraTypeInfo> _parser = new MessageParser<CameraTypeInfo>(() => new CameraTypeInfo());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int StartFieldNumber = 2;

	private int start_;

	public const int DurationFieldNumber = 3;

	private int duration_;

	public const int CameraTypeFieldNumber = 4;

	private int cameraType_;

	public const int EndPositionFieldNumber = 5;

	private VectorInt3 endPosition_;

	[DebuggerNonUserCode]
	public static MessageParser<CameraTypeInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[20];

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
	public int Start
	{
		get
		{
			return start_;
		}
		set
		{
			start_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Duration
	{
		get
		{
			return duration_;
		}
		set
		{
			duration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CameraType
	{
		get
		{
			return cameraType_;
		}
		set
		{
			cameraType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public VectorInt3 EndPosition
	{
		get
		{
			return endPosition_;
		}
		set
		{
			endPosition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CameraTypeInfo()
	{
	}

	[DebuggerNonUserCode]
	public CameraTypeInfo(CameraTypeInfo other)
		: this()
	{
		iD_ = other.iD_;
		start_ = other.start_;
		duration_ = other.duration_;
		cameraType_ = other.cameraType_;
		EndPosition = ((other.endPosition_ != null) ? other.EndPosition.Clone() : null);
	}

	[DebuggerNonUserCode]
	public CameraTypeInfo Clone()
	{
		return new CameraTypeInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CameraTypeInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(CameraTypeInfo other)
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
		if (Start != other.Start)
		{
			return false;
		}
		if (Duration != other.Duration)
		{
			return false;
		}
		if (CameraType != other.CameraType)
		{
			return false;
		}
		if (!object.Equals(EndPosition, other.EndPosition))
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
		if (Start != 0)
		{
			num ^= Start.GetHashCode();
		}
		if (Duration != 0)
		{
			num ^= Duration.GetHashCode();
		}
		if (CameraType != 0)
		{
			num ^= CameraType.GetHashCode();
		}
		if (endPosition_ != null)
		{
			num ^= EndPosition.GetHashCode();
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
		if (Start != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Start);
		}
		if (Duration != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Duration);
		}
		if (CameraType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CameraType);
		}
		if (endPosition_ != null)
		{
			output.WriteRawTag(42);
			output.WriteMessage(EndPosition);
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
		if (Start != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Start);
		}
		if (Duration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Duration);
		}
		if (CameraType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CameraType);
		}
		if (endPosition_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(EndPosition);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CameraTypeInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.ID != 0)
		{
			ID = other.ID;
		}
		if (other.Start != 0)
		{
			Start = other.Start;
		}
		if (other.Duration != 0)
		{
			Duration = other.Duration;
		}
		if (other.CameraType != 0)
		{
			CameraType = other.CameraType;
		}
		if (other.endPosition_ != null)
		{
			if (endPosition_ == null)
			{
				endPosition_ = new VectorInt3();
			}
			EndPosition.MergeFrom(other.EndPosition);
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
				Start = input.ReadInt32();
				break;
			case 24u:
				Duration = input.ReadInt32();
				break;
			case 32u:
				CameraType = input.ReadInt32();
				break;
			case 42u:
				if (endPosition_ == null)
				{
					endPosition_ = new VectorInt3();
				}
				input.ReadMessage(endPosition_);
				break;
			}
		}
	}
}
