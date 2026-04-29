_class("UIN25IdolNotOpenNextDay", UIController)
UIN25IdolNotOpenNextDay = UIN25IdolNotOpenNextDay

function UIN25IdolNotOpenNextDay:Constructor()
end

function UIN25IdolNotOpenNextDay:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N25, ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, function()
    end, function()
      self:SwitchState(UIStateType.UIMain)
    end)
  end
  self.component = self._campaign:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
  local breakInfo = self.component.m_component_info.break_info
  local round_index = breakInfo.round_index
  local cfgs = Cfg.cfg_component_idol_round({Round = round_index})
  self._day = 1
  if cfgs and 0 < #cfgs then
    local cfg_round = cfgs[1]
    if cfg_round then
      self._day = cfg_round.UnlockTime
    end
  end
end

function UIN25IdolNotOpenNextDay:OnShow(uiParams)
  self:GetComponents()
  self:OnValue()
end

function UIN25IdolNotOpenNextDay:GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtn")
  self.backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self.backBtns:SetData(function()
    self:Close()
  end, nil, nil, true)
  self._tex = self:GetUIComponent("UILocalizationText", "tex")
  local tips
  if self._day == 1 then
    tips = "str_n25_idol_y_not_open_next_day_tips_1"
  else
    tips = "str_n25_idol_y_not_open_next_day_tips_2"
  end
  self._tex:SetText(StringTable.Get(tips))
end

function UIN25IdolNotOpenNextDay:OnValue()
  CutsceneManager.ExcuteCutsceneOut()
end

function UIN25IdolNotOpenNextDay:Close()
  self:SwitchState(UIStateType.UIN25IdolLogin)
end

function UIN25IdolNotOpenNextDay:OnHide()
end
