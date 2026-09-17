local this = class("pagePetEvo", G_UIPageBase)
local petInfoTpl = L_GameTpl:getPetTpl()
local petLearningEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local petGradeTpl = L_GameTpl:getPetGradeTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local wordsTpl = L_GameTpl:getWordsTpl()
local petRankTpl = L_GameTpl:getPetRankTpl()
local petRankVoiceTpl = L_GameTpl:getPetRankVoiceTpl()
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
local _firstSkipPauseTime = 3.8
local _secondSkipTime = 7
local _firstSkipLogicTime = 1.9
local _skipTimeEpsilon = 0.001
local _particleVfxSimulateBufferTime = 5

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    gradeTxtColor = {
      [1] = {
        [1] = "#FFFFFF",
        [2] = "#AFAFAF"
      },
      [2] = {
        [1] = "#FFFFFF",
        [2] = "#AFAFAF"
      },
      [3] = {
        [1] = "#FFFFFF",
        [2] = "#94F0D8"
      },
      [4] = {
        [1] = "#FFFFFF",
        [2] = "#94F0D8"
      },
      [5] = {
        [1] = "#FFFFFF",
        [2] = "#8EB6FF"
      },
      [6] = {
        [1] = "#FFFFFF",
        [2] = "#8EB6FF"
      },
      [7] = {
        [1] = "#FFFFFF",
        [2] = "#C893FF"
      },
      [8] = {
        [1] = "#FFFFFF",
        [2] = "#FFF196",
        [3] = "#FFE08E"
      },
      [9] = {
        [1] = "#FFFFFF",
        [2] = "#FFFAE8",
        [3] = "#FFCBE2",
        [4] = "#FDE8FF",
        [5] = "#EBF5FF"
      }
    },
    frameIncon = {},
    elementColor = {
      [0] = "#b7dbf0",
      [1] = "#FF6364",
      [2] = "#FFAD6B",
      [3] = "#e1b839",
      [4] = "#82db84",
      [5] = "#a0faf8",
      [6] = "#5fc5ff",
      [7] = "#8088ff",
      [8] = "#fff4ac",
      [9] = "#8e65da"
    },
    normalEvo = "UI/Texture/PetEvo/tex_QBJH_jhcg_1v2.png",
    ultraEvo = "UI/Texture/PetEvo/tex_QBJH_ultimate_1v2.png",
    normalEnglishEvo = "UI/Texture/PetEvo/tex_QBJH_jhcg_MORPH_01.png",
    ultraEnglishEvo = "UI/Texture/PetEvo/tex_QBJH_jhcg_BREAKTHROUGH_01.png",
    normalEvoColor = {
      [1] = "#ffffff",
      [2] = "#96f9ff"
    },
    ultraEvoColor = {
      [1] = "#ffffff",
      [2] = "#fbffb8"
    },
    petSpecialSkill = L_GameConstTpl:getData("PET_SIGNATURESKILLLIST", L_Const.GameTplType.int),
    petNormalSkill = L_GameConstTpl:getData("PET_SKILLLIST", L_Const.GameTplType.list_int),
    petBreakSkill = L_GameConstTpl:getData("PET_BREAKSKILLLIST", L_Const.GameTplType.int)
  }
end

function this.bind()
  return {
    show_timelineImage = true,
    show_skilTip = true,
    show_timelineNode = false,
    preName = "",
    evoTxtColor = CS.UnityEngine.Color(1, 1, 1),
    evoName_1 = "",
    evoName_2 = "",
    evoName_3 = "",
    petGradeIcon = "",
    petGradeIconAfter_1 = "",
    petGradeIconAfter_2 = "",
    curGrade_1 = "",
    curGrade_2 = "",
    curGrade_3 = "",
    nextGrade_1 = "",
    nextGrade_2 = "",
    nextGrade_3 = "",
    attrList = {
      moduleName = "pages/Pet/cellTimelineComprehension"
    },
    rideTips = false,
    skillInfo = false,
    skillElementColor = nil,
    skillIcon = "",
    skillName = "",
    skillLv = "",
    skillDesc = "",
    skillGroup = false,
    skillList = {
      moduleName = "pages/Pet/cellPetEvoSkill"
    },
    evoChangeImg_blur = "",
    evoTitleText = ""
  }
