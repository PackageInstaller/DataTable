local page = class("pageGetPet", G_UIPageBase)
local petTpl = L_GameTpl:getPetTpl()
local petLearningEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local wordsTpl = L_GameTpl:getWordsTpl()
local _petHomeSizeTpl = L_GameTpl:getPetHomeSizeTpl()
local _petHomeTalentTpl = L_GameTpl:getPetHomeTalentTpl()
local gameConstTpl = L_GameTpl:getGameConstTpl()
local modulePetGeneSkillsTips_Path = "UI/Pages/PetBox/modulePetBoxGeneTip.prefab"
local modulePetGeneSkillsTips = "ui.pages.pet.new.modulePetBoxGeneTip"
local PATH_BG_ELEMENT = "UI/Texture/PetGet/tex_petduel_mask_element_%s.png"
local gradeRank = {
  [1] = 1,
  [2] = 1,
  [3] = 2,
  [4] = 2,
  [5] = 3,
  [6] = 3,
  [7] = 4,
  [8] = 5,
  [9] = 6
}
local GETPETRANKGRADE = {
  [6] = {
    Path = "UI/Pages/PetBox/PetBoxRating/pre_Rating_A.prefab",
    module = "ui.pages.pet.new.cellPetBoxRating"
  },
  [5] = {
    Path = "UI/Pages/PetBox/PetBoxRating/pre_Rating_B.prefab",
    module = "ui.pages.pet.new.cellPetBoxRating"
  },
  [4] = {
    Path = "UI/Pages/PetBox/PetBoxRating/pre_Rating_C.prefab",
    module = "ui.pages.pet.new.cellPetBoxRating"
  },
  [3] = {
    Path = "UI/Pages/PetBox/PetBoxRating/pre_Rating_D.prefab",
    module = "ui.pages.pet.new.cellPetBoxRating"
  },
  [2] = {
    Path = "UI/Pages/PetBox/PetBoxRating/pre_Rating_E.prefab",
    module = "ui.pages.pet.new.cellPetBoxRating"
  },
  [1] = {
    Path = "UI/Pages/PetBox/PetBoxRating/pre_Rating_F.prefab",
    module = "ui.pages.pet.new.cellPetBoxRating"
  },
  [7] = {
    Path = "UI/Pages/PetBox/PetBoxRating/pre_Rating_S.prefab",
    module = "ui.pages.pet.new.cellPetBoxRating"
  },
  [8] = {
    Path = "UI/Pages/PetBox/PetBoxRating/pre_Rating_SS.prefab",
    module = "ui.pages.pet.new.cellPetBoxRating"
  },
  [9] = {
    Path = "UI/Pages/PetBox/PetBoxRating/pre_Rating_SSS.prefab",
    module = "ui.pages.pet.new.cellPetBoxRating"
  }
}
local DNA_SFX = {
  [1] = "Play_SFX_System_UI_QiboGet_DNA_Gray",
  [2] = "Play_SFX_System_UI_QiboGet_DNA_Gray",
  [3] = "Play_SFX_System_UI_QiboGet_DNA_Blue",
  [4] = "Play_SFX_System_UI_QiboGet_DNA_S",
  [5] = "Play_SFX_System_UI_QiboGet_DNA_SS",
  [6] = "Play_SFX_System_UI_QiboGet_DNA_SSS"
}
local RATING_SFX = {
  [1] = "Play_SFX_System_UI_QiboGet_Rating_Gray",
  [2] = "Play_SFX_System_UI_QiboGet_Rating_Gray",
  [3] = "Play_SFX_System_UI_QiboGet_Rating_Green",
  [4] = "Play_SFX_System_UI_QiboGet_Rating_Green",
  [5] = "Play_SFX_System_UI_QiboGet_Rating_Blue",
  [6] = "Play_SFX_System_UI_QiboGet_Rating_Blue",
  [7] = "Play_SFX_System_UI_QiboGet_Rating_S",
  [8] = "Play_SFX_System_UI_QiboGet_Rating_SS",
  [9] = "Play_SFX_System_UI_QiboGet_Rating_SSS"
}
local showTypeBeginTime = {
  [L_Const.getPetShowType.short] = 0,
  [L_Const.getPetShowType.long] = 10,
  [L_Const.getPetShowType.middle] = 20
}
local hasHideBeginTime = {
  [L_Const.getPetShowType.short] = 7.2,
  [L_Const.getPetShowType.long] = 17.2,
  [L_Const.getPetShowType.middle] = 27.2
}

