local this = class("pageHero", G_UIPageBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local _systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()
local _fightProhibitTbl = L_GameTpl:getFightProhibitTpl()
local MODULE_SYSTEM = {
  [L_Const.heroModuleType.Talent] = L_SystemConst.enum.heroTalent,
  [L_Const.heroModuleType.SoulEssence] = L_SystemConst.enum.soulEssence,
  [L_Const.heroModuleType.Accessory] = L_SystemConst.enum.accessory,
  [L_Const.heroModuleType.Data] = L_SystemConst.enum.heroData,
  [L_Const.heroModuleType.Grade] = L_SystemConst.enum.heroGrade
}
local PageHeroMap = {
  [L_Const.heroModuleType.Property] = {
    name = "moduleProperty",
    ToggleName = "togglePropertyActive",
    moduleShowRing = true
  },
  [L_Const.heroModuleType.Talent] = {
    name = "talentModule",
    ToggleName = "toggleTalentActive",
    moduleShowRing = false
  },
  [L_Const.heroModuleType.Accessory] = {
    name = "moduleAccessory",
    ToggleName = "toggleAccessoryActive",
    moduleShowRing = false
  },
  [L_Const.heroModuleType.Data] = {
    name = "dataModule",
    ToggleName = "toggleDataActive",
    moduleShowRing = true
  },
  [L_Const.heroModuleType.Grade] = {
    name = "moduleGrade",
    ToggleName = "toggleGradeActive",
    moduleShowRing = false
  }
}
local heroModuleTypeList = {
  L_Const.heroModuleType.Property,
  L_Const.heroModuleType.Talent,
  L_Const.heroModuleType.Star,
  L_Const.heroModuleType.SoulEssence,
  L_Const.heroModuleType.Accessory,
  L_Const.heroModuleType.FormationPet,
  L_Const.heroModuleType.Data,
  L_Const.heroModuleType.Present
}

function this.bind()
  return {
    goAniRoot = true,
    go_board = true,
    toggleInfo = 0,
    downBg = true,
    mask = false,
    togglePropertyActive = true,
    toggleSkillActive = false,
    toggleStarActivee = true,
    toggleTalentActive = true,
    toggleAccessoryActive = true,
    toggleDataActive = true,
    toggleGradeActive = true,
    togglePetActive = false,
    previewLevelToggles = false,
    toggleModuleBar = {
      type = "toggleModule",
      moduleProperty = {
        assetName = "UI/Pages/heroPanel/moduleProperty",
        moduleName = "pages/heroPanel/moduleProperty"
      },
      skillModule = {
        assetName = "UI/Pages/heroPanel/moduleHeroSkill",
        moduleName = "pages/heroPanel/skill/moduleSkill"
      },
      talentModule = {
        assetName = "UI/Pages/heroPanel/moduleHeroTalent",
        moduleName = "pages/heroPanel/talent/moduleHeroTalent"
      },
      moduleAccessory = {
        assetName = "UI/Pages/heroPanel/moduleHeroAccessory",
        moduleName = "pages/heroPanel/accessory/moduleAccessory"
      },
      dataModule = {
        assetName = "UI/Pages/heroPanel/moduleHeroData",
        moduleName = "pages/heroPanel/moduleHeroData"
      },
      moduleGrade = {
        assetName = "UI/Pages/heroPanel/moduleHeroGrade",
        moduleName = "pages/heroPanel/moduleHeroGrade"
      }
    },
    toggleModuleName = "",
    listHeroHeads = {
      moduleName = "modulePages/cellHeroHeadItemCircle"
    },
    lastAndNext = true,
    ringActive = true,
    lockActive = false,
    modulesActive = true,
    txt_Property = "",
    txt_Talent = "",
    txt_Star = "",
    txt_Jewelry = "",
    txt_Data = "",
    txt_UnProperty = "",
    txt_UnTalent = "",
    txt_UnStar = "",
    txt_UnJewelry = "",
    txt_UnData = "",
    txt_CheckProperty = "",
    txt_CheckTalent = "",
    txt_CheckStar = "",
    txt_CheckJewelry = "",
    txt_CheckData = "",
    img_Property = "UI/Page/BSCommon/tex_herodetail_icon_sp.png",
    img_Talent = "UI/Page/BSCommon/tex_herodetail_icon_gift.png",
    img_Accessory = "UI/Page/BSCommon/tex_herodetail_icon_accessory.png",
    img_Data = "UI/Page/BSCommon/tex_herodetail_icon_data.png",
    img_Grade = "UI/Page/BSCommon/tex_herodetail_icon_detail.png",
    active_heroPropertyPageToggle = false
  }
end

function this.methods()
  return {
    btnProperty = function(self)
      self:on_BottomFuncSelChange(L_Const.heroModuleType.Property)
    end,
    btnAccessory = function(self)
      self:on_BottomFuncSelChange(L_Const.heroModuleType.Accessory)
    end,
    btnData = function(self)
      self:on_BottomFuncSelChange(L_Const.heroModuleType.Data)
    end,
    btnGrade = function(self)
      self:on_BottomFuncSelChange(L_Const.heroModuleType.Grade)
    end,
    btnSkill = function(self)
      self:on_BottomFuncSelChange(L_Const.heroModuleType.Skill)
    end,
    btnTalent = function(self)
      self:on_BottomFuncSelChange(L_Const.heroModuleType.Talent)
    end,
    btnFormationPet = function(self)
      self:on_BottomFuncSelChange(L_Const.heroModuleType.FormationPet)
    end,
    togglePreviewOrigin = function(self)
      self:onTogglePreviewChange(false)
    end,
    togglePreviewMax = function(self)
      self:onTogglePreviewChange(true)
    end,
    listHeroHeads = {
      onClick = function(self, bind)
        if self.modeController:getSelectGuid() == bind.id or C_PageHeroPipelineBridge.IsLoading() then
          return
        end
        if not self:canChangeHero() then
          return
        end
        self.modeController:setSelectGuid(bind.id)
      end
    },
    btn_heroPropertyPageToggle = function(self)
      if L_UI:checkPageShown("pageHeroProperty") then
        L_UI:close("pageHeroProperty")
      end
    end
  }
end

function this:check(options, callback)
  if (not options or not options.ignoreProxyType) and AzurWorld.DungeonMgr:CheckIsDungeonScene() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_cannot_goscene"))
    callback(false)
    return
  end
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.hero)
  if not result then
    callback(false)
    return
  end
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.OpenHeroPage, true) then
    callback(false)
    return
  end
  if L_PlayerManager:inKiBoTransformMainControl() then
    callback(false)
    return
  end
  callback(true)
