local base = UIBaseWindow
local UIDeliverySimulatorEntrance = class("UIDeliverySimulatorEntrance", base)
local UINActivityTimer = require("Game.ActivityFrame.UI.UINActivityTimer")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")

function UIDeliverySimulatorEntrance:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Start, self, self.OnClickGameStart)
  UIUtil.AddButtonListener(self.ui.btn_StoryReview, self, self.OnClickGameBtnReview)
  UIUtil.AddButtonListener(self.ui.btn_Reward, self, self.OnClickGameBtnReward)
  self.refreshEntranceDotBind = BindCallback(self, self.RefreshEntranceDot)
  self.resloader = CS.ResLoader.Create()
  self._actTimerNode = UINActivityTimer.New()
  self._actTimerNode:Init(self.ui.time)
end

function UIDeliverySimulatorEntrance:InitDeliverySimulatorEntrance(data)
  self.actData = data
  local topData = UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._OnClickReturn):SetTopStatusVisible(true)
  local guideId = self.actData:GetMainCfg().guide_id
  if 0 < guideId then
    topData:SetTopStatusInfoFunc(function()
      GuidePicture.OpenGuidePicture(guideId, nil)
    end)
  end
  topData:PushTopStatusDataToBackStack(true)
  local reddot = self.actData:GetActivityReddot()
  self.nodePath = reddot.nodePath
  RedDotController:AddListener(self.nodePath, self.refreshEntranceDotBind)
  TimerManager:StopTimer(self._timerId)
  self._timerId = TimerManager:StartTimer(1, self.__TimerCountdown, self)
  self:__TimerCountdown()
  self:RefreshEntrance()
  self:TryActLbGuide()
end

function UIDeliverySimulatorEntrance:TryActLbGuide()
  local actCtrl = ControllerManager:GetController(ControllerTypeId.ActDeliverySimulator)
  if actCtrl == nil then
    return
  end
  if not actCtrl:GetIsFirstEnter() then
    return
  end
  local guideId = self.actData:GetMainCfg().guide_id
  if 0 < guideId then
    GuidePicture.OpenGuidePicture(guideId, nil)
  end
end

function UIDeliverySimulatorEntrance:RefreshEntranceDot()
  local isShowStartDot = self.actData:GetIsHaveUIGameStartDot()
  self.ui.obj_startBlueDot:SetActive(isShowStartDot)
  local isShowRewardDot = self.actData:GetIsHaveUIRewardBpRedDot()
  self.ui.obj_rewardRedDot:SetActive(isShowRewardDot)
end

function UIDeliverySimulatorEntrance:RefreshEntrance()
  self.ui.img_logo.enabled = false
  local picPath = PathConsts:GetActDeliverySimulatorPic(self.actData:GetMainCfg().image_path)
  self.resloader:LoadABAssetAsync(picPath, function(texture)
    if not IsNull(self.ui.img_logo) then
      self.ui.img_logo.enabled = true
      self.ui.img_logo.texture = texture
    end
  end)
  self:RefreshEntranceDot()
end

function UIDeliverySimulatorEntrance:__TimerCountdown()
  local title, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(self.actData)
  local dayStr, diff = ActivityFrameUtil.GetCountdownTimeStr(expireTime)
  if diff < 0 then
    TimerManager:StopTimer(self._timerId)
  end
  self._actTimerNode:UpdActTimer(title, timeStr, dayStr)
end

function UIDeliverySimulatorEntrance:OnClickGameStart()
  UIManager:ShowWindowAsync(UIWindowTypeID.DeliverySimulatorSelect, function(win)
    if win == nil then
      return
    end
    win:InitDeliverySimulatorSelect(self.actData)
  end)
end

function UIDeliverySimulatorEntrance:OnClickGameBtnReward()
  local actCtrl = ControllerManager:GetController(ControllerTypeId.ActDeliverySimulator)
  actCtrl:ShowRewardBp(self.actData, nil)
end

function UIDeliverySimulatorEntrance:OnClickGameBtnReview()
  local sectorStage = self.actData:GetMainCfg().story_sector
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, function(window)
    if window == nil then
      return
    end
    window:InitSectorLevel(sectorStage, nil, 1)
  end)
end

function UIDeliverySimulatorEntrance:_OnClickReturn(tohome)
  local actCtrl = ControllerManager:GetController(ControllerTypeId.ActDeliverySimulator)
  actCtrl:ExitActDSEntrance()
  if tohome then
    actCtrl:BackToHome()
  else
    actCtrl:BackToSector()
  end
end

function UIDeliverySimulatorEntrance:OnDelete()
  TimerManager:StopTimer(self._timerId)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  RedDotController:RemoveListener(self.nodePath, self.refreshEntranceDotBind)
end

return UIDeliverySimulatorEntrance
