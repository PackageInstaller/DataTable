local cls = class("pagePetDuelFormationNew", G_UIPageBase)
local _petTpl = L_GameTpl:getPetTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
local _unitTpl = L_GameTpl:getUnitTpl()
local _kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
local _elementTpl = L_GameTpl:getElementTypeTpl()
local _trialPetTpl = L_GameTpl:getTrialPetTpl()
local isPc = L_DeviceTpl:getIsPc()
local isMobile = L_DeviceTpl:getIsMobile()
local MaxFormationNum = 5
local PropertyModuleArrowPosX = 9.8
local _scenePrefabPath = "Program/UIScene/pre_petDuelScene_ui_01.prefab"

function cls.bind()
  return {
    leftBtnActive = true,
    rightBtnActive = true,
    formation_List = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelEntranceNew"
    },
    active_leftPetList = true,
    active_leftPetEmptyTip = false,
    leftPetGrid = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelEntranceNew"
    },
    active_petEdit = false,
    formationPreview_list = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelEntranceNew"
    },
    active_heroModel = true,
    active_btnChangeHero = true,
    active_heroGrid = false,
    leftHeroGrid = {
      moduleName = "modulePages/cellIconUnit"
    },
    img_curFormationTag = nil,
    txt_curFormationName = "",
    active_tmpFormation = false,
    scrollList_heroSkill = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelSkill"
    },
    modulePetBoxFilter = {
      moduleName = "modulePages/sortFilter/modulePetBoxFilter"
    },
    loopListBoxPoint = {
      moduleName = "Pages/formation/formationModule/cellTeamPresetTip"
    },
    module_formationPetProperty = {
      moduleName = "pages/formation/formationModule/moduleFormationPetProperty"
    },
    active_arrowLeft = false,
    active_arrowRight = false,
    localPosition_propertyModule = nil,
    localPosition_propertyModuleArrowLeft = nil,
    localPosition_propertyModuleArrowRight = nil,
    module_DragKiboCard = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelEntranceNew"
    },
    active_DragKiboCard = false,
    enabled_PetGrid = true,
    active_downArea = false,
    active_downAreaNormal = true,
    active_downAreaSelected = false,
    modulePetDuelRecElement = {
      moduleName = "pages/petDuelOutside/modulePetDuelRecElement"
    },
    active_recELement = true,
    int_petGridFocusItemIndex = 1
  }
end

function cls.methods()
  return {
    onClick_changeLeft_preview = function(self)
      self:onBtnChangeLeft()
    end,
    onClick_changeRight_preview = function(self)
      self:onBtnChangeRight()
    end,
    onClick_btnChangeHero = function(self)
      self:onBtnChangeHero(true)
    end,
    onClick_savePetEdit = function(self)
      self:onEditFormation(false)
      self:refreshFormationSlot()
    end,
    onClick_saveHeroEdit = function(self)
      self:onBtnChangeHero(false)
    end,
    onClick_btnLeft = function(self)
      self:onBtnPageLeft()
    end,
    onClick_btnright = function(self)
      self:onBtnPageRight()
    end
  }
end

function cls:preOpen(options)
  cls.super.preOpen(self, options)
  if C_ResolutionUtility.CheckSuperWidthScreen() then
  end
  if not options.levelId then
    self.closeCallback = options.callback
    self.isSubFormation = options.isSubFormation
    self.isNotInALevel = true
    self.levelId = 1001
    self.levelType = L_Const.kiBoDuelLevelType.player
    self.bind.active_recELement = false
    self:openPetDuelScene()
  else
    self.levelId = options.levelId
    self.kiBoDuelCfg = _kiBoDuelTpl:getTplById(self.levelId)
    self.levelType = _kiBoDuelTpl:getLevelType(self.kiBoDuelCfg)
    self.heroParent = options.heroParent
    self.formationModeCamera = options.formationModeCamera
    self.HeroChangeCamera = options.HeroChangeCamera
    self:initPage()
  end
  self._petPropertyModule = self.modules.module_formationPetProperty
  self._petPropertyModule:showModuleInfo(false)
  self._onPointEnterPetCellHandler = handler(self, self.onPointEnterPetCell)
  self._onPointExitPetCellHandler = handler(self, self.onPointExitPetCell)
  self.modules.modulePetDuelRecElement:initModule(self.levelId)
  self:configTouch("+")
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.ENextPetBox, function()
    if self.bind.active_petEdit then
      self:onBtnPageRight()
      L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Switch")
    elseif self.bind.active_heroModel then
      if L_PetDuelStore:getCurPetDuelFormationSlot() == L_Const.kiBoDuelBlockSlot then
        return
      end
      self:onBtnChangeRight()
    end
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.ELastPetBox, function()
    if self.bind.active_petEdit then
      self:onBtnPageLeft()
      L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Switch")
    elseif self.bind.active_heroModel then
      if L_PetDuelStore:getCurPetDuelFormationSlot() == L_Const.kiBoDuelBlockSlot then
        return
      end
      self:onBtnChangeLeft()
    end
  end)
  L_PetStore:listenCallFunc(L_PetStore.event.closePetBox, self.onClosePetBox, self)
end

function cls:onTopBarRefresh()
  C_IntegrateMgr.TopBarModule:SetTopBarCloseFunc(handler(self, self.escHandle))
  if self.isSubFormation then
    C_IntegrateMgr.TopBarModule:SetTopBarMainBtnFunc(function()
      if self.isSubFormation then
        self.closeCallback()
      end
      L_UI:backToRoot()
    end)
    C_IntegrateMgr.TopBarModule:SetTopBarBackName("编队")
  end
end

function cls:initPage()
  self:initFormationData()
  if L_PetDuelStore:getCurPetDuelFormationSlot() == L_Const.kiBoDuelBlockSlot then
    self:initBlockFormation(L_Const.kiBoDuelBlockSlot)
  end
  self:initModulePetBoxFilter()
  self.selectFormationSlotId = L_PetDuelStore:getCurPetDuelFormationSlot()
  self:initPointList()
  self:refreshFormationSlot()
  self.bind.leftBtnActive = L_PetDuelStore:getCurPetDuelFormationSlot() ~= L_Const.kiBoDuelBlockSlot
  self.bind.rightBtnActive = L_PetDuelStore:getCurPetDuelFormationSlot() ~= L_Const.kiBoDuelBlockSlot
  self.bind.active_tmpFormation = L_PetDuelStore:getCurPetDuelFormationSlot() == L_Const.kiBoDuelBlockSlot
end

