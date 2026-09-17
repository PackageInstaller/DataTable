local this = class("moduleLeaveWall", G_UIModuleBase)

function this.bind()
  return {
    goLeaveWall = false,
    fill_leaveWall = 0,
    rectPos_node = C_Vector2.zero
  }
end

function this.methods()
  return {}
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open()
  L_BattleDataManager:addListener(L_BattleDataManager.event.leaveWallTime, self.onEvent_leaveWallTime, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.leaveWallBattle, self.onEvent_leaveWallSuccess, self)
  self.updateHandle = handler(self, self.doUpdate)
  C_UpdateSource.AddLateUpdateEventHandler(self.updateHandle, "moduleLeaveWall.doUpdate")
  self.bind.goLeaveWall = false
  self.isDoEnd = false
end

function this:show()
  self._flag = false
  self.bind.goLeaveWall = false
  self.isDoEnd = false
end

function this:hide()
end

function this:onEvent_leaveWallTime(args)
  if self.isDoEnd then
    return
  end
  if args.floatArg == 0 then
    self:setLeaveWallGo(false)
  else
    if args.floatArg > 0 and args.floatArg < 0.02 then
      return
    end
    self.bind.fill_leaveWall = args.floatArg > 1 and 1 or args.floatArg
    self:setLeaveWallGo(true)
  end
end

function this:doUpdate()
  if not self._flag then
    return
  end
  local main = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  if main == nil then
    return
  end
  local unitId = L_GameUtil.getUnitIdByRole(main.data.configId)
  if math.isEmpty(unitId) then
    return
  end
  local unitTpl = L_GameTpl:getUnitTpl()
  local correctPos = C_Vector3(0, unitTpl:getColliderHeightById(unitId), 0)
  local bindPoint = unitTpl:getBloodBarNodeById(unitId)
  local bindTran = main.model:GetTransByName(bindPoint)
  if not bindTran then
    errorf("该人物没有找到配置" .. bindPoint .. "节点  或者是节点配置错误 需要修改节点名称 或者人物节点配置 所以无法显示逃脱Ui")
    return
  end
  local viewPos = C_CameraManager.mainCamera:WorldToViewportPoint(bindTran.position + correctPos)
  local screenWidth, screenHeight = C_Screen.width, C_Screen.height
  local uiWidth, uiHight = L_UI:getCanvasScaler().referenceResolution.x, L_UI:getCanvasScaler().referenceResolution.y
  local adjustedScreenPos = C_Vector2((viewPos.x - 0.5) * screenWidth, (viewPos.y - 0.5) * screenHeight)
  local widthRatio = uiWidth / screenWidth
  local heightRatio = uiHight / screenHeight
  local screenPos = C_Vector2(widthRatio * adjustedScreenPos.x, heightRatio * adjustedScreenPos.y)
  self.bind.rectPos_node = screenPos
end

function this:onEvent_leaveWallSuccess()
  self.isDoEnd = true
  self:setLeaveWallGo(false)
end

function this:setLeaveWallGo(flag)
  if self._flag == flag then
    return
  end
  self._flag = flag
  self.bindComponents.anim:Stop()
  if flag then
    self.bind.goLeaveWall = flag
    self.bindComponents.anim:Play("anim_battle_leavewall_in")
  else
    self.bindComponents.anim:Play("anim_battle_leavewall_out")
  end
end

function this:close()
  self.bindComponents.anim:Stop()
  self.bind.goLeaveWall = false
  self._flag = false
  C_UpdateSource.RemoveLateUpdateEventHandler(self.updateHandle)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.leaveWallTime, self.onEvent_leaveWallTime, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.leaveWallBattle, self.onEvent_leaveWallSuccess, self)
end

function this:update()
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
end

return this
