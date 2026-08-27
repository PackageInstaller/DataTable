local base = ControllerBase
local ActivityLobbyCtrl = class("ActivityLobbyCtrl", base)
local util = require("XLua.Common.xlua_util")
local ActLbCmderCtrl = require("Game.ActivityLobby.Ctrl.ActLbCmderCtrl")
local ActLbAStarPathCtrl = require("Game.ActivityLobby.Ctrl.ActLbAStarPathCtrl")
local ActLbInputCtrl = require("Game.ActivityLobby.Ctrl.ActLbInputCtrl")
local ActLbCamCtrl = require("Game.ActivityLobby.Ctrl.ActLbCamCtrl")
local ActLbInteractCtrl = require("Game.ActivityLobby.Ctrl.ActLbInteractCtrl")
local ActLbEffectCtrl = require("Game.ActivityLobby.Ctrl.ActLbEffectCtrl")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local ActLbEnum = require("Game.ActivityLobby.ActLbEnum")
local PreLoadActMap = require("Game.ActivityLobby.Activity.PreLoadActMap")
local SectorEnum = require("Game.Sector.SectorEnum")
local SkyManager = require("Game.Sky.SkyManager")
local cs_GSceneManager_Ins = CS.GSceneManager.Instance

function ActivityLobbyCtrl:OnInit()
  self.ctrls = {}
  self.actLbCmderCtrl = ActLbCmderCtrl.New(self)
  self.actLbAStarPathCtrl = ActLbAStarPathCtrl.New(self)
  self.actLbInputCtrl = ActLbInputCtrl.New(self)
  self.actLbCamCtrl = ActLbCamCtrl.New(self)
  self.actLbIntrctCtrl = ActLbInteractCtrl.New(self)
  self.actLbEffectCtrl = ActLbEffectCtrl.New(self)
  ConfigData:LoadDynCfg(eDynConfigData.activity_lobby)
  ConfigData:LoadDynCfg(eDynConfigData.activity_lobby_interact_action)
  ConfigData:LoadDynCfg(eDynConfigData.activity_lobby_interact_obj)
  ConfigData:LoadDynCfg(eDynConfigData.activity_lobby_index)
  self.__UpdateHandle = BindCallback(self, self._OnUpdate)
  UpdateManager:AddUpdate(self.__UpdateHandle)
  self.__LateUpdateHandle = BindCallback(self, self._OnLateUpdate)
  UpdateManager:AddLateUpdate(self.__LateUpdateHandle)
  self._actLbState = ActLbEnum.eActLbState.Normal
end

function ActivityLobbyCtrl:GetMainType()
  return self.mainType or ActLbEnum.LobbyMainType.Common
end

function ActivityLobbyCtrl:SetMainType(mainType)
  self.mainType = mainType
end

function ActivityLobbyCtrl:SetActLobbyIndex(lobbyIndex)
  self.lobbyIndex = lobbyIndex
end

function ActivityLobbyCtrl:GetActLobbyIndex()
  return self.lobbyIndex or 1
end

function ActivityLobbyCtrl:SetCloseChangeLobbyMask(bool)
  self.closeChangeLobbyMask = bool
end

function ActivityLobbyCtrl:GetActLobbyId()
  local lobbyIndex = self:GetActLobbyIndex()
  local lobbyIndexCfg = ConfigData.activity_lobby_index[self._actId]
  local lobbyId = lobbyIndexCfg and lobbyIndexCfg[lobbyIndex].lobby_id or self._actId
  return lobbyId
end

function ActivityLobbyCtrl:InitActLobbyCtrl(actId)
  self._actId = actId
  local lobbyId = self:GetActLobbyId()
  local actLbCfg = ConfigData.activity_lobby[lobbyId]
  if actLbCfg == nil then
    error("Cant get activity_lobby cfg, actId:" .. tostring(self._actId))
    return
  end
  self._actLbCfg = actLbCfg
  self.scene_name = self._actLbCfg.scene_name
  if PreLoadActMap[actId] then
    self._preLoadHelperPath = "Game.ActivityLobby.Activity." .. PreLoadActMap[actId] .. ".LbPreLoadHelper"
    self._preLoadHelper = require(self._preLoadHelperPath)
  end
  local homeCtrl = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeCtrl ~= nil then
    homeCtrl:StopHomeSound()
  end
  local avgId = self._actLbCfg.first_avg
  self._isFirstEnter = 0 < avgId and not ControllerManager:GetController(ControllerTypeId.AvgPlay, true):IsAvgPlayed(avgId)
  if self._isFirstEnter then
    ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgId, function()
      if ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl) == nil then
        return
      end
      UIManager:DeleteAllWindow()
      self:EnterActLb()
    end)
  else
    UIManager:DeleteAllWindow()
    self:EnterActLb()
  end