function page:ctor(...)
  page.super.ctor(self, ...)
  self.data = {info = nil}
end

function page.bind()
  return {
    pet_name = "",
    pet_lv = "",
    pet_maxLv = "",
    show_new = false,
    go_time = false,
    txt_time = "",
    img_elementBottomBg = "",
    color_artTextimg = C_Color.white,
    modulePetNewSimpleTags = {
      moduleName = "pages/pet/new/modulePetNewSimpleTags"
    },
    petPropertyList = {
      moduleName = "pages/pet/cellAttrItem"
    },
    petGetGeneList = {
      moduleName = "pages/pet/new/cellPetGetGene"
    },
    list_petHomeLaborTag = {
      moduleName = "pages/Pet/cellTagPetHomeLabor"
    },
    rank_1 = false,
    rank_2 = false,
    rank_3 = false,
    rank_4 = false,
    rank_5 = false,
    rank_6 = false,
    timelineMask = false,
    offset_btns = true
  }
end

function page.methods()
  return {
    onClick_close = function(self)
      if self.initTime and self.initTime <= 0 then
        L_UI:close(self.pageName)
      end
    end,
    onClick_openSelectItemList = function(self)
      if not C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.petBox) then
        return
      end
      local pet = self.data.info
      if pet then
        self:moduleBoxItemList()
        L_UI:open("pagePetBoxSelect", {
          initBoxIndex = self.curBoxIndex,
          callback = function(boxIndex)
            self.curBoxIndex = boxIndex
            self:reqSetPetBox()
          end
        })
      end
    end,
    onClick_freePet = function(self)
      if not C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.petRelease) then
        return
      end
      local pet = self.data.info
      if pet then
        L_UI:open("pagePetReleaseConfirm", {
          pets = table.clone({
            pet.guid
          }),
          confirmCallback = function()
            L_UI:close(self.pageName)
          end,
          quickRelease = true
        })
      end
    end,
    onClick_detail = function(self)
      local petGuid = self.data.info.guid
      L_UI:open("pagePet", {petId = petGuid})
    end,
    onClick_geneDetailDown = function(self)
      self.pageTipBuddleOpen = L_UI:checkPageOpen("pageTipBubble")
    end,
    onClick_geneDetailUp = function(self)
      if table.isEmpty(self.geneData) then
        return
      end
      if not self.pageTipBuddleOpen then
        local factor = #self.geneData % 2 == 1
        local deltaY = -100
        L_UI:open("pageTipBubble", {
          data = {
            modulePetGeneSkillsTips_Path,
            modulePetGeneSkillsTips,
            self.data.info,
            self.bindComponents.listRect,
            0,
            true,
            1,
            C_Vector2(10, 10),
            C_Vector2(-85.6, -25.7),
            C_Vector3(0, deltaY, 0)
          }
        })
      else
        L_UI:close("pageTipBubble")
      end
    end
  }
end

