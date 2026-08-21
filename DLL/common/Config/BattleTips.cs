using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class BattleTips : IMessage<BattleTips>, IMessage, IEquatable<BattleTips>, IDeepCloneable<BattleTips>
{
	private static readonly MessageParser<BattleTips> _parser = new MessageParser<BattleTips>(() => new BattleTips());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int ContentFieldNumber = 2;

	private string content_ = "";

	public const int ContentEnFieldNumber = 3;

	private string contentEn_ = "";

	public const int ContentJpFieldNumber = 4;

	private string contentJp_ = "";

	public const int ContentKrFieldNumber = 5;

	private string contentKr_ = "";

	public const int ContentTcFieldNumber = 6;

	private string contentTc_ = "";

	public const int ContentDeFieldNumber = 7;

	private string contentDe_ = "";

	public const int ContentFrFieldNumber = 8;

	private string contentFr_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<BattleTips> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[16];

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
	public string ContentEn
	{
		get
		{
			return contentEn_;
		}
		set
		{
			contentEn_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ContentJp
	{
		get
		{
			return contentJp_;
		}
		set
		{
			contentJp_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ContentKr
	{
		get
		{
			return contentKr_;
		}
		set
		{
			contentKr_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ContentTc
	{
		get
		{
			return contentTc_;
		}
		set
		{
			contentTc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ContentDe
	{
		get
		{
			return contentDe_;
		}
		set
		{
			contentDe_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ContentFr
	{
		get
		{
			return contentFr_;
		}
		set
		{
			contentFr_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public BattleTips()
	{
	}

	[DebuggerNonUserCode]
	public BattleTips(BattleTips other)
		: this()
	{
		iD_ = other.iD_;
		content_ = other.content_;
		contentEn_ = other.contentEn_;
		contentJp_ = other.contentJp_;
		contentKr_ = other.contentKr_;
		contentTc_ = other.contentTc_;
		contentDe_ = other.contentDe_;
		contentFr_ = other.contentFr_;
	}

	[DebuggerNonUserCode]
	public BattleTips Clone()
	{
		return new BattleTips(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BattleTips);
	}

	[DebuggerNonUserCode]
	public bool Equals(BattleTips other)
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
		if (Content != other.Content)
		{
			return false;
		}
		if (ContentEn != other.ContentEn)
		{
			return false;
		}
		if (ContentJp != other.ContentJp)
		{
			return false;
		}
		if (ContentKr != other.ContentKr)
		{
			return false;
		}
		if (ContentTc != other.ContentTc)
		{
			return false;
		}
		if (ContentDe != other.ContentDe)
		{
			return false;
		}
		if (ContentFr != other.ContentFr)
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
		if (Content.Length != 0)
		{
			num ^= Content.GetHashCode();
		}
		if (ContentEn.Length != 0)
		{
			num ^= ContentEn.GetHashCode();
		}
		if (ContentJp.Length != 0)
		{
			num ^= ContentJp.GetHashCode();
		}
		if (ContentKr.Length != 0)
		{
			num ^= ContentKr.GetHashCode();
		}
		if (ContentTc.Length != 0)
		{
			num ^= ContentTc.GetHashCode();
		}
		if (ContentDe.Length != 0)
		{
			num ^= ContentDe.GetHashCode();
		}
		if (ContentFr.Length != 0)
		{
			num ^= ContentFr.GetHashCode();
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
		if (Content.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Content);
		}
		if (ContentEn.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(ContentEn);
		}
		if (ContentJp.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(ContentJp);
		}
		if (ContentKr.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(ContentKr);
		}
		if (ContentTc.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(ContentTc);
		}
		if (ContentDe.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(ContentDe);
		}
		if (ContentFr.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(ContentFr);
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
		if (Content.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Content);
		}
		if (ContentEn.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ContentEn);
		}
		if (ContentJp.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ContentJp);
		}
		if (ContentKr.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ContentKr);
		}
		if (ContentTc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ContentTc);
		}
		if (ContentDe.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ContentDe);
		}
		if (ContentFr.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ContentFr);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BattleTips other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Content.Length != 0)
			{
				Content = other.Content;
			}
			if (other.ContentEn.Length != 0)
			{
				ContentEn = other.ContentEn;
			}
			if (other.ContentJp.Length != 0)
			{
				ContentJp = other.ContentJp;
			}
			if (other.ContentKr.Length != 0)
			{
				ContentKr = other.ContentKr;
			}
			if (other.ContentTc.Length != 0)
			{
				ContentTc = other.ContentTc;
			}
			if (other.ContentDe.Length != 0)
			{
				ContentDe = other.ContentDe;
			}
			if (other.ContentFr.Length != 0)
			{
				ContentFr = other.ContentFr;
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
				Content = input.ReadString();
				break;
			case 26u:
				ContentEn = input.ReadString();
				break;
			case 34u:
				ContentJp = input.ReadString();
				break;
			case 42u:
				ContentKr = input.ReadString();
				break;
			case 50u:
				ContentTc = input.ReadString();
				break;
			case 58u:
				ContentDe = input.ReadString();
				break;
			case 66u:
				ContentFr = input.ReadString();
				break;
			}
		}
	}
}
