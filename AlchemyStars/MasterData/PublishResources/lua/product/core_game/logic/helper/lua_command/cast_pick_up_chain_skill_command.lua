_class("CastPickUpChainSkillCommand", IEntityCommand)
CastPickUpChainSkillCommand = CastPickUpChainSkillCommand

function CastPickUpChainSkillCommand:Constructor()
  self._commandType = "CastPickUpChainSkill"
  self._pickUpPos = nil
  self._activeSkillID = -1
  self._casterPstID = -1
end

function CastPickUpChainSkillCommand:GetCommandType()
  return self._commandType
end

function CastPickUpChainSkillCommand:GetExecStateID()
  return GameStateID.PickUpChainSkillTarget
end

function CastPickUpChainSkillCommand:IsExecExcluded()
  return 0
end

function CastPickUpChainSkillCommand:DependRoundCount()
  return true
end

function CastPickUpChainSkillCommand:SetCmdPickUpResult(result)
  self._pickUpPos = result
end

function CastPickUpChainSkillCommand:GetCmdPickUpResult()
  return self._pickUpPos
end

function CastPickUpChainSkillCommand:ToNetMessage()
  local msg = CEventCastPickUpChainSkillCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.IsAutoFight = self.IsAutoFight
  msg.CmdIndex = self.CmdIndex
  msg.PickUpPos = Vector2.Pos2Index(self._pickUpPos)
  return msg
end

function CastPickUpChainSkillCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.IsAutoFight = msg.IsAutoFight
  self.CmdIndex = msg.CmdIndex
  self._pickUpPos = Vector2.Index2Pos(msg.PickUpPos)
end
