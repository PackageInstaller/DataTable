_class("UIN12SynopsisController", UIController)
UIN12SynopsisController = UIN12SynopsisController

function UIN12SynopsisController:OnShow(uiParams)
  self:_GetComponent()
  self:_SetValue(uiParams)
  self:_SetShow()
end

function UIN12SynopsisController:_GetComponent()
  self._picture = self:GetUIComponent("RawImageLoader", "_picture")
  self._pictureGO = self:GetUIComponent("RectTransform", "_picture")
  self._rewardState = self:GetGameObject("_rewardState")
  self._name = self:GetUIComponent("UILocalizationText", "_name")
  self._missingidx = self:GetUIComponent("UILocalizationText", "_missingidx")
  self._describe = self:GetUIComponent("UILocalizationText", "_describe")
  self._bg = self:GetGameObject("_bg")
  self._describetxt = self:GetUIComponent("UILocalizationText", "_describetxt")
  self._transition = self:GetUIComponent("ATransitionComponent", "_syn")
end

function UIN12SynopsisController:_SetValue(uiParams)
  self._story = uiParams[1]
  self._story_component = uiParams[2]
  self._callback = uiParams[3]
  self._photo = uiParams[4]
  self._idx = uiParams[5]
  self._callback1 = uiParams[6]
  self._rewards = Cfg.cfg_campaign_story[self._story].RewardList
  self._isGetAward = false
end

function UIN12SynopsisController:_SetShow()
  self._transition:PlayEnterAnimation(true)
  local reward = self:GetUIComponent("UISelectObjectPath", "_reward")
  reward:SpawnObjects("UIN12SynAwardItem", #self._rewards)
  self._reward = reward:GetAllSpawnList()
  local iteminfo = self:GetUIComponent("UISelectObjectPath", "_iteminfo")
  self._iteminfo = iteminfo:SpawnObject("UISelectInfo")
  self._describetxt:SetText(StringTable.Get(self._photo.Describe))
  self._name:SetText(StringTable.Get(self._photo.Name))
  self._missingidx:SetText(string.format("%02d", self._idx))
  for i = 1, #self._rewards do
    self._reward[i]:SetData(self._rewards[i], self:CheckStoryGotAwards(self._idx), function(matid, pos)
      self._iteminfo:SetData(matid, pos)
    end)
  end
  self._picture:LoadImage(self._photo.Icon)
  local size = self._photo.Size
  self._pictureGO.sizeDelta = Vector2(size[1], size[2])
  if self:CheckStoryGotAwards(self._idx) then
    self:_SetState(true)
  else
    self:_SetState(false)
  end
end

function UIN12SynopsisController:_SetState(isGet)
  self._rewardState:SetActive(isGet)
end

function UIN12SynopsisController:btnOnClick(go)
  if self._callback1() then
    return
  end
  if not self._story then
    Log.error("### [UIActivityPlotEnter] no story")
    return
  end
  self:ShowDialog("UIStoryController", self._story, function()
    self:GetPlotAward()
  end)
  self:CloseDialog()
end

function UIN12SynopsisController:_closeOnClick(go)
  self:CloseDialog()
end

function UIN12SynopsisController:GetPlotAward()
  if not self:CheckStoryGotAwards(self._idx) then
    self:Lock("UIN12SynopsisController:GetPlotAward")
    GameGlobal.TaskManager():StartTask(self.OnGetPlotAward, self)
  end
end

function UIN12SynopsisController:OnGetPlotAward(TT)
  local request = AsyncRequestRes:New()
  local rewards = self._story_component:HandleStoryTake(TT, request, self._story)
  self:UnLock("UIN12SynopsisController:GetPlotAward")
  self.issucc = request:GetSucc()
  if self.issucc then
    self:ShowDialog("UIGetItemController", rewards, function()
      if self._callback then
        self._callback()
      end
    end)
  end
end

function UIN12SynopsisController:CheckStoryGotAwards(idx)
  local recv_list = self._story_component:GetAlreadyReceivedStoryIdList()
  return table.icontains(recv_list, self._story)
end
