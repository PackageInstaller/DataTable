_class("UIActivityBattlePassMainController", UIController)
UIActivityBattlePassMainController = UIActivityBattlePassMainController

function UIActivityBattlePassMainController:_GetBuyGiftComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassMainController:_GetBuyGiftComponentInfo()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassMainController:_GetComponents()
  self._mainBg = self:GetUIComponent("RawImageLoader", "mainBg")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, function()
    self:ShowDialog("UIHelpController", "UIActivityBattlePassMainController")
  end)
  self._rewardTabBtnRed = self:GetGameObject("rewardTabBtnRed")
  self._questTabBtnRed = self:GetGameObject("questTabBtnRed")
  self._rewardTabObj = self:GetGameObject("rewardTab")
  local rewardTab = self:GetUIComponent("UISelectObjectPath", "rewardTab")
  self._rewardTab = rewardTab:SpawnObject("UIActivityBattlePassMainTabReward")
  self._rewardTab:SetData(self._campaign, function()
    self:CloseDialog()
  end)
  self._questTabObj = self:GetGameObject("questTab")
  local questTab = self:GetUIComponent("UISelectObjectPath", "questTab")
  self._questTab = questTab:SpawnObject("UIActivityBattlePassMainTabQuest")
  self._questTab:SetData(self._campaign)
end

function UIActivityBattlePassMainController:LoadDataOnEnter(TT, res, uiParams)
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

function UIActivityBattlePassMainController:OnShow(uiParams)
  self:_AttachEvents()
  self._isOpen = true
  self:_GetComponents()
  self:_SetBg(1)
  self._tabIndex = 0
  self:RewardTabBtnOnClick()
  self:_CheckRedPointAll()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityBattlePassMainController)
end

function UIActivityBattlePassMainController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
end

function UIActivityBattlePassMainController:_SetBg(idx)
  local url = UIActivityHelper.GetCampaignMainBg(self._campaign, idx)
  if url then
    self._mainBg:LoadImage(url)
  end
end

function UIActivityBattlePassMainController:_SetTabBtn(name, idx)
  local atlas = self:GetAsset("UIBattlePass.spriteatlas", LoadType.SpriteAtlas)
  local bg = self:GetUIComponent("Image", name)
  local bgId = self._tabIndex == idx and "pass_jiangli_btn1" or "pass_jiangli_btn2"
  bg.sprite = atlas:GetSprite(bgId)
end

function UIActivityBattlePassMainController:_SetTabPage(resetPos, upgrade)
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
  items[self._tabIndex]:_Refresh(resetPos, upgrade)
end

function UIActivityBattlePassMainController:_OnTabBtnSelected(index)
  if index ~= self._tabIndex then
    self._tabIndex = index
    self:_SetTabBtn("rewardTabBtn", 1)
    self:_SetTabBtn("questTabBtn", 2)
    self:_SetTabPage(false, false)
  end
end

function UIActivityBattlePassMainController:RewardTabBtnOnClick(go)
  Log.info("UIActivityBattlePassMainController:RewardTabBtnOnClick")
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  self:_OnTabBtnSelected(1)
end

function UIActivityBattlePassMainController:QuestTabBtnOnClick(go)
  Log.info("UIActivityBattlePassMainController:QuestTabBtn")
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  self:_OnTabBtnSelected(2)
end

function UIActivityBattlePassMainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.ActivityQuestAwardItemClick, self._OnActivityQuestAwardItemClick)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIActivityBattlePassMainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.ActivityQuestAwardItemClick, self._OnActivityQuestAwardItemClick)
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:DetachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIActivityBattlePassMainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityBattlePassMainController:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckRedPointAll()
  end
end

function UIActivityBattlePassMainController:_CheckRedPointAll()
  self:_CheckRedPoint(self._rewardTabBtnRed, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD)
  self:_CheckRedPoint(self._questTabBtnRed, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3)
end

function UIActivityBattlePassMainController:_CheckRedPoint(obj, ...)
  local bShow = self._campaign and UIActivityBattlePassHelper.CheckComponentRedPoint(self._campaign, ...)
  obj:SetActive(bShow)
end

function UIActivityBattlePassMainController:_OnActivityQuestAwardItemClick(matid, pos)
  UIWidgetHelper.SetAwardItemTips(self, "itemInfoPool", matid, pos)
end

function UIActivityBattlePassMainController:OnUIGetItemCloseInQuest(type)
  self:_SetTabPage(true, true)
end

function UIActivityBattlePassMainController:_OnQuestUpdate()
  self:_SetTabPage(false, false)
end
