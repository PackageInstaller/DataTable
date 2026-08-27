local bs_16025 = class("bs_16025", LuaSkillBase)
local base = LuaSkillBase
bs_16025.config = {}

function bs_16025:ctor()
end

function bs_16025:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_16025_8", 1, self.OnAfterAddBuff, nil, nil, nil, eBattleRoleBelong.player, nil)
end

function bs_16025:OnAfterAddBuff(buff, target)
  if target.belongNum == eBattleRoleBelong.player and buff.buffCfg.IsControl == true then
    local value = target.hp * self.arglist[1] // 1000
    LuaSkillCtrl:RemoveLife(value, self, target, true, nil, true, true, eHurtType.RealDmg, false)
    local skill = target:GetBattleSkillList()
    if skill ~= nil then
      local skillCount = skill.Count
      if 0 < skillCount then
        for i = 0, skillCount - 1 do
          local TotalCd = skill[i].totalCDTime * -1 * self.arglist[1] // 1000
          if not skill[i].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skill[i], TotalCd)
          end
        end
      end
    end
  end
end

function bs_16025:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_16025
