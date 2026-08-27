local bs_20040 = class("bs_20040", LuaSkillBase)
local base = LuaSkillBase
bs_20040.config = {
  buffId1 = 164,
  buffId2 = 256,
  skillDelay = 60
}

function bs_20040:ctor()
end

function bs_20040:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.caster.roleDataId ~= 30001 and self.caster.roleDataId ~= 30002 then
    return
  end
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_20040_3", 3, self.OnAfterPlaySkill)
end

function bs_20040:OnAfterPlaySkill(skill, role)
  if skill.dataId == 201003 then
    local arriveCallBack = BindCallback(self, self.OnArriveAction, skill.maker)
    LuaSkillCtrl:StartTimer(nil, self.config.skillDelay, arriveCallBack, self, 1)
  end
end

function bs_20040:OnArriveAction(role)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId1, 0)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId2, 0)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 5, 10)
  if targetlist.Count < 1 then
    return
  end
end

function bs_20040:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20040
