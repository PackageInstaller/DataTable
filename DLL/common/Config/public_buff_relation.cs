using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class public_buff_relation : IMessage<public_buff_relation>, IMessage, IEquatable<public_buff_relation>, IDeepCloneable<public_buff_relation>
{
	private static readonly MessageParser<public_buff_relation> _parser = new MessageParser<public_buff_relation>(() => new public_buff_relation());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int RemoveSelfListFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_removeSelfList_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> removeSelfList_ = new RepeatedField<int>();

	public const int RemoveTogetherListFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_removeTogetherList_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> removeTogetherList_ = new RepeatedField<int>();

	public const int OverWriteListFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_overWriteList_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> overWriteList_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<public_buff_relation> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[89];

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
	public RepeatedField<int> RemoveSelfList => removeSelfList_;

	[DebuggerNonUserCode]
	public RepeatedField<int> RemoveTogetherList => removeTogetherList_;

	[DebuggerNonUserCode]
	public RepeatedField<int> OverWriteList => overWriteList_;

	[DebuggerNonUserCode]
	public public_buff_relation()
	{
	}

	[DebuggerNonUserCode]
	public public_buff_relation(public_buff_relation other)
		: this()
	{
		iD_ = other.iD_;
		removeSelfList_ = other.removeSelfList_.Clone();
		removeTogetherList_ = other.removeTogetherList_.Clone();
		overWriteList_ = other.overWriteList_.Clone();
	}

	[DebuggerNonUserCode]
	public public_buff_relation Clone()
	{
		return new public_buff_relation(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as public_buff_relation);
	}

	[DebuggerNonUserCode]
	public bool Equals(public_buff_relation other)
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
		if (!removeSelfList_.Equals(other.removeSelfList_))
		{
			return false;
		}
		if (!removeTogetherList_.Equals(other.removeTogetherList_))
		{
			return false;
		}
		if (!overWriteList_.Equals(other.overWriteList_))
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
		num ^= removeSelfList_.GetHashCode();
		num ^= removeTogetherList_.GetHashCode();
		return num ^ overWriteList_.GetHashCode();
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
		removeSelfList_.WriteTo(output, _repeated_removeSelfList_codec);
		removeTogetherList_.WriteTo(output, _repeated_removeTogetherList_codec);
		overWriteList_.WriteTo(output, _repeated_overWriteList_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		num += removeSelfList_.CalculateSize(_repeated_removeSelfList_codec);
		num += removeTogetherList_.CalculateSize(_repeated_removeTogetherList_codec);
		return num + overWriteList_.CalculateSize(_repeated_overWriteList_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(public_buff_relation other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			removeSelfList_.Add(other.removeSelfList_);
			removeTogetherList_.Add(other.removeTogetherList_);
			overWriteList_.Add(other.overWriteList_);
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
				removeSelfList_.AddEntriesFrom(input, _repeated_removeSelfList_codec);
				break;
			case 24u:
			case 26u:
				removeTogetherList_.AddEntriesFrom(input, _repeated_removeTogetherList_codec);
				break;
			case 32u:
			case 34u:
				overWriteList_.AddEntriesFrom(input, _repeated_overWriteList_codec);
				break;
			}
		}
	}
}
