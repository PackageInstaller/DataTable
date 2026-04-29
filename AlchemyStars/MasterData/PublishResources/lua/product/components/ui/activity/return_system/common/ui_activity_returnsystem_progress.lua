_class("UIActivityReturnSystemProgress", UICustomWidget)
UIActivityReturnSystemProgress = UIActivityReturnSystemProgress

function UIActivityReturnSystemProgress:OnShow()
  self._isOpen = true
end

function UIActivityReturnSystemProgress:OnHide()
  self._isOpen = false
end

function UIActivityReturnSystemProgress:SetData(campaign, tipsCallback)
  self._campaign = campaign
  self._tipsCallback = tipsCallback
  self._component = UIActivityReturnSystemHelper.GetComponentByTabName(self._campaign, "quest", 2)
  self:_Refresh()
end

function UIActivityReturnSystemProgress:_Refresh()
  self._cur_progress = self._component:GetCurrentProgress()
  local progress_list = self._component:GetProgressList()
  self._max_progress = progress_list[#progress_list] or 0
  self:_SetProgress(self._cur_progress, self._max_progress)
  self:_SetList(progress_list)
end

function UIActivityReturnSystemProgress:_SetProgress(cur_progress, max_progress)
  UIWidgetHelper.SetSliderValue(self, "_progress", cur_progress, max_progress)
  UIWidgetHelper.SetLocalizationText(self, "text_ProgressCur", math.min(self._cur_progress, self._max_progress))
  UIWidgetHelper.SetLocalizationText(self, "text_ProgressMax", "/" .. self._max_progress)
end

function UIActivityReturnSystemProgress:_SetList(progress_list)
  local objs = UIWidgetHelper.SpawnObjects(self, "_progressPool", "UIActivityReturnSystemProgressListItem", #progress_list)
  for i, v in ipairs(objs) do
    v:SetData(self._campaign, self._component, progress_list[i], function(progress)
      self._component:Start_HandleReceiveReward(progress, function(res, rewards)
        self:_OnReceiveRewards(res, rewards)
      end)
    end, self._tipsCallback)
  end
end

function UIActivityReturnSystemProgress:_OnReceiveRewards(res, rewards)
  if self.view == nil then
    return
  end
  if res:GetSucc() then
    UIActivityHelper.ShowUIGetRewards(rewards)
    self:_Refresh()
  else
    self._campaign:CheckErrorCode(res.m_result, function()
      self:_Refresh()
    end, function()
      self:_Refresh()
    end)
  end
end
