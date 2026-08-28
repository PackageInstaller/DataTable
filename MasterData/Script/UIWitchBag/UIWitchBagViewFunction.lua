local CommonItem = require("Common/BtnItem")
local View = require("UIWitchBag/UIWitchBagView")
local DataModel = require("UIWitchBag/UIWitchBagDataModel")
local Controller = require("UIWitchBag/UIWitchBagController")
local DataController = require("UIWitchMain/UIWitchMainDataController")
local ViewFunction = {
  WitchBag_ScrollGrid__SetGrid = function(element, elementIndex)
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    element.Group_Item.Img_Picked:SetActive(elementIndex == DataModel.selectIndex)
    local itemId = DataModel.items[elementIndex]
    local num = WitchData.GetItemNumById(itemId)
    CommonItem:SetItem(element.Group_Item, {id = itemId, num = num}, EnumDefine.ItemType.Item)
    element.Group_Item.Img_BGCell2:SetActive(elementIndex % 2 == 0)
    element.Group_Item.Img_BGCell1:SetActive(elementIndex % 2 - 1 == 0)
  end,
  WitchBag_ScrollGrid__Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller.ClickBagItems(tonumber(str))
  end,
  WitchBag_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  WitchBag_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  WitchBag_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  WitchBag_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  WitchBag_Group_ItemInfo_Btn_Use_Click = function(btn, str)
    Controller.UseItem()
  end
}
return ViewFunction
