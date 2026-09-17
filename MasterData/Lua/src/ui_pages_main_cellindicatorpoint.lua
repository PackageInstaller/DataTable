local this = class("cellIndicatorPoint", G_UIModuleBase)
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
local colorNormal = C_Color(1, 1, 1)
local colorAttackPrepare = C_Color(0.9803921568627451, 0.30980392156862746, 0.3137254901960784)
local colorAttack = C_Color(0.9803921568627451, 0.30980392156862746, 0.3137254901960784)
local distanceStateEnum = {
  none = 0,
  small = 1,
  mid = 2,
  big = 3
}
local attackStateEnum = {
  none = 4,
  idle = 0,
  attackPrepare = 1,
  attacking = 2
}

function this.bind()
  return {
    anchoredPos_small = C_Vector2.zero,
    anchoredPos_noSmall = C_Vector2.zero,
    angel_small = C_Vector3.zero,
    angel_noSmall = C_Vector3.zero,
    scale_medium = C_Vector3(1, 1, 1),
    scale_big = C_Vector3(1, 1, 1),
    active_smallIcon = false,
    active_middleIcon = false,
    active_bigIcon = false,
    active_noSmall = false,
    color_smallIcon = colorNormal,
    color_noSmall = colorNormal,
    color_point1 = colorNormal,
    color_point2 = colorNormal
  }
end

function this.methods()
  return {}
end

function this:created(...)
  self.super.created(self, ...)
  self.minDistance = L_GameTpl:getGameConstTpl():getData("INDICATOR_TYPE_DISTANCE_1", L_Const.GameTplType.int)
  self.midDistance = L_GameTpl:getGameConstTpl():getData("INDICATOR_TYPE_DISTANCE_2", L_Const.GameTplType.int)
  self.maxDistance = L_GameTpl:getGameConstTpl():getData("INDICATOR_TYPE_DISTANCE_3", L_Const.GameTplType.int)
  self.distanceState = distanceStateEnum.none
  self.attackState = attackStateEnum.none
  self.indicatorFlashFrequency = C_BattleConfigManager.Data.indicatorFlashFrequency
end

function this:refreshView(indicatorInfo, parentTrans)
  self.indicatorInfo = indicatorInfo
  self:refreshIndicatorIcon(indicatorInfo.distance)
  self:refreshIndicatorState(indicatorInfo.state)
  self:refreshIndicatorPosAndAngel(indicatorInfo.indicatorPosition, indicatorInfo.indicatorAngle, parentTrans)
end

function this:refreshIndicatorIcon(distance)
  local distanceState = distanceStateEnum.none
  if distance < self.minDistance then
    distanceState = distanceStateEnum.big
  elseif distance < self.midDistance then
    distanceState = distanceStateEnum.mid
  else
    distanceState = distanceStateEnum.small
  end
  if self.distanceState == distanceState then
    return
  end
  self.distanceState = distanceState
  self.bind.active_smallIcon = self.distanceState == distanceStateEnum.small
  self.bind.active_middleIcon = self.distanceState == distanceStateEnum.mid
  self.bind.active_bigIcon = self.distanceState == distanceStateEnum.big
  self.bind.active_noSmall = self.distanceState ~= distanceStateEnum.small
end

