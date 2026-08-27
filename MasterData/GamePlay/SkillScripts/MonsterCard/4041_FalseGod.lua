local bs_4041 = class("bs_4041", LuaSkillBase)
local base = LuaSkillBase
bs_4041.config = {buffId = 40411}

function bs_4041:ctor()
end

function bs_4041:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_4041_2", 1, self.OnAfterPlaySkill)
end

function bs_4041:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack then
    local target = role.recordTable.lastAttackRole
    if target == nil or target.belongNum == self.caster.belongNum then
      return
    end
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, self.arglist[1], true)
  end
end

function bs_4041:LuaDispose()
  base.LuaDispose(self)
end

function bs_4041:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4041