end

function this.methods()
  return {
    onClick_skipTimeline = function(self)
      local director = self.bindComponents.playableDirector
      if director == nil then
        return
      end
      if not self.hasSkippedToFirstPause and director.time < _firstSkipPauseTime - _skipTimeEpsilon then
        self.hasSkippedToFirstPause = true
        self.hasResumedAfterFirstPause = false
        self:applySkipLogicBeforeFirstPause()
        self:sampleSkipPrefabTimeline(_firstSkipPauseTime)
        self:setEvolutionPetVisible(true)
        self.bind.show_timelineNode = true
        self:pauseUITimelineAt(_firstSkipPauseTime)
        self:petVfxToEnd()
        return
      end
      if not self.hasResumedAfterFirstPause and director.time >= _firstSkipPauseTime - _skipTimeEpsilon and director.time < _secondSkipTime - _skipTimeEpsilon then
        self:applySkipLogicBeforeSecondStage()
        self:resumeUITimeline()
        self.hasSkippedToFirstPause = true
        self.hasResumedAfterFirstPause = true
        return
      end
      if director.time < _secondSkipTime - _skipTimeEpsilon then
        self:skipUITimelineTo(_secondSkipTime)
        return
      end
      self:closeEvolutionTimeline()
    end,
    onAnimation_event = function(self, type)
      if type ~= "grade" then
        return
      end
      self._animationEventJob = co.start(self.animationEventHandle, self)
    end,
    onClick_Close = function(self)
      self:closeEvolutionTimeline(true)
    end,
    skillList = {
      onClick_Choose = function(self, data, position)
        self:showSkillInfo(data, position)
      end
    }
  }
end

function this:pauseUITimelineAt(targetTime)
  local director = self.bindComponents.playableDirector
  if director == nil then
    return
  end
  director:Play()
  director.time = targetTime
  director:Evaluate()
  director:Pause()
end

function this:skipUITimelineTo(targetTime)
  local director = self.bindComponents.playableDirector
  if director == nil then
    return
  end
  director:Resume()
  director:Play()
  director.time = targetTime
  director:Evaluate()
end

function this:resumeUITimeline()
  local director = self.bindComponents.playableDirector
  if director == nil then
    return
  end
  director.time = director.time + 0.1
  director:Resume()
  director:Play()
end

function this:sampleSkipPrefabTimeline(targetTime)
  if self.timelineControl == nil or self.timelineControl._timelinePrefabHandle == nil then
    return
  end
  local timelineName = self.timelineControl._timelinePrefabHandle._timelineName
  local state = self.timelineControl._timelinePrefabHandle:getTimelineState(timelineName)
  if state and state.director and state.director.time < targetTime - _skipTimeEpsilon then
    state.director.time = targetTime
    state.director:Evaluate()
  end
end

function this:applySkipLogicBeforeFirstPause()
  local director = self.bindComponents.playableDirector
  if director == nil then
    return
  end
  if director.time >= _firstSkipLogicTime or self.firstStepIsClick then
    return
  end
  local allIndex = #self.bind.skillList
  for i = 1, allIndex do
    local skillItem = self.bind.skillList:getItemCls(i)
    if skillItem then
      skillItem:playAnim("Show")
      skillItem:playAnim(self.changeList[i])
    end
  end
  self.firstStepIsClick = true
  local attrCount = #self.bind.attrList
  for i = 1, attrCount do
    local attrItem = self.bind.attrList:getItemCls(i)
    if attrItem and attrItem.setAttrValue then
      attrItem:setAttrValue()
    end
  end
end

