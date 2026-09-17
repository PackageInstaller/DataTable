local this = class("moduleMovementBlockMobile", require("ui.modulePages.moduleMovementBlockBase"))

function this.bind()
  return {
    go_pc_mountJump_spacePic = true,
    go_pc_mountJump_flyPic = false,
    module_attackModuleMount = {
      moduleName = "pages/battle/moduleMountSkillBtn"
    },
    module_skillModuleMount = {
      moduleName = "pages/battle/moduleMountSkillBtn"
    },
    module_moduleDodgeMount = {
      moduleName = "pages/battle/moduleMountDodgeBtn"
    }
  }
end

function this.methods()
  return {
    pconClick_mountJump = function(self)
      self:doJump()
    end,
    pconClick_mountDodge = function(self)
      self:doDodge()
    end,
    pconDown_mountattack = function(self)
      L_PlayerManager:fireAttackDown()
    end,
    pconClick_mountSkill = function(self)
      L_PlayerManager:fireSkill()
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
    end,
    pconDown_mountSkillSmallDown = function(self)
    end,
    pconDown_mountSkillSmallUp = function(self)
    end,
    pconDown_mountSkillBigDown = function(self)
    end,
    pconDown_mountSkillBigUp = function(self)
    end
  }
end

function this:initBtnMap()
  self.blockBtnMap = {
    [L_Const.movementBlockType.default] = {
      [L_Const.movementBtnType.MountSkill] = false,
      [L_Const.movementBtnType.MountAtk] = false,
      [L_Const.movementBtnType.MountDodge] = false,
      [L_Const.movementBtnType.MountJump] = false,
      [L_Const.movementBtnType.MountFlyDown] = false,
      [L_Const.movementBtnType.MountFlyUp] = false
    },
    [L_Const.movementBlockType.mount] = {
      [L_Const.movementBtnType.MountSkill] = true,
      [L_Const.movementBtnType.MountAtk] = true,
      [L_Const.movementBtnType.MountDodge] = true,
      [L_Const.movementBtnType.MountJump] = true,
      [L_Const.movementBtnType.MountFlyDown] = false,
      [L_Const.movementBtnType.MountFlyUp] = false
    },
    [L_Const.movementBlockType.fly] = {
      [L_Const.movementBtnType.MountSkill] = true,
      [L_Const.movementBtnType.MountAtk] = true,
      [L_Const.movementBtnType.MountDodge] = true,
      [L_Const.movementBtnType.MountJump] = false,
      [L_Const.movementBtnType.MountFlyDown] = true,
      [L_Const.movementBtnType.MountFlyUp] = true
    }
  }
end

function this:refreshCtrlBtnState()
  self.modules.module_attackPcMount:initSkillType(L_Const.skillType.attack)
  self.modules.module_skillPcMount:initSkillType(L_Const.skillType.skill2)
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  if self.ctrlType == L_Const.movementBlockType.default and self.defaultHide then
    for k, v in pairs(self.btnRects) do
      v.gameObject:SetActive(false)
    end
    return
  end
  for k, v in pairs(self.btnRects) do
    local stateInMap = self.blockBtnMap[self.ctrlType][k]
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
  local mainMount = L_PlayerManager:getMainControlEntity()
  if not mainMount then
    self.bind.go_pc_mountJump_flyPic = false
    self.bind.go_pc_mountJump_spacePic = true
    return
  end
  local getCanOperateJumpToFly = self:getCanOperateJumpToFly(mainMount)
  self.bind.go_pc_mountJump_flyPic = getCanOperateJumpToFly
  self.bind.go_pc_mountJump_spacePic = not getCanOperateJumpToFly
end

function this:getCanOperateJumpToFly(mountEntity)
  local csEntity = C_EntityManager.GetEntity(mountEntity.csEntityId)
  if not csEntity then
    return false
  end
  if not csEntity.data.controlProperty.CanAir then
    return false
  end
  return not csEntity.data.characterControlProperty:IsGrounded()
end

function this:close()
  this.super.close(self)
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

return this
