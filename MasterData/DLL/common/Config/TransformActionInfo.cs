using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class TransformActionInfo : IMessage<TransformActionInfo>, IMessage, IEquatable<TransformActionInfo>, IDeepCloneable<TransformActionInfo>
{
	private static readonly MessageParser<TransformActionInfo> _parser = new MessageParser<TransformActionInfo>(() => new TransformActionInfo());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int StartFieldNumber = 2;

	private int start_;

	public const int TransformRoleIDFieldNumber = 3;

	private int transformRoleID_;

	public const int TransformActionIDFieldNumber = 4;

	private int transformActionID_;

	[DebuggerNonUserCode]
	public static MessageParser<TransformActionInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[66];

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
	public int TransformRoleID
	{
		get
		{
			return transformRoleID_;
		}
		set
		{
			transformRoleID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TransformActionID
	{
		get
		{
			return transformActionID_;
		}
		set
		{
			transformActionID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TransformActionInfo()
	{
	}

	[DebuggerNonUserCode]
	public TransformActionInfo(TransformActionInfo other)
		: this()
	{
		iD_ = other.iD_;
		start_ = other.start_;
		transformRoleID_ = other.transformRoleID_;
		transformActionID_ = other.transformActionID_;
	}

	[DebuggerNonUserCode]
	public TransformActionInfo Clone()
	{
		return new TransformActionInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TransformActionInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(TransformActionInfo other)
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
		if (TransformRoleID != other.TransformRoleID)
		{
			return false;
		}
		if (TransformActionID != other.TransformActionID)
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
		if (TransformRoleID != 0)
		{
			num ^= TransformRoleID.GetHashCode();
		}
		if (TransformActionID != 0)
		{
			num ^= TransformActionID.GetHashCode();
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
		if (TransformRoleID != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(TransformRoleID);
		}
		if (TransformActionID != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(TransformActionID);
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
		if (TransformRoleID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TransformRoleID);
		}
		if (TransformActionID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TransformActionID);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TransformActionInfo other)
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
			if (other.TransformRoleID != 0)
			{
				TransformRoleID = other.TransformRoleID;
			}
			if (other.TransformActionID != 0)
			{
				TransformActionID = other.TransformActionID;
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
			case 16u:
				Start = input.ReadInt32();
				break;
			case 24u:
				TransformRoleID = input.ReadInt32();
				break;
			case 32u:
				TransformActionID = input.ReadInt32();
				break;
			}
		}
	}
}