end

function this:created(...)
  this.super.created(self, ...)
  self.bOpenMagicClothRecord = C_ModelManager.OpenMagicCloth
  if C_ModelManager.OpenMagicCloth == true then
    C_ModelManager.OpenMagicCloth = false
  end
  self.modeController = nil
  self.heroGuidList = {}
  local options = self.options or {}
  if options.jumpParams then
    options.selectModuleType = options.jumpParams[1]
  end
  self.options = options
  self.currentModuleType = options.selectModuleType == nil and "Property" or options.selectModuleType
  self:initModeController(options)
  self.heroGuidList = options.heroIdList or self:getAllHeroList()
  self._heroId2FormationData = self:getFormationData()
  self:sortHeroGuidList()
  local selectHeroGuid = options.heroId or L_FormationStore:getControl(L_FormationConst.FormationType.world)
  local hero = L_HeroStore:getHero(selectHeroGuid)
  if L_HeroStore:getIsTrail(hero) then
    selectHeroGuid = nil
    local posData = L_FormationStore:getFormationPosData(L_FormationManager:getCurFormationType())
    for i, v in ipairs(posData) do
      if not math.isEmpty(v) then
        local hero_temp = L_HeroStore:getHero(v)
        if not L_HeroStore:getIsTrail(hero_temp) then
          selectHeroGuid = v
          break
        end
      end
    end
  end
  selectHeroGuid = selectHeroGuid or self.heroGuidList[1]
  if options and options.heroIdList then
    selectHeroGuid = options.heroIdList[1]
  end
  if options.callBack then
    self.callBack = options.callBack
  end
  self.modeController:setSelectGuid(selectHeroGuid, true)
  self.heroIndex = self:getHeroIndex()
  self._ESyncHeroServerDataHandler = handler(self, self.onEvent_refreshHero)
  AzurWorld.heroMgr:RegisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
  L_HeroStore:listenCallFunc(L_HeroStore.event.setCurHeroGuid, self.onEvent_setCurHeroID, self)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshModAvatar, self.onEvent_refreshAvatar, self)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshHeroListAndToggleModuleShowState, self.setBgToggles, self)
  L_HeroManager:addListener(L_HeroManager.event.showHeroSelection, self.onShowHeroSelection, self)
  L_UI:addListener(L_UI.pageEvent.opened, self.onEvent_showPage, self)
  L_UI:addListener(L_UI.pageEvent.closed, self.onEvent_closePage, self)
  self._ERefreshHeroHandler = handler(self, self.RefreshHero)
  AzurWorld.heroMgr:RegisterEvent(C_EHeroEvent.ERefreshMainPlayer, self._ERefreshHeroHandler)
end

function this:preOpen(options)
  AzurWorld.RedDotMgr:RefreshRedDot(L_ReddotManager.DotDef.HeroHead)
  self.bind.goAniRoot = true
  self.preOpenInit = true
  self.lastTimelineState = L_Const.heroTimelineState.None
  self:setDownBg(true)
  self:refreshModuleTypeArea()
  self:initSystem()
  self:initTogglesRed()
  self:initHeroLock()
  if L_DeviceTpl:getIsPc() then
    self:setShortcutGuidePCActive(true)
  end
  self.bind.txt_Property = L_WordsTpl:getValue("ui_hero_dec_01")
  self.bind.txt_Talent = L_WordsTpl:getValue("ui_hero_dec_02")
  self.bind.txt_Star = L_WordsTpl:getValue("ui_hero_dec_03")
  self.bind.txt_Jewelry = L_WordsTpl:getValue("ui_hero_dec_04")
  self.bind.txt_Data = L_WordsTpl:getValue("ui_hero_dec_05")
  self.bind.txt_UnProperty = L_WordsTpl:getValue("ui_hero_dec_01")
  self.bind.txt_UnTalent = L_WordsTpl:getValue("ui_hero_dec_02")
  self.bind.txt_UnStar = L_WordsTpl:getValue("ui_hero_dec_03")
  self.bind.txt_UnJewelry = L_WordsTpl:getValue("ui_hero_dec_04")
  self.bind.txt_UnData = L_WordsTpl:getValue("ui_hero_dec_05")
  self.bind.txt_CheckProperty = L_WordsTpl:getValue("ui_hero_dec_01")
  self.bind.txt_CheckTalent = L_WordsTpl:getValue("ui_hero_dec_02")
  self.bind.txt_CheckStar = L_WordsTpl:getValue("ui_hero_dec_03")
  self.bind.txt_CheckJewelry = L_WordsTpl:getValue("ui_hero_dec_04")
  self.bind.txt_CheckData = L_WordsTpl:getValue("ui_hero_dec_05")
  options = options or {}
  if options.jumpParams then
    options.selectModuleType = options.jumpParams[1]
  end
  if options.clearStackOnGoToNextStack then
    self.hide_pet = true
  else
    self.hide_pet = false
  end
  self.curSelectButton = nil
  if not self.modeController:isPreviewMode() then
    self:populateHeroList()
  end
  self:initRightModule(options)
  if self.csharpPage ~= nil then
    C_UISceneManager.SetSceneVisible()
    C_UISceneManager.SetUISceneEntryType(C_EUISceneType.Hero)
    self:initHeroTimeline(true, C_UIMgr.CloseCutin)
  end
  self.bind.modulesActive = false
  self.bind.lastAndNext = false
  local curModule = self.modules.toggleModuleBar[self.bind.toggleModuleName]
  if curModule ~= nil and curModule.setNeedHide then
    curModule:setNeedHide()
  end
