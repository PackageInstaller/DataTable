_class("UIActivityBattlePassAwardController", UIController)
UIActivityBattlePassAwardController = UIActivityBattlePassAwardController

function UIActivityBattlePassAwardController:_GetBuyGiftComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassAwardController:_GetBuyGiftComponentInfo()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassAwardController:_GetLVRewardComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassAwardController:_GetLVRewardComponentInfo()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassAwardController:_GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseBtnOnClick()
  end)
  self._state_EliteObj = self:GetGameObject("state_Elite")
  self._txtTitleElite = self:GetUIComponent("UILocalizationText", "txtTitleElite")
  self._state_DeluxeObj = self:GetGameObject("state_Deluxe")
  self._txtTitleDeluxe = self:GetUIComponent("UILocalizationText", "txtTitleDeluxe")
  self._txtTitleDeluxe2 = self:GetUIComponent("UILocalizationText", "txtTitleDeluxe2")
  self._state_AdditionObj = self:GetGameObject("state_Addition")
  self._txtTitleAddition2 = self:GetUIComponent("UILocalizationText", "txtTitleAddition2")
end

function UIActivityBattlePassAwardController:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIActivityBattlePassAwardController:OnShow(uiParams)
  self._type = uiParams[1]
  self.callback = uiParams[2]
  self:_AttachEvents()
  self._isOpen = true
  self:_GetComponents()
  self:_SetState()
  self:_SetTitle()
  self:_SetRewards()
end

function UIActivityBattlePassAwardController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
end

function UIActivityBattlePassAwardController:_SetState()
  self._state_EliteObj:SetActive(self._type == CampaignGiftType.ECGT_ADVANCED)
  self._state_DeluxeObj:SetActive(self._type == CampaignGiftType.ECGT_LUXURY)
  self._state_AdditionObj:SetActive(self._type == CampaignGiftType.ECGT_ADDITIONALBUY)
end

function UIActivityBattlePassAwardController:_SetTitle()
  local id = "str_activity_battlepass_buy_deluxe_unlock_desc_elite"
  self._txtTitleElite:SetText(StringTable.Get(id))
  id = "str_activity_battlepass_buy_deluxe_unlock_desc_deluxe"
  self._txtTitleDeluxe:SetText(StringTable.Get(id))
  id = "str_activity_battlepass_buy_deluxe_claim_extra"
  self._txtTitleDeluxe2:SetText(StringTable.Get(id))
  id = "str_activity_battlepass_buy_deluxe_claim"
  self._txtTitleAddition2:SetText(StringTable.Get(id))
end

function UIActivityBattlePassAwardController:_SetRewards()
  local component = self:_GetBuyGiftComponent()
  local giftId = component:GetFirstGiftIDByType(self._type)
  self._dynamicListInfo = component:GetGiftExtraAwardById(giftId)
  self:_SpawnRewards(self._dynamicListInfo, "rewardPool")
end

function UIActivityBattlePassAwardController:_SpawnRewards(rewards, sopName)
  local sop = self:GetUIComponent("UISelectObjectPath", sopName)
  sop:SpawnObjects("UIActivityBattlePassItemIcon", table.count(rewards))
  local items = sop:GetAllSpawnList()
  for i, v in ipairs(items) do
    local lv = self:_CheckLevelReward(rewards[i])
    if lv then
      v:SetData_LvIcon(i, lv)
    else
      v:SetData(i, rewards[i], function(matid, pos)
        UIWidgetHelper.SetAwardItemTips(self, "itemInfoPool", matid, pos)
      end, UIItemScale.Level1)
    end
  end
end

function UIActivityBattlePassAwardController:_CheckLevelReward(reward)
  local componentInfo = self:_GetLVRewardComponentInfo()
  if reward.assetid == componentInfo.m_item_id then
    local lv = reward.count / componentInfo.m_level_max_progress
    if not lv or lv ~= math.floor(lv) then
      Log.fatal("UIActivityBattlePassAwardController:_CheckLevelReward() Reward.count Error!", " cfg_component_buy_gift [ExtraAward]")
    end
    return math.floor(lv)
  end
  return nil
end

function UIActivityBattlePassAwardController:CloseBtnOnClick(go)
  Log.info("UIActivityBattlePassAwardController:CloseBtnOnClick")
  if self.callback then
    self.callback()
  end
  self:CloseDialog()
end

function UIActivityBattlePassAwardController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityBattlePassAwardController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityBattlePassAwardController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end
