_class("UIActivityAnniversaryLoginController", UIController)
UIActivityAnniversaryLoginController = UIActivityAnniversaryLoginController
local UIActivityAnniversaryLoginState = {
  TabMain = 1,
  TabPre = 2,
  TabReward = 3
}
_enum("UIActivityAnniversaryLoginState", UIActivityAnniversaryLoginState)

function UIActivityAnniversaryLoginController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_ANNIVERSARY
  self._componentId_1 = ECampaignAnniversaryComponentID.ECAMPAIGN_ANNIVERSARY
  self._componentId_2 = ECampaignAnniversaryComponentID.ECAMPAIGN_RESOURCE_BOX
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, self._componentId_1, self._componentId_2)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._campaign:ClearCampaignNew(TT)
  self._component_1 = self._campaign:GetComponent(self._componentId_1)
  self._component_2 = self._campaign:GetComponent(self._componentId_2)
end

function UIActivityAnniversaryLoginController:OnShow(uiParams)
  self:_AttachEvents()
  self:_Refresh()
  self._matReq = UIWidgetHelper.SetLocalizedTMPMaterial(self, "_title", "AnniversaryLogin_Material.mat", self._matReq)
end

function UIActivityAnniversaryLoginController:OnHide()
  self:_DetachEvents()
end

function UIActivityAnniversaryLoginController:Destroy()
  self._matReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq)
end

function UIActivityAnniversaryLoginController:_Start_ReloadAndRefresh(index)
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    self:_Refresh(index)
  end)
end

function UIActivityAnniversaryLoginController:_Refresh(index)
  if not self._tabIndex then
    local state = self._component_2:GetTimeRewardState(1)
    index = state == ETimeRewardRewardStatus.E_TIME_REWARD_CAN_RECV and 2 or 1
  end
  self._tabIndex = index or self._tabIndex
  self:_SetState(self._tabIndex)
  self:_SetTabPage(self._tabIndex)
end

function UIActivityAnniversaryLoginController:_SetState(index)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {
      "_tabMain",
      "_titleGroup"
    },
    {
      "_tabPre",
      "_titleGroup"
    },
    {"_tabReward"}
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, index)
end

function UIActivityAnniversaryLoginController:_InitTabPage()
  self._objs = {}
  local widgetNames = {
    "_tabMain",
    "_tabPre",
    "_tabReward"
  }
  local classNames = {
    "UIActivityAnniversaryLoginTabMain",
    "UIActivityAnniversaryLoginTabPre",
    "UIActivityAnniversaryLoginTabReward"
  }
  for i = 1, 3 do
    self._objs[i] = UIWidgetHelper.SpawnObject(self, widgetNames[index], classNames[index])
  end
end

function UIActivityAnniversaryLoginController:_SetTabPage(index)
  if not self._objs then
    self._objs = {}
    local components = {
      self._component_1,
      self._component_2,
      self._component_2
    }
    local widgetNames = {
      "_tabMain",
      "_tabPre",
      "_tabReward"
    }
    local classNames = {
      "UIActivityAnniversaryLoginTabMain",
      "UIActivityAnniversaryLoginTabPre",
      "UIActivityAnniversaryLoginTabReward"
    }
    for i = 1, 3 do
      self._objs[i] = UIWidgetHelper.SpawnObject(self, widgetNames[i], classNames[i])
      self._objs[i]:SetData(self._campaign, components[i], function(idx, reload)
        if reload then
          self:_Start_ReloadAndRefresh(idx)
        else
          self:_Refresh(idx)
        end
      end, function()
        self:CloseDialog()
      end, function(matid, pos)
        UIWidgetHelper.SetAwardItemTips(self, "_itemTipsPool", matid, pos)
      end, function(component, rewardID)
        self:_OnTakeBtnClick(component, rewardID)
      end)
    end
  end
  self._objs[index]:Refresh()
end

function UIActivityAnniversaryLoginController:BgBtnOnClick(go)
  self:CloseDialog()
end

function UIActivityAnniversaryLoginController:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIActivityAnniversaryLoginController:_OnTakeBtnClick(component, rewardID)
  component:Start_HandleTakeTimeRewardReward(rewardID, function(res, rewards)
    if rewards == nil then
      Log.error("UIActivityAnniversaryLoginController:_OnTakeBtnClick() rewards = nil")
    end
    self:_OnReceiveRewards(res, rewards)
  end)
end

function UIActivityAnniversaryLoginController:_OnReceiveRewards(res, rewards)
  if self.view == nil then
    return
  end
  if res:GetSucc() then
    UIActivityHelper.ShowUIGetRewards(rewards)
  else
    self._campaign:CheckErrorCode(res.m_result, function()
      self:_Refresh()
    end, function()
      self:CloseDialog()
    end)
  end
end

function UIActivityAnniversaryLoginController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIActivityAnniversaryLoginController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIActivityAnniversaryLoginController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:CloseDialog()
  end
end

function UIActivityAnniversaryLoginController:OnUIGetItemCloseInQuest(type)
  self:_Refresh(UIActivityAnniversaryLoginState.TabMain)
end
