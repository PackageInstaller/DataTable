using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Define;
using ACT.Model;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;
using Pb;

namespace ACT.Game.Data;

public sealed class Inventory : IMessage<Inventory>, IMessage, IEquatable<Inventory>, IDeepCloneable<Inventory>, IBufferMessage
{
	private static readonly MessageParser<Inventory> _parser = new MessageParser<Inventory>(() => new Inventory());

	private UnknownFieldSet _unknownFields;

	public const int ItemsFieldNumber = 1;

	private static readonly FieldCodec<Item> _repeated_items_codec = FieldCodec.ForMessage(10u, Item.Parser);

	private readonly RepeatedField<Item> items_ = new RepeatedField<Item>();

	public const int ChipsFieldNumber = 2;

	private static readonly FieldCodec<Chip> _repeated_chips_codec = FieldCodec.ForMessage(18u, Chip.Parser);

	private readonly RepeatedField<Chip> chips_ = new RepeatedField<Chip>();

	public const int WeaponsFieldNumber = 3;

	private static readonly FieldCodec<Weapon> _repeated_weapons_codec = FieldCodec.ForMessage(26u, Weapon.Parser);

	private readonly RepeatedField<Weapon> weapons_ = new RepeatedField<Weapon>();

	public const int EquipsFieldNumber = 4;

	private static readonly FieldCodec<Equip> _repeated_equips_codec = FieldCodec.ForMessage(34u, Equip.Parser);

	private readonly RepeatedField<Equip> equips_ = new RepeatedField<Equip>();

	public const int GemsFieldNumber = 5;

	private static readonly FieldCodec<Gem> _repeated_gems_codec = FieldCodec.ForMessage(42u, Gem.Parser);

	private readonly RepeatedField<Gem> gems_ = new RepeatedField<Gem>();

	public RepeatedField<BloodBottleData> BloodBottles = new RepeatedField<BloodBottleData>();

	public RepeatedField<BloodBottleMaterial> BloodBottleMaterials = new RepeatedField<BloodBottleMaterial>();

	public RepeatedField<GiftPackage> GiftPackages = new RepeatedField<GiftPackage>();

	public Dictionary<int, Item> ItemDic = new Dictionary<int, Item>();

	public List<Weapon> localWeapons = new List<Weapon>();

	public List<Chip> LocalChips = new List<Chip>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Inventory> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[55];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> Items => items_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Chip> Chips => chips_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Weapon> Weapons => weapons_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Equip> Equips => equips_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Gem> Gems => gems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Inventory()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Inventory(Inventory other)
		: this()
	{
		items_ = other.items_.Clone();
		chips_ = other.chips_.Clone();
		weapons_ = other.weapons_.Clone();
		equips_ = other.equips_.Clone();
		gems_ = other.gems_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Inventory Clone()
	{
		return new Inventory(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Inventory);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Inventory other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!items_.Equals(other.items_))
		{
			return false;
		}
		if (!chips_.Equals(other.chips_))
		{
			return false;
		}
		if (!weapons_.Equals(other.weapons_))
		{
			return false;
		}
		if (!equips_.Equals(other.equips_))
		{
			return false;
		}
		if (!gems_.Equals(other.gems_))
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		num ^= items_.GetHashCode();
		num ^= chips_.GetHashCode();
		num ^= weapons_.GetHashCode();
		num ^= equips_.GetHashCode();
		num ^= gems_.GetHashCode();
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		items_.WriteTo(ref output, _repeated_items_codec);
		chips_.WriteTo(ref output, _repeated_chips_codec);
		weapons_.WriteTo(ref output, _repeated_weapons_codec);
		equips_.WriteTo(ref output, _repeated_equips_codec);
		gems_.WriteTo(ref output, _repeated_gems_codec);
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		num += items_.CalculateSize(_repeated_items_codec);
		num += chips_.CalculateSize(_repeated_chips_codec);
		num += weapons_.CalculateSize(_repeated_weapons_codec);
		num += equips_.CalculateSize(_repeated_equips_codec);
		num += gems_.CalculateSize(_repeated_gems_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Inventory other)
	{
		if (other != null)
		{
			items_.Add(other.items_);
			chips_.Add(other.chips_);
			weapons_.Add(other.weapons_);
			equips_.Add(other.equips_);
			gems_.Add(other.gems_);
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 10u:
				items_.AddEntriesFrom(ref input, _repeated_items_codec);
				break;
			case 18u:
				chips_.AddEntriesFrom(ref input, _repeated_chips_codec);
				break;
			case 26u:
				weapons_.AddEntriesFrom(ref input, _repeated_weapons_codec);
				break;
			case 34u:
				equips_.AddEntriesFrom(ref input, _repeated_equips_codec);
				break;
			case 42u:
				gems_.AddEntriesFrom(ref input, _repeated_gems_codec);
				break;
			}
		}
	}