end

function this:open(options)
  self:refreshCanChangeHero(true)
  self.bind.modulesActive = true
  if self.bind.toggleModuleName == PageHeroMap[L_Const.heroModuleType.Talent].name then
    local curModule = self.modules.toggleModuleBar[self.bind.toggleModuleName]
    if curModule ~= nil then
      curModule:refreshTalentReward()
    end
  end
  local curModule = self.modules.toggleModuleBar[self.bind.toggleModuleName]
  if curModule ~= nil and curModule.playEnterAni then
    curModule:playEnterAni()
  end
  self:playHeroVoice(self.modeController:getSelectConfigId(), self.currentModuleType)
end

function this:show()
  C_UISceneManager.SetSceneVisible()
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.Hero)
  self.bind.goAniRoot = true
  self.preOpenInit = false
  self.lastCameraBlendStyle = C_CameraManager.GetMainCameraBrain().m_DefaultBlend.m_Style
  C_CameraManager.SetBrainBlendStyle(L_Const.blendStyle.cut)
end

function this:hide()
  C_PageHeroPipelineBridge.HideAllAsset()
  if C_PageHeroPipelineBridge.IsLoading() then
    C_PageHeroPipelineBridge.Dispose()
  else
    C_PageHeroPipelineBridge.HideAllAsset()
  end
  if self.lastCameraBlendStyle ~= nil then
    C_CameraManager.SetBrainBlendStyle(self.lastCameraBlendStyle)
    self.lastCameraBlendStyle = nil
  end
  C_UISceneManager.SetSceneVisible()
end

function this:close(options)
  this.super.close(self, options)
  if self.callBack then
    self.callBack()
  end
  if C_ModelManager.OpenMagicCloth ~= self.bOpenMagicClothRecord then
    C_ModelManager.OpenMagicCloth = self.bOpenMagicClothRecord
  end
  if L_DeviceTpl:getIsPc() then
    self:setShortcutGuidePCActive(false)
  end
  C_PageHeroPipelineBridge.Dispose()
  L_HeroVoiceManager:stopHeroVoice()
  self:destroyAllLocker()
  AzurWorld.heroMgr:UnregisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
  AzurWorld.heroMgr:UnregisterEvent(C_EHeroEvent.ERefreshMainPlayer, self._ERefreshHeroHandler)
  L_HeroStore:unListenCallFunc(L_HeroStore.event.setCurHeroGuid, self.onEvent_setCurHeroID)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshModAvatar, self.onEvent_refreshAvatar)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshHeroListAndToggleModuleShowState, self.setBgToggles)
  L_HeroManager:removeListener(L_HeroManager.event.showHeroSelection, self.onShowHeroSelection, self)
  C_MultiEvent.instance:Dispatch(C_EMultiEvent.MultiFormationClose)
  L_UI:removeListener(L_UI.pageEvent.opened, self.onEvent_showPage)
  L_UI:removeListener(L_UI.pageEvent.closed, self.onEvent_closePage, self)
  if L_UI:checkPageShown("pageHeroProperty") then
    L_UI:close("pageHeroProperty")
  end
end

function this:onEvent_showPage(pageName)
  if pageName == "pageHeroProperty" then
    self.bind.active_heroPropertyPageToggle = true
  end
end

function this:onEvent_closePage(pageName)
  if pageName == "pageHeroProperty" then
    self.bind.active_heroPropertyPageToggle = false
  end
end

function this:onTopChange(options)
  if self.isOnTop and L_Const.heroModuleType.Accessory == self.currentModuleType then
    local isShow = L_UI:arePagesClosed({
      "pageSoulEssenceUpgrade",
      "pageHeroSoulEssenceSwitch",
      "pageAccessoryStrength",
      "pageSoulEssenceInfo"
    })
    if self.bind.modulesActive ~= isShow then
      self:setDownBg(isShow)
      self.bind.modulesActive = isShow
    end
  end
  if self.cacheLv == nil then
    self.cacheLv = L_Const.topChangeHideLv.lowMemory
  end
  if options.topLv == 0 and 0 < options.lastTopLv then
    if self.topStateDirty then
      if not self.preOpenInit then
        self:initHeroTimeline(true, C_UIMgr.CloseCutin)
      end
      self.preOpenInit = false
      self.topStateDirty = false
    elseif self.needRefresh then
      C_PageHeroPipelineBridge.Dispose()
      self:initHeroTimeline(true, C_UIMgr.CloseCutin)
      self.needRefresh = false
    else
      C_UIMgr.CloseCutin()
      self:OnAllLoadedPlayTimeline(true)
    end
  elseif options.topLv == self.cacheLv and options.lastTopLv < self.cacheLv then
    C_PageHeroPipelineBridge.Dispose()
    self.topStateDirty = true
    if self.csharpPage then
      self.csharpPage.needCutback = true
    end
  end
end

