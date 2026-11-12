using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MiningControl : IMessage<MiningControl>, IMessage, IEquatable<MiningControl>, IDeepCloneable<MiningControl>
{
	private static readonly MessageParser<MiningControl> _parser = new MessageParser<MiningControl>(() => new MiningControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int UseTypeFieldNumber = 2;

	private int useType_;

	public const int UIAssetsFieldNumber = 3;

	private string uIAssets_ = "";

	public const int CtrlNameFieldNumber = 4;

	private string ctrlName_ = "";

	public const int GamePanelIdFieldNumber = 5;

	private int gamePanelId_;

	public const int QuestPanelIdFieldNumber = 6;

	private int questPanelId_;

	public const int DescFieldNumber = 7;

	private string desc_ = "";

	public const int RewardsShowFieldNumber = 8;

	private string rewardsShow_ = "";

	public const int DigConsumeItemIdFieldNumber = 9;

	private int digConsumeItemId_;

	public const int ConfigMaxLayerFieldNumber = 10;

	private int configMaxLayer_;

	public const int ShopIdFieldNumber = 11;

	private int shopId_;

	public const int BgPrefabFieldNumber = 12;

	private string bgPrefab_ = "";

	public const int GridListPrefabFieldNumber = 13;

	private string gridListPrefab_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<MiningControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(550);

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
	public int UseType
	{
		get
		{
			return useType_;
		}
		set
		{
			useType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string UIAssets
	{
		get
		{
			return uIAssets_;
		}
		set
		{
			uIAssets_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CtrlName
	{
		get
		{
			return ctrlName_;
		}
		set
		{
			ctrlName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int GamePanelId
	{
		get
		{
			return gamePanelId_;
		}
		set
		{
			gamePanelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int QuestPanelId
	{
		get
		{
			return questPanelId_;
		}
		set
		{
			questPanelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string RewardsShow
	{
		get
		{
			return rewardsShow_;
		}
		set
		{
			rewardsShow_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int DigConsumeItemId
	{
		get
		{
			return digConsumeItemId_;
		}
		set
		{
			digConsumeItemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ConfigMaxLayer
	{
		get
		{
			return configMaxLayer_;
		}
		set
		{
			configMaxLayer_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ShopId
	{
		get
		{
			return shopId_;
		}
		set
		{
			shopId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BgPrefab
	{
		get
		{
			return bgPrefab_;
		}
		set
		{
			bgPrefab_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string GridListPrefab
	{
		get
		{
			return gridListPrefab_;
		}
		set
		{
			gridListPrefab_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public MiningControl()
	{
	}

	[DebuggerNonUserCode]
	public MiningControl(MiningControl other)
		: this()
	{
		id_ = other.id_;
		useType_ = other.useType_;
		uIAssets_ = other.uIAssets_;
		ctrlName_ = other.ctrlName_;
		gamePanelId_ = other.gamePanelId_;
		questPanelId_ = other.questPanelId_;
		desc_ = other.desc_;
		rewardsShow_ = other.rewardsShow_;
		digConsumeItemId_ = other.digConsumeItemId_;
		configMaxLayer_ = other.configMaxLayer_;
		shopId_ = other.shopId_;
		bgPrefab_ = other.bgPrefab_;
		gridListPrefab_ = other.gridListPrefab_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MiningControl Clone()
	{
		return new MiningControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MiningControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(MiningControl other)
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
		if (UseType != other.UseType)
		{
			return false;
		}
		if (UIAssets != other.UIAssets)
		{
			return false;
		}
		if (CtrlName != other.CtrlName)
		{
			return false;
		}
		if (GamePanelId != other.GamePanelId)
		{
			return false;
		}
		if (QuestPanelId != other.QuestPanelId)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (RewardsShow != other.RewardsShow)
		{
			return false;
		}
		if (DigConsumeItemId != other.DigConsumeItemId)
		{
			return false;
		}
		if (ConfigMaxLayer != other.ConfigMaxLayer)
		{
			return false;
		}
		if (ShopId != other.ShopId)
		{
			return false;
		}
		if (BgPrefab != other.BgPrefab)
		{
			return false;
		}
		if (GridListPrefab != other.GridListPrefab)
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
		if (UseType != 0)
		{
			num ^= UseType.GetHashCode();
		}
		if (UIAssets.Length != 0)
		{
			num ^= UIAssets.GetHashCode();
		}
		if (CtrlName.Length != 0)
		{
			num ^= CtrlName.GetHashCode();
		}
		if (GamePanelId != 0)
		{
			num ^= GamePanelId.GetHashCode();
		}
		if (QuestPanelId != 0)
		{
			num ^= QuestPanelId.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (RewardsShow.Length != 0)
		{
			num ^= RewardsShow.GetHashCode();
		}
		if (DigConsumeItemId != 0)
		{
			num ^= DigConsumeItemId.GetHashCode();
		}
		if (ConfigMaxLayer != 0)
		{
			num ^= ConfigMaxLayer.GetHashCode();
		}
		if (ShopId != 0)
		{
			num ^= ShopId.GetHashCode();
		}
		if (BgPrefab.Length != 0)
		{
			num ^= BgPrefab.GetHashCode();
		}
		if (GridListPrefab.Length != 0)
		{
			num ^= GridListPrefab.GetHashCode();
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
		if (UseType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(UseType);
		}
		if (UIAssets.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(CtrlName);
		}
		if (GamePanelId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(GamePanelId);
		}
		if (QuestPanelId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(QuestPanelId);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Desc);
		}
		if (RewardsShow.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(RewardsShow);
		}
		if (DigConsumeItemId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(DigConsumeItemId);
		}
		if (ConfigMaxLayer != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(ConfigMaxLayer);
		}
		if (ShopId != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(ShopId);
		}
		if (BgPrefab.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(BgPrefab);
		}
		if (GridListPrefab.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(GridListPrefab);
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
		if (UseType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UseType);
		}
		if (UIAssets.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CtrlName);
		}
		if (GamePanelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GamePanelId);
		}
		if (QuestPanelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(QuestPanelId);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (RewardsShow.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RewardsShow);
		}
		if (DigConsumeItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DigConsumeItemId);
		}
		if (ConfigMaxLayer != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ConfigMaxLayer);
		}
		if (ShopId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ShopId);
		}
		if (BgPrefab.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BgPrefab);
		}
		if (GridListPrefab.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(GridListPrefab);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MiningControl other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.UseType != 0)
			{
				UseType = other.UseType;
			}
			if (other.UIAssets.Length != 0)
			{
				UIAssets = other.UIAssets;
			}
			if (other.CtrlName.Length != 0)
			{
				CtrlName = other.CtrlName;
			}
			if (other.GamePanelId != 0)
			{
				GamePanelId = other.GamePanelId;
			}
			if (other.QuestPanelId != 0)
			{
				QuestPanelId = other.QuestPanelId;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.RewardsShow.Length != 0)
			{
				RewardsShow = other.RewardsShow;
			}
			if (other.DigConsumeItemId != 0)
			{
				DigConsumeItemId = other.DigConsumeItemId;
			}
			if (other.ConfigMaxLayer != 0)
			{
				ConfigMaxLayer = other.ConfigMaxLayer;
			}
			if (other.ShopId != 0)
			{
				ShopId = other.ShopId;
			}
			if (other.BgPrefab.Length != 0)
			{
				BgPrefab = other.BgPrefab;
			}
			if (other.GridListPrefab.Length != 0)
			{
				GridListPrefab = other.GridListPrefab;
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
				UseType = input.ReadInt32();
				break;
			case 26u:
				UIAssets = input.ReadString();
				break;
			case 34u:
				CtrlName = input.ReadString();
				break;
			case 40u:
				GamePanelId = input.ReadInt32();
				break;
			case 48u:
				QuestPanelId = input.ReadInt32();
				break;
			case 58u:
				Desc = input.ReadString();
				break;
			case 66u:
				RewardsShow = input.ReadString();
				break;
			case 72u:
				DigConsumeItemId = input.ReadInt32();
				break;
			case 80u:
				ConfigMaxLayer = input.ReadInt32();
				break;
			case 88u:
				ShopId = input.ReadInt32();
				break;
			case 98u:
				BgPrefab = input.ReadString();
				break;
			case 106u:
				GridListPrefab = input.ReadString();
				break;
			}
		}
	}
}
