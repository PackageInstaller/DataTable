_class("UIActivityBattlePassN5MainController", UIController)
UIActivityBattlePassN5MainController = UIActivityBattlePassN5MainController

function UIActivityBattlePassN5MainController:_GetBuyGiftComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassN5MainController:_GetBuyGiftComponentInfo()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassN5MainController:_GetComponents()
  self._mainBg = self:GetUIComponent("RawImageLoader", "mainBg")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, function()
    self:ShowDialog("UIHelpController", "UIActivityBattlePassMainController")
  end)
  self._tabBtnSelected = {
    self:GetGameObject("rewardTabBtnSelected"),
    self:GetGameObject("questTabBtnSelected")
  }
  self._tabBtnNormal = {
    self:GetGameObject("rewardTabBtnNormal"),
    self:GetGameObject("questTabBtnNormal")
  }
  self._rewardTabBtnRed = self:GetGameObject("rewardTabBtnRed")
  self._questTabBtnRed = self:GetGameObject("questTabBtnRed")
  self._rewardTabObj = self:GetGameObject("rewardTab")
  local rewardTab = self:GetUIComponent("UISelectObjectPath", "rewardTab")
  self._rewardTab = rewardTab:SpawnObject("UIActivityBattlePassN5MainTabReward")
  self._rewardTab:SetData(self._campaign, function()
    self:CloseDialog()
  end)
  self._questTabObj = self:GetGameObject("questTab")
  local questTab = self:GetUIComponent("UISelectObjectPath", "questTab")
  self._questTab = questTab:SpawnObject("UIActivityBattlePassN5MainTabQuest")
  self._questTab:SetData(self._campaign)
end

function UIActivityBattlePassN5MainController:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  local component = self:_GetBuyGiftComponent()
  component:GetAllGiftLocalPrice()
  self._campaign:ClearCampaignNew(TT)
end

function UIActivityBattlePassN5MainController:OnShow(uiParams)
  self._callBack = uiParams[1]
  self:_AttachEvents()
  self._isOpen = true
  self:_GetComponents()
  self:_SetBg(1)
  self:_SetTextSize()
  self._tabIndex = 0
  self:RewardTabBtnOnClick()
  self:_CheckRedPointAll()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityBattlePassN5MainController)
end

function UIActivityBattlePassN5MainController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
  if self._callBack then
    self._callBack()
  end
end

function UIActivityBattlePassN5MainController:_SetBg(idx)
  local url = UIActivityHelper.GetCampaignMainBg(self._campaign, idx)
  if url then
    self._mainBg:LoadImage(url)
  end
end

function UIActivityBattlePassN5MainController:_SetTextSize()
  local tb = {
    self:GetUIComponent("UILocalizationText", "tabBtnText1"),
    self:GetUIComponent("UILocalizationText", "tabBtnText2"),
    self:GetUIComponent("UILocalizationText", "tabBtnText3"),
    self:GetUIComponent("UILocalizationText", "tabBtnText4")
  }
  local language = Localization.GetCurLanguage()
  if language == LanguageType.es or language == LanguageType.pt then
    for _, v in pairs(tb) do
      v.fontSize = 26
    end
  end
end

function UIActivityBattlePassN5MainController:_SetTabBtnSelected(idx)
  for k, v in pairs(self._tabBtnSelected) do
    v:SetActive(k == idx)
  end
  for k, v in pairs(self._tabBtnNormal) do
    v:SetActive(k ~= idx)
  end
end

function UIActivityBattlePassN5MainController:_SetTabPage(resetPos, upgrade, anim_PlayIn, anim_ListItem)
  local tabPages = {
    self._rewardTabObj,
    self._questTabObj
  }
  for i, v in ipairs(tabPages) do
    v:SetActive(i == self._tabIndex)
  end
  local items = {
    self._rewardTab,
    self._questTab
  }
  items[self._tabIndex]:_Refresh(resetPos, upgrade, anim_PlayIn, anim_ListItem)
end

function UIActivityBattlePassN5MainController:_OnTabBtnSelected(index)
  if index ~= self._tabIndex then
    self:Lock(self:GetName() .. "_SwitchTabPage()")
    local items = {
      self._rewardTab,
      self._questTab
    }
    if self._tabIndex > 0 and self._tabIndex <= #items then
      items[self._tabIndex]:_PlayAnimOut(function()
        self:_SwitchTabPage(index)
      end)
    else
      self:_SwitchTabPage(index)
    end
  end
end

function UIActivityBattlePassN5MainController:_SwitchTabPage(index)
  self._tabIndex = index
  self:_SetTabBtnSelected(index)
  self:_SetTabPage(true, 1, true, true)
  self:UnLock(self:GetName() .. "_SwitchTabPage()")
end

function UIActivityBattlePassN5MainController:RewardTabBtnOnClick(go)
  Log.info("UIActivityBattlePassN5MainController:RewardTabBtnOnClick")
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  self:_OnTabBtnSelected(1)
end

function UIActivityBattlePassN5MainController:QuestTabBtnOnClick(go)
  Log.info("UIActivityBattlePassN5MainController:QuestTabBtn")
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  self:_OnTabBtnSelected(2)
end

function UIActivityBattlePassN5MainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.ActivityQuestAwardItemClick, self._OnActivityQuestAwardItemClick)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIActivityBattlePassN5MainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.ActivityQuestAwardItemClick, self._OnActivityQuestAwardItemClick)
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:DetachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIActivityBattlePassN5MainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityBattlePassN5MainController:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckRedPointAll()
  end
end

function UIActivityBattlePassN5MainController:_CheckRedPointAll()
  self:_CheckRedPoint(self._rewardTabBtnRed, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD)
  self:_CheckRedPoint(self._questTabBtnRed, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3)
end

function UIActivityBattlePassN5MainController:_CheckRedPoint(obj, ...)
  local bShow = self._campaign and UIActivityBattlePassHelper.CheckComponentRedPoint(self._campaign, ...)
  obj:SetActive(bShow)
end

function UIActivityBattlePassN5MainController:_OnActivityQuestAwardItemClick(matid, pos)
  UIWidgetHelper.SetAwardItemTips(self, "itemInfoPool", matid, pos)
end

function UIActivityBattlePassN5MainController:OnUIGetItemCloseInQuest(type)
  self:_SetTabPage(true, 2, false, false)
end

function UIActivityBattlePassN5MainController:_OnQuestUpdate()
  self:_SetTabPage(false, 0, false, false)
end
