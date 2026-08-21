using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class CommonEffect : IMessage<CommonEffect>, IMessage, IEquatable<CommonEffect>, IDeepCloneable<CommonEffect>
{
	private static readonly MessageParser<CommonEffect> _parser = new MessageParser<CommonEffect>(() => new CommonEffect());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int PathFieldNumber = 2;

	private string path_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<CommonEffect> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[25];

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
	public CommonEffect()
	{
	}

	[DebuggerNonUserCode]
	public CommonEffect(CommonEffect other)
		: this()
	{
		iD_ = other.iD_;
		path_ = other.path_;
	}

	[DebuggerNonUserCode]
	public CommonEffect Clone()
	{
		return new CommonEffect(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CommonEffect);
	}

	[DebuggerNonUserCode]
	public bool Equals(CommonEffect other)
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
		if (Path.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Path);
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
		if (Path.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Path);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CommonEffect other)
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
			}
		}
	}
}
