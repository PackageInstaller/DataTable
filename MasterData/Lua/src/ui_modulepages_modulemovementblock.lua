local this = class("moduleMovementBlock", G_UIModuleBase)
local CDragBtn = CS.Lens.Framework.UI.LDragButton
local EButtonType = {
  Jump = 1,
  Dodge = 2,
  Atk = 3,
  Fall = 5,
  MountFlyUp = 6,
  MountFlyDown = 7,
  MountDodge = 8,
  MountAtk = 9,
  MountJump = 10,
  MountSkill = 11
}
local BlockBtnMap = {
  [L_Const.movementBlockType.default] = {
    [EButtonType.Atk] = true,
    [EButtonType.Jump] = true,
    [EButtonType.Dodge] = true,
    [EButtonType.MountFlyUp] = false,
    [EButtonType.MountFlyDown] = false,
    [EButtonType.MountDodge] = false,
    [EButtonType.MountAtk] = false,
    [EButtonType.MountJump] = false
  },
  [L_Const.movementBlockType.fly] = {
    [EButtonType.Atk] = false,
    [EButtonType.Jump] = false,
    [EButtonType.Dodge] = false,
    [EButtonType.MountFlyUp] = true,
    [EButtonType.MountFlyDown] = true,
    [EButtonType.MountDodge] = true,
    [EButtonType.MountAtk] = true,
    [EButtonType.MountJump] = false
  },
  [L_Const.movementBlockType.mount] = {
    [EButtonType.Atk] = false,
    [EButtonType.Jump] = false,
    [EButtonType.Dodge] = false,
    [EButtonType.MountFlyUp] = false,
    [EButtonType.MountFlyDown] = false,
    [EButtonType.MountDodge] = true,
    [EButtonType.MountAtk] = true,
    [EButtonType.MountJump] = true
  }
}
local PcBlockBtnMap = {
  [L_Const.movementBlockType.default] = {
    [EButtonType.MountSkill] = false,
    [EButtonType.MountAtk] = false,
    [EButtonType.MountDodge] = false,
    [EButtonType.MountAtk] = false,
    [EButtonType.MountJump] = false,
    [EButtonType.MountFlyDown] = false,
    [EButtonType.MountFlyUp] = false
  },
  [L_Const.movementBlockType.mount] = {
    [EButtonType.MountSkill] = true,
    [EButtonType.MountAtk] = true,
    [EButtonType.MountDodge] = true,
    [EButtonType.MountAtk] = true,
    [EButtonType.MountJump] = true,
    [EButtonType.MountFlyDown] = false,
    [EButtonType.MountFlyUp] = false
  },
  [L_Const.movementBlockType.fly] = {
    [EButtonType.MountSkill] = true,
    [EButtonType.MountAtk] = true,
    [EButtonType.MountDodge] = true,
    [EButtonType.MountAtk] = true,
    [EButtonType.MountJump] = false,
    [EButtonType.MountFlyDown] = true,
    [EButtonType.MountFlyUp] = true
  }
}

function this.bind()
  return {
    go_control = true,
    go_pc_mountJump_spacePic = true,
    go_pc_mountJump_flyPic = false,
    module_attackMount = {
      moduleName = "pages/battle/moduleMountSkillBtn"
    },
    module_attackPcMount = {
      moduleName = "pages/battle/moduleMountSkillBtn"
    },
    module_skillPcMount = {
      moduleName = "pages/battle/moduleMountSkillBtn"
    },
    module_dodgeMount = {
      moduleName = "pages/battle/moduleMountDodgeBtn"
    },
    module_pcDodgeMount = {
      moduleName = "pages/battle/moduleMountDodgeBtn"
    }
  }
end

