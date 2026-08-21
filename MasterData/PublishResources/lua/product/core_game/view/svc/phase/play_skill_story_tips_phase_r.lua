require("play_skill_phase_base_r")
_class("PlaySkillStoryTipsPhase", PlaySkillPhaseBase)
PlaySkillStoryTipsPhase = PlaySkillStoryTipsPhase

function PlaySkillStoryTipsPhase:PlayFlight(TT, casterEntity, phaseParam)
  local param = phaseParam
  local prob = param:GetProb()
  local tipsList = param:GetTipsList()
  local rand = Mathf.Random(1, 100)
  if prob >= rand then
    local index = Mathf.Random(1, #tipsList)
    local monsterTemplateID = casterEntity:MonsterID():GetMonsterID()
    local innerStoryService = self._world:GetService("InnerStory")
    innerStoryService:DoMonsterStoryTips(monsterTemplateID, casterEntity:GetID(), tonumber(tipsList[index]))
  end
end
