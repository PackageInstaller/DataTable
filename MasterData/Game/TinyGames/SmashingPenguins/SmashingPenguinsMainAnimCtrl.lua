local SmashingPenguinsMainAnimCtrl = class("SmashingPenguinsMainAnimCtrl")
local TinyGameFrameController = require("Game.TinyGames.TinyGameFrameController")
local SmashingPenguinsConfig = require("Game.TinyGames.SmashingPenguins.Config.SmashingPenguinsConfig")
local SmashingPenguinsEnum = require("Game.TinyGames.SmashingPenguins.Enum.SmashingPenguinsEnum")
local SmashingPenguinsCharacterAnimState = SmashingPenguinsEnum.eCharacterAnimState
local animType = {directMove = 1, fire = 2}
local animAction = {
  [animType.directMove] = function(self, cfg)
    self:GetFakeCharacterDirectMoveCfg(cfg)
  end,
  [animType.fire] = function(self, cfg)
    self:GetFakeCharacterFireCfg(cfg)
  end
}

function SmashingPenguinsMainAnimCtrl:ctor(fakeCharacterEntity)
  self.fakeCharacterEntity = fakeCharacterEntity
  self.frameCtrl = TinyGameFrameController.New()
  self:OnInit()
end

function SmashingPenguinsMainAnimCtrl:OnInit()
  self.__OnRenderFrameUpdate = BindCallback(self, self.OnRenderFrameUpdate)
  self.__OnLogicFrameUpdate = BindCallback(self, self.OnLogicFrameUpdate)
  self.fakeCharacterEntity.transform.localPosition = Vector3.New(SmashingPenguinsConfig.StartPosBeforeAnim.x, SmashingPenguinsConfig.StartPosBeforeAnim.y, 0)
  self.frameCtrl:StartRunning(self.__OnLogicFrameUpdate, self.__OnRenderFrameUpdate)
end

function SmashingPenguinsMainAnimCtrl:GetRandomAnimType()
  local data = SmashingPenguinsConfig.MainUiAnimData[math.random(#SmashingPenguinsConfig.MainUiAnimData)]
  self:SetCurrentAnimType(data)
end

function SmashingPenguinsMainAnimCtrl:SetCurrentAnimType(data)
  if animAction[data.animType] ~= nil then
    animAction[data.animType](self, data.cfg)
    self.currentAnimType = data.animType
  end
end

function SmashingPenguinsMainAnimCtrl:RefreshFakeCharacterState(isUsePhysics)
  if self._fireTimer ~= nil then
    TimerManager:StopTimer(self._fireTimer)
    self._fireTimer = nil
  end
  self.fakeCharacterEntity.transform:DOKill(false)
  self.fakeCharacterEntity:SetSmashingPenguinsAnimState(SmashingPenguinsCharacterAnimState.Cry)
  self.fakeCharacterEntity.rigidbody.velocity = Vector3.zero
  self.fakeCharacterEntity.canLookAtDir = true
  self.fakeCharacterEntity:LookAtDir(Vector3.left, true)
  self:SetFakeCharacterPhysics(isUsePhysics)
end

function SmashingPenguinsMainAnimCtrl:SetFakeCharacterPhysics(isUsePhysics)
  self.fakeCharacterEntity:SetSmashingPenguinsColliderEnabled(isUsePhysics)
  self.fakeCharacterEntity:SetSmashingPenguinsUseGravity(isUsePhysics)
end

function SmashingPenguinsMainAnimCtrl:GetFakeCharacterDirectMoveCfg(cfg)
  if cfg ~= nil then
    self:RefreshFakeCharacterState(false)
    self:PlayFakeCharacterDirectMoveAnim(cfg)
  end
end

function SmashingPenguinsMainAnimCtrl:PlayFakeCharacterDirectMoveAnim(directMoveCfg)
  local startPos = Vector3.New(directMoveCfg.startX, directMoveCfg.startY, 0)
  local endPos = Vector3.New(directMoveCfg.endX, directMoveCfg.endY, 0)
  self.fakeCharacterEntity:LookAtDir(endPos - startPos)
  self.fakeCharacterEntity.transform.localPosition = startPos
  self.fakeCharacterEntity.transform:DOLocalMove(endPos, directMoveCfg.time):SetLink(self):OnComplete(function()
    self:GetRandomAnimType()
  end)
end

function SmashingPenguinsMainAnimCtrl:GetFakeCharacterFireCfg(cfg)
  if cfg ~= nil then
    self:RefreshFakeCharacterState(true)
    self:PlayFakeCharacterFireAnim(cfg)
  end
end

function SmashingPenguinsMainAnimCtrl:PlayFakeCharacterFireAnim(fireCfg)
  local startPos = Vector3.New(fireCfg.startX, fireCfg.startY, 0)
  local forceDir = Vector2.New(fireCfg.dirX, fireCfg.dirY).normalized
  self.fakeCharacterEntity.transform.localPosition = startPos
  self.fakeCharacterEntity:AddForceToSmashingPenguinsCharacter(forceDir, fireCfg.power)
  if self._fireTimer ~= nil then
    TimerManager:StopTimer(self._fireTimer)
    self._fireTimer = nil
  end
  self._fireTimer = TimerManager:StartTimer(fireCfg.time, function()
    self:GetRandomAnimType()
  end)
end

function SmashingPenguinsMainAnimCtrl:OnRenderFrameUpdate(timeRate)
  if self.currentAnimType ~= animType.fire then
    return
  end
  self.fakeCharacterEntity:LookAtDir(self.fakeCharacterEntity.rigidbody.velocity)
end

function SmashingPenguinsMainAnimCtrl:OnLogicFrameUpdate(logicFrameNum)
  if self.currentAnimType ~= animType.fire then
    return
  end
  local currentVelocity = self.fakeCharacterEntity.rigidbody.velocity
  local sqrtSpeed = currentVelocity.sqrMagnitude
  self.fakeCharacterEntity.canLookAtDir = sqrtSpeed > SmashingPenguinsConfig.MinSqrtSpeedKeepDir
  self.fakeCharacterEntity:UpdateSmashingPenguinsAnimState()
  if sqrtSpeed < SmashingPenguinsConfig.MinSqrtSpeedKeepRoll then
    self.fakeCharacterEntity:SetSmashingPenguinsAnimState(SmashingPenguinsEnum.eCharacterAnimState.Cry)
    self.fakeCharacterEntity.canPlayRollAnim = false
  else
    self.fakeCharacterEntity.canPlayRollAnim = true
  end
end

function SmashingPenguinsMainAnimCtrl:Delete()
  self:RefreshFakeCharacterState(false)
  if self.frameCtrl:GetIsRunning() then
    self.frameCtrl:StopRunning()
  end
  if self._fireTimer ~= nil then
    TimerManager:StopTimer(self._fireTimer)
    self._fireTimer = nil
  end
end

return SmashingPenguinsMainAnimCtrl