function this:initRightModule(options)
  local selectModuleType = L_Const.heroModuleType.Property
  local selectModuleParam = {}
  for i = 1, #heroModuleTypeList do
    if self.modeController:checkModuleIsShow(heroModuleTypeList[i]) then
      selectModuleType = heroModuleTypeList[i]
      break
    end
  end
  if options and options.selectModuleType and self.modeController:checkModuleIsShow(options.selectModuleType) then
    selectModuleType = options.selectModuleType
    selectModuleParam = options.selectModuleParam or {}
  end
  local moduleName = PageHeroMap[selectModuleType].name
  if moduleName ~= nil and self.bind.toggleModuleName == moduleName then
    return
  end
  self:refreshUI(selectModuleType, selectModuleParam)
end

function this:onTopBarRefresh()
  self:setTopBarCloseCallback()
  if self.modeController.isPreviewMode() then
    C_IntegrateMgr.TopBarModule:SetTopBarBackName(self.modeController:getHomeName())
  end
end

function this:setTopBarCloseCallback()
  C_IntegrateMgr.TopBarModule:SetTopBarCloseFunc(function()
    self:dealBack()
  end)
end

function this:dealBack()
  if not L_HeroStore:getIsPlayLevelAnim() then
    if self.closeCurPageFunc then
      self.closeCurPageFunc()
      self.closeCurPageFunc = nil
      C_IntegrateMgr.TopBarModule:SetTopBarBackName(self.modeController:getHomeName())
      return
    end
    L_UI:close(self.pageName)
  end
end

function this:getAllHeroList()
  local list = {}
  for i, v in pairs(L_HeroStore:getAllHero()) do
    table.insert(list, L_HeroStore:getHeroGuid(v))
  end
  return list
end

function this:getFormationData()
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

function this:getHeroIndex()
  local selectedGuid = self.modeController:getSelectGuid()
  for i, v in ipairs(self.heroGuidList) do
    if selectedGuid == v then
      return i
    end
  end
  return 1
end

function this:setCommonTopData(func, name)
  self.closeCurPageFunc = func
  if string.isEmpty(name) then
    C_IntegrateMgr.TopBarModule:SetTopBarBackName(self.modeController:getHomeName())
  else
    C_IntegrateMgr.TopBarModule:SetTopBarBackName(name)
  end
end

function this:sortHeroGuidList()
  local list = self.heroGuidList
  if not list or #list <= 1 then
    return
  end
  local modeController = self.modeController
  local getHero = modeController.getHero
  local heroStore = L_HeroStore
  local itemMgr = L_ItemTplManager
  local getHeroConfigId = heroStore.getHeroConfigId
  local getHeroItem = itemMgr.getHeroItem
  local getHeroLevel = heroStore.getHeroLevel
  local getHeroStar = heroStore.getHeroStar
  local formationMap = self._heroId2FormationData
  local records = {}
  for i = 1, #list do
    local guid = list[i]
    local rec = {guid = guid}
    local heroData
    heroData = getHero(modeController, guid)
    if heroData then
      local configId = getHeroConfigId(heroStore, heroData)
      local config = getHeroItem(itemMgr, configId)
      rec.isOut = formationMap[guid] or math.huge
      rec.level = getHeroLevel(heroStore, heroData)
      rec.quality = config.quality
      rec.star = getHeroStar(heroStore, heroData)
      rec.configId = heroData.configId
      records[i] = rec
    else
      rec.isOut = math.huge
      rec.level = 0
      rec.quality = 0
      rec.star = 0
      rec.heroMissing = true
      rec.configId = math.huge
    end
  end
  table.sort(records, function(a, b)
    if a.heroMissing or b.heroMissing then
      return a.configId < b.configId
    end
    if a.isOut ~= b.isOut then
      return a.isOut < b.isOut
    end
    if a.level ~= b.level then
      return a.level > b.level
    end
    if a.quality ~= b.quality then
      return a.quality > b.quality
    end
    if a.star ~= b.star then
      return a.star > b.star
    end
    return a.configId < b.configId
  end)
  for i = 1, #records do
    list[i] = records[i].guid
  end
end

function this:populateHeroList()
  local modeController = self.modeController
  local L_HeroStore = _ENV.L_HeroStore
  local _heroTpl = _heroTpl
  local L_GameTpl = _ENV.L_GameTpl
  local L_RarityTpl = _ENV.L_RarityTpl
  local C_ColorUtility = _ENV.C_ColorUtility
  local getHero = self.modeController.getHero
  local getHeroConfigId = L_HeroStore.getHeroConfigId
  local getHeroLevel = L_HeroStore.getHeroLevel
  local getTplById = _heroTpl.getTplById
  local getElement = _heroTpl.getElement
  local getPosition = _heroTpl.getPosition
  local getRarity = _heroTpl.getRarity
  local elementTypeTpl = L_GameTpl:getElementTypeTpl()
  local professionTpl = L_GameTpl:getProfessionTpl()
  local getProfessionColor = elementTypeTpl.getProfessionColor
  local getProfessionTplById = elementTypeTpl.getTplById
  local getRarityTplById = L_RarityTpl.getTplById
  local getColorCircle = L_RarityTpl.getColorCircle
  local TryParseHtmlString = C_ColorUtility.TryParseHtmlString
  local formationData = self:getFormationData()
  local formationLookup = {}
  for id in pairs(formationData) do
    formationLookup[id] = true
  end
  local heroGuidList = self.heroGuidList
  self.heroHeadUIData = {}
  local selectedIndex = self.heroIndex or 0
  local circle = L_Const.professionColorType.circle
  local colorCfg = "#eaffaa"
  for k, v in ipairs(heroGuidList) do
    local heroId = v
    local hero = getHero(modeController, heroId)
    local heroConfigId = getHeroConfigId(L_HeroStore, hero)
    local tpl = getTplById(_heroTpl, heroConfigId)
    local elementId = getElement(_heroTpl, tpl)
    local bgIconPath = getProfessionColor(elementTypeTpl, getProfessionTplById(elementTypeTpl, elementId), circle)
    local professionIcon = professionTpl:getIcon(professionTpl:getTplById(getPosition(_heroTpl, tpl)))
    local teamPosIndex = formationData[heroId] ~= nil and formationData[heroId] or 0
    local rarity = getRarity(_heroTpl, tpl)
    local rarityTpl = getRarityTplById(L_RarityTpl, rarity)
    colorCfg = getColorCircle(L_RarityTpl, rarityTpl)
    local _, color = TryParseHtmlString(colorCfg)
    table.insert(self.heroHeadUIData, {
      id = heroId,
      txtLevel = string.format("%02d", getHeroLevel(L_HeroStore, hero)),
      selected = k == selectedIndex,
      qualityColor = color,
      heroConfigId = heroConfigId,
      teamPosIndex = teamPosIndex
    })
  end
  local bind = self.bind
  bind.listHeroHeads:clear()
  bind.listHeroHeads:insert_array(self.heroHeadUIData)
  if 0 < selectedIndex then
    self.bindComponents.panelHeroHeads:FocusItemIndex(selectedIndex - 1)
  end
