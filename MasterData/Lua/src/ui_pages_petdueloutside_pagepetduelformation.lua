local cls = class("pagePetDuelFormation", G_UIPageBase)
local _petTpl = L_GameTpl:getPetTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
local _unitTpl = L_GameTpl:getUnitTpl()
local _kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
local _elementTpl = L_GameTpl:getElementTypeTpl()
local _trialPetTpl = L_GameTpl:getTrialPetTpl()
local MaxFormationNum = 5

function cls.bind()
  return {
    formation_List = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelEntranceNew"
    },
    table_pet = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelEntranceNew"
    },
    txt_curFormationTag = nil,
    active_changeHero = false,
    scrollList_hero = {
      moduleName = "modulePages/cellIconUnit"
    },
    scrollList_heroSkill = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelSkill"
    },
    active_petContent = true,
    active_formationPet = false,
    active_formationLine = false,
    module_petFormation = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelEntranceNew"
    },
    modulePetBoxFilter = {
      moduleName = "modulePages/sortFilter/modulePetBoxFilter"
    },
    active_tablePet = true,
    active_emptyTips = false,
    loopListBoxPoint = {
      moduleName = "Pages/formation/formationModule/cellTeamPresetTip"
    },
    leftBtnActive = true,
    rightBtnActive = true,
    formationNumActive = true,
    moduleCommonTop = {
      moduleName = "modulePages/moduleCommonTop"
    }
  }
end

function cls.methods()
  return {
    onClick_changeLeft = function(self)
      self:onBtnChangeLeft()
    end,
    onClick_changeRight = function(self)
      self:onBtnChangeRight()
    end,
    onClick_closeChangeHero = function(self)
      self:onBtnCloseChangeHero()
    end,
    onClick_emptyArea = function(self)
      self:onClickEmpty()
    end
  }
end

function cls:preOpen(options)
  cls.super.preOpen(self, options)
  if C_ResolutionUtility.CheckSuperWidthScreen() then
    self.bindComponents.petRoot.offsetMax = C_Vector2(-440, self.bindComponents.petRoot.offsetMax.y)
    self.bindComponents.heroListRoot.offsetMax = C_Vector2(-440, self.bindComponents.heroListRoot.offsetMax.y)
  end
  self.levelId = options.levelId
  self.kiBoDuelCfg = _kiBoDuelTpl:getTplById(self.levelId)
  self.levelType = _kiBoDuelTpl:getLevelType(self.kiBoDuelCfg)
  self.heroParent = options.heroParent
  self:initPage()
  self:initCommonTopModule()
  L_PetStore:listenCallFunc(L_PetStore.event.closePetBox, self.onClosePetBox, self)
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
  self.bind.formationNumActive = L_PetDuelStore:getCurPetDuelFormationSlot() ~= L_Const.kiBoDuelBlockSlot
end

function cls:initCommonTopModule()
  local data = {
    name = L_WordsTpl:getValue("residual_code_pagepetduelformation_01"),
    helpBtnBool = false,
    mainBtnBool = false,
    closeCurPage = function()
      L_UI:close(self.pageName)
    end,
    helpBtn = function()
    end,
    mainBtn = function()
      L_UI:backToRoot()
    end
  }
  self.modules.moduleCommonTop:initModule(data)
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
    self.selectSlotId = 1
    self.selectHeroGuid = -1
    self.bind.txt_curFormationTag = tostring(self.selectFormationSlotId)
    self:applyFormationSlot()
    self:setPointListActive()
  end
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
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.list_persetTipImgs)
end

function cls:onRspPetBoxSelectCallBack(selectBoxIndex)
  self.selectPetBoxIndex = selectBoxIndex
  if self.bInit then
    self:refreshPetPoolInfo()
  end
  self.bInit = true
end

