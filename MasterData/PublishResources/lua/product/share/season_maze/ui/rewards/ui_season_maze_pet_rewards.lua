_class("UISeasonMazePetRewards", UIController)
UISeasonMazePetRewards = UISeasonMazePetRewards

function UISeasonMazePetRewards:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazePetRewards:OnShow(uiParams)
  self._petIDList = {}
  if uiParams then
    self._petIDList = uiParams[1]
    self._callBack = uiParams[2]
  end
  self:InitWidget()
  self:GetPets()
  self:InitUI()
end

function UISeasonMazePetRewards:OnHide()
end

function UISeasonMazePetRewards:InitWidget()
  self.cardPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._uiSeasonMazeModule = self._seasonMazeModule:UIModule()
end

function UISeasonMazePetRewards:InitUI()
  self.cardPool:SpawnObjects("UISeasonMaze_Campsites_Recruit_Item", #self._pets)
  local pools = self.cardPool:GetAllSpawnList()
  self._cellWidgets = pools
  for i = 1, #self._pets do
    local pet = self._pets[i]
    local widget = pools[i]
    widget:SetData(i, pet, self._pets, function(idx)
      self:OnPetClick(idx)
    end)
  end
  self:PlayChooseCardsShowInAnim()
end

function UISeasonMazePetRewards:PlayChooseCardsShowInAnim()
  local lockName = "UISeasonMazePetRewards:PlayChooseCardsShowInAnim"
  self:StartTask(function(TT)
    self:Lock(lockName)
    local eachDelay = 60
    local lockTime = 667
    local maxDelayMs = 0
    if self._cellWidgets then
      for index, widget in ipairs(self._cellWidgets) do
        local delayMs = (index - 1) * eachDelay
        widget:PlayShowInAnim(delayMs)
        maxDelayMs = delayMs
      end
    end
    lockTime = lockTime + maxDelayMs
    YIELD(TT, lockTime)
    self:UnLock(lockName)
  end)
end

function UISeasonMazePetRewards:OnPetClick(idx)
  do return end
  self._chooseIdx = idx
  local pools = self.cardPool:GetAllSpawnList()
  for i = 1, #self._pets do
    local widget = pools[i]
    widget:Select(self._chooseIdx)
  end
  local lockName = "UISeasonMazePetRewards:OnPetClick"
  self:StartTask(function(TT)
    self:Lock(lockName)
    local lockTime = 400
    YIELD(TT, lockTime)
    self:UnLock(lockName)
  end)
end

function UISeasonMazePetRewards:GetPets()
  self._pets = {}
  local currentMazeLv = 1
  local cfg_lvs = Cfg.cfg_component_season_maze_lv({Lv = currentMazeLv})
  local cfg_lv
  if cfg_lvs and next(cfg_lvs) then
    cfg_lv = cfg_lvs[1]
  else
    Log.error("###[UISeasonMaze_Campsites_Recruit] cfg_lvs is nil ! id --> ", currentMazeLv)
  end
  local petModule = GameGlobal.GetModule(PetModule)
  for index, value in ipairs(self._petIDList) do
    local pstid = 0
    local templateID = value
    local level = 1
    local grade = 0
    local awake = 0
    local equip = 0
    local skinId = 0
    local localPetData = petModule:GetPetByTemplateId(templateID)
    if localPetData then
      pstid = localPetData:GetPstID()
      awake = localPetData:GetPetAwakening()
      if cfg_lv.PetAwake and 0 < cfg_lv.PetAwake then
        awake = cfg_lv.PetAwake
      end
      grade = localPetData:GetPetGrade()
      level = localPetData:GetPetLevel()
      if cfg_lv.PetGrade and 0 < cfg_lv.PetGrade then
        grade = cfg_lv.PetGrade
        if cfg_lv.PetLv and 0 < cfg_lv.PetLv then
          level = cfg_lv.PetLv
        end
        grade, level = self._uiSeasonMazeModule:GetPetGradeLv(templateID, grade, level)
      end
      equip = localPetData:GetEquipLv()
      if cfg_lv.PetEquip and 0 < cfg_lv.PetEquip then
        equip = cfg_lv.PetEquip
      end
      skinId = localPetData:GetSkinId()
    else
      if cfg_lv.PetAwake and 0 < cfg_lv.PetAwake then
        awake = cfg_lv.PetAwake
      end
      if cfg_lv.PetGrade and 0 < cfg_lv.PetGrade then
        grade = cfg_lv.PetGrade
        if cfg_lv.PetLv and 0 < cfg_lv.PetLv then
          level = cfg_lv.PetLv
        end
        grade, level = self._uiSeasonMazeModule:GetPetGradeLv(templateID, grade, level)
      end
      if cfg_lv.PetEquip and 0 < cfg_lv.PetEquip then
        equip = cfg_lv.PetEquip
      end
    end
    local codeCheckPetData = _G.pet_data
    local tempData = codeCheckPetData:New()
    tempData.pet_pstid = pstid
    tempData.template_id = templateID
    tempData.current_skin = skinId or 0
    local pet = Pet:New(tempData)
    tempData.grade = grade
    tempData.level = level
    tempData.awakening = awake
    tempData.equip_lv = equip
    pet:SetData(tempData)
    table.insert(self._pets, pet)
  end
end

function UISeasonMazePetRewards:AnimClose()
  self:CloseDialog()
end

function UISeasonMazePetRewards:CloseBtnOnClick(go)
  self:AnimClose()
  if self._callBack then
    self._callBack()
  end
end
