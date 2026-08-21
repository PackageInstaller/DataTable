using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class RoleVoice : IMessage<RoleVoice>, IMessage, IEquatable<RoleVoice>, IDeepCloneable<RoleVoice>
{
	private static readonly MessageParser<RoleVoice> _parser = new MessageParser<RoleVoice>(() => new RoleVoice());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int AudioIDFieldNumber = 2;

	private int audioID_;

	public const int ContentFieldNumber = 3;

	private int content_;

	public const int CdFieldNumber = 4;

	private int cd_;

	public const int InfluenceIdFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_influenceId_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> influenceId_ = new RepeatedField<int>();

	public const int AddTimeFieldNumber = 6;

	private int addTime_;

	[DebuggerNonUserCode]
	public static MessageParser<RoleVoice> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[49];

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
	public int AudioID
	{
		get
		{
			return audioID_;
		}
		set
		{
			audioID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Content
	{
		get
		{
			return content_;
		}
		set
		{
			content_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Cd
	{
		get
		{
			return cd_;
		}
		set
		{
			cd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> InfluenceId => influenceId_;

	[DebuggerNonUserCode]
	public int AddTime
	{
		get
		{
			return addTime_;
		}
		set
		{
			addTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RoleVoice()
	{
	}

	[DebuggerNonUserCode]
	public RoleVoice(RoleVoice other)
		: this()
	{
		iD_ = other.iD_;
		audioID_ = other.audioID_;
		content_ = other.content_;
		cd_ = other.cd_;
		influenceId_ = other.influenceId_.Clone();
		addTime_ = other.addTime_;
	}

	[DebuggerNonUserCode]
	public RoleVoice Clone()
	{
		return new RoleVoice(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as RoleVoice);
	}

	[DebuggerNonUserCode]
	public bool Equals(RoleVoice other)
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
		if (AudioID != other.AudioID)
		{
			return false;
		}
		if (Content != other.Content)
		{
			return false;
		}
		if (Cd != other.Cd)
		{
			return false;
		}
		if (!influenceId_.Equals(other.influenceId_))
		{
			return false;
		}
		if (AddTime != other.AddTime)
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
		if (AudioID != 0)
		{
			num ^= AudioID.GetHashCode();
		}
		if (Content != 0)
		{
			num ^= Content.GetHashCode();
		}
		if (Cd != 0)
		{
			num ^= Cd.GetHashCode();
		}
		num ^= influenceId_.GetHashCode();
		if (AddTime != 0)
		{
			num ^= AddTime.GetHashCode();
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
		if (AudioID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(AudioID);
		}
		if (Content != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Content);
		}
		if (Cd != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Cd);
		}
		influenceId_.WriteTo(output, _repeated_influenceId_codec);
		if (AddTime != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(AddTime);
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
		if (AudioID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AudioID);
		}
		if (Content != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Content);
		}
		if (Cd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cd);
		}
		num += influenceId_.CalculateSize(_repeated_influenceId_codec);
		if (AddTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AddTime);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(RoleVoice other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.AudioID != 0)
			{
				AudioID = other.AudioID;
			}
			if (other.Content != 0)
			{
				Content = other.Content;
			}
			if (other.Cd != 0)
			{
				Cd = other.Cd;
			}
			influenceId_.Add(other.influenceId_);
			if (other.AddTime != 0)
			{
				AddTime = other.AddTime;
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
				AudioID = input.ReadInt32();
				break;
			case 24u:
				Content = input.ReadInt32();
				break;
			case 32u:
				Cd = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				influenceId_.AddEntriesFrom(input, _repeated_influenceId_codec);
				break;
			case 48u:
				AddTime = input.ReadInt32();
				break;
			}
		}
	}
}
