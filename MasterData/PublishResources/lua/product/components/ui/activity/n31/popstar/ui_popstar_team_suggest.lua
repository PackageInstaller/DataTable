_class("UIPopStarTeamSuggest", UIController)
UIPopStarTeamSuggest = UIPopStarTeamSuggest

function UIPopStarTeamSuggest:OnShow(uiParams)
  self._levelData = uiParams[1]
  self._callback = uiParams[2]
  self._loader = self:GetUIComponent("UISelectObjectPath", "Content")
  local s = self:GetUIComponent("UISelectObjectPath", "skillTips")
  self._skilltips = s:SpawnObject("UIPopStarSkillInfo")
  self:Init()
  self:Refresh()
  self:PlayAnimation()
end

function UIPopStarTeamSuggest:Init()
  local suggestTeams = self._levelData:GetSuggestTeams()
  self._loader:SpawnObjects("UIPopStarTeamSuggestItem", #suggestTeams)
end

function UIPopStarTeamSuggest:Refresh()
  local suggestTeams = self._levelData:GetSuggestTeams()
  local list = self._loader:GetAllSpawnList()
  for i = 1, #list do
    local item = list[i]
    item:SetData(suggestTeams[i], self._levelData, function(id, pos)
      self:ShowSkillTips(id, pos)
    end, function(data)
      self:Use(data)
    end)
  end
end

function UIPopStarTeamSuggest:PlayAnimation()
  self:StartTask(self.PlayAnimationCoro, self)
end

function UIPopStarTeamSuggest:PlayAnimationCoro(TT)
  self:Lock("UIPopStarTeamSuggest_PlayAnimationCoro")
  local list = self._loader:GetAllSpawnList()
  for i = 1, #list do
    local item = list[i]
    item:SetActive(false)
  end
  YIELD(TT, 160)
  for i = 1, 3 do
    local item = list[i]
    if item then
      item:SetActive(true)
      YIELD(TT, 30)
    end
  end
  for i = 1, #list do
    local item = list[i]
    item:SetActive(true)
  end
  self:UnLock("UIPopStarTeamSuggest_PlayAnimationCoro")
end

function UIPopStarTeamSuggest:ShowSkillTips(petId, pos)
  self._skilltips:SetData(pos, 0, petId, nil)
end

function UIPopStarTeamSuggest:Use(data)
  self:StartTask(self.UseCoro, self, data)
end

function UIPopStarTeamSuggest:UseCoro(TT, data)
  if not self._levelData:IsActivityOpen() then
    return
  end
  self:Lock("UIPopStarTeamSuggest_UseCoro")
  local team = self._levelData:TeamClone()
  self._levelData:UseTeam(data:GetTeam())
  local result = self._levelData:UpdateTeam(TT)
  if result == false then
    self._levelData:UseTeam(team)
  else
    ToastManager.ShowToast(StringTable.Get("str_n31_popstar_tishi_3"))
  end
  self:Refresh()
  self:UnLock("UIPopStarTeamSuggest_UseCoro")
end

function UIPopStarTeamSuggest:BtnCloseOnClick()
  if self._callback then
    self._callback()
  end
  self:CloseDialog()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PopStarRefreshTeam)
end
