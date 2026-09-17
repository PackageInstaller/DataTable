local this = class("moduleActivitySurveyGE", L_GameEventStore.baseGameEventCls)

function this:initData()
  self.data.curDay = 1
  self.data.finish = false
  self.data.showRed = false
  self.data.kiboList = {}
  self.data.finishList = {}
  self:initFakeData()
end

function this:populate(protoData)
end

function this:initFakeData()
  self.data.curDay = 6
  self.data.kiboList = {
    [500001] = 0,
    [500002] = 2,
    [500003] = 2,
    [500004] = 2,
    [500005] = 1,
    [500006] = 0
  }
  self.data.finishList = {
    [102] = true,
    [103] = true
  }
  self.data.finish = false
end

function this:getData()
  return self.data
end

function this:SetRedState(show)
end

function this:getRedState()
  local activityId = self.data:getActivityId()
  local GameEventTpl = L_GameTpl:getGameEventsTpl()
  local GameEventsKiboSurveyTpl = L_GameTpl:getGameEventsKiboSurveyTpl()
  local tpl = GameEventTpl:getTplById(activityId)
  local systemId = GameEventTpl:getSystemId(tpl)
  local groupData = GameEventsKiboSurveyTpl:getGroupData(systemId)
  for i, v in ipairs(groupData) do
    if self:getHasAward(v.id) then
      return true
    end
  end
  return false
end

function this:isActivityCompleted()
  return self.data.finish
end

function this:getHasAward(id)
  local activityId = self.data:getActivityId()
  local GameEventsKiboSurveyTpl = L_GameTpl:getGameEventsKiboSurveyTpl()
  local kiboSurveyTpl = GameEventsKiboSurveyTpl:getTplById(id)
  local kiboList = self.data.kiboList
  local finishList = self.data.finishList
  local curDay = self.data.curDay
  local surveyTpl = GameEventsKiboSurveyTpl:getTplById(id)
  local unlockTime = GameEventsKiboSurveyTpl:getUnlockTime(surveyTpl)
  if curDay < unlockTime then
    return false
  end
  local totalFinish = finishList[id] or false
  if totalFinish then
    return false
  end
  local kiboMission = GameEventsKiboSurveyTpl:getKiboMission(surveyTpl)
  local finishedCount = 0
  for i, v in ipairs(kiboMission) do
    local curNum = kiboList[v[2]]
    local maxNum = v[3]
    if curNum >= maxNum then
      finishedCount = finishedCount + 1
    end
  end
  local needNum = GameEventsKiboSurveyTpl:getKiboMissionSelect(surveyTpl)
  if finishedCount >= needNum then
    return true
  end
  return false
end

return this
