require("monster_behavior_base")
_class("MonsterBeHaviorGenerator", MonsterBeHaviorBase)
MonsterBeHaviorGenerator = MonsterBeHaviorGenerator

function MonsterBeHaviorGenerator:Name()
  return "MonsterBeHaviorGenerator"
end

function MonsterBeHaviorGenerator:OnInit(param)
  self.genId = param.GeneratorId
  self:InitData()
end

function MonsterBeHaviorGenerator:Exec(dt)
  if self._generator then
    self._generator:OnUpdate(dt)
  end
end

function MonsterBeHaviorGenerator:OnShow()
end

function MonsterBeHaviorGenerator:OnReset()
end

function MonsterBeHaviorGenerator:OnRelease()
end

function MonsterBeHaviorGenerator:InitData()
  local genCfg = Cfg.cfg_bounce_monster_gen[self.genId]
  if genCfg then
    self._generator = MonsterGenerator:New()
    self._generator:Init(self.genId, function()
      local behaviorAni = self:GetBehavior(MonsterBeHaviorAnimation:Name())
      if behaviorAni then
        behaviorAni:PlayAnimation(BounceConst.MonsterAttackAniName)
      end
    end)
  else
    Log.error("MonsterBeHaviorGenerator err:can't find cfg_bounce_monster_gen with id = " .. self.genId)
  end
end

function MonsterBeHaviorGenerator:SetCoreController()
  if self._generator then
    self._generator:SetCoreController(self:GetCoreController())
  end
end