function cls:initBlockFormation(slotId)
  local petUids = {}
  for _, v in ipairs(L_PetDuelStore:getPetDuelFormationPetGuids(slotId)) do
    table.insert(petUids, {
      is_trial = v.is_trial,
      id = v.id
    })
  end
  self.curFormationPetData[slotId] = petUids
  self.curFormationHeroData[slotId] = L_PetDuelStore:getPetDuelFormationHeroGuid(slotId)
  local skills = {}
  for _, v in ipairs(L_PetDuelStore:getPetDuelFormationHeroSkills(slotId)) do
    table.insert(skills, table.clone(v))
  end
  self.curFormationSkillData[slotId] = skills
end

function cls:onClosePetBox()
  local bPetDelete = false
  local curFormationPetGuids = self.curFormationPetData[self.selectFormationSlotId]
  for i = 1, #curFormationPetGuids do
    if curFormationPetGuids[i].id > 0 and not L_PetStore:getPetItem(curFormationPetGuids[i].id) then
      bPetDelete = true
      break
    end
  end
  self:refreshFormationSlot(true)
  if not bPetDelete then
    return
  end
  self:saveFormationInfo()
end

function cls:initFormationData()
  self.curFormationPetData = {}
  self.curFormationHeroData = {}
  self.curFormationSkillData = {}
  for slotId = 1, MaxFormationNum do
    local petUids = {}
    for _, v in ipairs(L_PetDuelStore:getPetDuelFormationPetGuids(slotId)) do
      table.insert(petUids, {
        is_trial = v.is_trial,
        id = v.id
      })
    end
    self.curFormationPetData[slotId] = petUids
    self.curFormationHeroData[slotId] = L_PetDuelStore:getPetDuelFormationHeroGuid(slotId)
    local skills = {}
    for _, v in ipairs(L_PetDuelStore:getPetDuelFormationHeroSkills(slotId)) do
      table.insert(skills, table.clone(v))
    end
    self.curFormationSkillData[slotId] = skills
  end
end

function cls:refreshFormationSlot(bPetFormationChange)
  if not bPetFormationChange then
    self.selectSlotId = 0
    self.selectHeroGuid = -1
    if L_PetDuelStore:getCurPetDuelFormationSlot() == L_Const.kiBoDuelBlockSlot then
      self.bind.txt_curFormationName = string.format("试用对决阵容", tostring(self.selectFormationSlotId))
    else
      self.bind.txt_curFormationName = string.format("%s号对决阵容", tostring(self.selectFormationSlotId))
      self.bind.img_curFormationTag = string.format("UI/FormationPage/tex_formation_icon_team%s.png", tostring(self.selectFormationSlotId))
    end
    self:applyFormationSlot()
    self:setPointListActive()
  end
  self:refreshPreviewFormation(bPetFormationChange)
  self:refreshBottomShow(bPetFormationChange)
  if not bPetFormationChange then
    self:refreshHeroShow()
    self:refreshHeroSkillShow()
  end
end

function cls:initModulePetBoxFilter()
  self.modules.modulePetBoxFilter:initPetBoxFilterModule(L_PetConst.PetBoxFilterEnums.PetDuel, function(selectBoxIndex)
    self:onRspPetBoxSelectCallBack(selectBoxIndex)
  end)
end

function cls:initPointList()
  local tmp = {}
  for i = 1, MaxFormationNum do
    table.insert(tmp, {index = i})
  end
  self.bind.loopListBoxPoint:clear()
  self.bind.loopListBoxPoint:insert_array(tmp)
end

function cls:setPointListActive()
  for _, v in pairs(self.modules.loopListBoxPoint) do
    v:setActive(v.bind.index == self.selectFormationSlotId)
  end
end

function cls:onRspPetBoxSelectCallBack(selectBoxIndex)
  self.selectPetBoxIndex = selectBoxIndex
  if self.bInit then
    self:refreshLeftPetGrid()
  end
  self.bInit = true
end

function cls:refreshPreviewFormation(bPetFormationChange)
  local function onClick_select(cell)
    self.selectSlotId = cell.bind.slotId
    
    self.selectPetGuid = cell.bind.petGuid
    self.bind.active_petEdit = true
    C_IntegrateMgr.TopBarModule:SetTopBarVisible(false)
    self:refreshLeftPetGrid()
  end
  
  local petItems = {}
  local curFormationPetGuids = self.curFormationPetData[self.selectFormationSlotId]
  for i = 1, #curFormationPetGuids do
    local info = curFormationPetGuids[i]
    if info.id > 0 and not info.is_trial and not L_PetStore:getPetItem(info.id) then
      info.id = 0
    end
  end
  local isValidEmpty = false
  if not isValidEmpty and _kiBoDuelTpl:isKiboLock(self.levelId) then
    local info = L_PetDuelStore:getPetDuelFormationGroupInfo(L_Const.kiBoDuelBlockSlot)
    if info.lockSlot >= 8 then
      self.selectSlotId = 1
    else
      self.selectSlotId = 8
    end
  end
  local curNameList = L_PetDuelStore:getPetName(curFormationPetGuids)
  for i = 1, 8 do
    local info = curFormationPetGuids[i]
    local isForbidden = not L_PetDuelStore:checkPetValid(info, self.levelId)
    table.insert(petItems, {
      slotId = i,
      selectSlotId = self.selectSlotId,
      petGuid = info.id,
      cellMode = L_PetConst.PetDuelEntranceCellMode.FormationPreviewSlot,
      callback = onClick_select,
      is_trial = info.is_trial,
      isForbidden = isForbidden,
      petName = curNameList[i]
    })
  end
  self.bind.formationPreview_list:clear()
  self.bind.formationPreview_list:insert_array(petItems)
  self:refreshLeftPetGrid()
end