function page:preOpen(options)
  L_ProfilerUtil.BeginSample("pageGetPet:preOpen")
  page.super.preOpen(self, options)
  local signalListener = self.bindComponents.pageRoot:GetComponent(typeof(C_TimelineSignalListener))
  if signalListener then
    signalListener:SetHandler(handler(self, self.timelineSignalListener))
  end
  L_PetManager:loadPetGetScene()
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.PetGet)
  self:refreshPetInfo(options)
  self.bindComponents.playableDirector:Play()
  self._timelinePlayedInPreOpen = true
  L_UI:close("pageExclusive")
  AzurWorld.HUDMgr:SetAllVisible(false)
  local conditions = gameConstTpl:getData("KIBO_GET_INTRO_CONDITION", L_Const.GameTplType.condition)
  local unlockTaskCompleted = true
  for _, condition in ipairs(conditions) do
    if not L_ConditionManager:singleIsComplete(condition) then
      unlockTaskCompleted = false
      break
    end
  end
  self.bind.offset_btns = AzurWorld.proxyCenter.curProxy.proxyType ~= C_EWorldType.NestCoop and unlockTaskCompleted
  L_ProfilerUtil.EndSample()
end

function page:open()
  self.pageTipBuddleOpen = false
  self.bind.timelineMask = true
  local conditions = gameConstTpl:getData("KIBO_GET_INTRO_CONDITION", L_Const.GameTplType.condition)
  local unlockTaskCompleted = true
  for _, condition in ipairs(conditions) do
    if not L_ConditionManager:singleIsComplete(condition) then
      unlockTaskCompleted = false
      break
    end
  end
  if AzurWorld.proxyCenter.curProxy.proxyType == C_EWorldType.NestCoop or not unlockTaskCompleted then
    if L_DeviceTpl:getIsMobile() then
      self.bindComponents.rect_tips.anchoredPosition = C_Vector2(-2.06, -541.65)
    end
    if L_DeviceTpl:getIsPc() then
      self.bindComponents.rect_tips.anchoredPosition = C_Vector2(-2.06, -564.8)
    end
  end
end

function page:show(options)
  L_ProfilerUtil.BeginSample("pageGetPet:show")
  if self.data.info.id ~= options.pet.id then
    if options.texture then
      C_RenderTexture.ReleaseTemporary(options.texture)
    end
    self:refreshPetInfo(options)
  end
  local timelinePlayedInPreOpen = self._timelinePlayedInPreOpen
  self._timelinePlayedInPreOpen = false
  if not timelinePlayedInPreOpen then
    self.bindComponents.playableDirector:Play()
  end
  L_PetManager:setPetGetActive(true)
  if self.hasHide then
    local playableDirector = self.bindComponents.playableDirector
    local beginTime = hasHideBeginTime[self.showType]
    playableDirector.time = beginTime
    L_PetManager:setPlayableDirectorTime(beginTime)
    if self.data.info and self.data.info:hasFlashGene() then
      L_TimerManager:newOrResetTimer(self, "replayFlashSoundOnReturn", function()
        L_PetManager:stopFlashSound()
        L_PetManager:playFlashSound()
      end, 0.15)
    end
    self.hasHide = false
  end
  self:timelineSignalListener("PlayAnim")
  L_ProfilerUtil.EndSample()
  self:checkNestCoopCall(options.ignoreNestCall)
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.PetGet)
  if L_DeviceTpl:getIsPc() then
    self:setShortcutGuidePCActive(true)
  end
end

function page:checkNestCoopCall(ignoreNestCall)
  if AzurWorld.PetCatchManagerMgr:IsNestCoopPetCatch() then
    if ignoreNestCall == nil then
      AzurWorld.PetCatchManagerMgr:ExecutePetCatchResultCallBack()
    end
    L_MailStore:delayCheckKiboMailTip()
  end
end

function page:refreshPetInfo(options)
  self._closeCallback = options.closeCallback
  if self._closeCallback == nil then
    self._closeCallback = options.callback
  end
  self.voiceCallBack = options.voiceCallBack
  self.showType = options.showType and options.showType or L_Const.getPetShowType.short
  self.data.bFromHatch = options.bFromPetHatch
  self.data.bldUid = options.bldUid
  self.data.info = options.pet
  local isNew = false
  if self.data.info.guid ~= 0 then
    isNew = L_AzurMediator.isFirstGetPet(self.data.info.guid)
  end
  self.bind.show_new = isNew
  L_PetManager:loadPetGetModel(self.data.info.id, self.data.info:isSpecialPet(), self.data.info:hasFlashGene(), self.data.info.colorMatId)
  L_PetManager:setPetBlackRootColor(C_Color(0, 0, 0, 1))
  self:setPetModelBloomEffect(false)
  local playableDirector = self.bindComponents.playableDirector
  local beginTime = showTypeBeginTime[self.showType]
  playableDirector.time = beginTime
  L_PetManager:setPlayableDirectorTime(beginTime)
  if options.texture then
    self.bindComponents.textureBg.texture = options.texture
  end
  self:initPage()
  if self.voiceCallBack then
    self.voiceCallBack()
  end
  L_PetManager.curGetPetGuid = self.data.info.guid
