local this = class("moduleHeroData", require("ui.pages.HeroPanel.moduleHeroBase"))
local _charDataTpl = L_GameTpl:getCharDataTpl()
local _charVoiceTpl = L_GameTpl:getCharVoiceTpl()
local _charStoryTpl = L_GameTpl:getCharStoryTpl()
local _speciesTpl = L_GameTpl:getSpeciesTpl()
local _nationsTpl = L_GameTpl:getGroupsTpl()
local _charPlotTpl = L_GameTpl:getCharPlotTpl()
local _charKiboTpl = L_GameTpl:getCharKiboTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
local animationName = {
  [L_Const.heroDataModuleType.Info] = "infoAnimation",
  [L_Const.heroDataModuleType.Story] = "storyAnimation",
  [L_Const.heroDataModuleType.Voice] = "voiceAnimation",
  [L_Const.heroDataModuleType.Drama] = "dramaAnimation"
}

function this.bind()
  return {
    infoPanel = false,
    storyPanel = false,
    voicePanel = false,
    dramaPanel = false,
    petPanel = false,
    infoChoice = true,
    storyChoice = false,
    voiceChoice = false,
    dramaChoice = false,
    petChoice = false,
    infoBackground = false,
    storyBackground = true,
    voiceBackground = true,
    dramaBackground = true,
    petBackground = true,
    goBirthday = true,
    goPetLine = true,
    goPetInfo = true,
    goPetDesc = true,
    goInfo_nextLine = true,
    goStory = false,
    goStory_nextLine = true,
    goVoice = false,
    goDrama = false,
    goVoice_nextLine = true,
    go_dramaEmpty = true,
    go_dramaContent = false,
    go_dynamicHead = false,
    dynamicHead = "",
    name = "",
    birthday = "",
    nation = "",
    nationOtherText = "",
    nationActive = true,
    nationOtherActive = false,
    race = "",
    cv = "",
    resume = "",
    heroPetList = {
      moduleName = "pages/HeroPanel/hero/cellHeroPetItem"
    },
    nationIcon = "",
    storyItemList = {
      moduleName = "pages/HeroPanel/hero/cellHeroStoryItem"
    },
    voiceItemList = {
      moduleName = "pages/HeroPanel/hero/cellHeroVoiceItem"
    },
    dramaItemList = {
      moduleName = "pages/HeroPanel/hero/cellHeroDramaItem"
    },
    txt_dramaNum = "",
    favorabilityDramaCount = "",
    infoScrollNormalize = 1,
    storyScrollNormalize = 1,
    voiceScrollNormalize = 1,
    active_dramaLine = false,
    img_pet = "",
    txt_petName = "",
    modulePet = {
      moduleName = "pages/pet/modulePetPixelIcon"
    },
    moduleHeroFavorabilityArea = {
      moduleName = "pages/heroPanel/moduleHeroFavorabilityArea"
    },
    goPetLock = false,
    goPetHouse = false,
    goPetTask = false,
    goPetGet = false,
    txt_petLock = "",
    txt_petTask = "",
    txt_petGet = ""
  }
end

