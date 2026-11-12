using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityShopControl : IMessage<ActivityShopControl>, IMessage, IEquatable<ActivityShopControl>, IDeepCloneable<ActivityShopControl>
{
	private static readonly MessageParser<ActivityShopControl> _parser = new MessageParser<ActivityShopControl>(() => new ActivityShopControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ShopIdsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_shopIds_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> shopIds_ = new RepeatedField<int>();

	public const int NpcFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_npc_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> npc_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<ActivityShopControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(56);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ShopIds => shopIds_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Npc => npc_;

	[DebuggerNonUserCode]
	public ActivityShopControl()
	{
	}

	[DebuggerNonUserCode]
	public ActivityShopControl(ActivityShopControl other)
		: this()
	{
		id_ = other.id_;
		shopIds_ = other.shopIds_.Clone();
		npc_ = other.npc_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityShopControl Clone()
	{
		return new ActivityShopControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityShopControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityShopControl other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (!shopIds_.Equals(other.shopIds_))
		{
			return false;
		}
		if (!npc_.Equals(other.npc_))
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		num ^= shopIds_.GetHashCode();
		num ^= npc_.GetHashCode();
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		shopIds_.WriteTo(output, _repeated_shopIds_codec);
		npc_.WriteTo(output, _repeated_npc_codec);
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		num += shopIds_.CalculateSize(_repeated_shopIds_codec);
		num += npc_.CalculateSize(_repeated_npc_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityShopControl other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			shopIds_.Add(other.shopIds_);
			npc_.Add(other.npc_);
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
			case 18u:
				shopIds_.AddEntriesFrom(input, _repeated_shopIds_codec);
				break;
			case 24u:
			case 26u:
				npc_.AddEntriesFrom(input, _repeated_npc_codec);
				break;
			}
		}
	}
}