function this:refreshIndicatorState(state)
  if self.attackState == state then
    return
  end
  self:clearTimer()
  self.attackState = state
  if self.distanceState == distanceStateEnum.small then
    if self.attackState == attackStateEnum.idle then
      self.bind.color_smallIcon = colorNormal
    elseif self.attackState == attackStateEnum.attackPrepare then
      self:attackPrepareFlashTimer(distanceStateEnum.small)
    else
      self.bind.color_smallIcon = colorAttack
    end
  elseif self.distanceState == distanceStateEnum.mid then
    if self.attackState == attackStateEnum.idle then
      self.bind.color_noSmall = colorNormal
      self.bind.color_point1 = colorNormal
      self.bind.color_point2 = colorNormal
      self.bindComponents.mediumIndicatorInfo.isAttack = false
      self.bindComponents.mediumIndicatorInfo.isAttackPrepare = false
    elseif self.attackState == attackStateEnum.attackPrepare then
      self:attackPrepareFlashTimer(distanceStateEnum.mid)
      self.bindComponents.mediumIndicatorInfo.isAttack = false
      self.bindComponents.mediumIndicatorInfo.isAttackPrepare = true
    else
      self.bind.color_noSmall = colorAttack
      self.bind.color_point1 = colorAttack
      self.bind.color_point2 = colorAttack
      self.bindComponents.mediumIndicatorInfo.isAttack = true
      self.bindComponents.mediumIndicatorInfo.isAttackPrepare = false
    end
  elseif self.attackState == attackStateEnum.idle then
    self.bind.color_noSmall = colorNormal
    self.bind.color_point1 = colorNormal
    self.bind.color_point2 = colorNormal
    self.bindComponents.mediumIndicatorInfo.isAttack = false
    self.bindComponents.mediumIndicatorInfo.isAttackPrepare = false
  elseif self.attackState == attackStateEnum.attackPrepare then
    self:attackPrepareFlashTimer(distanceStateEnum.big)
    self.bindComponents.mediumIndicatorInfo.isAttack = false
    self.bindComponents.mediumIndicatorInfo.isAttackPrepare = true
  else
    self.bind.color_noSmall = colorAttack
    self.bind.color_point1 = colorAttack
    self.bind.color_point2 = colorAttack
    self.bindComponents.mediumIndicatorInfo.isAttack = true
    self.bindComponents.mediumIndicatorInfo.isAttackPrepare = false
  end
end

function this:refreshIndicatorPosAndAngel(pos2, angelZ, parentTrans)
  local _, uiPos = _screenPosToUI(parentTrans, pos2, C_CameraManager.uiCamera)
  if self.bindComponents.mediumIndicatorInfo and self.bindComponents.bigIndicatorInfo then
    self.bindComponents.mediumIndicatorInfo.angel = math.rad(180 - angelZ) - math.pi / 2
    self.bindComponents.bigIndicatorInfo.angel = math.rad(180 - angelZ) - math.pi / 2
    self.bindComponents.mediumIndicatorHud:SetVerticesDirty()
    self.bindComponents.bigIndicatorHud:SetVerticesDirty()
  end
  self.bind.anchoredPos_small = uiPos
  self.bind.anchoredPos_noSmall = uiPos
  self.bind.angel_small = C_Vector3(0, 0, 180 - angelZ)
  self.bind.angel_noSmall = C_Vector3(0, 0, 180 - angelZ)
end

function this:attackPrepareFlashTimer(distanceState)
  if distanceState == distanceStateEnum.small then
    self.flashTimer = Timer.repeated(self.indicatorFlashFrequency * 2, function()
      self.bind.color_smallIcon = colorAttackPrepare
      Timer.once(self.indicatorFlashFrequency, function()
        self.bind.color_smallIcon = colorNormal
      end, self, self.gameObject)
    end)
  else
    self.flashTimer = Timer.repeated(self.indicatorFlashFrequency * 2, function()
      self.bind.color_noSmall = colorAttackPrepare
      self.bind.color_point1 = colorAttackPrepare
      self.bind.color_point2 = colorAttackPrepare
      Timer.once(self.indicatorFlashFrequency, function()
        self.bind.color_noSmall = colorNormal
        self.bind.color_point1 = colorNormal
        self.bind.color_point2 = colorNormal
      end, self, self.gameObject)
    end)
  end
end

function this:clearTimer()
  if self.flashTimer then
    Timer.remove(self.flashTimer)
    self.flashTimer = nil
  end
end

function this:reset()
  self.distanceState = distanceStateEnum.none
  self.attackState = attackStateEnum.none
  L_CommonUtil.setObjActive(self.gameObject, false)
  self:clearTimer()
end

function this:close()
  self:clearTimer()
end

return this
