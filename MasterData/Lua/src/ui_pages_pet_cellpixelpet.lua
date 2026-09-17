local this = class("cellPixelPet", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()
local petGradeTpl = L_GameTpl:getPetGradeTpl()
local petTalentTpl = L_GameTpl:getPetTalentTpl()
local IsPc = L_DeviceTpl:getIsPc()
local _homeTalentTpl = L_GameTpl:getHomeTalentTpl()
local _petHomeTalentTpl = L_GameTpl:getPetHomeTalentTpl()
local _homeDropTpl = L_GameTpl:getHomeDropTpl()
local _petPixelTagTpl = L_GameTpl:getPetPixelTagTpl()

local function setBindValue(bind, key, value)
  if bind[key] ~= value then
    bind[key] = value
  end
end

local INFO_LIST_POS_Y_DEFAULT = -88
local INFO_LIST_POS_Y_COUNT_3 = -75
local INFO_LIST_POS_Y_COUNT_4 = -82
local INFO_LIST_POS_DEFAULT, INFO_LIST_POS_COUNT_3, INFO_LIST_POS_COUNT_4, LOCK_POS_GRADE, LOCK_POS_LABOR
local PET_GRADE_GROUP_CACHE = {}
local PET_GRADE_SCORE_MIN

local function sortPetGradeTpl(a, b)
  return a.grade[1] < b.grade[1]
end

local function getPetGradeGroup(petRank, petRare)
  local rankCache = PET_GRADE_GROUP_CACHE[petRank]
  if not rankCache then
    rankCache = {}
    PET_GRADE_GROUP_CACHE[petRank] = rankCache
  end
  local group = rankCache[petRare]
  if group then
    return group
  end
  group = {}
  local allGradeRank = petGradeTpl:getAllData()
  for i, v in ipairs(allGradeRank) do
    if v.petRank == petRank and v.petRare == petRare then
      table.insert(group, v)
    end
  end
  table.sort(group, sortPetGradeTpl)
  rankCache[petRare] = group
  return group
end

local function getPetGradeRank(totalScore, petConfigId)
  PET_GRADE_SCORE_MIN = PET_GRADE_SCORE_MIN or L_GameTpl:getGameConstTpl():getData("PET_GRADE_SCORE_MIN", L_Const.GameTplType.int)
  totalScore = math.max(totalScore, PET_GRADE_SCORE_MIN)
  local petCfg = petTpl:getTplById(petConfigId)
  local petRank = petCfg and petTpl:getPetStage(petCfg) or 1
  local petRare = petCfg and petCfg.petrare or 0
  local group = getPetGradeGroup(petRank, petRare)
  local gradeRank = 1
  for i, v in ipairs(group) do
    if totalScore >= v.grade[1] and totalScore <= v.grade[2] then
      gradeRank = i
      break
    end
  end
  return gradeRank
end

local function getInfoListPosition(posY)
  if posY == INFO_LIST_POS_Y_COUNT_4 then
    INFO_LIST_POS_COUNT_4 = INFO_LIST_POS_COUNT_4 or C_Vector3(0, INFO_LIST_POS_Y_COUNT_4, 0)
    return INFO_LIST_POS_COUNT_4
  elseif posY == INFO_LIST_POS_Y_COUNT_3 then
    INFO_LIST_POS_COUNT_3 = INFO_LIST_POS_COUNT_3 or C_Vector3(0, INFO_LIST_POS_Y_COUNT_3, 0)
    return INFO_LIST_POS_COUNT_3
  end
  INFO_LIST_POS_DEFAULT = INFO_LIST_POS_DEFAULT or C_Vector3(0, INFO_LIST_POS_Y_DEFAULT, 0)
  return INFO_LIST_POS_DEFAULT
end

local function getLockPosition(posY)
  if posY == 0 then
    LOCK_POS_GRADE = LOCK_POS_GRADE or C_Vector2(0, 0)
    return LOCK_POS_GRADE
  end
  LOCK_POS_LABOR = LOCK_POS_LABOR or C_Vector2(-3.5, -89.9)
  return LOCK_POS_LABOR
end

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    hungerColor = {
      [L_PetConst.SatietyStatus.LESS] = "#ff7e6d",
      [L_PetConst.SatietyStatus.MIDDLE] = "#ffbf35",
      [L_PetConst.SatietyStatus.FULL] = "#27ae89"
    }
  }
  self.tagNodeMap = {}
  self.tagActiveMap = {}
  self.tagVisibleMap = {}
end

