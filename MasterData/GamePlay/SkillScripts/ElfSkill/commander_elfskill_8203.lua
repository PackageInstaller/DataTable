local bs_8203 = class("bs_8203", LuaSkillBase)
local base = LuaSkillBase
bs_8203.config = {effectId_reduce = 606, buff_id = 605}

function bs_8203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_8203:CheckManualSkillTakeAvailable(role)
  local skills = role:GetBattleSkillList()
  local num = 0
  if skills ~= nil then
    local skillCount = skills.Count
    if 0 < skillCount then
      for j = 0, skillCount - 1 do
        if skills[j].isNormalSkill then
          num = num + 1
        end
      end
    end
  end
  if num == 0 then
    return false
  end
  return base.CheckManualSkillTakeAvailable(self, role)
end

function bs_8203:PlaySkill(data, selectTargetCoord, selectRoles)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_8203:CallSelectExecute(role)
  if role.hp <= 0 then
    return
  end
  if role.belongNum == eBattleRoleBelong.enemy then
    local curCd = self:GetCurMainSkillCd(role)
    local offset = self.arglist[1]
    if 1000 < offset then
      offset = 1000
    end
    curCd = -curCd * offset // 1000
    LuaSkillCtrl:CallEffect(role, self.config.effectId_reduce, self)
    LuaSkillCtrl:CallResetCDNumForRole(role, curCd)
    LuaSkillCtrl:CallBuff(self, role, self.config.buff_id, 1, nil, true)
  end
end

function bs_8203:GetCurMainSkillCd(role)
  local skillMgr = role:GetSkillComponent()
  if skillMgr == nil then
    return 0
  end
  if skillMgr.currentFixedSkill ~= nil then
    return skillMgr.currentFixedSkill.CurCDTime
  end
  return role:GetMainSkillCurCd()
end

function bs_8203:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8203