function this:applySkipLogicBeforeSecondStage()
  if self.firstPause then
    return
  end
  self.bind.skillInfo = false
  local allIndex = #self.bind.skillList
  for i = 1, allIndex do
    local skillItem = self.bind.skillList:getItemCls(i)
    if skillItem then
      skillItem:playAnim("Hide")
    end
  end
  self.bind.show_skilTip = false
  L_AudioUtil.playSound("Play_SFX_System_UI_Evolve_Rate")
  self.firstPause = true
end

function this:petVfxToEnd()
  if self.timelineControl == nil or self.timelineControl._timelinePrefabHandle == nil then
    return
  end
  local timeLinePrefab = self.timelineControl._timelinePrefabHandle:getTimelinePrefab()
  if not L_CommonUtil.isValid(timeLinePrefab) then
    return
  end
  local prefabTrans = timeLinePrefab.transform
  if prefabTrans == nil then
    return
  end
  local particleSystems = prefabTrans.gameObject:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystem), true)
  if particleSystems == nil then
    return
  end
  for i = 0, particleSystems.Length - 1 do
    local particleSystem = particleSystems[i]
    if L_CommonUtil.isValid(particleSystem) then
      local duration = particleSystem.main.duration + _particleVfxSimulateBufferTime
      particleSystem:Simulate(duration, true, true, true)
      particleSystem:Play(true)
    end
  end
end

function this:animationEventHandle()
  if not self.isBind then
    return
  end
  local endValue = self.nextGrade - math.ceil(self.offset * 0.045)
  co.wait(0.27)
  
  local function getter()
    return self.curGrade
  end
  
  local function setter(v)
    if not self.isBind then
      return
    end
    self.bind.curGrade_1 = L_HeroManager:addComma(math.ceil(v))
    self.bind.curGrade_2 = L_HeroManager:addComma(math.ceil(v))
    self.bind.curGrade_3 = L_HeroManager:addComma(math.ceil(v))
  end
  
  local tween = DOTween.To(getter, setter, endValue, 1.567):SetEase(self.customCurve)
  co.call(tween.OnComplete, tween, co.callback)
  co.wait(0.165)
  if not self.isBind then
    return
  end
  self.bind.curGrade_1 = L_HeroManager:addComma(self.nextGrade - math.ceil(self.offset * 0.014))
  self.bind.curGrade_2 = L_HeroManager:addComma(self.nextGrade - math.ceil(self.offset * 0.014))
  self.bind.curGrade_3 = L_HeroManager:addComma(self.nextGrade - math.ceil(self.offset * 0.014))
  co.wait(0.333)
  if not self.isBind then
    return
  end
  self.bind.curGrade_1 = L_HeroManager:addComma(self.nextGrade)
  self.bind.curGrade_2 = L_HeroManager:addComma(self.nextGrade)
  self.bind.curGrade_3 = L_HeroManager:addComma(self.nextGrade)
end

function this:refreshEvolutionPetState()
  local pet = L_PetStore:getPetItem(self.guid)
  self.data.isSpecial = pet:isSpecialPet()
  self.data.isFlash = pet:hasFlashGene()
  self.data.starColorId = pet.colorMatId
  return pet
end

function this:ensureEvolutionTimelineControl()
  if self.timelineControl == nil then
    self.timelineControl = require("ui.pages.pet.timeline.petTimelineController").new()
  end
  return self.timelineControl
end

function this:getEvolutionTimelineParams(petId)
  local tpl = petRankTpl:getTplById(petId)
  if tpl == nil then
    return
  end
  local evoPerform = petRankTpl:getEvoPerform(tpl)
  if string.isEmpty(evoPerform) then
    return
  end
  local nextPetId = petRankTpl:getNextPetId(tpl)
  local petData = {
    pet1 = petId,
    pet1Rot = petRankTpl:getPet1Rotation(tpl),
    pet1Scale = petRankTpl:getPet1Scale(tpl),
    pet2 = nextPetId,
    pet2Rot = petRankTpl:getPet2Rotation(tpl),
    pet2Scale = petRankTpl:getPet2Scale(tpl),
    isSpecial = self.data.isSpecial,
    isFlash = self.data.isFlash,
    starColorId = self.data.starColorId
  }
  return tpl, evoPerform, nextPetId, petRankTpl:getLoopFrame(tpl), petData