function this.methods()
  return {
    onClick_toggleInfo = function(self)
      C_AudioManager.Play("Play_SFX_System_UI_General_Parchment_Switch_L1")
      self:btnChoice(L_Const.heroDataModuleType.Info, true)
    end,
    onClick_toggleStory = function(self)
      if not self:getSystemIsOpen(L_SystemConst.enum.heroDataStory) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_systemMessage_16"))
        return
      end
      C_AudioManager.Play("Play_SFX_System_UI_General_Parchment_Switch_L1")
      self:btnChoice(L_Const.heroDataModuleType.Story, true)
    end,
    onClick_toggleVoice = function(self)
      if not self:getSystemIsOpen(L_SystemConst.enum.heroDataVoice) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_systemMessage_16"))
        return
      end
      C_AudioManager.Play("Play_SFX_System_UI_General_Parchment_Switch_L1")
      self:btnChoice(L_Const.heroDataModuleType.Voice, true)
    end,
    onClick_toggleDrama = function(self)
      if not self:getSystemIsOpen(L_SystemConst.enum.heroDataDrama) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_systemMessage_16"))
        return
      end
      C_AudioManager.Play("Play_SFX_System_UI_General_Parchment_Switch_L1")
      self:btnChoice(L_Const.heroDataModuleType.Drama, true)
    end,
    onClick_togglePet = function(self)
      C_AudioManager.Play("Play_SFX_System_UI_General_Parchment_Switch_L1")
      self:btnChoice(L_Const.heroDataModuleType.Pet, true)
    end,
    onClick_goHome = function(self)
      local wordsTpl = L_GameTpl:getWordsTpl()
      L_FlyMsgManager:showNormalMsg(wordsTpl:getValue("notice_system_notdo"))
    end,
    onClick_petTask = function(self)
      local tpl = _charKiboTpl:getTplById(self.heroConfigId)
      L_JumpMgr:jumpTo(tpl.systemJump)
    end,
    onClick_petGet = function(self)
      if self.bInGetPetCD == true then
        return
      end
      self.bInGetPetCD = true
      self:newOrResetTimer("timer", function()
        self.bInGetPetCD = false
      end, 1.5)
      if not L_PetStore:getIsPetBoxHasValidSlot() then
        local wordsTpl = L_GameTpl:getWordsTpl()
        L_FlyMsgManager:showNormalMsg(wordsTpl:getValue("notice_kibo_box_full_can_not_receive"))
        return
      end
      local herotpl = _heroTpl:getTplById(self.heroConfigId)
      local kiboId = _heroTpl:getKiboId(herotpl)
      AzurWorld.heroMgr:ReqGetCharKibo(self.heroGuid, kiboId, function()
        self:onEvent_refreshCharKibo()
      end)
    end,
    onClick_petHouse = function(self)
      local herotpl = _heroTpl:getTplById(self.heroConfigId)
      local kiboId = _heroTpl:getKiboId(herotpl)
      if kiboId and L_PetStore:getPetNum(kiboId) == 0 or L_PetManager:checkPetInMailReward(kiboId) then
        local wordsTpl = L_GameTpl:getWordsTpl()
        L_FlyMsgManager:showNormalMsg(wordsTpl:getValue("notice_kibo_box_full_mail"))
        return
      end
      local allPet = L_PetStore:getPetList()
      local petList = {}
      for i, pet in pairs(allPet) do
        if pet.id == kiboId then
          table.insert(petList, {
            guid = pet.guid
          })
        end
      end
      table.sort(petList, function(a, b)
        return a.guid < b.guid
      end)
      L_UI:open("pagePetBox", {
        defaultPetGuid = petList[1].guid,
        failure_jump = self:GetSourceLuaPageOptions("failure_jump")
      })
    end,
    storyItemList = {
      storyToggle = function(self, id, newBool)
        for i = 1, #self.bind.storyItemList do
          if id ~= self.bind.storyItemList:getValue(i, "id") and self.bind.storyItemList:getValue(i, "isInfoOpen") then
            self.bind.storyItemList:change(i, {isInfoOpen = false})
            self.bind.storyItemList:getItemCls(i):refresh(false)
          end
        end
        self.backScrollNormalize = self.bindComponents.storyScroll.verticalNormalizedPosition
      end
    },
    voiceItemList = {
      voiceToggle = function(self, id, newBool, audioEvent)
        for i = 1, #self.bind.voiceItemList do
          if id ~= self.bind.voiceItemList:getValue(i, "id") and self.bind.voiceItemList:getValue(i, "isInfoOpen") then
            self.bind.voiceItemList:change(i, {isInfoOpen = false})
            self.bind.voiceItemList:getItemCls(i):refresh()
          end
        end
        L_HeroVoiceManager:playHeroVoice(audioEvent)
        self.backScrollNormalize = self.bindComponents.voiceScroll.verticalNormalizedPosition
      end
    },
    onValueChanged_storyItemList = function(self, _)
      if not self.lockBackVertical then
        self.backScrollNormalize = nil
      end
    end,
    onValueChanged_voiceItemList = function(self, _)
      if not self.lockBackVertical then
        self.backScrollNormalize = nil
      end
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open()
  self.heroGuid = self:getModeController():getSelectGuid()
  self.heroConfigId = self:getModeController():getSelectConfigId()
  C_AudioManager.Play("Play_SFX_System_UI_General_Parchment_Open_L3")
  self._ESyncHeroServerDataHandler = handler(self, self.onEvent_refreshHero)
  AzurWorld.heroMgr:RegisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
  self._refreshTaskHandler = self._refreshTaskHandler or handler(self, self.onEvent_refreshTask)
  AzurWorld.TaskMgr:RegisterEvent(C_ETaskEvent.RefreshUITask, self._refreshTaskHandler)
end

function this:close()
  C_AudioManager.Play("Play_SFX_System_UI_General_Parchment_Close_L3")
  self:destroyAllLocker()
  AzurWorld.heroMgr:UnregisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
  if self._refreshTaskHandler then
    AzurWorld.TaskMgr:UnregisterEvent(C_ETaskEvent.RefreshUITask, self._refreshTaskHandler)
  end
  L_PhotoManager:releaseHead(self)
end

function this:initSystem()
  self.systemToTrans = {
    [L_SystemConst.enum.heroFavorability] = {
      self.bindComponents.favorabilityUnlockArea
    },
    [L_SystemConst.enum.heroDataStory] = {
      self.bindComponents.toggleStory
    },
    [L_SystemConst.enum.heroDataVoice] = {
      self.bindComponents.toggleVoice
    },
    [L_SystemConst.enum.cv] = {
      self.bindComponents.rect_cv
    },
    [L_SystemConst.enum.heroDataDrama] = {
      self.bindComponents.toggleDrama
    },
    [L_SystemConst.enum.heroDataPet] = {
      self.bindComponents.togglePet
    }
  }
  for systemId, v in pairs(self.systemToTrans) do
    v.locker = C_IntegrateMgr.SystemUnlockModule:TryGenerateLocker(systemId)
    if v.locker then
      self:refreshSystem(systemId, false)
      v.locker:setCallback(self.refreshSystem, self, self.gameObject)
    else
      for _, trans in pairs(self.systemToTrans[systemId]) do
        trans.gameObject:ActiveTrans(true)
      end
    end
  end
  if self:getSystemIsOpen(L_SystemConst.enum.dorm) == false then
    self.bind.active_dorm = false
  else
    self.bind.active_dorm = true
  end
  local herotpl = _heroTpl:getTplById(self.heroConfigId)
  local kiboId = _heroTpl:getKiboId(herotpl)
  local tableData = _charKiboTpl:getTplById(self.heroConfigId)
  if kiboId == nil or tableData == nil then
    self.bindComponents.togglePet:ActiveTrans(false)
    self.bind.active_dramaLine = false
  else
    self.bindComponents.togglePet:ActiveTrans(true)
    self.bind.active_dramaLine = true
  end
end

function this:destroyAllLocker()
  for _, v in pairs(self.systemToTrans) do
    local locker = v.locker
    if locker then
      C_IntegrateMgr.SystemUnlockModule:RemoveLocker(locker)
    end
  end
end

function this:refreshSystem(systemId, isUnlock)
  local node = self.systemToTrans[systemId]
  local locker = node.locker
  for _, v in ipairs(node) do
    if systemId == L_SystemConst.enum.cv then
      v.gameObject:ActiveTrans(isUnlock)
    else
      local isNeedShow = locker:tryShowOrHide(v, isUnlock)
      if isNeedShow then
        v.gameObject:ActiveTrans(isUnlock)
      end
    end
  end
end

function this:onEvent_refreshCharKibo()
  self:petPanelSet()
end

function this:initPage(params)
  self.bInGetPetCD = false
  this.super.initPage(self)
  local forceRefresh = true
  forceRefresh = forceRefresh and (self.heroGuid == nil or self.heroGuid == self:getModeController():getSelectGuid())
  if forceRefresh then
    self:refresh(params, true)
  else
    self.bindComponents.infoAnimation:Stop()
    self:animationRefresh(params)
    self.bindComponents.infoAnimation:Play("anim_heroes_data_switch_in")
    self:playChangeEffect()
  end
  self:initSystem()
end

function this:playChangeEffect()
  self.bindComponents.favorabilityAnimation:Stop("anim_heroes_data_favor_show")
  self.bindComponents.favorabilityAnimation:Play("anim_heroes_data_favor_show")
end

function this:onEvent_refreshHero()
  if self.delayRefreshTimer then
    return
  end
  self.modules.moduleHeroFavorabilityArea:refreshHeroFavorabilityInfo()
  self:refreshFavorabilityDramaCount()
  self:refreshFavorabilityEntries()
  if self.curPanelEnum == L_Const.heroDataModuleType.Info then
  elseif self.curPanelEnum == L_Const.heroDataModuleType.Story then
    self:refreshStory()
  elseif self.curPanelEnum == L_Const.heroDataModuleType.Voice then
    self:refreshVoice()
  elseif self.curPanelEnum == L_Const.heroDataModuleType.Drama then
    self:refreshDrama()
  end
end

function this:refreshVoice()
  for i = 1, #self.bind.voiceItemList do
    local id = self.bind.voiceItemList:getValue(i, "id")
    local tpl = _charVoiceTpl:getTplById(id)
    local unLockCondition = _charVoiceTpl:getUnlockCondition(tpl)
    local name = _charVoiceTpl:getTitle(tpl)
    local isComp, lockIndex = self:getConditionStatus(unLockCondition)
    if lockIndex then
      name = L_GameUtil.fillColor(_charVoiceTpl:getUnlockConditionText(tpl, lockIndex), L_Const.colorHtml.grey004)
    end
    local new = not L_HeroStore:getIsCharDataRead(self.heroConfigId, L_Const.heroData.voice, id)
    if not isComp then
      new = false
    end
    self.bind.voiceItemList:change(i, {
      title = name,
      lock = not isComp,
      new = new,
      openText = isComp
    })
  end
end

function this:refreshStory()
  for i = 1, #self.bind.storyItemList do
    local id = self.bind.storyItemList:getValue(i, "id")
    local tpl = _charStoryTpl:getTplById(id)
    local unLockCondition = _charStoryTpl:getUnlockCondition(tpl)
    local name = _charStoryTpl:getTitle(tpl)
    local isComp, lockIndex = self:getConditionStatus(unLockCondition)
    if lockIndex then
      name = L_GameUtil.fillColor(_charStoryTpl:getUnlockConditionText(tpl, lockIndex), L_Const.colorHtml.grey004)
    end
    local new = not L_HeroStore:getIsCharDataRead(self.heroConfigId, L_Const.heroData.story, id)
    if not isComp then
      new = false
    end
    self.bind.storyItemList:change(i, {
      name = name,
      lock = not isComp,
      new = new,
      openText = isComp
    })
  end
end

function this:refreshDrama()
  for i = 1, #self.bind.dramaItemList do
    local charPlot = _charPlotTpl:getTplByHeroId(self.heroConfigId, i)
    local dramaDesc = _charPlotTpl:getTitle(charPlot)
    local isComp, lockIndex = self:getConditionStatus(_charPlotTpl:getUnlockCondition(charPlot))
    if lockIndex then
      dramaDesc = _charPlotTpl:getUnlockConditionText(charPlot, lockIndex)
    end
    self.bind.dramaItemList:change(i, {unlockTips = dramaDesc, isUnlock = isComp})
  end
  self:refreshDramaNum()
end

function this:refreshDramaNum()
  local compCount = 0
  for i = 1, #self.bind.dramaItemList do
    local charPlot = _charPlotTpl:getTplByHeroId(self.heroConfigId, i)
    local isComp, lockIndex = self:getConditionStatus(_charPlotTpl:getUnlockCondition(charPlot))
    if isComp then
      compCount = compCount + 1
    end
  end
  self.bind.txt_dramaNum = string.format("%d/%d", compCount, #self.bind.dramaItemList)
end

function this:onEvent_refreshTask(type, list)
  if self.delayRefreshTimer then
    return
  end
  if self.panelEnum ~= L_Const.heroDataModuleType.Drama then
    return
  end
  self.modules.moduleHeroFavorabilityArea:refreshHeroFavorabilityInfo()
  self:refreshFavorabilityEntries()
  self:refreshFavorabilityDramaCount()
  for i = 1, #self.bind.dramaItemList do
    local charPlot = _charPlotTpl:getTplByHeroId(self.heroConfigId, i)
    local dramaDesc = _charPlotTpl:getTitle(charPlot)
    local isComp, result = L_ConditionManager:isComplete(_charPlotTpl:getUnlockCondition(charPlot))
    if isComp then
    else
      for i, v in ipairs(result) do
        if not v then
          dramaDesc = _charPlotTpl:getUnlockConditionText(charPlot, i)
          break
        end
      end
    end
    self.bind.dramaItemList:change(i, {unlockTips = dramaDesc, isUnlock = isComp})
    self.bind.dramaItemList:getItemCls(i):refresh()
  end
  self:refreshDramaNum()
end

function this:refresh(params)
  self.heroGuid = self:getModeController():getSelectGuid()
  self.heroConfigId = self:getModeController():getSelectConfigId()
  local favorArea = self.modules.moduleHeroFavorabilityArea
  if favorArea then
    favorArea:setData(self.heroGuid, self.heroConfigId, self:getModeController())
  end
  self:clearDelayAnimationRefresh()
  local hero = self:getHero(self.heroGuid)
  self.rank = L_HeroStore:getHeroRank(hero)
  if self.heroGuid == L_HeroStore:getDefaultHeroGuid() then
    self.bind.go_dynamicHead = false
    L_PhotoManager:fillMainHead(self, self.bindComponents.head.gameObject, nil, L_Const.avatarTextureIndex.head_talk, function()
      self.bind.go_dynamicHead = true
    end)
  else
    L_PhotoManager:releaseHead(self)
    self.bind.go_dynamicHead = true
    self.bind.dynamicHead = ""
    local heroConfigId = L_HeroStore:getHeroConfigId(hero)
    local clothingId = AzurWorld.heroMgr:GetUsingClothingId(self.heroGuid, heroConfigId)
    self.bind.dynamicHead = L_GameUtil.getAvatarTexturePath(clothingId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.mid)
  end
  self:registerReddot(self.bindComponents.reddotStory, string.format(L_ReddotManager.DotDef.HeroInfo, self.heroGuid .. "_story"))
  self:registerReddot(self.bindComponents.reddotVoice, string.format(L_ReddotManager.DotDef.HeroInfo, self.heroGuid .. "_voice"))
  self:registerReddot(self.bindComponents.reddotDrama, string.format(L_ReddotManager.DotDef.HeroInfo, self.heroGuid .. "_drama"))
  self:registerReddot(self.bindComponents.reddotPet, string.format(L_ReddotManager.DotDef.HeroInfo, self.heroGuid .. "_pet"))
  local openPanelEnum = L_Const.heroDataModuleType.Info
  if params and params.openPanelEnum then
    openPanelEnum = params.openPanelEnum
  end
  self:btnChoice(openPanelEnum)
  self.modules.moduleHeroFavorabilityArea:refreshHeroFavorabilityInfo()
  self:refreshFavorabilityEntries()
end

function this:refreshFavorabilityEntries()
  local tpl = _heroTpl:getTplById(self.heroConfigId)
  local haveFavor = _heroTpl:getFavor(tpl) == 1
  local showFavorabilityInfo = self:getModeController():checkShowFavorabilityInfo() and haveFavor
  local showGoDrama = showFavorabilityInfo and self:getOnlySystemUnlock(L_SystemConst.enum.heroDataDrama)
  self.bind.goDrama = showGoDrama
  self.bind.goVoice_nextLine = showGoDrama
  if self:showCurrentProperty() then
    self.bind.goStory = false
    self.bind.goDrama = false
  end
end

function this:refreshPanelData(panelEnum, bForceRefresh)
  self.backScrollNormalize = nil
  self.curPanelEnum = panelEnum
  if panelEnum == L_Const.heroDataModuleType.Info then
    self:infoPanelSet()
  elseif panelEnum == L_Const.heroDataModuleType.Story then
    self:storyPanelSet()
  elseif panelEnum == L_Const.heroDataModuleType.Voice then
    self:voicePanelSet()
  elseif panelEnum == L_Const.heroDataModuleType.Drama then
    self:dramaPanelSet()
  elseif panelEnum == L_Const.heroDataModuleType.Pet then
    self:petPanelSet()
  end
end

function this:animationRefresh(params)
  local animation
  if self.panelEnum ~= nil then
    local name = animationName[self.panelEnum]
    if name then
      animation = self.bindComponents[name]
    end
  end
  if animation == nil then
    self:refresh(params)
    return
  end
  self:refresh(params)
  self:clearDelayAnimationRefresh()
end

function this:unBind()
  self.super.unBind(self)
  self:clearDelayAnimationRefresh()
  if self.photoEntity then
    self.photoEntity:dispose()
    self.photoEntity = nil
  end
end

function this:clearDelayAnimationRefresh()
  if self.delayRefreshTimer then
    Timer.remove(self.delayRefreshTimer)
    self.delayRefreshTimer = nil
  end
end

function this:delayAnimationRefresh(params)
  local animation
  if self.panelEnum ~= nil then
    local name = animationName[self.panelEnum]
    if name then
      animation = self.bindComponents[name]
    end
  end
  if animation then
  end
  self:refresh(params)
end

function this:btnChoice(panelEnum, bCheckPanel)
  if panelEnum == self.panelEnum and bCheckPanel then
    return
  end
  self.panelEnum = panelEnum
  self.bind.infoPanel = panelEnum == L_Const.heroDataModuleType.Info
  self.bind.storyPanel = panelEnum == L_Const.heroDataModuleType.Story
  self.bind.voicePanel = panelEnum == L_Const.heroDataModuleType.Voice
  self.bind.dramaPanel = panelEnum == L_Const.heroDataModuleType.Drama
  self.bind.petPanel = panelEnum == L_Const.heroDataModuleType.Pet
  self.bind.infoChoice = panelEnum == L_Const.heroDataModuleType.Info
  self.bind.storyChoice = panelEnum == L_Const.heroDataModuleType.Story
  self.bind.voiceChoice = panelEnum == L_Const.heroDataModuleType.Voice
  self.bind.dramaChoice = panelEnum == L_Const.heroDataModuleType.Drama
  self.bind.petChoice = panelEnum == L_Const.heroDataModuleType.Pet
  self.bind.infoBackground = panelEnum ~= L_Const.heroDataModuleType.Info
  self.bind.storyBackground = panelEnum ~= L_Const.heroDataModuleType.Story
  self.bind.voiceBackground = panelEnum ~= L_Const.heroDataModuleType.Voice
  self.bind.dramaBackground = panelEnum ~= L_Const.heroDataModuleType.Drama
  self.bind.petBackground = panelEnum ~= L_Const.heroDataModuleType.Pet
  self:refreshPanelData(self.panelEnum)
end

function this:infoPanelSet()
  local charDataTpl = _charDataTpl:getTplById(self.heroConfigId) or _charDataTpl:getTplById(101003)
  local tempName = _charDataTpl:getCharacterName(charDataTpl)
  if self.heroGuid == L_HeroStore:getDefaultHeroGuid() then
    tempName = L_PlayerStore:getPlayerName()
  end
  self.bind.name = tempName
  self.bind.birthday = _charDataTpl:getCharacterBirthday(charDataTpl)
  if self.heroConfigId == L_GameUtil.getDefaultHeroId(L_PlayerStore:getSex()) then
    local baseInfo = L_PlayerStore:getPlayerBaseInfo()
    local birthday = L_FriendStore:getPlayerBirthday(baseInfo)
    local notSetBirth = table.isEmpty(birthday)
    if not notSetBirth then
      self.bind.birthday = L_WordsTpl:getValue("notice_playercard_birthday", {
        month = birthday.month,
        day = birthday.day
      })
    else
      self.bind.birthday = L_WordsTpl:getValue("notice_playercard_birthday", {month = "？", day = "？"})
    end
  end
  local nationId = _charDataTpl:getCharacterNation(charDataTpl)
  self.bind.nation = _nationsTpl:getName(_nationsTpl:getTplById(nationId))
  self.bind.nationOtherText = _nationsTpl:getName(_nationsTpl:getTplById(nationId))
  local raceId = _charDataTpl:getCharacterRace(charDataTpl)
  self.bind.race = _speciesTpl:getName(_speciesTpl:getTplById(raceId))
  local voiceSettingId = L_SettingStore:getSetData(L_Const.settingType.language)
  local voiceLang = L_Const.settingText[L_Const.settingType.language][tonumber(voiceSettingId)]
  local cvName = L_Config:provider(charDataTpl["cv_" .. voiceLang])
  self.bind.cv = cvName
  self.bind.resume = _charDataTpl:getIntroduction(charDataTpl)
  self.bind.nationActive = nationId ~= L_Const.nations.other
  self.bind.nationOtherActive = nationId == L_Const.nations.other
  local heroTpl = L_GameTpl:getHeroTpl()
  local _heroTpl = heroTpl:getTplById(self.heroConfigId)
  local _petTpl = L_GameTpl:getPetTpl()
  local petId = _heroTpl.kiboId
  self.bind.heroPetList:clear()
  if petId and 0 < #petId then
    local listPet = {}
    for i = 1, #petId do
      table.insert(listPet, {
        id = petId[i]
      })
    end
    self.bind.heroPetList:insert_array(listPet)
  else
  end
  if nationId ~= L_Const.nations.other then
    local groupsTpl = L_GameTpl:getGroupsTpl()
    local iconPath = groupsTpl:getIcon(groupsTpl:getTplById(nationId), L_Const.nationTextureIndex.heroNation)
    self.bind.nationIcon = iconPath
  end
  self.bind.infoScrollNormalize = 1
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.heroPetListRect)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.infoContentRect)
  L_TimerManager:newOrResetTimer(self, "refreshInfoScrollView", function()
    if self.bindComponents.infoContentRect.rect.size.y <= 430 then
      self.bindComponents.infoScrollView.enabled = false
    else
      self.bindComponents.infoScrollView.enabled = true
    end
  end, 0)