function cls:refreshBottomShow(bPetFormationChange)
  local function onClick_select(cell)
    self.selectSlotId = cell.bind.slotId
    
    self.selectPetGuid = cell.bind.petGuid
    for i = 1, #self.bind.formation_List do
      self.bind.formation_List:change(i, {
        selectSlotId = self.selectSlotId
      })
    end
    if #self.bind.leftPetGrid <= 0 then
      local curSelectPetGuid = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id
      if curSelectPetGuid == 0 or cell.bind.is_trial then
        local curSelectBoxIndex = 1
        self.modules.modulePetBoxFilter:changeIndexOutside(curSelectBoxIndex)
      else
        local petItem = L_PetStore:getPetItem(curSelectPetGuid)
        local curSelectBoxIndex = petItem.box_id // 100
        self.modules.modulePetBoxFilter:changeIndexOutside(curSelectBoxIndex)
      end
      self:onEditFormation(true)
    else
      self:refreshLeftPetGridLit()
    end
  end
  
  local function onClick_remove(cell)
    self.selectSlotId = cell.bind.slotId
    self:onBtnCancelFormation()
  end
  
  local petItems = {}
  local curFormationPetGuids = self.curFormationPetData[self.selectFormationSlotId]
  for i = 1, #curFormationPetGuids do
    local info = curFormationPetGuids[i]
    if info.id > 0 and not info.is_trial and not L_PetStore:getPetItem(info.id) then
      info.id = 0
    end
  end
  local isValidEmpty = false
  if not isValidEmpty and _kiBoDuelTpl:isKiboLock(self.levelId) then
    local info = L_PetDuelStore:getPetDuelFormationGroupInfo(L_Const.kiBoDuelBlockSlot)
    if info.lockSlot >= 8 then
      self.selectSlotId = 1
    else
      self.selectSlotId = 8
    end
  end
  local curNameList = L_PetDuelStore:getPetName(curFormationPetGuids)
  for i = 1, 8 do
    local info = curFormationPetGuids[i]
    local isForbidden = not L_PetDuelStore:checkPetValid(info, self.levelId)
    table.insert(petItems, {
      slotId = i,
      selectSlotId = self.selectSlotId,
      petGuid = info.id,
      cellMode = L_PetConst.PetDuelEntranceCellMode.FormationSlot,
      callback = onClick_select,
      callback_remove = onClick_remove,
      pointEnterCallback = self._onPointEnterPetCellHandler,
      pointExitCallback = self._onPointExitPetCellHandler,
      petGridMark = "formation_list",
      is_trial = info.is_trial,
      isForbidden = isForbidden,
      petName = curNameList[i]
    })
  end
  self.bind.formation_List:clear()
  self.bind.formation_List:insert_array(petItems)
  self:refreshLeftPetGrid()
end

function cls:changePetFormation(dstPetUid, isTrial)
  L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_Qibo_SelectUp")
  local dstSlot = self:getPetSlot(dstPetUid, isTrial)
  local curSelectUid = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id
  local curSelectIsTrial = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].is_trial
  if curSelectUid <= 0 then
    self.isBlankSlot = true
  else
    self.isBlankSlot = false
  end
  self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id = dstPetUid
  self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].is_trial = isTrial
  if 0 < dstSlot then
    self.curFormationPetData[self.selectFormationSlotId][dstSlot].id = curSelectUid
    self.curFormationPetData[self.selectFormationSlotId][dstSlot].is_trial = curSelectIsTrial
  end
  local curFormationPetGuids = self.curFormationPetData[self.selectFormationSlotId]
  local curNameList = L_PetDuelStore:getPetName(curFormationPetGuids)
  local isFound = false
  for i = self.selectSlotId, 8 do
    if curFormationPetGuids[i].id <= 0 and self.isBlankSlot then
      self.selectSlotId = i
      isFound = true
      break
    end
  end
  if not isFound then
    for i = 1, self.selectSlotId do
      if curFormationPetGuids[i].id <= 0 and self.isBlankSlot then
        self.selectSlotId = i
        break
      end
    end
  end
  for i = 1, #self.bind.formation_List do
    local isForbidden = not L_PetDuelStore:checkPetValid(curFormationPetGuids[i], self.levelId)
    self.bind.formation_List:change(i, {
      selectSlotId = self.selectSlotId,
      petGuid = curFormationPetGuids[i].id,
      is_trial = curFormationPetGuids[i].is_trial,
      isForbidden = isForbidden,
      petName = curNameList[i]
    })
  end
end

function cls:refreshLeftPetGridLit()
  local petList = self:getCurPetList()
  for i, v in ipairs(petList) do
    self.bind.leftPetGrid:change(i, {
      petGuid = v.id,
      is_trial = v.is_trial,
      slotId = self:getPetSlot(v.id, v.is_trial),
      selectSlotId = self.selectSlotId
    })
  end
end

function cls:refreshLeftPetGrid()
  local function onClick_select(cell)
    local curSelectPetGuid = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id
    
    local isTrial = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].is_trial
    if 0 < curSelectPetGuid and curSelectPetGuid == cell.petGuid and not isTrial == not cell.isTrial then
      self:onBtnCancelFormation()
    else
      self:changePetFormation(cell.petGuid, cell.isTrial)
      self:refreshLeftPetGridLit()
    end
  end
  
  local function onClick_remove(cell)
    self.selectSlotId = cell.bind.slotId
    self:onBtnCancelFormation()
  end
  
  if self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId] == nil then
    return
  end
  local curSelectPetGuid = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id
  local isTrial = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].is_trial
  local petList = self:getCurPetList()
  local petCount = #petList
  self.bind.active_leftPetList = 0 < petCount
  self.bind.active_leftPetEmptyTip = petCount < 1
  if curSelectPetGuid <= 0 and petCount < 1 then
    return
  end
  local petItems = {}
  for i, v in ipairs(petList) do
    local isForbidden = not L_PetDuelStore:checkPetValid(v, self.levelId)
    table.insert(petItems, {
      petGuid = v.id,
      is_trial = v.is_trial,
      slotId = self:getPetSlot(v.id, v.is_trial),
      selectSlotId = self.selectSlotId,
      callback = onClick_select,
      callback_remove = onClick_remove,
      pointEnterCallback = self._onPointEnterPetCellHandler,
      pointExitCallback = self._onPointExitPetCellHandler,
      petGridMark = "leftPetGrid",
      cellMode = L_PetConst.PetDuelEntranceCellMode.FormationPetPool,
      isForbidden = isForbidden
    })
  end
  self.bind.leftPetGrid:clear()
  self.bind.leftPetGrid:insert_array(petItems)
  for index, v in ipairs(petItems) do
    if v.petGuid == self.selectPetGuid then
      self.bind.int_petGridFocusItemIndex = index
    end
  end
end

function cls:refreshHeroShow(bSwitch)
  local curHeroGuid = self.curFormationHeroData[self.selectFormationSlotId]
  if 0 < curHeroGuid and curHeroGuid == self.selectHeroGuid then
    return
  end
  if curHeroGuid <= 0 and 0 >= self.selectHeroGuid then
    self.selectHeroGuid = L_HeroStore:getDefaultHeroGuid()
  end
  if 0 >= self.selectHeroGuid then
    self.selectHeroGuid = self.curFormationHeroData[self.selectFormationSlotId]
  end
  self.curFormationHeroData[self.selectFormationSlotId] = self.selectHeroGuid
  self:refreshHeroModel(bSwitch)
end