function this:buildPetDisplayInfo(serverData, guid, filterType)
  local info = self._petDisplayInfo or {}
  self._petDisplayInfo = info
  info.guid = guid
  info.petConfigId = serverData and serverData.id or nil
  info.grade = nil
  info.gradeRank = 0
  info.gradeTpl = nil
  info.gradeValue = nil
  info.gradeIcon = nil
  info.gradeFrame = nil
  info.talentGradeTpl = nil
  info.talentPixelIcon = nil
  info.talentPixelBase = nil
  info.bodyType = nil
  if serverData and serverData.comprehension then
    local talentGradeTpl
    if not math.isEmpty(serverData.petTalentId) then
      talentGradeTpl = petTalentTpl:getTplById(serverData.petTalentId)
    else
      local totalIV = L_PetStore:getPetSixDimPotentialQualification(serverData)
      talentGradeTpl = L_PetStore:getPetTalentGradeTplByTotalIV(totalIV)
    end
    if talentGradeTpl then
      info.talentGradeTpl = talentGradeTpl
      info.talentPixelIcon = petTalentTpl:getPixelIcon(talentGradeTpl)
      info.talentPixelBase = petTalentTpl:getPetPixelBase(talentGradeTpl)
      local tpl = petTpl:getTplById(serverData.id)
      info.bodyType = petTpl:getBodyType(tpl)
    end
  end
  local needGrade = filterType ~= L_PetConst.filterPetBox.labor and filterType ~= L_PetConst.filterPetBox.laborOnlyGrade
  needGrade = needGrade or string.isEmpty(info.talentPixelBase)
  if needGrade then
    local grade, gradeRank
    if self.petInfo and self.petInfo.gradeRank then
      grade = self.petInfo.grade
      gradeRank = self.petInfo.gradeRank
    elseif serverData then
      if type(serverData.getPetGrade) == "function" then
        grade = serverData:getPetGrade()
      else
        grade = serverData.grade or 0
      end
      gradeRank = getPetGradeRank(grade, serverData.id)
    end
    info.grade = grade or 0
    info.gradeRank = gradeRank or 0
    if info.gradeRank ~= 0 then
      info.gradeTpl = petGradeTpl:getTplById(info.gradeRank)
    end
    info.gradeValue = tostring(info.grade)
    info.gradeIcon = info.gradeTpl and petGradeTpl:getIcon(info.gradeTpl) or ""
    info.gradeFrame = info.gradeTpl and petGradeTpl:getPetGradeFrame(info.gradeTpl) or ""
  end
  return info
end

function this.bind()
  return {
    stat_go_yellow = true,
    stat_go_blue = false,
    empty = true,
    content = false,
    frameBg = "",
    gradeGroup = false,
    gradeValue = nil,
    gradeIcon = nil,
    crownSamllIcon = "",
    crownBigIcon = "",
    crownSmallIconActive = false,
    crownBigIconActive = false,
    crownActive = false,
    gradeAsset = nil,
    hungerIconColor = C_Color.white,
    masterGroup = false,
    masterIcon = "",
    workStatusGroup = false,
    workStatusIcon = "",
    workStatusIcon2 = "",
    txtWorkStatus = "",
    txtWorkStatus2 = "",
    selected = false,
    module_pixelIcon = {
      moduleName = "pages/pet/modulePetPixelIcon"
    },
    emptySelect = false,
    exchangeSelect = false,
    releaseTagActive = false,
    petStatusActive = false,
    petLockActive = false,
    modulesPetGameplayStatus = {
      type = "toggleModule",
      modulePetGameplayStatus = {
        assetName = "UI/Pages/Pet/modulePetGameplayStatus",
        moduleName = "pages/pet/modulePetGameplayStatus"
      }
    },
    togglePetGameplayStatus = "",
    list_petLabors = {
      moduleName = "pages/pet/cellPixelPetLabor"
    },
    active_petLaborList = false,
    position_rect_infoList = nil,
    module_petLevel = {
      moduleName = "pages/pet/cellPixelPetLevel"
    },
    active_petLevel = false,
    activeEdit = false,
    dropItem = false,
    imgDropItem = "",
    go_maskPc = false,
    go_maskMobile = false,
    masterIconMobile = "",
    skinActive = false,
    txt_mutationNum = "",
    mutationTypeActive = false,
    reddotGeneActive = false,
    reddotNewActive = false,
    workStatusActive = false,
    evolutionActive = false,
    reddotNormalActive = false,
    filterEmpty = false
  }
end

function this:_bindTagNodes()
  self.tagNodeMap = {
    [L_PetConst.TagEnum.ReddotNew] = function(active)
      self.bind.reddotNewActive = active
    end,
    [L_PetConst.TagEnum.Team] = function(active)
      self.bind.masterGroup = active
    end,
    [L_PetConst.TagEnum.TalentGrade] = function(active)
      self.bind.crownActive = active
    end,
    [L_PetConst.TagEnum.Skin] = function(active)
      self.bind.skinActive = active
    end,
    [L_PetConst.TagEnum.Gene] = function(active)
      self.bind.reddotNormalActive = active
    end,
    [L_PetConst.TagEnum.Evolution] = function(active)
      self.bind.reddotNormalActive = active
    end,
    [L_PetConst.TagEnum.Starsoul] = function(active)
      self.bind.reddotNormalActive = active
    end,
    [L_PetConst.TagEnum.ReleaseSelect] = function(active)
      self.bind.releaseTagActive = active
    end,
    [L_PetConst.TagEnum.ReleaseStatus] = function(active)
      self.bind.petStatusActive = active
    end,
    [L_PetConst.TagEnum.WorkStatus] = function(active)
      self.bind.workStatusActive = active
    end,
    [L_PetConst.TagEnum.Annoy] = function(active)
      self._pixelIconModule:SetAnnoyActive(active)
    end,
    [L_PetConst.TagEnum.Lock] = function(active)
      self.bind.petLockActive = active
    end
  }
  for tagType, _ in pairs(_petPixelTagTpl:getTagInfo()) do
    if self.tagActiveMap[tagType] == nil then
      self.tagActiveMap[tagType] = false
    end
    self.tagVisibleMap[tagType] = false
  end
