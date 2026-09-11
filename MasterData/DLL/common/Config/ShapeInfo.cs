using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class ShapeInfo : IMessage<ShapeInfo>, IMessage, IEquatable<ShapeInfo>, IDeepCloneable<ShapeInfo>
{
	private static readonly MessageParser<ShapeInfo> _parser = new MessageParser<ShapeInfo>(() => new ShapeInfo());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int StartFieldNumber = 2;

	private int start_;

	public const int DurationFieldNumber = 3;

	private int duration_;

	public const int ShapeItemInfoListFieldNumber = 4;

	private static readonly FieldCodec<ShapeItemInfo> _repeated_shapeItemInfoList_codec = FieldCodec.ForMessage(34u, ShapeItemInfo.Parser);

	private readonly RepeatedField<ShapeItemInfo> shapeItemInfoList_ = new RepeatedField<ShapeItemInfo>();

	[DebuggerNonUserCode]
	public static MessageParser<ShapeInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[54];

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
	public RepeatedField<ShapeItemInfo> ShapeItemInfoList => shapeItemInfoList_;

	[DebuggerNonUserCode]
	public ShapeInfo()
	{
	}

	[DebuggerNonUserCode]
	public ShapeInfo(ShapeInfo other)
		: this()
	{
		iD_ = other.iD_;
		start_ = other.start_;
		duration_ = other.duration_;
		shapeItemInfoList_ = other.shapeItemInfoList_.Clone();
	}

	[DebuggerNonUserCode]
	public ShapeInfo Clone()
	{
		return new ShapeInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ShapeInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(ShapeInfo other)
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
		if (!shapeItemInfoList_.Equals(other.shapeItemInfoList_))
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
		return num ^ shapeItemInfoList_.GetHashCode();
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
		shapeItemInfoList_.WriteTo(output, _repeated_shapeItemInfoList_codec);
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
		return num + shapeItemInfoList_.CalculateSize(_repeated_shapeItemInfoList_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ShapeInfo other)
	{
		if (other != null)
		{
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
			shapeItemInfoList_.Add(other.shapeItemInfoList_);
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
			case 34u:
				shapeItemInfoList_.AddEntriesFrom(input, _repeated_shapeItemInfoList_codec);
				break;
			}
		}
	}
}
