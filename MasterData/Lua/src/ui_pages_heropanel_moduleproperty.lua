local this = class("moduleProperty", require("ui.pages.HeroPanel.moduleHeroBase"))
local uiTopBarTpl = L_GameTpl:getUiTopBarTpl()
local _fightProhibitTbl = L_GameTpl:getFightProhibitTpl()

function this.bind()
  return {
    go_pet = false,
    isOn_hasPet = false,
    module_pixelIcon = {
      moduleName = "pages/pet/modulePetPixelIcon"
    },
    txt_petLevel = nil,
    txt_petName = nil,
    toggleModuleBar = {
      type = "toggleModule",
      heroTotalProperty = {
        assetName = "UI/Pages/HeroPanel/Prop/heroTotalProperty",
        moduleName = "pages/heroPanel/property/heroTotalProperty",
        autoHideOthers = false
      },
      heroModuleLevelUp = {
        assetName = "UI/Pages/HeroPanel/Prop/heroModuleLevelUp",
        moduleName = "pages/heroPanel/property/heroModuleLevelUp",
        autoHideOthers = false
      }
    },
    toggleModuleName = "",
    txt_petFavorLv = "",
    txt_heroGrade = "",
    txt_curHeroGrade = "",
    go_petFavor = false
  }
end

function this.methods()
  return {
    onClick_pet = function(self)
      if L_BattleDataManager:checkPlayerBattle() then
        L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.FormationSetting))
        return
      end
      if L_FormationStore:getIsTrailFormation(L_FormationManager:getCurFormationType()) and not L_WorldManager:getCurModule() == C_EWorldType.Prologue or AzurWorld.DungeonMgr:CheckIsDungeonScene() then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageFormationMain_01"))
        return
      end
      L_UI:open("pageWearPet", {
        heroGuid = self.heroGuid,
        failure_jump = self:GetSourceLuaPageOptions("failure_jump")
      })
    end,
    onClick_name = function(self)
      if L_BattleDataManager:checkPlayerBattle() then
        L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.FormationSetting))
        return
      end
      if L_FormationStore:getIsTrailFormation(L_FormationManager:getCurFormationType()) and not L_WorldManager:getCurModule() == C_EWorldType.Prologue or AzurWorld.DungeonMgr:CheckIsDungeonScene() then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageFormationMain_01"))
        return
      end
      L_UI:open("pageWearPet", {
        heroGuid = self.heroGuid,
        failure_jump = self:GetSourceLuaPageOptions("failure_jump")
      })
    end,
    onClick_petFavor = function(self)
      if not math.isEmpty(self._petGuid) then
        L_PetStore:setCurSelectPetId(self._petGuid)
      end
      L_UI:open("pagePetBox", {
        defaultPetGuid = self._petGuid
      })
    end,
    onClick_heroGrade = function(self)
      if not self:checkCanShowGrade() then
        return
      end
      self.parent:on_BottomFuncSelChange(L_Const.heroModuleType.Grade)
    end
  }
end

function this:checkCanShowGrade()
  if AzurWorld.DungeonMgr:CheckIsDungeonScene() then
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

function this:created(...)
  this.super.created(self, ...)
end

function this:open()
  self.bind.txt_heroGrade = L_WordsTpl:getValue("ui_hero_dec_03")
  self.isLevelUp = false
  L_AudioUtil.playSound("Play_SFX_System_UI_General_Frame_Open")
  self:refreshHeroProperty()
  self._ESyncHeroServerDataHandler = handler(self, self.onEvent_refreshHero)
  AzurWorld.heroMgr:RegisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.onRefreshPet, self, nil, 0)
end

function this:close()
  AzurWorld.heroMgr:UnregisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onRefreshPet)
end

function this:onEvent_refreshHero(enum, varList)
  local hero = varList:GetObject(0)
  if L_HeroStore:getIsPlayLevelAnim() then
    return
  end
  if L_HeroStore:getHeroGuid(hero) ~= self.heroGuid then
    return
  end
  self:refreshHeroProperty()
end

function this:setCommonTop(bool)
  self.parent:setCommonTop(bool)
end

function this:onClickLevelUp()
  if self:isPreviewMode() then
    return
  end
  if self.isLevelUp or C_PageHeroPipelineBridge.IsLoading() or self.parent.canChangeHero and not self.parent:canChangeHero() then
    return
  end
  self.parent:setDownBg(false)
  self.parent:refreshCanChangeHero(false)
  self.isLevelUp = true
  
  local function cb()
    self.modules.toggleModuleBar[self.bind.toggleModuleName]:onOpenExp()
    local tpl_uiTopBar = uiTopBarTpl:getTplByPageName(self.parent.pageName)
    local name = uiTopBarTpl:getBackTxt(tpl_uiTopBar, 2)
    local resource = uiTopBarTpl:getResourceBar(tpl_uiTopBar, 2)
    local tb = L_LuaToCSharpUtil.parseLuaCfgList(resource)
    C_IntegrateMgr.TopBarModule:Lua_SetResourcesByResList(tb)
    self.parent:setCommonTopData(handler(self, self.onExitLevelUp), name)
  end
  
  self:refreshHeroProperty(cb)
