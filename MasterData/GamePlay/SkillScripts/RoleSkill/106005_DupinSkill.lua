local bs_106002 = require("GamePlay.SkillScripts.RoleSkill.106002_DupinSkill")
local bs_106005 = class("bs_106005", bs_106002)
local base = bs_106002
bs_106005.config = {
  weaponLv = 2,
  selectId = 9,
  buffId_A = 106001
}
bs_106005.config = setmetatable(bs_106005.config, {
  __index = base.config
})

function bs_106005:ctor()
end

function bs_106005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.trigger_num = self.arglist[9]
  self.recover_num = self.arglist[10]
  self.recover_pro = self.arglist[11]
  self:AddLuaTrigger(eSkillLuaTrigger.DupinExDam, self.recoverclue, 2)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_106005_02", 1, self.OnAfterBattleStart)
end

function bs_106005:OnAfterBattleStart()
  self.caster.recordTable.weaponlv2 = true
end

function bs_106005:recoverclue(target)
  if self.config.weaponLv >= 2 and target.belongNum == eBattleRoleBelong.enemy and self.caster:GetBuffTier(self.config.buffId_skill) > 0 then
    local roleList = LuaSkillCtrl:FindRolesAroundRole(target)
    local count_around = 0
    if roleList ~= nil and 0 < roleList.Count then
      count_around = roleList.Count
      for i = roleList.Count - 1, 0, -1 do
        if roleList[i].belongNum ~= eBattleRoleBelong.enemy then
          count_around = count_around - 1
        end
      end
    end
    local recoverclue = self.recover_num
    if count_around < self.trigger_num and LuaSkillCtrl:CallRange(1, 1000) <= self.recover_pro or 0 < target:GetBuffTier(self.config.buffId_spe) then
      self.caster.recordTable.clueCount = self.caster.recordTable.clueCount + recoverclue
      if self.caster.recordTable.weaponlv3 then
        self.caster.recordTable.exClueCount = self.caster.recordTable.exClueCount + recoverclue
      end
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_A, recoverclue)
    end
  end
end

function bs_106005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106005
