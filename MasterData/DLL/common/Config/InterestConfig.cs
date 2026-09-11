using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class InterestConfig : IMessage<InterestConfig>, IMessage, IEquatable<InterestConfig>, IDeepCloneable<InterestConfig>
{
	private static readonly MessageParser<InterestConfig> _parser = new MessageParser<InterestConfig>(() => new InterestConfig());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int GroupFieldNumber = 2;

	private static readonly FieldCodec<RoleType> _repeated_group_codec = FieldCodec.ForEnum(18u, (RoleType x) => (int)x, (int x) => (RoleType)x);

	private readonly RepeatedField<RoleType> group_ = new RepeatedField<RoleType>();

	[DebuggerNonUserCode]
	public static MessageParser<InterestConfig> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[34];

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
	public RepeatedField<RoleType> Group => group_;

	[DebuggerNonUserCode]
	public InterestConfig()
	{
	}

	[DebuggerNonUserCode]
	public InterestConfig(InterestConfig other)
		: this()
	{
		iD_ = other.iD_;
		group_ = other.group_.Clone();
	}

	[DebuggerNonUserCode]
	public InterestConfig Clone()
	{
		return new InterestConfig(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as InterestConfig);
	}

	[DebuggerNonUserCode]
	public bool Equals(InterestConfig other)
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
		if (!group_.Equals(other.group_))
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
		return num ^ group_.GetHashCode();
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
		group_.WriteTo(output, _repeated_group_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		return num + group_.CalculateSize(_repeated_group_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(InterestConfig other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			group_.Add(other.group_);
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
			case 18u:
				group_.AddEntriesFrom(input, _repeated_group_codec);
				break;
			}
		}
	}
}
