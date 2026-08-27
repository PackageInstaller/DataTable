local bs_82021 = class("bs_82021", LuaSkillBase)
local base = LuaSkillBase
bs_82021.config = {buff_ranjie = 107101, buff_damageup = 702}

function bs_82021:ctor()
end

function bs_82021:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_82021_1", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buff_ranjie)
  self:AddBuffDieTrigger("bs_82021_2", 1, self.OnBuffDie, nil, nil, self.config.buff_ranjie)
end

function bs_82021:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buff_ranjie and target ~= nil and target.hp > 0 and target.belongNum ~= eBattleRoleBelong.player then
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_damageup, 1)
  end
end

function bs_82021:OnBuffDie(buff, target, removeType)
  if target ~= nil then
    LuaSkillCtrl:DispelBuff(target, self.config.buff_damageup, 0, true)
  end
end

function bs_82021:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_82021
