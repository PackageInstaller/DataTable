require("ui_side_enter_center_content_base")
_class("UIActivityTimeLoginContent", UISideEnterCenterContentBase)
UIActivityTimeLoginContent = UIActivityTimeLoginContent

function UIActivityTimeLoginContent:DoInit(params)
  self._campaignType = params and params.campaign_type
  self._componentIds = params and params.component_ids or {}
  self._campaignId = params and params.campaign_id
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_TIMELOGIN
  self._componentId_TimeLogin = ECCampaignInlandTimeLoginComponentID.Time_LOGIN
  self._componentId_Progress = ECCampaignInlandTimeLoginComponentID.PERSON_PROGRESS
  self._campaign = self._data
  self:GetGameObject("CloseBtn"):SetActive(self._type == ESideEnterContentType.Single)
end

function UIActivityTimeLoginContent:DoShow()
  if not self._campaign:CheckComponentOpen(self._componentId_TimeLogin) then
    local result = self._campaign:CheckComponentOpenClientError(self._componentId_TimeLogin)
    self._campaign:CheckErrorCode(result)
    return
  end
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  
  function self._tipsCallback(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
  end
  
  self:_Refresh(true)
  self:_Attach()
end

function UIActivityTimeLoginContent:DoHide()
  UIWidgetHelper.ClearWidgets(self, "_tipsPool")
  self:_Detach()
end

function UIActivityTimeLoginContent:DoDestroy()
end

function UIActivityTimeLoginContent:_ForceRefresh()
  if self._refreshTaskID ~= nil then
    return
  end
  self._refreshTaskID = self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    if res and res:GetSucc() then
      self:_Refresh()
    end
    self._refreshTaskID = nil
  end, self)
end

function UIActivityTimeLoginContent:_Refresh(isFirst)
  self._component_TimeLogin = self._campaign:GetComponent(self._componentId_TimeLogin)
  local componentCfgId = self._component_TimeLogin:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_time_login({ComponentID = componentCfgId})
  if not cfgs or table.count(cfgs) == 0 then
    Log.error("UIActivityTimeLoginContent:_Refresh() cfg_component_time_login {", componentCfgId, "] is nil")
  end
  self._cfgs = cfgs
  self._component_Progress = self._campaign:GetComponent(self._componentId_Progress)
  self._hideItem = self._component_Progress:GetItemId()
  local endTime = self._campaign:GetSample().end_time
  self:_SetRemainingTime("_timePool", "str_activity_common_remainingtime_3", endTime, true)
  self:_SetTitle()
  self:_SetDynamicList()
  self:_SetProgress()
  self:_DynamicListPlayAnimation(isFirst)
end

function UIActivityTimeLoginContent:_SetRemainingTime(widgetName, descId, endTime, customTimeStr)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  if customTimeStr then
    obj:SetCustomTimeStr_Common_1()
  end
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UIActivityTimeLoginContent:_SetTitle()
  local str = StringTable.Get("str_activity_time_login_main_title")
  UIWidgetHelper.SetLocalizationText(self, "_titleText", str)
end

function UIActivityTimeLoginContent:_SetProgress()
  local obj = UIWidgetHelper.SpawnObject(self, "_progressPool", "UIActivityTimeLoginProgress")
  obj:SetData(self._campaign, self._component_Progress, function()
    self:_ForceRefresh()
  end, self._tipsCallback)
end

function UIActivityTimeLoginContent:_SetDynamicList()
  if not self._dynamicListHelper then
    self._dynamicListHelper = UIActivityDynamicListHelper:New(self, self:GetUIComponent("UIDynamicScrollView", "_dynamicList"), "UIActivityTimeLoginCell", function(listItem, itemIndex)
      listItem:SetData(self._campaign, self._component_TimeLogin, self._cfgs[itemIndex], itemIndex == self._itemIndex, self._component_Progress, function()
        self:_ForceRefresh()
      end, function()
        self:_SetItemSelect(itemIndex)
      end, self._tipsCallback)
    end)
  end
  local itemCount = #self._cfgs
  local itemCountPerRow = 1
  self._dynamicListHelper:Refresh(itemCount, itemCountPerRow)
end

function UIActivityTimeLoginContent:_DynamicListPlayAnimation(isPlay)
  if not isPlay then
    return
  end
  local tb = self._dynamicListHelper:GetVisibleItem()
  for _, v in ipairs(tb) do
    v.item:PlayAnimationInSequence(v.index)
  end
end

function UIActivityTimeLoginContent:_SetItemSelect(index)
  self._itemIndex = index
  self:_SetDynamicList()
end

function UIActivityTimeLoginContent:CloseBtnOnClick(go)
  self:CloseDialog(true)
end

function UIActivityTimeLoginContent:_Attach()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIActivityTimeLoginContent:_Detach()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIActivityTimeLoginContent:OnUIGetItemCloseInQuest()
  self:_Refresh()
end
