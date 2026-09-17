local this = class("moduleMovementBlockBase", G_UIModuleBase)

function this.methods()
  return {}
end

function this:created(...)
  this.super.created(self, ...)
  self:initBtnMap()
end

function this:initBtnMap()
  self.blockBtnMap = {}
end

function this:open()
  self.btnRects = {}
  for _, v in pairs(L_Const.movementBtnType) do
    local rect = self.bindComponents.control:Find("btn" .. _)
    if L_CommonUtil.isValid(rect) then
      self.btnRects[v] = self.bindComponents.control:Find("btn" .. _)
    end
  end
  self:registerListeners()
end

function this:registerListeners()
  L_PlayerManager:addListener(L_PlayerManager.event.playMount, self.onPlayerOnMount, self)
  L_PlayerManager:addListener(L_PlayerManager.event.outMount, self.onPlayerOutMount, self)
  L_PlayerManager:addListener(L_PlayerManager.event.outMountEnd, self.onPlayerOutMount, self)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshMountStatus, self.refresh, self)
  L_MountManager:addListener(L_MountManager.event.onCSEntityMountStateChange, self.onEvent_CsEntityStateChange, self)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.refresh, self)
end

function this:show()
  self:refresh()
  self.defaultHide = L_BattleDataManager:checkPlayerBattle()
  self:refreshCtrlBtnState()
end

function this:refresh()
  self.ctrlType = L_Const.movementBlockType.default
  if L_PlayerManager:inMountFly() then
    self.ctrlType = L_Const.movementBlockType.fly
  elseif AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() then
    self.ctrlType = L_Const.movementBlockType.mount
  end
  self:refreshCtrlType(self.ctrlType)
end

function this:onEvent_CsEntityStateChange(state)
  local ctrlType = L_Const.movementBlockType.default
  if AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() then
    if state == L_Const.WorldMapPlayerMountStatusType.WMPMST_FLY then
      ctrlType = L_Const.movementBlockType.fly
    else
      ctrlType = L_Const.movementBlockType.mount
    end
  end
  self:refreshCtrlType(ctrlType)
end

function this:showOrHideBtnRoot(flag)
  self.bindComponents.goControl.gameObject:ActiveTrans(flag)
end

function this:refreshCtrlType(type)
  self.ctrlType = type
  self:refreshCtrlBtnState()
end

function this:refreshCtrlBtnState()
end

function this:onPlayerOnMount()
  local ctrlType = L_Const.movementBlockType.default
  if L_PlayerManager:inMountFly() then
    ctrlType = L_Const.movementBlockType.fly
  else
    ctrlType = L_Const.movementBlockType.mount
  end
  self:refreshCtrlType(ctrlType)
end

function this:onPlayerOutMount()
  self:refreshCtrlType(L_Const.movementBlockType.default)
end

function this:doJump()
  if self.ctrlType == L_Const.movementBlockType.fly then
    return
  end
  L_PlayerManager:fireJump()
end

function this:doDodge()
  if self.ctrlType == L_Const.movementBlockType.mount or self.ctrlType == L_Const.movementBlockType.fly then
    L_PlayerManager:fireFlySprint()
  else
    L_PlayerManager:fireEvade()
  end
end

function this:getBtnTypeLock(ctrlType, eButtonType)
  if ctrlType == L_Const.movementBlockType.mount or ctrlType == L_Const.movementBlockType.fly then
    local mainMount = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
    if mainMount == nil then
      return false
    end
    if eButtonType == L_Const.movementBtnType.MountJump then
      return mainMount.data.canOperateJumpState ~= 0
    elseif eButtonType == L_Const.movementBtnType.MountFlyUp or eButtonType == L_Const.movementBtnType.MountFlyDown then
      return L_MountManager:getCanFly(L_PetStore:getPetItem(mainMount.data.UUID).id)
    elseif eButtonType == L_Const.movementBtnType.MountDodge then
      return mainMount.data.canOperateDodge
    end
  end
  return true
end

function this:removeListeners()
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.refresh, self)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshMountStatus, self.refresh, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.playMount, self.onPlayerOnMount, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.outMount, self.onPlayerOutMount, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.outMountEnd, self.onPlayerOutMount, self)
  L_MountManager:removeListener(L_MountManager.event.onCSEntityMountStateChange, self.onEvent_CsEntityStateChange, self)
end

function this:close()
  self:removeListeners()
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