end

function this:storyPanelSet()
  self.bind.storyItemList:clear()
  self.bind.storyScrollNormalize = 1
  local charDataTpl = _charDataTpl:getTplById(self.heroConfigId)
  local storyTable = _charDataTpl:getCharacterStory(charDataTpl)
  local temp = {}
  local newIDs = {}
  for i, v in ipairs(storyTable) do
    local tpl = _charStoryTpl:getTplById(v)
    local unLockCondition = _charStoryTpl:getUnlockCondition(tpl)
    local name = _charStoryTpl:getTitle(tpl)
    local isComp, lockIndex = self:getConditionStatus(unLockCondition)
    if lockIndex then
      name = L_GameUtil.fillColor(_charStoryTpl:getUnlockConditionText(tpl, lockIndex), L_Const.colorHtml.grey004)
    end
    local new = not L_HeroStore:getIsCharDataRead(self.heroConfigId, L_Const.heroData.story, v)
    if not isComp then
      new = false
    end
    if new then
      table.insert(newIDs, v)
    end
    table.insert(temp, {
      id = v,
      name = name,
      lock = not isComp,
      new = new,
      openText = isComp,
      infoText = _charStoryTpl:getText(tpl),
      heroStory = Unity.Vector2(480, 115),
      isInfoOpen = false
    })
  end
  self.bind.storyItemList:insert_array(temp)
  if 0 < #newIDs then
    AzurWorld.heroMgr:ReqUpdateHeroCharData(self.heroConfigId, L_Const.heroData.story, newIDs)
  end
