local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1021012 = class("bs_1021012", base)
bs_1021012.config = {
  effectId_Grid = 10709,
  buffId_lockCD = 170,
  audioId1 = 77,
  AOE = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 10
  }
}

function bs_1021012:ctor()
end

function bs_1021012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1021012_3", 1, self.OnAfterHurt, nil, nil, nil, nil, nil, eBattleRoleType.character)
end

function bs_1021012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss and target.roleType == 1 and target.belongNum == self.caster.belongNum and self.caster:GetBuffTier(self.config.buffId_lockCD) == 0 then
    LuaSkillCtrl:CallResetCDNumForRole(self.caster, self.arglist[1])
  end
end

function bs_1021012:OnCasterDie()
  base.OnCasterDie(self)
  if self.timerhurt ~= nil then
    self.timerhurt:Stop()
    self.timerhurt = nil
  end
  if self.loop ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loop)
    self.loop = nil
  end
end

function bs_1021012:LuaDispose()
  base.LuaDispose(self)
  self.loop = nil
  self.effectQ = nil
end

return bs_1021012