end

function page:setPetModelBloomEffect(enable)
  if not L_DeviceTpl:getIsMobile() then
    return
  end
  if not L_PetManager.runtimePetGetData or not L_CommonUtil.isValid(L_PetManager.runtimePetGetData.petScene) then
    return
  end
  local petScene = L_PetManager.runtimePetGetData.petScene
  
  local function findChildByName(rootTrans, targetName)
    if not rootTrans or string.isEmpty(targetName) then
      return nil
    end
    if rootTrans.name == targetName then
      return rootTrans
    end
    local childCount = rootTrans.childCount or 0
    for i = 0, childCount - 1 do
      local child = rootTrans:GetChild(i)
      local found = findChildByName(child, targetName)
      if found then
        return found
      end
    end
    return nil
  end
  
  local volumeRoot = findChildByName(petScene.transform, "VolumeAfterOpaque")
  if not L_CommonUtil.isValid(volumeRoot) then
    return
  end
  local VolumeCtr = CS.UnityEngine.Rendering.Azur.Volume
  local volume = volumeRoot:GetComponent(typeof(VolumeCtr))
  if not L_CommonUtil.isValid(volume) then
    return
  end
  if not L_CommonUtil.isValid(volume.Profile) then
    return
  end
  local UberType = CS.UnityEngine.Rendering.Azur.Uber
  local TryGetMethod = xlua.get_generic_method(volume.Profile:GetType(), "TryGet")
  local TryGetUber = TryGetMethod(UberType)
  local hasUber, uber = TryGetUber(volume.Profile)
  if hasUber and L_CommonUtil.isValid(uber) then
    if self._originalBloomEnable == nil then
      self._originalBloomEnable = uber.bloomEnable.value
    end
    uber.bloomEnable.value = enable
  end
end

function page:hide()
  L_TimerManager:stopTimer(self, "delayBlack")
  if L_CommonUtil.isValid(self._doTween) then
    self._doTween:Kill()
    self._doTween = nil
  end
  L_PetManager:setPetBlackRootColor(C_Color(0, 0, 0, 0))
  L_PetManager:setPetGetActive(false)
  self.hasHide = true
  self.bind.timelineMask = false
end

function page:getPetBlackRootAlpha()
  if not L_PetManager.runtimePetGetData or not L_CommonUtil.isValid(L_PetManager.runtimePetGetData.blackObj) then
    return 0
  end
  local blackObj = L_PetManager.runtimePetGetData.blackObj
  local effectMaterialHelper = blackObj.transform:GetComponent(typeof(CS.EffectMaterialHelper))
  if not L_CommonUtil.isValid(effectMaterialHelper) or not L_CommonUtil.isValid(effectMaterialHelper.material) then
    return 0
  end
  return effectMaterialHelper.insMaterial:GetColor("_IB_Color").a
end

function page:alphaTween()
  if L_CommonUtil.isValid(self._doTween) then
    self._doTween:Kill()
    self._doTween = nil
  end
  local beginAlpha = self:getPetBlackRootAlpha()
  if beginAlpha <= 0 then
    L_PetManager:setPetBlackRootColor(C_Color(0, 0, 0, 0))
    return
  end
  local target = 0
  
  local function getter1()
    return beginAlpha
  end
  
  local function setter1(r)
    L_PetManager:setPetBlackRootColor(C_Color(0, 0, 0, r))
  end
  
  self._doTween = DOTween.To(getter1, setter1, target, 0.1):OnComplete(function()
    self._doTween = nil
    L_PetManager:setPetBlackRootColor(C_Color(0, 0, 0, 0))
  end)
