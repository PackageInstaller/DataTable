local bs_80015 = class("bs_80015", LuaSkillBase)
local base = LuaSkillBase
bs_80015.config = {curCd = 15}

function bs_80015:ctor()
end

function bs_80015:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_80015_1", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, nil, nil, eBuffFeatureType.Stun)
end

function bs_80015:OnAfterAddBuff(buff, target)
  if target.belongNum == eBattleRoleBelong.enemy then
    local skills = target:GetBattleSkillList()
    if skills ~= nil then
      local count = skills.Count
      if 0 < count then
        for i = 0, count - 1 do
          local curCd = -self.config.curCd
          if not skills[i].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[i], curCd)
          end
        end
      end
    end
  end
end

function bs_80015:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_80015