function cls:refreshHeroModel(bSwitch)
  local heroInfo = L_HeroStore:getHero(self.selectHeroGuid)
  if not heroInfo then
    errorf("英雄数据不存在 heroGuid = " .. tostring(self.selectHeroGuid))
    return
  end
  local heroConfigId = L_HeroStore:getHeroConfigId(heroInfo)
  local heroCfg = _heroTpl:getTplById(heroConfigId)
  local clothingId = AzurWorld.heroMgr:GetUsingClothingId(self.selectHeroGuid, heroConfigId)
  local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
  local unitID = heroClothingTpl:getUnitId(heroClothingTpl:getTplById(clothingId))
  if not unitID then
    return
  end
  local unit = _unitTpl:getTplById(unitID)
  local path = _unitTpl:getModel(unit, 1)
  local curRotation = _heroTpl:getKiBoDuelFormationHeroTransEuler(heroCfg)
  if self.bind.active_heroGrid then
    curRotation = L_Vector3.new(0, 10, 0)
  end
  self.biologyData = nil
  self.characterAnchorFit = nil
  L_UIModelMgr:LoadHeroModelAsync(path, _heroTpl:getKiBoDuelFormationHeroTransOffset(heroCfg), curRotation, _heroTpl:getKiBoDuelFormationHeroTransScale(heroCfg), function(go)
    self.biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), go)
    if self.biologyData then
      self.biologyData.isSync = true
    end
    local isPlayerHero = self.selectHeroGuid == L_HeroStore:getDefaultHeroGuid()
    local needAnimaList = {"KiboDuelUi"}
    self.entity = L_EntityManager:generateSimpleHero(L_HeroStore:getHeroConfigId(heroInfo), go, isPlayerHero, nil, needAnimaList, C_EEntityEntranceType.PetDuel)
    self.entity.playableAnimator:Play("KiboDuelUi")
    self.go = go
    self.characterAnchorFit = self.heroParent:GetComponent(typeof(CS.Lens.Gameplay.UI.CharacterAnchorFit))
    if bSwitch then
      self.characterAnchorFit.followTrans = self.bindComponents.modelHeadRoot_edit
    else
      self.characterAnchorFit.followTrans = self.bindComponents.modelHeadRoot_preview
    end
    self.characterAnchorFit:SetModelHeight(self.biologyData.halfHeight * 2)
    if bSwitch then
      self:loadEffectModel(L_HeroStore:getHeroConfigId(heroInfo), self.heroParent, _heroTpl:getKiBoDuelFormationHeroTransOffset(heroCfg))
    end
  end, self.heroParent)
end

function cls:loadEffectModel(heroCfgId, heroParent, heroPos)
  local tpl = _heroTpl:getTplById(heroCfgId)
  local elementId = _heroTpl:getElement(tpl)
  if elementId ~= self.lastElementId then
    self:recycleEffectModel()
    self.lastElementId = elementId
  end
  if not L_CommonUtil.isValid(self.heroSwitchEft) then
    local tpl_ele = _elementTpl:getTplById(elementId)
    local path = _elementTpl:getAdmissioneffects(tpl_ele)
    self.heroSwitchEft = L_ResPool:syncGameObject(path)
    self.heroSwitchEft.transform:SetParent(heroParent)
    L_Vector3.setLocalPos(self.heroSwitchEft.transform, heroPos)
  else
    self.heroSwitchEft:ActiveTrans(false)
  end
  self.heroSwitchEft:ActiveTrans(true)
end

function cls:recycleEffectModel()
  if L_CommonUtil.isValid(self.heroSwitchEft) then
    C_GameObject.Destroy(self.heroSwitchEft)
  end
  self.heroSwitchEft = nil
end

function cls:getFormationData()
  local formationType = L_FormationConst.FormationType.world
  local posData = L_FormationStore:getFormationPosData(formationType)
  local data = {}
  for i, guid in pairs(posData) do
    if not math.isEmpty(guid) then
      data[guid] = i
    end
  end
  return data
end

function cls:sortHeroUidList()
  table.sort(self.heroUidList, function(a, b)
    local heroDataA = L_HeroStore:getHero(a)
    local heroDataB = L_HeroStore:getHero(b)
    if heroDataA == nil or heroDataB == nil then
      return a < b
    end
    local configA = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroDataA))
    local configB = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroDataB))
    local isOutA = self._heroId2FormationData[a] or math.huge
    local isOutB = self._heroId2FormationData[b] or math.huge
    if isOutA ~= isOutB then
      return isOutA < isOutB
    end
    local priorityOrder = {
      function()
        return L_HeroStore:getHeroLevel(heroDataA), L_HeroStore:getHeroLevel(heroDataB)
      end,
      function()
        return configA.quality, configB.quality
      end,
      function()
        return L_HeroStore:getHeroStar(heroDataA), L_HeroStore:getHeroStar(heroDataB)
      end
    }
    for _, getPriorityValue in ipairs(priorityOrder) do
      local valueA, valueB = getPriorityValue()
      if valueA ~= valueB then
        return valueB < valueA
      end
    end
    return a < b
  end)
end

function cls:getAllHeroList()
  local list = {}
  for i, v in pairs(L_HeroStore:getAllHero()) do
    table.insert(list, L_HeroStore:getHeroGuid(v))
  end
  return list
end

function cls:refreshHeroList()
  self.heroUidList = self:getAllHeroList()
  self._heroId2FormationData = self:getFormationData()
  if self.modeController == nil then
    self.modeController = require("ui.pages.HeroPanel.controller.heroListModeController").new()
  end
  self:sortHeroUidList()
  local dataArray = {}
  
  local function onClickHeroCell(cell)
    if self.selectHeroGuid ~= cell.bind.guid then
      local heroInfo = L_HeroStore:getHero(cell.bind.guid)
      L_HeroVoiceManager:playHeroVoice(string.format("Play_VO_System_%s_Forming", L_HeroStore:getHeroConfigId(heroInfo)))
    end
    self.selectHeroGuid = cell.bind.guid
    self:refreshHeroShow(true)
    self:setHeroListActive()
  end
  
  for _, uid in ipairs(self.heroUidList) do
    local heroInfo = L_HeroStore:getHero(uid)
    local heroItem = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroInfo))
    local data = {
      itemType = L_Const.resType.hero,
      guid = L_HeroStore:getHeroGuid(heroInfo),
      star = L_HeroStore:getHeroStar(heroInfo),
      lv = L_HeroStore:getHeroLevel(heroInfo),
      quality = heroItem.quality,
      callback = onClickHeroCell
    }
    table.insert(dataArray, data)
  end
  self.bind.leftHeroGrid:clear()
  self.bind.leftHeroGrid:insert_array(dataArray)
  self:setHeroListActive()
