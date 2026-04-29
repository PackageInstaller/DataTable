_class("Quest", Object)
Quest = Quest

function Quest:Constructor(qinfo)
  self._questInfo = qinfo
end

function Quest:IsHomeLandQuestComplete()
  if self._questInfo.status == QuestStatus.QUEST_Completed then
    return true
  end
  if self._questInfo.QuestType >= QuestType.QT_Homeland_Group_Rookie and self._questInfo.QuestType < 120 then
    return self._questInfo.IsGroupTaskSatisfy
  end
  return false
end

function Quest:Update(info)
  if self._questInfo.status == QuestStatus.QUEST_Accepted and info.status == QuestStatus.QUEST_Completed and info.QuestType == QuestType.QT_Achieve then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestAchiUpdate, {
      info.quest_id
    })
  end
  self._questInfo = info
end

function Quest:ID()
  return self._questInfo.quest_id
end

function Quest:QuestInfo()
  return self._questInfo
end

function Quest:Status()
  return self._questInfo.status
end

function Quest:CondDesc()
  return self._condDesc
end

function Quest:ShowType()
  return self._questInfo.ShowType
end

function Quest:GrowthStage()
  return self._questInfo.GrowthStage
end

function Quest:BuildDesc()
  local cond_desc
  local s = StringTable.Get(self._questInfo.CondDesc)
  if s then
    cond_desc = s
  end
  local paramList = self:ParseParams(self._questInfo.Cond)
  if paramList then
    for i, v in ipairs(paramList) do
      cond_desc = string.gsub(cond_desc, "{" .. i - 1 .. "}", v)
    end
  end
  return cond_desc
end

function Quest:ParseParams(cond)
  if cond == nil then
    return
  end
  local resList = {}
  local paramList = GameHelper.StringSplit(cond, "[()&|,]")
  for _, v in ipairs(paramList) do
    local index = string.find(v, ":")
    if index then
      resList[#resList + 1] = string.sub(v, index + 1)
    else
      resList[#resList + 1] = v
    end
  end
  return resList
end