end

function this:refreshPageView(options)
  local lastModule = self.modules.toggleModuleBar[PageHeroMap[self.currentModuleType].name]
  if lastModule and lastModule.closePage then
    lastModule:closePage()
  end
  self:preOpen(options)
  self:initRightModule(options)
end

function this:playHeroVoice(configId, moduleType)
  if self.options ~= nil then
    L_HeroVoiceManager:playHeroVoiceByConfigId(configId, moduleType)
  end
end

function this:initHeroTimeline(isFirstInit, waitCallback)
  local heroGuid = self.modeController:getSelectGuid()
  local heroId = self.modeController:getSelectConfigId()
  if heroGuid ~= nil and heroId ~= nil and heroId == heroGuid then
    local hero = AzurWorld.heroMgr:GetHero(heroGuid)
    if hero then
      heroId = AzurWorld.heroMgr:GetHero(heroGuid).configId
    end
  end
  if not self.modeController:showTimeline() then
    if waitCallback then
      waitCallback()
    end
    return
  end
  local clothingId = AzurWorld.heroMgr:GetUsingClothingId(heroGuid, heroId)
  local _heroClothingTpl = L_GameTpl:getHeroClothingTpl()
  local heroClothing = _heroClothingTpl:getTplById(clothingId)
  local path = heroClothing.uiperform
  local scenePath = heroClothing.uibackground
  scenePath = L_CommonUtil.getMultiPlatformScenePath(scenePath)
  local state = self:getTimelineStateAndShowHero()
  local excludeState = {
    L_Const.heroTimelineState.Select
  }
  local excludeArr = CS.System.Array.CreateInstance(typeof(CS.System.String), #excludeState)
  for i = 1, #excludeState do
    excludeArr[i - 1] = excludeState[i]
  end
  if isFirstInit then
    C_UIMgr.OpenCutin(1)
  end
  C_PageHeroPipelineBridge.InitHeroTimelineLoad(C_UIMgr.GetPage(self.pageName), scenePath, path, state, excludeArr, heroId, self.modeController:getSelectGuid(), L_PlayerStore:getSex(), isFirstInit, 0, function()
    if waitCallback then
      waitCallback()
    end
  end)
end

function this:OnAllLoadedPlayTimeline(isResumeFromTop)
  local state = self:getTimelineStateAndShowHero()
  C_PageHeroPipelineBridge.ShowAllAsset()
  if isResumeFromTop then
    C_PageHeroPipelineBridge.CheckPlayTimelineStateByStateLoader(state, true, false)
  else
    C_PageHeroPipelineBridge.PlayTimelineStateByStateLoader(state, true, true)
  end
  C_PageHeroPipelineBridge.PreloadStateByStateLoader(state)
  C_PageHeroPipelineBridge.PreloadStateOutgoingTransitionsByStateLoader(state)
end

function this:getTimelineStateAndShowHero()
  local state = L_Const.heroTimelineState.Detail
  if self.bind.toggleModuleName then
    local module = self.modules.toggleModuleBar[self.bind.toggleModuleName]
    if module then
      local moduleState = module:getTimelineState()
      if moduleState ~= L_Const.heroTimelineState.None then
        state = moduleState
      elseif self.lastTimelineState ~= L_Const.heroTimelineState.None then
        state = self.lastTimelineState
      else
        state = L_Const.heroTimelineState.Detail
      end
    end
  end
  return state
end

function this:playTimelineAndRefreshInteractable(toggleName)
  if not self.modeController:showTimeline() then
    return true
  end
  local nextState = L_Const.heroTimelineState.Detail
  if toggleName then
    local module = self.modules.toggleModuleBar[toggleName]
    if module then
      local moduleState = module:getTimelineState()
      if moduleState == L_Const.heroTimelineState.None then
        return true
      end
      nextState = moduleState
    end
  end
  local state, _ = self:getTimelineStateAndShowHero()
  if state ~= nextState then
    local transitionAssetName = C_PageHeroPipelineBridge.GetTimelineAssetNameByTransition(state, nextState)
    if not C_PageHeroPipelineBridge.CheckTimelineLoadedByStateLoader(transitionAssetName) then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_character_system_too_frequent"))
      return false
    end
  end
  local lastShowHero = C_PageHeroPipelineBridge.GetTimelineAssetsActive()
  C_PageHeroPipelineBridge.SetTimelineAssetsActive(true)
  C_PageHeroPipelineBridge.CheckPlayTimelineStateByStateLoader(nextState, true, lastShowHero)
  self.lastTimelineState = nextState
  local stateAssetName = C_PageHeroPipelineBridge.GetTimelineAssetNameByState(nextState)
  C_PageHeroPipelineBridge.CancelUnrelatedLoadingByStateLoader(stateAssetName)
  C_PageHeroPipelineBridge.PreloadStateByStateLoader(nextState)
  C_PageHeroPipelineBridge.PreloadStateOutgoingTransitionsByStateLoader(nextState)
  return true
end

function this:initModeController(options)
  if options.pageType then
    if options.pageType == L_Const.heroPageType.DetailMode then
      self.modeController = require("ui.pages.heroPanel.controller.heroDetailModeController").new()
    elseif options.pageType == L_Const.heroPageType.ListMode then
      self.modeController = require("ui.pages.heroPanel.controller.heroListModeController").new()
    elseif options.pageType == L_Const.heroPageType.PreviewMode then
      self.modeController = require("ui.pages.heroPanel.controller.heroPreviewModeController").new()
    elseif options.pageType == L_Const.heroPageType.HandBookMode then
      self.modeController = require("ui.pages.heroPanel.controller.heroHandBookPreviewModeController").new()
    end
  end
  if self.modeController == nil then
    self.modeController = require("ui.pages.HeroPanel.controller.heroListModeController").new()
  end
  if options.showCurrentProperty then
    self.modeController:setCurrentProperty(options.showCurrentProperty)
  end
end

function this:refreshModuleTypeArea()
  local checkModuleIsShow = self.modeController.checkModuleIsShow
  for i, value in pairs(PageHeroMap) do
    local isShow = checkModuleIsShow(self.modeController, i)
    self.bind[value.ToggleName] = isShow
  end
end

function this:onEvent_refreshAvatar()
  for k, v in ipairs(self.heroGuidList) do
    if v == L_HeroStore:getDefaultHeroGuid() then
      self.bind.listHeroHeads:change(k, {})
      return
    end
  end
end

function this:onEvent_refreshHero(enum, varList)
  local hero = varList:GetObject(0)
  if L_HeroStore:getHeroGuid(hero) ~= self.modeController:getSelectGuid() then
    return
  end
  if self.bind.toggleModuleName == "petModule" then
    self.modules.toggleModuleBar.petModule:refresh()
  end
  self:refreshHeroHead(L_HeroStore:getHeroGuid(hero), nil)
end

function this:onEvent_setCurHeroID(newHeroID, oldHeroID)
  self.heroIndex = self:getHeroIndex()
  local curModule = self.modules.toggleModuleBar[self.bind.toggleModuleName]
  if self.bind.toggleModuleName == "moduleProperty" then
    curModule:setAnimationState(false)
    self.bDelay = true
    self._changingHero = true
    self._chgHeroTimerDone = false
    self._chgHeroLoadDone = false
    self:newOrResetTimer("propertyTimer", function()
      if L_DeviceTpl:getIsMobile() then
        if self.bDelay == false then
          self:initData()
          curModule:setAnimationState(true)
        end
      else
        self:initData()
        curModule:setAnimationState(true)
      end
      self.bDelay = false
      self._chgHeroTimerDone = true
      self:tryFinishChangeHero()
    end, 0.231)
  else
    self._changingHero = false
    self:initData()
  end
  self:refreshHeroHead(newHeroID, oldHeroID, true)
  self:initHeroTimeline(false, function()
    if self.bind.toggleModuleName == "moduleProperty" and L_DeviceTpl:getIsMobile() then
      if self.bDelay == false then
        self:initData()
        curModule:setAnimationState(true)
      end
      self.bDelay = false
    end
    self._chgHeroLoadDone = true
    self:tryFinishChangeHero()
    C_UIMgr.CloseCutin()
    self:playHeroVoice(self.modeController:getSelectConfigId(), self.currentModuleType)
  end)
end

function this:tryFinishChangeHero()
  if self._chgHeroTimerDone and self._chgHeroLoadDone then
    self._changingHero = false
  end
end

function this:getSelHeroData()
  return self.modeController:getHero(self.heroGuidList[self.heroIndex])
end

function this:refreshHeroHead(newHeroID, oldHeroID, bSelChange)
  if self.modeController:isPreviewMode() then
    return
  end
  for k, v in ipairs(self.heroGuidList) do
    local heroId = v
    if heroId == newHeroID or heroId == oldHeroID then
      local heroData = self.modeController:getHero(heroId)
      local heroItem = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroData))
      local heroConfigId = L_HeroStore:getHeroConfigId(heroData)
      local clothingId = AzurWorld.heroMgr:GetUsingClothingId(heroId, heroConfigId)
      local heroHeadAvatarTexture = L_GameUtil.getAvatarTexturePath(clothingId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.small)
      if bSelChange then
        self.heroHeadUIData[k].selected = heroId == newHeroID
        self.modules.listHeroHeads[k]:refreshSelState(heroId == newHeroID)
      else
        self.bind.listHeroHeads:change(k, {
          id = heroId,
          imgHead = heroHeadAvatarTexture,
          txtLevel = string.format("%02d", L_HeroStore:getHeroLevel(heroData)),
          colorCircle = heroItem.qualityColor,
          selected = heroId == newHeroID
        })
      end
    end
  end