end

function this:refreshCrownIcon(serverData, guid, isHideCrown, displayInfo)
  if not serverData then
    self:SetTagActive(L_PetConst.TagEnum.TalentGrade, false)
    return
  end
  local petData = serverData
  petData = guid and not petData.comprehension and L_PetStore:getPetItem(guid) or petData
  if not petData or not petData.comprehension then
    self:SetTagActive(L_PetConst.TagEnum.TalentGrade, false)
    return
  end
  local talentGradeTpl = displayInfo and displayInfo.talentGradeTpl
  if talentGradeTpl then
  else
    local totalIV = L_PetStore:getPetSixDimPotentialQualification(petData)
    talentGradeTpl = L_PetStore:getPetTalentGradeTplByTotalIV(totalIV)
  end
  if talentGradeTpl then
    local pixelIcon = displayInfo and displayInfo.talentPixelIcon or petTalentTpl:getPixelIcon(talentGradeTpl)
    local bodyType = displayInfo and displayInfo.bodyType
    if not bodyType then
      local tpl = petTpl:getTplById(serverData.id)
      bodyType = petTpl:getBodyType(tpl)
    end
    if 2 < bodyType then
      setBindValue(self.bind, "crownBigIcon", pixelIcon or "")
    else
      setBindValue(self.bind, "crownSamllIcon", pixelIcon or "")
    end
    setBindValue(self.bind, "crownSmallIconActive", bodyType <= 2)
    setBindValue(self.bind, "crownBigIconActive", 2 < bodyType)
    self:SetTagActive(L_PetConst.TagEnum.TalentGrade, not string.isEmpty(pixelIcon) and isHideCrown ~= true)
  else
    self:SetTagActive(L_PetConst.TagEnum.TalentGrade, false)
  end
end

function this.methods()
  return {
    onClick = function(self)
      if self.select then
        if self.bind.removeCallback then
          self.bind.removeCallback(self)
        end
      elseif self.bind.callback then
        if not string.isEmpty(self.bind.reddotName) then
          L_ReddotManager:clearNew(L_ReddotManager.DotDef.PetNew, self.bind.guid)
          self:SetTagActive(L_PetConst.TagEnum.ReddotNew, false)
          self:refreshView(true)
        end
        self.bind.callback(self)
      end
    end,
    onClick_Enemy = function(self)
      if self.bind.callback_Empty then
        self.bind.callback_Empty(self)
      end
    end,
    onPointEnter_content = function(self)
      if not IsPc then
        return
      end
      if self.bind.pointEnterCallback then
        self.bind.pointEnterCallback(self)
      end
    end,
    onPointExit_content = function(self)
      if not IsPc then
        return
      end
      if self.bind.pointExitCallback then
        self.bind.pointExitCallback(self)
      end
    end,
    onPointEnter_slot = function(self)
      if self.parent == nil or not self.parent.isDragging then
        return
      end
      if self.bind.empty ~= true then
        return
      end
      self:setEmptySelect(true)
    end,
    onPointExit_slot = function(self)
      if self.parent == nil or not self.parent.isDragging then
        return
      end
      if self.bind.empty ~= true then
        return
      end
      self:setEmptySelect(false)
    end,
    onPointEnter_exchange = function(self)
      if not (self.parent ~= nil and self.parent.isDragging) or self.isDragSelect then
        return
      end
      if self.bind.content ~= true then
        return
      end
      if self.parent and self.parent.parent and self.parent.parent._holdGuid and self.parent.parent._holdGuid == self.bind.guid then
        return
      end
      self:setExchangeSelect(true)
    end,
    onPointExit_exchange = function(self)
      if self.parent == nil or self.isDragSelect then
        return
      end
      if self.bind.content ~= true then
        return
      end
      self:setExchangeSelect(false)
    end
  }
end

function this:open()
  this.super.open(self)
  self.isPc = L_DeviceTpl:getIsPc()
  self.bind.go_maskPc = self.isPc
  self.bind.go_maskMobile = not self.isPc
  self._pixelIconModule = self.modules.module_pixelIcon
  self:_bindTagNodes()
end

function this:show(options)
  L_SatietyStore:listenCallFunc(L_SatietyStore.event.satiety_value_refresh, self.onRefreshSatiety, self)
  L_PetStore:listenCallFunc(L_PetStore.event.setPetReleaseMode, self.refreshPetStatus, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshStarSoul, self.refreshPetStarSoulStatus, self)
end

function this:hide()
  L_SatietyStore:unListenCallFunc(L_SatietyStore.event.satiety_value_refresh, self.onRefreshSatiety, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.setPetReleaseMode, self.refreshPetStatus, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshStarSoul, self.refreshPetStarSoulStatus, self)
end

