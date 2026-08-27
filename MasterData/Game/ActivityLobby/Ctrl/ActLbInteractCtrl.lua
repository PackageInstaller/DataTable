local ActLbInteractCtrl = {}
local base = require("Game.ActivityLobby.Ctrl.ActLobbyCtrlBase")
local ActLbInteractCtrl = class("ActLbInteractCtrl", base)
local LbInteractData = require("Game.ActivityLobby.Data.LbInteractData")
local LbIntrctActionData = require("Game.ActivityLobby.Data.LbIntrctActionData")
local ActivityMap = require("Game.ActivityLobby.Activity.ActivityMap")
local ActInteractCommon = require("Game.ActivityLobby.Activity.Common.ActInteractCommon")
local ActLbEnum = require("Game.ActivityLobby.ActLbEnum")
local LbIntrctEntitys = {
  [ActLbEnum.eActLbEntityType.Normal] = require("Game.ActivityLobby.Entity.Interact.LbIntrctNormalEntity"),
  [ActLbEnum.eActLbEntityType.Hero] = require("Game.ActivityLobby.Entity.Interact.LbIntrctHeroEntity")
}

function ActLbInteractCtrl:ctor(actLbCtrl)
end

function ActLbInteractCtrl:OnActLbSceneEnter(bind)
  base.OnActLbSceneEnter(self, bind)
  self:_LoadCfg()
  self._interactDataDic = {}
  self._interactEntityDic = {}
  self._allEntityDic = {}
  self._normalEntityDic = {}
  self._heroEntityDic = {}
  self._intrctEntGoDic = {}
  self._intrctRangeGoDic = {}
  self._curIntrctEntDic = {}
  self._curActionList = {}
  self._quickEntranceActionList = {}
  local lobbyId = self.actLbCtrl:GetActLobbyId()
  local interactObjCfgs = ConfigData.activity_lobby_interact_obj[lobbyId]
  if interactObjCfgs == nil then
    error("Cant get activity_lobby_interact_obj, actId:" .. tostring(lobbyId))
    return
  end
  for objId, intrctObjCfg in pairs(interactObjCfgs) do
    local intrctData = LbInteractData.New(intrctObjCfg, self._eActIntrct)
    self._interactDataDic[objId] = intrctData
    self:_NewIntrctEntity(intrctData)
    self:SetLbInteractObjShow(objId, true)
  end
  table.sort(self._quickEntranceActionList, function(a, b)
    return a:GetLbIntrctActionId() < b:GetLbIntrctActionId()
  end)
  UIManager:ShowWindowAsync(UIWindowTypeID.ActLbFollowInfo, function(win)
    if win == nil then
      return
    end
    local actLbCfg = self.actLbCtrl:GetActLbCfg()
    local enttDic = {}
    for interactData, entt in pairs(self._interactEntityDic) do
      if not interactData:IsLbActIntrctObjHideHeadUI() and #interactData:GetLbIntrctObjActions() > 0 then
        enttDic[interactData:GetLbIntrctObjId()] = entt
      end
    end
    win:InitActLbFollowInfo(actLbCfg.obj_ui, enttDic)
  end)
  if self._eActIntrct.OnActLbSceneLoadedFunc ~= nil then
    self._eActIntrct.OnActLbSceneLoadedFunc(self.actLbCtrl)
  end
end

function ActLbInteractCtrl:_NewIntrctEntity(intrctData)
  local objType = intrctData:GetLbIntrctObjType()
  local entityClass = LbIntrctEntitys[objType]
  if entityClass == nil then
    error("Cant get LbIntrctEntitys, objType:" .. tostring(objType))
    return
  end
  local entity = entityClass.New(intrctData)
  local lobbyId = self.actLbCtrl:GetActLobbyId()
  local actionIdList = intrctData:GetLbIntrctObjActionIdList()
  local actionList = {}
  local showQuickEntrance = intrctData:IsLbIntrctObjShowQuickEntrance()
  for k, actionId in ipairs(actionIdList) do
    local actionCfg = ConfigData.activity_lobby_interact_action[lobbyId][actionId]
    local actionData = LbIntrctActionData.New()
    local actionFunc = self:GetActLbIntrctActionFunc(actionId)
    actionData:InitLbIntrctAction(actionCfg, entity, actionFunc, self._eActIntrct)
    table.insert(actionList, actionData)
    if showQuickEntrance then
      table.insert(self._quickEntranceActionList, actionData)
    end
  end
  intrctData:SetLbIntrctObjActions(actionList)
  entity:InitLbInteractEntityGo()
  self._interactEntityDic[intrctData] = entity
  if IsNull(entity.gameObject) then
    return
  end
  self._intrctEntGoDic[entity.gameObject] = entity
  local intrctRangeGo = entity:GetLbIntrctEntRangeGo()
  if not IsNull(intrctRangeGo) then
    self._intrctRangeGoDic[intrctRangeGo] = entity
    self.actLbCtrl.actLbCamCtrl:AddLbCamHideableEntt(intrctRangeGo, entity)
  end
  self._allEntityDic[intrctData:GetLbIntrctObjId()] = entity
  if objType == ActLbEnum.eActLbEntityType.Normal then
    self._normalEntityDic[intrctData:GetLbIntrctObjId()] = entity
  elseif objType == ActLbEnum.eActLbEntityType.Hero then
    self._heroEntityDic[intrctData:GetLbIntrctObjHeroId()] = entity
  end
