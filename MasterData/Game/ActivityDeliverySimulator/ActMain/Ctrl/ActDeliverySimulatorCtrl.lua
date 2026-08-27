local base = require("Game.Common.Activity.ActCommonCtrlBase")
local ActDeliverySimulatorCtrl = class("ActDeliverySimulatorCtrl", base)
local ActDeliverySimulatorData = require("Game.ActivityDeliverySimulator.ActMain.Data.ActDeliverySimulatorData")
local cs_GSceneManager_Ins = CS.GSceneManager.Instance
local CS_GameObject = CS.UnityEngine.GameObject
local SectorEnum = require("Game.Sector.SectorEnum")
local util = require("XLua.Common.xlua_util")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")

function ActDeliverySimulatorCtrl:OnInit()
  base.OnInit(self)
end

function ActDeliverySimulatorCtrl:NewActData()
  local data = ActDeliverySimulatorData.New()
  return data
end

function ActDeliverySimulatorCtrl:LoadAllCfg()
  ConfigData:LoadDynCfg(eDynConfigData.delivery_activity_main)
  ConfigData:LoadDynCfg(eDynConfigData.delivery_activity_role_group)
  ConfigData:LoadDynCfg(eDynConfigData.delivery_activity_sector_group)
  ConfigData:LoadDynCfg(eDynConfigData.delivery_role)
  ConfigData:LoadDynCfg(eDynConfigData.activity_general_act_bp)
end

function ActDeliverySimulatorCtrl:LoadAllListener()
end

function ActDeliverySimulatorCtrl:UnLoadAllCfg()
  ConfigData:ReleaseDynCfg(eDynConfigData.delivery_activity_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.delivery_activity_role_group)
  ConfigData:ReleaseDynCfg(eDynConfigData.delivery_activity_sector_group)
  ConfigData:ReleaseDynCfg(eDynConfigData.delivery_role)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_general_act_bp)
end

function ActDeliverySimulatorCtrl:UnLoadAllListener()
end

function ActDeliverySimulatorCtrl:EnterDeliverySimulatorGame(actData, levelId, skinId)
  self:ExitActDSEntrance()
  local dsCtrl = ControllerManager:GetController(ControllerTypeId.DeliverySimulator, true)
  dsCtrl:EnterDeliverySimulatorGame(actData:GetActId(), levelId, skinId)
end

function ActDeliverySimulatorCtrl:TryOpenDeliverySimulator(actId)
  local actData = self:GetActDataByActId(actId)
  if actData == nil then
    return
  end
  if self.lbComResloader ~= nil then
    self.lbComResloader:Put2Pool()
    self.lbComResloader = nil
  end
  self.lbComResloader = CS.ResLoader.Create()
  local avgId = actData:GetMainCfg().first_avg
  self._isFirstEnter = 0 < avgId and not ControllerManager:GetController(ControllerTypeId.AvgPlay, true):IsAvgPlayed(avgId)
  if self._isFirstEnter then
    ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgId, function()
      self:EnterActScene(actData)
    end)
  else
    self:EnterActScene(actData)
  end
end

function ActDeliverySimulatorCtrl:GetIsFirstEnter()
  return self._isFirstEnter
end

function ActDeliverySimulatorCtrl:EnterActScene(actData)
  local function preloadFunc()
    self:_OnScenePreload(actData)
  end
  
  local function loadedFunc()
    self:_OnSceneLoaded(actData)
  end
  
  ControllerManager:DeleteController(ControllerTypeId.SectorController)
  UIManager:DeleteAllWindow()
  local sceneName = actData:GetMainCfg().scene_path
  cs_GSceneManager_Ins:LoadSceneAsyncByABEx(sceneName, true, false, loadedFunc, util.cs_generator(preloadFunc))
end