function this.methods()
  return {
    onClick_jump = function(self)
      self:doJump()
    end,
    onClick_dodge = function(self)
      self:doDodge()
    end,
    onDragEnd_jump = function(self)
      self:refreshBtnState(EButtonType.Jump)
    end,
    onDragEnd_dodge = function(self)
      self:refreshBtnState(EButtonType.Dodge)
    end,
    onDragEnd_attack = function(self)
      self:refreshBtnState(EButtonType.Atk)
    end,
    onDown_attack = function(self)
      L_PlayerManager:fireAttackDown()
    end,
    onUp_attack = function(self)
      L_PlayerManager:fireAttackUp()
    end,
    onClick_mountJump = function(self)
      self:doJump()
    end,
    onClick_mountDodge = function(self)
      self:doDodge()
    end,
    onDragEnd_mountJump = function(self)
      self:refreshBtnState(EButtonType.MountJump)
    end,
    onDragEnd_mountFlyUp = function(self)
      self:refreshBtnState(EButtonType.MountFlyUp)
    end,
    onDragEnd_mountAttack = function(self)
      self:refreshBtnState(EButtonType.MountAtk)
    end,
    onDown_flyUp = function(self)
      L_PlayerManager:fireFlyUp(true)
    end,
    onUp_flyUp = function(self)
      L_PlayerManager:fireFlyUp(false)
    end,
    onDown_flyDown = function(self)
      L_PlayerManager:fireFlyFall(true)
    end,
    onUp_flyDown = function(self)
      L_PlayerManager:fireFlyFall(false)
    end,
    pconClick_mountJump = function(self)
      self:doJump()
    end,
    pconClick_mountDodge = function(self)
      self:doDodge()
    end,
    pconDown_mountattack = function(self)
      L_PlayerManager:fireAttackDown()
    end,
    pconUp_mountattack = function(self)
      L_PlayerManager:fireAttackUp()
    end,
    pconClick_mountSkill = function(self)
      L_PlayerManager:fireSkill()
    end,
    pconDragEnd_mountJump = function(self)
      self:refreshBtnState(EButtonType.MountJump)
    end,
    pconDragEnd_mountFlyUp = function(self)
      self:refreshBtnState(EButtonType.MountFlyUp)
    end,
    pconDragEnd_mountAttack = function(self)
      self:refreshBtnState(EButtonType.MountAtk)
    end,
    pconDown_flyUp = function(self)
      L_PlayerManager:fireFlyUp(true)
    end,
    pconUp_flyUp = function(self)
      L_PlayerManager:fireFlyUp(false)
    end,
    pconDown_flyDown = function(self)
      L_PlayerManager:fireFlyFall(true)
    end,
    pconUp_flyDown = function(self)
      L_PlayerManager:fireFlyFall(false)
    end
  }
end

function this:open()
  self.ctrlType = L_Const.movementBlockType.default
  if L_PlayerManager:inMountFly() then
    self.ctrlType = L_Const.movementBlockType.fly
  elseif AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() then
    self.ctrlType = L_Const.movementBlockType.mount
  end
  self.btns = {}
  for _, v in pairs(EButtonType) do
    self.btns[v] = self.bindComponents.control:Find("btn" .. _)
  end
  self.pcBtns = {}
  for _, v in pairs(EButtonType) do
    self.pcBtns[v] = self.bindComponents.pcControl:Find("btn" .. _)
  end
  L_ControlStore:listenCallFunc(L_ControlStore.event.toggleType, self.refreshCtrlType, self)
  L_SettingStore:listenCallFunc(L_SettingStore.event.refreshEquipment, self.onEvent_refreshEquipment, self)
  L_PlayerManager:addListener(L_PlayerManager.event.playMount, self.onPlayerOnMount, self)
  L_PlayerManager:addListener(L_PlayerManager.event.outMount, self.onPlayerOutMount, self)
  L_PlayerManager:addListener(L_PlayerManager.event.outMountEnd, self.onPlayerOutMount, self)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshMountStatus, self.refresh, self)
  L_MountManager:addListener(L_MountManager.event.onCSEntityMountStateChange, self.onEvent_CsEntityStateChange, self)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.refresh, self)
  self:onEvent_refreshEquipment()
end

function this:show()
  self:refresh()
  self.defaultHide = L_BattleDataManager:checkPlayerBattle()
  self:refreshCtrlBtnState()
end

function this:close()
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.refresh, self)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshMountStatus, self.refresh, self)
  L_ControlStore:unListenCallFunc(L_ControlStore.event.toggleType, self.refreshCtrlType, self)
  L_SettingStore:unListenCallFunc(L_SettingStore.event.refreshEquipment, self.onEvent_refreshEquipment, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.playMount, self.onPlayerOnMount, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.outMount, self.onPlayerOutMount, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.outMountEnd, self.onPlayerOutMount, self)
  L_MountManager:removeListener(L_MountManager.event.onCSEntityMountStateChange, self.onEvent_CsEntityStateChange, self)
  if L_CommonUtil.isValid(self.oldJoyStick) then
    L_GameUtil.setJoyStick(self.oldJoyStick)
    self.oldJoyStick = nil
  end
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:refresh()
  self.ctrlType = L_Const.movementBlockType.default
  if L_PlayerManager:inMountFly() then
    self.ctrlType = L_Const.movementBlockType.fly
  elseif AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() then
    self.ctrlType = L_Const.movementBlockType.mount
  end
  self:refreshBtnPos()
  self:refreshCtrlType(self.ctrlType)