end

function this:initSystem()
  self.systemToTrans = {
    [L_SystemConst.enum.heroTalent] = {
      self.bindComponents.transTalent
    },
    [L_SystemConst.enum.heroGrade] = {
      self.bindComponents.transGrade
    },
    [L_SystemConst.enum.accessory] = {
      self.bindComponents.transAccessory
    },
    [L_SystemConst.enum.heroData] = {
      self.bindComponents.transData
    }
  }
  local systemUnlockStore = C_IntegrateMgr.SystemUnlockModule
  local isUnlocked, tpl, shouldShow
  for systemId, v in pairs(self.systemToTrans) do
    isUnlocked = systemUnlockStore.getSystemIsOpen(systemUnlockStore, systemId)
    if not isUnlocked then
      tpl = _systemUnlockTpl:getTplById(systemId)
      shouldShow = tpl and _systemUnlockTpl:getButtonShow(tpl)
      if shouldShow then
        v.locker = C_IntegrateMgr.SystemUnlockModule:TryGenerateLocker(systemId)
        if v.locker then
          self:refreshSystem(systemId, false)
          v.locker:setCallback(self.refreshSystem, self, self.gameObject)
        end
      end
    end
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
    local isNeedShow = locker:tryShowOrHide(v, isUnlock)
    if isNeedShow then
      local lock = v:Find("Background/lock")
      local unlock = v:Find("Background/unlock")
      if lock then
        lock.gameObject:ActiveTrans(not isUnlock)
      end
      if unlock then
        unlock.gameObject:ActiveTrans(isUnlock)
      end
    end
  end
