require("monster_behavior_base")
_class("MonsterBeHaviorMove", MonsterBeHaviorBase)
MonsterBeHaviorMove = MonsterBeHaviorMove

function MonsterBeHaviorMove:Name()
  return "MonsterBeHaviorMove"
end

function MonsterBeHaviorMove:OnInit(param)
  self._initSpeed = param.Speed
  self._curSpeed = self._initSpeed
  self:_InitDiretonBySpeed()
end

function MonsterBeHaviorMove:_InitDiretonBySpeed()
  if self._initSpeed > 0 then
    self._direction = BounceMoveDirection.ToRight
  else
    self._direction = BounceMoveDirection.ToLeft
  end
end

function MonsterBeHaviorMove:ChgDirection()
  self._curSpeed = self._curSpeed * -1
  self:_InitDiretonBySpeed()
end

function MonsterBeHaviorMove:Exec(dt)
  if not self._posBehavior then
    self._posBehavior = self:GetBehavior(MonsterBeHaviorPosition:Name())
  end
  if not self.bounceData then
    self.bounceData = self:GetBounceData()
  end
  if not self.guideModule then
    self.guideModule = GameGlobal.GetModule(GuideModule)
  end
  local pos = self._posBehavior:GetPosition()
  pos.x = pos.x + self._curSpeed * dt / 1000
  self._posBehavior:SetPosition(pos)
  if self.bounceData.levelId == 6 and not self.guideModule:IsGuideDone(BounceConst.GuideBoss2) then
    local cfg = self:GetCfg()
    if cfg and cfg.ID == 100006 and pos.x < BounceConst.GuideBoss2_BulletPos1 then
      self:GetCoreController():SetGuidePosition(BounceConst.GuideBoss2_BulletPosKey1, pos)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIBounceMainControllerBoss2)
      self.bounceData.guidingId = BounceConst.GuideBoss2
      local isGuiding = self.guideModule:IsGuideProcess(BounceConst.GuideBoss2)
      self.bounceData:SetIsGuiding(isGuiding)
    end
  end
  return pos
end

function MonsterBeHaviorMove:OnShow()
end

function MonsterBeHaviorMove:OnReset()
  self._curSpeed = self._initSpeed
  self:_InitDiretonBySpeed()
end

function MonsterBeHaviorMove:OnRelease()
end