end

function this:voicePanelSet(keepPos)
  self.bind.voiceItemList:clear()
  if not keepPos then
    self.bind.voiceScrollNormalize = 1
  end
  local charDataTpl = _charDataTpl:getTplById(self.heroConfigId)
  local voiceTable = _charDataTpl:getCharacterVoice(charDataTpl)
  local temp = {}
  self.voiceNew = false
  local newIDs = {}
  for _, v in ipairs(voiceTable) do
    local tpl = _charVoiceTpl:getTplById(v)
    local unLockCondition = _charVoiceTpl:getUnlockCondition(tpl)
    local name = _charVoiceTpl:getTitle(tpl)
    local isComp, lockIndex = self:getConditionStatus(unLockCondition)
    if lockIndex then
      name = L_GameUtil.fillColor(_charVoiceTpl:getUnlockConditionText(tpl, lockIndex), L_Const.colorHtml.grey004)
    end
    local new = not L_HeroStore:getIsCharDataRead(self.heroConfigId, L_Const.heroData.voice, v)
    if not isComp then
      new = false
    end
    if new then
      table.insert(newIDs, v)
    end
    table.insert(temp, {
      id = v,
      title = name,
      action = _charVoiceTpl:getAction(_charVoiceTpl:getTplById(v)),
      audioEvent = _charVoiceTpl:getAudioEvent(_charVoiceTpl:getTplById(v)),
      lock = not isComp,
      new = new,
      infoText = _charVoiceTpl:getText(_charVoiceTpl:getTplById(v)),
      openText = isComp,
      heroVoice = Unity.Vector2(480, 115),
      isInfoOpen = false
    })
  end
  self.bind.voiceItemList:insert_array(temp)
  if 0 < #newIDs then
    AzurWorld.heroMgr:ReqUpdateHeroCharData(self.heroConfigId, L_Const.heroData.voice, newIDs)
  end
