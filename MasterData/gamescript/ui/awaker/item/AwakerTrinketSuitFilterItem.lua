local AwakerTrinketSuitFilterItem, Super = System.NewComponent("AwakerTrinketSuitFilterItem")

function AwakerTrinketSuitFilterItem:ctor(res, data)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Trinket_SuitResource(res)
  self.model = data.model
  self.tid = data.tid
  self.callback = data.callback
end

local CompStateTable = {
  "Normal",
  "High",
  "Unclickable"
}

function AwakerTrinketSuitFilterItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.uiNode, System.fn(self, self.OnClick))
  for _, stateName in ipairs(CompStateTable) do
    local textNameObj = self.ui["Text_Name_" .. stateName]
    binder:BindToText(textNameObj, function()
      local name = self.model:GetSuitName(self.tid)
      return name
    end)
    local textCountObj = self.ui["Text_Count_" .. stateName]
    binder:BindToText(textCountObj, function()
      local suitItemNum = self.model:GetSuitItemNum(self.tid)
      return suitItemNum
    end)
    local iconObj = self.ui["Image_Icon_" .. stateName]
    binder:BindToImage(iconObj, function()
      local iconPath = self.model:GetSuitIcon(self.tid)
      return iconPath
    end)
  end
  binder:BindToVisible(self.ui.Group_Normal, function()
    local suitItemNum = self.model:GetSuitItemNum(self.tid)
    return suitItemNum > 0 and self.tid ~= self.model.filter
  end)
  binder:BindToVisible(self.ui.Group_High, function()
    return self.tid == self.model.filter
  end)
  binder:BindToVisible(self.ui.Group_Unclickable, function()
    local suitItemNum = self.model:GetSuitItemNum(self.tid)
    return 0 == suitItemNum
  end)
end

function AwakerTrinketSuitFilterItem:OnClick()
  if not self.callback then
    return
  end
  self.callback(self.tid)
end

return AwakerTrinketSuitFilterItem