end

function this:initHeroLock()
  if self.modeController:showCurrentProperty() then
    self.bind.lockActive = false
  elseif self.modeController:isPreviewMode() then
    local currHeroConfigId = self.modeController:getSelectConfigId()
    if L_HeroStore:getHasHero(currHeroConfigId) then
      self.bind.lockActive = false
    else
      self.bind.lockActive = true
    end
  else
    self.bind.lockActive = false
  end
end

function this:initTogglesRed()
  if self.modeController:isPreviewMode() then
    self.bindComponents.redotJewel.gameObject:SetActive(false)
    self.bindComponents.redotHeroInfo.gameObject:SetActive(false)
    self.bindComponents.redotGrade.gameObject:SetActive(false)
  else
    local selectGuid = self.modeController:getSelectGuid()
    L_ReddotManager:clearNew(L_ReddotManager.DotDef.HeroNew, selectGuid)
    AzurWorld.RedDotMgr:MarkDirty(string.format(L_ReddotManager.DotDef.HeroHead, selectGuid))
    AzurWorld.RedDotMgr:BindRedDotRenderer(string.format("HeroAccessory_%s", selectGuid), self.bindComponents.redotJewel.gameObject)
    self:registerReddot(self.bindComponents.redotHeroInfo, string.format(L_ReddotManager.DotDef.HeroInfo, selectGuid))
    self:registerReddot(self.bindComponents.redotTalent, string.format(L_ReddotManager.DotDef.HeroTalent, selectGuid))
    AzurWorld.RedDotMgr:BindRedDotRenderer(string.format(L_ReddotManager.DotDef.HeroGrade, selectGuid .. "_heroProperty"), self.bindComponents.redotProperty.gameObject)
    AzurWorld.RedDotMgr:BindRedDotRenderer(string.format("HeroGradeTab_%s", selectGuid), self.bindComponents.redotGrade.gameObject)
  end
end

function this:initData()
  self:initTogglesRed()
  local curModule = self.modules.toggleModuleBar[self.bind.toggleModuleName]
  if curModule ~= nil then
    curModule:initPage(nil, self.preOpenInit)
  end
end

function this:onTogglePreviewChange(isMaxLevel)
  if not self.modeController:isPreviewMode() then
    return
  end
  local lastIsMax = self.modeController:getIsMaxLevel()
  self.modeController:setisMaxLevel(isMaxLevel)
  if self.bind.toggleModuleName == PageHeroMap[L_Const.heroModuleType.Property].name and isMaxLevel ~= lastIsMax then
    self.modules.toggleModuleBar[self.bind.toggleModuleName]:playTotalPreviewAnimation(isMaxLevel)
    FrameScheduler.add(function()
      self.modules.toggleModuleBar[self.bind.toggleModuleName]:initPage()
    end, 1)
  else
    self.modules.toggleModuleBar[self.bind.toggleModuleName]:initPage()
  end
end

function this:checkCanShowGrade()
  if AzurWorld.DungeonMgr:CheckIsDungeonScene() or AzurWorld.proxyCenter.curProxy.proxyType == C_EWorldType.MultiDungeon or AzurWorld.abyssMgr.isInAbyss or AzurWorld.scenarioManager.RuntimeData.IsInTrial or AzurWorld.scenarioManager.GlobalData:GetIsInEndlessTrail() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_cannot_goscene"))
    return false
  end
  local systemId = L_SystemConst.enum.heroGrade
  local result = not L_SystemBreakManager:checkBanSystemAndTip(systemId) and C_IntegrateMgr.SystemUnlockModule:CheckAndTip(systemId)
  if not result then
    return false
  end
  if C_PageHeroPipelineBridge.IsLoading() then
    return false
  end
  if C_BattleManager.IsInBattle(C_EntityManager.MainPlayer) then
    local cfg = _fightProhibitTbl:getTplById(1028)
    L_FlyMsgManager:showNormalMsg(_fightProhibitTbl:getBlockTips(cfg))
    return false
  end
  return true
end