	public Item GetItemInfo(int itemId)
	{
		if (!ItemDic.TryGetValue(itemId, out var value))
		{
			return null;
		}
		return value;
	}

	public int GetItemCount(int itemId)
	{
		if (ItemDic.TryGetValue(itemId, out var value) && value != null)
		{
			return value.Count;
		}
		ItemData data = CoreUtils.GetData(itemId, RuntimeConfigs.data.itemDatas);
		if (data != null)
		{
			switch (data.type)
			{
			case 5:
				return GetCharacterItemCount(data);
			case 17:
				return CharacterDependHelper.GetEquipCount(itemId);
			case 18:
				return CharacterDependHelper.GetGemCount(itemId);
			case 15:
				return G.localPlayer.Inventory.BloodBottles.FindAll((BloodBottleData x) => x.id == itemId).Count;
			case 16:
				return G.localPlayer.Inventory.BloodBottleMaterials.FindAll((BloodBottleMaterial x) => x.id == itemId).Count;
			case 35:
				return G.localPlayer.Inventory.GiftPackages.FindAll((GiftPackage x) => x.GetId() == itemId).Count;
			}
		}
		G.detailUserInfo.Attributes.TryGetValue(itemId, out var value2);
		return (int)value2;
	}

	private int GetCharacterItemCount(ItemData itemData)
	{
		List<ItemKv> list = itemData?.canBeTransited;
		if (list == null || list.Count == 0)
		{
			return 0;
		}
		int id = list[0].id;
		if (id <= 0 || !CharacterDataHelper.CheckIsHaveCharacterById(id))
		{
			return 0;
		}
		return 1;
	}

	public bool CheckIsHaveItemByType(int type)
	{
		if (items_.Find((Item si) => si.itemType == type && si.Count > 0) != null)
		{
			return true;
		}
		switch ((LuminItemType)type)
		{
		case LuminItemType.Weapon:
			return weapons_.Count > 0;
		case LuminItemType.Chip:
			return chips_.Count > 0;
		case LuminItemType.Equip:
			return CharacterDependHelper.GetCurWorldAllEquip().Count > 0;
		case LuminItemType.Gem:
			return CharacterDependHelper.GetCurWorldAllGem().Count > 0;
		case LuminItemType.LittleItem:
			return BloodBottles.Count > 0;
		case LuminItemType.Additive:
			return BloodBottleMaterials.Count > 0;
		case LuminItemType.GiftPack:
			return GiftPackages.Count > 0;
		case LuminItemType.Attribute:
			if (G.detailUserInfo?.Attributes == null || RuntimeConfigs.data?.itemDatas == null)
			{
				return false;
			}
			foreach (KeyValuePair<int, long> attribute in G.detailUserInfo.Attributes)
			{
				if (attribute.Value > 0 && RuntimeConfigs.data.itemDatas.TryGetValue(attribute.Key, out var value) && value.type == 999)
				{
					return true;
				}
			}
			return false;
		default:
			return false;
		}
	}

