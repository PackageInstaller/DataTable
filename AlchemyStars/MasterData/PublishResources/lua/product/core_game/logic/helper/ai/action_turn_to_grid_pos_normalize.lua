require("ai_node_new")
_class("ActionTurnToGridPosNormalize", AINewNode)
ActionTurnToGridPosNormalize = ActionTurnToGridPosNormalize

function ActionTurnToGridPosNormalize:OnBegin()
  local x = self:GetLogicData(-1)
  local y = self:GetLogicData(-2)
  local posTarget = Vector2(x, y)
  self:TurnToTarget(self.m_entityOwn, posTarget)
end

function ActionTurnToGridPosNormalize:TurnToTarget(entityWork, posTarget)
  local aiComponent = entityWork:AI()
  if false == aiComponent:CanTurn() then
    self:PrintLog("转向: 转向玩家方向<不允许>")
    return
  end
  local posDir = self:GetDirNormalize(posTarget, entityWork)
  local posSelf = entityWork:GetGridPosition()
  self:PrintDebugLog("转向: <允许>，我的位置 = ", posSelf, " 目标位置=", posTarget, " 转向方向：", posDir)
  entityWork:SetGridDirection(posDir)
end

function ActionTurnToGridPosNormalize:GetDirNormalize(targetPos, entity)
  local gridLoc = entity:GridLocation()
  local center = gridLoc:Center()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  return utilCalcSvc:GetDirNormalize(center, targetPos)
end
