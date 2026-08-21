_class("NetCmdLogger", Object)
NetCmdLogger = NetCmdLogger

function NetCmdLogger:Constructor()
  self._enabled = false
  self._csLogger = {}
  self._commandCount = 0
end

function NetCmdLogger:IsEnable()
  return self._enabled
end

function NetCmdLogger:BaseTOCS(msg, str)
  if msg.EntityID then
    str = str .. "ev_" .. tostring(self._commandCount) .. ".EntityID = " .. tostring(msg.EntityID) .. "; \n"
  end
  if msg.RoundCount then
    str = str .. "ev_" .. tostring(self._commandCount) .. ".RoundCount = " .. tostring(msg.RoundCount) .. "; \n"
  end
  if msg.ClientWaitInput then
    str = str .. "ev_" .. tostring(self._commandCount) .. ".ClientWaitInput = " .. tostring(msg.ClientWaitInput) .. "; \n"
  end
  if msg.IsAutoFight then
    str = str .. "ev_" .. tostring(self._commandCount) .. ".IsAutoFight = " .. tostring(msg.IsAutoFight) .. "; \n"
  end
  return str
end

function NetCmdLogger:InsertToCSLog(str)
  str = str .. "cmdList.Add(ev_" .. tostring(self._commandCount) .. "); \n"
  table.insert(self._csLogger, str)
  self._commandCount = self._commandCount + 1
end

function NetCmdLogger:PrintLogger()
end

function NetCmdLogger:MovePathCmdToCS(msg)
  if not self:IsEnable() then
    return
  end
  local str = "CEventMovePathDoneCommand ev_" .. tostring(self._commandCount) .. " = new CEventMovePathDoneCommand(); \n"
  for i, v in ipairs(msg.ChainPath) do
    str = str .. "ev_" .. tostring(self._commandCount) .. ".ChainPath.Add(" .. tostring(v) .. "); \n"
  end
  str = str .. "ev_" .. tostring(self._commandCount) .. ".ElementType=" .. tostring(msg.ElementType) .. "; \n"
  str = self:BaseTOCS(msg, str)
  self:InsertToCSLog(str)
end

function NetCmdLogger:CastActiveSkillCmdToCS(msg)
  if not self:IsEnable() then
    return
  end
  local str = "CEventCastActiveSkillCommand ev_" .. tostring(self._commandCount) .. "= new CEventCastActiveSkillCommand(); \n"
  str = str .. "ev_" .. tostring(self._commandCount) .. ".ActiveSkillID = " .. tostring(msg.ActiveSkillID) .. ";\n"
  str = str .. "ev_" .. tostring(self._commandCount) .. ".CasterPstID = " .. tostring(msg.CasterPstID) .. ";\n"
  str = str .. "ev_" .. tostring(self._commandCount) .. ".CasterTrapEntityID = " .. tostring(msg.CasterTrapEntityID) .. ";\n"
  str = self:BaseTOCS(msg, str)
  self:InsertToCSLog(str)
end

function NetCmdLogger:CastPickUpActiveSkillCmdToCS(msg)
  if not self:IsEnable() then
    return
  end
  local str = "CEventCastPickUpActiveSkillCommand ev_" .. tostring(self._commandCount) .. "= new CEventCastPickUpActiveSkillCommand(); \n"
  str = str .. "ev_" .. tostring(self._commandCount) .. ".ActiveSkillID = " .. tostring(msg.ActiveSkillID) .. ";\n"
  str = str .. "ev_" .. tostring(self._commandCount) .. ".CasterPstID = " .. tostring(msg.CasterPstID) .. ";\n"
  str = str .. "ev_" .. tostring(self._commandCount) .. ".LastPickUpDirection = " .. tostring(msg.LastPickUpDirection) .. ";\n"
  str = str .. "ev_" .. tostring(self._commandCount) .. ".ReflectDir = " .. tostring(msg.ReflectDir) .. ";\n"
  str = str .. "ev_" .. tostring(self._commandCount) .. ".CasterTrapEntityID = " .. tostring(msg.CasterTrapEntityID) .. ";\n"
  for i, v in ipairs(msg.PickUpPosList) do
    str = str .. "ev_" .. tostring(self._commandCount) .. ".PickUpPosList.Add(" .. tostring(v) .. "); \n"
  end
  for dir, v in pairs(msg.DirectionPickUpPos) do
    str = str .. "ev_" .. tostring(self._commandCount) .. ".DirectionPickUpPos.Add(" .. tostring(dir) .. "," .. tostring(v) .. "); \n"
  end
  for i, v in ipairs(msg.PickUpExtraParamList) do
    str = str .. "ev_" .. tostring(self._commandCount) .. ".PickUpExtraParamList.Add(" .. tostring(v) .. "); \n"
  end
  for i, v in ipairs(msg.PickUpDirList) do
    str = str .. "ev_" .. tostring(self._commandCount) .. ".PickUpDirList.Add(" .. tostring(v) .. "); \n"
  end
  str = self:BaseTOCS(msg, str)
  self:InsertToCSLog(str)
end

function NetCmdLogger:CastSelectTeamOrderPositionCmdToCS(msg)
  if not self:IsEnable() then
    return
  end
  local str = "CEventCastSelectTeamOrderPositionCommand ev_" .. tostring(self._commandCount) .. " = new CEventCastSelectTeamOrderPositionCommand(); \n"
  str = str .. "ev_" .. tostring(self._commandCount) .. ".targetPos = " .. tostring(msg.targetPos) .. ";\n"
  str = str .. "ev_" .. tostring(self._commandCount) .. ".casterPstID = " .. tostring(msg.casterPstID) .. ";\n"
  str = self:BaseTOCS(msg, str)
  self:InsertToCSLog(str)
end

function NetCmdLogger:ChangeTeamLeaderCmdToCS(msg)
  if not self:IsEnable() then
    return
  end
  local str = "CEventChangeTeamLeaderCommand ev_" .. tostring(self._commandCount) .. " = new CEventChangeTeamLeaderCommand(); \n"
  str = str .. "ev_" .. tostring(self._commandCount) .. ".OldLeaderPstID = " .. tostring(msg.OldLeaderPstID) .. ";\n"
  str = str .. "ev_" .. tostring(self._commandCount) .. ".NewLeaderPstID = " .. tostring(msg.NewLeaderPstID) .. ";\n"
  str = self:BaseTOCS(msg, str)
  self:InsertToCSLog(str)
end

function NetCmdLogger:GetLogger()
  local retStr = ""
  for i, logger in ipairs(self._csLogger) do
    retStr = retStr .. logger .. "\n"
  end
  return retStr
end
