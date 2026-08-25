local PlayerDataExpression, Super = System.NewClass("PlayerDataExpression", BaseExpression)

function PlayerDataExpression:ctor()
  Super.ctor(self)
  self.cmdFuncs = {}
  self.memberValues = {}
  Super.InitGetter(self)
end

function PlayerDataExpression:_GetPlayerData()
  if bg.battleScene then
    return bg.battleDataCenter.playerDataModel
  else
    return DataCenter.playerData.DRole
  end
end

function PlayerDataExpression:GetAttr(attrName)
  local playerData = self:_GetPlayerData()
  if not playerData then
    return 0
  end
  local attrValue
  if playerData.GetProperty then
    attrValue = playerData:GetProperty(attrName)
  elseif playerData.attrs then
    attrValue = playerData.attrs[attrName]
  end
  return attrValue or 0
end

function PlayerDataExpression:GetStateLayer(stateId)
  if bg.battleScene then
    local playerRole = bg.battleScene:GetPlayerRole()
    local stateList = bg.battleDataCenter.stateData:GetStateListByOwner(playerRole.uid)
    for _, state in ipairs(stateList) do
      if state.stateId == stateId and state.layer then
        return state.layer
      end
    end
    return 0
  else
    do return StateDataUtils.GetLayer end
    return StateDataUtils.GetLayer, stateId, 0, ipairs(stateList)
  end
end

return PlayerDataExpression
