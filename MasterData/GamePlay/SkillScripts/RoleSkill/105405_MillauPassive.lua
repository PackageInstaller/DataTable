local bs_105404 = require("GamePlay.SkillScripts.RoleSkill.105404_MillauPassive")
local bs_105405 = class("bs_105405", bs_105404)
local base = bs_105404
bs_105405.config = {
  start_cookTier = 3,
  max_cookTier = 5,
  weaponLv = 2,
  buffId_defense = 105415
}
bs_105405.config = setmetatable(bs_105405.config, {
  __index = base.config
})

function bs_105405:ctor()
end

function bs_105405:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105405:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
end

function bs_105405:AddDropEffectAuto(entity)
  local buff1 = LuaSkillCtrl:GetRoleBuffById(entity, self.config.buffId_tasterMark)
  if buff1 ~= nil then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_attackUpG2, 2, self.arglist[6])
    local value1 = self.caster.def * (self.arglist[8] + self.cook * self.arglist[14]) // 1000 * 2
    if 0 < value1 then
      LuaSkillCtrl:AddRoleShield(entity, eShieldType.Normal, value1)
      local SelfShieldValue = LuaSkillCtrl:GetShield(entity, 0)
      if SelfShieldValue ~= 0 then
        LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_shield, 1)
      end
    end
  else
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_attackUpG, 1, self.arglist[6])
    local value2 = self.caster.def * (self.arglist[8] + self.cook * self.arglist[14]) // 1000
    if 0 < value2 then
      LuaSkillCtrl:AddRoleShield(entity, eShieldType.Normal, value2)
      local SelfShieldValue = LuaSkillCtrl:GetShield(entity, 0)
      if SelfShieldValue ~= 0 then
        LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_shield, 1)
      end
    end
  end
end

function bs_105405:AddDropEffectPick(entity)
  local buff1 = LuaSkillCtrl:GetRoleBuffById(entity, self.config.buffId_tasterMark)
  if buff1 ~= nil then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_attackUp2, 2, self.arglist[6])
    local value1 = self.caster.def * (self.arglist[4] + self.cook * self.arglist[14]) // 1000 * 2
    if 0 < value1 then
      LuaSkillCtrl:AddRoleShield(entity, eShieldType.Normal, value1)
      local SelfShieldValue = LuaSkillCtrl:GetShield(entity, 0)
      if SelfShieldValue ~= 0 then
        LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_shield, 1)
      end
    end
  else
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_attackUp, 1, self.arglist[6])
    local value2 = self.caster.def * (self.arglist[4] + self.cook * self.arglist[14]) // 1000
    if 0 < value2 then
      LuaSkillCtrl:AddRoleShield(entity, eShieldType.Normal, value2)
      local SelfShieldValue = LuaSkillCtrl:GetShield(entity, 0)
      if SelfShieldValue ~= 0 then
        LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_shield, 1)
      end
    end
  end
end

return bs_105405
