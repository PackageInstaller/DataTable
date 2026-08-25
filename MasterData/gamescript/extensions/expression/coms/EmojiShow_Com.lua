local EmojiShow_Com, Super = NewViewComponent("EmojiShow_Com")
local TOTALNUM = 16

function EmojiShow_Com:ctor(uiNode, view, datalist)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Pvp_Popup_Expression_ChooseResource(uiNode)
  self.datalist = datalist
end

function EmojiShow_Com:RegisterNotifications()
end

function EmojiShow_Com:OnEnterComponent()
  self:InitSlot()
  self:UpdateShow()
end

function EmojiShow_Com:UpdateShow()
  for index, data in ipairs(self.datalist) do
    self:LoadDataByIndex(index, data)
  end
end

function EmojiShow_Com:LoadDataByIndex(index, newData)
  local itemCom = self.coms[index]
  local data = self.datas[index]
  data.uid = newData.uid
  data.iconId = newData.iconId
  data.grayEndTime = newData.grayEndTime
  data.selected = newData.selected
  data.clickCB = newData.clickCB
  data.showGray = newData.showGray or false
  itemCom:UpdateShow()
end

function EmojiShow_Com:InitSlot()
  self.ui.UI_Pvp_Item_Expression:SetActive(false)
  local coms = {}
  local datas = {}
  for i = 1, TOTALNUM do
    local itemData = {}
    local obj = GameObject.Instantiate(self.ui.UI_Pvp_Item_Expression, self.ui.Image_Bg.transform)
    local com = self:AddViewComponentOnce(obj, EmojiItem_Com, itemData, UI_Pvp_Item_ExpressionResource)
    coms[i] = com
    datas[i] = itemData
    obj:SetActive(true)
  end
  self.datas = datas
  self.coms = coms
end

return EmojiShow_Com
