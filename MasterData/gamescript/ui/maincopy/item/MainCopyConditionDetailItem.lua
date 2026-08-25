local MainCopyConditionDetailItem, Super = System.NewComponent("MainCopyConditionDetailItem")

function MainCopyConditionDetailItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Battle_Popup_DetailResource(uiNode)
  self.data = data
end

function MainCopyConditionDetailItem:OnBind(binder)
  binder:BindToText(self.ui.Text_Describe, function()
    return self.data.title
  end)
  binder:BindToTextColorOld(self.ui.Text_Describe, function()
    if self.data.isGot then
      return DT.ColorConfig.TalentGreen.Light
    else
      return "#ffffff"
    end
  end)
  local rewards = self.data.rewards or {}
  for index = 1, 5 do
    local itemGameObj = self.ui["UI_Card_Item_Award_" .. index]
    local itemData = rewards[index]
    if itemGameObj then
      itemGameObj:SetActive(nil ~= itemData)
      if itemData then
        binder:BindComponent(CommonIconItemType2(itemGameObj, itemData))
      end
    end
  end
  CS.Framework.UIUtilTool.RefreshLayout(self.ui.uiNode)
end

function MainCopyConditionDetailItem:OnTodoFunc()
end

return MainCopyConditionDetailItem
