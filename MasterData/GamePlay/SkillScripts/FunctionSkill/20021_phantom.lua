local bs_20021 = class("bs_20021", LuaSkillBase)
local base = LuaSkillBase
bs_20021.config = {effectId = 10164}

function bs_20021:ctor()
end

function bs_20021:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    if self.caster ~= nil then
      local skills = self.caster:GetBattleSkillList()
      if skills ~= nil then
        local count = skills.Count
        if 0 < count then
          for i = 0, count - 1 do
            local curCd = skills[i].totalCDTime
            if not skills[i].isCommonAttack then
              LuaSkillCtrl:CallResetCDForSingleSkill(skills[i], curCd)
            end
          end
          self:PlayChipEffect()
          LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
        end
      end
    end
  end)
end

function bs_20021:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_20021:LuaDispose()
  base.LuaDispose(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_20021
