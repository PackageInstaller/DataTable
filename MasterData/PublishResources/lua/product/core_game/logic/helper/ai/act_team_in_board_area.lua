local AITeamInBoardAreaType = {
  UpArea = 1,
  DownArea = 2,
  LeftArea = 3,
  RightArea = 4
}
_enum("AITeamInBoardAreaType", AITeamInBoardAreaType)
require("action_is_base")
_class("ActionTeamInBoardArea", ActionIsBase)
ActionTeamInBoardArea = ActionTeamInBoardArea

function ActionTeamInBoardArea:Constructor()
end

function ActionTeamInBoardArea:OnUpdate()
  local entityCaster = self.m_entityOwn
  local aiComponent = entityCaster:AI()
  if nil == aiComponent then
    return AINewNodeStatus.Failure
  end
  local areaType = self:GetLogicData(-1)
  local excludeEqual = self:GetLogicData(-2)
  self:PrintDebugLog("areaType=", areaType, "excludeEqual=", excludeEqual)
  local bSuccess = self:IsTeamInBoardArea(areaType, excludeEqual)
  if bSuccess then
    self:PrintLog("判断队伍在指定区域内成功")
    return AINewNodeStatus.Success
  end
  self:PrintLog("判断队伍在指定区域内失败")
  return AINewNodeStatus.Failure
end

function ActionTeamInBoardArea:IsTeamInBoardArea(areaType, excludeEqual)
  local utilDataSvc = self._world:GetService("UtilData")
  local posCenter = utilDataSvc:GetBoardCenterPos()
  local localTeamEntity = self._world:Player():GetLocalTeamEntity()
  local teamPos = localTeamEntity:GetGridPosition()
  if areaType == AITeamInBoardAreaType.UpArea then
    if excludeEqual and excludeEqual == 1 then
      return teamPos.y > posCenter.y
    else
      return teamPos.y >= posCenter.y
    end
  elseif areaType == AITeamInBoardAreaType.DownArea then
    if excludeEqual and excludeEqual == 1 then
      return teamPos.y < posCenter.y
    else
      return teamPos.y <= posCenter.y
    end
  elseif areaType == AITeamInBoardAreaType.LeftArea then
    if excludeEqual and excludeEqual == 1 then
      return teamPos.x < posCenter.x
    else
      return teamPos.x <= posCenter.x
    end
  elseif areaType == AITeamInBoardAreaType.RightArea then
    if excludeEqual and excludeEqual == 1 then
      return teamPos.x > posCenter.x
    else
      return teamPos.x >= posCenter.x
    end
  end
end
