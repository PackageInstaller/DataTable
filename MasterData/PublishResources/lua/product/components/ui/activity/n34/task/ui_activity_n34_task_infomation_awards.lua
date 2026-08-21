_class("UIActivityN34TaskInfomationAwards", UIController)
UIActivityN34TaskInfomationAwards = UIActivityN34TaskInfomationAwards

function UIActivityN34TaskInfomationAwards:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIActivityN34TaskInfomationAwards:OnShow(uiParams)
  local data = uiParams[1]
  self._awards = {}
  for _, reward in pairs(data) do
    table.insert(self._awards, reward)
  end
  self:_GetComponents()
  self:_OnValue()
end

function UIActivityN34TaskInfomationAwards:_GetComponents()
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UIN31SecondAnniversaryItemTips")
  self._animation = self.view.gameObject:GetComponent("Animation")
  self.atc = self:GetGameObject():GetComponent(typeof(ATransitionComponent))
end

function UIActivityN34TaskInfomationAwards:_OnValue()
  local count = table.count(self._awards)
  self._content:SpawnObjects("UIActivityN34TaskInfomationAwardItem", count)
  local widgets = self._content:GetAllSpawnList()
  for index, widget in ipairs(widgets) do
    widget:SetData(self._awards[index], function(id, position)
      self:_ShowTips(id, position)
    end, true)
  end
  self.atc:PlayEnterAnimation(true)
end

function UIActivityN34TaskInfomationAwards:BackgroundBtnOnClick(go)
  self:StartTask(function(TT)
    local key = "UIActivityN34TaskInfomationAwards"
    self:Lock(key)
    self.atc:PlayLeaveAnimation(true)
    YIELD(TT, 233)
    self:CloseDialog()
    self:UnLock(key)
  end, self)
end

function UIActivityN34TaskInfomationAwards:_ShowTips(id, position)
  self._tips:SetData(id, position)
end
