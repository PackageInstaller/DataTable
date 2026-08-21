BattleTeamOrderViewType = {
  Exchange_ChangeTeamLeader = 1,
  FillVacancies_MazePetDead = 2,
  FillVacancies_Skill = 3,
  Exchange_SwapTeamOrder = 4,
  ShuffleTeamOrder = 5
}
_enum("BattleTeamOrderViewType", BattleTeamOrderViewType)
_class("BattleTeamOrderViewRequest", Object)
BattleTeamOrderViewRequest = BattleTeamOrderViewRequest

function BattleTeamOrderViewRequest:Constructor(oldTeamOrder, newTeamOrder, viewType)
  self._oldTeamOrder = oldTeamOrder
  self._newTeamOrder = newTeamOrder
  self._viewType = viewType
end

function BattleTeamOrderViewRequest:GetViewType()
  return self._viewType
end

function BattleTeamOrderViewRequest:GetOldTeamOrder()
  return self._oldTeamOrder
end

function BattleTeamOrderViewRequest:GetNewTeamOrder()
  return self._newTeamOrder
end

function BattleTeamOrderViewRequest:SetRequestSequenceNo(val)
  self._sequenceNo = val
end

function BattleTeamOrderViewRequest:GetRequestSequenceNo()
  return self._sequenceNo
end

function BattleTeamOrderViewRequest:CalSwapPstID()
  local oldOrder = self._oldTeamOrder
  local newOrder = self._newTeamOrder
  local newOrderCount = #newOrder
  local diffIndexs = {}
  for index, value in ipairs(oldOrder) do
    local oldPstID = value
    if index <= newOrderCount then
      local newPstID = newOrder[index]
      if oldPstID ~= newPstID then
        table.insert(diffIndexs, index)
      end
    end
  end
  if #diffIndexs == 2 then
    local pstIdA = oldOrder[diffIndexs[1]]
    local pstIdB = oldOrder[diffIndexs[2]]
    return pstIdA, pstIdB
  end
end