end

function this:refreshBtnPos()
  if L_CommonUtil.isValid(self.oldJoyStick) then
    return
  end
  self.oldJoyStick = L_GameUtil.getJoyStick()
  L_GameUtil.setJoyStick(self.bindComponents.joystick)
  self:setLayoutPosition()
end

function this:setLayoutPosition()
  local isPc = L_DeviceTpl:getIsPc()
  if isPc then
    self:setPcLayoutPosition()
  else
    self:setMobileLayoutPosition()
  end
end

function this:setPcLayoutPosition()
end

function this:onEvent_CsEntityStateChange(state)
  local ctrlType = L_Const.movementBlockType.default
  if AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() then
    if state == L_Const.WorldMapPlayerMountStatusType.WMPMST_FLY then
      ctrlType = L_Const.movementBlockType.fly
    else
      ctrlType = L_Const.movementBlockType.mount
    end
  else
    ctrlType = L_Const.movementBlockType.default
  end
  self:refreshCtrlType(ctrlType)
end

function this:setMobileLayoutPosition()
  if L_SettingStore:getSetData(L_Const.settingType.uiLayout) == "true" then
    local joyPos = L_SettingStore:getMoveBlockJoystickPos()
    if joyPos then
      L_Vector3.setLocalPos(self.bindComponents.joystickObj, joyPos)
    end
    for k, v in pairs(self.btns) do
      local pos = L_SettingStore:getMovementBlockBtnPos(k)
      if pos then
        L_Vector3.setLocalPos(v, pos)
      end
    end
  end
end

function this:showOrHideBtnRoot(flag)
  local isPc = L_DeviceTpl:getIsPc()
  if isPc then
    self.bindComponents.pcControl.gameObject:ActiveTrans(flag)
    self.bind.go_control = false
  else
    self.bind.go_control = flag
    self.bindComponents.pcControl.gameObject:ActiveTrans(false)
  end
end

function this:refreshCtrlType(type)
  self.ctrlType = type
  self:refreshCtrlBtnState()
end

function this:refreshCtrlBtnState()
  local isPc = L_DeviceTpl:getIsPc()
  if isPc then
    self.bindComponents.pcControl.gameObject:ActiveTrans(true)
    self.modules.module_attackMount:initSkillType(nil)
    self.modules.module_attackPcMount:initSkillType(L_Const.skillType.attack)
    self.modules.module_skillPcMount:initSkillType(L_Const.skillType.skill2)
    self:_refreshPcCtrlBtnState()
  else
    self.bindComponents.pcControl.gameObject:ActiveTrans(false)
    self.modules.module_attackMount:initSkillType(L_Const.skillType.attack)
    self.modules.module_attackPcMount:initSkillType(nil)
    self.modules.module_skillPcMount:initSkillType(nil)
    self:_refreshMobileCtrlBtnState()
  end
end

function this:_refreshPcCtrlBtnState()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  if self.ctrlType == L_Const.movementBlockType.default and self.defaultHide then
    for k, v in pairs(self.pcBtns) do
      v.gameObject:SetActive(false)
    end
    return
  end
  for k, v in pairs(self.pcBtns) do
    local stateInMap = PcBlockBtnMap[self.ctrlType][k]
    v.gameObject:SetActive(stateInMap and self:getBtnTypeLock(self.ctrlType, k))
  end
  if self.ctrlType == L_Const.movementBlockType.mount then
    self.timer = Timer.repeated(0.1, function()
      self:checkCanMountJumpToFly()
    end, self)
    self:checkCanMountJumpToFly()
  end
end

function this:checkCanMountJumpToFly()
  if self.ctrlType ~= L_Const.movementBlockType.mount then
    if self.timer then
      Timer.remove(self.timer)
      self.timer = nil
    end
    return
  end
  local mainMount = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if not mainMount then
    self.bind.go_pc_mountJump_flyPic = false
    self.bind.go_pc_mountJump_spacePic = true
    return
  end
  local getCanOperateJumpToFly = self:getCanOperateJumpToFly(mainMount)
  self.bind.go_pc_mountJump_flyPic = getCanOperateJumpToFly
  self.bind.go_pc_mountJump_spacePic = not getCanOperateJumpToFly
