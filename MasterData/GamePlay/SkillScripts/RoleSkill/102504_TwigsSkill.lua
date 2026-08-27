local bs_102502 = require("GamePlay.SkillScripts.RoleSkill.102502_TwigsSkill")
local bs_102504 = class("bs_102504", bs_102502)
local base = bs_102502
bs_102504.config = {buffId_CH2 = 102505, weaponLv = 1}
bs_102504.config = setmetatable(bs_102504.config, {
  __index = base.config
})

function bs_102504:ctor()
end

function bs_102504:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102504:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffId_Hua and removeType == eBuffRemoveType.Timeout then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.Aoe)
    if skillResult.roleList.Count > 0 then
      for i = 0, skillResult.roleList.Count - 1 do
        local role = skillResult.roleList[i]
        if 0 < role:GetBuffTier(self.config.buffId_CH) then
          LuaSkillCtrl:DispelBuff(role, self.config.buffId_CH, 0)
          if 0 < role:GetBuffTier(self.config.buffId_CH2) then
            LuaSkillCtrl:DispelBuff(role, self.config.buffId_CH2, 0)
          end
        end
      end
    end
    skillResult:EndResult()
  end
  self:OnSkillDamageEnd()
end

function bs_102504:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102504
