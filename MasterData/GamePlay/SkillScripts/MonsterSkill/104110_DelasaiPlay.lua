local bs_104101 = require("GamePlay.SkillScripts.RoleSkill.104101_DeLaceyPassive")
local bs_104110 = class("bs_104110", bs_104101)
local base = bs_104101
bs_104110.config = {}
bs_104110.config = setmetatable(bs_104110.config, {
  __index = base.config
})

function bs_104110:ctor()
end

function bs_104110:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.CallBuffForSameCamp)
end

function bs_104110:CallBuffForSameCamp(role)
  if role == self.caster then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 3, 20)
    local attack_int = 0
    local up_type = 0
    if targetList ~= nil and 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i].targetRole
        if role.belongNum == self.caster.belongNum and (attack_int < role.pow or role.skill_intensity) then
          self.caster.recordTable.pass_target = role
          if role.pow > role.skill_intensity then
            attack_int = role.pow
            up_type = 1
          else
            attack_int = role.skill_intensity
            up_type = 2
          end
        end
      end
    end
    if self.caster.recordTable.pass_target ~= nil then
      local onPassiveHeal = BindCallback(self, self.OnPassiveHeal, self.caster.recordTable.pass_target)
      self.passive_time = LuaSkillCtrl:StartTimer(nil, self.arglist[1], onPassiveHeal, self, -1)
      if up_type == 1 then
        LuaSkillCtrl:CallBuff(self, self.caster.recordTable.pass_target, self.config.buffId_pow, 1, nil, true)
      else
        LuaSkillCtrl:CallBuff(self, self.caster.recordTable.pass_target, self.config.buffId_skill, 1, nil, true)
      end
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
      LuaSkillCtrl:CallEffect(self.caster.recordTable.pass_target, self.config.effectId_start, self)
      self.loop_effect = LuaSkillCtrl:CallEffect(self.caster.recordTable.pass_target, self.config.effectId_line, self)
      self.loop_effect2 = LuaSkillCtrl:CallEffect(self.caster.recordTable.pass_target, self.config.effectId_line_go, self)
      self.loop_effect3 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_line_go, self, nil, self.caster.recordTable.pass_target)
      self.loop_caster_quan = LuaSkillCtrl:CallEffect(self.caster.recordTable.pass_target, self.config.effectId_quan, self)
    end
  end
end

function bs_104110:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104110
