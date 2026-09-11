using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class PostDespawnThrownEventInfo : IMessage<PostDespawnThrownEventInfo>, IMessage, IEquatable<PostDespawnThrownEventInfo>, IDeepCloneable<PostDespawnThrownEventInfo>
{
	private static readonly MessageParser<PostDespawnThrownEventInfo> _parser = new MessageParser<PostDespawnThrownEventInfo>(() => new PostDespawnThrownEventInfo());

	public const int StartFieldNumber = 1;

	private int start_;

	public const int IDFieldNumber = 2;

	private int iD_;

	[DebuggerNonUserCode]
	public static MessageParser<PostDespawnThrownEventInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[45];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public PostDespawnThrownEventInfo()
	{
	}

	[DebuggerNonUserCode]
	public PostDespawnThrownEventInfo(PostDespawnThrownEventInfo other)
		: this()
	{
		start_ = other.start_;
		iD_ = other.iD_;
	}

	[DebuggerNonUserCode]
	public PostDespawnThrownEventInfo Clone()
	{
		return new PostDespawnThrownEventInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PostDespawnThrownEventInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(PostDespawnThrownEventInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Start != other.Start)
		{
			return false;
		}
		if (ID != other.ID)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Start != 0)
		{
			num ^= Start.GetHashCode();
		}
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
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
		if (Start != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Start);
		}
		if (ID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ID);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Start != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Start);
		}
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PostDespawnThrownEventInfo other)
	{
		if (other != null)
		{
			if (other.Start != 0)
			{
				Start = other.Start;
			}
			if (other.ID != 0)
			{
				ID = other.ID;
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
				Start = input.ReadInt32();
				break;
			case 16u:
				ID = input.ReadInt32();
				break;
			}
		}
	}
}