function this:refreshSubCell()
  local pet = L_PetStore:getPetItem(self.bind.guid)
  if pet then
    local petTpl = L_GameTpl:getPetTpl()
    local tpl = petTpl:getTplById(pet.id)
    local status = pet:getGameplayStatus()
    self:SetTagActive(L_PetConst.TagEnum.ReleaseStatus, status ~= L_Const.PetState.PET_NORMAL or not petTpl:getIsRelease(tpl))
    if self.bind.petStatusActive then
      self.bind.togglePetGameplayStatus = "modulePetGameplayStatus"
      local moduleStatus = self.modules.modulesPetGameplayStatus[self.bind.togglePetGameplayStatus]
      moduleStatus:setPetReleaseData(self.bind.guid)
    else
      local moduleStatus = self.modules.modulesPetGameplayStatus[self.bind.togglePetGameplayStatus]
      if moduleStatus then
        moduleStatus:setContentShow(false)
      end
    end
    self:SetTagActive(L_PetConst.TagEnum.Lock, pet.is_lock and self:isInHouse())
  end
end

function this:hidePetStatus()
  local moduleStatus = self.modules.modulesPetGameplayStatus[self.bind.togglePetGameplayStatus]
  if moduleStatus then
    moduleStatus:setContentShow(false)
  end
end

function this:refreshNoReleaseSunCell()
  local pet = L_PetStore:getPetItem(self.bind.guid)
  if pet then
    self:SetTagActive(L_PetConst.TagEnum.Lock, pet.is_lock and self:isInHouse())
  end
end

function this:refreshInfoListPosition(laborCount)
  if not self.isBind then
    return
  end
  local posY = INFO_LIST_POS_Y_DEFAULT
  if self.bind.active_petLaborList then
    local count = laborCount
    if count == nil then
      count = #self.bind.list_petLabors
    end
    if self.bind.workStatusGroup then
      count = count + 1
    end
    if 4 <= count then
      posY = INFO_LIST_POS_Y_COUNT_4
    elseif 3 <= count then
      posY = INFO_LIST_POS_Y_COUNT_3
    end
  end
  if self._lastInfoListPosY == posY then
    return
  end
  self._lastInfoListPosY = posY
  self.bind.position_rect_infoList = getInfoListPosition(posY)
end

function this:alignLockPositionWithGradeAndLabor()
  if not self.bind.petLockActive then
    return
  end
  if not self.isBind then
    return
  end
  local showGrade = self.bind.gradeGroup
  local showLaborList = self.bind.active_petLaborList
  local parentTransform
  local lockTransform = self.bindComponents.transLock
  local lockAnchoredPos
  local offsetX = 0
  if showGrade then
    parentTransform = self.bindComponents.transLayoutLock
    lockAnchoredPos = getLockPosition(0)
  end
  if showLaborList then
    parentTransform = self.bindComponents.transContent
    lockAnchoredPos = getLockPosition(INFO_LIST_POS_Y_DEFAULT)
  end
  if parentTransform then
    lockTransform:SetParent(parentTransform)
    lockTransform.gameObject:SetActive(true)
    lockTransform.anchoredPosition = lockAnchoredPos
  end
end

function this:clearLockStatus()
  self:SetTagActive(L_PetConst.TagEnum.Lock, false)
  self:SetTagActive(L_PetConst.TagEnum.ReleaseStatus, false)
  self:SetTagActive(L_PetConst.TagEnum.Team, false)
end

function this:setCount(selectCount)
  if self.bind.itemShowType == L_Const.submitItemShowType.submitTarget then
  elseif self.bind.itemShowType == L_Const.submitItemShowType.select then
    local select = selectCount and 0 < selectCount or false
    self:setSelect(select, selectCount)
  end
end

function this:setSelect(select, num)
  self.select = select
  self._pixelIconModule:outLineShow(select)
  self:SetTagActive(L_PetConst.TagEnum.ReleaseSelect, select)
end

function this:setSelectNew(select)
  self.select = select
  self.bind.selected = select
  self._pixelIconModule:outLineShow(select)
  self:SetTagActive(L_PetConst.TagEnum.ReleaseSelect, select)
end

function this:setSelectPetBox(select, poinEnter)
  self.select = select
  self.bind.selected = poinEnter
  if self._pixelIconModule then
    self._pixelIconModule:outLineShow(select)
  end
  self:SetTagActive(L_PetConst.TagEnum.ReleaseSelect, select)
end

function this:refresh()
  if self.parent and self.parent.filter then
    self.bind.filterType = self.parent.filter
  elseif self.parent and self.parent.parent and self.parent.parent.filter then
    self.bind.filterType = self.parent.parent.filter
  end
  self:refreshView()
end

function this:refreshFilterType(filterType)
  self.bind.filterType = filterType
  self:refreshView()
end

function this:refreshView(skipGifUpdate)
  if not self.isBind then
    return
  end
  self:_resetAllTag()
  if self.bind.filterEmpty then
    self.bind.empty = false
    self.bind.content = false
    return
  end
  local guid = self.bind.guid
  L_ProfilerUtil.BeginSample("lua ui cellPixel refreshView")
  self.bind.choice = L_PetStore:getCurSelectPetId() == guid
  if not math.isEmpty(guid) then
    self:setPetDataContent(guid, self.bind, true)
    if not skipGifUpdate then
      if L_PetReleaseManager:getIsReleaseMode() then
        self:setGifPlay(L_PetReleaseManager:isPetSelected(guid) or self.bind.pointEnter)
      else
        self:setGifPlay(self.bind.choice or self.bind.pointEnter)
      end
    end
    self:setOutLineShow(self.bind.selected)
  else
    self.bind.empty = true
    self.bind.content = false
  end
  L_ProfilerUtil.EndSample()
