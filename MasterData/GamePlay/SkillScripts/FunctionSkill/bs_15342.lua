local bs_15342 = class("bs_15342", LuaSkillBase)
local base = LuaSkillBase
bs_15342.config = {
  buffId_miniFire = 110150,
  buffId_jisu = 110151,
  newBuffId_miniFire = 110152,
  buffId_hotFire = 107101
}

function bs_15342:ctor()
end

function bs_15342:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15342_1", 1, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_15342_2", 1, self.OnAfterAddBuff, self.caster, nil, nil, eBattleRoleBelong.enemy, self.config.buffId_hotFire)
end

function bs_15342:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_jisu, 1, nil, true)
end

function bs_15342:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_hotFire then
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = self.arglist[2]
          if not skills[j].isCommonAttack then
            self:OnSkillTake()
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
  end
end

function bs_15342:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15342