end

function this:preloadEvolutionTimeline(petId)
  local _, evoPerform, _, _, petData = self:getEvolutionTimelineParams(petId)
  if petData == nil or string.isEmpty(evoPerform) then
    return
  end
  self:ensureEvolutionTimelineControl():preloadTimelineState(evoPerform, petData)
end

function this:setEvolutionPetVisible(isVisible)
  if self.timelineControl then
    self.timelineControl:setPetVisible(isVisible)
  end
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.firstPause = false
  self.firstStepIsClick = false
  self.hasSkippedToFirstPause = false
  self.hasResumedAfterFirstPause = false
  self.petId = options.prePetData.id
  self.prePetData = options.prePetData
  self.guid = options.guid
  self.oldSkillInfo = options.oldSkillInfo
  C_UISceneManager.SetSceneActiveForTimeline(false)
  self:refreshEvolutionPetState()
  self:preloadEvolutionTimeline(self.petId)
  self:initPage()
  C_UISceneManager.SetSceneVisible()
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.PetEvolution)
  self:playEvolutionTimeline(self.petId)
end

function this:open()
end

function this:show()
  AzurWorld.visbleMgr:SetWeatherActive(true, CS.Lens.Gameplay.Modules.BigWorld.VisibleConst.EWeatherHideReason.UIHide)
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.PetEvolution)
end

