local bs_100202 = require("GamePlay.SkillScripts.RoleSkill.100202_AnnaSkill")
local bs_100205 = class("bs_100205", bs_100202)
local base = bs_100202
bs_100205.config = {
  weaponLv = 2,
  effectId_trail = 100208,
  effectId_line = 100207,
  effectId_trail3 = 100219,
  buffId_cockhourse2 = 100203,
  time = nil,
  tier = 1,
  tier_skill = 1,
  selectId_skill = 9,
  select_range = 10,
  hurt_config_extra = {
    hit_formula = 0,
    def_formula = 0,
    basehurt_formula = 100201,
    crit_formula = 0,
    returndamage_formula = 0,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  }
}
bs_100205.config = setmetatable(bs_100205.config, {
  __index = base.config
})

function bs_100205:ctor()
end

function bs_100205:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.targetlist = {}
  self:AddLuaTrigger(eSkillLuaTrigger.OnAnnaStun, self.OnAnnaStun)
end

function bs_100205:OnAnnaStun(target)
  local maker = self.caster
  if self.targetlist[target] == nil then
    self.targetlist[target] = 1
  end
  if target.belongNum ~= maker.belongNum and target ~= self.caster and self.cando == true and self.targetlist[target] <= 1 then
    self.targetlist[target] = 2
    LuaSkillCtrl:StartTimer(self, 2, function()
      local transferList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_skill, self.config.select_range)
      if transferList.Count == 0 then
        return
      end
      local num1 = 0
      for i = 0, transferList.Count - 1 do
        local role = transferList[i].targetRole
        if role ~= target and role.intensity ~= 0 then
          num1 = num1 + 1
          if num1 <= 2 then
            LuaSkillCtrl:CallEffect(role, self.config.effectId_trail3, self, self.SkillEventFunc_extra2, target)
          else
            break
          end
        end
      end
    end)
  end
end

function bs_100205:SkillEventFunc_extra2(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config_extra, nil, true)
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_cockhourse2, 1, nil, true)
  end
end

function bs_100205:OnCasterDie()
  base.OnCasterDie(self)
  self.targetlist = {}
end

return bs_100205
