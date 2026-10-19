using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum UniversalItemType
{
	[OriginalName("UNIVERSAL_ITEM_NORMAL")]
	UniversalItemNormal,
	[OriginalName("UNIVERSAL_ITEM_WEAPON")]
	UniversalItemWeapon,
	[OriginalName("UNIVERSAL_ITEM_CHIP")]
	UniversalItemChip,
	[OriginalName("UNIVERSAL_ITEM_EQUIP")]
	UniversalItemEquip,
	[OriginalName("UNIVERSAL_ITEM_GEM")]
	UniversalItemGem,
	[OriginalName("UNIVERSAL_ITEM_CHARACTER")]
	UniversalItemCharacter,
	[OriginalName("UNIVERSAL_ITEM_SKIN")]
	UniversalItemSkin,
	[OriginalName("UNIVERSAL_ITEM_EFFECT_DRESS")]
	UniversalItemEffectDress,
	[OriginalName("UNIVERSAL_ITEM_TITLE")]
	UniversalItemTitle,
	[OriginalName("UNIVERSAL_ITEM_AVATAR")]
	UniversalItemAvatar,
	[OriginalName("UNIVERSAL_ITEM_AVATARFRAME")]
	UniversalItemAvatarframe
}