end

function ActLbInteractCtrl:SetLbInteractObjShow(objId, isNeedChangePos)
  local entity = self._allEntityDic[objId]
  if entity == nil then
    return
  end
  if self._eActIntrct.eActIntrctEntityShowFunc then
    local func = self._eActIntrct.eActIntrctEntityShowFunc[objId]
    if func then
      local isShow, pos = func(entity, isNeedChangePos)
      entity:SetLbEnityGameObjectActive(isShow)
      if isNeedChangePos and pos then
        entity:SetLbEnityPos(pos)
      end
    end
  end
end

function ActLbInteractCtrl:SetAllLbInteractObjShow()
  if not self._eActIntrct.eActIntrctEntityShowFunc then
    return
  end
  for id, entity in pairs(self._allEntityDic) do
    local func = self._eActIntrct.eActIntrctEntityShowFunc[id]
    if func then
      local isShow = func(entity)
      entity:SetLbEnityGameObjectActive(isShow)
      if not isShow and self._curIntrctEntDic[entity] then
        local rangeGo = self:GetRangeGoByEntity(entity)
        if not IsNull(rangeGo) then
          self:OnLbInteractChange(rangeGo, false)
        end
      end
    end
  end
end

function ActLbInteractCtrl:GetRangeGoByEntity(entity)
  for rangeItem, item in pairs(self._intrctRangeGoDic) do
    if item == entity then
      return rangeItem
    end
  end
  return nil
end

function ActLbInteractCtrl:OnLbInteractChange(interactRangeGo, isEnter)
  local intrctEnt = self._intrctRangeGoDic[interactRangeGo]
  if IsNull(intrctEnt) then
    return
  end
  if isEnter then
    self._curIntrctEntDic[intrctEnt] = true
  else
    self._curIntrctEntDic[intrctEnt] = nil
  end
  self:UpdLbCurInteractAction()
  self:OnLbInteractChangeCallback(intrctEnt, isEnter)
end

function ActLbInteractCtrl:OnLbInteractChangeCallback(intrctEnt, isEnter)
  if self._eActIntrct == nil then
    return
  end
  local intrctData = intrctEnt:GetLbIntrctEntData()
  local actionData = intrctData:GetLbIntrctObjActionFirst()
  if actionData then
    local actionId = actionData:GetLbIntrctActionId()
    local func = self._eActIntrct.eActIntrctEntityEnterFunc and self._eActIntrct.eActIntrctEntityEnterFunc[actionId]
    if func then
      func(intrctEnt, isEnter)
    end
  end
end

function ActLbInteractCtrl:UpdLbCurInteractAction()
  self._curActionList = {}
  for entity, _ in pairs(self._curIntrctEntDic) do
    local intrctData = entity:GetLbIntrctEntData()
    local actionList = intrctData:GetLbIntrctObjActions()
    for k, actionData in ipairs(actionList) do
      if actionData:IsLbIntrctEntiUnlock() then
        table.insert(self._curActionList, actionData)
      end
    end
  end
  self:UpdLbCurInteractList()
end

function ActLbInteractCtrl:UpdLbCurInteractList()
  local win = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
  if win then
    win.actLbIntrctNode:UpdateLbInteractList(self._curActionList)
  end
end

function ActLbInteractCtrl:GetActLbIntrctActionFunc(actionId)
  local func = self._eActIntrct.eIntrctFuncs[actionId]
  if func == nil then
    error(string.format("Cant get InteractAction, actId:%s, actionId:%s", self.actLbCtrl:GetActLobbyId(), actionId))
  end
  return func
end

function ActLbInteractCtrl:InvokeActLbEntity(objectId, args)
  local LbInteractData = self._interactDataDic[objectId]
  if LbInteractData == nil then
    return
  end
  local entity = self._interactEntityDic[LbInteractData]
  if entity == nil then
    return
  end
  local actionId = LbInteractData:GetLbIntrctObjActionIdList()[1]
  if actionId == nil then
    return
  end
  local func = self:GetActLbIntrctActionFunc(actionId)
  func(entity, args)
end

function ActLbInteractCtrl:GetActLbEntityIsUnlock(objectId)
  local LbInteractData = self._interactDataDic[objectId]
  if LbInteractData == nil then
    return false
  end
  local actionId = LbInteractData:GetLbIntrctObjActionIdList()[1]
  if actionId == nil then
    return false
  end
  local func = self._eActIntrct.eUnlockIntrctFunc[actionId]
  if func == nil then
    error(string.format("Cant get unlockIntrctFunc, actId:%s, actionId:%s", self.actLbCtrl:GetActLobbyId(), actionId))
    return false
  end
  return func(LbInteractData)
end

