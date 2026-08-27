local base = require("GamePlay.SkillScripts.MonsterSkill.50023_equipmentCommonSkill")
local bs_50019 = class("bs_50019", base)
bs_50019.config = {buffId_Core2 = 5001901}

function bs_50019:ctor()
end

function bs_50019:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_50019:OnAfterBattleStart()
  local caster = LuaSkillCtrl:GetEquipmentSummonerOrHostEntity(self.caster)
  if caster ~= nil then
    LuaSkillCtrl:CallBuff(self, caster, self.config.buffId_Core2, 1)
  else
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Core2, 1)
  end
end

function bs_50019:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_50019
