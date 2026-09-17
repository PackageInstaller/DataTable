local cls = class("pagePetPrepareDuel", G_UIPageBase)
local _kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
local _unitTpl = L_GameTpl:getUnitTpl()
local _heroInterimTpl = L_GameTpl:getHeroInterimTpl()
local _trialPetTpl = L_GameTpl:getTrialPetTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _kiboDuelChapterTpl = L_GameTpl:getKiBoDuelChapterTpl()
local _kiboDuelGroupTpl = L_GameTpl:getKiBoDuelGroupTpl()
local _elementTypeTpl = L_GameTpl:getElementTypeTpl()
local _scenePrefabPath = "Program/UIScene/pre_petDuelScene_ui_01.prefab"

function cls.bind()
  return {
    list_playerPet = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelEntranceNew"
    },
    list_enemyPet = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelEntranceNew"
    },
    active_txt_duelTip = false,
    active_btnBlack = true,
    active_btnGrey = false,
    txt_duelTip = "",
    active_plotNode = true,
    active_btnFormationNode = false,
    modulePetDuelRecElement = {
      moduleName = "pages/petDuelOutside/modulePetDuelRecElement"
    }
  }
end

function cls.methods()
  return {
    onClick_setFormation = function(self)
      if C_KiboDuelSystemMgr:IsTrialDuel(self.levelId) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_duel_block_formation"))
        return
      end
      L_UI:open("pagePetDuelFormationNew", {
        levelId = self.levelId,
        heroParent = self.heroParent,
        formationModeCamera = self.formationModeCamera,
        HeroChangeCamera = self.HeroChangeCamera
      })
    end,
    onClick_startDuel = function(self)
      self:onBtnStartDuel()
    end
  }
end

function cls:preOpen(options)
  cls.super.preOpen(self, options)
  self.levelId = options.levelId
  self.isRestore = options.isRestore
  L_PetDuelStore:setCurChallengeLevelId(self.levelId)
  self.levelMode = options.levelMode
  self.kiBoDuelCfg = _kiBoDuelTpl:getTplById(self.levelId)
  if not self.kiBoDuelCfg then
    errorf("kiBoDuelCfg is nil, levelId: " .. tostring(self.levelId))
  end
  self.levelType = _kiBoDuelTpl:getLevelType(self.kiBoDuelCfg)
  self.bInit = false
  self.bHeroModLoaded = false
  self.bNpcModLoaded = false
  self.modules.modulePetDuelRecElement:initModule(self.levelId)
end

function cls:show(options)
  L_PetDuelStore:listenCallFunc(L_PetDuelStore.event.refresh_formationInfo, self.refreshSelfFormationInfo, self)
  self:openPetDuelScene()
end

function cls:openPetDuelScene()
  if self.isRestore ~= nil and self.isRestore == true then
    L_UI:close("pageDungeonEntrustEntrance")
  end
  L_UIModelMgr:LoadHeroScenePrefabAsync(_scenePrefabPath, function(go)
    C_UISceneManager.SetSceneVisible()
    self.heroParent = go.transform:Find("PlayerModelRoot")
    self.npcParent = go.transform:Find("NpcModelRoot")
    self.prepareModeCamera = go.transform:Find("petCameraPrepare").gameObject
    self.formationModeCamera = go.transform:Find("petCameraFormation").gameObject
    self.HeroChangeCamera = go.transform:Find("petCameraHeroChange").gameObject
    self.bg = go.transform:Find("BgRoot/BgFullScreen_bg").gameObject
    self.bg_prepare_front = go.transform:Find("BgRoot/BgFullScreen_bg_prepare_front").gameObject
    self.bg_prepare_back = go.transform:Find("BgRoot/BgFullScreen_bg_prepare_back").gameObject
    self:changeMode(true)
    if _kiBoDuelTpl:isKiboLock(self.levelId) then
      local info = L_PetDuelStore:getPetDuelFormationGroupInfo(L_Const.kiBoDuelBlockSlot)
      if info.levelId ~= self.levelId then
        L_PetDuelStore:req_CSProtoKiboDuelGetGroup(self.levelId, function()
          self:initPage()
        end)
      else
        self:initPage()
      end
    else
      self:initPage()
    end
  end)
end

