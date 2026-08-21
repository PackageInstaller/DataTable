using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class PostSpwanThrownEventInfo : IMessage<PostSpwanThrownEventInfo>, IMessage, IEquatable<PostSpwanThrownEventInfo>, IDeepCloneable<PostSpwanThrownEventInfo>
{
	private static readonly MessageParser<PostSpwanThrownEventInfo> _parser = new MessageParser<PostSpwanThrownEventInfo>(() => new PostSpwanThrownEventInfo());

	public const int StartFieldNumber = 1;

	private int start_;

	public const int IDFieldNumber = 2;

	private int iD_;

	public const int CenterOffsetFieldNumber = 3;

	private VectorInt3 centerOffset_;

	public const int SpawnForwardFieldNumber = 4;

	private VectorInt3 spawnForward_;

	public const int UseCommonFieldNumber = 5;

	private bool useCommon_;

	[DebuggerNonUserCode]
	public static MessageParser<PostSpwanThrownEventInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[46];

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
	public VectorInt3 CenterOffset
	{
		get
		{
			return centerOffset_;
		}
		set
		{
			centerOffset_ = value;
		}
	}

	[DebuggerNonUserCode]
	public VectorInt3 SpawnForward
	{
		get
		{
			return spawnForward_;
		}
		set
		{
			spawnForward_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool UseCommon
	{
		get
		{
			return useCommon_;
		}
		set
		{
			useCommon_ = value;
		}
	}

	[DebuggerNonUserCode]
	public PostSpwanThrownEventInfo()
	{
	}

	[DebuggerNonUserCode]
	public PostSpwanThrownEventInfo(PostSpwanThrownEventInfo other)
		: this()
	{
		start_ = other.start_;
		iD_ = other.iD_;
		CenterOffset = ((other.centerOffset_ != null) ? other.CenterOffset.Clone() : null);
		SpawnForward = ((other.spawnForward_ != null) ? other.SpawnForward.Clone() : null);
		useCommon_ = other.useCommon_;
	}

	[DebuggerNonUserCode]
	public PostSpwanThrownEventInfo Clone()
	{
		return new PostSpwanThrownEventInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PostSpwanThrownEventInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(PostSpwanThrownEventInfo other)
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
		if (!object.Equals(CenterOffset, other.CenterOffset))
		{
			return false;
		}
		if (!object.Equals(SpawnForward, other.SpawnForward))
		{
			return false;
		}
		if (UseCommon != other.UseCommon)
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
		if (centerOffset_ != null)
		{
			num ^= CenterOffset.GetHashCode();
		}
		if (spawnForward_ != null)
		{
			num ^= SpawnForward.GetHashCode();
		}
		if (UseCommon)
		{
			num ^= UseCommon.GetHashCode();
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
		if (centerOffset_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(CenterOffset);
		}
		if (spawnForward_ != null)
		{
			output.WriteRawTag(34);
			output.WriteMessage(SpawnForward);
		}
		if (UseCommon)
		{
			output.WriteRawTag(40);
			output.WriteBool(UseCommon);
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
		if (centerOffset_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(CenterOffset);
		}
		if (spawnForward_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(SpawnForward);
		}
		if (UseCommon)
		{
			num += 2;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PostSpwanThrownEventInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Start != 0)
		{
			Start = other.Start;
		}
		if (other.ID != 0)
		{
			ID = other.ID;
		}
		if (other.centerOffset_ != null)
		{
			if (centerOffset_ == null)
			{
				centerOffset_ = new VectorInt3();
			}
			CenterOffset.MergeFrom(other.CenterOffset);
		}
		if (other.spawnForward_ != null)
		{
			if (spawnForward_ == null)
			{
				spawnForward_ = new VectorInt3();
			}
			SpawnForward.MergeFrom(other.SpawnForward);
		}
		if (other.UseCommon)
		{
			UseCommon = other.UseCommon;
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
			case 26u:
				if (centerOffset_ == null)
				{
					centerOffset_ = new VectorInt3();
				}
				input.ReadMessage(centerOffset_);
				break;
			case 34u:
				if (spawnForward_ == null)
				{
					spawnForward_ = new VectorInt3();
				}
				input.ReadMessage(spawnForward_);
				break;
			case 40u:
				UseCommon = input.ReadBool();
				break;
			}
		}
	}
}
