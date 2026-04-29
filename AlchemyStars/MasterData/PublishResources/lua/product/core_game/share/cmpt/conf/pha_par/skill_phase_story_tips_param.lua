require("skill_phase_param_base")
_class("SkillPhaseStoryTipsParam", SkillPhaseParamBase)
SkillPhaseStoryTipsParam = SkillPhaseStoryTipsParam

function SkillPhaseStoryTipsParam:Constructor(t)
  self._prob = t.prob
  self._tipsList = t.tipsList
end

function SkillPhaseStoryTipsParam:GetCacheTable()
  return nil
end

function SkillPhaseStoryTipsParam:GetPhaseType()
  return SkillViewPhaseType.StoryTips
end

function SkillPhaseStoryTipsParam:GetProb()
  return self._prob
end

function SkillPhaseStoryTipsParam:GetTipsList()
  return self._tipsList
end
