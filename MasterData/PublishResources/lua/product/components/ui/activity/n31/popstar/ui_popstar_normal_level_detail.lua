_class("UIPopStarNormalLevelDetail", UIController)
UIPopStarNormalLevelDetail = UIPopStarNormalLevelDetail

function UIPopStarNormalLevelDetail:OnShow(uiParams)
  self._levelData = uiParams[1]
  self._nameLabel = self:GetUIComponent("UILocalizationText", "LevelName")
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._firstRewardsLoader = self:GetUIComponent("UISelectObjectPath", "FirstRewards")
  self._threeStarRewardsLoader = self:GetUIComponent("UISelectObjectPath", "ThreeStarRewards")
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._teamsLoader = self:GetUIComponent("UISelectObjectPath", "Teams")
  self._tips = s:SpawnObject("UISelectInfo")
  local s = self:GetUIComponent("UISelectObjectPath", "skillTips")
  self._skilltips = s:SpawnObject("UIPopStarSkillInfo")
  self:Refresh()
end

function UIPopStarNormalLevelDetail:Refresh()
  self._iconLoader:LoadImage(self._levelData:GetlevelDetailIcon())
  self._nameLabel:SetText(self._levelData:GetName())
  self._desLabel:SetText(self._levelData:GetDes())
  local firstRewards = self._levelData:GetPassReward()
  self._firstRewardsLoader:SpawnObjects("UIPopStarRewardItem", #firstRewards)
  local list = self._firstRewardsLoader:GetAllSpawnList()
  for i = 1, #list do
    local item = list[i]
    item:SetData(firstRewards[i], self._levelData:IsComplete(), 1, function(id, pos)
      self:ShowTips(id, pos)
    end)
  end
  local threeStarRewards = self._levelData:GetThreeStarReward()
  self._threeStarRewardsLoader:SpawnObjects("UIPopStarRewardItem", #threeStarRewards)
  local list = self._threeStarRewardsLoader:GetAllSpawnList()
  for i = 1, #list do
    local item = list[i]
    item:SetData(threeStarRewards[i], self._levelData:IsThreeStarRewardComplete(), 1, function(id, pos)
      self:ShowTips(id, pos)
    end)
  end
  local teams = self._levelData:GetTeam()
  self._teamsLoader:SpawnObjects("UIPopStarPetItem", #teams)
  local list = self._teamsLoader:GetAllSpawnList()
  for i = 1, #list do
    local item = list[i]
    item:SetData(teams[i], 0.8, function(id, pos)
      if id <= 0 then
        return
      end
      self:ShowSkillTips(id, pos)
    end)
  end
end

function UIPopStarNormalLevelDetail:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIPopStarNormalLevelDetail:ShowSkillTips(petId, pos)
  self._skilltips:SetData(pos, 0, petId, nil)
end

function UIPopStarNormalLevelDetail:BtnCloseOnClick()
  self:CloseDialog()
end

function UIPopStarNormalLevelDetail:BtnStartBattleOnClick()
  if not self._levelData:IsActivityOpen() then
    return
  end
  self:StartTask(self.EnterBattle, self)
end

function UIPopStarNormalLevelDetail:EnterBattle(TT)
  self:Lock("UIPopStarNormalLevelDetail_EnterBattle")
  self._levelData:EnterBattle(TT)
  self:UnLock("UIPopStarNormalLevelDetail_EnterBattle")
end