function this:initPage()
  local guid = self.guid
  local pet = self:refreshEvolutionPetState()
  self.skillInfos = L_PetStore:getPetSkills(pet, false, false, true)
  self.customCurve = self.bindComponents.customCurve.curves[0] or Tweening.Ease.OutCirc
  local tpl = petRankTpl:getTplById(self.petId)
  local petTpl = petInfoTpl:getTplById(self.petId)
  local preName = petInfoTpl:getName(petTpl, pet:isSpecialPet())
  local next_id = petRankTpl:getNextPetId(tpl)
  local nextPetTpl = petInfoTpl:getTplById(next_id)
  local nextPetName = petInfoTpl:getName(nextPetTpl, pet:isSpecialPet())
  local stage = petInfoTpl:getPetStage(nextPetTpl)
  local canRide = petInfoTpl:getIsMount(nextPetTpl)
  local _, normalTopColor1 = C_ColorUtility.TryParseHtmlString(self.data.normalEvoColor[1])
  local _, normalBottomColor1 = C_ColorUtility.TryParseHtmlString(self.data.normalEvoColor[2])
  local _, ultraTopColor2 = C_ColorUtility.TryParseHtmlString(self.data.ultraEvoColor[1])
  local _, normalBottomColor2 = C_ColorUtility.TryParseHtmlString(self.data.ultraEvoColor[2])
  self.bindComponents.evoChangeTextColor:SetColorGradient(ultraTopColor2, ultraTopColor2, normalBottomColor2, normalBottomColor2)
  self.bind.evoTitleText = L_GameTpl:getWordsTpl():getValue("notice_pet_evolution_form_changing")
  self.bind.evoChangeImg_blur = self.data.normalEnglishEvo
  self.bind.rideTips = canRide
  self.bind.preName = preName
  self.bind.evoName_1 = nextPetName
  self.bind.evoName_2 = nextPetName
  self.bind.evoName_3 = nextPetName
  local _, color = C_ColorUtility.TryParseHtmlString(petRankTpl:getEvolutionColor(tpl))
  self.bind.evoTxtColor = color
  self.groupColor = {
    [1] = C_Color.white,
    [2] = color
  }
  local topRankComprehension = L_PetStore:getRangeValueComprehension(false, 8, pet.comprehension)
  local signalListener = self.bindComponents.skillGroup:GetComponent(typeof(C_TimelineSignalListener))
  if signalListener then
    signalListener:SetHandler(handler(self, self.timelineSignalListener))
  end
  local property = L_PetStore:getPetOriginalProperty(self.prePetData, pet.lv, self.petId)
  local nextProperty = L_PetStore:getPetOriginalProperty(pet, pet.lv, next_id)
  local grade = self.prePetData.grade
  local prePetCfg = petInfoTpl:getTplById(self.prePetData.id)
  local prePetRank = prePetCfg and petInfoTpl:getPetStage(prePetCfg) or 1
  local prePetRare = prePetCfg and prePetCfg.petrare or 0
  local gradeRank = L_PetStore:calGradeRank(grade, prePetRank, prePetRare)
  local gradeTpl = petGradeTpl:getTplById(gradeRank)
  local curGrade = L_HeroManager:addComma(grade)
  local lev = petGradeTpl:getLevel(gradeTpl)
  self.bind.curGrade_1 = curGrade
  self.bind.curGrade_2 = curGrade
  self.bind.curGrade_3 = curGrade
  self.bind.petGradeIcon = petGradeTpl:getIcon(gradeTpl)
  local nextGradeTpl = petGradeTpl:getTplById(nextProperty.gradeRank)
  local nextGrade = L_HeroManager:addComma(nextProperty.grade)
  self.nextGrade = nextProperty.grade
  self.curGrade = grade
  self.offset = self.nextGrade - self.curGrade
  local curGradeGradient = self:parseColor(self.data.gradeTxtColor[nextProperty.gradeRank])
  local nextGradeGradient = self:parseColor(self.data.gradeTxtColor[nextProperty.gradeRank])
  for i = 1, 3 do
    self.bindComponents["txtColor_" .. i].LinearGradient = curGradeGradient
    self.bindComponents["txtColorAfter_" .. i].LinearGradient = nextGradeGradient
  end
  self.bind.petGradeIconAfter_1 = petGradeTpl:getIcon(nextGradeTpl)
  self.bind.petGradeIconAfter_2 = petGradeTpl:getIcon(nextGradeTpl)
  self.bind.nextGrade_1 = nextGrade
  self.bind.nextGrade_2 = nextGrade
  self.bind.nextGrade_3 = nextGrade
  self.bind.attrList:clear()
  local propertyData = {}
  local all_Attribute = petLearningEnumTpl:getAllEnum()
  for i, v in ipairs(all_Attribute) do
    local tpl = petLearningEnumTpl:getTplById(i)
    local enumId = petLearningEnumTpl:getEnumNum(tpl)
    local id = 0
    for n, k in pairs(topRankComprehension) do
      if k.attr_id == enumId then
        id = k.rankId
        break
      end
    end
    local offset = L_PetStore:getPetAttFinalValue(nextProperty, enumId) - L_PetStore:getPetAttFinalValue(property, enumId)
    local battleTpl = battleInfoTpl:getTplById(enumId)
    local isRatio = battleInfoTpl:getIsRatio(battleTpl)
    if isRatio == 1 then
      offset = math.ceil(offset / 100)
    end
    table.insert(propertyData, {
      value = offset,
      isRatio = isRatio,
      attr_icon = petLearningEnumTpl:getNewIcon(tpl),
      attr_shiningIcon = "",
      name = petLearningEnumTpl:getName(tpl),
      attrId = id,
      curve = self.bindComponents.customCurve.curves[1] or Tweening.Ease.InOutCirc,
      index = i,
      order = petLearningEnumTpl:getOrder(tpl)
    })
  end
  table.sort(propertyData, function(a, b)
    return a.order < b.order
  end)
  self.bind.attrList:insert_array(propertyData)
  self.changeList = {}
  if table.isEmpty(self.skillInfos) then
    for i = 1, 4 do
      table.insert(self.changeList, "")
    end
    self.bind.skillGroup = false
  else
    if #self.skillInfos < #self.oldSkillInfo then
      for i = 1, 4 do
        table.insert(self.changeList, "")
      end
      self.bind.skillGroup = false
      return
    end
    self.bind.skillGroup = true
    self:handleSkillChange()
    local specialSkill
    local normalSkill = {}
    local breakSkill, newBreakSkill
    for _, v in ipairs(self.oldSkillInfo) do
      if v.skillSlot == self.data.petSpecialSkill then
        specialSkill = v
      elseif v.skillSlot >= self.data.petNormalSkill[1] and v.skillSlot <= self.data.petNormalSkill[2] then
        table.insert(normalSkill, v)
      elseif v.skillSlot == self.data.petBreakSkill then
        breakSkill = v
      end
      printf("进化前技能slot:" .. v.skillSlot .. " 技能ID:" .. v.skillId)
    end
    for _, v in ipairs(self.skillInfos) do
      if v.skillSlot == self.data.petBreakSkill then
        newBreakSkill = v
      end
      printf("进化后技能slot:" .. v.skillSlot .. " 技能ID:" .. v.skillId)
    end
    local specialPool = petInfoTpl:getSignatureSkillList(petTpl)
    local newSpecialPool = petInfoTpl:getSignatureSkillList(nextPetTpl)
    local oldIndex = 0
    local haveSame = false
    local sameIndex
    if specialSkill ~= nil then
      for i, v in pairs(specialPool) do
        if v[2] == specialSkill.skillId then
          oldIndex = v[1]
        end
      end
      for _, n in ipairs(newSpecialPool) do
        if n[2] == specialSkill.skillId then
          haveSame = true
          sameIndex = n[1]
          break
        end
      end
    end
    local isChange = true
    for i, v in pairs(newSpecialPool) do
      if v[1] == oldIndex then
        isChange = false
        break
      end
    end
    if isChange then
      table.insert(self.changeList, "Change")
    elseif haveSame and sameIndex == oldIndex then
      table.insert(self.changeList, "")
    else
      table.insert(self.changeList, "Up")
    end
    local skillPool = petInfoTpl:getCommonSkillList(petTpl)
    local newSkillPool = petInfoTpl:getCommonSkillList(nextPetTpl)
    for i, v in ipairs(newSkillPool) do
      local index
      local haveSameId = false
      local sameIdIndex
      local change = true
      for _, n in ipairs(normalSkill) do
        if n.skillId == v[2] then
          haveSameId = true
          sameIdIndex = n.index
          break
        end
      end
      for _, n in ipairs(skillPool) do
        if n[2] == v.skillId then
          index = n[1]
          break
        end
      end
      for _, n in pairs(normalSkill) do
        if n.index == index then
          change = false
          break
        end
      end
      if change then
        table.insert(self.changeList, "Change")
      elseif haveSameId and sameIdIndex == index then
        table.insert(self.changeList, "")
      else
        table.insert(self.changeList, "Up")
      end
    end
    if breakSkill == nil then
      table.insert(self.changeList, "Change")
    elseif breakSkill.skillId == newBreakSkill.skillId then
      table.insert(self.changeList, "")
    else
      table.insert(self.changeList, "Up")
    end
  end