end

function this:onExitLevelUp()
  self.parent:setDownBg(true)
  self.parent:refreshCanChangeHero(true)
  self.isLevelUp = false
  
  local function cb()
    local tpl_uiTopBar = uiTopBarTpl:getTplByPageName(self.parent.pageName)
    local resource = uiTopBarTpl:getResourceBar(tpl_uiTopBar)
    local tb = L_LuaToCSharpUtil.parseLuaCfgList(resource)
    C_IntegrateMgr.TopBarModule:Lua_SetResourcesByResList(tb)
  end
  
  local levelUpModule = self.modules.toggleModuleBar[self.bind.toggleModuleName]
  if levelUpModule and levelUpModule.onCloseExpBtn then
    levelUpModule:onCloseExpBtn()
  end
  self:refreshHeroProperty(cb)
end

function this:refreshHeroProperty(cb)
  self.heroGuid = self:getModeController():getSelectGuid()
  self.heroConfigId = self:getModeController():getSelectConfigId()
  local isLevelUp = self:checkIsLevelUp()
  local playAnim = false
  local animName = ""
  if self.bind.toggleModuleName == "heroTotalProperty" and isLevelUp then
    playAnim = true
    animName = "ToLevelUp"
  end
  if self.bind.toggleModuleName == "heroModuleLevelUp" and not isLevelUp then
    playAnim = true
    animName = "ToTotal"
  end
  
  local function animFinish()
    if isLevelUp then
      self.modules.toggleModuleBar[self.bind.toggleModuleName]:refreshHeroProperty()
    else
      self.modules.toggleModuleBar[self.bind.toggleModuleName]:skillListSet()
      self.modules.toggleModuleBar[self.bind.toggleModuleName]:refreshHeroProperty()
    end
  end
  
  if playAnim then
    local curIsLevelUp = self:checkIsLevelUp()
    if curIsLevelUp then
      self.bind.toggleModuleName = "heroModuleLevelUp"
    else
      self.bind.toggleModuleName = "heroTotalProperty"
    end
    self.bindComponents.switchAnimator:SetTrigger(animName)
    if cb then
      cb()
    end
    Timer.once(0.24, function()
      self.bindComponents.toggleModule:HideNonCurrentModules(false)
    end, self)
    animFinish()
    self:initPetInfo()
  else
    if isLevelUp then
      self.bind.toggleModuleName = "heroModuleLevelUp"
    else
      self.bind.toggleModuleName = "heroTotalProperty"
    end
    animFinish()
    self:initPetInfo()
    if cb then
      cb()
    end
  end
end

function this:checkIsLevelUp()
  return self.isLevelUp
end

function this:initPage(params)
  this.super.initPage(self)
  self.isLevelUp = false
  if params == nil then
    params = {hide_pet = false}
  end
  self.hide_pet = params.hide_pet
  self:refreshHeroProperty()
  if params and params.openLevelUp then
    self:onClickLevelUp()
  end
  self:show()
end

function this:setAnimationState(bShow)
  self.bindComponents.switchAnimator:SetBool("Show", bShow)
end

function this:playTotalPreviewAnimation(isMax)
  if self:isPreviewMode() then
    self.modules.toggleModuleBar[self.bind.toggleModuleName]:playTotalPreviewAnimation(isMax)
  end
end

function this:getTimelineState()
  return L_Const.heroTimelineState.Detail
end

function this:lvUpBtnAndAdvanceBtnObj(bool1)
  local isPreview = self:isPreviewMode()
  self.bind.lvUpBtn = bool1 and not isPreview
end

function this:initPetInfo()
  local formationSystemUnlock = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.heroWearPet)
  self.bind.go_pet = not self:checkIsLevelUp() and not self:isPreviewMode() and formationSystemUnlock and not self.hide_pet
  if self.bind.go_pet then
    local hero = L_HeroStore:getHero(self.heroGuid)
    self._petGuid = L_HeroStore:getHeroPetGuid(hero)
    local isEquipped = not math.isEmpty(self._petGuid)
    self.bind.isOn_hasPet = isEquipped
    if isEquipped then
      local pet = L_PetStore:getPetItem(self._petGuid)
      self.modules.module_pixelIcon:setGuid(self._petGuid, true)
      self.bind.txt_petLevel = tostring(pet.lv)
      self.bind.txt_petName = pet.pet_name
      local result = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.petFavor)
      self.bind.go_petFavor = result
      if result then
        self.bind.txt_petFavorLv = tostring(pet:petFavorLv())
      end
    end
  end
end

function this:onRefreshPet()
  self:initPetInfo()
end

function this:playSwitchAnimator(name)
  if self.bindComponents and self.bindComponents.switchAnimator then
    self.bindComponents.switchAnimator:SetTrigger(name)
  end
end

function this:show(options)
  L_HeroManager:curModuleChanged(L_Const.heroModuleType.Property, true)
end

function this:hide(options)
  L_HeroManager:curModuleChanged(L_Const.heroModuleType.Property, false)
end

return this
