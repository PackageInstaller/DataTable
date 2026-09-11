using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class SourceSpace : IMessage<SourceSpace>, IMessage, IEquatable<SourceSpace>, IDeepCloneable<SourceSpace>
{
	private static readonly MessageParser<SourceSpace> _parser = new MessageParser<SourceSpace>(() => new SourceSpace());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescribeFieldNumber = 3;

	private string describe_ = "";

	public const int PrefabPathFieldNumber = 4;

	private string prefabPath_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<SourceSpace> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[57];

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
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string PrefabPath
	{
		get
		{
			return prefabPath_;
		}
		set
		{
			prefabPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public SourceSpace()
	{
	}

	[DebuggerNonUserCode]
	public SourceSpace(SourceSpace other)
		: this()
	{
		iD_ = other.iD_;
		name_ = other.name_;
		describe_ = other.describe_;
		prefabPath_ = other.prefabPath_;
	}

	[DebuggerNonUserCode]
	public SourceSpace Clone()
	{
		return new SourceSpace(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SourceSpace);
	}

	[DebuggerNonUserCode]
	public bool Equals(SourceSpace other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (Describe != other.Describe)
		{
			return false;
		}
		if (PrefabPath != other.PrefabPath)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Describe.Length != 0)
		{
			num ^= Describe.GetHashCode();
		}
		if (PrefabPath.Length != 0)
		{
			num ^= PrefabPath.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (Describe.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Describe);
		}
		if (PrefabPath.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(PrefabPath);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Describe.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Describe);
		}
		if (PrefabPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PrefabPath);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SourceSpace other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Describe.Length != 0)
			{
				Describe = other.Describe;
			}
			if (other.PrefabPath.Length != 0)
			{
				PrefabPath = other.PrefabPath;
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
				Name = input.ReadString();
				break;
			case 26u:
				Describe = input.ReadString();
				break;
			case 34u:
				PrefabPath = input.ReadString();
				break;
			}
		}
	}
}
