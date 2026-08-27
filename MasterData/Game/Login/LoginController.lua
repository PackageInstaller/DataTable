local LoginController = class("LoginController", ControllerBase)
local util = require("XLua.Common.xlua_util")

function LoginController:OnInit()
end

function LoginController:FirstGameStart(loadComplete)
  CS.GSceneManager.Instance:LoadScene(Consts.SceneName.Empty)
  UIManager:ShowWindowAsync(UIWindowTypeID.Login, function(window)
    if loadComplete ~= nil then
      loadComplete()
    end
  end)
end

function LoginController:OnLoginUserDataComplete(noShowLoading)
  RedDotController.RedDotDriver.LoadPstReddotData()
  local skipGuide, onlyFirst = GR.SkipGameGuide()
  GuideManager:SetGMSkipGuide(skipGuide and not onlyFirst)
  UIManager:ShowWindowAsync(UIWindowTypeID.TopStatus, function(window)
    UIManager:HideWindow(UIWindowTypeID.TopStatus)
    self.noShowLoading = noShowLoading or false
    if GuideManager.firstBattleGuideCtrl:TryStartFirstBattleGuide() then
      return
    end
    GR.StartCoroutine(util.cs_generator(BindCallback(self, self.__BeforeLoadingHome)))
  end)
end

function LoginController:__BeforeLoadingHome()
  local needShowSettingWin = false
  local avgTaskList = {}
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
  for k, taskData in pairs(PlayerDataCenter.allTaskData.avgTaskDatas) do
    if taskData.id == ConfigData.buildinConfig.FirstGuideTaskId then
      needShowSettingWin = true
    end
    local avgId = taskData.stcData.story
    local avgCfg = ConfigData.story_avg[avgId]
    if avgCfg == nil then
      error("Can't find avgCfg, avgId = " .. tostring(avgId))
    elseif not avgPlayCtrl:IsAvgPlayed(avgId) and avgPlayCtrl:IsAvgUnlock(avgId) then
      table.insert(avgTaskList, taskData)
    end
  end
  if needShowSettingWin then
    self:_SettingGraph()
  end
  if 0 < #avgTaskList then
    table.sort(avgTaskList, function(a, b)
      return a.id < b.id
    end)
    UIManager:ShowWindowAsync(UIWindowTypeID.Avg, nil)
    local window = UIManager:GetWindow(UIWindowTypeID.Avg)
    while window == nil do
      coroutine.yield(nil)
      window = UIManager:GetWindow(UIWindowTypeID.Avg)
    end
    UIManager:DeleteWindow(UIWindowTypeID.Login)
    for k, taskData in ipairs(avgTaskList) do
      local story2guide_condition = taskData.stcData.story2guide_condition
      local avgCfg = ConfigData.story_avg[taskData.stcData.story]
      local avgCompleteFunc
      local isLast = k == #avgTaskList
      
      function avgCompleteFunc()
        if isLast and not GuideManager.firstBattleGuideCtrl.lastbattleGuide then
          self:__LoadingHome()
        end
        if 0 < story2guide_condition then
          GuideManager:TryTriggerGuide(story2guide_condition)
        end
      end
      
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(avgCfg.script_id, avgCfg.id, avgCompleteFunc)
    end
  else
    self:__LoadingHome()
  end
end

function LoginController:__LoadingHome()
  local firstEnterHome = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_FirstEnterHome)
  if not firstEnterHome then
    self:__NewbeeToSector()
    return
  end
  
  local function loadingFunc()
    local homeCtr = ControllerManager:GetController(ControllerTypeId.HomeController, true)
    homeCtr:OnEnterHome()
    UIManager:ShowWindowAsync(UIWindowTypeID.Home)
    while UIManager:GetWindow(UIWindowTypeID.Home) == nil do
      coroutine.yield(nil)
    end
  end
  
  local function loadedFunc()
    UIManager:DeleteWindow(UIWindowTypeID.Login)
    self:__EnterUIHome()
  end
  
  CS.GSceneManager.Instance:LoadSceneAsyncByABEx(Consts.SceneName.Main, true, self.noShowLoading, loadedFunc, util.cs_generator(loadingFunc))
  local loginWindow = UIManager:GetWindow(UIWindowTypeID.Login)
  if loginWindow ~= nil then
    loginWindow:ShowLoading()
  end
end

function LoginController:__NewbeeToSector()
  ControllerManager:GetController(ControllerTypeId.SectorController, true):InitSectorCtrl(function(sectorCtrl)
    sectorCtrl:SetFrom(AreaConst.Exploration)
    UIManager:DeleteWindow(UIWindowTypeID.Login)
  end)
end

function LoginController:__EnterUIHome()
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  window:SetFrom2Home(AreaConst.Sector)
end

function LoginController:_SettingGraph()
  if CS.MTPManager.Instance.isSimulator then
    local settingCtrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
    settingCtrl:SetPerformanceLevel(5)
    settingCtrl:ForceSetToCurrentPerformanceLevel()
    PersistentManager:SaveModelData(PersistentConfig.ePackage.SystemData)
    return
  end
  local setGraphComplete = false
  UIManager:ShowWindowAsync(UIWindowTypeID.SettingGraph, function(window)
    window:InitSettingGraph(function()
      setGraphComplete = true
    end)
    UIManager:DeleteWindow(UIWindowTypeID.Login)
  end)
  while not setGraphComplete do
    coroutine.yield()
  end
end

function LoginController:OnDelete()
end

return LoginController