end

function this:getConditionStatus(unLockCondition)
  local isComp, results = L_ConditionManager:isComplete(unLockCondition)
  if not isComp then
    for k, result in ipairs(results) do
      if not result then
        return isComp, k
      end
    end
  end
  return isComp
end

function this:refreshFavorabilityDramaCount()
  local charPlots = _charPlotTpl:getChildren(self.heroConfigId)
  local unlockCount = 0
  local allCount = 0
  for _, charPlot in ipairs(charPlots) do
    allCount = allCount + 1
    local isComp, _ = L_ConditionManager:isComplete(_charPlotTpl:getUnlockCondition(charPlot))
    if isComp then
      local taskId = _charPlotTpl:getTaskId(charPlot)
      local taskFinish = true
      if taskId and taskId ~= 0 then
        taskFinish = AzurWorld.TaskMgr:IsFinishTask(taskId)
      end
      if taskFinish then
        unlockCount = unlockCount + 1
      end
    end
  end
  self.bind.favorabilityDramaCount = unlockCount .. "/" .. allCount
end

function this:dramaPanelSet()
  self.bind.dramaItemList:clear()
  local charPlots = _charPlotTpl:getChildren(self.heroConfigId)
  local temp = {}
  local jumpIndex = 1
  local newIDs = {}
  for i, charPlot in ipairs(charPlots) do
    local dramaDesc = _charPlotTpl:getTitle(charPlot)
    local isComp, lockIndex = self:getConditionStatus(_charPlotTpl:getUnlockCondition(charPlot))
    if lockIndex then
      dramaDesc = _charPlotTpl:getUnlockConditionText(charPlot, lockIndex)
    end
    local charId = _charPlotTpl:getId(charPlot)
    local new = not L_HeroStore:getIsCharDataRead(self.heroConfigId, L_Const.heroData.drama, charId)
    if not isComp or self:isPreviewMode() then
      new = false
    end
    local taskId = _charPlotTpl:getTaskId(charPlot)
    local taskFinish = true
    if taskId and taskId ~= 0 then
      taskFinish = AzurWorld.TaskMgr:IsFinishTask(taskId)
    end
    if taskFinish then
      new = false
    end
    if new then
      table.insert(newIDs, charId)
    end
    table.insert(temp, {
      id = charId,
      heroId = self.heroGuid,
      heroConfigId = self.heroConfigId,
      unlockTips = dramaDesc,
      isUnlock = isComp,
      isPreview = self:isPreviewMode(),
      new = new
    })
    local taskId = _charPlotTpl:getTaskId(charPlot)
    local taskFinish = AzurWorld.TaskMgr:IsFinishTask(taskId)
    if jumpIndex == 1 and isComp and not taskFinish then
      local new = not L_HeroStore:getIsCharDataRead(self.heroConfigId, L_Const.heroData.drama, charId)
      if new then
        jumpIndex = i
      end
    end
  end
  if 0 < #temp then
    self.bind.go_dramaEmpty = false
    self.bind.go_dramaContent = true
    self.bind.dramaItemList:insert_array(temp)
    self.bindComponents.dramaTableView:FocusItemIndex(jumpIndex - 1)
    self:refreshFavorabilityDramaCount()
  else
    self.bind.go_dramaEmpty = true
    self.bind.go_dramaContent = false
  end
  self:refreshDramaNum()
  if 0 < #newIDs then
    AzurWorld.heroMgr:ReqUpdateHeroCharData(self.heroConfigId, L_Const.heroData.drama, newIDs)
  end