end

function cls:setHeroListActive()
  for i, v in pairs(self.modules.leftHeroGrid) do
    v:setSelectState(v.bind.guid == self.selectHeroGuid)
  end
end

function cls:refreshHeroSkillShow()
  if #self.curFormationSkillData[self.selectFormationSlotId] <= 0 then
    self.curFormationSkillData[self.selectFormationSlotId] = L_PetDuelStore:getDefaultSkillInfos(self.levelId)
  end
  local curSkillInfo = self.curFormationSkillData[self.selectFormationSlotId]
  
  local function onClickHeroSkillCell(cell)
    self.isOpenSkillPage = true
    L_UI:open("pagePetDuelSelectSkill", {
      selectSkillId = cell.bind.skillId,
      levelId = cell.bind.levelId,
      callback = function(selectSkillsId)
        self:onBtnSaveCallBack(selectSkillsId)
        self:refreshHeroSkillShow()
      end,
      closecallback = function()
        self.isOpenSkillPage = false
      end,
      curFormationHeroSkillData = self.curFormationSkillData[self.selectFormationSlotId]
    })
  end
  
  local datas = {}
  for _, v in ipairs(curSkillInfo) do
    table.insert(datas, {
      cellMode = L_PetConst.PetDuelSkillCellMode.FormationShow,
      skillId = v.skill_id,
      levelId = self.levelId,
      callback = onClickHeroSkillCell,
      reddotKey = L_ReddotManager.DotDef.kiBoDuel_Skill
    })
  end
  self.bind.scrollList_heroSkill:clear()
  self.bind.scrollList_heroSkill:insert_array(datas)
end

function cls:getSkillSlot(skillId)
  for slot, v in ipairs(self.curFormationSkillData[self.selectFormationSlotId]) do
    if v.skill_id == skillId then
      return slot
    end
  end
  return -1
end

function cls:onBtnChooseCallBack(defaultSkillId, selectSkillId)
  local defaultSlotId = self:getSkillSlot(defaultSkillId)
  local selectSlotId = self:getSkillSlot(selectSkillId)
  self.curFormationSkillData[self.selectFormationSlotId][defaultSlotId].skill_id = selectSkillId
  if 0 < selectSlotId then
    self.curFormationSkillData[self.selectFormationSlotId][selectSlotId].skill_id = defaultSkillId
  end
end

function cls:onBtnSaveCallBack(selectSkillsId)
  for idx = 1, #selectSkillsId do
    self.curFormationSkillData[self.selectFormationSlotId][idx].skill_id = selectSkillsId[idx].skillId
  end
end

function cls:getPetSlot(id, isTrial)
  if id <= 0 then
    return -1
  end
  for index, info in ipairs(self.curFormationPetData[self.selectFormationSlotId]) do
    if id == info.id and not info.is_trial == not isTrial then
      return index
    end
  end
  return -1
end

function cls:getCurPetList()
  local curSelectPetGuid = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id
  local isTrial = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].is_trial
  local petBoxList = L_PetStore:getPetBoxList(self.selectPetBoxIndex)
  local petList = {}
  local hasCurSelectPet = false
  if self.levelType == L_Const.kiBoDuelLevelType.system or self.levelType == L_Const.kiBoDuelLevelType.mix then
    local systemKiBoList = _kiBoDuelTpl:getKiboList(self.kiBoDuelCfg)
    for i = 1, #systemKiBoList do
      table.insert(petList, 1, {
        is_trial = true,
        id = systemKiBoList[i]
      })
    end
  end
  if not table.isEmpty(petBoxList) then
    for _, v in ipairs(petBoxList) do
      local pet = L_PetStore:getPetItem(v)
      if not table.isEmpty(pet) then
        table.insert(petList, {is_trial = false, id = v})
      end
    end
  end
  return petList
end

function cls:applyFormationSlot()
  L_PetDuelStore:req_setPetCurDuelFormation(self.selectFormationSlotId)
end

function cls:saveFormationInfo()
  local info = L_PetDuelStore:getPetDuelFormationGroupInfo(L_PetDuelStore:getCurPetDuelFormationSlot())
  local index = info.lockSlot
  L_PetDuelStore:req_setPetDuelFormation(self.selectFormationSlotId, self.curFormationPetData[self.selectFormationSlotId], self.curFormationHeroData[self.selectFormationSlotId], self.curFormationSkillData[self.selectFormationSlotId], self.levelId, index)
end

function cls:onClickEmpty()
  if self.bind.active_heroGrid then
    self:onBtnChangeHero(false)
  end
  if self.bind.active_petEdit then
    self:onEditFormation(false)
  end
end

function cls:onBtnCancelFormation()
  L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_Qibo_SelectDown")
  self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id = 0
  self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].is_trial = false
  local curFormationPetGuids = self.curFormationPetData[self.selectFormationSlotId]
  local curNameList = L_PetDuelStore:getPetName(curFormationPetGuids)
  for i = 1, #self.bind.formation_List do
    local isForbidden = not L_PetDuelStore:checkPetValid(curFormationPetGuids[i], self.levelId)
    self.bind.formation_List:change(i, {
      selectSlotId = self.selectSlotId,
      petGuid = curFormationPetGuids[i].id,
      is_trial = curFormationPetGuids[i].is_trial,
      isForbidden = isForbidden,
      petName = curNameList[i]
    })
  end
  self:refreshLeftPetGridLit()
end

function cls:onBtnChangeLeft()
  self:saveFormationInfo()
  self.selectFormationSlotId = self.selectFormationSlotId - 1
  if self.selectFormationSlotId < 1 then
    self.selectFormationSlotId = MaxFormationNum
  end
  self:refreshFormationSlot()
  self.selectSlotId = 1
  for i = 1, #self.bind.formation_List do
    self.bind.formation_List:change(i, {
      selectSlotId = self.selectSlotId
    })
  end
  if #self.bind.leftPetGrid <= 0 then
    local curSelectPetGuid = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id
    if curSelectPetGuid == 0 or cell.bind.is_trial then
      local curSelectBoxIndex = 1
      self.modules.modulePetBoxFilter:changeIndexOutside(curSelectBoxIndex)
    else
      local petItem = L_PetStore:getPetItem(curSelectPetGuid)
      local curSelectBoxIndex = petItem.box_id // 100
      self.modules.modulePetBoxFilter:changeIndexOutside(curSelectBoxIndex)
    end
    self:onEditFormation(true)
  else
    self:refreshLeftPetGridLit()
  end
end

