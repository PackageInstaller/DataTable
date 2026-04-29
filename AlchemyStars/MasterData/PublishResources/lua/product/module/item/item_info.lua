MAX_ITEM_USE_COUNT = 99
GameGlobal.MAX_ITEM_OVERLAY = 999999999
GameGlobal.MAX_ITEM_USE_COUNT = 99
local ItemType = {
  ItemType_None = 0,
  ItemType_Use = 1,
  ItemType_Material = 2,
  ItemType_Count = 3
}
_enum("ItemType", ItemType)
local ItemSubType = {
  ItemSubType_Begin = 0,
  ItemSubType_Base = 1,
  ItemSubType_Gift = 2,
  ItemSubType_PetExp = 3,
  ItemSubType_Relic = 4,
  ItemSubType_PetPresent = 5,
  ItemSubType_Furniture = 6,
  ItemSubType_Book = 7,
  ItemSubType_Cartridge = 8,
  ItemSubType_Cam_Cartridge = 9,
  ItemSubType_BackGroudPicture = 10,
  ItemSubType_BoardPet = 11,
  ItemSubType_10DrawCardTicket = 12,
  ItemSubType_Architecture = 13,
  ItemSubType_ForgeAccelerate = 14,
  ItemSubType_ArchitectureSkin = 15,
  ItemSubType_Tool = 16,
  ItemSubType_Photo = 17,
  ItemSubType_Seed = 18,
  ItemSubType_CultivationItem = 19,
  ItemSubType_Fish = 20,
  ItemSubType_WishingCoin = 21,
  ItemSubType_CommonBreakThough = 22,
  ItemSubType_HomelandDrawingg = 23,
  ItemSubType_Title = 24,
  ItemSubType_Fifure = 25,
  ItemSubType_Medal = 26,
  ItemSubType_Medal_Board = 27,
  ItemSubType_TempDrawTicket = 28,
  ItemSubType_TempSpecialTicket = 29,
  ItemSubType_Head = 30,
  ItemSubType_HeadFrame = 31,
  ItemSubType_Overt = 32,
  ItemSubType_Collection = 33,
  ItemSubType_Season_Collection = 34,
  ItemSubType_Season_Common = 35,
  ItemSubType_Chess = 36,
  ItemSubType_End = 37
}
_enum("ItemSubType", ItemSubType)
local ItemGiftType = {
  ItemGiftType_General = 1,
  ItemGiftType_Choose = 2,
  ItemGiftType_Drop = 3,
  ItemGiftType_CommonRandom = 4,
  ItemGiftType_Cartridge = 5
}
_enum("ItemGiftType", ItemGiftType)
local ItemColor = {
  ItemColor_White = 1,
  ItemColor_Green = 2,
  ItemColor_Blue = 3,
  ItemColor_Purple = 4,
  ItemColor_Yellow = 5,
  ItemColor_Golden = 6
}
_enum("ItemColor", ItemColor)
local ItemUseType = {
  ItemUseType_CanotUse = 0,
  ItemUseType_ManualUse = 1,
  ItemUseType_AutoUse = 2
}
_enum("ItemUseType", ItemUseType)
local ItemPhotoType = {
  ItemPhotoType_None = 0,
  ItemPhotoType_HomeLand = 1,
  ItemPhotoType_End = 2
}
_enum("ItemPhotoType", ItemPhotoType)
local ItemDataFlags = {
  Item_Flag_Is_New_Obtain = 1,
  Item_Flag_Is_New_Furniture = 2,
  Item_Flag_Is_New_Overlay = 4,
  Item_Flag_Is_Send_First_Dead_Mail = 8,
  Item_Flag_Is_Send_Second_Dead_Mail = 16,
  Item_Flag_Is_Send_Final_Mail = 32
}
_enum("ItemDataFlags", ItemDataFlags)
_class("item_data_info", Object)
item_data_info = item_data_info

function item_data_info:Constructor()
  self.item_pstid = 0
  self.owner_pstid = 0
  self.template_id = 0
  self.count = 0
  self.gain_time = 0
  self.durability = 0
  self.flags = 0
  self.custom_data = ""
end

item_data_info._proto = {
  [1] = {"item_pstid", "int64"},
  [2] = {
    "owner_pstid",
    "int64"
  },
  [3] = {
    "template_id",
    "int"
  },
  [4] = {"count", "int64"},
  [5] = {"gain_time", "time"},
  [6] = {"durability", "int"},
  [7] = {"flags", "int"},
  [8] = {
    "custom_data",
    "buffer"
  }
}
_class("UseItemParameter", Object)
UseItemParameter = UseItemParameter

function UseItemParameter:Constructor()
  self.item_pstid = 0
  self.item_tempid = 0
  self.use_count = 0
  self.param1 = 0
  self.param2 = 0
  self.param3 = 0
end

UseItemParameter._proto = {
  [1] = {"item_pstid", "int64"},
  [2] = {
    "item_tempid",
    "int"
  },
  [3] = {"use_count", "int64"},
  [4] = {"param1", "int64"},
  [5] = {"param2", "int64"},
  [6] = {"param3", "int64"}
}
_class("item_ext_dummy", Object)
item_ext_dummy = item_ext_dummy

function item_ext_dummy:Constructor()
end

item_ext_dummy._proto = {}
_class("item_ext_gold", Object)
item_ext_gold = item_ext_gold

function item_ext_gold:Constructor()
  self.custom_data = 0
end

item_ext_gold._proto = {
  [1] = {
    "custom_data",
    "int"
  }
}
local EnumItemSaleAndUseState = {Use = 0, Sale = 1}
_enum("EnumItemSaleAndUseState", EnumItemSaleAndUseState)
local EnumItemGetPathState = {
  None = 0,
  Discovery = 1,
  Base = 2,
  Text = 3
}
_enum("EnumItemGetPathState", EnumItemGetPathState)
