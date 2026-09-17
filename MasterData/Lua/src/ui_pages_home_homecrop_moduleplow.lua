local this = class("modulePlow", G_UIModuleBase)
local _homeBuildingNumTpl = L_GameTpl:getHomeBuildingNumTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _commonConditionTpl = L_GameTpl:getCommonConditionTpl()
local EOperateModel = {
  NONE = 1,
  PLANT = 2,
  RETURN_LAND = 3
}

function this.bind()
  return {
    active_pc = true,
    label_plowNum = "",
    active_label_plowNum = true,
    active_self = false,
    active_plow = true,
    active_retireFarmLand = false,
    active_phone = false,
    active_btnPlow = true,
    txt_plowNum = "",
    active_btnRetireFarmLand = false
  }
end

function this.methods()
  return {
    onClick_pc_plow = function(self)
      self:onPressKeyCodeE()
    end,
    onClick_pc_retireFarmLand = function(self)
      self:onPressKeyCodeR()
    end,
    onClick_Mobile_plow = function(self)
      self:onPressKeyCodeE()
    end,
    onClick_Mobile_retireFarmLand = function(self)
      self:onPressKeyCodeR()
    end
  }
end

function this:open(...)
  this.super.open(self, ...)
  self:onCurrInteractBuildGuidChanged()
  self.homeBuildingTplOfPlow = _homeBuildingTpl:getTplById(L_HomeConst.HomeBuildIdOfPlow)
  self.homeBuildingGroupIdOfPlow = _homeBuildingTpl:getGroupId(self.homeBuildingTplOfPlow)
  self.csHomeStore = AzurWorld.HomeMgr:GetHomeStore()
  if L_DeviceTpl:getIsPc() then
    L_ShortCutManager:addShortKeyFlag(self, "E", L_Const.AnchorType.Bottom, self.bindComponents.rectPlow, L_Vector3.new(0, -10))
    L_ShortCutManager:addShortKeyFlag(self, "R", L_Const.AnchorType.Bottom, self.bindComponents.rectRetireFarmLand, L_Vector3.new(0, -10))
    L_ShortCutManager:addListener(L_ShortCutConst.event.KeyCodeE, self.onPressKeyCodeE, self)
    L_ShortCutManager:addListener(L_ShortCutConst.event.KeyCodeR, self.onPressKeyCodeR, self)
  end
  self.onHomeBuildSyncHandler = handler(self, self.onHomeBuildSync)
  self.csHomeStore:RegisterEvent(C_EHomeStoreEvent.HomeBuildSync, self.onHomeBuildSyncHandler)
  self:registerConditionsOfUnlockMaxPlowBuildNum()
  L_HomeManager:addListener(L_HomeManager.event.triggerBuilding, self.onCurrInteractBuildGuidChanged, self)
  self:onCurrInteractBuildGuidChanged()
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "modulePlow.update")
  self:onRefreshInfo(true)
end

function this:onRefreshInfo(initState)
  self:onRefreshPcInfo(initState)
  self:onRefreshPhoneInfo(initState)
end

function this:onRefreshPcInfo(initState)
  if not L_DeviceTpl:getIsPc() then
    return
  end
  if initState then
    self.bind.active_pc = true
    self.bind.active_phone = false
  end
  local curMaxCanBuildNum = C_DataUtil.GetBuildingCount(self.homeBuildingGroupIdOfPlow)
  self.curMaxCanBuildNum = curMaxCanBuildNum
  local buildNumOfPlow = self.csHomeStore:GetBuildNumOfPlow()
  if curMaxCanBuildNum == buildNumOfPlow then
    self.bind.label_plowNum = L_GameUtil.fillColor(string.format("%d/%d", buildNumOfPlow, curMaxCanBuildNum), L_Const.colorHtml.red003)
    return
  end
  self.bind.label_plowNum = string.format("%d/%d", buildNumOfPlow, curMaxCanBuildNum)
end

