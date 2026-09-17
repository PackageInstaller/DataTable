local this = class("pageMainCity", G_UIPageBase)

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:registerModule()
  if not self.subModuleMgr then
    self.subModuleMgr = require("ui.manager.ui.uiSubModuleManager").new(self)
  end
  self.subModuleMgr:init()
  self.subModuleMgr:initSubModules(self, L_SubModuleConfig.GameProcedure.None)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.All, L_SubModuleConfig.ModuleCfg.moduleMiniMap.uiName, self.bindComponents.transMiniMap)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.All, L_SubModuleConfig.ModuleCfg.moduleMainCityBtnFunc.uiName, self.bindComponents.transGeneral)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.HomeScene, L_SubModuleConfig.ModuleCfg.moduleMainCityHome.uiName, self.bindComponents.transHome, self.pageName)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldIdle | L_SubModuleConfig.GameProcedure.Meeting | L_SubModuleConfig.GameProcedure.BigWorldBattle | L_SubModuleConfig.GameProcedure.Dungeon | L_SubModuleConfig.GameProcedure.Interim, L_SubModuleConfig.ModuleCfg.moduleHero.uiName, self.bindComponents.transHero)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldIdle | L_SubModuleConfig.GameProcedure.Meeting | L_SubModuleConfig.GameProcedure.BigWorldBattle | L_SubModuleConfig.GameProcedure.HomeScene | L_SubModuleConfig.GameProcedure.Interim, L_SubModuleConfig.ModuleCfg.moduleTask.uiName, self.bindComponents.transTask)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.All, L_SubModuleConfig.ModuleCfg.moduleMount.uiName, self.bindComponents.transMount)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldIdle | L_SubModuleConfig.GameProcedure.Meeting | L_SubModuleConfig.GameProcedure.HomeScene | L_SubModuleConfig.GameProcedure.BigWorldBattle | L_SubModuleConfig.GameProcedure.Dungeon | L_SubModuleConfig.GameProcedure.Interim, L_SubModuleConfig.ModuleCfg.moduleScreenGuide.uiName, self.bindComponents.transScreenGuide)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldIdle | L_SubModuleConfig.GameProcedure.Meeting | L_SubModuleConfig.GameProcedure.HomeScene | L_SubModuleConfig.GameProcedure.Dungeon | L_SubModuleConfig.GameProcedure.Interim, L_SubModuleConfig.ModuleCfg.moduleSceneBorderTransfer.uiName, self.bindComponents.transScreenBorderTransfer)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldIdle | L_SubModuleConfig.GameProcedure.Meeting | L_SubModuleConfig.GameProcedure.HomeScene | L_SubModuleConfig.GameProcedure.Dungeon | L_SubModuleConfig.GameProcedure.Interim, L_SubModuleConfig.ModuleCfg.moduleDungeonCountdown.uiName, self.bindComponents.transDungeonCountDown)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldIdle | L_SubModuleConfig.GameProcedure.Meeting | L_SubModuleConfig.GameProcedure.Dungeon | L_SubModuleConfig.GameProcedure.Interim, L_SubModuleConfig.ModuleCfg.moduleStarHealing.uiName, self.bindComponents.transStarHealing)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.All, L_SubModuleConfig.ModuleCfg.moduleTutorial.uiName, self.bindComponents.transTutorial)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldBattle, L_SubModuleConfig.ModuleCfg.moduleBattleEnergy.uiName, self.bindComponents.transBattleEnergy)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldBattle, L_SubModuleConfig.ModuleCfg.moduleBattleLimitTime.uiName, self.bindComponents.transBattleLimitTime)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldBattle, L_SubModuleConfig.ModuleCfg.moduleLeaveWall.uiName, self.bindComponents.transLeaveWall)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldBattle, L_SubModuleConfig.ModuleCfg.moduleBattleCombo.uiName, self.bindComponents.transBattleCombo)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.All, L_SubModuleConfig.ModuleCfg.moduleBattleDialog.uiName, self.bindComponents.transBattleDialog)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldBattle, L_SubModuleConfig.ModuleCfg.moduleBattleEffect.uiName, self.bindComponents.transBattleEffect)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldBattle, L_SubModuleConfig.ModuleCfg.moduleBossHpList.uiName, self.bindComponents.transBossHpList)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldIdle | L_SubModuleConfig.GameProcedure.Meeting | L_SubModuleConfig.GameProcedure.BigWorldBattle | L_SubModuleConfig.GameProcedure.Dungeon | L_SubModuleConfig.GameProcedure.Interim, L_SubModuleConfig.ModuleCfg.modulePlayerHp.uiName, self.bindComponents.transPlayerHp)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldIdle | L_SubModuleConfig.GameProcedure.Meeting | L_SubModuleConfig.GameProcedure.BigWorldBattle | L_SubModuleConfig.GameProcedure.Dungeon | L_SubModuleConfig.GameProcedure.Interim, L_SubModuleConfig.ModuleCfg.moduleSkillControlPc.uiName, self.bindComponents.transSkillControl)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldIdle | L_SubModuleConfig.GameProcedure.Meeting | L_SubModuleConfig.GameProcedure.BigWorldBattle | L_SubModuleConfig.GameProcedure.Dungeon, L_SubModuleConfig.ModuleCfg.moduleChallenge.uiName, self.bindComponents.transChallenge)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.All, L_SubModuleConfig.ModuleCfg.modulePetHideShow.uiName, self.bindComponents.transPetHideShow)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.All, L_SubModuleConfig.ModuleCfg.moduleTransformationSystemSkill.uiName, self.bindComponents.trans_moduleTransformationSystemSkill, self)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.All, L_SubModuleConfig.ModuleCfg.moduleScanning.uiName, self.bindComponents.transScanning)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.All, L_SubModuleConfig.ModuleCfg.moduleMainCityChat.uiName, self.bindComponents.transChat)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.All, L_SubModuleConfig.ModuleCfg.moduleMovementBlockNew.uiName, self.bindComponents.transMovementBlock)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldBattle, L_SubModuleConfig.ModuleCfg.moduleIndicator.uiName, self.bindComponents.transIndicator)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.All, L_SubModuleConfig.ModuleCfg.moduleBossAreaEnter.uiName, self.bindComponents.transBattleLimitTime)
  self.subModuleMgr:addSubModules(L_SubModuleConfig.GameProcedure.BigWorldIdle | L_SubModuleConfig.GameProcedure.BigWorldBattle | L_SubModuleConfig.GameProcedure.Meeting, L_SubModuleConfig.ModuleCfg.moduleMythicalPet.uiName, self.bindComponents.transTask)
