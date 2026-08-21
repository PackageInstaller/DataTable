_class("UIActivityReturnSystemWelecome", UICustomWidget)
UIActivityReturnSystemWelecome = UIActivityReturnSystemWelecome

function UIActivityReturnSystemWelecome:OnShow()
  self.txtHint = self:GetUIComponent("UILocalizationText", "txtHint")
end

function UIActivityReturnSystemWelecome:OnHide()
end

function UIActivityReturnSystemWelecome:SetData(campaign, remainingTimeCallback)
  self._campaign = campaign
  self._component = UIActivityReturnSystemHelper.GetComponentByTabName(self._campaign, "welecome", 1)
  self:Flush()
end

function UIActivityReturnSystemWelecome:Flush()
  local isRecv = self._component:IsRecvBackReward()
  local txtId = isRecv and "str_discovery_chapter_collected" or "str_return_system_get_award"
  self.txtHint:SetText(StringTable.Get(txtId))
end

function UIActivityReturnSystemWelecome:imgIconOnClick(go)
  self:GetAward()
end

function UIActivityReturnSystemWelecome:imgGetOnClick(go)
  self:GetAward()
end

function UIActivityReturnSystemWelecome:GetAward()
  local isRecv = self._component:IsRecvBackReward()
  if isRecv then
    return
  end
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self._component:HandleRecvBackReward(TT, res)
    if res:GetSucc() then
      self._component:SetRecvBackRewardGot()
      self:Flush()
      local awards = self._component:GetAwards()
      self:ShowDialog("UIGetItemController", awards)
    else
      Log.fatal("### HandleRecvBackReward failed.")
    end
  end, self)
end