end

function ActivityLobbyCtrl:_UnloadCfg()
  self._preLoadHelper = nil
  if self._preLoadHelperPath ~= nil then
    package.loaded[self._preLoadHelperPath] = nil
    self._preLoadHelperPath = nil
  end
end

function ActivityLobbyCtrl:GetPreLoadHelper()
  return self._preLoadHelper or table.emptytable
end

function ActivityLobbyCtrl:SkipActLbStartShow()
  self._skipStartShow = true
end

function ActivityLobbyCtrl:ChangeActLb(notResetBorn)
  local lobbyId = self:GetActLobbyId()
  local actLbCfg = ConfigData.activity_lobby[lobbyId]
  if actLbCfg == nil then
    error("Cant get activity_lobby cfg, actId:" .. tostring(self._actId))
    return
  end
  self:SkipActLbStartShow()
  self._isFirstEnter = false
  self._actLbCfg = actLbCfg
  local isChangeScene = self._actLbCfg.scene_name ~= self.scene_name
  self.scene_name = self._actLbCfg.scene_name
  self:EnterActLbByOneAct(isChangeScene, notResetBorn)
end

function ActivityLobbyCtrl:EnterActLbByOneAct(isChangeScene, notResetBorn)
  self:InitEnterActLb()
  if notResetBorn then
    self.actLbCmderCtrl:RecordCmderEntityPos()
  end
  for k, v in ipairs(self.ctrls) do
    v:Delete()
  end
  if isChangeScene then
    self:EnterActLbByNewScene()
    return
  end
  if not self.closeChangeLobbyMask then
    UIUtil.AddOneCover("ChangeLobby", SafePack(nil, nil, nil, Color.black, false))
  end
  self.__changeLobbyCoroutine = GR.StartCoroutine(util.cs_generator(BindCallback(self, self._OnSceneReloadCo)))
end

function ActivityLobbyCtrl:_OnSceneReloadCo()
  self:_OnScenePreload()
  self:_OnSceneLoaded()
end

function ActivityLobbyCtrl:InitEnterActLb()
  self._isInLoadingScene = true
  UIManager:DeleteAllWindow()
  if self.lbComResloader ~= nil then
    self.lbComResloader:Put2Pool()
    self.lbComResloader = nil
  end
  self.lbComResloader = CS.ResLoader.Create()
  if self.lbConstResloader == nil then
    self.lbConstResloader = CS.ResLoader.Create()
  end
end

function ActivityLobbyCtrl:SetCmderObjShow(bool)
  self.actLbCmderCtrl:SetLbCmderObj(bool)
end

function ActivityLobbyCtrl:EnterActLbByNewScene()
  local preLoadFunc = BindCallback(self, self._OnScenePreload)
  local sceneLoadedFunc = BindCallback(self, self._OnSceneLoaded)
  local noShowLoding = self.closeChangeLobbyMask == true
  cs_GSceneManager_Ins:LoadSceneAsyncByABEx(self._actLbCfg.scene_name, true, noShowLoding, sceneLoadedFunc, util.cs_generator(preLoadFunc))
end

function ActivityLobbyCtrl:GetIsInLoading()
  return self._isInLoadingScene
end

function ActivityLobbyCtrl:EnterActLb()
  self:InitEnterActLb()
  self:EnterActLbByNewScene()
end

function ActivityLobbyCtrl:_OnScenePreload()
  self.lbComRes = {}
  local cmderPrefabWait = self.lbComResloader:LoadABAssetAsyncAwait(PathConsts:GetCharacterActivityLobbyModelPath(self.actLbCmderCtrl:GetActLbCmderResPath()))
  local cmderHeadFxWait = self.lbComResloader:LoadABAssetAsyncAwait(PathConsts:GetDormPath("CommonPrefab/Fx_CmdHeadGem"))
  coroutine.yield(cmderPrefabWait)
  self.lbComRes.cmderPrefab = cmderPrefabWait.Result
  coroutine.yield(cmderHeadFxWait)
  self.lbComRes.cmderHeadFxPrefab = cmderHeadFxWait.Result
end

