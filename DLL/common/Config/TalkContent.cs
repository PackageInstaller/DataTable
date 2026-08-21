using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class TalkContent : IMessage<TalkContent>, IMessage, IEquatable<TalkContent>, IDeepCloneable<TalkContent>
{
	private static readonly MessageParser<TalkContent> _parser = new MessageParser<TalkContent>(() => new TalkContent());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int SpeakerFieldNumber = 2;

	private string speaker_ = "";

	public const int ContentFieldNumber = 3;

	private string content_ = "";

	public const int DeltaFieldNumber = 4;

	private int delta_;

	[DebuggerNonUserCode]
	public static MessageParser<TalkContent> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[60];

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
	public string Speaker
	{
		get
		{
			return speaker_;
		}
		set
		{
			speaker_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Content
	{
		get
		{
			return content_;
		}
		set
		{
			content_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Delta
	{
		get
		{
			return delta_;
		}
		set
		{
			delta_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TalkContent()
	{
	}

	[DebuggerNonUserCode]
	public TalkContent(TalkContent other)
		: this()
	{
		iD_ = other.iD_;
		speaker_ = other.speaker_;
		content_ = other.content_;
		delta_ = other.delta_;
	}

	[DebuggerNonUserCode]
	public TalkContent Clone()
	{
		return new TalkContent(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TalkContent);
	}

	[DebuggerNonUserCode]
	public bool Equals(TalkContent other)
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
		if (Speaker != other.Speaker)
		{
			return false;
		}
		if (Content != other.Content)
		{
			return false;
		}
		if (Delta != other.Delta)
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
		if (Speaker.Length != 0)
		{
			num ^= Speaker.GetHashCode();
		}
		if (Content.Length != 0)
		{
			num ^= Content.GetHashCode();
		}
		if (Delta != 0)
		{
			num ^= Delta.GetHashCode();
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
		if (Speaker.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Speaker);
		}
		if (Content.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Content);
		}
		if (Delta != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Delta);
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
		if (Speaker.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Speaker);
		}
		if (Content.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Content);
		}
		if (Delta != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Delta);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TalkContent other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Speaker.Length != 0)
			{
				Speaker = other.Speaker;
			}
			if (other.Content.Length != 0)
			{
				Content = other.Content;
			}
			if (other.Delta != 0)
			{
				Delta = other.Delta;
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
				Speaker = input.ReadString();
				break;
			case 26u:
				Content = input.ReadString();
				break;
			case 32u:
				Delta = input.ReadInt32();
				break;
			}
		}
	}
}
