local bs_80008 = class("bs_80008", LuaSkillBase)
local base = LuaSkillBase
bs_80008.config = {}

function bs_80008:ctor()
end

function bs_80008:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_80008_3", 1, self.OnAfterAddBuff, self.caster)
end

function bs_80008:OnAfterAddBuff(buff, target)
  if buff:ContainFeature(eBuffFeatureType.Stun) and target.belongNum ~= self.caster.belongNum then
    local down = self.arglist[1]
    LuaSkillCtrl:CallResetCDNumForRole(self.caster, down)
  end
end

function bs_80008:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_80008