end

function this:escHandle()
  if self.bindComponents.playableDirector.time >= 8 then
    self:closeEvolutionTimeline()
  end
end

function this:close(options)
  this.super.close(self, options)
  if self.timelineControl then
    self.timelineControl:dispose()
    self.timelineControl = nil
  end
  local skillInfoQueue = L_PetStore:getPetSkillInfoQueue()
  local length = skillInfoQueue:getLength()
  for i = 1, length do
    local data = skillInfoQueue:deQueue()
    L_UI:open("pagePetSkillNewInfo", data)
  end
  L_PetStore:setIsPlayingTimeLine(false)
  if self._timelineSignalJob then
    co.stop(self._timelineSignalJob)
    self._timelineSignalJob = nil
  end
  if self._animationEventJob then
    co.stop(self._animationEventJob)
    self._animationEventJob = nil
  end
  C_UISceneManager.SetSceneActiveForTimeline(true)
  C_UISceneManager.SetSceneVisible()
  L_PetStore:call(L_PetStore.event.setCurPetId, self.guid, true)
end

function this:closeEvolutionTimeline(isForce)
  if self.timelineControl == nil then
    return
  end
  if not isForce and not self.timelineControl:getIsLoop() then
    return
  end
  L_AudioUtil.playSound("Play_SFX_System_QiboEvolution_End")
  L_UI:close("pagePetEvo")
