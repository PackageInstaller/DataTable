local cls = class("pageFormations", G_UIPageBase)
local _dungeonEntrustTypeTpl = L_GameTpl:getDungeonEntrustTypeTpl()
local FormationTypeToTabIdEnum = {
  [L_FormationConst.FormationType.world] = 1,
  [L_FormationConst.FormationType.kiBoDuel] = 2
}
local FormationTypeToPageNameEnum = {
  [L_FormationConst.FormationType.world] = "pageFormationMain",
  [L_FormationConst.FormationType.kiBoDuel] = "pagePetDuelMain"
}
local FormationTypeEnum = {
  L_FormationConst.FormationType.world,
  L_FormationConst.FormationType.kiBoDuel
}

function cls.bind()
  return {
    moduleCommonTop = {
      moduleName = "pages/common/modules/moduleCommonTab"
    },
    active_tabList = true
  }
end

function cls.methods()
  return {}
end

function cls:check(options, callback)
  if AzurWorld.DungeonMgr:CheckIsInTeaching() then
    callback(false)
    return
  end
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.Formation, true) then
    callback(false)
    return
  end
  if L_PlayerManager:inKiBoTransformMainControl() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_transform_02"))
    callback(false)
    return
  end
  if L_FormationStore:getIsTrailFormation(L_FormationManager:getCurFormationType()) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageFormationMain_01"))
    callback(false)
    return
  end
  if (not options or not options.ignoreProxyType) and AzurWorld.DungeonMgr:CheckIsDungeonScene() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageFormationMain_01"))
    callback(false)
    return
  end
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.FormationSetting))
    callback(false)
    return
  end
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.formation)
  if not L_FormationManager:checkCanChangeFormation() then
    callback(false)
    return
  end
  callback(result)
end

function cls:created(obj, config, binderData)
  cls.super.created(self, obj, config, binderData)
end

function cls:reCreated(obj, options)
end

function cls:preOpen(options)
  cls.super.preOpen(self, options)
  self.dontBack2RootWhenClose = options and options.dontBack2RootWhenClose or false
  self.bind.active_tabList = true
  self.showOrHideHandler = handler(self, self.showContent)
  L_FormationManager:addListener(L_FormationManager.event.showFormations, self.showOrHideHandler)
end

function cls:showContent(isShow)
  if self.isBind then
    C_UIMgr.ShowOrHide(self.pageName, isShow)
  end
end

function cls:escHandle()
  L_UI:close(self.pageName)
end

function cls:open(options)
  self.selectFormation = L_FormationConst.FormationType.world
  self.onReconnectedHandler = self.onReconnectedHandler or handler(self, self.onReconnected)
  L_Net:RegisterGameConnectEvent(C_EGameConnectStatus.FullReconnected, self.onReconnectedHandler)
  self:initPage()
end

function cls:initPage()
  self.enableSwitch = false
  self:initTabList()
end

function cls:initTabList()
  local tabList = {}
  local selectIndex = 1
  table.insert(tabList, {
    id = FormationTypeToTabIdEnum[L_FormationConst.FormationType.world],
    name = L_WordsTpl:getValue("residual_code_pageformations_01")
  })
  table.insert(tabList, {
    id = FormationTypeToTabIdEnum[L_FormationConst.FormationType.kiBoDuel],
    name = L_WordsTpl:getValue("residual_code_pageformations_02")
  })
  
  local function callback(tabId)
    if tabId < 1 then
      return
    end
    if not self.enableSwitch then
      return
    end
    self:switchFormation(FormationTypeEnum[tabId])
  end
  
  self.modules.moduleCommonTop:initData(tabList, callback, selectIndex)
  self.enableSwitch = true
  self.modules.moduleCommonTop:setWillSelectTab(function(tabId)
    if tabId == FormationTypeToTabIdEnum[L_FormationConst.FormationType.world] and self.selectFormation == L_FormationConst.FormationType.kiBoDuel then
      if C_IntegrateMgr.SystemUnlockModule:CheckBanSystemAndTip(L_SystemConst.enum.formation) then
        return false
      end
      local kiboArenaFormationPage = L_UI:getPage("pagePetDuelMain")
      if kiboArenaFormationPage ~= nil then
        return kiboArenaFormationPage.cls:closeCheck()
      end
    end
    return true
  end)
end

function cls:switchFormation(formationTpye)
  if formationTpye == self.selectFormation then
    return
  else
    self.selectFormation = formationTpye
  end
  C_UIMgr.OpenCutin(102, function()
    local function closeCallBack()
      self:setTopTabListShow(false)
      
      L_UI:close(self.pageName)
    end
    
    local function setShowCallBack(isShow)
      if self.isBind then
        C_UIMgr.ShowOrHide(self.pageName, isShow)
      end
    end
    
    local function setSelectTabIdCallBack(type)
      self.modules.moduleCommonTop:setSelectTabId(FormationTypeToTabIdEnum[type])
    end
    
    L_UI:open(FormationTypeToPageNameEnum[formationTpye], {
      isSubFormation = true,
      callback = closeCallBack,
      setShowCallBack = setShowCallBack,
      setSelectTabIdCallBack = setSelectTabIdCallBack,
      dontBack2RootWhenClose = self.dontBack2RootWhenClose
    })
  end)
end

function cls:setTopTabListShow(isShow)
  if isShow then
    self.modules.moduleCommonTop:customShow()
  else
    self.modules.moduleCommonTop:customHide()
  end
end

function cls:onReconnected()
  if self.isBind then
    L_UI:close(self.pageName)
  end
end

function cls:onClosePage()
  self.enableSwitch = false
  L_UI:close(FormationTypeToPageNameEnum[self.selectFormation])
  L_UI:close(self.pageName)
  L_UI:backToRoot()
end

function cls:close(options)
  L_Net:UnregisterGameConnectEvent(C_EGameConnectStatus.FullReconnected, self.onReconnectedHandler)
  L_FlyMsgManager:closeUILoading(true)
  for _, page in pairs(FormationTypeToPageNameEnum) do
    L_UI:close(page)
  end
  if self.showOrHideHandler then
    L_FormationManager:removeListener(L_FormationManager.event.showFormations, self.showOrHideHandler)
    self.showOrHideHandler = nil
  end
end

return cls