function cls:onBtnChangeRight()
  self:saveFormationInfo()
  self.selectFormationSlotId = self.selectFormationSlotId + 1
  if self.selectFormationSlotId > MaxFormationNum then
    self.selectFormationSlotId = 1
  end
  self:refreshFormationSlot()
  self.selectSlotId = 1
  for i = 1, #self.bind.formation_List do
    self.bind.formation_List:change(i, {
      selectSlotId = self.selectSlotId
    })
  end
  if #self.bind.leftPetGrid <= 0 then
    local curSelectPetGuid = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id
    if curSelectPetGuid == 0 or cell.bind.is_trial then
      local curSelectBoxIndex = 1
      self.modules.modulePetBoxFilter:changeIndexOutside(curSelectBoxIndex)
    else
      local petItem = L_PetStore:getPetItem(curSelectPetGuid)
      local curSelectBoxIndex = petItem.box_id // 100
      self.modules.modulePetBoxFilter:changeIndexOutside(curSelectBoxIndex)
    end
    self:onEditFormation(true)
  else
    self:refreshLeftPetGridLit()
  end
end

function cls:onBtnPageLeft()
  self.selectPetBoxIndex = self.selectPetBoxIndex - 1
  self.modules.modulePetBoxFilter:changeIndexOutside(self.selectPetBoxIndex)
  self:refreshLeftPetGrid()
end

function cls:onBtnPageRight()
  self.selectPetBoxIndex = self.selectPetBoxIndex + 1
  self.modules.modulePetBoxFilter:changeIndexOutside(self.selectPetBoxIndex)
  self:refreshLeftPetGrid()
end

function cls:onBtnChangeHero(isChangeHero)
  self.bind.active_heroGrid = isChangeHero
  self.bind.active_heroModel = not isChangeHero
  C_IntegrateMgr.TopBarModule:SetTopBarVisible(not isChangeHero)
  self:refreshHeroList()
  for i, v in pairs(self.modules.formation_List) do
    v:setSelectHero(isChangeHero)
  end
  if L_CommonUtil.isValid(self.formationModeCamera) then
    L_CommonUtil.setObjActive(self.formationModeCamera, not isChangeHero)
  end
  if L_CommonUtil.isValid(self.HeroChangeCamera) then
    L_CommonUtil.setObjActive(self.HeroChangeCamera, isChangeHero)
  end
  if not isChangeHero then
    self.characterAnchorFit.followTrans = self.bindComponents.modelHeadRoot_preview
  else
    self.characterAnchorFit.followTrans = self.bindComponents.modelHeadRoot_edit
  end
  self.characterAnchorFit:SetModelHeight(self.biologyData.halfHeight * 2)
  local childCount = self.heroParent.childCount
  if 0 < childCount then
    for i = 0, childCount - 1 do
      local child = self.heroParent:GetChild(i)
      if L_CommonUtil.compareLayer(child.gameObject, L_Const.layer.character) and child.gameObject.activeSelf then
        self.heroModel = child.gameObject
      end
    end
  end
  if isChangeHero then
    local eulerAngles = L_Vector3.new(0, 10, 0)
    self.heroModel.transform.rotation = Unity.Quaternion.Euler(eulerAngles)
  else
    local eulerAngles = L_Vector3.new(0, -10, 0)
    self.heroModel.transform.rotation = Unity.Quaternion.Euler(eulerAngles)
  end
end

function cls:onEditFormation(isEdit)
  self.bind.active_petEdit = isEdit
  C_IntegrateMgr.TopBarModule:SetTopBarVisible(not isEdit)
  if not isEdit then
    self.selectSlotId = 0
    self._petPropertyModule:showModuleInfo(false)
  end
  for i = 1, #self.bind.formation_List do
    self.bind.formation_List:change(i, {
      selectSlotId = self.selectSlotId
    })
  end
  for i = 1, #self.bind.formation_List do
    self.bind.formation_List:change(i, {
      active_petEdit = self.bind.active_petEdit
    })
  end
  L_CommonUtil.setObjActive(self.heroModel, not isEdit)
end

function cls:onPointEnterPetCell(cell)
  if not isPc then
    return
  end
  if cell.bind.is_trial then
    return
  end
  self:showPetProperty(cell:getRaycastGo(), cell.bind.petGuid)
end

function cls:onPointExitPetCell(cell)
  if not isPc then
    return
  end
  self._petPropertyModule:showModuleInfo(false)
end

function cls:configTouch(operator)
  self.onUITouchHandle = self.onUITouchHandle or L_CommonUtil.handle(self.onUI_touchHandle, self)
  self.onUIClickHandle = self.onUIClickHandle or L_CommonUtil.handle(self.onUI_clickHandle, self)
  self.onUIDragHandle = self.onUIDragHandle or L_CommonUtil.handle(self.onUI_dragHandle, self)
  self.onUIDragEndHandle = self.onUIDragEndHandle or L_CommonUtil.handle(self.onUI_dragEndHandle, self)
  C_ScreenTouch.OnUI_LongTapStart(operator, self.onUITouchHandle)
  C_ScreenTouch.OnUI_LongTapEnd(operator, self.onUIClickHandle)
  C_ScreenTouch.OnUI_Click(operator, self.onUIClickHandle)
  C_ScreenTouch.OnUI_Drag(operator, self.onUIDragHandle)
  C_ScreenTouch.OnUI_DragEnd(operator, self.onUIDragEndHandle)
end

function cls:getHoldInfo(go)
  for i, v in ipairs(self.modules.formation_List) do
    local module = v
    if module:getRaycastGo() == go then
      return module.bind.petGuid, module.bind.is_trial, module.bind.slotId, module.bind.petGridMark
    end
  end
  for i, v in ipairs(self.modules.leftPetGrid) do
    local module = v
    if module:getRaycastGo() == go then
      return module.bind.petGuid, module.bind.is_trial, module.bind.slotId, module.bind.petGridMark
    end
  end
end

function cls:onUI_clickHandle(gesture)
  return self:endDrag()
end

function cls:onUI_touchHandle(gesture)
  if self.bindComponents.rect_drag.gameObject.activeSelf == true then
    print("outfrom1")
    return
  end
  if L_PetReleaseManager:getIsReleaseMode() then
    print("outfrom2")
    return
  end
  local go = gesture.go
  self.fingerId = gesture.fingerId
  local holdGuid, holdIsTrial, holdSlotId, holdFromGridMark = self:getHoldInfo(go)
  if math.isEmpty(holdGuid) then
    return
  end
  if not self.isBind then
    return
  end
  local touchPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_content, gesture.position)
  L_AudioUtil.playSound("Play_SFX_System_UI_General_Click_Hold")
  L_FlyMsgManager:startLongPress(gesture, 0.5, function()
    self._holdGuid, self._holdIsTrial, self._holdSlotId, self._holdFromGridMark = holdGuid, holdIsTrial, holdSlotId, holdFromGridMark
    L_Vector3.setAnchored(self.bindComponents.rect_drag, touchPos)
    self:showDragImg(true, holdGuid, holdIsTrial, holdGuid)
    if self._holdFromGridMark == "formation_list" then
      self.bind.active_downArea = true
    end
  end)