function this:onRefreshPhoneInfo(initState)
  if L_DeviceTpl:getIsPc() then
    return
  end
  if initState then
    self.bind.active_pc = false
    self.bind.active_phone = true
  end
  local curMaxCanBuildNum = C_DataUtil.GetBuildingCount(self.homeBuildingGroupIdOfPlow)
  self.curMaxCanBuildNum = curMaxCanBuildNum
  local buildNumOfPlow = self.csHomeStore:GetBuildNumOfPlow()
  if curMaxCanBuildNum == buildNumOfPlow then
    self.bind.txt_plowNum = L_GameUtil.fillColor(string.format("%d/%d", buildNumOfPlow, curMaxCanBuildNum), L_Const.colorHtml.red003)
    return
  end
  self.bind.txt_plowNum = string.format("%d/%d", buildNumOfPlow, curMaxCanBuildNum)
end

function this:update()
  local oldActiveSelf = self.bind.active_self
  local active
  local curHomeMainMode = AzurWorld.HomeMgr.curHomeMainMode:GetHashCode()
  if curHomeMainMode == L_HomeConst.homeMainMode.CROP or curHomeMainMode == L_HomeConst.homeMainMode.BUILD then
    active = true
  else
    active = false
  end
  if active == true and self.homeBuildingGroupIdOfPlow then
    local curMaxCanBuildNum = self.curMaxCanBuildNum
    active = 0 < curMaxCanBuildNum and true or false
  end
  if oldActiveSelf ~= self.bind.active_self then
    self.bind.active_self = active
    L_BattleDataManager:sendEvent(L_BattleDataManager.event.refreshPageMainLeftBottomLayout)
  end
end

function this:close(...)
  this.super.close(self, ...)
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
  self.csHomeStore:UnregisterEvent(C_EHomeStoreEvent.HomeBuildSync, self.onHomeBuildSyncHandler)
  self:unregisterConditionsOfUnlockMaxPlowBuildNum()
  L_HomeManager:removeListener(L_HomeManager.event.triggerBuilding, self.onCurrInteractBuildGuidChanged)
  if L_DeviceTpl:getIsPc() then
    L_ShortCutManager:clearShortKeyFlag(self)
    L_ShortCutManager:removeListener(L_ShortCutConst.event.KeyCodeE, self.onPressKeyCodeE)
    L_ShortCutManager:removeListener(L_ShortCutConst.event.KeyCodeR, self.onPressKeyCodeR)
  end
  self._operateModel = EOperateModel.NONE
end

function this:hide()
  self:hideModules()
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
  L_BattleDataManager:sendEvent(L_BattleDataManager.event.refreshPageMainLeftBottomLayout)
end

function this:registerConditionsOfUnlockMaxPlowBuildNum()
  self.conditionNodeList = {}
  for _, configId in pairs(_homeBuildingNumTpl:getConfigIdListByBuildingGroupId(self.homeBuildingGroupIdOfPlow)) do
    local homeBuildingNumTpl = _homeBuildingNumTpl:getTplById(configId)
    local unlockConditionGroup = _homeBuildingNumTpl:getUnlockConditionGroup(homeBuildingNumTpl)
    local conditionNode = L_ConditionManager:registGroup("modulePlow", unlockConditionGroup, self.onConditionGroupNodeStateChanged, self)
    if conditionNode ~= nil then
      table.insert(self.conditionNodeList, conditionNode)
    end
  end
end

function this:unregisterConditionsOfUnlockMaxPlowBuildNum()
  for _, conditionNode in pairs(self.conditionNodeList) do
    L_ConditionManager:unRegist(conditionNode, "modulePlow")
  end
end

function this:tryInvokeRetireFarmland()
  local buildingEntity = AzurWorld.HomeMgr:GetHomeBuild(AzurWorld.HomeMgr:GetCurrentInteractBuildGuid())
  local C_homeBuildData = buildingEntity:GetStoreData()
  local C_homeBuildCropData = C_homeBuildData.crop
  local homeCropState = C_homeBuildCropData:GetStateInt()
  if homeCropState ~= L_HomeConst.HomeCropState.NONE then
    L_GameUtil.showCommonTip({
      txtContent = L_Lang:get(L_WordsTpl:getValue("notice_home_hoe_reset_confirm")),
      confirmCallback = function()
        AzurWorld.HomeMgr:TryInvokeRetireFarmland()
      end
    })
  else
    AzurWorld.HomeMgr:TryInvokeRetireFarmland()
  end
end