end

function this:playEvolutionTimeline(petId)
  local tpl, evoPerform, nextPetId, loopFrame, petData = self:getEvolutionTimelineParams(petId)
  if tpl == nil or nextPetId == nil or petData == nil or string.isEmpty(evoPerform) then
    return
  end
  local timelineControl = self:ensureEvolutionTimelineControl()
  
  function timelineControl.loadErrorFunc()
    self:closeEvolutionTimeline(true)
  end
  
  timelineControl.startPlayFunc = nil
  timelineControl.clipAudioEvents = nil
  
  function timelineControl.startPlayFunc()
    C_UIMgr.CloseCutin()
    self.bind.show_timelineImage = true
    self:setEvolutionPetVisible(true)
    if self.hasSkippedToFirstPause then
      self.bind.show_timelineNode = true
      self:pauseUITimelineAt(_firstSkipPauseTime)
      timelineControl:playPetShowExpression()
      return
    end
    local delta = co.wait(2.3)
    if self.hasSkippedToFirstPause then
      return
    end
    L_PetStore:playPetVoiceSound(petId, L_PetConst.PetSystemVoiceType.Evolve)
    delta = co.wait(0.5)
    if self.hasSkippedToFirstPause then
      return
    end
    self.bindComponents.playableDirector:Play()
    timelineControl:playPetShowExpression()
    self.bind.show_timelineNode = true
    delta = co.wait(0.2 - delta)
    if self.hasSkippedToFirstPause then
      return
    end
    local stage = petInfoTpl:getPetStage(petInfoTpl:getTplById(nextPetId))
    L_AudioUtil.playSound("Play_SFX_System_UI_Evolve_Transform")
    co.wait(0.3 - delta)
    if self.hasSkippedToFirstPause then
      return
    end
    L_PetStore:playPetVoiceSound(nextPetId, L_PetConst.PetSystemVoiceType.Evolve)
  end
  
  local tpls = petRankVoiceTpl:getTplsByTimeline(evoPerform)
  if tpls then
    local audioEvents = {}
    for stage, v in pairs(tpls) do
      if type(stage) == "string" then
        audioEvents[stage] = {
          audioEvent = petRankVoiceTpl:getAudioEvent(v),
          bgmEvent = petRankVoiceTpl:getBgmEvent(v)
        }
      end
    end
    timelineControl.clipAudioEvents = audioEvents
  end
  self.bind.show_timelineImage = true
  timelineControl:playTimelineState(evoPerform, petData, loopFrame)
end

function this:updateTimelineTip()
  local showTip = false
  if self.timelineControl and self.timelineControl:getIsLoop() then
    showTip = true
  end
  self.bind.show_skilTip = showTip
end

function this:parseColor(colorList)
  if #colorList == 0 or #colorList == 1 then
    return
  end
  local gradient
  local list = {}
  for i, v in ipairs(colorList) do
    local _, color = C_ColorUtility.TryParseHtmlString(v)
    table.insert(list, color)
  end
  if #colorList == 2 then
    gradient = C_CustomColorUtility.GenerateGradientLinear(list[1], 1, 0, list[2], 1, 1)
  elseif #colorList == 3 then
    gradient = C_CustomColorUtility.GenerateGradientLinear(list[1], 1, 0, list[2], 1, 0.5, list[3], 1, 1)
  elseif #colorList == 4 then
    gradient = C_CustomColorUtility.GenerateGradientLinear(list[1], 1, 0, list[2], 1, 0.33, list[3], 1, 0.66, list[4], 1, 1)
  elseif #colorList == 5 then
    gradient = C_CustomColorUtility.GenerateGradientLinear(list[1], 1, 0, list[2], 1, 0.25, list[3], 1, 0.5, list[4], 1, 0.75, list[5], 1, 1)
  end
  return gradient
