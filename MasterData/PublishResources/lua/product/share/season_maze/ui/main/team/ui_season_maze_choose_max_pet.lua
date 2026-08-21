_class("UISeasonMazeChooseMaxPet", UIController)
UISeasonMazeChooseMaxPet = UISeasonMazeChooseMaxPet

function UISeasonMazeChooseMaxPet:Constructor()
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._uiSeasonMazeModule = self._seasonMazeModule.uiModule
end

function UISeasonMazeChooseMaxPet:OnShow(uiParams)
  self._selectPet = nil
  self._allPets = self._uiSeasonMazeModule:GetSeasonMazeCfgPets()
  self:UIWidget()
  self:FlushTeam()
  self:AttachEvent(GameEventType.OnSeasonMazeShowRewardsFinish, self.OnSeasonMazeShowRewardsFinish)
end

function UISeasonMazeChooseMaxPet:OnHide()
end

function UISeasonMazeChooseMaxPet:UIWidget()
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._poolGo = self:GetGameObject("pool")
  self._poolItem = self._pool:SpawnObject("UIPetMemberItem")
  self._btn = self:GetGameObject("BtnGo")
end

function UISeasonMazeChooseMaxPet:FlushTeam()
  self._poolGo:SetActive(self._selectPet ~= nil)
  self._btn:SetActive(self._selectPet == nil)
  if self._selectPet then
    self._poolItem:SMazeSetData(self._selectPet, function()
      local petModule = self:GetModule(PetModule)
      petModule.uiModule:SetTeamCustomPets({
        self._selectPet
      })
      local petid = self._selectPet:GetTemplateID()
      self:ShowDialog("UISpiritDetailGroupController", petid, false, nil, nil, true)
    end)
  end
end

function UISeasonMazeChooseMaxPet:BtnOnClick(go)
  self:OpenChange()
end

function UISeasonMazeChooseMaxPet:SureBtnOnClick(go)
  if self._selectPet then
    self:Lock("UISeasonMazeChooseMaxPet:SureBtnOnClick")
    GameGlobal.TaskManager():StartTask(self.OnSureBtnOnClick, self)
  else
    Log.debug("###[UISeasonMazeChooseMaxPet] self._selectPet is nil !")
  end
end

function UISeasonMazeChooseMaxPet:OnSureBtnOnClick(TT)
  local res = AsyncRequestRes:New()
  local obj = self._seasonMazeModule:CurSeasonObj()
  local com = obj:GetMazeComponent()
  local pstid = self._selectPet:GetPstID()
  com:HandleSeasonMazeSelectFullBreakPet(TT, res, pstid)
  self:UnLock("UISeasonMazeChooseMaxPet:SureBtnOnClick")
  if res:GetSucc() then
    Log.debug("###[UISeasonMazeChooseMaxPet] OnSureBtnOnClick succ ! pstid:", pstid)
    SMazeAdaptor.ChooseFullPetFinish(pstid)
    local showRewards = {}
    local data = SeasonMazeEffect:New()
    data.type = SeasonMazeEffectType.SMET_Pet
    data.id = pstid
    data.value_min = 1
    data.value_max = 1
    table.insert(showRewards, data)
    SeasonMazeTool:GetInstance():ShowUIGetRewards(showRewards)
  else
    Log.error("###[UISeasonMazeChooseMaxPet] OnSureBtnOnClick fail , result:", res:GetResult())
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeChooseMaxPet:OpenChange()
  local havePets = self._uiSeasonMazeModule:GetSeasonMazePets()
  local allPets = self._uiSeasonMazeModule:GetSeasonMazeCfgPets(true, true)
  local filterPets = {}
  for k, v in pairs(allPets) do
    if havePets[k] or self._selectPet and self._selectPet:GetPstID() == k then
    else
      filterPets[k] = v
    end
  end
  self:ShowDialog("UISeasonMazeTeamChangeControllerPrimary", filterPets, function(pstid)
    self._selectPet = filterPets[pstid]
    self:FlushTeam()
  end, nil, nil, nil, self._allPets)
end

function UISeasonMazeChooseMaxPet:OnSeasonMazeShowRewardsFinish(flag)
  self:CloseDialog()
end
