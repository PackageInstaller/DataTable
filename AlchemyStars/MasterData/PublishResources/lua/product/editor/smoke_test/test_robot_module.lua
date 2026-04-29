require("game_module")
_class("TestRobotModule", GameModule)
TestRobotModule = TestRobotModule

function TestRobotModule:__tostring()
  return self._className
end

function TestRobotModule:IsCNVersion()
  return SmokingTestHub.IsCNVersion()
end

function TestRobotModule:Constructor()
  self.m_tGlobalFlags = {}
  self.m_bEnableRobot = false
  self._currentSequence = nil
  self.m_pMissionRunData = nil
  self.m_oStartupParam = nil
  self._progressInfo = nil
  self.autoBinder = AutoEventBinder:New(GameGlobal.EventDispatcher())
end

function TestRobotModule:IsDebugMode()
  return EDITOR
end

function TestRobotModule:GetMissionRunData()
  return self.m_pMissionRunData
end

function TestRobotModule:SetMissionRunData(data)
  self.m_pMissionRunData = data
end

function TestRobotModule:Init()
  if not self:IsDebugMode() then
    return
  end
  GameGlobal.UIStateManager().uiControllerManager:RegisterUI("UISmokingTestDashboard", "UISmokingTestDashboard.prefab")
  self:SubscribeGameEvent()
end

function TestRobotModule:Dispose()
  WorkWXPoster.IsActive = false
  if self.__autoBinder then
    self.__autoBinder:Dispose()
  end
end

function TestRobotModule:Update(deltaTimeMS)
  if not self:IsDebugMode() then
    return
  end
  self._deltaTime = deltaTimeMS
  self:DashboardUpdate(deltaTimeMS)
  if false == self.m_bEnableRobot then
    return
  end
  self._currentSequence:OnUpdate()
end

function TestRobotModule:DashboardUpdate(t)
  if not GameGlobal.UIStateManager():IsShow("UISmokingTestDashboard") and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Tab) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) then
    GameGlobal.UIStateManager():ShowDialog("UISmokingTestDashboard")
  end
end

function TestRobotModule:PrintLog(...)
  self:Log(...)
end

function TestRobotModule:OnTestRobot_Begin()
  self.m_tGlobalFlags.NOGUIDE = _G.NOGUIDE
  _G.NOGUIDE = true
  BattleConst.TimeSpeedList = {
    6,
    6,
    6
  }
  WorkWXPoster.IsActive = true
end

function TestRobotModule:OnTestRobot_End()
  self.m_bEnableRobot = false
  _G.NOGUIDE = self.m_tGlobalFlags.NOGUIDE
  BattleConst.TimeSpeedList = {
    1.2,
    1.8,
    3.5
  }
  WorkWXPoster.IsActive = false
end

function TestRobotModule:GetConversationTaskID()
  return self.m_tidConversation
end

function TestRobotModule:SetConversationTaskID(tid)
  self.m_tidConversation = tid
end

function TestRobotModule:SendCheatCommand(strcmd)
  local gmproxy = GameGlobal.GetModule(GMProxyModule)
  return gmproxy:SendCmd(strcmd)
end

function TestRobotModule:GetIsEnableRobot()
  return self.m_bEnableRobot
end

function TestRobotModule:StopAutoTest()
  local go = UnityEngine.GameObject.Find("SmokingTestAgent")
  if go and go ~= "null" then
    UnityEngine.GameObject.Destroy(go)
  end
end

function TestRobotModule:LoadCustomSequence(tSequence)
  local actionTree = LAction_Tree:New(self)
  actionTree:InitTreeByConfig(tSequence, 0, 1)
  self._currentSequence = actionTree
  return actionTree
end

function TestRobotModule:ResetElementaryTestLogic()
  if not self._currentSequence then
    return
  end
  self._currentSequence:InitLogic()
  self.m_eRunningMode = TestRobotRunningMode.Elementary
  self.m_bEnableRobot = true
end

function TestRobotModule:SetStartupParam(meta)
  self.m_oStartupParam = meta
  local splitStr = string.split(meta, "|")
  if 0 == tonumber(splitStr[1]) then
    return string.split(splitStr[2], ",")
  end
end

function TestRobotModule:GetStartupParam()
  return self.m_oStartupParam
end

function TestRobotModule:GetTestAccountOpenID()
  return LocalDB.GetString("OpenIdTest")
end
