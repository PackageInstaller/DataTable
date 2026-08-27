local base = require("GamePlay.SkillScripts.MonsterSkill.50023_equipmentCommonSkill")
local bs_50018 = class("bs_50018", base)
bs_50018.config = {
  buffId_taunt = 3002,
  heal_configId = 3,
  effectId_taunt = 5001802,
  selectId_taunt = 9
}

function bs_50018:ctor()
end

function bs_50018:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_50018:OnAfterBattleStart()
  local caster = LuaSkillCtrl:GetEquipmentSummonerOrHostEntity(self.caster)
  if caster ~= nil then
    self.heal = LuaSkillCtrl:StartTimer(nil, self.arglist[1], BindCallback(self, self.Heal_time, caster), nil, -1)
    self.taunt = LuaSkillCtrl:StartTimer(nil, self.arglist[3], BindCallback(self, self.Taunt_time, caster), nil, -1)
  else
    self.heal = LuaSkillCtrl:StartTimer(nil, self.arglist[1], BindCallback(self, self.Heal_time, self.caster), nil, -1)
    self.taunt = LuaSkillCtrl:StartTimer(nil, self.arglist[3], BindCallback(self, self.Taunt_time, self.caster), nil, -1)
  end
end

function bs_50018:Heal_time(caster)
  if caster ~= nil and caster.hp > 0 then
    base.OnSyncAttrFromHost(self, caster)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, caster)
    LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_configId, {
      self.arglist[2]
    }, true)
    skillResult:EndResult()
  end
end

function bs_50018:Taunt_time(caster)
  if caster ~= nil and caster.hp > 0 then
    local num = 2 - caster.attackRange
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_taunt, num, caster)
    LuaSkillCtrl:CallEffect(caster, self.config.effectId_taunt, self)
    if 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        if targetList[i].targetRole.belongNum ~= self.caster.belongNum then
          LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId_taunt, 1, self.arglist[4], nil, caster)
        end
      end
    end
  end
end

function bs_50018:OnCasterDie()
  base.OnCasterDie(self)
  if self.heal ~= nil then
    self.heal:Stop()
    self.heal = nil
  end
  if self.taunt ~= nil then
    self.taunt:Stop()
    self.taunt = nil
  end
end

return bs_50018
