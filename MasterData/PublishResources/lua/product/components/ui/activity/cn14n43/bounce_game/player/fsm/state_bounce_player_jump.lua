_class("StateBouncePlayerJump", StateBouncePlayerBase)
StateBouncePlayerJump = StateBouncePlayerJump

function StateBouncePlayerJump:OnEnter(TT, ...)
  self:Init()
  self:PlayAnim()
  self:LoadJumpEffect()
  if BounceDebug.ShowObjRect then
    self:ShowDebugRect()
  end
  self.viewBehavior = self.player:GetBehavior(BouncePlayerBeHaviorView:Name())
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BounceJump)
end

function StateBouncePlayerJump:OnExit(TT)
end

function StateBouncePlayerJump:OnJump()
  local duration = self.bounceData.durationMs
  if self.playerData:ChecAirkAttackCD(duration, true) then
    self.playerData.curSpeed = self.playerData.airJumpSpeed
    self.player:ChgPlayerState(StateBouncePlayer.JumpAttack)
  end
end

function StateBouncePlayerJump:OnAttack()
  if self.playerData.curSpeed > self.playerData.accDownSpeed then
    self.playerData.curSpeed = self.playerData.accDownSpeed
  end
  self.player:ChgPlayerState(StateBouncePlayer.AccDown)
end

function StateBouncePlayerJump:OnUpdate(deltaTimeMS)
  if self.playerData.curSpeed <= 0 then
    self.player:ChgPlayerState(StateBouncePlayer.Down)
    return
  end
  self.player:HandleMove(deltaTimeMS)
end

function StateBouncePlayerJump:GetStateType()
  return StateBouncePlayer.Jump
end

function StateBouncePlayerJump:LoadJumpEffect()
  local viewBehavior = self:GetBehavior(BouncePlayerBeHaviorView:Name())
  if not viewBehavior then
    return
  end
  local playerGo = viewBehavior:GetGameObject()
  if not playerGo then
    return
  end
  local playerTran = playerGo:GetComponent("RectTransform")
  local eff = EffectManager.Acquire("eff_jump.prefab", playerTran.parent, playerTran.anchoredPosition, 350)
  return eff
end
