_class("BuffLogicChangeAutoBeadNeedEnergy", BuffLogicBase)
BuffLogicChangeAutoBeadNeedEnergy = BuffLogicChangeAutoBeadNeedEnergy

function BuffLogicChangeAutoBeadNeedEnergy:Constructor(buffInstance, logicParam)
  self._autoBeadTagList = logicParam.autoBeadTagList
  self._mulValue = logicParam.mulValue or 0
  self._addValue = logicParam.addValue or 0
end

function BuffLogicChangeAutoBeadNeedEnergy:DoLogic(notify)
  local autoBeadServiceLogic = self._world:GetService("AutoBeadLogic")
  local holderEntity = self._entity
  if self._entity:HasTeam() then
    local teamEntity = self._entity
    local autoBeadServiceLogic = self._world:GetService("AutoBeadLogic")
    holderEntity = autoBeadServiceLogic:GetAutoBeadSkillHolder(teamEntity)
  end
  if not holderEntity then
    return
  end
  local oldTotalNeed = 0
  local curTotalNeed = 0
  local tagList = self._autoBeadTagList
  local autoBeadCmpt = holderEntity:LogicAutoBead()
  if autoBeadCmpt then
    oldTotalNeed = autoBeadCmpt:GetAutoBeadPointEachPower()
    local dataList = autoBeadCmpt:GetAutoBeadInnerDataListByTag(tagList)
    for index, data in ipairs(data) do
      local innerData = data
      local oldEnergy = innerData:GetAutoBeadAttr(ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_Energy)
      if oldEnergy then
        local mulAddVal = math.ceil(oldEnergy * self._mulValue)
        local curEnergy = oldEnergy + mulAddVal + self._addValue
        innerData:SetAutoBeadAttr(ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_Energy, curEnergy)
      end
    end
    autoBeadServiceLogic:CalcAutoBeadNeedEnergy(teamEntity)
    curTotalNeed = autoBeadCmpt:GetAutoBeadPointEachPower()
  end
  local result = BuffResultChangeAutoBeadNeedEnergy:New(curTotalNeed, oldTotalNeed)
  return result
end
