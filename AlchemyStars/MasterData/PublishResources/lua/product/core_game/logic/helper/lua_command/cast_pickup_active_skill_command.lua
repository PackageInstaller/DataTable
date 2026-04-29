_class("CastPickUpActiveSkillCommand", IEntityCommand)
CastPickUpActiveSkillCommand = CastPickUpActiveSkillCommand

function CastPickUpActiveSkillCommand:Constructor()
  self._commandType = "CastPickUpActiveSkill"
  self._activeSkillID = -1
  self._casterPstID = -1
  self._pickUpPosList = {}
  self._pickUpDirList = {}
  self._directionPickupPos = {}
  self._lastPickUpDirection = nil
  self._reflectDir = nil
  self._casterTrapEntityID = nil
  self._pickUpExtraParamList = {}
  self._pickUpPetPstID = nil
  self._tetrisDirIndex = nil
end

function CastPickUpActiveSkillCommand:GetExecStateID(runAtClient)
  if runAtClient then
    return GameStateID.PickUpActiveSkillTarget
  else
    return GameStateID.WaitInput
  end
end

function CastPickUpActiveSkillCommand:GetCommandType()
  return self._commandType
end

function CastPickUpActiveSkillCommand:IsExecExcluded()
  return 1
end

function CastPickUpActiveSkillCommand:DependRoundCount()
  return true
end

function CastPickUpActiveSkillCommand:GetCmdActiveSkillID()
  return self._activeSkillID
end

function CastPickUpActiveSkillCommand:GetCmdCasterPstID()
  return self._casterPstID
end

function CastPickUpActiveSkillCommand:SetCmdActiveSkillID(activeSkillID)
  self._activeSkillID = activeSkillID
end

function CastPickUpActiveSkillCommand:SetCmdCasterPstID(pstID)
  self._casterPstID = pstID
end

function CastPickUpActiveSkillCommand:SetCmdPickUpResult(result)
  if result then
    self._pickUpPosList = {}
    for _, v in ipairs(result) do
      local pos = Vector2(v.x, v.y)
      table.insert(self._pickUpPosList, pos)
    end
  end
end

function CastPickUpActiveSkillCommand:GetCmdPickUpResult()
  return self._pickUpPosList
end

function CastPickUpActiveSkillCommand:SetCmdPickUpExtraParamResult(result)
  self._pickUpExtraParamList = {}
  if result then
    for index, value in ipairs(result) do
      table.insert(self._pickUpExtraParamList, value)
    end
  end
end

function CastPickUpActiveSkillCommand:GetCmdPickUpExtraParamResult()
  return self._pickUpExtraParamList
end

function CastPickUpActiveSkillCommand:GetCmdCasterTrapEntityID()
  return self._casterTrapEntityID
end

function CastPickUpActiveSkillCommand:SetCmdCasterTrapEntityID(trapEntityID)
  self._casterTrapEntityID = trapEntityID
end

function CastPickUpActiveSkillCommand:SetPickUpDirectionResult(directionPickupPosList, directionList, lastPickUpDirection)
  self._directionPickupPos = directionPickupPosList
  self._pickUpDirList = directionList
  self._lastPickUpDirection = lastPickUpDirection
end

function CastPickUpActiveSkillCommand:GetDirectionPickupData()
  return self._directionPickupPos, self._pickUpDirList, self._lastPickUpDirection
end

function CastPickUpActiveSkillCommand:SetReflectDir(dir)
  self._reflectDir = dir
end

function CastPickUpActiveSkillCommand:GetReflectDir()
  return self._reflectDir
end

function CastPickUpActiveSkillCommand:SetPickUpPetPstID(petPstID)
  self._pickUpPetPstID = petPstID
end

function CastPickUpActiveSkillCommand:GetPickUpPetPstID()
  return self._pickUpPetPstID
end

function CastPickUpActiveSkillCommand:SetPickUpTetrisDirIndex(index)
  self._tetrisDirIndex = index
end

function CastPickUpActiveSkillCommand:GetPickUpTetrisDirIndex()
  return self._tetrisDirIndex
end

function CastPickUpActiveSkillCommand:ToNetMessage()
  local msg = CEventCastPickUpActiveSkillCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.IsAutoFight = self.IsAutoFight
  msg.CmdIndex = self.CmdIndex
  msg.ActiveSkillID = self._activeSkillID
  msg.CasterPstID = self._casterPstID
  for i, pos in ipairs(self._pickUpPosList) do
    msg.PickUpPosList[#msg.PickUpPosList + 1] = Vector2.Pos2Index(pos)
  end
  for dir, pos in pairs(self._directionPickupPos) do
    msg.DirectionPickUpPos[dir] = Vector2.Pos2Index(pos)
  end
  msg.PickUpDirList = self._pickUpDirList
  msg.LastPickUpDirection = self._lastPickUpDirection
  msg.ReflectDir = self._reflectDir
  msg.CasterTrapEntityID = self._casterTrapEntityID
  for i, param in ipairs(self._pickUpExtraParamList) do
    msg.PickUpExtraParamList[#msg.PickUpExtraParamList + 1] = param
  end
  msg.PickUpPetPstID = self._pickUpPetPstID
  msg.TetrisDirIndex = self._tetrisDirIndex
  return msg
end

function CastPickUpActiveSkillCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.IsAutoFight = msg.IsAutoFight
  self.CmdIndex = msg.CmdIndex
  self._activeSkillID = msg.ActiveSkillID
  self._casterPstID = msg.CasterPstID
  for i, v in ipairs(msg.PickUpPosList) do
    self._pickUpPosList[#self._pickUpPosList + 1] = Vector2.Index2Pos(v)
  end
  for k, v in pairs(msg.DirectionPickUpPos) do
    self._directionPickupPos[k] = Vector2.Index2Pos(v)
  end
  self._pickUpDirList = msg.PickUpDirList
  self._lastPickUpDirection = msg.LastPickUpDirection
  self._reflectDir = msg.ReflectDir
  self._casterTrapEntityID = msg.CasterTrapEntityID
  for i, v in ipairs(msg.PickUpExtraParamList) do
    self._pickUpExtraParamList[#self._pickUpExtraParamList + 1] = v
  end
  if msg.PickUpPetPstID == 0 then
    self._pickUpPetPstID = nil
  else
    self._pickUpPetPstID = msg.PickUpPetPstID
  end
  self._tetrisDirIndex = msg.TetrisDirIndex
end
