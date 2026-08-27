local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_107300 = class("bs_107300", bs_1)
local base = bs_1
bs_107300.config = {
  action1 = 1001,
  action2 = 1001,
  effectId_start1 = 107312,
  effectId_hit_target = 107302,
  effectId_start111 = 107301
}
bs_107300.config = setmetatable(bs_107300.config, {
  __index = base.config
})

function bs_107300:ctor()
end

function bs_107300:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.line = nil
end

function bs_107300:SetAttackRole()
  self.displaySelectEfc = false
  local moveTarget = self:GetMoveSelectTarget()
  if moveTarget ~= nil then
    local curAtkRole = moveTarget.targetRole
    if curAtkRole ~= nil then
      if self.lastAttackRole ~= curAtkRole then
        self.displaySelectEfc = true
        if self.line ~= nil then
          self.line:Die()
          self.line = nil
        end
      end
      self.lastAttackRole = curAtkRole
    end
  end
end

function bs_107300:CallSelectEffect()
  if self.displaySelectEfc and self.lastAttackRole ~= nil then
    if self.line == nil then
      self.line = LuaSkillCtrl:CallEffect(self.lastAttackRole, self.config.effectId_start111, self)
    end
    if self.caster.recordTable.completeFirstComatk then
      LuaSkillCtrl:CallSelectTargetEffect(self, self.lastAttackRole)
      self.displaySelectEfc = false
    end
  end
end

function bs_107300:LuaDispose()
  base.LuaDispose(self)
  if self.line ~= nil then
    self.line:Die()
    self.line = nil
  end
end

function bs_107300:OnCasterDie()
  base.OnCasterDie(self)
  if self.line ~= nil then
    self.line:Die()
    self.line = nil
  end
end

return bs_107300
