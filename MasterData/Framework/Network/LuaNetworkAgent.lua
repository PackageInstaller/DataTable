local LuaNetworkAgent = class("LuaNetworkAgent")
local util = require("XLua.Common.xlua_util")
local JumpManager = require("Game.Jump.JumpManager")
local CameraEffectUtil = require("Game.Exploration.Util.CameraEffectUtil")
local cs_EventSystem = CS.UnityEngine.EventSystems.EventSystem

function LuaNetworkAgent:ctor()
  self.__startReconnect = false
  self.__logoutDeletes = {}
end

function LuaNetworkAgent:__ClearQuitData()
  CS.RenderManager.Instance:ResetRenderSetting()
  TimerManager:ClearCommand()
  TimerManager:CleanAllUpdateTimer()
  TimelineUtil.StopAll()
  NoticeManager:OnLogOut()
  GuideManager:OnQuitAndClear()
  ExplorationManager:ClearExploration()
  BattleDungeonManager:ClearBattleDungeon(true)
  CS.BattleManager.Instance:ForceExitBattle()
  NetworkManager:ResetAllNetwork()
  UIManager:DeleteAllWindow()
  UIManager:HideAllWindow()
  UIManager:DeleteWindow(UIWindowTypeID.TopStatus)
  ControllerManager:DeleteAllController()
  CS.UIManager.Instance:DeleteAllWindow()
  PlayerDataCenter:OnLogOut()
  UnlockCenter:InitUnlockCenter()
  RedDotController.RedDotDriver:ResetAllData()
  JumpManager:CleanJumpManager()
  UIUtil.CloseAllCover()
  UserMsgCenter:Clear()
  PlayerClickCollectManager:OnLogout()
  WarChessManager:ExitWarChessClean()
  WarChessSeasonManager:ExitWarChessClean()
  DeepLinkManager:ClearLink()
  PersistentManager:HandleLogOut()
  UIManager.csUIManager:DisableUIPPVolume()
  CameraEffectUtil:ClearPPStack()
  Time.unity_time.timeScale = 1
  self._isDisconnected = false
  self._lastTimeScale = nil
  self.loginData = nil
  for _, delInterface in pairs(self.__logoutDeletes) do
    delInterface:Delete()
  end
  self.__logoutDeletes = {}
end

function LuaNetworkAgent:__QuitToLogin()
  self:__ClearQuitData()
  CS.NetworkManager.Instance:Disconnect()
  CS.GSceneManager.Instance:LoadSceneAsync(Consts.SceneName.Empty, function()
    UIManager:ShowWindow(UIWindowTypeID.Login)
  end)
end

function LuaNetworkAgent:__LogoutToLogin(isLogoutUser)
  local isUseSDK = CS.MicaSDKManager.Instance:IsUseSdk()
  if isLogoutUser and isUseSDK then
    CS.MicaSDKManager.Instance:Logout(function()
      self:__QuitToLogin()
    end)
  else
    self:__QuitToLogin()
  end
end

function LuaNetworkAgent:LogoutToLogin(isLogoutUser)
  local loginWindow = UIManager:GetWindow(UIWindowTypeID.Login)
  if loginWindow ~= nil then
    loginWindow:HideCreateUser()
    CS.NetworkManager.Instance:Disconnect()
    if isLogoutUser then
      CS.MicaSDKManager.Instance:Logout()
    end
    loginWindow:SetWindowPermanent(true)
    self:__ClearQuitData()
    loginWindow:SetWindowPermanent(false)
    UIManager:ShowWindowOnly(UIWindowTypeID.Login)
    AudioManager:PlayAudioById(3002, nil, false)
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Home.name, eAuSelct.Home.base)
  else
    local CS_GSceneMgr = CS.GSceneManager.Instance
    if not CS_GSceneMgr.isLoading then
      self:__LogoutToLogin(isLogoutUser)
    else
      do
        local function waitSceneLoad()
          while true do
            coroutine.yield()
            
            if not CS_GSceneMgr.isLoading then
              loginWindow = UIManager:GetWindow(UIWindowTypeID.Login)
              if loginWindow ~= nil then
                loginWindow:HideCreateUser()
                CS.NetworkManager.Instance:Disconnect()
                if isLogoutUser then
                  CS.MicaSDKManager.Instance:Logout()
                end
                break
              end
              self:__LogoutToLogin(isLogoutUser)
              break
            end
          end
        end
        
        GR.StartCoroutine(util.cs_generator(waitSceneLoad))
      end
    end
  end