function this:on_BottomFuncSelChange(moduleType, params)
  if moduleType == L_Const.heroModuleType.Grade and not self:checkCanShowGrade() then
    return
  end
  local systemId = MODULE_SYSTEM[moduleType]
  if systemId then
    local result = not L_SystemBreakManager:checkBanSystemAndTip(systemId) and C_IntegrateMgr.SystemUnlockModule:CheckAndTip(systemId)
    if not result then
      return
    end
  end
  if C_PageHeroPipelineBridge.IsLoading() then
    return
  end
  local canSwitch = self:playTimelineAndRefreshInteractable(PageHeroMap[moduleType].name)
  if not canSwitch then
    return
  end
  if L_UI:checkPageShown("pageHeroProperty") then
    L_UI:close("pageHeroProperty")
  end
  self:playHeroVoice(self.modeController:getSelectConfigId(), moduleType)
  self:refreshUI(moduleType, params)
end

function this:refreshUI(moduleType, params)
  self.bind.ringActive = PageHeroMap[moduleType].moduleShowRing == true
  params = params or {}
  params.hide_pet = self.hide_pet
  local moduleName = PageHeroMap[moduleType].name
  local systemId = MODULE_SYSTEM[moduleType]
  if systemId then
    local result = not L_SystemBreakManager:checkBanSystemAndTip(systemId) and C_IntegrateMgr.SystemUnlockModule:CheckAndTip(systemId)
    if not result then
      return
    end
  end
  local lastModule
  if self.currentModuleType then
    lastModule = self.modules.toggleModuleBar[PageHeroMap[self.currentModuleType].name]
  end
  if self.currentModuleType == "Property" and moduleType == L_Const.heroModuleType.Talent then
    self.modules.toggleModuleBar.moduleProperty:playSwitchAnimator("LevelToBreak")
    self.bind.ringActive = true
    self.bindComponents.ringAnim:Play("Switch")
    Timer.once(0.67, function()
      self.bind.ringActive = false
    end, self)
    self:initPage(lastModule, moduleName, params)
    self.currentModuleType = moduleType
    self:triggerSelection(moduleType)
    self:refreshCanChangeHero(true)
    self.bind.previewLevelToggles = false
  else
    self.currentModuleType = moduleType
    self:triggerSelection(moduleType)
    self:refreshCanChangeHero(true)
    self:initPage(lastModule, moduleName, params)
    self.bind.previewLevelToggles = false
  end
  self:setHeroHeadPanelActive(moduleType ~= L_Const.heroModuleType.Grade)
end

function this:initPage(lastModule, moduleName, params)
  if lastModule and lastModule.closePage then
    lastModule:closePage()
  end
  self.bind.toggleModuleName = moduleName
  self.modules.toggleModuleBar[moduleName]:initPage(params, self.preOpenInit)
  if self.modules.toggleModuleBar[moduleName].playChangeEffect ~= nil then
    self.modules.toggleModuleBar[moduleName]:playChangeEffect()
  end
end

function this:triggerSelection(moduleType)
  for i, _ in pairs(PageHeroMap) do
    local t = self.bindComponents["trans" .. i]
    if t then
      self:selectButtonIsOn(t, false)
    end
  end
  local trans = self.bindComponents["trans" .. moduleType]
  self:selectButtonIsOn(trans, true)
  self.curSelectButton = trans
end

function this:selectButtonIsOn(trans, isOn)
  if trans then
    trans:Find("Checkmark").gameObject:ActiveTrans(isOn)
    trans:Find("Background").gameObject:ActiveTrans(not isOn)
  end
end

function this:canChangeHero()
  if self._changingHero then
    return false
  end
  local curModule = self.modules.toggleModuleBar[self.bind.toggleModuleName]
  if curModule and curModule.checkIsLevelUp and curModule:checkIsLevelUp() then
    return false
  end
  return true
end

function this:refreshCanChangeHero(canShow)
  local canChangeHero = canShow
  canChangeHero = canChangeHero and #self.heroGuidList > 1
  canChangeHero = canChangeHero and self.modeController:checkCanChangeHero()
  self.bind.lastAndNext = canChangeHero
end

function this:setDownBg(bool)
  bool = bool and self.modeController:checkCanShowDownBG()
  self.bind.downBg = bool
  self:refreshCanChangeHero(bool)
end

function this:setHeroHeadPanelActive(show)
  if self.bindComponents.panelHeroHeads then
    self.bindComponents.panelHeroHeads.gameObject:SetActive(show)
  end
  if not show then
    self.bind.lastAndNext = false
  end
end

function this:setCommonTop(bool)
  self.bind.go_commonTop = bool
end

function this:setMaskActive(active)
  self.bind.mask = active
end

function this:escHandle()
  if self.modules.toggleModuleBar and self.modules.toggleModuleBar[self.bind.toggleModuleName] and self.modules.toggleModuleBar[self.bind.toggleModuleName].getCanClose then
    local canClose = self.modules.toggleModuleBar[self.bind.toggleModuleName]:getCanClose()
    if not canClose then
      return
    end
  end
  self:dealBack()
end

function this:onShowHeroSelection(data)
  if data.selectionType == L_Const.heroModuleType.Talent then
    self:setDownBg(true)
    self:refreshCanChangeHero(true)
    self:setCommonTopData()
  end
  self:on_BottomFuncSelChange(data.selectionType, data.jumpData)
end

function this:setBlurActive(isBlur)
  self.bindComponents.blur.enabled = isBlur
end

function this:setBgToggles(isActiveBg)
  self.bind.downBg = isActiveBg
  C_IntegrateMgr.TopBarModule:SetTopBarVisible(isActiveBg)
end

function this:setShortcutGuidePCActive(isShow)
  local args = CS.Lens.Gameplay.UI.ModuleShortcutGuidePcUiPanelEventArgs()
  args.isLuaEvent = true
  args.luaTable = {shortcutGuidePcUiPanel = 64}
  if isShow then
    C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcShowUiPanel, args)
  else
    C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcHideUiPanel, args)
  end
end

function this:RefreshHero()
  self.needRefresh = true
end

return this