end

function page:initPage()
  self:moduleBoxItemList()
  self.bind.pet_name = self.data.info.pet_name
  self.bind.pet_lv = tostring(self.data.info.lv)
  self.bind.pet_maxLv = string.format("/%d", L_PetStore:getPetMaxLevel(true))
  self:SetPetRatingGrade(self.data.info.guid)
  local params = {
    pointTo = 2,
    borderDistance = C_Vector2(30, 27),
    offset = C_Vector3(375, 0, 0)
  }
  self.modules.modulePetNewSimpleTags:setGuid(self.data.info.guid, false, true, false, params)
  local topRankComprehension = L_PetStore:getRangeValueComprehension(false, 8, self.data.info.comprehension)
  local property = L_PetStore:getPetOriginalProperty(self.data.info)
  local gradeIndex = gradeRank[property.gradeRank]
  local gradeRankName = string.format("rank_%d", gradeIndex)
  local tpl = petTpl:getTplById(self.data.info.id)
  self.bindComponents.kiboCard_1:LoadSprite(petTpl:getKiboBoxCardIcon(tpl, 5, self.data.info:isSpecialPet()), false, CS.Azur.Gameplay.UI.ELImageLoadType.ForceSync)
  self.bindComponents.kiboCard_2:LoadSprite(petTpl:getKiboBoxCardIcon(tpl, 5, self.data.info:isSpecialPet()), false, CS.Azur.Gameplay.UI.ELImageLoadType.ForceSync)
  local elementTypeId = petTpl:getFirstElement(tpl)
  self.bind.img_elementBottomBg = string.format(PATH_BG_ELEMENT, elementTypeId)
  self.bind[gradeRankName] = true
  self.bind.petPropertyList:clear()
  local propertyData = {}
  local all_Attribute = petLearningEnumTpl:getAllEnum(true)
  for i, v in ipairs(all_Attribute) do
    local enumId = petLearningEnumTpl:getEnumNum(v)
    local id = 0
    for n, k in pairs(topRankComprehension) do
      if k.attr_id == enumId then
        id = k.rankId
        break
      end
    end
    table.insert(propertyData, {
      attrIcon = petLearningEnumTpl:getNewIcon(petLearningEnumTpl:getTplByEnumId(enumId)),
      value = battleInfoTpl:getShowTxtComma(enumId, L_PetStore:getPetAttFinalValue(property, enumId, self.data.info.guid)),
      name = petLearningEnumTpl:getName(petLearningEnumTpl:getTplByEnumId(enumId)),
      attrId = id
    })
  end
  self.bind.petPropertyList:insert_array(propertyData)
  local genelist = L_PetStore:getPetSkills(self.data.info, false, true, false)
  self:setGeneList(genelist)
  self.geneData = genelist
  self:openTickTimer()
  if self.data.info.guid ~= 0 then
    self:refreshHomeLaborTag()
  end
end

function page:setGeneList(genelist)
  local function getOpenPositions(count)
    local positions = {
      [1] = {3},
      
      [2] = {2, 3},
      [3] = {
        2,
        3,
        4
      },
      [4] = {
        1,
        2,
        3,
        4
      }
    }
    return positions[count] or {}
  end
  
  table.sort(genelist, function(a, b)
    return a.rarity > b.rarity
  end)
  local geneCount = #genelist
  geneCount = math.min(geneCount, 4)
  local openPositions = getOpenPositions(geneCount)
  local displayData = {}
  for i, pos in ipairs(openPositions) do
    displayData[pos] = genelist[i]
  end
  local tmpTable = {}
  for pos = 1, 4 do
    local gene = displayData[pos]
    if gene then
      gene.type = "show"
      table.insert(tmpTable, gene)
    else
      table.insert(tmpTable, {type = "hide"})
    end
  end
  self:playGeneSFX(genelist)
  self.bind.petGetGeneList:clear()
  self.bind.petGetGeneList:insert_array(tmpTable)
