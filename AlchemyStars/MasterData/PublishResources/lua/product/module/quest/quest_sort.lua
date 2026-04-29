QuestSortType = {
  ID = 0,
  Status = 1,
  CompletedTime = 2
}
QuestSortOrder = {
  None = 0,
  Ascending = 1,
  Descending = 2
}
_class("QuestSortParam", Object)
QuestSortParam = QuestSortParam

function QuestSortParam:Constructor(sort_type, sort_order, ...)
  self._sort_type = sort_type
  self._sort_order = sort_order or QuestSortOrder.Ascending
  self._params = {
    ...
  }
end

function QuestSortParam:GetSortValue(quest)
  if self._sort_type == QuestSortType.ID then
    return quest:ID()
  elseif self._sort_type == QuestSortType.Status then
    local st = quest:Status()
    if st == QuestStatus.QUEST_Completed then
      return 1
    elseif st == QuestStatus.QUEST_Accepted then
      return 2
    elseif st == QuestStatus.QUEST_NotStart then
      return 3
    else
      return 4
    end
  elseif self._sort_type == QuestSortType.CompletedTime then
    return quest:QuestInfo().complete_time
  end
  return 0
end

function QuestSortParam:Compare(a, b)
  local va = self:GetSortValue(a)
  local vb = self:GetSortValue(b)
  if self._sort_order == QuestSortOrder.Ascending then
    return va < vb
  else
    return va > vb
  end
end

_class("QuestSorter", Object)
QuestSorter = QuestSorter

function QuestSorter.Sort(quest_list, sort_params)
  local out = quest_list
  
  local function sort_runner(runner, idx, a, b)
    local sorter = sort_params[idx]
    if sorter == nil then
      return false
    end
    if sorter:GetSortValue(a) == sorter:GetSortValue(b) then
      return runner(runner, idx + 1, a, b)
    else
      return sorter:Compare(a, b)
    end
  end
  
  table.sort(out, function(a, b)
    return sort_runner(sort_runner, 1, a, b)
  end)
  return out
end