function cls:changeMode(isPrepare)
  if L_CommonUtil.isValid(self.prepareModeCamera) then
    L_CommonUtil.setObjActive(self.prepareModeCamera, isPrepare)
    if self.prepareModeCamera.activeSelf then
      L_CommonUtil.setObjActive(self.bg, false)
      L_CommonUtil.setObjActive(self.bg_prepare_front, true)
      L_CommonUtil.setObjActive(self.bg_prepare_back, true)
    end
  end
  if L_CommonUtil.isValid(self.formationModeCamera) then
    L_CommonUtil.setObjActive(self.formationModeCamera, not isPrepare)
    if self.formationModeCamera.activeSelf then
      L_CommonUtil.setObjActive(self.bg, true)
      L_CommonUtil.setObjActive(self.bg_prepare_front, false)
      L_CommonUtil.setObjActive(self.bg_prepare_back, false)
    end
  end
  if L_CommonUtil.isValid(self.HeroChangeCamera) then
    L_CommonUtil.setObjActive(self.HeroChangeCamera, false)
  end
end

function cls:initPage()
  self:initModNPC()
  self.curHeroGuid = -1
  if C_KiboDuelSystemMgr:IsTrialDuel(self.levelId) then
    self:refreshTrialDuelInfo()
  else
    self:refreshSelfFormationInfo()
  end
  self:refreshEnemyFormationInfo()
  L_ReddotManager:registerReddot(self.bindComponents.reddoFormation, L_ReddotManager.DotDef.kiBoDuel_Skill)
end

function cls:refreshTrialDuelInfo()
  local tpl = _kiBoDuelTpl:getTplById(self.levelId)
  if not tpl then
    return
  end
  local trialRole = _kiBoDuelTpl:getTrialRole(tpl)
  local heroConfigId = L_GameUtil.getDefaultHeroId(L_PlayerStore:getSex())
  if not math.isEmpty(trialRole) then
    local trialRoleTpl = _heroInterimTpl:getTplById(trialRole)
    heroConfigId = _heroInterimTpl:getHeroId(trialRoleTpl)
  end
  self.curHeroGuid = heroConfigId
  local heroCfg = _heroTpl:getTplById(heroConfigId)
  local clothingId = AzurWorld.heroMgr:GetUsingClothingId(L_HeroStore:getDefaultHeroGuid(), heroConfigId)
  local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
  local unitID = heroClothingTpl:getUnitId(heroClothingTpl:getTplById(clothingId))
  if not unitID then
    return false
  end
  local isPlayerHero = heroConfigId == L_GameUtil.getDefaultHeroId(L_PlayerStore:getSex())
  self:loadHeroUnit(unitID, heroCfg, heroConfigId, isPlayerHero)
  local trialPets = _kiBoDuelTpl:getKiboList(tpl)
  local playerSlotItem = {}
  for k, v in ipairs(trialPets) do
    local trialPetTpl = _trialPetTpl:getTplById(v)
    local petCfg = _petTpl:getTplById(_trialPetTpl:getTrialPet(trialPetTpl))
    local petName = _petTpl:getName(petCfg, 0)
    table.insert(playerSlotItem, {
      petGuid = v,
      is_trial = true,
      cellMode = L_PetConst.PetDuelEntranceCellMode.PrepareSelf,
      isForbidden = false,
      petName = petName
    })
  end
  self.bind.list_playerPet:clear()
  self.bind.list_playerPet:insert_array(playerSlotItem)
  self.bind.active_txt_duelTip = false
  self.bind.active_btnBlack = not self.bind.active_txt_duelTip
  self.bind.active_btnGrey = self.bind.active_txt_duelTip
  self.canStartDuel = true
  self.skillUsable = true
end

function cls:setInitialFormation()
  local skillInfos = L_PetDuelStore:getDefaultSkillInfos(self.levelId)
  local info = L_PetDuelStore:getPetDuelFormationGroupInfo(L_PetDuelStore:getCurPetDuelFormationSlot())
  local index = info.lockSlot
  L_PetDuelStore:req_setPetDuelFormation(L_PetDuelStore:getCurPetDuelFormationSlot(), L_PetDuelStore:getPetDuelFormationPetGuids(), L_HeroStore:getDefaultHeroGuid(), skillInfos, self.levelId, index)
end

