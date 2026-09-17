local cls = class("pageEntrustChallenge", G_UIPageBase)
local _dungeonEntrustTypeTpl = L_GameTpl:getDungeonEntrustTypeTpl()
local DUNGEONCOSTNORMAL_RESOURCE_BAR_ITEM_TPL_ID = 411
local DUNGEONCOSTSPECIAL_RESOURCE_BAR_ITEM_TPL_ID = 412
local TOPBAR_REOURCEID = 400
local ModuleStateEnum = {
  [L_Const.EntrustTypeEnum.None] = 0,
  [L_Const.EntrustTypeEnum.AreaEntrust] = 1,
  [L_Const.EntrustTypeEnum.SpecialEntrust] = 2,
  [L_Const.EntrustTypeEnum.TrainTask] = 4,
  [L_Const.EntrustTypeEnum.EntrustAssemble] = 8,
  [L_Const.EntrustTypeEnum.PetDuel] = 16,
  [L_Const.EntrustTypeEnum.MultiCoopEntrust] = 32
}

function cls.bind()
  return {
    module_tabList = {
      moduleName = "pages/entrustTask/moduleEntrustTabList"
    },
    module_currency = {
      moduleName = "modulePages/moduleCurrency"
    },
    moduleDoubleRewardTipItem = {
      moduleName = "pages/gameAct/doubleDrop/moduleDoubleRewardTipItem"
    },
    go_tipsNode = false,
    go_imgNode = false,
    active_tabList = false
  }
end

function cls.methods()
  return {}
end

function cls:preOpen(options)
  cls.super.preOpen(self, options)
  self:registerModule()
  self.timelineControl = nil
end

function cls:registerModule()
  if not self.subModuleMgr then
    self.subModuleMgr = require("ui.manager.ui.uiSubModuleManager").new(self)
  end
  self.subModuleMgr:init()
  self.subModuleMgr:initSubModules(self, ModuleStateEnum[L_Const.EntrustTypeEnum.None])
  self.subModuleMgr:addSubModules(ModuleStateEnum[L_Const.EntrustTypeEnum.AreaEntrust], "moduleEntrustTask", self.bindComponents.transParent)
  self.subModuleMgr:addSubModules(ModuleStateEnum[L_Const.EntrustTypeEnum.TrainTask], "moduleEntrustTrainTask", self.bindComponents.transParent)
  self.subModuleMgr:addSubModules(ModuleStateEnum[L_Const.EntrustTypeEnum.PetDuel], "moduleEntrustBattleTask", self.bindComponents.transParent)
  self.subModuleMgr:addSubModules(ModuleStateEnum[L_Const.EntrustTypeEnum.MultiCoopEntrust], "moduleEntrustMultiCoopTask", self.bindComponents.transParent, {
    jumpTargetLevel = self.options.selectId
  })
end

function cls:open(options)
  self.selectType = options and options.entrustType or L_Const.EntrustTypeEnum.AreaEntrust
  self.timelineControl = options and options.timelineControl
  if options ~= nil and options.isLock then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_target_dungeon_entrust_locked"), 2)
  end
  self:initPage()
  self.options = options or {}
  if L_ReddotManager:haveDailyNew(L_ReddotManager.DotDef.EntrustDoubleReward) then
    L_ReddotManager:clearDailyNew(L_ReddotManager.DotDef.EntrustDoubleReward)
    L_ReddotManager:setDirty(L_ReddotManager.DotDef.EntrustDoubleReward, true)
  end
  L_AudioUtil.playSound("Play_SFX_System_UI_Entrust_Tab_Open")
end

function cls:initPage()
  self:initTabList()
end

function cls:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:checkAndTip(L_SystemConst.enum.entrustTask)
  if not result then
    callback(result)
    return
  end
  local condId = AzurWorld.ConditionMgr:CreateCond({70001}, nil)
  if not AzurWorld.ConditionMgr:CheckCond(condId) then
    local cond = AzurWorld.ConditionMgr:GetCond(condId)
    if cond then
      local str = cond:ShowMsg()
      L_FlyMsgManager:showNormalMsg(str)
    end
    callback(false)
    return
  end
  callback(true)
end

function cls:initTabList()
  local tabList = {}
  local selectIndex = 1
  for index, tpl in ipairs(_dungeonEntrustTypeTpl:getShowData()) do
    table.insert(tabList, _dungeonEntrustTypeTpl:getId(tpl))
    if _dungeonEntrustTypeTpl:getId(tpl) == self.selectType then
      selectIndex = index
    end
  end
  self:switchState()
end