end

function this:close()
  L_PhotoManager:clearPhotoEntity(self)
  if self._pixelIconModule then
    self._pixelIconModule:close()
  end
  if self.exchangeAudioTimer then
    Timer.remove(self.exchangeAudioTimer)
    self.exchangeAudioTimer = nil
  end
  self.bind.togglePetGameplayStatus = ""
  self.bind.togglePetPixelIcon = ""
end

function this:refreshGradeGroup(filterType, displayInfo)
  local grade, gradeRank
  if displayInfo and displayInfo.gradeRank then
    grade = displayInfo.grade
    gradeRank = displayInfo.gradeRank
  elseif self.petInfo and self.petInfo.gradeRank then
    grade = self.petInfo.grade
    gradeRank = self.petInfo.gradeRank
  else
    grade, gradeRank = L_PetStore:getPetGradeNew(self.bind.guid)
  end
  self.setPetFilterType(filterType)
  local bind = self.bind
  if filterType == L_PetConst.filterPetBox.labor or filterType == L_PetConst.filterPetBox.laborOnlyGrade then
    setBindValue(bind, "active_petLaborList", true)
    setBindValue(bind, "active_petLevel", false)
    setBindValue(bind, "gradeGroup", false)
    setBindValue(bind, "frameBg", "")
  else
    local gradeTpl
    if displayInfo and displayInfo.gradeTpl then
      gradeTpl = displayInfo.gradeTpl
    elseif gradeRank ~= 0 then
      gradeTpl = petGradeTpl:getTplById(gradeRank)
    end
    local frameBg = displayInfo and displayInfo.gradeFrame or gradeTpl and petGradeTpl:getPetGradeFrame(gradeTpl) or ""
    if filterType == L_PetConst.filterPetBox.grade then
      setBindValue(bind, "active_petLaborList", false)
      setBindValue(bind, "active_petLevel", false)
      setBindValue(bind, "frameBg", frameBg)
      setBindValue(bind, "gradeAsset", "UI/Pages/Pet/dynamic/cellGrade.prefab")
      setBindValue(bind, "gradeValue", displayInfo and displayInfo.gradeValue or tostring(grade))
      setBindValue(bind, "gradeIcon", displayInfo and displayInfo.gradeIcon or gradeTpl and petGradeTpl:getIcon(gradeTpl) or "")
      setBindValue(bind, "hungerIconColor", C_Color.white)
      setBindValue(bind, "gradeGroup", true)
    elseif filterType == L_PetConst.filterPetBox.level then
      setBindValue(bind, "active_petLaborList", false)
      setBindValue(bind, "frameBg", frameBg)
      setBindValue(bind, "gradeGroup", false)
      setBindValue(bind, "active_petLevel", true)
      local modulePetLevel = self.modules.module_petLevel
      if modulePetLevel and modulePetLevel.refreshData then
        modulePetLevel:refreshData(self.levelValue, self.petConfigId)
      end
    elseif filterType == L_PetConst.filterPetBox.satiety then
      setBindValue(bind, "active_petLaborList", false)
      setBindValue(bind, "active_petLevel", false)
      setBindValue(bind, "frameBg", frameBg)
      setBindValue(bind, "gradeAsset", "UI/Pages/Pet/dynamic/cellHunger.prefab")
      setBindValue(bind, "gradeValue", self.hungerValue)
      setBindValue(bind, "gradeIcon", "UI/Icon/PetBoxNew/tex_pet_icon_satietyIcon.png")
      setBindValue(bind, "hungerIconColor", self.hungerColor)
      setBindValue(bind, "gradeGroup", true)
    else
      setBindValue(bind, "active_petLaborList", false)
      setBindValue(bind, "active_petLevel", false)
      setBindValue(bind, "gradeGroup", false)
      setBindValue(bind, "frameBg", "")
    end
  end
  self:alignLockPositionWithGradeAndLabor()
  self:refreshInfoListPosition()
end

function this:refreshPetWorkStatusIcon(statusIcon)
  if not statusIcon or string.isEmpty(statusIcon) or string.isEmpty(self.bind.txtWorkStatusStr) then
    self.bind.workStatusGroup = false
    self:refreshInfoListPosition()
    return
  end
  self.bind.workStatusGroup = true
  self.bind.workStatusIcon = statusIcon
  self.bind.workStatusIcon2 = statusIcon
  self.bind.txtWorkStatus = self.bind.txtWorkStatusStr
  self.bind.txtWorkStatus2 = self.bind.txtWorkStatusStr
  local ctlWorkStatNum = 1
  if "UI/Page/PetBox/tex_pet_frame_homeranch.png" == statusIcon or "UI/Page/PetBox/tex_pet_frame_homework.png" == statusIcon then
    ctlWorkStatNum = 0
  end
  self.bind.stat_go_yellow = ctlWorkStatNum == 1 and true or false
  self.bind.stat_go_blue = ctlWorkStatNum == 0 and true or false
  self:refreshInfoListPosition()
end

function this:setPetGUID(guid)
  if guid then
    self.bind.guid = guid
  end
end

