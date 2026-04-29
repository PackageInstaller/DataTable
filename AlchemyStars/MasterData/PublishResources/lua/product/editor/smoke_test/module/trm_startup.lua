require("test_robot_module")
local registry = require("smoke_test_registry")

function TestRobotModule:StubInit()
  _G.SMOKE_TEST_ENABLED = true
  dofile("stub_aircraft_resource_room")
  dofile("stub_ui_sign_in_controller")
  dofile("stub_rattackt_animation_param")
  dofile("stub_fly_effect_caster_to_target_ins")
  dofile("stub_ui_n30_entrust_line")
  dofile("stub_ui_activity_battlepass_helper")
  if self:IsCNVersion() then
    dofile("stub_ui_login_controller")
  end
end

function TestRobotModule:_GetTaskTypeFromStartupString(startupString)
  local args = string.split(startupString, "|")
  local taskType = tonumber(args[1])
  return taskType, args[1]
end

function TestRobotModule:StartAutoTestTask(arg)
  self:StubInit()
  return GameGlobal.TaskManager():StartTask(self.__TaskFnAutoStart, self, arg)
end

function TestRobotModule:__TaskFnAutoStart(TT, arg)
  GameGlobal.UIStateManager():SwitchState(UIStateType.LoginEmpty)
  YIELD(TT, TestConst.LoginDelay)
  if self:IsCNVersion() then
    local msdkAuthorityInfo = GameGlobal.GameLogic().msdkAuthorityInfo
    msdkAuthorityInfo.open_id = self:GetTestAccountOpenID()
  end
  local lmodule = GameGlobal.GetModule(LoginModule)
  lmodule:NewLoginStart()
  lmodule:NewLoginGameTT(TT, {
    [1] = {ip = "127.0.0.1", port = "8111"}
  })
  YIELD(TT, 3000)
  local roleModule = GameGlobal.GetModule(RoleModule)
  if roleModule.m_char_info.pstid <= 0 then
    Log.exception(self._className, "登录失败?")
    return
  end
  if self:IsCNVersion() then
    LoginLuaHelper.CloseAllUI()
    while GameGlobal.UIStateManager():CurUIStateType() ~= UIStateType.UIMain do
      YIELD(TT, 100)
    end
  end
  local attendedParam
  if arg then
    attendedParam = self:SetStartupParam(arg)
  end
  if attendedParam then
    Log.exception("Attended Smoke Test is not supported anymore. ")
    return
  end
  local taskType = self:_GetTaskTypeFromStartupString(arg)
  if taskType == TestRobotRunningMode.AutoTest then
    AutoTestEnterCoreGame()
    return
  end
  local registryNode = registry[taskType]
  if not registryNode then
    Log.exception(self._className, "Registry not found for (TestRobotRunningMode)", taskType)
    return
  end
  self:GenerateRunDataFromTestCase(registryNode, arg)
  self:Startup_InitializeTestCase(registryNode, arg)
end

function TestRobotModule:GenerateRunDataFromTestCase(registryNode, strTestCase)
  local args = string.split(strTestCase, "|")
  local taskType, rawTaskType = self:_GetTaskTypeFromStartupString(strTestCase)
  local runData
  local clsName = registryNode.RunDataClassName
  local GlobalRunDataClass = _G[clsName]
  if not GlobalRunDataClass then
    Log.exception(clsName, "Nil run data type for (TestRobotRunningMode)", tostring(rawTaskType))
    return
  end
  Log.info(self._className, "Creating runData [", GlobalRunDataClass._className, "] for (TestRobotRunningMode)", taskType)
  runData = GlobalRunDataClass:New()
  if runData then
    runData:ParseLevelData(args[2])
    runData:ParseTeamData(args[3])
    runData:SetPermanentlyTestPet(TestConst.PermanentlyTestPet)
    runData:SetPermanentlyDisabledPet(TestConst.PermanentlyDisabledPet)
    self:SetMissionRunData(runData)
  end
end

function TestRobotModule:Startup_InitializeTestCase(registryNode, strTestCase)
  local taskType, rawTaskType = self:_GetTaskTypeFromStartupString(strTestCase)
  local luaName = registryNode.TestCaseLuaName
  if not luaName then
    Log.exception(self._className, "Nil test case lua name for (TestRobotRunningMode)", tostring(rawTaskType))
    return
  end
  local stc = require(luaName)
  if not stc then
    Log.exception(self._className, "The given test case file did not returns a sequence: ", tostring(luaName))
    return
  end
  local at = LAction_Tree:New(self)
  at:InitTreeByConfig(stc)
  at:InitLogic()
  self._currentSequence = at
  local progressInfo = SmokingTestProgressInfo:New()
  if registryNode.InitTotalProgressProvider then
    if not self[registryNode.InitTotalProgressProvider] then
      Log.warn(self._className, "invalid InitTotalProgressProvider :", tostring(registry.InitTotalProgressProvider))
    else
      local total = self[registryNode.InitTotalProgressProvider]()
      progressInfo:SetTotalProgress(total)
    end
  end
  self:SetProgressInfo(progressInfo)
  self.m_eRunningMode = taskType
  self.m_bEnableRobot = true
end
