_class("UIN31SecondAnniversaryAwards", UIController)
UIN31SecondAnniversaryAwards = UIN31SecondAnniversaryAwards

function UIN31SecondAnniversaryAwards:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIN31SecondAnniversaryAwards:OnShow(uiParams)
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

function UIN31SecondAnniversaryAwards:_GetComponents()
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UIN31SecondAnniversaryItemTips")
  self._animation = self.view.gameObject:GetComponent("Animation")
  self.atc = self:GetGameObject():GetComponent(typeof(ATransitionComponent))
end

function UIN31SecondAnniversaryAwards:_OnValue()
  local count = table.count(self._awards)
  self._content:SpawnObjects("UIN31SecondAnniversaryAwardItem", count)
  local widgets = self._content:GetAllSpawnList()
  for index, widget in ipairs(widgets) do
    widget:SetData(self._awards[index], function(id, position)
      self:_ShowTips(id, position)
    end, true)
  end
  self.atc:PlayEnterAnimation(true)
end

function UIN31SecondAnniversaryAwards:BackgroundBtnOnClick(go)
  self:StartTask(function(TT)
    local key = "UIN31SecondAnniversaryItemTipsClose"
    self:Lock(key)
    self.atc:PlayLeaveAnimation(true)
    YIELD(TT, 233)
    self:CloseDialog()
    self:UnLock(key)
  end, self)
end

function UIN31SecondAnniversaryAwards:_ShowTips(id, position)
  self._tips:SetData(id, position)
end