function ActDeliverySimulatorCtrl:_OnScenePreload(actData)
  self.lbComRes = {}
  local roleGroup = actData:GetMainCfg().role_group
  local roleList = {}
  local roleDic = ConfigData.delivery_activity_role_group[roleGroup]
  for id, cfg in pairs(roleDic) do
    table.insert(roleList, id)
  end
  local ranId = math.random(1, #roleList)
  local skinId = roleList[ranId]
  local heroId = ConfigData.delivery_role[skinId].hero_id
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resCfg = skinCtr:GetResModel(heroId, skinId)
  local modelPath = PathConsts:GetCharacterModelPathEx(resCfg.src_id_model)
  local cmderPrefabWait = self.lbComResloader:LoadABAssetAsyncAwait(modelPath)
  coroutine.yield(cmderPrefabWait)
  self.lbComRes.cmderPrefab = cmderPrefabWait.Result
end

function ActDeliverySimulatorCtrl:_OnSceneLoaded(actData)
  local targetObj = CS_GameObject.Find("Target")
  if IsNull(targetObj) then
    return
  end
  AudioManager:PlayAudioById(actData:GetMainCfg().bgm_id)
  local homeController = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeController ~= nil then
    homeController:ResetShowHeroVoiceImme()
  end
  local showCharacterPrefab = self.lbComRes.cmderPrefab
  if showCharacterPrefab ~= nil then
    local characterObj = showCharacterPrefab:Instantiate()
    local characterTrans = targetObj.transform
    characterObj.transform:SetParent(characterTrans)
    characterObj.transform.localPosition = Vector3.zero
    characterObj.transform.localRotation = Quaternion.Euler(0, 0, 0)
    self.characterAnimator = nil
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.DeliverySimulatorEntrance, function(win)
    if win == nil then
      return
    end
    win:InitDeliverySimulatorEntrance(actData)
  end)
end

function ActDeliverySimulatorCtrl:ResultExFunc(dsCtrl, func)
  if dsCtrl == nil then
    func()
    return
  end
  local actId = dsCtrl.actId
  local actData = self:GetActDataByActId(actId)
  local realCount = dsCtrl.totalMoney - dsCtrl.lastHighScore
  if realCount <= 0 then
    func()
    return
  end
  local rewardIdList = {
    actData:GetMainCfg().bp_item
  }
  local rewardNumList = {realCount}
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window ~= nil then
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIdList, rewardNumList):SetCRShowOverFunc(func)
      window:AddAndTryShowReward(CRData)
    end
  end)
end

function ActDeliverySimulatorCtrl:ShowRewardBp(actData, closeCallback)
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonActRewardBp, function(window)
    if window == nil then
      return
    end
    window:InitActivityCommonRewardBp(actData:GetRewardBpData())
    window:SetCloseCallback(closeCallback)
  end)
end

function ActDeliverySimulatorCtrl:ExitActDSEntrance()
  UIManager:DeleteAllWindow()
  if self.lbComResloader ~= nil then
    self.lbComResloader:Put2Pool()
    self.lbComResloader = nil
  end
end

function ActDeliverySimulatorCtrl:BackToHome()
  cs_GSceneManager_Ins:LoadSceneAsyncByAB(Consts.SceneName.Main, function(ok)
    ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      if window == nil then
        return
      end
      window:SetFrom2Home(nil, true)
    end)
  end)
end

function ActDeliverySimulatorCtrl:BackToSector()
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

function ActDeliverySimulatorCtrl:JumpStorySector()
  local entranceWin = UIManager:GetWindow(UIWindowTypeID.DeliverySimulatorEntrance)
  if entranceWin == nil then
    return
  end
  UIUtil.ReturnUntil2Marker(UIWindowTypeID.DeliverySimulatorEntrance, false)
  entranceWin:OnClickGameBtnReview()
end

function ActDeliverySimulatorCtrl:OnDelete()
  base.OnDelete(self)
  if self.lbComResloader ~= nil then
    self.lbComResloader:Put2Pool()
    self.lbComResloader = nil
  end
end

return ActDeliverySimulatorCtrl