end

function this:switchState()
  local curModule = L_WorldManager:getCurModule()
  if curModule == L_Const.worldModule.home then
    self.subModuleMgr:openSubModulesByIndex(L_SubModuleConfig.GameProcedure.HomeScene)
    return
  end
  if L_BattleDataManager:checkPlayerBattle() then
    self.subModuleMgr:openSubModulesByIndex(L_SubModuleConfig.GameProcedure.BigWorldBattle)
    return
  end
  if curModule == L_Const.worldModule.main or curModule == L_Const.worldModule.whiteBox or curModule == L_Const.worldModule.prologue or curModule == L_Const.worldModule.multipleWorld or curModule == L_Const.worldModule.photo then
    self.subModuleMgr:openSubModulesByIndex(L_SubModuleConfig.GameProcedure.BigWorldIdle | L_SubModuleConfig.GameProcedure.Meeting)
    return
  end
  if curModule == L_Const.worldModule.dungeon then
    self.subModuleMgr:openSubModulesByIndex(L_SubModuleConfig.GameProcedure.Dungeon)
    return
  end
  if curModule == L_Const.worldModule.interim then
    self.subModuleMgr:openSubModulesByIndex(L_SubModuleConfig.GameProcedure.Interim)
    return
  end
  if curModule == L_Const.worldModule.meeting then
    self.subModuleMgr:openSubModulesByIndex(L_SubModuleConfig.GameProcedure.Meeting)
    return
  end
  self.subModuleMgr:openSubModulesByIndex(L_SubModuleConfig.GameProcedure.BigWorldIdle | L_SubModuleConfig.GameProcedure.Meeting)
  errorf("(清联系liubin添加玩法枚举)主界面在不知道什么module下打开了 module = " .. tostring(curModule))
end

function this:preOpen(options)
  self._pageReady = false
  self:registerModule()
end

function this:open(options)
  self:registerEvents()
  self:switchState()
end

function this:show()
  self._pageReady = true
  self.subModuleMgr:show({
    parentPageName = self.pageName
  })
  self:onEvent_refreshPageMainLeftBottomLayout()
  L_ShortCutManager:registerPageMainShortCut()
end

function this:update()
  if not self._pageReady then
    return
  end
end

function this:onEvent_switchSceneEnd()
  self:switchState()
end

function this:onEvent_fightStateChange()
  self:switchState()
end

function this:onEvent_refreshPageMainLeftBottomLayout()
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.module_mount)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.modulePetHideShow)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.transScanning)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.LeftBottomLayout)
end

function this:registerEvents()
  self._onCutWorldComplete = handler(self, self.onEvent_switchSceneEnd)
  C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  L_BattleDataManager:addListener(L_BattleDataManager.event.playerFightStateChange, self.onEvent_fightStateChange, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.refreshPageMainLeftBottomLayout, self.onEvent_refreshPageMainLeftBottomLayout, self)
end

function this:unRegisterEvents()
  C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.playerFightStateChange, self.onEvent_fightStateChange, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.refreshPageMainLeftBottomLayout, self.onEvent_refreshPageMainLeftBottomLayout, self)
end

function this:escHandle()
  if not AzurWorld.DungeonMgr:CheckIsDungeonScene() then
    return
  end
  AzurWorld.DungeonMgr:ExitDungeon(true)
end

function this:hide()
  self._pageReady = false
  self.subModuleMgr:hide()
end

function this:close(options)
  self:unRegisterEvents()
  self.subModuleMgr:closeAllSubModules()
  this.super.close(self, options)
end

function this:destroy(options)
  self.subModuleMgr:destroyAllSubModules()
end

return this