function this:setPetFilterType(filterType)
  if filterType then
    self.bind.filterType = filterType
  end
end

function this:setPetDataContent(guid, params, skipResetTag)
  if not self.isBind then
    return
  end
  if skipResetTag ~= true then
    self:_resetAllTag()
  end
  local bind = self.bind
  bind.guid = guid
  if params and params ~= bind then
    table.merge(bind, params)
  end
  local isEmpty = math.isEmpty(guid)
  bind.empty = isEmpty
  bind.content = not isEmpty
  if bind.filterEmpty then
    bind.empty = false
    bind.content = false
    return
  end
  bind.itemShowType = params.setPetDataContent
  bind.pageType = params.pageType
  if params.clickCallback then
    bind.callback = params.clickCallback
  end
  if params.clickRemoveHandle then
    bind.removeCallback = params.clickRemoveHandle
  end
  if params.callback_Empty then
    bind.callback_Empty = params.callback_Empty
  end
  local petStore = L_PetStore
  local serverData = petStore:getPetItem(guid)
  if not serverData and params.petInfo then
    self.petInfo = params.petInfo
    serverData = {
      lv = self.petInfo.lv,
      satiety = self.petInfo.satiety,
      id = self.petInfo.id
    }
    local infoPetCfg = petTpl:getTplById(self.petInfo.id)
    local infoPetRare = infoPetCfg and infoPetCfg.petrare or 0
    local infoPetRank = infoPetCfg and petTpl:getPetStage(infoPetCfg) or 1
    self.petInfo.gradeRank = petStore:calGradeRank(self.petInfo.grade, infoPetRank, infoPetRare)
    self._pixelIconModule:setPetInfo(self.petInfo)
  end
  local displayInfo
  if serverData then
    displayInfo = self:buildPetDisplayInfo(serverData, guid, params.filterType)
    self._pixelIconModule:setGuid(guid, nil, serverData, displayInfo)
    self._pixelIconModule:outLineShow(params.outlineShow)
    if self.bind.filterType == L_PetConst.filterPetBox.satiety then
      self:refreshSatiety(serverData.satiety, guid)
    end
    self:refreshCrownIcon(serverData, guid, params.isHideCrown, displayInfo)
    if self._lastLevel ~= serverData.lv then
      self._lastLevel = serverData.lv
      self.levelValue = string.format("Lv.%d", serverData.lv)
    end
    self.petConfigId = serverData.id
    local reddotManager = L_ReddotManager
    self.bind.mutationTypeActive = false
    if not math.isEmpty(serverData.mutation_times) then
      if self._lastMutationTimes ~= serverData.mutation_times then
        self._lastMutationTimes = serverData.mutation_times
        self.bind.txt_mutationNum = "x" .. serverData.mutation_times
      end
    else
      self._lastMutationTimes = nil
    end
    if not math.isEmpty(serverData.hero_id) and L_HeroStore:getHero(serverData.hero_id) then
      self:RefreshTeamActive()
      self:refreshPetWorkStatusIcon(self.bind.workStatusIconStr)
      if reddotManager:haveNew(reddotManager.DotDef.PetNew, guid) then
        reddotManager:clearNew(reddotManager.DotDef.PetNew, guid)
        self:SetTagActive(L_PetConst.TagEnum.ReddotNew, false)
      end
    else
      self:SetTagActive(L_PetConst.TagEnum.Team, false)
      self:refreshPetWorkStatusIcon(self.bind.workStatusIconStr)
    end
    if serverData.wear_skin_id then
      self:SetTagActive(L_PetConst.TagEnum.Skin, serverData.wear_skin_id ~= 0)
    end
  else
    self:refreshCrownIcon(nil, guid)
  end
  self:refreshGradeGroup(params.filterType, displayInfo)
  local laborCount = 0
  if self.bind.active_petLaborList then
    local needLaborType = params.needLaborType
    local csPetData = petStore:getCsPetData(guid)
    if L_CommonUtil.isValid(csPetData) then
      local talentIdList = petStore:getPetTalentIdList(csPetData)
      local laborInfoList = petStore:getPetLaborInfoList(csPetData)
      table.sort(laborInfoList, function(a, b)
        return a.laborGrade > b.laborGrade
      end)
      local data = {}
      for _, laborInfo in pairs(laborInfoList) do
        local laborId = laborInfo.laborId
        local needShow = false
        if needLaborType == nil then
          needShow = true
        elseif type(needLaborType) == "table" then
          for _, needType in ipairs(needLaborType) do
            if needType == laborId then
              needShow = true
              break
            end
          end
        else
          needShow = needLaborType == laborId
        end
        if self.bind.filterType == L_PetConst.filterPetBox.none then
          needShow = false
        end
        if not math.isEmpty(laborId) and needShow then
          local talentId
          for _, id in pairs(talentIdList) do
            local talentTpl = _homeTalentTpl:getTplById(id)
            local talentLaborId = _homeTalentTpl:getLaborTypeIdOfTalent(talentTpl)
            if talentLaborId == laborId then
              talentId = id
              break
            end
          end
          local laborGradeStr = string.format("%d", laborInfo.laborGrade)
          table.insert(data, {
            laborId = laborId,
            talentId = talentId,
            laborGrade = laborGradeStr
          })
        end
      end
      laborCount = #data
      self.bind.list_petLabors:clear()
      self.bind.list_petLabors:insert_array(data)
    end
    self:refreshInfoListPosition(laborCount)
  end
  if not params.ignoreStatus then
    self:refreshPetStatus()
  end
  local reddotManager = L_ReddotManager
  local havePetNewReddot = reddotManager:haveNew(reddotManager.DotDef.PetNew, guid)
  local haveGeneMutationReddot = reddotManager:haveNew(reddotManager.DotDef.PetGeneMutation, guid)
  if self:isInFormation() or self:isInHouse() or self:isInHome() then
    if haveGeneMutationReddot and havePetNewReddot then
      reddotManager:clearNew(reddotManager.DotDef.PetNew, guid)
      havePetNewReddot = false
    end
    self:SetTagActive(L_PetConst.TagEnum.ReddotNew, havePetNewReddot)
  end
  if self:isInHouse() then
    local isInFormation = 0 < L_FormationStore:getPetPlaceInTeam(L_FormationManager:getCurFormationType(), nil, guid)
    self:SetTagActive(L_PetConst.TagEnum.Gene, isInFormation and haveGeneMutationReddot)
    self:refreshPetStarSoulStatus(guid)
    if serverData and serverData.checkCanEvo then
      self:SetTagActive(L_PetConst.TagEnum.Evolution, isInFormation and serverData:checkCanEvo())
    end
  end