end

function LuaNetworkAgent:OnServerKickOut()
  local homeController = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeController ~= nil then
    homeController:StopHomeOnHookTimer()
  end
end

function LuaNetworkAgent:OnDisconected()
  MsgCenter:Broadcast(eMsgEventId.OnDisconnect)
  if not self._isDisconnected then
    local pauseTime = false
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
    if avgCtrl ~= nil then
      avgCtrl:SetAvgAutoPlayMode(false)
    end
    CS.MovieManager.Instance:PauseAllMoviePlayer()
    if ExplorationManager:IsInExploration() then
      ExplorationManager.epCtrl.autoCtrl:CloseAutoMode()
    end
    local battleCtrl = CS.BattleManager.Instance.CurBattleController
    if battleCtrl ~= nil and battleCtrl:BattleIsRunning() then
      pauseTime = true
      local uiBattleSkill = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
      if uiBattleSkill ~= nil and uiBattleSkill.inputModeMaskUI.active then
        uiBattleSkill.inputModeMaskUI:InvokeCancleInputAction()
      end
    end
    local ltrCtrl = ControllerManager:GetController(ControllerTypeId.Lottery)
    if ltrCtrl ~= nil and ltrCtrl:IsInLotteryShow() then
      pauseTime = true
    end
    if self._lastTimeScale == nil and pauseTime then
      self._lastTimeScale = Time.unity_time.timeScale
      Time.unity_time.timeScale = 0
    end
    UIManager:HideWindow(UIWindowTypeID.MessageCommon)
    UIManager:DeleteWindow(UIWindowTypeID.GameNotice)
    cs_EventSystem.current:SetSelectedGameObject(nil)
  end
  self._isDisconnected = true
  if self.__startReconnect and self.__reconnectAction ~= nil then
    self.__reconnectAction(false)
  end
  self.__startReconnect = false
  self.__reconnectAction = nil
  self.__inExploration = false
end

function LuaNetworkAgent:SaveLoginData(loginData)
  self.loginData = loginData
end

function LuaNetworkAgent:CanReconnectGame()
  local loginWindow = UIManager:GetWindow(UIWindowTypeID.Login)
  if loginWindow ~= nil then
    return false
  end
  if self.loginData == nil then
    return false
  end
  return true
end

function LuaNetworkAgent:StartReconnectGame(reconnectAction)
  self.__reconnectAction = reconnectAction
  self.__startReconnect = true
  self.__inExploration = ExplorationManager:IsInExploration()
  NetworkManager:GetNetwork(NetworkTypeID.Login):CS_Login(self.loginData.open_id, self.loginData.token, CS.ClientConsts.GameVersionStr, true, function(msgList)
    if msgList.Count == 0 then
      if self.__reconnectAction ~= nil then
        self.__reconnectAction(false)
        self.__reconnectAction = nil
      end
    else
      local success = msgList[0]
      if success then
        if self._lastTimeScale ~= nil then
          Time.unity_time.timeScale = self._lastTimeScale
          self._lastTimeScale = nil
        end
        CS.MovieManager.Instance:PauseAllMoviePlayer()
        self._isDisconnected = false
      end
      if self.__reconnectAction ~= nil then
        self.__reconnectAction(success)
        self.__reconnectAction = nil
      end
    end
  end)
end

function LuaNetworkAgent:OnRecvExploraionDetail()
  if not self.__startReconnect then
    return
  end
  self.__startReconnect = false
  GR.StartCoroutine(util.cs_generator(self.__StartAfterReconnect, self))
end

function LuaNetworkAgent:__StartAfterReconnect()
  while true do
    local CS_GSceneMgr = CS.GSceneManager.Instance
    if not CS_GSceneMgr.isLoading then
      break
    end
    coroutine.yield()
  end
  UIManager:HideWindow(UIWindowTypeID.Loading)
  if ExplorationManager:HasUncompletedEp() and self.__inExploration then
    self.__inExploration = false
    ExplorationManager:ContinueLastExploration()
    return
  end
  ControllerManager:GetController(ControllerTypeId.Login, true):OnLoginUserDataComplete()
end

function LuaNetworkAgent:AddLogoutAutoDelete(delInterface)
  table.insert(self.__logoutDeletes, delInterface)
end

function LuaNetworkAgent:RemoveLogoutAutoDelete(delInterface)
  table.removebyvalue(self.__logoutDeletes, delInterface)
end

return LuaNetworkAgent
