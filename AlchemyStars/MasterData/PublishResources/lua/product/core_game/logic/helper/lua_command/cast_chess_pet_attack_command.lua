_class("CastChessPetAttackCommand", IEntityCommand)
CastChessPetAttackCommand = CastChessPetAttackCommand

function CastChessPetAttackCommand:Constructor()
  self._commandType = "CastChessPetAttack"
  self._casterEntityID = -1
  self._targetEntityList = {}
  self._chessPath = {}
  self._pickUpPos = nil
end

function CastChessPetAttackCommand:GetCommandType()
  return self._commandType
end

function CastChessPetAttackCommand:GetExecStateID(runAtClient)
  if runAtClient then
    return GameStateID.PickUpChessPet
  else
    return GameStateID.WaitInput
  end
end

function CastChessPetAttackCommand:IsExecExcluded()
  return 1
end

function CastChessPetAttackCommand:DependRoundCount()
  return true
end

function CastChessPetAttackCommand:GetCmdCasterEntityID()
  return self._casterEntityID
end

function CastChessPetAttackCommand:GetCmdTargetEntityIDList()
  return self._targetEntityList
end

function CastChessPetAttackCommand:SetCmdCasterEntityID(casterEntityID)
  self._casterEntityID = casterEntityID
end

function CastChessPetAttackCommand:SetCmdTargetEntityIDList(targetEntityIDList)
  self._targetEntityList = targetEntityIDList
end

function CastChessPetAttackCommand:GetCmdChessPath()
  return self._chessPath
end

function CastChessPetAttackCommand:SetCmdChessPath(chessPath)
  self._chessPath = chessPath
end

function CastChessPetAttackCommand:SetCmdPickUpResult(result)
  self._pickUpPos = result
end

function CastChessPetAttackCommand:GetCmdPickUpResult()
  return self._pickUpPos
end

function CastChessPetAttackCommand:ToNetMessage()
  local msg = CEventCastChessPetAttackCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.IsAutoFight = self.IsAutoFight
  msg.CmdIndex = self.CmdIndex
  msg.casterEntityID = self:GetCmdCasterEntityID()
  msg.targetEntityList = self:GetCmdTargetEntityIDList()
  for i, pos in ipairs(self._chessPath) do
    msg.chessPath[#msg.chessPath + 1] = Vector2.Pos2Index(pos)
  end
  msg.pickUpPos = Vector2.Pos2Index(self._pickUpPos)
  return msg
end

function CastChessPetAttackCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.IsAutoFight = msg.IsAutoFight
  self.CmdIndex = msg.CmdIndex
  self._casterEntityID = msg.casterEntityID
  self._targetEntityList = msg.targetEntityList
  for i, v in ipairs(msg.chessPath) do
    self._chessPath[#self._chessPath + 1] = Vector2.Index2Pos(v)
  end
  self._pickUpPos = Vector2.Index2Pos(msg.pickUpPos)
end
