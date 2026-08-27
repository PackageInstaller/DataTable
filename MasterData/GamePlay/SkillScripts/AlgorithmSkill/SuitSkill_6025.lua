local bs_6025 = class("bs_6025", LuaSkillBase)
local base = LuaSkillBase
bs_6025.config = {buffId_1 = 602501}

function bs_6025:ctor()
end

function bs_6025:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_106201_7", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, nil, 2)
end

function bs_6025:OnAfterAddBuff(buff, target)
  if buff.buffType == 2 and target.belonfNum ~= self.caster.belongNum then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_1, 1, self.arglist[2], true)
  end
end

function bs_6025:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6025
