local bs_20131 = class("bs_20131", LuaSkillBase)
local base = LuaSkillBase
bs_20131.config = {buffId = 110009, selectTargetId = 501101}

function bs_20131:ctor()
end

function bs_20131:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20131_1", 1, self.OnAfterBattleStart)
end

function bs_20131:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, self.config.selectTargetId, 10)
  if targetlist == nil or targetlist.Count <= 0 then
    return
  end
  local tempCareerDict = {}
  local sameCareer = 0
  for i = 0, targetlist.Count - 1 do
    local v = targetlist[i]
    local curCareer = v.targetRole.career
    if tempCareerDict[curCareer] then
      sameCareer = sameCareer + 1
    else
      tempCareerDict[curCareer] = true
    end
  end
  if sameCareer <= 0 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local role = targetlist[i].targetRole
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, sameCareer)
    role:UpdateHp()
  end
end

function bs_20131:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20131
