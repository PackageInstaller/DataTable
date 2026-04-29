_class("UISeasonMazeModule", UIModule)
UISeasonMazeModule = UISeasonMazeModule

function UISeasonMazeModule:Enter(battleExitState)
  local mazeID = GameGlobal.GetModule(SeasonMazeModule):CurSeasonMazeID()
  if not mazeID or mazeID <= 0 then
    Log.exception("获取不到当前开放的赛季秘境 不能进入")
    return
  end
  self._seasonID = Cfg.cfg_season_maze_client[mazeID].SeasonID
  local cfg = Cfg.cfg_season_map[self._seasonID]
  local mapRes = cfg and cfg.MapRes
  self._battleExitState = battleExitState or SMazeBattleExitState.None
  self._isBossBattle = nil
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.SeasonMaze_Enter, mapRes)
end

function UISeasonMazeModule:Run(mazeID)
  self._manager = SeasonMazeManager:New(mazeID)
  self._manager:Init()
  self._running = true
  self:AttachEvent(GameEventType.OnBattleStartLoading, self.OnBattleLoading)
  self:AttachEvent(GameEventType.BeforeRelogin, self.DisposeLogic)
end

function UISeasonMazeModule:GetAndClearBattleExitState()
  local tmp = self._battleExitState
  self._battleExitState = nil
  return tmp
end

function UISeasonMazeModule:Update(dt)
  if self._running then
    self._manager:Update(GameGlobal:GetInstance():GetDeltaTime())
  end
end

function UISeasonMazeModule:ExitTo(uistate)
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.SeasonMaze_Exit, "UI", uistate)
end

function UISeasonMazeModule:OnBattleLoading()
  local cmp = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj():GetMazeComponent()
  self._isBossBattle = cmp:CurOperate() == SeasonMazeActionState.SMAS_BossBattle
  if self._isBossBattle then
    self._goldBeforeBossBattle = cmp:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  end
  self:DisposeLogic()
end

function UISeasonMazeModule:_GetAndClearGoldBeforeBossBattle()
  local tmp = self._goldBeforeBossBattle
  self._goldBeforeBossBattle = nil
  return tmp
end

function UISeasonMazeModule:DisposeLogic()
  if self._manager then
    self._manager:Dispose()
  end
  self._manager = nil
  self._running = false
  self._seasonID = nil
  self._tempRoomUI = nil
  self:DetachEvent(GameEventType.OnBattleStartLoading)
  self:DetachEvent(GameEventType.BeforeRelogin)
end

function UISeasonMazeModule:IsRunning()
  return self._running
end

function UISeasonMazeModule:GetSeasonID()
  return self._seasonID
end

function UISeasonMazeModule:SeasonMazeManager()
  return self._manager
end

function UISeasonMazeModule.PopMsgBox(title, desc, uiType, okCb, okCbParams, cancelCb, cancelCbParams, afterShowCb)
  GameGlobal.UIStateManager():ShowDialog("UISeasonMazeMsgBox", title, desc, uiType, okCb, okCbParams, cancelCb, cancelCbParams, afterShowCb)
end

function UISeasonMazeModule:TryExitBattle(matchEnterData, isWin)
  if matchEnterData:GetMatchType() == MatchType.MT_SeasonMaze then
    local state
    if self._isBossBattle and isWin then
      state = SMazeBattleExitState.BossBattleSuccess
    elseif self._isBossBattle and not isWin then
      state = SMazeBattleExitState.BossBattleFailed
    elseif not self._isBossBattle and isWin then
      state = SMazeBattleExitState.RoomBattleSuccess
    elseif not self._isBossBattle and not isWin then
      state = SMazeBattleExitState.RoomBattleFailed
    end
    self:Enter(state)
    return true
  end
  return false
end

function UISeasonMazeModule.OpenHelpUI(tabIdx, pageIdx)
  GameGlobal.UIStateManager():ShowDialog("UISMazeS1HelperController", tabIdx, pageIdx)
