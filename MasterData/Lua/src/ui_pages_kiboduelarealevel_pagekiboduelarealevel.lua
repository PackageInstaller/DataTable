local page = class("pageKiboDuelAreaLevel", G_UIPageBase)
local _areaLeveTpl = L_GameTpl:getKiboDuelAreaLevelTpl()
local _areaTypeTpl = L_GameTpl:getKiboDuelAreaTypeTpl()
local _petDuelStore = L_PetDuelStore

function page:ctor(...)
  page.super.ctor(self, ...)
end

function page.bind()
  return {
    moduleExpInfo = {
      moduleName = "pages/kiboDuelAreaLevel/moduleAreaLevelExpInfo"
    },
    moduleUnlockList = {
      moduleName = "pages/kiboDuelAreaLevel/moduleAreaLevelUnlockList"
    },
    moduleRewardList = {
      moduleName = "pages/kiboDuelAreaLevel/moduleAreaLevelRewardList"
    },
    moduleLevelList = {
      moduleName = "pages/kiboDuelAreaLevel/moduleAreaLeveItemlList"
    },
    btnReward = false,
    objNoneState = true,
    txtNode = "",
    btnUnlockLevel = false,
    moduleSkillTips = {
      moduleName = "pages/kiboDuelAreaLevel/moduleArealLevelSkillTips"
    },
    skillTipsLocalPos = nil,
    txtTitle = "",
    imgAspect = false
  }
end

function page.methods()
  return {
    closeBtn = function(self)
      self:onClick_close()
    end,
    rewardBtn = function(self)
      self:onClickRewardBtn()
    end,
    unlockLevelBtn = function(self)
      local tpl = _areaLeveTpl:getTpl(self.areaType, math.max(self.curSelectLevel - 1, 1))
      local taskId = _areaLeveTpl:getTaskId(tpl)
      if taskId and taskId ~= 0 then
        L_SystemBreakManager:jumpTo(L_SystemConst.enum.task, {taskId = taskId})
      end
    end,
    moduleLevelList = {
      onSelectLevelClick = function(self, level)
        self:switchSelectLevel(level)
      end
    }
  }
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  _petDuelStore:listenCallFunc(_petDuelStore.event.refresh_areaInfo, self.onRefreshAreaInfo, self)
  self.areaType = 1
  if options then
    local areaType = options.areaType
    self.areaType = areaType and tonumber(areaType) or 1
    self:initVirtualCamera(options.entity)
    self.npcLight = C_UINpcLight.CreateLight(options.entity.data.transform.gameObject)
  end
  self.maxLevel = _areaLeveTpl:getMaxLevel(self.areaType)
  self.curSelectLevel = self:getJumpNextLevel() or 2
end

function page:open()
  page.super.open(self)
  self:refresh()
  self:refreshRewardReddot()
  self.modules.moduleSkillTips:showModule(false)
  self.modules.moduleUnlockList:setClickCallbackFunc(function(cell, skillId)
    if skillId then
      self.modules.moduleSkillTips:showModule(true, {skillId = skillId})
      self:setSkillTipsPos(cell:getRootTran())
    end
  end)
  L_UI:addListener(L_UI.pageEvent.closed, self.onEvent_closePage, self)
  local areaTypeTpl = _areaTypeTpl:getTplById(self.areaType)
  local areaName = _areaTypeTpl:getName(areaTypeTpl)
  self.bind.txtTitle = L_Lang:get(areaName)
end

function page:setSkillTipsPos(targetTran)
  if not targetTran then
    return
  end
  local targetPos = self.bindComponents.rootTran:InverseTransformPoint(targetTran.position)
  local isPc = L_DeviceTpl:getIsPc()
  local pos = isPc and L_Vector3.new(targetPos.x - 420, targetPos.y, 0) or L_Vector3.new(targetPos.x - 410, targetPos.y, 0)
  self.bind.skillTipsLocalPos = pos
end

function page:onClickRewardBtn()
  _petDuelStore:req_CSProtoKiboDuelGetAreaRearwd(self.areaType, self.curSelectLevel)
end

function page:switchSelectLevel(level)
  self.curSelectLevel = level
  self:refreshModuleExpInfo()
  self:refreshModuleRewardList()
  self:refreshModuleUnlockContentList()
  self:refreshInteractStatus()
  self:refreshRewardReddot()
end

function page:refresh()
  self:refreshModuleExpInfo()
  self:refreshModuleRewardList()
  self:refreshModuleUnlockContentList()
  self:refreshModuleLevelItemList()
  self:refreshInteractStatus()
end

function page:refreshModuleExpInfo()
  local active = self:checkShowLevelInfo(self.areaType, self.curSelectLevel)
  if active then
    self.modules.moduleExpInfo:setAreaLevelData(self.areaType, self.curSelectLevel)
  end
  self.modules.moduleExpInfo:SetActive(active)
  self.bind.imgAspect = not active
  self.bindComponents.layoutGroup.spacing = active and 25 or 22
  L_GameUtil.forceRebuildLayout(self.bindComponents.layoutGroupTran)
end

function page:checkShowLevelInfo(areaType, level)
  local areaInfo = L_PetDuelStore:getAreaInfo(areaType)
  if not areaInfo then
    return false
  end
  local curLevel = areaInfo:getlvl()
  if level ~= curLevel + 1 then
    return false
  end
  return true
end

function page:refreshModuleRewardList()
  self.modules.moduleRewardList:setAreaLevelData(self.areaType, self.curSelectLevel)
end

