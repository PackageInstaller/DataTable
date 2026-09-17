local cls_guideData = class("guideData")
local guideGroupTpl = L_GameTpl:getGuideGroupTpl()

function cls_guideData:ctor(id)
  self.id = id
  self.step = 0
end

local cls = {}
cls.dataClass = {guideData = cls_guideData}

function cls:state()
  return {}
end

function cls:init()
  cls.super.init(self)
  self.data = {
    guideDataMap = {},
    setHasInitSync = false,
    mutualCompleteMap = {},
    enabledConditions = {}
  }
end

function cls:isGuideComplete(id, isCheckOne)
  if L_GuideManager:isOnDebugMode() then
    return false
  end
  self.data.guideDataMap[id] = self.data.guideDataMap[id] or {}
  if isCheckOne then
    return self.data.guideDataMap[id][0] == true
  end
  if self.data.guideDataMap[id][0] == true then
    return true
  end
  if self:isMutualGuideComplete(id) then
    return true
  end
  return false
end

function cls:isMutualGuideComplete(id)
  if L_GuideManager:isOnDebugMode() then
    return false
  end
  local map = self.data.mutualCompleteMap
  if not map then
    return false
  end
  return map[id] == true
end

function cls:isGuideStepComplete(id, step)
  if L_GuideManager:isOnDebugMode() then
    return false
  end
  self.data.guideDataMap[id] = self.data.guideDataMap[id] or {}
  return self.data.guideDataMap[id][step] == true
end

function cls:getUnlockGuideDataMapIds()
  local ids = {}
  for i, v in pairs(self.data.guideDataMap) do
    if self:isGuideComplete(i) then
      table.insert(ids, i)
    end
  end
  table.sort(ids, function(a, b)
    return a < b
  end)
  return ids
end

function cls:onGuideCompleted(guideId)
  local groupTpl = guideGroupTpl:getTplById(guideId)
  if not groupTpl then
    return
  end
  local mutualIds = guideGroupTpl:getMutualExclusion(groupTpl)
  if not mutualIds or #mutualIds == 0 then
    return
  end
  self.data.mutualCompleteMap = self.data.mutualCompleteMap or {}
  for _, mutualId in ipairs(mutualIds) do
    self.data.guideDataMap[mutualId] = self.data.guideDataMap[mutualId] or {}
    if self.data.guideDataMap[mutualId][0] ~= true then
      self.data.mutualCompleteMap[mutualId] = true
    end
  end
end

function cls:checkConditionEnabled(id)
  return not self.data.enabledConditions[id] == nil
end

return cls
