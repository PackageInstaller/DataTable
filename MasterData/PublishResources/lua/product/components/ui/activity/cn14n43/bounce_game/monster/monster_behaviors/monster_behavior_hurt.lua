require("monster_behavior_base")
_class("MonsterBeHaviorHurt", MonsterBeHaviorBase)
MonsterBeHaviorHurt = MonsterBeHaviorHurt

function MonsterBeHaviorHurt:Name()
  return "MonsterBeHaviorHurt"
end

function MonsterBeHaviorHurt:Exec(ap)
  local monsterData = self:GetMonsterData()
  local monsterOldHp = monsterData.hp
  local newHp = monsterData.hp - ap
  if newHp < 0 then
    newHp = 0
  end
  monsterData.hp = newHp
  self:PlayAudioByLeftHp(newHp)
  local beHaviorProgress = self:GetBehavior(MonsterBeHaviorShowHpProgress:Name())
  if beHaviorProgress then
    beHaviorProgress:SetProgress(newHp)
  end
  local behaviorAni = self:GetBehavior(MonsterBeHaviorAnimation:Name())
  if newHp == 0 then
    local bounceController = self:GetCoreController()
    bounceController:MonsterDead(self.monster:GetMonsterId())
    local deadDuration = 0
    if self.monster.state == BounceObjState.Transformation then
      local beHaviorTransmation = self:GetBehavior("MonsterBeHaviorTransformationWithHp")
      if beHaviorTransmation then
        beHaviorTransmation:ChgResImmediatelyBy(monsterOldHp)
        behaviorAni = self:GetBehavior(MonsterBeHaviorAnimation:Name())
      end
    end
    if behaviorAni then
      behaviorAni:PlayAnimation(BounceConst.MonsterDeadAniName)
    end
    local behaviorView = self:GetBehavior(MonsterBeHaviorView:Name())
    if behaviorView and behaviorView.resCfg then
      local duration = behaviorView.resCfg.DeadDuration
      deadDuration = duration or 0
    end
    self.monster:SetDeadWithDuration(deadDuration)
    return
  elseif behaviorAni then
    behaviorAni:PlayAnimation(BounceConst.MonsterBeAttackedAniName)
  end
  local beHaviorTransmation = self:GetBehavior("MonsterBeHaviorTransformationWithHp")
  if beHaviorTransmation then
    beHaviorTransmation:CheckTransformation(monsterData.hp)
  end
end

function MonsterBeHaviorHurt:PlayAudioByLeftHp(hp)
  local cfg = self:GetCfg()
  if not cfg or not cfg.Audio then
    return
  end
  local audioId
  if 0 < hp then
    audioId = cfg.Audio[BounceConst.MonsterAudioTypeBeAttacked]
  else
    audioId = cfg.Audio[BounceConst.MonsterAudioTypeDead]
  end
  if audioId then
    AudioHelperController.PlayUISoundAutoRelease(audioId)
  end
end

function MonsterBeHaviorHurt:OnInit(param)
end

function MonsterBeHaviorHurt:OnShow()
end

function MonsterBeHaviorHurt:OnReset()
end

function MonsterBeHaviorHurt:OnRelease()
end
