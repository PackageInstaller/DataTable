_class("UIPopStarTeam", UIController)
UIPopStarTeam = UIPopStarTeam

function UIPopStarTeam:OnShow(uiParams)
  self._levelData = uiParams[1]
  self._callback = uiParams[2]
  self._teamsLoader = self:GetUIComponent("UISelectObjectPath", "Teams")
  self._petLoader = self:GetUIComponent("UISelectObjectPath", "Content")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._tipsGo = self:GetGameObject("Tips")
  local s = self:GetUIComponent("UISelectObjectPath", "skillTips")
  self._skilltips = s:SpawnObject("UIPopStarSkillInfo")
  self._pets = {}
  local cfgs = Cfg.cfg_popstar_pet_list({})
  for k, v in pairs(cfgs) do
    self._pets[#self._pets + 1] = {
      id = v.PetId,
      item = nil
    }
  end
  table.sort(self._pets, function(a, b)
    return a.id < b.id
  end)
  self:AttachEvent(GameEventType.PopStarRefreshTeam, self.Refresh)
  self:Init()
  self:Refresh()
end

function UIPopStarTeam:OnHide()
  self:DetachEvent(GameEventType.PopStarRefreshTeam, self.Refresh)
end

function UIPopStarTeam:Init()
  self._petLoader:SpawnObjects("UIPopStarPetItem", #self._pets)
  local list = self._petLoader:GetAllSpawnList()
  for i = 1, #list do
    local item = list[i]
    self._pets[i].item = item
    item:SetData(self._pets[i].id, 0.8, function(id, pos)
      self:ShowUseSkillTips(id, pos)
    end, "uieff_UIPopStarPetItem_in")
    item:SetEmptyActive(false)
  end
end

function UIPopStarTeam:Refresh(addId)
  local team = self._levelData:GetTeam()
  self._teamsLoader:SpawnObjects("UIPopStarPetItem", #team)
  local list = self._teamsLoader:GetAllSpawnList()
  for i = 1, #list do
    local id = team[i]
    local item = list[i]
    local animName
    if addId == id then
      animName = "uieff_UIPopStarPetItem_in_turn"
    end
    item:SetData(id, 0.8, function(id, pos)
      self:ShowDownSkillTips(id, pos)
    end, animName)
  end
  for i = 1, #self._pets do
    if self._levelData:TeamHasPet(self._pets[i].id) then
      self._pets[i].item:SetActive(false)
    else
      self._pets[i].item:SetActive(true)
    end
  end
end

function UIPopStarTeam:ShowUseSkillTips(petId, pos)
  self._skilltips:SetData(pos, 2, petId, function(id)
    self:StartTask(self.UsePetCoro, self, id)
  end)
end

function UIPopStarTeam:ShowDownSkillTips(petId, pos)
  self._skilltips:SetData(pos, 1, petId, function(id)
    self:StartTask(self.DownPetCoro, self, id)
  end)
end

function UIPopStarTeam:UsePetCoro(TT, id)
  if not self._levelData:IsActivityOpen() then
    return
  end
  self:Lock("UIPopStarTeam_UsePetCoro")
  local ret = self._levelData:AddTeamPet(id)
  if not ret then
    ToastManager.ShowToast(StringTable.Get("str_n31_popstar_tishi_2"))
    self:UnLock("UIPopStarTeam_UsePetCoro")
    return
  end
  local result = self._levelData:UpdateTeam(TT)
  if result == false then
    self._levelData:RemoveTeamPet(id)
  end
  self:Refresh(id)
  self:UnLock("UIPopStarTeam_UsePetCoro")
end

function UIPopStarTeam:DownPetCoro(TT, id)
  if not self._levelData:IsActivityOpen() then
    return
  end
  self:Lock("UIPopStarTeam_DownPetCoro")
  self._levelData:RemoveTeamPet(id)
  local result = self._levelData:UpdateTeam(TT)
  if result == false then
    self._levelData:AddTeamPet(id)
  end
  self:Refresh()
  self:UnLock("UIPopStarTeam_DownPetCoro")
end

function UIPopStarTeam:BtnCloseOnClick()
  if self._callback then
    self._callback()
  end
  self:CloseDialog()
end

function UIPopStarTeam:BtnStartBattleOnClick()
  if not self._levelData:IsActivityOpen() then
    return
  end
  self:StartTask(self.EnterBattle, self)
end

function UIPopStarTeam:EnterBattle(TT)
  self:Lock("UIPopStarTeam_EnterBattle")
  self._levelData:EnterBattle(TT)
  self:UnLock("UIPopStarTeam_EnterBattle")
end

function UIPopStarTeam:BtnSuggestOnClick()
  if not self._levelData:IsActivityOpen() then
    return
  end
  self._tipsGo:SetActive(false)
  self:ShowDialog("UIPopStarTeamSuggest", self._levelData, function()
    self._anim:Play("uieff_UIPopStarTeam_in_02")
    self._tipsGo:SetActive(true)
  end)
end
