_class("UIN25NewYearAwards", UIController)
UIN25NewYearAwards = UIN25NewYearAwards

function UIN25NewYearAwards:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIN25NewYearAwards:OnShow(uiParams)
  local data = uiParams[1]
  self._awards = {}
  for _, TimeRewardInfo in pairs(data) do
    for _, reward in pairs(TimeRewardInfo.rewards) do
      table.insert(self._awards, reward)
    end
  end
  self:_GetComponents()
  self:_OnValue()
end

function UIN25NewYearAwards:_GetComponents()
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UIN25NewYearItemTips")
  self._animation = self.view.gameObject:GetComponent("Animation")
end

function UIN25NewYearAwards:_OnValue()
  local count = table.count(self._awards)
  self._content:SpawnObjects("UIN25NewYearAwardItem", count)
  local widgets = self._content:GetAllSpawnList()
  for index, widget in ipairs(widgets) do
    widget:SetData(self._awards[index], function(roleAsset, position)
      self:_ShowTips(roleAsset, position)
    end, true)
  end
end

function UIN25NewYearAwards:BackgroundBtnOnClick(go)
  self:CloseDialog()
end

function UIN25NewYearAwards:_ShowTips(roleAsset, position)
  self._tips:SetData(roleAsset, position)
end