end

function this:petPanelSet()
  local tableData = _charKiboTpl:getTplById(self.heroConfigId)
  local herotpl = _heroTpl:getTplById(self.heroConfigId)
  local kiboId = _heroTpl:getKiboId(herotpl)
  local tpl_pet = _petTpl:getTplById(kiboId)
  self.bind.img_pet = _petTpl:getKiboBoxCardIcon(tpl_pet, 5)
  local modulePet = self.modules.modulePet
  modulePet:setConfigId(kiboId, true, false)
  self.bind.txt_petName = _petTpl:getName(tpl_pet)
  local unLockCondition = _charKiboTpl:getUnlockCondition(tableData)
  local isComp, lockIndex = self:getConditionStatus(unLockCondition)
  if tableData.getType == 1 then
    if isComp then
      if L_PetStore:getPetNum(kiboId) == 0 then
        self.bind.goPetLock = false
        self.bind.goPetHouse = false
        self.bind.goPetTask = false
        self.bind.goPetGet = true
        self.bind.txt_petGet = L_WordsTpl:getValue("puzzle_interact_2")
        self:registerReddot(self.bindComponents.reddotGetPet, string.format(L_ReddotManager.DotDef.HeroInfo, self.heroGuid .. "_petGet"))
      else
        self.bind.goPetLock = false
        self.bind.goPetHouse = true
        self.bind.goPetTask = false
        self.bind.goPetGet = false
      end
    else
      self.bind.goPetLock = true
      self.bind.goPetHouse = false
      self.bind.goPetTask = false
      self.bind.goPetGet = false
      self.bind.txt_petLock = _charKiboTpl:getUnlockDesc(tableData)
    end
  elseif isComp then
    self.bind.goPetLock = false
    self.bind.goPetHouse = true
    self.bind.goPetTask = false
    self.bind.goPetGet = false
  else
    self.bind.goPetLock = false
    self.bind.goPetHouse = false
    self.bind.goPetTask = true
    self.bind.goPetGet = false
    self.bind.txt_petTask = _charKiboTpl:getUnlockDesc(tableData)
  end
