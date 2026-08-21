require("ai_node_new")
_class("ActionCastSkillBase", AINewNode)
ActionCastSkillBase = ActionCastSkillBase

function ActionCastSkillBase:Constructor()
  self._world = nil
  self.m_nWaitTaskID = 0
  self.m_nWaitSkillType = 0
end

function ActionCastSkillBase:InitializeNode(cfg, context, parentNode, configData)
  ActionCastSkillBase.super.InitializeNode(self, cfg, context, parentNode, configData)
end

function ActionCastSkillBase:GetWorkSkillID()
  return nil
end

function ActionCastSkillBase:OnBegin()
  local aiCmpt = self.m_entityOwn:AI()
  aiCmpt:SetMoveState(AIMoveState.MoveEnd)
end

function ActionCastSkillBase:OnUpdate()
  local nSkillID = self:GetWorkSkillID()
  if not nSkillID or nSkillID <= 0 then
    self:PrintLog("释放技能，skillID = nil")
    return AINewNodeStatus.Failure
  end
  if AINewNode.IsEntityDead(self.m_entityOwn) then
    return AINewNodeStatus.Failure
  end
  if self.m_entityOwn:BuffComponent():HasFlag(BuffFlags.Benumb) then
    self:PrintLog("施放技能<麻痹Buff不放技能>，技能ID = ", nSkillID)
    return AINewNodeStatus.Failure
  end
  local ret = self:_CalcAISkill(nSkillID)
  return ret
end

function ActionCastSkillBase:_CalcAISkill(skillID)
  local aiCmpt = self.m_entityOwn:AI()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  self.m_nWaitSkillType = skillConfigData:GetSkillType()
  if SkillType.Normal == self.m_nWaitSkillType then
    self:PrintLog("施放普攻技能，技能ID = ", skillID)
    self:PrintDebugLog("施放普攻技能，技能ID = ", skillID)
    self:_CastNormalSkill(skillID)
    return AINewNodeStatus.Success
  elseif self:_IsAllAIMoveDone() then
    self:PrintLog("所有AI移动结束，施放非普攻技能，技能ID = ", skillID)
    self:PrintDebugLog("所有AI移动结束，施放非普攻技能，技能ID = ", skillID)
    self:_CastSkill(skillID)
    return AINewNodeStatus.Success
  else
    self:PrintLog("本次施放非普攻技能失败，需要等待移动结束，技能ID = ", skillID)
    return AINewNodeStatus.Failure
  end
end

function ActionCastSkillBase:_CastNormalSkill(skillID)
  self:PrintLog2(" CastNormalSkill skillID=", skillID)
  local skillLogicSvc = self._world:GetService("SkillLogic")
  local recorderCmpt = self._world:GetBoardEntity():AIRecorder()
  local casterEntityID = self.m_entityOwn:GetID()
  local atkCount = 1
  if self.m_entityOwn:Attributes():GetAttribute("DoubleAtk") then
    atkCount = 2
  end
  for i = 1, atkCount do
    local aiResult = AISkillResult:New()
    aiResult:SetCastSkillDir(self.m_entityOwn:GetGridDirection())
    recorderCmpt:AddNormalAttackResult(casterEntityID, aiResult)
    skillLogicSvc:CalcAISkillResult(self.m_entityOwn, skillID, aiResult)
  end
end

function ActionCastSkillBase:_CastSkill(skillID)
  local skillLogicSvc = self._world:GetService("SkillLogic")
  local recorderCmpt = self._world:GetBoardEntity():AIRecorder()
  local casterEntityID = self.m_entityOwn:GetID()
  local aiResult = AISkillResult:New()
  aiResult:SetCastSkillDir(self.m_entityOwn:GetGridDirection())
  aiResult:SetCasterEntityID(casterEntityID)
  aiResult:SetParallelID(self:GetParallelID())
  recorderCmpt:AddSpellResult(casterEntityID, aiResult)
  self:PrintLog(" CastSkill skillID=", skillID)
  skillLogicSvc:CalcAISkillResult(self.m_entityOwn, skillID, aiResult)
  local deadChessPetEntityIDList = self:_HandleChessPetDead()
  aiResult:SetAISkillResult_DeadChessList(deadChessPetEntityIDList)
end

function ActionCastSkillBase:_HandleChessPetDead()
  if self._world:MatchType() ~= MatchType.MT_Chess then
    return
  end
  local chessSvc = self._world:GetService("ChessLogic")
  local deadIDList = chessSvc:GetDeadChessPetList()
  chessSvc:DoChessPetListDeadLogic(deadIDList)
  return deadIDList
end
