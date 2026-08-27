local bs_105402 = require("GamePlay.SkillScripts.RoleSkill.105402_MillauSkill")
local bs_105406 = class("bs_105406", bs_105402)
local base = bs_105402
bs_105406.config = {
  weaponLv = 3,
  buffID = 105416,
  buffID_Ult = 105417
}
bs_105406.config = setmetatable(bs_105406.config, {
  __index = base.config
})

function bs_105406:ctor()
end

function bs_105406:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnAddShield, self.OnAddShield, self)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_105406_1", 2, self.OnBreakShield)
end

function bs_105406:OnAddShield(role, shieldType)
  if shieldType == 0 and role.belongNum == eBattleRoleBelong.player and role.roleType == eBattleRoleType.character then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffID, 1)
    LuaSkillCtrl:CallBuff(self, role, self.config.buffID_Ult, 1)
  end
end

function bs_105406:OnBreakShield(shieldType, sender, target)
  if shieldType == 0 and 0 < target:GetBuffTier(self.config.buffID) then
    LuaSkillCtrl:DispelBuff(target, self.config.buffID, 0)
    LuaSkillCtrl:DispelBuff(target, self.config.buffID_Ult, 0)
  end
end

function bs_105406:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105406
