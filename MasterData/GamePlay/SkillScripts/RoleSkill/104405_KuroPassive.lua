local bs_104401 = require("GamePlay.SkillScripts.RoleSkill.104401_KuroPassive")
local bs_104405 = class("bs_104405", bs_104401)
local base = bs_104401
bs_104405.config = {
  weaponLv = 2,
  buff_blind1 = 115,
  buff_blind2 = 3012,
  hurt_config = {crit_formula = 9992, crithur_ratio = 9995}
}
local blindList = {
  108006,
  108008,
  115,
  3012,
  450000115,
  450003012,
  301201,
  1009032,
  208401
}
bs_104405.config = setmetatable(bs_104405.config, {
  __index = base.config
})

function bs_104405:ctor()
end

function bs_104405:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultStartTriggerForTable("bs_104405_01", 10, self.OnHurtResultStart, {
    sender = self.caster
  })
  self.caster.recordTable.weaponLv = 2
  self.caster.recordTable.blind_triNum = self.arglist[4]
  self.caster.recordTable.blind_time = self.arglist[5]
end

function bs_104405:OnHurtResultStart(skill, context)
  local isblind = false
  if skill.skillType == eBattleSkillLogicType.Original and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey and context.hurt_type ~= 2 then
    local critFurmula = context.config.crit_formula
    if critFurmula == nil or critFurmula == 0 then
      for k, v in pairs(blindList) do
        if 0 < context.target:GetBuffTier(v) then
          isblind = true
          break
        end
      end
      if isblind then
        context.new_config = self.config.hurt_config
        setmetatable(context.new_config, {
          __index = context.config
        })
        return
      end
    end
  end
end

function bs_104405:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_104405:LuaDispose()
  base.LuaDispose(self)
end

return bs_104405
