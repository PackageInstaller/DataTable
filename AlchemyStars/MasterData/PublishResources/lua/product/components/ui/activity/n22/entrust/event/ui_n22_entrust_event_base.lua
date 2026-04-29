_class("UIN22EntrustEventBase", UICustomWidget)
UIN22EntrustEventBase = UIN22EntrustEventBase

function UIN22EntrustEventBase:OnShow(uiParams)
end

function UIN22EntrustEventBase:OnHide()
end

function UIN22EntrustEventBase:CloseDialog()
  local pass = self._component:IsEventPass(self._levelId, self._eventId)
  local rate = self._component:GetExplorNum(self._levelId)
  local show = self._eventType == EntrustEventType.EntrustEventType_End and not self._passInBegining and pass
  show = show or self._rateInBegining < 100 and 100 <= rate
  self._uiView:OnLevelClose(show)
  self._uiView:CloseDialog()
end

function UIN22EntrustEventBase:SetPlayer(eventId)
  if eventId then
    self._uiView:SetPlayer(eventId)
  end
end

function UIN22EntrustEventBase:SetData(uiView, campaign, component, levelId, eventId)
  self._uiView = uiView
  self._campaign = campaign
  self._component = component
  self._levelId = levelId
  self._eventId = eventId
  self._eventType = self._component:GetEventType(self._eventId)
  self._passInBegining = self._component:IsEventPass(self._levelId, self._eventId)
  self._rateInBegining = self._component:GetExplorNum(self._levelId)
  self:Refresh()
end

function UIN22EntrustEventBase:Refresh()
end

function UIN22EntrustEventBase:_SetRoot(show)
  self:GetGameObject("_root"):SetActive(show)
end

function UIN22EntrustEventBase:_SetCloseBtn()
  self:GetGameObject("CloseBtn"):SetActive(true)
end

function UIN22EntrustEventBase:_SetPass(show)
  self:GetGameObject("_pass"):SetActive(show)
end

function UIN22EntrustEventBase:_SetMainTitle(txt)
  self:GetGameObject("_mainTitle"):SetActive(true)
  UIWidgetHelper.SetLocalizationText(self, "_mainTitle", txt)
end

function UIN22EntrustEventBase:_SetMainDesc(txt)
  self:GetGameObject("_mainDesc"):SetActive(true)
  UIWidgetHelper.SetLocalizationText(self, "_mainDesc", txt)
end

function UIN22EntrustEventBase:_SetTalkIcon(url)
  self:GetGameObject("_talkIcon"):SetActive(true)
  UIWidgetHelper.SetRawImage(self, "_talkIcon", url)
end

function UIN22EntrustEventBase:_SetTalkDesc(txt)
  self:GetGameObject("_talkDesc"):SetActive(true)
  UIWidgetHelper.SetLocalizationText(self, "_talkText", txt)
end

function UIN22EntrustEventBase:_SetStage(isChess, fightLevel, missionCfg, recommendAwaken, recommendLV)
  self:GetGameObject("_stage"):SetActive(true)
  local noLv = true
  local enemy = UIWidgetHelper.SpawnObject(self, "_enemyMsg", "UIEnemyMsg")
  enemy:SetData(fightLevel, nil, self._isChess, noLv)
  local wordAndElemItem = UIWidgetHelper.SpawnObject(self, "_wordAndElem", "UIWordAndElemItem")
  wordAndElemItem:SetData(missionCfg)
  local txt = StringTable.Get("str_discovery_node_recommend_lv")
  local str1 = txt .. " " .. StringTable.Get("str_pet_config_common_advance") .. recommendAwaken
  txt = recommendAwaken and 0 < recommendAwaken and str1 or txt
  local str2 = txt .. " LV." .. recommendLV
  txt = recommendLV and str2 or txt
  UIWidgetHelper.SetLocalizationText(self, "_txtRecommendLV", txt)
end

function UIN22EntrustEventBase:_SetRewards(rewards)
  self:GetGameObject("_desc"):SetActive(true)
  local count = #rewards
  local objs = UIWidgetHelper.SpawnObjects(self, "_rewardPool", "UIN22EntrustRewardItem", count)
  for i = 1, count do
    objs[i]:SetData(rewards[i], false, function(matid, pos)
      UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
    end)
  end
end

function UIN22EntrustEventBase:_SetExitBtn(title, callback)
  self:GetGameObject("ExitBtn"):SetActive(true)
  UIWidgetHelper.SetLocalizationText(self, "_txtExitBtn", title)
  self._exit = callback
end

function UIN22EntrustEventBase:_SetConfirmBtn(enable, title, callback)
  self:GetGameObject("ConfirmBtn"):SetActive(enable)
  self:GetGameObject("ConfirmBtn_Disable"):SetActive(not enable)
  UIWidgetHelper.SetLocalizationText(self, "_txtConfirmBtn", title)
  UIWidgetHelper.SetLocalizationText(self, "_txtConfirmBtn_Disable", title)
  self._confirm = callback
end

function UIN22EntrustEventBase:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIN22EntrustEventBase:ExitBtnOnClick(go)
  if self._exit then
    self._exit()
  end
end

function UIN22EntrustEventBase:ConfirmBtnOnClick(go)
  if self._confirm then
    self._confirm()
  end
end

function UIN22EntrustEventBase:RequestEvent(eventId)
  eventId = eventId or self._eventId
  self._component:Start_HandleCompleteEvent(self._levelId, eventId, function(res, rewards)
    if res:GetSucc() then
      if eventId == self._eventId then
        self:OnEventFinish(rewards)
      else
        self:CloseDialog()
      end
    else
      self._campaign:ShowErrorToast(res.m_result, true)
      self._campaign._campaign_module:CampaignSwitchState(false, UIStateType.UIActivityN22MainController, UIStateType.UIMain, nil, self._campaign._id)
    end
  end)
end

function UIN22EntrustEventBase:OnEventFinish(rewards)
  Log.info("UIN22EntrustEventBase:OnEventFinish()")
end

function UIN22EntrustEventBase:GetCfgCampaignEntrustEvent(eventId)
  eventId = eventId or self._eventId
  local cfg = Cfg.cfg_campaign_entrust_event[eventId]
  if not cfg then
    Log.error("UIN22EntrustEventBase:GetCfgCampaignEntrustEvent() cfg_campaign_entrust_event[", eventId, "] is nil!")
  end
  return cfg
end
