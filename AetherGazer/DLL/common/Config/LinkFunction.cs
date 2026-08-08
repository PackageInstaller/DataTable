using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class LinkFunction : IMessage<LinkFunction>, IMessage, IEquatable<LinkFunction>, IDeepCloneable<LinkFunction>
{
	private static readonly MessageParser<LinkFunction> _parser = new MessageParser<LinkFunction>(() => new LinkFunction());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int PathFieldNumber = 2;

	private string path_ = "";

	public const int ExceptListFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_exceptList_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> exceptList_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<LinkFunction> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[37];

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
	public string Path
	{
		get
		{
			return path_;
		}
		set
		{
			path_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ExceptList => exceptList_;

	[DebuggerNonUserCode]
	public LinkFunction()
	{
	}

	[DebuggerNonUserCode]
	public LinkFunction(LinkFunction other)
		: this()
	{
		iD_ = other.iD_;
		path_ = other.path_;
		exceptList_ = other.exceptList_.Clone();
	}

	[DebuggerNonUserCode]
	public LinkFunction Clone()
	{
		return new LinkFunction(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as LinkFunction);
	}

	[DebuggerNonUserCode]
	public bool Equals(LinkFunction other)
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
		if (Path != other.Path)
		{
			return false;
		}
		if (!exceptList_.Equals(other.exceptList_))
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
		if (Path.Length != 0)
		{
			num ^= Path.GetHashCode();
		}
		return num ^ exceptList_.GetHashCode();
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
		if (Path.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Path);
		}
		exceptList_.WriteTo(output, _repeated_exceptList_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (Path.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Path);
		}
		return num + exceptList_.CalculateSize(_repeated_exceptList_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(LinkFunction other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Path.Length != 0)
			{
				Path = other.Path;
			}
			exceptList_.Add(other.exceptList_);
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
				Path = input.ReadString();
				break;
			case 24u:
			case 26u:
				exceptList_.AddEntriesFrom(input, _repeated_exceptList_codec);
				break;
			}
		}
	}
}