function cls:refreshBottomShow(bPetFormationChange)
  local function onClick_select(cell)
    self.selectSlotId = cell.bind.slotId
    
    for i = 1, #self.bind.formation_List do
      self.bind.formation_List:change(i, {
        selectSlotId = self.selectSlotId
      })
    end
    self:refreshPetPoolInfo()
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
  if not bPetFormationChange then
    local hasEmptySlot = false
    for i = self.selectSlotId, 8 do
      if curFormationPetGuids[i].id <= 0 then
        self.selectSlotId = i
        hasEmptySlot = true
        isValidEmpty = true
        break
      end
    end
    if not hasEmptySlot then
      for i = 1, self.selectSlotId - 1 do
        if curFormationPetGuids[i].id <= 0 then
          self.selectSlotId = i
          isValidEmpty = true
          break
        end
      end
    end
  end
  if not isValidEmpty and _kiBoDuelTpl:isKiboLock(self.levelId) then
    local info = L_PetDuelStore:getPetDuelFormationGroupInfo(L_Const.kiBoDuelBlockSlot)
    if 8 <= info.lockSlot then
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
      is_trial = info.is_trial,
      isForbidden = isForbidden,
      petName = curNameList[i]
    })
  end
  self.bind.formation_List:clear()
  self.bind.formation_List:insert_array(petItems)
  self:refreshPetPoolInfo()
end

function cls:changePetFormation(dstPetUid, isTrial)
  L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_Qibo_SelectUp")
  local dstSlot = self:getPetSlot(dstPetUid, isTrial)
  local curSelectUid = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id
  local curSelectIsTrial = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].is_trial
  self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id = dstPetUid
  self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].is_trial = isTrial
  if 0 < dstSlot then
    self.curFormationPetData[self.selectFormationSlotId][dstSlot].id = curSelectUid
    self.curFormationPetData[self.selectFormationSlotId][dstSlot].is_trial = curSelectIsTrial
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

