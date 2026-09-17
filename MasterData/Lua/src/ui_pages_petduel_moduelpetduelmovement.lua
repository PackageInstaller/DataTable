local this = class("moduelPetDuelMovement", G_UIModuleBase)
local _wordsTpl = L_GameTpl:getWordsTpl()
local CDragBtn = CS.Lens.Framework.UI.LDragButton
local EButtonType = {
  Jump = 1,
  Dodge = 2,
  Atk = 3,
  Fly = 4,
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
    [EButtonType.Atk] = false,
    [EButtonType.Jump] = true,
    [EButtonType.Dodge] = true,
    [EButtonType.Fly] = false,
    [EButtonType.MountFlyUp] = false,
    [EButtonType.MountFlyDown] = false,
    [EButtonType.MountDodge] = false,
    [EButtonType.MountAtk] = false,
    [EButtonType.MountJump] = false,
    [EButtonType.MountSkill] = false
  },
  [L_Const.movementBlockType.fly] = {
    [EButtonType.Atk] = false,
    [EButtonType.Jump] = false,
    [EButtonType.Dodge] = false,
    [EButtonType.Fly] = false,
    [EButtonType.MountFlyUp] = true,
    [EButtonType.MountFlyDown] = true,
    [EButtonType.MountDodge] = true,
    [EButtonType.MountAtk] = false,
    [EButtonType.MountJump] = false,
    [EButtonType.MountSkill] = false
  },
  [L_Const.movementBlockType.mount] = {
    [EButtonType.Atk] = false,
    [EButtonType.Jump] = false,
    [EButtonType.Dodge] = false,
    [EButtonType.Fly] = true,
    [EButtonType.MountFlyUp] = false,
    [EButtonType.MountFlyDown] = false,
    [EButtonType.MountDodge] = true,
    [EButtonType.MountAtk] = false,
    [EButtonType.MountJump] = true,
    [EButtonType.MountSkill] = false
  }
}
local PcBlockBtnMap = {
  [L_Const.movementBlockType.default] = {
    [EButtonType.Atk] = true,
    [EButtonType.Jump] = true,
    [EButtonType.Dodge] = true,
    [EButtonType.Fly] = false,
    [EButtonType.MountFlyUp] = false,
    [EButtonType.MountFlyDown] = false,
    [EButtonType.MountDodge] = false,
    [EButtonType.MountAtk] = false,
    [EButtonType.MountJump] = false,
    [EButtonType.MountSkill] = false
  },
  [L_Const.movementBlockType.fly] = {
    [EButtonType.Atk] = false,
    [EButtonType.Jump] = false,
    [EButtonType.Dodge] = false,
    [EButtonType.Fly] = false,
    [EButtonType.MountFlyUp] = true,
    [EButtonType.MountFlyDown] = true,
    [EButtonType.MountDodge] = true,
    [EButtonType.MountAtk] = false,
    [EButtonType.MountJump] = false,
    [EButtonType.MountSkill] = false
  },
  [L_Const.movementBlockType.mount] = {
    [EButtonType.Atk] = false,
    [EButtonType.Jump] = false,
    [EButtonType.Dodge] = false,
    [EButtonType.Fly] = true,
    [EButtonType.MountFlyUp] = false,
    [EButtonType.MountFlyDown] = false,
    [EButtonType.MountDodge] = true,
    [EButtonType.MountAtk] = false,
    [EButtonType.MountJump] = true,
    [EButtonType.MountSkill] = false
  }
}

function this.bind()
  return {
    go_control = true,
    module_dodge = {
      moduleName = "pages/petDuel/cellKiboDuelDodge"
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
    onDrag_joystick = function(self)
    end,
    onDown_attack = function(self)
      L_PlayerManager:fireAttackDown()
    end,
    onUp_attack = function(self)
      L_PlayerManager:fireAttackUp()
    end,
    onClickDodgeNew = function(self)
      self:onClickDodgeNew()
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
  self:showShortCut(27, true)
  self:showShortCut(28, true)
end

function this:hide()
  self:showShortCut(27, false)
  self:showShortCut(28, false)
end

function this:setDefalutHide()
  self.defalutHide = true
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
  self:refreshCtrlBtnState()
end

function this:refreshBtnPos()
  self.oldJoyStick = L_GameUtil.getJoyStick()
  L_GameUtil.setJoyStick(self.bindComponents.joystick)
  self:setLayoutPosition()
end

function this:setPCLayoutPosition()
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
    self:_refreshPcCtrlBtnState()
  else
    self.bindComponents.pcControl.gameObject:ActiveTrans(false)
    self:_refreshMobileCtrlBtnState()
  end
end

function this:_refreshPcCtrlBtnState()
  if self.ctrlType == L_Const.movementBlockType.default and self.defalutHide then
    for k, v in pairs(self.pcBtns) do
      v.gameObject:SetActive(false)
    end
    return
  end
  for k, v in pairs(self.pcBtns) do
    local stateInMap = PcBlockBtnMap[self.ctrlType][k]
    v.gameObject:SetActive(stateInMap and self:getBtnTypeLock(self.ctrlType, k))
  end
end

function this:_refreshMobileCtrlBtnState()
  if self.ctrlType == L_Const.movementBlockType.default and self.defalutHide then
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
  local isPageOption = self.parent.pageName == "pageOption"
  self.canClick = not isPageOption
  if isPc then
    self.bindComponents.pcControl.gameObject:ActiveTrans(true)
    self.bind.go_control = false
    self.bindComponents.clickArea.gameObject:ActiveTrans(false)
    self:refreshCtrlBtnState()
  else
    self.bind.go_control = true
    self.bindComponents.clickArea.gameObject:ActiveTrans(true)
    self.bindComponents.pcControl.gameObject:ActiveTrans(false)
    if not isPageOption then
      L_GameUtil.setJoyStick(self.bindComponents.joystick)
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
  if not self.canClick then
    return
  end
  L_PlayerManager:fireJump()
end

function this:doDodge()
  if not self.canClick then
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
    elseif eButtonType == EButtonType.MountFlyUp or eButtonType == EButtonType.MountFlyDown or eButtonType == EButtonType.Fly then
      return L_MountManager:getCanFly(L_PetStore:getPetItem(mainMount.data.UUID).id)
    elseif eButtonType == EButtonType.MountDodge then
      return mainMount.data.canOperateDodge
    end
  end
  return true
end

function this:onClickDodgeNew()
  if self.parent and not self.parent.duelStar then
    return
  end
  L_PlayerManager:fireEvade()
end

function this:showShortCut(id, idAdd)
  local args = CS.Lens.Gameplay.UI.ModuleShortcutGuideEventArgs()
  args.isLuaEvent = true
  args.luaTable = {
    tdId = id,
    isAdd = idAdd,
    isGray = false
  }
  C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcChange, args)
end

return this
