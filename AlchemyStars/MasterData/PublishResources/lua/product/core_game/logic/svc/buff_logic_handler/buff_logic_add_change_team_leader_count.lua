_class("BuffLogicAddChangeTeamLeaderCount", BuffLogicBase)
BuffLogicAddChangeTeamLeaderCount = BuffLogicAddChangeTeamLeaderCount

function BuffLogicAddChangeTeamLeaderCount:Constructor(buffInstance, logicParam)
  self._addNum = logicParam.addNum
  self._noLimit = logicParam.noLimit
  self._setZero = logicParam.setZero
end

function BuffLogicAddChangeTeamLeaderCount:DoLogic()
  local teamEntity
  if self._entity:HasTeam() then
    teamEntity = self._entity
  elseif self._entity:HasPet() then
    teamEntity = self._entity:Pet():GetOwnerTeamEntity()
  end
  if teamEntity then
    local teamAttrConmpt = teamEntity:Attributes()
    local curLeftCount = teamAttrConmpt:GetAttribute("ChangeTeamLeaderCount")
    local newCount = 0
    if self._noLimit and self._noLimit == 1 then
      newCount = -1
    elseif self._setZero and self._setZero == 1 then
      newCount = 0
    elseif self._addNum then
      if curLeftCount == -1 then
        return
      else
        newCount = curLeftCount + self._addNum
        if newCount < 0 then
          newCount = 0
        end
      end
    end
    teamAttrConmpt:Modify("ChangeTeamLeaderCount", newCount)
    local result = BuffResultAddChangeTeamLeaderCount:New(teamEntity:GetID(), newCount)
    return result
  end
end
