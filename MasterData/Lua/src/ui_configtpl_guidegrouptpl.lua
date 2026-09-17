local this = class("guideGroupTpl")

function this:init(config)
  self.data = config
  self.workingGuide = {}
  for _, v in pairs(self.data) do
    if v.isWorking then
      table.insert(self.workingGuide, v)
    end
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getIsBattleGuide(tpl)
  return tpl.isBattleGuide
end

function this:getTriggerSource(tpl)
  return tpl.triggerSource
end

function this:getBavTreePath(tpl)
  return tpl.bavTreePath
end

function this:getData()
  return self.workingGuide
end

function this:getIsWorking(tpl)
  return tpl.isWorking
end

function this:getIsBattle(tpl)
  return tpl.isBattle
end

function this:getIsHome(tpl)
  return tpl.isHome
end

function this:getTutorialId(tpl)
  return tpl.tutorialId
end

function this:getGuideType(tpl)
  return tpl.guideType
end

function this:getGuideAndCondition(tpl)
  return tpl.guideAndCondition
end

function this:getGuideOrCondition(tpl)
  return tpl.guideOrCondition
end

function this:getMutualExclusion(tpl)
  return tpl.mutualExclusion
end

function this:getIsNoBattle(tpl)
  return tpl.isNoBattle
end

function this:getTriggerScene(tpl)
  return tpl.triggerScene
end

function this:getGuidePriority(tpl)
  return tpl.guidePriority or 0
end

function this:getIsRepeat(tpl)
  return tpl.isRepeat
end

function this:getIsBreak(tpl)
  return tpl.isBreak
end

function this:getGuideAndDisableCondition(tpl)
  return tpl.guideAndDisableCondition
end

function this:getGuideOrDisableCondition(tpl)
  return tpl.guideOrDisableCondition
end

return this