end

function this:getCanOperateJumpToFly(csEntity)
  if not csEntity then
    return false
  end
  if not csEntity.data.controlProperty.CanAir then
    return false
  end
  return not csEntity.data.characterControlProperty:IsGrounded()
end

function this:_refreshMobileCtrlBtnState()
  if self.ctrlType == L_Const.movementBlockType.default and self.defaultHide then
    for k, v in pairs(self.pcBtns) do
      v.gameObject:SetActive(false)
    end
    return
  end
  for k, v in pairs(self.btns) do
    local stateInMap = BlockBtnMap[self.ctrlType][k]
    v.gameObject:SetActive(stateInMap and self:getBtnTypeLock(self.ctrlType, k))
  end
end

function this:onEvent_refreshEquipment()
  local isPc = L_DeviceTpl:getIsPc()
  self.bindComponents.joystickObj.gameObject:ActiveTrans(not isPc)
  local isPc = L_DeviceTpl:getIsPc()
  if isPc then
    self.bindComponents.pcControl.gameObject:ActiveTrans(true)
    self.bind.go_control = false
    self:refreshCtrlBtnState()
  else
    self.bind.go_control = true
    self.bindComponents.pcControl.gameObject:ActiveTrans(false)
    local isPageOption = self.parent.pageName == "pageOption"
    self.canClick = not isPageOption
    if not isPageOption then
      self:refreshBtnPos()
    end
    self:refreshCtrlBtnState()
  end
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

function this:loadSettingLayout()
  self.canClick = false
  for _, v in pairs(self.btns) do
    v.gameObject:SetActive(true)
  end
  self:setLayoutPosition()
  self:clearOverlapAlert()
  self.canSaveLayout = true
  for _, v in pairs(self.btns) do
    v:GetComponent(typeof(CDragBtn)).moveWithDrag = true
  end
  self.bindComponents.joystickDrag.moveWithDrag = true
  self.bindComponents.joystick.enabled = false
end

function this:refreshBtnState(btnType)
  self:clearOverlapAlert()
  self.canSaveLayout = true
  for k, v in pairs(self.btns) do
    local pos1 = L_Vector3.getLocalPos(self.btns[btnType])
    if k ~= btnType then
      local pos2 = L_Vector3.getLocalPos(v)
      local sqrDis = L_Vector3.sqrDistance(pos1, pos2)
      if sqrDis < 19600 then
        self:btnOverlapAlert(k)
        self:btnOverlapAlert(btnType)
        self.canSaveLayout = false
      end
    end
  end
end

function this:btnOverlapAlert(btnType, showAlert)
  local active = true
  if not showAlert then
    active = false
  end
  self.btns[btnType]:Find("mask").gameObject:SetActive(active)
end

function this:clearOverlapAlert()
  for _, v in pairs(self.btns) do
    v:Find("mask").gameObject:SetActive(false)
  end
end

function this:saveNewLayout()
  if not self.canSaveLayout then
    L_GameUtil.showCommonTip({
      txtTitle = L_WordsTpl:getValue("notice_title_hint"),
      txtContent = L_WordsTpl:getValue("notice_moduelPetDuelMovement"),
      cancelCallback = function()
        self.parent:closeModuleMovementBlock()
      end
    })
    return
  end
  L_SettingStore:setSetting(L_Const.settingType.uiLayout, "true")
  local posList = {}
  for k, v in pairs(self.btns) do
    posList[k] = L_Vector3.getLocalPos(v)
  end
  L_SettingStore:setMoveBlockControlConfig(L_Vector3.getLocalPos(self.bindComponents.joystickObj), posList)
  self.parent:closeModuleMovementBlock()
end

function this:doJump()
  if self.ctrlType == L_Const.movementBlockType.fly then
    return
  end
  if self.canClick == false then
    return
  end
  L_PlayerManager:fireJump()
end

function this:doDodge()
  if self.canClick == false then
    return
  end
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
    if eButtonType == EButtonType.MountJump then
      return mainMount.data.canOperateJumpState ~= 0
    elseif eButtonType == EButtonType.MountFlyUp or eButtonType == EButtonType.MountFlyDown then
      return L_MountManager:getCanFly(L_PetStore:getPetItem(mainMount.data.UUID).id)
    elseif eButtonType == EButtonType.MountDodge then
      return mainMount.data.canOperateDodge
    end
  end
  return true
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