function cls:switchState()
  local function callBack()
    if self.selectType == L_Const.EntrustTypeEnum.MultiCoopEntrust then
      local target = self.subModuleMgr:getSubModule("moduleEntrustMultiCoopTask")
      
      if not target or not target.script then
        return
      end
      if target.script.setTimelineControl then
        target.script:setTimelineControl(self.timelineControl)
      end
    end
    if self.selectType == L_Const.EntrustTypeEnum.AreaEntrust then
      local target = self.subModuleMgr:getSubModule("moduleEntrustTask")
      if not target or not target.script then
        return
      end
      if self.options.selectTab then
        target.script:setSelectTab(self.options.selectTab)
      end
      if self.options.selectId and target.script.setSelectEntrustTask then
        target.script:setSelectEntrustTask(self.options.selectId, true)
      end
    end
    if self.options.selectTab and self.selectType == L_Const.EntrustTypeEnum.TrainTask then
      local target = self.subModuleMgr:getSubModule("moduleEntrustTrainTask")
      if not target or not target.script then
        return
      end
      target.script:setSelectType(self.options.selectTab)
    end
    if self.options.selectId and self.selectType == L_Const.EntrustTypeEnum.PetDuel then
      local target = self.subModuleMgr:getSubModule("moduleEntrustBattleTask")
      if not target or not target.script then
        return
      end
      target.script:setSelect(self.options.selectId)
    end
    L_AudioUtil.playSound("Play_SFX_System_UI_EnTrust_Tab_Open")
  end
  
  self.subModuleMgr:openSubModulesByIndex(ModuleStateEnum[self.selectType], callBack)
  self.bind.go_tipsNode = self.selectType == L_Const.EntrustTypeEnum.TrainTask
  self.bind.go_imgNode = self.selectType ~= L_Const.EntrustTypeEnum.PetDuel
end

function cls:selectTarget(options)
  self.options = options or {}
  self.selectType = self.options.selectType or self.selectType
  self:switchState()
  self:onTopChange()
end

function cls:refreshCurrencyList()
  local tpl = _dungeonEntrustTypeTpl:getTplById(self.selectType)
  if not tpl then
    return
  end
  local tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplById(_dungeonEntrustTypeTpl:getSystemUnLockId(tpl))
  C_IntegrateMgr.TopBarModule:SetResourceVisible(self.selectType == L_Const.EntrustTypeEnum.MultiCoopEntrust or self.selectType == L_Const.EntrustTypeEnum.AreaEntrust)
  if self.selectType == L_Const.EntrustTypeEnum.MultiCoopEntrust then
    C_IntegrateMgr.TopBarModule:Lua_SetResourcesByResList({DUNGEONCOSTSPECIAL_RESOURCE_BAR_ITEM_TPL_ID, DUNGEONCOSTNORMAL_RESOURCE_BAR_ITEM_TPL_ID})
  end
  if self.selectType == L_Const.EntrustTypeEnum.AreaEntrust then
    C_IntegrateMgr.TopBarModule:Lua_SetResourcesByResList({TOPBAR_REOURCEID})
  end
end

function cls:show()
  self.modules.moduleDoubleRewardTipItem:SetHideByEntrusttype(self.selectType)
  self:refreshCurrencyList()
end

function cls:onTopChange()
  if L_UI:checkPageOpen("pageEntrustChallenge") then
    self:refreshCurrencyList()
  end
  self.needCutback = true
end

function cls:hide()
end

function cls:close(options)
  cls.super.close(self, options)
  L_TimerManager:clearTimer(self)
  C_IntegrateMgr.TopBarModule:SetResourceVisible(true)
  C_UISceneManager.SetSceneVisible()
end

function cls:destroy(options)
  self.subModuleMgr:destroyAllSubModules()
end

function cls:check(options, callback)
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.Dungeon, true) then
    callback(false)
    return
  end
  callback(true)
end

function cls:onTopBarRefresh()
  self:onRefreshCallBack()
end

function cls:onRefreshCallBack()
  C_IntegrateMgr.TopBarModule:SetResourceVisible(self.selectType == L_Const.EntrustTypeEnum.MultiCoopEntrust or self.selectType == L_Const.EntrustTypeEnum.AreaEntrust)
  if self.selectType == L_Const.EntrustTypeEnum.MultiCoopEntrust then
    C_IntegrateMgr.TopBarModule:SetResourcesByResList({DUNGEONCOSTSPECIAL_RESOURCE_BAR_ITEM_TPL_ID, DUNGEONCOSTNORMAL_RESOURCE_BAR_ITEM_TPL_ID})
  end
  if self.selectType == L_Const.EntrustTypeEnum.AreaEntrust then
    C_IntegrateMgr.TopBarModule:SetResourcesByResList({TOPBAR_REOURCEID})
  end
  C_IntegrateMgr.TopBarModule:SetTopBarCloseFunc(function()
    L_EntrustStore:call(L_EntrustStore.event.entrustReturnToMain)
    L_UI:close(self.pageName)
  end)
end

function cls:escHandle()
  L_EntrustStore:call(L_EntrustStore.event.entrustReturnToMain)
  L_UI:close(self.pageName)
end

return cls