function this:tryInvokePlow()
  local curMaxCanBuildNum = C_DataUtil.GetBuildingCount(self.homeBuildingGroupIdOfPlow)
  local buildNumOfPlow = self.csHomeStore:GetBuildNumOfPlow()
  if curMaxCanBuildNum > buildNumOfPlow then
    L_UI:open("PageHomeCropEditor")
  else
    local hasImproveSpace = false
    local targetConditionNode
    for _, conditionNode in pairs(self.conditionNodeList) do
      if not conditionNode:isComplete() then
        hasImproveSpace = true
        targetConditionNode = conditionNode
        break
      end
    end
    if hasImproveSpace then
      local targetCondition = targetConditionNode:getCondition()
      local commonConditionConfigId = targetCondition[1]
      local conditionParam = targetCondition[2]
      local commonConditionTpl = _commonConditionTpl:getTplById(commonConditionConfigId)
      local conditionDescShowKey = _commonConditionTpl:getDescShowKey(commonConditionTpl)
      local conditionNodeCls = L_ConditionManager:getCls(commonConditionConfigId)
      local conditionDescShowKeyWithConditionParam = conditionNodeCls.descFunc and conditionNodeCls.descFunc(conditionDescShowKey, targetCondition) or conditionDescShowKey .. tostring(conditionParam)
      L_FlyMsgManager:showNormalMsgByKey("notice_home_hoe_nextlimit", {
        [0] = conditionDescShowKeyWithConditionParam
      })
    else
      L_FlyMsgManager:showNormalMsg(L_Lang:get(L_WordsTpl:getValue("notice_home_hoe_reachlimit")))
    end
  end
end

function this:onPressKeyCodeE()
  if self._operateModel == EOperateModel.PLANT then
    self:tryInvokePlow()
  end
end

function this:onPressKeyCodeR()
  L_UI:open("PageHomeCropEditor")
end

function this:onCurrInteractBuildGuidChanged()
  local currInteractBuildGuid = L_HomeManager:getCurrInteractId()
  if currInteractBuildGuid ~= 0 then
    local baseHomeBuild = AzurWorld.HomeMgr:GetHomeBuild(currInteractBuildGuid)
    if L_CommonUtil.isValid(baseHomeBuild) then
      local homeBuildId = baseHomeBuild:GetHomeBuildId()
      if homeBuildId == L_HomeConst.HomeBuildIdOfPlow then
        self.bind.active_plow = false
        self.bind.active_label_plowNum = false
        self.bind.active_btnPlow = false
        if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.retireFarmLand) then
          self.bind.active_retireFarmLand = true
          self.bind.active_btnRetireFarmLand = true
          self._operateModel = EOperateModel.RETURN_LAND
        else
          self._operateModel = EOperateModel.NONE
          self.bind.active_retireFarmLand = false
          self.bind.active_btnRetireFarmLand = false
        end
        return
      end
    end
  end
  self.bind.active_plow = true
  self.bind.active_label_plowNum = true
  self.bind.active_retireFarmLand = false
  self.bind.active_btnPlow = true
  self.bind.active_btnRetireFarmLand = false
  self._operateModel = EOperateModel.PLANT
end

function this:onHomeBuildSync()
  self:onRefreshInfo()
end

function this:onConditionGroupNodeStateChanged()
  self:onRefreshInfo()
end

function this:refreshLabelPlowNum()
  local curMaxCanBuildNum = C_DataUtil.GetBuildingCount(self.homeBuildingGroupIdOfPlow)
  self.curMaxCanBuildNum = curMaxCanBuildNum
  local buildNumOfPlow = self.csHomeStore:GetBuildNumOfPlow()
  if curMaxCanBuildNum == buildNumOfPlow then
    self.bind.label_plowNum = L_GameUtil.fillColor(string.format("%d/%d", buildNumOfPlow, curMaxCanBuildNum), L_Const.colorHtml.red003)
    self.bind.txt_plowNum = L_GameUtil.fillColor(string.format("%d/%d", buildNumOfPlow, curMaxCanBuildNum), L_Const.colorHtml.red003)
    return
  end
  self.bind.label_plowNum = string.format("%d/%d", buildNumOfPlow, curMaxCanBuildNum)
  self.bind.txt_plowNum = string.format("%d/%d", buildNumOfPlow, curMaxCanBuildNum)
end

return this