end

function page:playGeneSFX(genelist)
  L_TimerManager:newOrResetTimer(self, "geneSFXTimer", function()
    for i, gene in ipairs(genelist) do
      L_TimerManager:newOrResetTimer(self, "geneSFX_" .. i, function()
        local rarity = gene.rarity or 1
        local sfxName = DNA_SFX[rarity] or DNA_SFX[1]
        L_AudioUtil.playSound(sfxName)
      end, (i - 1) * 0.3)
    end
  end, 2)
end

function page:openTickTimer()
  self.initTime = gameConstTpl:getData("KIBO_GET_COUNTDOWN", L_Const.GameTplType.int)
  self.bind.go_time = not C_InputManager.IsEnableGamePad
  
  local function func()
    self.initTime = self.initTime - 1
    if self.initTime > 0 then
      self.bind.txt_time = ""
    else
      local canvasGroup = self.bindComponents.rect_tips:GetComponent(typeof(C_CanvasGroup))
      canvasGroup.alpha = 0
      self.tipsTween = canvasGroup:DOFade(1, 0.5)
      self.bind.txt_time = wordsTpl:getValue("ui_get_kibo_close")
      L_TimerManager:clearTimer(self)
    end
  end
  
  L_TimerManager:newOrResetTimer(self, "timeTick", func, 1, -1)
  func()
end

function page:timelineSignalListener(signalMsg)
  if signalMsg == "PlayAnim" then
    self.bind.timelineMask = false
    L_PetManager:playPetPersonalShow()
    L_TimerManager:newOrResetTimer(self, "delayBlack", function()
      self:alphaTween()
    end, 0.1)
  end
end

function page:moduleBoxItemList()
  local boxId = self.data.info.box_id
  self.curBoxIndex = boxId // 100
  local boxNameIndex = L_PetStore:getPetBoxNameList()
  self.bind.selectBoxName = boxNameIndex[self.curBoxIndex]
end

function page:refreshContinueHatchShow()
  if not self.data.bFromHatch then
    self.bind.active_btn_continueHatch = false
    return
  end
  if L_ProductManager:isProductRewarded(self.data.bldUid) then
    self.bind.active_btn_continueHatch = true
    local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(self.data.bldUid)
    local csHomeBuildProductDataList = csHomeBuildData.products
    local csHomeBuildProductData = csHomeBuildProductDataList[0]
    local specialGuid = csHomeBuildProductData.specialGuid
    if not specialGuid then
      errorf("孵化台孵化数据有问题" .. self.data.bldUid .. " " .. csHomeBuildProductData.guid)
    end
    self.data.eggUid = specialGuid
    return
  end
  self.bind.active_btn_continueHatch = false
end

function page:reqSetPetBox()
  local pet = L_PetStore:getPetItem(self.data.info.guid)
  if pet == nil then
    return
  end
  local _, slot = L_PetStore:getPetBoxIsFull(self.curBoxIndex)
  local box_id = self.curBoxIndex * 100 + slot
  L_PetStore:req_CSSetPetBox(self.data.info.guid, box_id)
end

function page:closeDoTween()
  if L_CommonUtil.isValid(self.tipsTween) then
    self.tipsTween:Kill()
    self.tipsTween = nil
  end
  if L_CommonUtil.isValid(self._doTween) then
    self._doTween:Kill()
    self._doTween = nil
  end
  if self.mutationTimer then
    Timer.remove(self.mutationTimer)
    self.mutationTimer = nil
  end
  L_TimerManager:clearTimer(self)
  L_PetManager:setPetBlackRootColor(C_Color(0, 0, 0, 0))
end