	public Weapon GetWeapon(int uid)
	{
		return weapons_.Find((Weapon x) => x.Uid == uid);
	}

	public Weapon GetLocalWeapon(int uid)
	{
		return localWeapons.Find((Weapon x) => x.Uid == uid);
	}

	public int GetWeaponIndex(int uid)
	{
		return weapons_.FindIndex((Weapon si) => si.Uid == uid);
	}

	public int GetSameWeaponIdCount(int weaponId)
	{
		return Enumerable.Count(weapons_, (Weapon _) => _.WeaponId == weaponId);
	}

	public Chip GetChip(int uid)
	{
		return chips_.Find((Chip x) => x.Uid == uid);
	}

	public int GetChipIndex(int uid)
	{
		return chips_.FindIndex((Chip x) => x.Uid == uid);
	}

	public Equip GetEquip(int uid)
	{
		return CharacterDependHelper.GetCurWorldEquip(uid);
	}

	public Gem GetGem(int uid)
	{
		return CharacterDependHelper.GetCurWorldGem(uid);
	}

	public int GetEquippedGemCount()
	{
		int num = 0;
		List<Equip> curWorldAllEquip = CharacterDependHelper.GetCurWorldAllEquip();
		for (int i = 0; i < curWorldAllEquip.Count; i++)
		{
			Equip equip = curWorldAllEquip[i];
			num += Enumerable.Count(equip.GemSlots, (GemSlot slot) => slot.GemId > 0);
		}
		return num;
	}

	public int GetEquipCountLevel(int level)
	{
		return Enumerable.Count(CharacterDependHelper.GetCurWorldAllEquip(), (Equip equip) => equip.Level >= level);
	}

	public int GetEquippedCountRare(int rare)
	{
		return CharacterDependHelper.GetCurWorldAllEquip().Where((Equip equip) =>
		{
			int quality = CoreUtils.GetData(equip.Id, RuntimeConfigs.data.itemDatas).quality;
			return equip.WearCharacter > 0 && quality == rare;
		}).Count();
	}

	public void ApplyChanges(ItemNtf itemNtf, List<Item> addedItem, List<Item> minusItem, bool reset)
	{
		if (reset)
		{
			items_.Clear();
		}
		foreach (Item change in itemNtf.Changes)
		{
			int num = items_.FindIndex((Item si) => si.Id == change.Id);
			if (num == -1)
			{
				items_.Add(change);
				addedItem.Add(change);
				continue;
			}
			int count = change.Count;
			Item item = items_[num];
			if (count > item.Count)
			{
				change.Count -= items_[num].Count;
				addedItem.Add(change);
			}
			else if (count < item.Count)
			{
				change.Count = item.Count - change.Count;
				minusItem.Add(change);
			}
			if (items_[num].Count == 0 && items_[num].itemType == 15)
			{
				items_.RemoveAt(num);
			}
			else
			{
				items_[num].Count = count;
			}
		}
		ItemDic.Clear();
		for (int num2 = 0; num2 < items_.Count; num2++)
		{
			Item item2 = items_[num2];
			if (item2 != null)
			{
				ItemDic[item2.Id] = item2;
			}
		}
	}

	public void ApplyChanges(WeaponNtf weaponNtf, bool reset)
	{
		if (reset)
		{
			weapons_.Clear();
		}
		foreach (Weapon change in weaponNtf.Changes)
		{
			int weaponIndex = GetWeaponIndex(change.Uid);
			if (weaponIndex == -1)
			{
				weapons_.Add(change);
			}
			else
			{
				weapons_[weaponIndex].MargeFrom(change);
			}
		}
		foreach (int removeUid in weaponNtf.RemoveUids)
		{
			int weaponIndex2 = GetWeaponIndex(removeUid);
			weapons_.RemoveAt(weaponIndex2);
		}
	}
}
