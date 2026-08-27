local bs_fuji = class("bs_fuji", LuaSkillBase)
local base = LuaSkillBase
bs_fuji.config = {player = 1, enemy = 2}

function bs_fuji:ctor()
end

function bs_fuji:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_fuji_1", 9999, self.OnAfterBattleStart)
end

function bs_fuji:OnAfterBattleStart()
  local roles = LuaSkillCtrl.battleCtrl.PlayerTeamController.battleOriginRoleList
  if roles == nil then
    return
  end
  local roleCount = roles.Count
  if 0 < roleCount then
    for i = 0, roleCount - 1 do
      if roles[i] ~= nil then
        local skills = roles[i]:GetBattleSkillList()
        if skills ~= nil then
          local skillCount = skills.Count
          if 0 < skillCount then
            for j = 0, skillCount - 1 do
              local startCd = skills[j].startCdTime
              local curTotalCd = skills[j].totalCDTime
              LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], (curTotalCd + startCd) // 2)
            end
          end
        end
      end
    end
  end
end

function bs_fuji:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_fuji