function page:close(options)
  page.super.close(self, options)
  if self.timer then
    self.timer:destroy()
    Timer.remove(self.timer)
    self.timer = nil
  end
  self:closeDoTween()
  if self._originalBloomEnable ~= nil then
    self:setPetModelBloomEffect(self._originalBloomEnable)
    self._originalBloomEnable = nil
  end
  if options.texture then
    C_RenderTexture.ReleaseTemporary(options.texture)
  end
  if self.animator then
    self.animator.stateNotify:Remove(handler(self, self.stateNotifyFunc))
  end
  L_RewardManager:showBattlePage(nil, L_Const.FightRewardReason.FRR_Catch)
  L_PetManager:removePetGetScene()
  if self._closeCallback then
    self._closeCallback()
  end
  AzurWorld.HUDMgr:SetAllVisible(true)
  L_PetManager.curGetPetGuid = nil
  C_MultiTeamMgr:TrySetupPetDuelSuccess()
  if AzurWorld.PetCatchManagerMgr:IsNestCoopPetCatch() then
    AzurWorld.NestCoopKiboDuelMgr:StarLinkShowUiEnd()
  end
  if L_DeviceTpl:getIsPc() then
    self:setShortcutGuidePCActive(false)
  end
end

function page:refreshHomeLaborTag()
  local petGuid = self.data.info.guid
  local C_HomeManager = AzurWorld.HomeMgr
  local C_PetStore = C_HomeManager:GetPetStore()
  local C_PetData = C_PetStore:GetPet(petGuid)
  local C_LaborInfoList = C_PetData:GetLaborInfoList()
  local showParamsList = {}
  for i = 0, C_LaborInfoList.Count - 1 do
    local C_LaborInfo = C_LaborInfoList[i]
    local C_TalentIds = C_PetData.talentIds
    local talentId
    if 0 < C_TalentIds.Count and i == 0 then
      talentId = C_TalentIds[0]
    end
    local showParams = {
      petId = C_PetData.configId,
      laborId = C_LaborInfo.laborId,
      laborGrade = C_LaborInfo.laborGrade,
      talentId = talentId,
      upperLaborGrade = C_LaborInfo.upperLaborGrade
    }
    table.insert(showParamsList, showParams)
  end
  self.bind.list_petHomeLaborTag:clear()
  self.bind.list_petHomeLaborTag:insert_array(showParamsList)
end

function page:SetPetRatingGrade(guid)
  local grade, gradeRank = L_PetStore:getPetGradeNew(guid)
  self.grade = grade
  
  local function cbk(childObj)
    if self.curScript then
      self.curScript:Init(grade)
    else
      local module = GETPETRANKGRADE[gradeRank].module
      self.curScript = require(module).new(G_UIModuleBase.ModuleType.Static)
      self.curScript:created(nil, nil, self)
      self.curScript:toBind(self.pfObj:GetComponent(typeof(C_UIBinding)))
      self.curScript:Init(grade)
    end
    self:playRatingSFX(gradeRank)
  end
  
  self:LoadRankTip(gradeRank, cbk)
end

function page:playRatingSFX(gradeRank)
  local sfxName = RATING_SFX[gradeRank] or RATING_SFX[1]
  L_TimerManager:newOrResetTimer(self, "ratingSFXTimer", function()
    L_AudioUtil.playSound(sfxName)
  end, 1.4)
end

function page:LoadRankTip(gradeRank, cbk)
  local pfPath = GETPETRANKGRADE[gradeRank].Path
  C_LuaUtility.InstantiateAsync(pfPath, function(go)
    if not L_CommonUtil.isValid(go) then
      errorf("cant load asset from " .. pfPath)
      return
    end
    self.pfObj = go
    if cbk then
      cbk(self.pfObj)
    end
  end, self.bindComponents.rankRoot.transform)
end

function page:setShortcutGuidePCActive(isShow)
  local args = CS.Lens.Gameplay.UI.ModuleShortcutGuidePcUiPanelEventArgs()
  args.isLuaEvent = true
  args.luaTable = {shortcutGuidePcUiPanel = 1024}
  if isShow then
    C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcShowUiPanel, args)
  else
    C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcHideUiPanel, args)
  end
end

return page