function cls:refreshPetPoolInfo()
  local function onClick_select(cell)
    if L_PetDuelStore:getCurPetDuelFormationSlot() == L_Const.kiBoDuelBlockSlot then
      local info = L_PetDuelStore:getPetDuelFormationGroupInfo(L_PetDuelStore:getCurPetDuelFormationSlot())
      
      if info ~= nil and self.selectSlotId <= info.lockSlot then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_duel_cannt_formation"))
        return
      end
    end
    local curSelectPetGuid = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id
    local isTrial = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].is_trial
    if 0 < curSelectPetGuid and curSelectPetGuid == cell.petGuid and not isTrial == not cell.isTrial then
      self:onBtnCancelFormation()
    else
      self:changePetFormation(cell.petGuid, cell.isTrial)
      self:refreshPetPoolInfo()
    end
  end
  
  if self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId] == nil then
    return
  end
  local curSelectPetGuid = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id
  local isTrial = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].is_trial
  local petList = self:getPetList()
  local petCount = #petList
  self.bind.active_tablePet = 0 < curSelectPetGuid or 0 < petCount
  self.bind.active_emptyTips = curSelectPetGuid <= 0 and petCount < 1
  if curSelectPetGuid <= 0 and petCount < 1 then
    return
  end
  self.bind.active_formationPet = 0 < curSelectPetGuid
  self.bind.active_formationLine = 0 < curSelectPetGuid
  if 0 < curSelectPetGuid then
    local isForbidden = not L_PetDuelStore:checkPetValid({id = curSelectPetGuid, is_trial = isTrial}, self.levelId)
    self.modules.module_petFormation:initData({
      petGuid = curSelectPetGuid,
      is_trial = isTrial,
      slotId = self:getPetSlot(curSelectPetGuid, isTrial),
      callback = onClick_select,
      cellMode = L_PetConst.PetDuelEntranceCellMode.FormationPetPool,
      isForbidden = isForbidden
    })
  end
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.petRoot)
  local petItems = {}
  for i, v in ipairs(petList) do
    local isForbidden = not L_PetDuelStore:checkPetValid(v, self.levelId)
    table.insert(petItems, {
      petGuid = v.id,
      is_trial = v.is_trial,
      slotId = self:getPetSlot(v.id, v.is_trial),
      callback = onClick_select,
      cellMode = L_PetConst.PetDuelEntranceCellMode.FormationPetPool,
      isForbidden = isForbidden
    })
  end
  self.bind.table_pet:clear()
  self.bind.table_pet:insert_array(petItems)
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
  L_UIModelMgr:LoadHeroModelAsync(path, _heroTpl:getKiBoDuelFormationHeroTransOffset(heroCfg), _heroTpl:getKiBoDuelFormationHeroTransEuler(heroCfg), _heroTpl:getKiBoDuelFormationHeroTransScale(heroCfg), function(go)
    local isPlayerHero = self.selectHeroGuid == L_HeroStore:getDefaultHeroGuid()
    local needAnimaList = {"KiboDuelUi"}
    local entity = L_EntityManager:generateSimpleHero(L_HeroStore:getHeroConfigId(heroInfo), go, isPlayerHero, nil, needAnimaList, C_EEntityEntranceType.PetDuel)
    entity.playableAnimator:Play("KiboDuelUi")
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
  self.bind.scrollList_hero:clear()
  self.bind.scrollList_hero:insert_array(dataArray)
  self:setHeroListActive()
end

function cls:setHeroListActive()
  for i, v in pairs(self.modules.scrollList_hero) do
    v:setSelectState(v.bind.guid == self.selectHeroGuid)
  end
end

function cls:refreshHeroSkillShow()
  if #self.curFormationSkillData[self.selectFormationSlotId] <= 0 then
    self.curFormationSkillData[self.selectFormationSlotId] = L_PetDuelStore:getDefaultSkillInfos(self.levelId)
  end
  local curSkillInfo = self.curFormationSkillData[self.selectFormationSlotId]
  
  local function onClickHeroSkillCell(cell)
    L_UI:open("pagePetDuelSelectSkill", {
      selectSkillId = cell.bind.skillId,
      levelId = cell.bind.levelId,
      callback = function(selectSkillsId)
        self:onBtnSaveCallBack(selectSkillsId)
        self:refreshHeroSkillShow()
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
      callback = onClickHeroSkillCell
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

function cls:getPetList()
  local curSelectPetGuid = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id
  local isTrial = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].is_trial
  local petBoxList = L_PetStore:getPetBoxList(self.selectPetBoxIndex)
  local petList = {}
  local hasCurSelectPet = false
  if self.levelType == L_Const.kiBoDuelLevelType.system or self.levelType == L_Const.kiBoDuelLevelType.mix then
    local systemKiBoList = _kiBoDuelTpl:getKiboList(self.kiBoDuelCfg)
    for i = 1, #systemKiBoList do
      if systemKiBoList[i] == curSelectPetGuid and isTrial then
        hasCurSelectPet = true
      end
      if systemKiBoList[i] == curSelectPetGuid and isTrial then
      elseif self:getPetSlot(systemKiBoList[i], true) <= 0 then
        table.insert(petList, {
          is_trial = true,
          id = systemKiBoList[i]
        })
      end
    end
  end
  if not table.isEmpty(petBoxList) then
    for _, v in ipairs(petBoxList) do
      local pet = L_PetStore:getPetItem(v)
      if not table.isEmpty(pet) then
        if v == curSelectPetGuid and not isTrial then
          hasCurSelectPet = true
        end
        if v == curSelectPetGuid and not isTrial then
        elseif self:getPetSlot(v, false) <= 0 then
          table.insert(petList, {is_trial = false, id = v})
        end
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
  local mousePosition = CS.UnityEngine.Input.mousePosition
  local success, hit = C_CameraManager.mainCamera:ScreenRaycastByLayer(C_Vector2(mousePosition.x, mousePosition.y), "Character")
  if success then
    self:onBtnChangeHero()
    for i, v in pairs(self.modules.formation_List) do
      v:setSelectHero(true)
    end
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
  self:refreshPetPoolInfo()
end

function cls:onBtnChangeLeft()
  self:saveFormationInfo()
  self.selectFormationSlotId = self.selectFormationSlotId - 1
  if self.selectFormationSlotId < 1 then
    self.selectFormationSlotId = MaxFormationNum
  end
  self:refreshFormationSlot()
end

function cls:onBtnChangeRight()
  self:saveFormationInfo()
  self.selectFormationSlotId = self.selectFormationSlotId + 1
  if self.selectFormationSlotId > MaxFormationNum then
    self.selectFormationSlotId = 1
  end
  self:refreshFormationSlot()
end

function cls:onBtnChangeHero()
  self.bind.active_changeHero = true
  self.bind.active_petContent = false
  self:refreshHeroList()
end

function cls:onBtnCloseChangeHero()
  self.bind.active_changeHero = false
  self.bind.active_petContent = true
  for i, v in pairs(self.modules.formation_List) do
    v:setSelectHero(false)
  end
end

function cls:close(options)
  cls.super.close(self, options)
  self:saveFormationInfo()
  self:recycleEffectModel()
  self.bInit = false
  L_PetStore:unListenCallFunc(L_PetStore.event.closePetBox, self.onClosePetBox, self)
end

return cls
