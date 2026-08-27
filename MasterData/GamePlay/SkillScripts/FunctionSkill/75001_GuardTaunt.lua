local bs_75001 = class("bs_75001", LuaSkillBase)
local base = LuaSkillBase
bs_75001.config = {
  buffId = 3002,
  buffTier = 1,
  a = 0
}

function bs_75001:ctor()
end

function bs_75001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_75001_1", 1, self.OnAfterHurt)
end

function bs_75001:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.intensity == 99 and target.hp < target.maxHp * self.arglist[1] // 1000 and self.config.a == 0 then
    local targetListMax = LuaSkillCtrl:CallTargetSelect(self, 76, 10)
    if 0 < targetListMax.Count then
      for i = 0, targetListMax.Count - 1 do
        if targetListMax[i].targetRole.intensity ~= 99 then
          self.highHpTarget = targetListMax[0].targetRole
          break
        else
          i = i + 1
        end
      end
      local targetListEnemy = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
      for i = 0, targetListEnemy.Count - 1 do
        LuaSkillCtrl:CallBuff(self, targetListEnemy[i].targetRole, self.config.buffId, 1, self.arglist[2])
      end
    end
  end
end

function bs_75001:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_75001:LuaDispose()
  base.LuaDispose(self)
end

return bs_75001
