require("ai_node_new")
_class("ActionCastChessTransformationSkill", ActionCastSkillBase)
ActionCastChessTransformationSkill = ActionCastChessTransformationSkill

function ActionCastChessTransformationSkill:Constructor()
end

function ActionCastChessTransformationSkill:GetWorkSkillID()
  local skillIndexX = self:GetLogicData(-1)
  local battleFlags = self._world:BattleFlags()
  local skillIndexY = battleFlags:GetChessTransformationIndex()
  local vecSkillList = self:GetConfigSkillList()
  local skillCount = table.count(vecSkillList[skillIndexX])
  skillIndexY = skillIndexY % skillCount
  if skillIndexY == 0 then
    skillIndexY = skillCount
  end
  local nSkillID = self:GetConfigSkillID(skillIndexX, skillIndexY)
  return nSkillID
end