end

function this:getTimelineState()
  return L_Const.heroTimelineState.Equip
end

function this:getOnlySystemUnlock(enumNumber)
  return C_IntegrateMgr.SystemUnlockModule:getOnlySystemUnlock(enumNumber)
end

function this:getSystemIsOpen(enumNumber)
  return C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(enumNumber)
end

function this:checkItemPos(uiBinding, isInfoOpen, scrollName)
  if isInfoOpen then
    local scroll = self.bindComponents[scrollName]
    local uiElementRect = uiBinding:GetComponent(typeof(C_RectTransform))
    local contentPos = scroll.content.localPosition
    local cellMinY = uiElementRect.localPosition.y - uiElementRect.rect.size.y
    local distance = -cellMinY - contentPos.y - scroll.viewport.rect.size.y
    if 0 < distance then
      scroll.content.localPosition = contentPos + L_Vector3.new(0, distance, 0)
    end
  end
end

function this:playEnterAni()
  self.bindComponents.infoAnimation:Stop()
  self.bindComponents.infoAnimation:Play("anim_heroes_data_switch_in")
  self:playChangeEffect()
end

function this:show(options)
  L_HeroManager:curModuleChanged(L_Const.heroModuleType.Data, true)
end

function this:hide(options)
  L_HeroManager:curModuleChanged(L_Const.heroModuleType.Data, false)
end

return this
