_class("UIPopStarChallengeLevelDetail", UIController)
UIPopStarChallengeLevelDetail = UIPopStarChallengeLevelDetail

function UIPopStarChallengeLevelDetail:OnShow(uiParams)
  self._levelData = uiParams[1]
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._scoreLabel = self:GetUIComponent("UILocalizationText", "Score")
  self._taskLoader = self:GetUIComponent("UISelectObjectPath", "Tasks")
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self:Refresh()
end

function UIPopStarChallengeLevelDetail:Refresh()
  self._iconLoader:LoadImage(self._levelData:GetlevelDetailIcon())
  self._scoreLabel:SetText(self._levelData:GetBestScore())
  local tasks = self._levelData:GetTasks()
  self._taskLoader:SpawnObjects("UIPopStarTaskItem", #tasks)
  local list = self._taskLoader:GetAllSpawnList()
  for i = 1, #list do
    local item = list[i]
    item:SetData(tasks[i], function(id, pos)
      self:ShowTips(id, pos)
    end)
  end
end

function UIPopStarChallengeLevelDetail:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIPopStarChallengeLevelDetail:BtnCloseOnClick()
  self:CloseDialog()
end

function UIPopStarChallengeLevelDetail:BtnStartBattleOnClick()
  if not self._levelData:IsActivityOpen() then
    return
  end
  self:ShowDialog("UIPopStarTeam", self._levelData, function()
    self._anim:Play("uieff_UIPopStarChallengeLevelDetail_in_02")
  end)
end