function cls:initModHero()
  local curHeroGuid = L_PetDuelStore:getCurPetDuelFormationHeroGuid()
  if curHeroGuid <= 0 then
    if not self.bInit then
      self:setInitialFormation()
      self.bInit = true
    end
    return true
  end
  self.bInit = true
  if self.curHeroGuid == curHeroGuid then
    return false
  end
  self.curHeroGuid = curHeroGuid
  local heroInfo = L_HeroStore:getHero(curHeroGuid)
  local heroConfigId = L_HeroStore:getHeroConfigId(heroInfo)
  local heroCfg = _heroTpl:getTplById(heroConfigId)
  local clothingId = AzurWorld.heroMgr:GetUsingClothingId(curHeroGuid, heroConfigId)
  local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
  local unitID = heroClothingTpl:getUnitId(heroClothingTpl:getTplById(clothingId))
  if not unitID then
    return false
  end
  local isPlayerHero = self.curHeroGuid == L_HeroStore:getDefaultHeroGuid()
  self:loadHeroUnit(unitID, heroCfg, heroConfigId, isPlayerHero)
  return false
end

function cls:loadHeroUnit(unitID, heroCfg, configId, isPlayerHero)
  local unit = _unitTpl:getTplById(unitID)
  local path = _unitTpl:getModel(unit, 1)
  L_UIModelMgr:LoadHeroModelAsync(path, _heroTpl:getKiBoDuelHeroPrepareTransOffset(heroCfg), _heroTpl:getKiBoDuelHeroPrepareTransEuler(heroCfg), _heroTpl:getKiBoDuelHeroPrepareTransScale(heroCfg), function(go)
    local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), go)
    if biologyData then
      biologyData.isSync = true
    end
    local needAnimaList = {"KiboDuelUi"}
    local entity = L_EntityManager:generateSimpleHero(configId, go, isPlayerHero, nil, needAnimaList, C_EEntityEntranceType.PetDuel)
    entity.playableAnimator:Play("KiboDuelUi")
    local characterAnchorFit = self.heroParent:GetComponent(typeof(CS.Lens.Gameplay.UI.CharacterAnchorFit))
    characterAnchorFit.followTrans = self.bindComponents.playerModelHeadRoot
    characterAnchorFit:SetModelHeight(biologyData.halfHeight * 2)
    self.bHeroModLoaded = true
    if self.bNpcModLoaded then
      self.bind.active_plotNode = false
      self.bind.active_btnFormationNode = true
    end
  end, self.heroParent)
end

function cls:initModNPC()
  local kiBoDuelCfg = _kiBoDuelTpl:getTplById(self.levelId)
  local spawnerId = _kiBoDuelTpl:getNpcSpawnerID(kiBoDuelCfg)
  local spawnerTpl = L_GameTpl:getWorldSpawnerTpl()
  local spawnerCfg = spawnerTpl:getTplById(spawnerId)
  local unitID = spawnerTpl:getResourceId(spawnerCfg)
  if not unitID then
    return
  end
  local unit = _unitTpl:getTplById(unitID)
  local path = _unitTpl:getModel(unit, 1)
  L_UIModelMgr:LoadViceHeroModelAsync(path, _kiBoDuelTpl:getNpcTransOffset(kiBoDuelCfg), _kiBoDuelTpl:getNpcTransEuler(kiBoDuelCfg), _kiBoDuelTpl:getNpcTransScale(kiBoDuelCfg), function(go)
    local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), go)
    if biologyData then
      biologyData.isSync = true
      biologyData:UsePreviewLodLevelByInt()
    end
    local characterAnchorFit = self.npcParent:GetComponent(typeof(CS.Lens.Gameplay.UI.CharacterAnchorFit))
    characterAnchorFit.followTrans = self.bindComponents.npcModelHeadRoot
    characterAnchorFit:SetModelHeight(biologyData.halfHeight * 2)
    self.animatorNpc = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), go)
    self.animatorNpc.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
    self.animatorNpc.updateMode = C_PlayableAnimator.UpdateMode.LateUpdate
    local needAnimaList = {"Idle"}
    local loadNames = CS.System.Array.CreateInstance(typeof(CS.System.String), #needAnimaList)
    for i = 1, #needAnimaList do
      loadNames[i - 1] = needAnimaList[i]
    end
    self.controllerAssetHandle = C_LuaUtility.LoadPlayableController(_unitTpl:getAnimatorConfig(unit, L_Const.avatarAnimatorConfigIndex.uiPreview), loadNames)
    self.animatorNpc.defaultAnimatorController = self.controllerAssetHandle.config
    self.animatorNpc:Play("Idle")
    self.bNpcModLoaded = true
    if self.bHeroModLoaded then
      self.bind.active_plotNode = false
      self.bind.active_btnFormationNode = true
    end
  end, self.npcParent)