function ActivityLobbyCtrl:_OnSceneLoaded()
  if self._actLbCfg.skybox_id > 0 then
    SkyManager.ApplySkyboxGroup(self._actLbCfg.skybox_id, self.lbComResloader)
  end
  AudioManager:PlayAudioById(self._actLbCfg.bgm)
  if not string.IsNullOrEmpty(self._actLbCfg.bgm_selector) then
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, self._actLbCfg.bgm_selector, self._actLbCfg.selector_label)
  end
  local rootGo = CS.UnityEngine.GameObject.Find("ActLobboyRoot")
  if IsNull(rootGo) then
    error("Cant find ActLobboyRoot")
    return
  end
  self._bind = {}
  UIUtil.LuaUIBindingTable(rootGo.transform, self._bind)
  for k, v in ipairs(self.ctrls) do
    v:OnActLbSceneEnter(self._bind)
  end
  UIUtil.CloseOneCover("ChangeLobby")
  UIManager:ShowWindowAsync(UIWindowTypeID.ActLobbyMain, function(win)
    if win == nil then
      return
    end
    win:InitActLobbyMain(self)
  end)
  if not self.closeChangeLobbyMask then
    self.actLbCamCtrl:PlayOpeningMovie(self._actLbCfg.opening, self._actLbCfg.openingStartTime, self._actLbCfg.openingKeepTime)
  end
  self.actLbCamCtrl:ActLbPlayStartShowTimeLine(self._skipStartShow)
  self._isInLoadingScene = false
  if self._ExitAfterLoadedScene then
    self:_ExitCtrl()
  end
end

function ActivityLobbyCtrl:GetActLbActId()
  return self._actId
end

function ActivityLobbyCtrl:GetActLbCfg()
  return self._actLbCfg
end

function ActivityLobbyCtrl:IsFirstEnterActLb()
  return self._isFirstEnter
end

function ActivityLobbyCtrl:_OnUpdate()
  self.actLbCamCtrl:OnLbCamUpdate()
end

function ActivityLobbyCtrl:_OnLateUpdate()
  self.actLbCamCtrl:OnLbCamLateUpdate()
end

function ActivityLobbyCtrl:ShowActLbUI(isShow)
  if isShow then
    ActLbUtil.OnActLbInteractEnter(false, true)
    self._actLbState = ActLbEnum.eActLbState.Normal
    UIUtil.ReShowTopStatus()
    return
  end
  UIUtil.HideTopStatus()
  ActLbUtil.OnActLbInteractEnter(true, true)
  self._actLbState = ActLbEnum.eActLbState.HideUI
end

function ActivityLobbyCtrl:SetActLbState(actLbState)
  self._actLbState = actLbState
end

function ActivityLobbyCtrl:IsActLbState(actLbState)
  return self._actLbState == actLbState
end

function ActivityLobbyCtrl:SetLobbyBgmPause(bool)
  self.isLobbyBgmPause = bool
  AudioManager:PauseSource(eAudioSourceType.BgmSource, self.isLobbyBgmPause)
end

function ActivityLobbyCtrl:ExitActLbCtrl(toHome)
  self._exit2Home = toHome
  if self._isInLoadingScene then
    self._ExitAfterLoadedScene = true
    return
  end
  self:_ExitCtrl()
end

function ActivityLobbyCtrl:_ExitCtrl()
  self:Delete()
  if self._exit2Home then
    cs_GSceneManager_Ins:LoadSceneAsyncByAB(Consts.SceneName.Main, function(ok)
      ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
      UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
        if window == nil then
          return
        end
        window:SetFrom2Home(nil, true)
      end)
    end)
  else
    ControllerManager:GetController(ControllerTypeId.SectorController, true):InitSectorCtrl(function(sectorCtrl)
      sectorCtrl:SetFrom(AreaConst.Home)
      sectorCtrl:AddLoadCoCallback(function()
        local sectorEnterWin = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
        while sectorEnterWin == nil do
          return
        end
        sectorEnterWin:OnClickSEPageBtn(SectorEnum.ePageIndex.act)
      end)
    end, function()
    end)
  end
end

function ActivityLobbyCtrl:OnDelete()
  UIManager:DeleteAllWindow()
  if self.isLobbyBgmPause then
    self:SetLobbyBgmPause(false)
  end
  for k, v in ipairs(self.ctrls) do
    v:Delete()
  end
  self:_UnloadCfg()
  if self.lbComResloader ~= nil then
    self.lbComResloader:Put2Pool()
    self.lbComResloader = nil
  end
  if self.lbConstResloader ~= nil then
    self.lbConstResloader:Put2Pool()
    self.lbConstResloader = nil
  end
  if self.__changeLobbyCoroutine ~= nil then
    GR.StopCoroutine(self.__changeLobbyCoroutine)
  end
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_lobby)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_lobby_interact_action)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_lobby_interact_obj)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_lobby_index)
  UpdateManager:RemoveUpdate(self.__UpdateHandle)
  UpdateManager:RemoveLateUpdate(self.__LateUpdateHandle)
end

return ActivityLobbyCtrl