function ActLbInteractCtrl:GetActLbIntrctActionUnlockTip(objectId)
  local LbInteractData = self._interactDataDic[objectId]
  if LbInteractData == nil then
    return nil
  end
  local intrctData = LbInteractData:GetLbIntrctObjActionFirst()
  if intrctData == nil then
    return nil
  end
  return intrctData:GetLbIntrctActionLockClickTip()
end

function ActLbInteractCtrl:InvokeActLbInteractEnterFunc(isEnter, isEye)
  if self._eActIntrct.OnActLbInteractEnterFunc ~= nil then
    self._eActIntrct.OnActLbInteractEnterFunc(isEnter, isEye)
  end
end

function ActLbInteractCtrl:InvokeActLbCamChange()
  if self._eActIntrct.OnActCamChangeFunc ~= nil then
    self._eActIntrct.OnActCamChangeFunc()
  end
end

function ActLbInteractCtrl:InvokeLbActivityRunningTimeoutFunc()
  if self._eActIntrct.OnLbActivityRunningTimeoutFunc ~= nil then
    self._eActIntrct.OnLbActivityRunningTimeoutFunc(self.actLbCtrl)
  end
end

function ActLbInteractCtrl:InvokeLbActivityFinishedFunc()
  if self._eActIntrct.OnLbActivityFinishedFunc ~= nil then
    self._eActIntrct.OnLbActivityFinishedFunc(self.actLbCtrl)
  end
end

function ActLbInteractCtrl:InvokeActLbStartShowEndCoFunc()
  if self._eActIntrct.OnActLbStartShowEndCoFunc ~= nil then
    self._eActIntrct.OnActLbStartShowEndCoFunc(self.actLbCtrl)
  end
end

function ActLbInteractCtrl:InvokeActLbRedDotFunc()
  if self._eActIntrct.UpdateActivityReddotChange ~= nil then
    self._eActIntrct.UpdateActivityReddotChange()
  end
end

function ActLbInteractCtrl:_LoadCfg()
  local actId = self.actLbCtrl:GetActLbActId()
  local actPathName = ActivityMap[actId]
  if actPathName == nil then
    error("Cant get actPathName, actId : " .. tostring(actId))
    return
  end
  self._eActIntrctPath = "Game.ActivityLobby.Activity." .. actPathName .. ".eActInteract"
  self._eActIntrct = require(self._eActIntrctPath)
  local actLbCfg = self.actLbCtrl:GetActLbCfg()
  if actLbCfg.guide_action_id > 0 and 0 < actLbCfg.guide_id then
    self._eActIntrct.eIntrctFuncs[actLbCfg.guide_action_id] = ActInteractCommon.IntrctCmFuncs.ShowGuidePic
  end
end

function ActLbInteractCtrl:_UnloadCfg()
  self._eActIntrct = nil
  if self._eActIntrctPath ~= nil then
    package.loaded[self._eActIntrctPath] = nil
    self._eActIntrctPath = nil
  end
end

function ActLbInteractCtrl:TryGetActLbIntrctEnttByGo(go)
  return self._intrctEntGoDic[go]
end

function ActLbInteractCtrl:TryGetAcgLbHeroEntity(heroId)
  return self._heroEntityDic[heroId]
end

function ActLbInteractCtrl:GetAllHeroEntity()
  return self._heroEntityDic
end

function ActLbInteractCtrl:GetActLbQuickEntranceActionList()
  return self._quickEntranceActionList
end

function ActLbInteractCtrl:GetActLbIntractDataById(enttId)
  return self._interactDataDic[enttId]
end

function ActLbInteractCtrl:GetLbIntrctEntFxUnlockById(enttId)
  local intrctData = self._interactDataDic[enttId]
  if intrctData == nil then
    return
  end
  local entt = self._interactEntityDic[intrctData]
  if entt then
    return entt
  end
end

function ActLbInteractCtrl:GetLbIntrctAllEntityDic()
  return self._allEntityDic
end

function ActLbInteractCtrl:UpdAllLbIntrctEntFxUnlock()
  for k, entt in pairs(self._interactEntityDic) do
    entt:UpdLbIntrctEntFxUnlock()
  end
end

function ActLbInteractCtrl:UpdLbIntrctEntFxUnlockById(objId)
  local intrctData = self._interactDataDic[objId]
  local entt = self._interactEntityDic[intrctData]
  if entt then
    entt:UpdLbIntrctEntFxUnlock()
  end
end

function ActLbInteractCtrl:GetObjId(objName)
  return self._eActIntrct.eLbIntrctEntityId[objName]
end

function ActLbInteractCtrl:GeteActIntrct()
  return self._eActIntrct
end

function ActLbInteractCtrl:Delete()
  if self._eActIntrct and self._eActIntrct.OnActLbExitFunc ~= nil then
    self._eActIntrct.OnActLbExitFunc(self.actLbCtrl)
  end
  self:_UnloadCfg()
  if self._interactEntityDic then
    for k, v in pairs(self._interactEntityDic) do
      v:OnDelete()
    end
  end
end

return ActLbInteractCtrl
