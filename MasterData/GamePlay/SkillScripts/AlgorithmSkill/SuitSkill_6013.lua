local bs_6013 = class("bs_6013", LuaSkillBase)
local base = LuaSkillBase
bs_6013.config = {buff_yishang = 601301}

function bs_6013:ctor()
end

function bs_6013:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_6013_7", 1, self.OnAfterAddBuff, self.caster)
end

function bs_6013:OnAfterAddBuff(buff, target)
  if buff.buffCfg.IsControl then
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_yishang, 1, self.arglist[2])
  end
end

function bs_6013:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_6013:LuaDispose()
  base.LuaDispose(self)
  self.Ismove = nil
end

return bs_6013
