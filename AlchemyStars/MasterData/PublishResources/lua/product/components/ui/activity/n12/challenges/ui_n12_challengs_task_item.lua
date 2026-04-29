_class("UIN12ChallengsTaskItem", UICustomWidget)
UIN12ChallengsTaskItem = UIN12ChallengsTaskItem

function UIN12ChallengsTaskItem:_GetComponents()
  self._count = self:GetUIComponent("UILocalizationText", "_count")
  self._state = self:GetUIComponent("UILocalizationText", "_state")
  self._icon = self:GetUIComponent("RawImageLoader", "_icon")
  self._iconraw = self:GetUIComponent("RawImage", "_icon")
  self._bg = self:GetGameObject("_bg")
  self._finish = self:GetGameObject("_finish")
  self._finish_ok = self:GetGameObject("_finish_ok")
  self._score = self:GetUIComponent("UILocalizationText", "_score")
  self._score_shade = self:GetUIComponent("UILocalizationText", "_score_shade")
  self._not_finish = self:GetGameObject("_not_finish")
  self._animation = self.view.gameObject:GetComponent("Animation")
end

function UIN12ChallengsTaskItem:_SetValue(uiParams)
  self._campaign = nil
  self._date = nil
  self._bossidx = 0
  self._idx = 0
  self._icon_gray = Color.New(0.5176470588235295, 0.5176470588235295, 0.5176470588235295)
end

function UIN12ChallengsTaskItem:_SetShow()
  if not self._date then
    return
  end
  self._count:SetText(self._date.rewards[1].count)
  self:_SetState(self._date.status == QuestStatus.QUEST_Taken)
  self:_SetScore(self._date.score)
end

function UIN12ChallengsTaskItem:_SetState(isShow)
  if isShow then
    self._state:SetText(StringTable.Get("str_n12_task_reach"))
    UIN12ChallengesContorl.SetIconGrey({
      self._icon,
      self._bg
    }, 1)
    self._iconraw.color = self._icon_gray
  else
    self._state:SetText(StringTable.Get("str_n12_task_not_reach"))
    UIN12ChallengesContorl.SetIconGrey({
      self._icon,
      self._bg
    }, 0)
    self._iconraw.color = Color.white
  end
  self._not_finish:SetActive(not isShow)
  self._finish:SetActive(isShow)
  self._finish_ok:SetActive(isShow)
  self._finish:SetActive(isShow)
end

function UIN12ChallengsTaskItem:_SetScore(score)
  self._score_shade:SetText(score)
  self._score:SetText(score)
end

function UIN12ChallengsTaskItem:_PlayAnimation(globalDelayTimeFunc)
  self._animation:Stop()
  self._animation:Play("uieff_N12_Hard_ChallengesTask_In")
end

function UIN12ChallengsTaskItem:OnShow(uiParams)
  self:_SetValue(uiParams)
  self:_GetComponents()
end

function UIN12ChallengsTaskItem:SetData(campaign, date, bosscfg, idx, globalDelayTimeFunc)
  self._campaign = campaign
  self._date = date
  self._cfg = Cfg.cfg_component_challenge_mission({
    CampaignMissionId = bosscfg[1]
  })[1]
  self._idx = idx
  self:_SetShow()
  self:_PlayAnimation(globalDelayTimeFunc)
end
