local MainCopyConditionItem, Super = System.NewComponent("MainCopyConditionItem")

function MainCopyConditionItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Battle_Popup_ConditionResource(uiNode)
  self.data = data
end

function MainCopyConditionItem:OnBind(binder)
  binder:BindToText(self.ui.Label, function()
    return self.data.title
  end)
  self.itemGameObjList = {}
  for i = 1, 3 do
    local itemData = self.data.itemList[i]
    local itemGameObj = self.ui["Detail_" .. i]
    if itemData then
      table.insert(self.itemGameObjList, itemGameObj)
      binder:BindComponent(MainCopyConditionDetailItem(itemGameObj, itemData))
    else
      itemGameObj:SetActive(false)
    end
  end
  self:SetToggle(true)
  binder:BindButtonClick(self.ui.Btn_Closing, function()
    self:SetToggle(not self.isToggle)
  end)
  CS.Framework.UIUtilTool.RefreshLayout(self.ui.uiNode)
end

function MainCopyConditionItem:SetToggle(isToggle)
  self.isToggle = isToggle
  self.ui.Image_Open:SetActive(isToggle)
  self.ui.Image_Close:SetActive(not isToggle)
  for _, gameObj in ipairs(self.itemGameObjList or {}) do
    gameObj:SetActive(isToggle)
  end
end

function MainCopyConditionItem:OnTodoFunc()
end

return MainCopyConditionItem
