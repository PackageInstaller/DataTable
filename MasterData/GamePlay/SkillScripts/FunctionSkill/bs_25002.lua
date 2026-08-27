local bs_25002 = class("bs_25002", LuaSkillBase)
local base = LuaSkillBase
bs_25002.config = {buffId = 110073, selectTargetId = 501101}

function bs_25002:ctor()
end

function bs_25002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25002_1", 1, self.OnAfterBattleStart)
end

function bs_25002:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, self.config.selectTargetId, 10)
  if targetlist == nil or targetlist.Count <= 0 then
    return
  end
  local tempCareerDict = {}
  local differentCareer = 0
  for i = 0, targetlist.Count - 1 do
    local v = targetlist[i]
    local curCareer = v.targetRole.career
    if not tempCareerDict[curCareer] then
      tempCareerDict[curCareer] = true
      differentCareer = differentCareer + 1
    end
  end
  if differentCareer <= 0 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local role = targetlist[i].targetRole
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, differentCareer)
    role:UpdateHp()
  end
end

function bs_25002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25002