end

function cls:refreshSelfFormationInfo()
  if L_PetDuelStore:getCurRealPetDuelFormationSlot() < 1 then
    L_PetDuelStore:req_setPetCurDuelFormation(1)
    return
  end
  local needSetDefaultHero = self:initModHero()
  if needSetDefaultHero then
    return
  end
  self.curFormationSlot = L_PetDuelStore:getCurPetDuelFormationSlot()
  
  local function onClick_select(cell)
    L_UI:open("pagePetDuelFormationNew", {
      levelId = self.levelId,
      heroParent = self.heroParent,
      formationModeCamera = self.formationModeCamera,
      HeroChangeCamera = self.HeroChangeCamera
    })
  end
  
  local playerSlotItem = {}
  local curPetGuids = L_PetDuelStore:getPetDuelFormationPetGuids(self.curFormationSlot)
  local nameList = L_PetDuelStore:getPetName(curPetGuids)
  self.notAllPetUseable = false
  for i = 1, #curPetGuids do
    local info = curPetGuids[i]
    local isForbidden = not L_PetDuelStore:checkPetValid(info, self.levelId)
    self.notAllPetUseable = self.notAllPetUseable or isForbidden
    table.insert(playerSlotItem, {
      petGuid = info.id,
      is_trial = info.is_trial,
      cellMode = L_PetConst.PetDuelEntranceCellMode.PrepareSelf,
      callback = onClick_select,
      isForbidden = isForbidden,
      petName = nameList[i]
    })
  end
  self.bind.list_playerPet:clear()
  self.bind.list_playerPet:insert_array(playerSlotItem)
  local kiBoDuelCfg = _kiBoDuelTpl:getTplById(self.levelId)
  self.minimumKibo = _kiBoDuelTpl:getMinimumKibo(kiBoDuelCfg)
  local validPetNum = self:getValidPetNum(curPetGuids)
  self.canStartDuel = validPetNum >= self.minimumKibo
  self.skillUsable = self:checkSkillUsable()
  self.bind.active_txt_duelTip = self.notAllPetUseable or validPetNum < self.minimumKibo or not self.skillUsable
  self.bind.active_btnBlack = not self.bind.active_txt_duelTip
  self.bind.active_btnGrey = self.bind.active_txt_duelTip
  if self.notAllPetUseable then
    self.bind.txt_duelTip = L_WordsTpl:getValue("notice_pagePetPrepareDuel_01")
  elseif validPetNum < self.minimumKibo then
    self.bind.txt_duelTip = L_WordsTpl:getValue("notice_pagePetPrepareDuel_02", {
      [0] = self.minimumKibo
    })
  elseif not self.skillUsable then
    self.bind.txt_duelTip = L_WordsTpl:getValue("notice_pagePetPrepareDuel_03")
  end
end

function cls:getValidPetNum(petIds)
  if not petIds then
    return 0
  end
  local num = 0
  for _, v in ipairs(petIds) do
    if 0 < v.id then
      num = num + 1
    end
  end
  return num
end

function cls:refreshEnemyFormationInfo()
  local enemySlotItem = {}
  local kiBoDuelCfg = _kiBoDuelTpl:getTplById(self.levelId)
  for id, level in pairs(_kiBoDuelTpl:getEnemy(kiBoDuelCfg)) do
    table.insert(enemySlotItem, {
      petCfgId = id,
      petLv = level,
      cellMode = L_PetConst.PetDuelEntranceCellMode.PrepareEnemy
    })
  end
  table.sort(enemySlotItem, function(a, b)
    return a.petCfgId < b.petCfgId
  end)
  self.bind.list_enemyPet:clear()
  self.bind.list_enemyPet:insert_array(enemySlotItem)
end

