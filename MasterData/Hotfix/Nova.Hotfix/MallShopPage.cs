using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MallShopPage : IMessage<MallShopPage>, IMessage, IEquatable<MallShopPage>, IDeepCloneable<MallShopPage>
{
	private static readonly MessageParser<MallShopPage> _parser = new MessageParser<MallShopPage>(() => new MallShopPage());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SortFieldNumber = 2;

	private int sort_;

	public const int NameFieldNumber = 3;

	private string name_ = "";

	public const int RefreshTimeTypeFieldNumber = 4;

	private int refreshTimeType_;

	public const int ShopCoinFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_shopCoin_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> shopCoin_ = new RepeatedField<int>();

	public const int ListTimeFieldNumber = 6;

	private string listTime_ = "";

	public const int DeListTimeFieldNumber = 7;

	private string deListTime_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<MallShopPage> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(528);

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
	public int Sort
	{
		get
		{
			return sort_;
		}
		set
		{
			sort_ = value;
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
	public int RefreshTimeType
	{
		get
		{
			return refreshTimeType_;
		}
		set
		{
			refreshTimeType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ShopCoin => shopCoin_;

	[DebuggerNonUserCode]
	public string ListTime
	{
		get
		{
			return listTime_;
		}
		set
		{
			listTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string DeListTime
	{
		get
		{
			return deListTime_;
		}
		set
		{
			deListTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public MallShopPage()
	{
	}

	[DebuggerNonUserCode]
	public MallShopPage(MallShopPage other)
		: this()
	{
		id_ = other.id_;
		sort_ = other.sort_;
		name_ = other.name_;
		refreshTimeType_ = other.refreshTimeType_;
		shopCoin_ = other.shopCoin_.Clone();
		listTime_ = other.listTime_;
		deListTime_ = other.deListTime_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MallShopPage Clone()
	{
		return new MallShopPage(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MallShopPage);
	}

	[DebuggerNonUserCode]
	public bool Equals(MallShopPage other)
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
		if (Sort != other.Sort)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (RefreshTimeType != other.RefreshTimeType)
		{
			return false;
		}
		if (!shopCoin_.Equals(other.shopCoin_))
		{
			return false;
		}
		if (ListTime != other.ListTime)
		{
			return false;
		}
		if (DeListTime != other.DeListTime)
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
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (RefreshTimeType != 0)
		{
			num ^= RefreshTimeType.GetHashCode();
		}
		num ^= shopCoin_.GetHashCode();
		if (ListTime.Length != 0)
		{
			num ^= ListTime.GetHashCode();
		}
		if (DeListTime.Length != 0)
		{
			num ^= DeListTime.GetHashCode();
		}
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
		if (Sort != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Sort);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Name);
		}
		if (RefreshTimeType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(RefreshTimeType);
		}
		shopCoin_.WriteTo(output, _repeated_shopCoin_codec);
		if (ListTime.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(ListTime);
		}
		if (DeListTime.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(DeListTime);
		}
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
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (RefreshTimeType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RefreshTimeType);
		}
		num += shopCoin_.CalculateSize(_repeated_shopCoin_codec);
		if (ListTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ListTime);
		}
		if (DeListTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DeListTime);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MallShopPage other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.RefreshTimeType != 0)
			{
				RefreshTimeType = other.RefreshTimeType;
			}
			shopCoin_.Add(other.shopCoin_);
			if (other.ListTime.Length != 0)
			{
				ListTime = other.ListTime;
			}
			if (other.DeListTime.Length != 0)
			{
				DeListTime = other.DeListTime;
			}
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
				Sort = input.ReadInt32();
				break;
			case 26u:
				Name = input.ReadString();
				break;
			case 32u:
				RefreshTimeType = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				shopCoin_.AddEntriesFrom(input, _repeated_shopCoin_codec);
				break;
			case 50u:
				ListTime = input.ReadString();
				break;
			case 58u:
				DeListTime = input.ReadString();
				break;
			}
		}
	}
}