end

function this:refreshDropItem(petGuid)
  petGuid = petGuid or self.bind.guid
  if not self.isBind or not petGuid then
    return
  end
  local confId = L_PetStore:getPetItem(petGuid).id
  local petTalentTpl = _petHomeTalentTpl:getTplById(confId)
  if petTalentTpl then
    local dropIds = _petHomeTalentTpl:getFarmProducts(petTalentTpl)
    if not table.isEmpty(dropIds) then
      local tpl_drop = _homeDropTpl:getTplById(dropIds[1])
      local itemType, itemId = _homeDropTpl:getItemType(tpl_drop), _homeDropTpl:getItemId(tpl_drop)
      local configData = L_ItemTplManager:getItemConfig(itemType, itemId[1])
      self.bind.imgDropItem = configData.icon
      self.bind.dropItem = true
    end
  end
end

function this:onRefreshSatiety(petGuids)
  if not self.isBind then
    return
  end
  for i, v in pairs(petGuids) do
    if self.bind.guid == v then
      local currentSatiety = L_SatietyStore:getPetSatiety(v)
      self:refreshSatiety(currentSatiety, v)
      break
    end
  end
end

function this:refreshSatiety(satiety, petGuid)
  if not self.isBind then
    return
  end
  if self.bind.filterType == L_PetConst.filterPetBox.satiety then
    local satietyStatus = L_SatietyStore:getPetSatietyStatus(petGuid)
    local maxSatiety = L_SatietyStore:getPetMaxSatiety(petGuid)
    local str = L_GameUtil.fillColor(satiety, L_PetConst.NewSatietyTextColor[satietyStatus])
    local colorStr = string.format("%s<color=#C1C1C1>/%d</color>", str, maxSatiety)
    self.hungerValue = colorStr
    self.hungerColor = C_LuaUtility.ParseHtmlStringColor(L_PetConst.SatietyStatusIconColor[satietyStatus])
  end
end

function this:setGifPlay(isPlay)
  if not self.isBind then
    return
  end
  isPlay = isPlay or false
  self:SetTagActive(L_PetConst.TagEnum.ReleaseSelect, isPlay and L_PetReleaseManager:getIsReleaseMode())
  local selectionChanged = self.bind.selected ~= isPlay
  local isFrameInitialed = self._pixelIconModule:getIsInitFrameIcon()
  if selectionChanged then
    self.bind.selected = isPlay
    self:refreshPetStatus()
  end
  if isPlay then
    if selectionChanged or not isFrameInitialed then
      self._pixelIconModule:playPixelGif()
    end
  else
    self._pixelIconModule:stopPixelGif()
  end
end

function this:refreshSel(sel)
  self._pixelIconModule:outLineShow(sel)
end

function this:setOutLineShow(isShow)
  if not self.isBind then
    return
  end
  self._pixelIconModule:outLineShow(isShow)
end

function this:getRaycastGo()
  if self.isBind then
    if math.isEmpty(self.bind.guid) then
      return self.bindComponents.img_empty.gameObject
    else
      return self.bindComponents.btn_img_content.gameObject
    end
  end
end

function this:checkRaycastEqualsGo(go)
  if self.isBind then
    if math.isEmpty(self.bind.guid) then
      return self.bindComponents.img_empty.gameObject == go or go.transform:IsChildOf(self.bindComponents.img_empty.transform)
    else
      return self.bindComponents.btn_img_content.gameObject == go
    end
  end
end

function this:setIconAlpha(alpha)
  if not self.isBind then
    return
  end
  self._pixelIconModule:setIconAlpha(alpha)
  self.isDragSelect = alpha < 1 and true or false
end

function this:setEmptySelect(bool)
  self.bind.emptySelect = bool
end