end

function cls:onUI_dragHandle(gesture)
  if L_PetReleaseManager:getIsReleaseMode() then
    return
  end
  local go = gesture:GetCurrentFirstPickedUIElement()
  if not math.isEmpty(go) then
    if go.name == "rect_removeArea" and self._holdFromGridMark == "formation_list" then
      self.bind.active_downAreaNormal = false
      self.bind.active_downAreaSelected = true
    else
      self.bind.active_downAreaNormal = true
      self.bind.active_downAreaSelected = false
    end
  end
  local touchPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_content, gesture.position)
  L_Vector3.setAnchored(self.bindComponents.rect_drag, touchPos)
end

function cls:onUI_dragEndHandle(gesture)
  if L_PetReleaseManager:getIsReleaseMode() then
    return
  end
  if gesture.fingerId ~= self.fingerId then
    return
  end
  local go = gesture:GetCurrentFirstPickedUIElement()
  if not math.isEmpty(self._holdGuid) then
    local holdGuid, holdIsTrail, holdSlotId, holdToGridMark = self:getHoldInfo(go)
    if holdGuid == self._holdGuid or holdSlotId == self._holdSlotId then
      self:endDrag()
      return
    end
    if math.isEmpty(holdSlotId) then
      if go.name == "rect_removeArea" and self._holdFromGridMark == "formation_list" then
        self.selectSlotId = self._holdSlotId
        self:onBtnCancelFormation()
      end
      self:endDrag()
      return
    end
    if holdToGridMark == "leftPetGrid" then
      self:endDrag()
      return
    end
    self:handleDragEffect(self._holdGuid, self._holdSlotId, self._holdIsTrial, holdGuid, holdSlotId)
    self:endDrag()
  else
    self:endDrag()
  end
end

function cls:showDragImg(isShow, holdGuid, holdIsTrial, holdSlotId)
  if L_PetReleaseManager:getIsReleaseMode() then
    return
  end
  if isShow then
    self.bindComponents.rect_drag.gameObject:ActiveTrans(true)
    self:changeDragCardInfo(holdGuid, holdIsTrial)
    self.bindComponents.scroll_petGrid.enabled = false
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_PickUp")
    for i, module in ipairs(self.modules.formation_List) do
      if module.bind.petGuid == holdGuid then
        module:setIsDragging(true, true)
      else
        module:setIsDragging(true, false)
      end
    end
    for i, module in ipairs(self.modules.leftPetGrid) do
      if module.bind.petGuid == holdGuid then
        module:setIsDragging(true, true)
      else
        module:setIsDragging(true, false)
      end
    end
  else
    self:endDrag()
  end
end

function cls:changeDragCardInfo(_petGuid, _isTrial)
  if 0 < _petGuid then
    local isForbidden = not L_PetDuelStore:checkPetValid({id = _petGuid, is_trial = _isTrial}, self.levelId)
    isForbidden = false
    self.modules.module_DragKiboCard:initData({
      petGuid = _petGuid,
      is_trial = _isTrial,
      slotId = self:getPetSlot(_petGuid, _isTrial),
      cellMode = L_PetConst.PetDuelEntranceCellMode.FormationSlot,
      isForbidden = isForbidden
    })
  end
end

function cls:handleDragEffect(fromGuid, fromSlotId, fromIsTrial, toGuid, toSlotId)
  self:changePetFormationFromDrag(fromGuid, fromSlotId, fromIsTrial, toSlotId)
  self:refreshLeftPetGridLit()
  L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Drop")
end

function cls:changePetFormationFromDrag(fromPetGuid, fromSlotId, fromIsTrial, toPetSlotId)
  L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_Qibo_SelectUp")
  local toPetUid = self.curFormationPetData[self.selectFormationSlotId][toPetSlotId].id
  local toPetIsTrial = self.curFormationPetData[self.selectFormationSlotId][toPetSlotId].is_trial
  local curPetSlotId = self:getPetSlot(fromPetGuid, fromIsTrial)
  self.curFormationPetData[self.selectFormationSlotId][toPetSlotId].id = fromPetGuid
  self.curFormationPetData[self.selectFormationSlotId][toPetSlotId].is_trial = fromIsTrial
  if 0 < curPetSlotId then
    self.curFormationPetData[self.selectFormationSlotId][curPetSlotId].id = toPetUid
    self.curFormationPetData[self.selectFormationSlotId][curPetSlotId].is_trial = toPetIsTrial
  end
  local curFormationPetGuids = self.curFormationPetData[self.selectFormationSlotId]
  local curNameList = L_PetDuelStore:getPetName(curFormationPetGuids)
  for i = 1, 8 do
    if curFormationPetGuids[i].id <= 0 then
      self.selectSlotId = i
      break
    end
  end
  for i = 1, #self.bind.formation_List do
    local isForbidden = not L_PetDuelStore:checkPetValid(curFormationPetGuids[i], self.levelId)
    self.bind.formation_List:change(i, {
      selectSlotId = self.selectSlotId,
      petGuid = curFormationPetGuids[i].id,
      is_trial = curFormationPetGuids[i].is_trial,
      isForbidden = isForbidden,
      petName = curNameList[i]
    })
  end
end

function cls:endDrag()
  if L_PetReleaseManager:getIsReleaseMode() then
    return
  end
  self._holdGuid, self._holdSlotId, self.fingerId = nil, nil, nil
  if not math.isEmpty(self.bindComponents.rect_drag) then
    self.bindComponents.rect_drag.gameObject:ActiveTrans(false)
  end
  self.bindComponents.scroll_petGrid.enabled = true
  self.bind.active_downAreaNormal = true
  self.bind.active_downAreaSelected = false
  self.bind.active_downArea = false
  for i, module in ipairs(self.modules.formation_List) do
    module:setIsDragging(false, false)
  end
  for i, module in ipairs(self.modules.leftPetGrid) do
    module:setIsDragging(false, false)
  end
  self:killAutoDragTimer()
end

