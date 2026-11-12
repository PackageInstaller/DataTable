using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TopBar : IMessage<TopBar>, IMessage, IEquatable<TopBar>, IDeepCloneable<TopBar>
{
	private static readonly MessageParser<TopBar> _parser = new MessageParser<TopBar>(() => new TopBar());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private string id_ = "";

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int EntryIdFieldNumber = 3;

	private int entryId_;

	public const int HideBackFieldNumber = 4;

	private bool hideBack_;

	public const int EnergyFieldNumber = 5;

	private bool energy_;

	public const int CoinFieldNumber = 6;

	private bool coin_;

	public const int CoinIdsFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_coinIds_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> coinIds_ = new RepeatedField<int>();

	public const int HideCoinAddFieldNumber = 8;

	private bool hideCoinAdd_;

	public const int DelayShowFieldNumber = 9;

	private bool delayShow_;

	public const int HideHomeFieldNumber = 10;

	private bool hideHome_;

	[DebuggerNonUserCode]
	public static MessageParser<TopBar> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(942);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public string Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int EntryId
	{
		get
		{
			return entryId_;
		}
		set
		{
			entryId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool HideBack
	{
		get
		{
			return hideBack_;
		}
		set
		{
			hideBack_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Energy
	{
		get
		{
			return energy_;
		}
		set
		{
			energy_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Coin
	{
		get
		{
			return coin_;
		}
		set
		{
			coin_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> CoinIds => coinIds_;

	[DebuggerNonUserCode]
	public bool HideCoinAdd
	{
		get
		{
			return hideCoinAdd_;
		}
		set
		{
			hideCoinAdd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool DelayShow
	{
		get
		{
			return delayShow_;
		}
		set
		{
			delayShow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool HideHome
	{
		get
		{
			return hideHome_;
		}
		set
		{
			hideHome_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TopBar()
	{
	}

	[DebuggerNonUserCode]
	public TopBar(TopBar other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		entryId_ = other.entryId_;
		hideBack_ = other.hideBack_;
		energy_ = other.energy_;
		coin_ = other.coin_;
		coinIds_ = other.coinIds_.Clone();
		hideCoinAdd_ = other.hideCoinAdd_;
		delayShow_ = other.delayShow_;
		hideHome_ = other.hideHome_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TopBar Clone()
	{
		return new TopBar(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TopBar);
	}

	[DebuggerNonUserCode]
	public bool Equals(TopBar other)
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
		if (Title != other.Title)
		{
			return false;
		}
		if (EntryId != other.EntryId)
		{
			return false;
		}
		if (HideBack != other.HideBack)
		{
			return false;
		}
		if (Energy != other.Energy)
		{
			return false;
		}
		if (Coin != other.Coin)
		{
			return false;
		}
		if (!coinIds_.Equals(other.coinIds_))
		{
			return false;
		}
		if (HideCoinAdd != other.HideCoinAdd)
		{
			return false;
		}
		if (DelayShow != other.DelayShow)
		{
			return false;
		}
		if (HideHome != other.HideHome)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id.Length != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (EntryId != 0)
		{
			num ^= EntryId.GetHashCode();
		}
		if (HideBack)
		{
			num ^= HideBack.GetHashCode();
		}
		if (Energy)
		{
			num ^= Energy.GetHashCode();
		}
		if (Coin)
		{
			num ^= Coin.GetHashCode();
		}
		num ^= coinIds_.GetHashCode();
		if (HideCoinAdd)
		{
			num ^= HideCoinAdd.GetHashCode();
		}
		if (DelayShow)
		{
			num ^= DelayShow.GetHashCode();
		}
		if (HideHome)
		{
			num ^= HideHome.GetHashCode();
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
		if (Id.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Id);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Title);
		}
		if (EntryId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(EntryId);
		}
		if (HideBack)
		{
			output.WriteRawTag(32);
			output.WriteBool(HideBack);
		}
		if (Energy)
		{
			output.WriteRawTag(40);
			output.WriteBool(Energy);
		}
		if (Coin)
		{
			output.WriteRawTag(48);
			output.WriteBool(Coin);
		}
		coinIds_.WriteTo(output, _repeated_coinIds_codec);
		if (HideCoinAdd)
		{
			output.WriteRawTag(64);
			output.WriteBool(HideCoinAdd);
		}
		if (DelayShow)
		{
			output.WriteRawTag(72);
			output.WriteBool(DelayShow);
		}
		if (HideHome)
		{
			output.WriteRawTag(80);
			output.WriteBool(HideHome);
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
		if (Id.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Id);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (EntryId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EntryId);
		}
		if (HideBack)
		{
			num += 2;
		}
		if (Energy)
		{
			num += 2;
		}
		if (Coin)
		{
			num += 2;
		}
		num += coinIds_.CalculateSize(_repeated_coinIds_codec);
		if (HideCoinAdd)
		{
			num += 2;
		}
		if (DelayShow)
		{
			num += 2;
		}
		if (HideHome)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TopBar other)
	{
		if (other != null)
		{
			if (other.Id.Length != 0)
			{
				Id = other.Id;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.EntryId != 0)
			{
				EntryId = other.EntryId;
			}
			if (other.HideBack)
			{
				HideBack = other.HideBack;
			}
			if (other.Energy)
			{
				Energy = other.Energy;
			}
			if (other.Coin)
			{
				Coin = other.Coin;
			}
			coinIds_.Add(other.coinIds_);
			if (other.HideCoinAdd)
			{
				HideCoinAdd = other.HideCoinAdd;
			}
			if (other.DelayShow)
			{
				DelayShow = other.DelayShow;
			}
			if (other.HideHome)
			{
				HideHome = other.HideHome;
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
			case 10u:
				Id = input.ReadString();
				break;
			case 18u:
				Title = input.ReadString();
				break;
			case 24u:
				EntryId = input.ReadInt32();
				break;
			case 32u:
				HideBack = input.ReadBool();
				break;
			case 40u:
				Energy = input.ReadBool();
				break;
			case 48u:
				Coin = input.ReadBool();
				break;
			case 56u:
			case 58u:
				coinIds_.AddEntriesFrom(input, _repeated_coinIds_codec);
				break;
			case 64u:
				HideCoinAdd = input.ReadBool();
				break;
			case 72u:
				DelayShow = input.ReadBool();
				break;
			case 80u:
				HideHome = input.ReadBool();
				break;
			}
		}
	}
}