end

function UISeasonMazeModule:GetSeasonMazePets(condition)
  local pets = {}
  local obj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
  local com = obj:GetMazeComponent()
  local comInfo = com:GetComponentInfo()
  local bagInfo = comInfo.m_bag_info
  local seasonMazePets = bagInfo.pet_list
  for id, info in pairs(seasonMazePets) do
    if condition then
      if condition(info) then
        local matchPet = self:CreateMatchPet(info)
        pets[id] = matchPet
      end
    else
      local matchPet = self:CreateMatchPet(info)
      pets[id] = matchPet
    end
  end
  return pets
end

function UISeasonMazeModule:GetSeasonMazeTablePets(condition)
  local tablePets = {}
  local pets = self:GetSeasonMazePets(condition)
  for key, value in pairs(pets) do
    tablePets[#tablePets + 1] = value
  end
  return tablePets
end

function UISeasonMazeModule:GetSeasonMazeRelics()
  local relics = {}
  local obj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
  local com = obj:GetMazeComponent()
  local comInfo = com:GetComponentInfo()
  local bagInfo = comInfo.m_bag_info
  local seasonMazeRelics = bagInfo.relic_list
  return seasonMazeRelics
end

function UISeasonMazeModule:GetSeasonMazeRelicCanUseCount(id)
  local relics = self:GetSeasonMazeRelics()
  if relics[id] ~= nil then
    return relics[id].residueCnt
  end
  return 1
end

function UISeasonMazeModule:GetSeasonMazeActionCards()
  local relics = {}
  local obj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
  local com = obj:GetMazeComponent()
  local comInfo = com:GetComponentInfo()
  local wait_hands = comInfo.wait_hands
  local fold_hands = comInfo.fold_hands
  local seasonActionCards = {}
  for i = 1, #wait_hands do
    local item = wait_hands[i]
    seasonActionCards[#seasonActionCards + 1] = item
  end
  for i = 1, #fold_hands do
    local item = fold_hands[i]
    seasonActionCards[#seasonActionCards + 1] = item
  end
  return seasonActionCards
end

function UISeasonMazeModule:CreateMatchPet(SeasonMazePetInfo)
  local tid = SeasonMazePetInfo.petID
  local MatchPetInfo = MatchPetInfo:New()
  MatchPetInfo.pet_pstid = tid
  local petModule = GameGlobal.GetModule(PetModule)
  local havePet = petModule:GetPetByTemplateId(tid)
  local obj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
  local com = obj:GetMazeComponent()
  local comInfo = com:GetComponentInfo()
  local cfgid = com:GetComponentCfgId()
  local curLv = com:GetAttrValue(SeasonMazeAttrType.SMAT_Lv)
  local cfg_lvs = Cfg.cfg_component_season_maze_lv({ComponentID = cfgid, Lv = curLv})
  local cfg_lv
  if cfg_lvs and next(cfg_lvs) then
    cfg_lv = cfg_lvs[1]
  else
    Log.error("###[UISeasonMazeModule] cfg_lvs is nil ! comcfgid:", cfgid)
  end
  local petBreak = SeasonMazePetInfo.break_though_lv
  local currSkin
  if havePet then
    currSkin = havePet:GetSkinId()
  else
    currSkin = 0
  end
  MatchPetInfo.awakening = petBreak
  MatchPetInfo.grade, MatchPetInfo.level = self:GetPetGradeLv(tid, cfg_lv.PetGrade, cfg_lv.PetLv)
  MatchPetInfo.equip_lv = cfg_lv.PetEquip
  MatchPetInfo.current_skin = currSkin
  MatchPetInfo.template_id = tid
  local matchPet = Pet:New(MatchPetInfo)
  return matchPet
end

function UISeasonMazeModule:CreateMatchPetByID(tid, mazeLv, maxAwaken)
  if not tid or tid <= 0 then
    return nil
  end
  local MatchPetInfo = MatchPetInfo:New()
  MatchPetInfo.pet_pstid = tid
  local petModule = GameGlobal.GetModule(PetModule)
  local havePet = petModule:GetPetByTemplateId(tid)
  local obj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
  local com = obj:GetMazeComponent()
  local comInfo = com:GetComponentInfo()
  local cfgid = com:GetComponentCfgId()
  local get_cfg_by_lv
  if mazeLv then
    get_cfg_by_lv = mazeLv
  else
    local curLv = com:GetAttrValue(SeasonMazeAttrType.SMAT_Lv)
    get_cfg_by_lv = curLv
  end
  local cfg_lvs = Cfg.cfg_component_season_maze_lv({ComponentID = cfgid, Lv = get_cfg_by_lv})
  local cfg_lv
  if cfg_lvs and next(cfg_lvs) then
    cfg_lv = cfg_lvs[1]
  else
    Log.error("###[UISeasonMazeModule] cfg_lvs is nil ! comcfgid:", cfgid, get_cfg_by_lv)
  end
  local petBreak, currSkin
  if havePet then
    if maxAwaken then
      petBreak = self:GetPetMaxAwaken(tid)
    else
      local tmpBreak = havePet:GetPetAwakening()
      local cfgBreak = cfg_lv.PetAwake
      petBreak = math.max(tmpBreak, cfgBreak)
    end
    currSkin = havePet:GetSkinId()
  else
    if maxAwaken then
      petBreak = self:GetPetMaxAwaken(tid)
    else
      petBreak = self:GetPetAwake(tid, cfg_lv.PetAwake)
    end
    currSkin = 0
  end
  MatchPetInfo.awakening = petBreak
  MatchPetInfo.grade, MatchPetInfo.level = self:GetPetGradeLv(tid, cfg_lv.PetGrade, cfg_lv.PetLv)
  MatchPetInfo.equip_lv = cfg_lv.PetEquip
  local hp = 0
  local cfg_pet_level = Cfg["cfg_pet_level_" .. tid .. "_" .. MatchPetInfo.grade]({
    Level = MatchPetInfo.level
  })[1]
  hp = cfg_pet_level.Health
  local cfg_pet_grade = Cfg.cfg_pet_grade({
    PetID = tid,
    Grade = MatchPetInfo.grade
  })[1]
  hp = hp + cfg_pet_grade.Health
  if petBreak and 0 < petBreak then
    local cfg_pet_awakening = Cfg.cfg_pet_awakening({PetID = tid, Awakening = petBreak})[1]
    hp = hp + cfg_pet_awakening.Health
  end
  if cfg_lv.PetEquip and 0 < cfg_lv.PetEquip then
    local cfg_pet_equip = Cfg.cfg_pet_equip({
      PetID = tid,
      Level = cfg_lv.PetEquip
    })[1]
    hp = hp + cfg_pet_equip.Health
  end
  MatchPetInfo.max_hp = hp
  MatchPetInfo.current_skin = currSkin
  MatchPetInfo.template_id = tid
  local matchPet = Pet:New(MatchPetInfo)
  return matchPet
end

function UISeasonMazeModule:GetPetMaxAwaken(tid)
  local cfgs = Cfg.cfg_pet_awakening({PetID = tid})
  local max = 0
  if cfgs ~= nil then
    for _, c in ipairs(cfgs) do
      if max < c.Awakening then
        max = c.Awakening
      end
    end
  end
  return max
end

function UISeasonMazeModule:_CalcPetMaxLevel(templateId, grade)
  local cfgs = Cfg["cfg_pet_level_" .. templateId .. "_" .. grade]()
  local max = 1
  for _, c in pairs(cfgs) do
    if max < c.Level then
      max = c.Level
    end
  end
  return max
end

function UISeasonMazeModule:GetPetGradeLv(tid, grade, lv)
  local tmpGrade = grade
  local tmpLv = lv
  local cfgs = Cfg.cfg_pet_grade({PetID = tid})
  if not cfgs then
    Log.fatal("UISeasonMazeModule cfg_pet_grade can't find PetID ", tid)
  end
  local max = 0
  for _, c in ipairs(cfgs) do
    if max < c.Grade then
      max = c.Grade
    end
  end
  if grade > max then
    tmpGrade = max
    tmpLv = self:_CalcPetMaxLevel(tid, tmpGrade)
  end
  return tmpGrade, tmpLv
end

function UISeasonMazeModule:GetPetAwake(tid, awake)
  local tmpAwake = awake
  local cfgs = Cfg.cfg_pet_awakening({PetID = tid})
  local max = 0
  if cfgs ~= nil then
    for _, c in ipairs(cfgs) do
      if max < c.Awakening then
        max = c.Awakening
      end
    end
  end
  if awake > max then
    tmpAwake = max
  end
  return tmpAwake
end

function UISeasonMazeModule:GetPetPower(tid, pet)
  local obj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
  local com = obj:GetMazeComponent()
  local comInfo = com:GetComponentInfo()
  local bagInfo = comInfo.m_bag_info
  local seasonMazePets = bagInfo.pet_list
  local Pet = seasonMazePets[tid]
  if Pet then
    local power = Pet.pow
    if power < 0 then
    else
      return power
    end
  end
  local activeSkillID = pet:GetPetActiveSkill()
  local cfg = BattleSkillCfg(activeSkillID)
  return cfg.TriggerParam
end

function UISeasonMazeModule:GetPetState(petid, type)
  local obj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
  local com = obj:GetMazeComponent()
  return com:GetPetState(petid, type)
end

function UISeasonMazeModule:GetPetHP(tid, pet)
  local obj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
  local com = obj:GetMazeComponent()
  local comInfo = com:GetComponentInfo()
  local bagInfo = comInfo.m_bag_info
  local seasonMazePets = bagInfo.pet_list
  local Pet = seasonMazePets[tid]
  if Pet == nil then
    return pet:GetPetHealth(), pet:GetPetHealth()
  end
  local hpPrcent = Pet.cur_blood_prcent
  local maxHp = Pet.max_hp
  local curHp = math.ceil(maxHp * hpPrcent)
  return curHp, maxHp
end

function UISeasonMazeModule:GetSeasonMazeCfgPets(useMazeLv, awaken)
  local pets = {}
  local mlv
  if not useMazeLv then
    mlv = 1
  end
  local cfgs = self:SeasonMazeCfgPets()
  for key, value in pairs(cfgs) do
    local matchPet = self:CreateMatchPetByID(key, mlv, awaken)
    pets[key] = matchPet
  end
  return pets
end

function UISeasonMazeModule:SeasonMazeCfgPets()
  local pets = {}
  local cfgs = Cfg.cfg_season_maze_pet({})
  for key, value in pairs(cfgs) do
    pets[value.ID] = value.ID
  end
  return pets
end

function UISeasonMazeModule:SeasonMazeCfgBanPetList()
  local pets = {}
  local banCfgs = Cfg.cfg_season_maze_pet({Ban = 1})
  if banCfgs then
    for index, value in ipairs(banCfgs) do
      table.insert(pets, value.ID)
    end
  end
  return pets
end

function UISeasonMazeModule:SetTempRoom(uiname)
  self._tempRoomUI = uiname
end

function UISeasonMazeModule:GetTempRoom()
  return self._tempRoomUI
end

function UISeasonMazeModule:ReturnTempRoom(uiparams)
  if self._tempRoomUI then
    GameGlobal.UIStateManager():ShowDialog(self._tempRoomUI, uiparams)
  end
  self._tempRoomUI = nil
end

function UISeasonMazeModule:OnAttrChanged(attId, reason, oldValue, newValue)
  if self._running then
    self._manager:RelicManager():CheckRelicEft(attId, reason, oldValue, newValue)
  end
end
