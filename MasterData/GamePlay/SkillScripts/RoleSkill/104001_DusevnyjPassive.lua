local bs_104001 = class("bs_104001", LuaSkillBase)
local base = LuaSkillBase
bs_104001.config = {
  buffId_1 = 104004,
  buffId_2 = 104005,
  buffId_1z = 104010,
  buffId_2z = 104011,
  buffId_1w = 104013,
  buffId_2w = 104014,
  selectId_player = 34,
  selectId_enemy = 33,
  buffId_attack = 104006,
  buffId_skill = 104007,
  weaponLv = 0
}

function bs_104001:ctor()
end

function bs_104001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_104001_7", 1, self.OnAfterAddBuff, self.caster, self.caster)
  self.caster.recordTable["arglist[3]"] = self.arglist[3]
end

function bs_104001:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_attack then
    local num = 2 - self.caster.attackRange
    local targetList_player = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_player, num)
    if targetList_player.Count > 0 then
      for i = 0, targetList_player.Count - 1 do
        if 1 <= self.config.weaponLv then
          LuaSkillCtrl:CallBuff(self, targetList_player[i].targetRole, self.config.buffId_1w, 1, self.arglist[5])
          LuaSkillCtrl:CallBuff(self, targetList_player[i].targetRole, self.config.buffId_1z, 1, self.arglist[5])
        else
          LuaSkillCtrl:CallBuff(self, targetList_player[i].targetRole, self.config.buffId_1, 1, self.arglist[5])
        end
      end
    end
    local targetList_enemy = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_enemy, num)
    if targetList_enemy.Count > 0 then
      for i = 0, targetList_enemy.Count - 1 do
        if 2 <= self.config.weaponLv then
          LuaSkillCtrl:CallBuff(self, targetList_enemy[i].targetRole, self.config.buffId_2w, 1, self.arglist[5])
          LuaSkillCtrl:CallBuff(self, targetList_enemy[i].targetRole, self.config.buffId_2z, 1, self.arglist[5])
        else
          LuaSkillCtrl:CallBuff(self, targetList_enemy[i].targetRole, self.config.buffId_2, 1, self.arglist[5])
        end
      end
    end
  elseif buff.dataId == self.config.buffId_skill and self.caster.recordTable.skill_open == true then
    local targetList_player = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_player, 10)
    if targetList_player.Count > 0 then
      for i = 0, targetList_player.Count - 1 do
        if 1 <= self.config.weaponLv then
          LuaSkillCtrl:CallBuff(self, targetList_player[i].targetRole, self.config.buffId_1w, 1, self.arglist[5])
          LuaSkillCtrl:CallBuff(self, targetList_player[i].targetRole, self.config.buffId_1z, 1, self.arglist[5])
        else
          LuaSkillCtrl:CallBuff(self, targetList_player[i].targetRole, self.config.buffId_1, 1, self.arglist[5])
        end
      end
    end
    local targetList_enemy = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_enemy, 10)
    if targetList_enemy.Count > 0 then
      for i = 0, targetList_enemy.Count - 1 do
        if 2 <= self.config.weaponLv then
          LuaSkillCtrl:CallBuff(self, targetList_enemy[i].targetRole, self.config.buffId_2w, 1, self.arglist[5])
          LuaSkillCtrl:CallBuff(self, targetList_enemy[i].targetRole, self.config.buffId_2z, 1, self.arglist[5])
        else
          LuaSkillCtrl:CallBuff(self, targetList_enemy[i].targetRole, self.config.buffId_2, 1, self.arglist[5])
        end
      end
    end
  end
end

function bs_104001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104001
