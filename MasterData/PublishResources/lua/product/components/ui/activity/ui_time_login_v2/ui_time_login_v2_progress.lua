_class("UITimeLoginV2Progress", UICustomWidget)
UITimeLoginV2Progress = UITimeLoginV2Progress

function UITimeLoginV2Progress:OnShow(uiParams)
end

function UITimeLoginV2Progress:OnHide()
end

function UITimeLoginV2Progress:SetData(campaign, component, refreshCallback, tipsCallback)
  self._campaign = campaign
  self._component = component
  self._refreshCallback = refreshCallback
  self._tipsCallback = tipsCallback
  self:_Refresh()
end

function UITimeLoginV2Progress:_Refresh()
  self:_SetProtressCur()
  self:_SetProtressImg()
  self:_SetItem()
end

function UITimeLoginV2Progress:_SetProtressCur()
  local cur = self._component:GetCurrentProgress()
  UIWidgetHelper.SetLocalizationText(self, "_txtProgressCur", cur)
end

function UITimeLoginV2Progress:_SetProtressImg()
  local uiRate = {
    {0, 0.12},
    {0.32, 0.55},
    {0.75, 1}
  }
  local rate = self._component:CalcProtressRate_Multi(uiRate)
  local img = self:GetUIComponent("Image", "_imgFill")
  img.fillAmount = rate
end

function UITimeLoginV2Progress:_SetItem()
  local rewards = {}
  local prgList = self._component:GetProgressList()
  for _, v in ipairs(prgList) do
    local roleAssets = self._component:GetProgressRewards(v)
    local roleAsset = roleAssets and roleAssets[1] or RoleAsset:New()
    table.insert(rewards, roleAsset)
  end
  local tb = {
    "_item_1",
    "_item_2",
    "_item_3"
  }
  for i, widgetName in ipairs(tb) do
    local reward = rewards[i]
    local progress = prgList[i]
    local state = self._component:CheckItemStatus(progress)
    local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UITimeLoginV2ProgressItem")
    obj:SetData(reward, progress, state, function()
      self:_OnRecvClick(prgList[i])
    end, self._tipsCallback)
  end
end

function UITimeLoginV2Progress:_OnRecvClick(progress)
  self._component:Start_HandleReceiveReward(progress, function(res, rewards)
    self:_OnReceiveRewards(res, rewards)
  end)
end

function UITimeLoginV2Progress:_OnReceiveRewards(res, rewards)
  if self.view == nil then
    return
  end
  if res:GetSucc() then
    UIActivityHelper.ShowUIGetRewards(rewards)
  else
    self._campaign:CheckErrorCode(res.m_result, function()
      self:_Refresh()
    end, function()
    end)
  end
end
