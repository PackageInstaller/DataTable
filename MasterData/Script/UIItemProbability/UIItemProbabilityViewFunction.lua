local View = require("UIItemProbability/UIItemProbabilityView")
local DataModel = require("UIItemProbability/UIItemProbabilityDataModel")
local CommonItem = require("Common/BtnItem")
local ViewFunction = {
  ItemProbability_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack(false)
    View.self:Confirm()
  end,
  ItemProbability_CustomScrollGrid_List_SetGrid = function(element, elementIndex)
    View.myCustomSV:SetItemShowAndHide(View.CustomScrollGrid_List.self.currentPosXOrY)
  end,
  ItemProbability_CustomScrollGrid_List_Group_Item_Group_List_StaticGrid_Card_SetGrid = function(element, elementIndex)
    local data = DataModel.itemPosList[DataModel.nowIndx].list[elementIndex]
    element:SetActive(data)
    if data then
      CommonItem:SetItem(element, {
        id = data.itemId,
        num = data.num
      })
      element.Group_Probability.Txt_ProbabilityNum:SetText(data.probability)
      element.Btn_Item:SetClickParam(data.itemId)
    end
    element.Group_EType:SetActive(false)
  end,
  ItemProbability_CustomScrollGrid_List_Group_Item_Group_List_StaticGrid_Card_Group_Item_Btn_Item_Click = function(btn, str)
    local id = tonumber(str)
    CommonTips.OpenPreItemTips({itemId = id})
  end
}
return ViewFunction
