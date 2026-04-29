require("ai_node_new")
_class("ActionTurnToTargetNormalize", ActionTurnToTarget)
ActionTurnToTargetNormalize = ActionTurnToTargetNormalize

function ActionTurnToTargetNormalize:TurnToTarget(world, entityWork, nTargetType)
  local aiComponent = entityWork:AI()
  if false == aiComponent:CanTurn() then
    self:PrintLog("转向: 转向玩家方向<不允许>")
    return
  end
  local targetEntity
  if nTargetType and 0 < nTargetType then
    local nSkillID = self:GetLogicData(1)
    if nSkillID == 0 then
      self:PrintLog("转向: 转向使用的技能ID为0<不允许>")
      return
    end
    targetEntity = self:_GetTargetPosBySkillID(world, entityWork, nSkillID)
  else
    targetEntity = aiComponent:GetTargetEntity()
  end
  if not targetEntity or not entityWork:HasBodyArea() then
    self:PrintLog("转向: 转向玩家方向<允许>，目标没有BodyArea")
    return
  end
  self:PrintLog("转向: 转向玩家方向<允许>")
  local posTarget = targetEntity:GetGridPosition()
  local posDir = self:GetDir(posTarget, entityWork)
  local posSelf = entityWork:GetGridPosition()
  self:PrintDebugLog("转向: <允许>，我的位置 = ", posSelf, " 目标ID = ", targetEntity:GetID(), " 目标位置=", posTarget, " 转向方向：", posDir)
  entityWork:SetGridDirection(posDir)
end