function cls:createAutoDragTimer(index)
  self:killAutoDragTimer()
  local value = index == 1 and 1 or -1
  self.autoDragTimer = Timer.repeated(1.1, function()
    self:clearFilter()
    self.bind.snapToItemIndex = self.realIndex + value
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Switch")
  end, self)
end

function cls:killAutoDragTimer()
  if self.autoDragTimer then
    Timer.remove(self.autoDragTimer)
    self.autoDragTimer = nil
  end
end

function cls:showPetProperty(go, guid)
  local targetPosY = self.bindComponents.rect_pagePetDuelFormationNew.transform:InverseTransformPoint(go.transform.position).y
  local halfHeight = self.bindComponents.rect_moduleFormationPetProperty.sizeDelta.y / 2
  local halfWidth = self.bindComponents.rect_moduleFormationPetProperty.sizeDelta.x / 2
  local halfScreenHeight = self.bindComponents.rect_pagePetDuelFormationNew.transform.rect.height / 2
  local halfScreenWidth = self.bindComponents.rect_pagePetDuelFormationNew.transform.rect.width / 2
  if halfScreenHeight < targetPosY + halfHeight then
    targetPosY = halfScreenHeight - halfHeight
  elseif halfScreenHeight < halfHeight - targetPosY then
    targetPosY = halfHeight - halfScreenHeight
  end
  local halfPetGridWidth = self.bindComponents.rect_petGrid.transform.rect.width / 2
  local halfFormationGridWidth = self.bindComponents.rect_formationGrid.transform.rect.width / 2
  local petGridPosX = self.bindComponents.rect_pagePetDuelFormationNew.transform:InverseTransformPoint(self.bindComponents.rect_petGrid.transform.position).x
  local formationGridPosX = self.bindComponents.rect_pagePetDuelFormationNew.transform:InverseTransformPoint(self.bindComponents.rect_formationGrid.transform.position).x
  local PropertyModulePosXRight = petGridPosX + halfPetGridWidth + halfWidth
  local PropertyModulePosXLeft = formationGridPosX - halfFormationGridWidth - halfWidth
  if go.transform.position.x < 0 then
    self.bind.localPosition_propertyModule = L_Vector3.new(PropertyModulePosXRight, targetPosY, 0)
  else
    self.bind.localPosition_propertyModule = L_Vector3.new(PropertyModulePosXLeft, targetPosY, 0)
  end
  self._petPropertyModule:showModuleInfo(true, guid)
  self.bind.active_arrowLeft = go.transform.position.x < 0
  self.bind.active_arrowRight = go.transform.position.x > 0
  local targetPosArrowY = self._petPropertyModule:getArrowContentRect().transform:InverseTransformPoint(go.transform.position).y
  local PropertyModuleArrowPosXLeft = -(PropertyModuleArrowPosX + halfWidth)
  self.bind.localPosition_propertyModuleArrowLeft = L_Vector3.new(PropertyModuleArrowPosXLeft, targetPosArrowY, 0)
  local PropertyModuleArrowPosXRight = PropertyModuleArrowPosX + halfWidth
  self.bind.localPosition_propertyModuleArrowRight = L_Vector3.new(PropertyModuleArrowPosXRight, targetPosArrowY, 0)
end

function cls:initPageNormal()
  self:initFormationData()
  self:initModulePetBoxFilter()
  self.selectFormationSlotId = L_PetDuelStore:getCurPetDuelFormationSlot()
  self:initPointList()
  self:refreshFormationSlot()
end

function cls:openPetDuelScene()
  L_UIModelMgr:LoadHeroScenePrefabAsync(_scenePrefabPath, function(go)
    C_UISceneManager.SetSceneVisible()
    self.heroParent = go.transform:Find("PlayerModelRoot")
    self.prepareModeCamera = go.transform:Find("petCameraPrepare").gameObject
    self.formationModeCamera = go.transform:Find("petCameraFormation").gameObject
    self.HeroChangeCamera = go.transform:Find("petCameraHeroChange").gameObject
    self.bg = go.transform:Find("BgRoot/BgFullScreen_bg").gameObject
    self.bg_prepare_front = go.transform:Find("BgRoot/BgFullScreen_bg_prepare_front").gameObject
    self.bg_prepare_back = go.transform:Find("BgRoot/BgFullScreen_bg_prepare_back").gameObject
    self.petDuelFormationSceneGo = go
    self:changeMode(false)
    self:initPageNormal()
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
    L_CommonUtil.setObjActive(self.bg, isPrepare)
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

function cls:escHandle()
  if self.bind.active_petEdit then
    self:onEditFormation(false)
    self:refreshFormationSlot()
    return
  end
  if self.bind.active_heroGrid then
    self:onBtnChangeHero(false)
    return
  end
  if self.isSubFormation then
    self.closeCallback()
  end
  L_UI:close(self.pageName)
end

function cls:hide()
  if self.isOpenSkillPage then
    return
  end
  if L_CommonUtil.isValid(self.petDuelFormationSceneGo) then
    L_CommonUtil.setObjActive(self.petDuelFormationSceneGo, false)
  end
end

function cls:show()
  if L_CommonUtil.isValid(self.petDuelFormationSceneGo) then
    L_CommonUtil.setObjActive(self.petDuelFormationSceneGo, true)
  end
end

function cls:close(options)
  self:configTouch("-")
  L_ShortCutManager:removeShortCut(self.pageName)
  cls.super.close(self, options)
  self:saveFormationInfo()
  self:recycleEffectModel()
  if self.isNotInALevel then
    L_UIModelMgr:RecycleHeroEnvironment()
    L_UIModelMgr:RecycleHeroModel()
    L_UIModelMgr:RecycleViceHeroModel()
    C_UISceneManager.SetSceneVisible()
    L_PetDuelStore:setCurPetDuelFormationSlot(self.selectFormationSlotId)
  end
  self.bInit = false
  if self.entity ~= nil then
    self.entity:onDestroy()
  end
  L_PetStore:unListenCallFunc(L_PetStore.event.closePetBox, self.onClosePetBox, self)
  print("page close")
end

function cls:revert()
  local data = L_PetDuelStore:getPetDuelFormationHeroGuid(self.selectFormationSlotId)
end

function cls:showConfirmTips()
  local data = {
    txtTitle = L_WordsTpl:getValue("notice_title_petFormation_save"),
    txtContent = L_WordsTpl:getValue("notice_petFormation_save"),
    confirmCallback = function()
      self:onEditFormation(false)
      self:refreshFormationSlot()
    end,
    cancelCallback = function()
      self:revert()
      self:onEditFormation(false)
    end
  }
  L_GameUtil.showCommonTip(data)
end

return cls
