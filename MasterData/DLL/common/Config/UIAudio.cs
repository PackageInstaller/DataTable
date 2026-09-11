using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class UIAudio : IMessage<UIAudio>, IMessage, IEquatable<UIAudio>, IDeepCloneable<UIAudio>
{
	private static readonly MessageParser<UIAudio> _parser = new MessageParser<UIAudio>(() => new UIAudio());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int SourceKeyFieldNumber = 2;

	private string sourceKey_ = "";

	public const int AudioIDFieldNumber = 3;

	private int audioID_;

	public const int DescribeFieldNumber = 4;

	private string describe_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<UIAudio> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[67];

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
	public string SourceKey
	{
		get
		{
			return sourceKey_;
		}
		set
		{
			sourceKey_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string Describe
	{
		get
		{
			return describe_;
		}
		set
		{
			describe_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public UIAudio()
	{
	}

	[DebuggerNonUserCode]
	public UIAudio(UIAudio other)
		: this()
	{
		iD_ = other.iD_;
		sourceKey_ = other.sourceKey_;
		audioID_ = other.audioID_;
		describe_ = other.describe_;
	}

	[DebuggerNonUserCode]
	public UIAudio Clone()
	{
		return new UIAudio(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as UIAudio);
	}

	[DebuggerNonUserCode]
	public bool Equals(UIAudio other)
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
		if (SourceKey != other.SourceKey)
		{
			return false;
		}
		if (AudioID != other.AudioID)
		{
			return false;
		}
		if (Describe != other.Describe)
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
		if (SourceKey.Length != 0)
		{
			num ^= SourceKey.GetHashCode();
		}
		if (AudioID != 0)
		{
			num ^= AudioID.GetHashCode();
		}
		if (Describe.Length != 0)
		{
			num ^= Describe.GetHashCode();
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
		if (SourceKey.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(SourceKey);
		}
		if (AudioID != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(AudioID);
		}
		if (Describe.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Describe);
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
		if (SourceKey.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SourceKey);
		}
		if (AudioID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AudioID);
		}
		if (Describe.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Describe);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(UIAudio other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.SourceKey.Length != 0)
			{
				SourceKey = other.SourceKey;
			}
			if (other.AudioID != 0)
			{
				AudioID = other.AudioID;
			}
			if (other.Describe.Length != 0)
			{
				Describe = other.Describe;
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
			case 18u:
				SourceKey = input.ReadString();
				break;
			case 24u:
				AudioID = input.ReadInt32();
				break;
			case 34u:
				Describe = input.ReadString();
				break;
			}
		}
	}
}