function page:refreshModuleUnlockContentList()
  self.modules.moduleUnlockList:setAreaLevelData(self.areaType, self.curSelectLevel)
end

function page:refreshModuleLevelItemList()
  self.modules.moduleLevelList:setAreaLevelData(self.areaType, self.curSelectLevel)
end

function page:refreshInteractStatus()
  local status = _petDuelStore:getAreaLevelStatus(self.areaType, self.curSelectLevel)
  local level = _petDuelStore:getAreaLevel(self.areaType)
  self.bind.btnReward = status == L_Const.commonRewardStatus.complete
  self.bind.btnUnlockLevel = false
  self.bind.objNoneState = false
  if status == L_Const.commonRewardStatus.got then
    self.bind.objNoneState = true
    if self.curSelectLevel == self.maxLevel then
      self.bind.txtNode = L_WordsTpl:getValue("ui_home_manage_13")
    else
      self.bind.txtNode = L_WordsTpl:getValue("ui_kiboduel_level_achieved")
    end
  elseif status == L_Const.commonRewardStatus.notComp then
    local tpl = _areaLeveTpl:getTpl(self.areaType, math.max(self.curSelectLevel - 1, 1))
    local taskId = _areaLeveTpl:getTaskId(tpl)
    if taskId and taskId ~= 0 then
      local isFinish = AzurWorld.TaskMgr:IsFinishTask(taskId)
      if not isFinish then
        self.bind.btnUnlockLevel = true
        self.bind.objNoneState = false
      else
        self.bind.objNoneState = true
        self.bind.txtNode = L_WordsTpl:getValue("ui_kiboduel_level_not_achieved")
      end
    elseif self.curSelectLevel == level + 1 then
      self.bind.objNoneState = true
      self.bind.txtNode = L_WordsTpl:getValue("ui_kiboduel_level_not_achieved")
    else
      self.bind.objNoneState = true
      self.bind.txtNode = L_WordsTpl:getValue("ui_kiboduel_level_not_achieved_exlevel")
    end
  end
end

function page:getJumpNextLevel()
  local levels = _petDuelStore:getAreaCompleteLevel(self.areaType)
  if not table.isEmpty(levels) then
    table.sort(levels, function(a, b)
      return a < b
    end)
    return levels[1]
  else
    local level = _petDuelStore:getAreaLevel(self.areaType)
    if level < self.maxLevel then
      return level + 1
    end
  end
end

function page:initVirtualCamera(entity)
  if entity == nil then
    return
  end
  self._npcEntity = entity
  self._npcEntity.data.characterControlProperty:SetLookAtControllerEnable(false)
  C_CameraManager.ActivateTactics(C_ECameraType.NpcAreaLevel, C_CinemachineBlendType.EaseIn, 1000)
  local cameraController = C_CameraManager.GetTactics(C_ECameraType.NpcAreaLevel)
  local areaTypeTpl = _areaTypeTpl:getTplById(self.areaType)
  local param = _areaTypeTpl:getKiboCenterCameraParam(areaTypeTpl)
  cameraController:SetNpcAreaLevelData(entity.entity:GetTransform(), 0, L_Vector3.new(param[1], param[2], param[3]), param[4], param[5])
  L_PlayerManager:showOrHideAllPlayer(false)
  AzurWorld.HUDMgr:SetAllVisible(false, "pageKiboDuelAreaLevel")
  AzurWorldInstance:SetNodeVisible(L_Const.WorldNode.PLAYERPETNODE, false, L_Const.worldNodeHideType.LuaUIControlHide)
  self._initVirtualCamera = true
end

function page:unloadVirtualCamera()
  if not self._initVirtualCamera then
    return
  end
  C_CameraManager.PlaySetBlend(C_CinemachineBlendType.EaseInOut, 1000)
  C_CameraManager.DeactivateTactics(C_ECameraType.NpcAreaLevel)
  L_PlayerManager:showOrHideAllPlayer(true)
  AzurWorld.HUDMgr:SetAllVisible(true, "pageKiboDuelAreaLevel")
  AzurWorldInstance:SetNodeVisible(L_Const.WorldNode.PLAYERPETNODE, true, L_Const.worldNodeHideType.LuaUIControlHide)
  if self._npcEntity ~= nil then
    self._npcEntity.data.characterControlProperty:SetLookAtControllerEnable(true)
  end
end

function page:onRefreshAreaInfo()
  self:refresh()
end

function page:close(options)
  page.super.close(self, options)
  _petDuelStore:unListenCallFunc(_petDuelStore.event.refresh_areaInfo, self.onRefreshAreaInfo, self)
  L_UI:removeListener(L_UI.pageEvent.closed, self.onEvent_closePage, self)
  self:unloadVirtualCamera()
  if self.npcLight then
    self.npcLight:Release()
    self.npcLight = nil
  end
end

function page:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.kiboDuelAreaLevel)
  callback(result)
end

function page:refreshRewardReddot()
end

function page:onEvent_closePage(pageName)
  if pageName == "pageReward" then
    local nextLevel = self:getJumpNextLevel()
    if nextLevel then
      self:switchSelectLevel(nextLevel)
      self.modules.moduleLevelList:setSelect(nextLevel)
    end
  end
end

function page:escHandle()
  self:onClick_close()
end

function page:onClick_close()
  self.modules.moduleSkillTips:showModule(false)
  self.bindComponents.anim:Play("anim_PetArea_out")
  self:newOrResetTimer(self.pageName, function()
    L_UI:close(self.pageName)
  end, 0.2)
end

return page
