require("test_robot_module")

function TestRobotModule:SetProgressInfo(p)
  self._progressInfo = p
  self:WriteProgressLog()
end

function TestRobotModule:GetProgressInfo()
  return self._progressInfo
end

function TestRobotModule:WriteProgressLog()
  if not self.m_pMissionRunData then
    return
  end
  local runData = self.m_pMissionRunData
  local t = {}
  if runData:IsExceptionThrew() then
    table.insert(t, "【异常】")
  end
  table.insert(t, GetEnumKey("TestRobotRunningMode", self.m_eRunningMode))
  table.insert(t, self.m_pMissionRunData:GetMissionID())
  table.insert(t, string.format("<%s>", tostring(self._currentSequence.m_listScanID[#self._currentSequence.m_listScanID])))
  if self.m_pMissionRunData:IsRandomTeam() then
    local count = table.count(self.m_pMissionRunData._petInfo)
    local max = #Cfg.cfg_pet({Formal = 1})
    table.insert(t, string.format("随机阵容: %d/%d %.2f%%", count, max, count / max * 100))
  else
    table.insert(t, "指定阵容:")
    local currentTeamBuild = self.m_pMissionRunData:GetCurrentTeamBuild()
    for _, v in ipairs(currentTeamBuild) do
      table.insert(t, v:GetTemplateID())
    end
  end
  if self._progressInfo then
    table.insert(t, "关卡进度:")
    table.insert(t, tostring(self._progressInfo))
  end
  local str = table.concat(t, " ")
  self.__statusStr = str
  SmokingTestHub.WriteBoardLog(str)
end

function TestRobotModule:WriteProgressEnd()
  if not self.m_pMissionRunData then
    return
  end
  local t = {}
  local runData = self.m_pMissionRunData
  if runData:IsExceptionThrew() then
    table.insert(t, "【异常】")
  end
  table.insert(t, GetEnumKey("TestRobotRunningMode", self.m_eRunningMode))
  table.insert(t, string.format("<%s>", tostring(self._currentSequence.m_listScanID[#self._currentSequence.m_listScanID])))
  if self.m_pMissionRunData:IsRandomTeam() then
    local max = #Cfg.cfg_pet({Formal = 1})
    table.insert(t, string.format("随机阵容: %d", max))
  else
    table.insert(t, "指定阵容:")
    local currentTeamBuild = self.m_pMissionRunData:GetCurrentTeamBuild()
    for _, v in ipairs(currentTeamBuild) do
      table.insert(t, v:GetTemplateID())
    end
  end
  table.insert(t, "测试完成")
  local str = table.concat(t, " ")
  self.__statusStr = str
  SmokingTestHub.WriteBoardLog(str)
end

function TestRobotModule:Progress_GetMazeInitTotalProgress()
  local cfgMazeLayer = Cfg.cfg_maze_layer()
  return #cfgMazeLayer
end

function TestRobotModule:Progress_GetAniPopStarInitTotalProgress()
  return 10
end
