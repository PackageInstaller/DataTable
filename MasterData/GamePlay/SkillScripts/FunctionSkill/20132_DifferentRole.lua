local bs_20132 = class("bs_20132", LuaSkillBase)
local base = LuaSkillBase
bs_20132.config = {buffId = 110010, selectTargetId = 501101}

function bs_20132:ctor()
end

function bs_20132:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20132_1", 1, self.OnAfterBattleStart)
end

function bs_20132:OnAfterBattleStart()
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

function bs_20132:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20132