function cls:checkSkillUsable()
  local curSkillInfo = L_PetDuelStore:getCurPetDuelFormationHeroSkills()
  for _, v in ipairs(curSkillInfo) do
    if not L_PetDuelStore:checkSkillCanUse(self.levelId, v.skill_id) then
      L_FlyMsgManager:showNormalMsgByKey("notice_pagePetPrepareDuel_04")
      return false
    end
  end
  return true
end

function cls:onBtnStartDuel()
  if self.notAllPetUseable then
    L_FlyMsgManager:showNormalMsgByKey("notice_pagePetPrepareDuel_05")
    return
  end
  if not self.canStartDuel then
    L_FlyMsgManager:showNormalMsgByKey("notice_pagePetPrepareDuel_02", {
      [0] = self.minimumKibo
    })
    return
  end
  if not self.skillUsable then
    L_FlyMsgManager:showNormalMsgByKey("notice_pagePetPrepareDuel_03")
    return
  end
  C_KiBoDuelLuaWrapper.SetCurrentLevel(self.levelId)
  if L_EntrustStore:isActivityEntrustLevel(self.levelId) then
    if self.levelId ~= 0 then
      local buffList = L_EntrustStore:getEntrustBuffByLevelId(self.levelId)
      if buffList ~= nil then
        C_KiBoDuelLuaWrapper.SetCurrentLevelBuff(buffList)
      end
      L_GameEventStore:req_CSProtoKiboDuelGetGroup(self.levelId, function()
        if self.levelMode ~= L_PetConst.PetDuelChallengeMode.ChapterLevel then
          return
        end
        local keyWithoutMode = L_PetDuelStore:getLastLevelIdSaveKey()
        C_PlayerPrefsUtility.SetInt(keyWithoutMode, self.levelId)
        local kiBoDuelGroupCfg = _kiboDuelGroupTpl:getTplById(self.levelId)
        local chapterId = _kiboDuelGroupTpl:getChapterId(kiBoDuelGroupCfg)
        local kiBoDuelChapterCfg = _kiboDuelChapterTpl:getTplById(chapterId)
        local keyWithMode = L_PetDuelStore:getLastLevelIdSaveKey(_kiboDuelChapterTpl:getModeId(kiBoDuelChapterCfg))
        C_PlayerPrefsUtility.SetInt(keyWithMode, self.levelId)
      end)
    else
      errorf("活动" .. "not found activityId for levelId" .. tostring(self.levelId), 2)
    end
    return
  end
  L_PetDuelStore:req_CSProtoKiboDuelStart(self.levelId, function()
    if self.levelMode ~= L_PetConst.PetDuelChallengeMode.ChapterLevel then
      return
    end
    local keyWithoutMode = L_PetDuelStore:getLastLevelIdSaveKey()
    C_PlayerPrefsUtility.SetInt(keyWithoutMode, self.levelId)
    local kiBoDuelGroupCfg = _kiboDuelGroupTpl:getTplById(self.levelId)
    local chapterId = _kiboDuelGroupTpl:getChapterId(kiBoDuelGroupCfg)
    local kiBoDuelChapterCfg = _kiboDuelChapterTpl:getTplById(chapterId)
    local keyWithMode = L_PetDuelStore:getLastLevelIdSaveKey(_kiboDuelChapterTpl:getModeId(kiBoDuelChapterCfg))
    C_PlayerPrefsUtility.SetInt(keyWithMode, self.levelId)
  end)
end

function cls:hide(options)
  L_UIModelMgr:EnableHeroModel(false)
  L_UIModelMgr:EnableViceHeroModel(false)
  self:changeMode(false)
  L_PetDuelStore:unListenCallFunc(L_PetDuelStore.event.refresh_formationInfo, self.refreshSelfFormationInfo, self)
end

function cls:close(options)
  cls.super.close(self, options)
  L_UIModelMgr:RecycleHeroEnvironment()
  L_UIModelMgr:RecycleHeroModel()
  L_UIModelMgr:RecycleViceHeroModel()
  C_UISceneManager.SetSceneVisible()
end

function cls:check(options, callback)
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.KiboDuel, true) then
    callback(false)
    return
  end
  callback(true)
end

function cls:destroy()
  cls.super.destroy(self)
  if self.controllerAssetHandle then
    C_LuaUtility.ReleasePlayableController(self.controllerAssetHandle)
    self.controllerAssetHandle = nil
  end
end

return cls