end

function this:showSkillInfo(data, position)
  if self.firstPause == true then
    return
  end
  if self.bind.skillInfo == true and self.skillInfoPos == position then
    self.skillInfoPos = 0
    self.bind.skillInfo = false
    return
  end
  self.skillInfoPos = position
  if self.bind.skillInfo == false then
    self.bind.skillInfo = true
  end
  local info = data.skillInfo
  local _, skillcolor = C_ColorUtility.TryParseHtmlString(self.data.elementColor[info.skillElement[1]] or "#b7dbf0")
  self.bind.skillElementColor = skillcolor
  self.bind.skillIcon = info.itemIcon
  self.bind.skillName = info.skillName
  local lv = string.sub(info.skillLv, 4)
  self.bind.skillLv = lv
  self.bind.skillDesc = info.describe
  local skillPointPos = position
  local screenPos = C_CameraManager.uiCamera:WorldToScreenPoint(skillPointPos)
  local v2 = C_Vector2(screenPos.x, screenPos.y)
  local rect = self.bindComponents.skillInfoTrans
  local parent = rect.parent
  local _, uiPos = _screenPosToUI(parent, v2, C_CameraManager.uiCamera)
  uiPos.y = uiPos.y + 240
  L_Vector3.setAnchored(rect, uiPos)
  L_GameUtil.forceRebuildLayout(self.bindComponents.descBoard)
end

function this:timelineSignalListener(signalMsg)
  local allIndex = #self.bind.skillList
  self._timelineSignalJob = co.start(function()
    for i = 1, allIndex do
      if signalMsg == "Show" or signalMsg == "Hide" then
        co.wait((i - 1) * 0.033, co.phase.unscaled)
        self.bind.skillList:getItemCls(i):playAnim(signalMsg)
      elseif signalMsg == "Change" then
        co.wait((i - 1) * 0.066, co.phase.unscaled)
        self.bind.skillList:getItemCls(i):playAnim(self.changeList[i])
      end
    end
  end)
end

function this:handleSkillChange()
  local skillData = {}
  self.bind.skillList:clear()
  if table.isEmpty(self.oldSkillInfo) then
    for i, v in ipairs(self.skillInfos) do
      local _, color = C_ColorUtility.TryParseHtmlString(self.data.elementColor[v.skillElement[1]] or "#b7dbf0")
      table.insert(skillData, {
        skillBeforeIcon = v.itemIcon,
        skillBeforeColor = color,
        skillAfterIcon = v.itemIcon,
        skillAfterColor = color,
        skillInfo = v
      })
    end
  else
    for i, v in ipairs(self.oldSkillInfo) do
      local _, color = C_ColorUtility.TryParseHtmlString(self.data.elementColor[v.skillElement[1]] or "#b7dbf0")
      skillData[i] = {
        skillBeforeIcon = v.itemIcon,
        skillBeforeColor = color,
        skillInfo = v,
        skillAfterIcon = v.itemIcon,
        skillAfterColor = color
      }
    end
    for i, v in ipairs(self.skillInfos) do
      local _, color = C_ColorUtility.TryParseHtmlString(self.data.elementColor[v.skillElement[1]] or "#b7dbf0")
      if skillData[i] then
        skillData[i].skillAfterIcon = v.itemIcon
        skillData[i].skillAfterColor = color
        skillData[i].skillInfo = v
      else
        skillData[i] = {
          skillBeforeIcon = v.itemIcon,
          skillBeforeColor = color,
          skillInfo = v,
          skillAfterIcon = v.itemIcon,
          skillAfterColor = color
        }
      end
    end
  end
  self.bind.skillList:insert_array(skillData)
end

return this
