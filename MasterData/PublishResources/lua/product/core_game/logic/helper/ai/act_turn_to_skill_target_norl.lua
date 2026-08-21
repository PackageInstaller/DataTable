require("ai_node_new")
require("action_turn_to_target")
_class("ActionTurnToSkillTargetNormalize", ActionTurnToTarget)
ActionTurnToSkillTargetNormalize = ActionTurnToSkillTargetNormalize

function ActionTurnToSkillTargetNormalize:TurnToTarget(world, entityWork, nTargetType)
  local aiComponent = entityWork:AI()
  if false == aiComponent:CanTurn() then
    self:PrintLog("转向: 转向玩家方向<不允许>")
    return
  end
  local targetEntity
  local nSkillID = self:GetLogicData(1)
  local configSkillID = self:GetLogicSkillID()
  if configSkillID then
    nSkillID = configSkillID
  end
  if nSkillID == 0 then
    self:PrintLog("转向: 转向使用的技能ID为0<不允许>")
    return
  end
  targetEntity = self:_GetTargetPosBySkillID(world, entityWork, nSkillID)
  local targetEntityId = -1
  if targetEntity then
    targetEntityId = targetEntity:GetID()
  end
  self:PrintDebugLog("转向: <允许>，技能ID = ", nSkillID, " 目标ID = ", targetEntityId)
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