function this:setCatchingPet(isCatching, configId)
  local hasOutline = true
  self.bind.empty = false
  self.bind.content = true
  if configId and configId ~= 0 then
    self._pixelIconModule:setConfigId(configId)
  end
  self._pixelIconModule:setIconBlack2(isCatching)
end

function this:setExchangeSelect(bool)
  self.bind.exchangeSelect = bool
  self.bind.emptySelect = bool
  if bool then
    self._petExchangeWrap = L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_PickUp_Hold")
    self.exchangeAudioTimer = Timer.repeated(1, function(self)
      self._petExchangeWrap = L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_PickUp_Hold")
    end, self)
  else
    L_AudioUtil.stopSound(self._petExchangeWrap)
    if self.exchangeAudioTimer then
      Timer.remove(self.exchangeAudioTimer)
    end
  end
end

function this:setGray(isGray)
  self._pixelIconModule:setGray(isGray)
end

function this:refreshPetStatus()
  self:SetTagActive(L_PetConst.TagEnum.ReleaseStatus, L_PetReleaseManager:getIsReleaseMode())
  if self.bind.petStatusActive then
    self:refreshSubCell()
  else
    self:hidePetStatus()
    self:refreshNoReleaseSunCell()
  end
end

function this:unBind()
  if self.isBind then
    self.bind.content = false
    self.bind.empty = true
  end
end

function this:SetTagActive(tagType, active)
  local tpl = _petPixelTagTpl:getTagTpl(tagType)
  if not tpl then
    return
  end
  active = active == true
  if self.tagActiveMap[tagType] == active then
    return
  end
  self.tagActiveMap[tagType] = active
  self:_refreshTagPos(tpl.tagPos)
end

function this:_refreshTagPos(pos)
  local tagList = _petPixelTagTpl:getTagSortList(pos)
  if not tagList then
    return
  end
  local showTagType
  for _, tagType in ipairs(tagList) do
    if self.tagActiveMap[tagType] == true then
      showTagType = tagType
      break
    end
  end
  for _, tagType in ipairs(tagList) do
    if tagType ~= showTagType then
      self:_ApplyTagVisible(tagType, false)
    end
  end
  if showTagType then
    self:_ApplyTagVisible(showTagType, true)
  end
end

function this:_ApplyTagVisible(tagType, visible)
  visible = visible == true
  if self.tagVisibleMap[tagType] == visible then
    return
  end
  local call = self.tagNodeMap[tagType]
  if call == nil then
    return
  end
  self.tagVisibleMap[tagType] = visible
  call(visible)
end

function this:_resetAllTag()
  for tagType, _ in pairs(_petPixelTagTpl:getTagInfo()) do
    self.tagActiveMap[tagType] = false
    self.tagVisibleMap[tagType] = nil
    self:_ApplyTagVisible(tagType, false)
  end
end

function this:refreshPetStarSoulStatus(petGuid, isSucess)
  self:SetTagActive(L_PetConst.TagEnum.Starsoul, false)
end

function this:RefreshTeamActive()
  local serverData = L_PetStore:getPetItem(self.bind.guid)
  if not serverData then
    self:SetTagActive(L_PetConst.TagEnum.Team, false)
    return
  end
  if not math.isEmpty(serverData.hero_id) and L_HeroStore:getHero(serverData.hero_id) then
    self:SetTagActive(L_PetConst.TagEnum.Team, self:isInFormation() or self:isInHouse())
    local heroStore = L_HeroStore
    local heroData = heroStore:getHero(serverData.hero_id)
    local modName = L_PlayerStore:getPlayerModHeadImgName()
    if heroStore:getHeroGuid(heroData) == heroStore:getDefaultHeroGuid() and not string.isEmpty(modName) then
      if self.isPc then
        L_PhotoManager:fillMainHead(self, self.bindComponents.ImageHead.gameObject, nil, L_Const.avatarTextureIndex.head, function()
          self.bindComponents.ImageHead.gameObject:SetActive(true)
        end)
      else
        L_PhotoManager:fillMainHead(self, self.bindComponents.ImageHeadMobile.gameObject, nil, L_Const.avatarTextureIndex.head, function()
          self.bindComponents.ImageHeadMobile.gameObject:SetActive(true)
        end)
      end
    else
      L_PhotoManager:releaseHead(self)
      local heroConfigId = heroStore:getHeroConfigId(heroData)
      local clothingId = AzurWorld.heroMgr:GetUsingClothingId(heroStore:getHeroGuid(heroData), heroConfigId)
      if self.isPc then
        self.bind.masterIcon = L_GameUtil.getAvatarTexturePath(clothingId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.small)
      else
        self.bind.masterIconMobile = L_GameUtil.getAvatarTexturePath(clothingId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.small)
      end
    end
  else
    self:SetTagActive(L_PetConst.TagEnum.Team, false)
  end
end

function this:setSelectRootActive(isShow)
  self._pixelIconModule:setSelectRootActive(isShow)
end

function this:isInFormation()
  if not self.bind then
    return false
  end
  return self.bind.pageType == L_PetConst.PageType.Formation
end

function this:isInHouse()
  if not self.bind then
    return false
  end
  return self.bind.pageType == L_PetConst.PageType.House
end

function this:isInHome()
  if not self.bind then
    return false
  end
  return self.bind.pageType == L_PetConst.PageType.Home
end

return this
