local base = UIBaseWindow
local UIReinforceCardMain = class("UIReinforceCardMain", base)
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local eReinforce = require("Game.Reinforce.Enum.eReinforce")
local ActAnniversary24Enum = require("Game.ActivityAnniversary24.Data.ActAnniversary24Enum")
local ReinforceUtil = require("Game.Reinforce.Util.ReinforceUtil")
local cs_MessageCommon = CS.MessageCommon

function UIReinforceCardMain:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction)
  UIUtil.AddButtonListener(self.ui.btn_Draw, self, self.OnClickGetSysCard)
  UIUtil.AddButtonListener(self.ui.btn_Handbook, self, self.OnClickCardHandBook)
  UIUtil.AddButtonListener(self.ui.btn_RepeatDun, self, self.OnClickRepeatLevel)
  UIUtil.AddButtonListener(self.ui.btn_Challenge, self, self.OnClickHardLevel)
  UIUtil.AddButtonListener(self.ui.btn_Unlimit, self, self.OnClickInfiniteLevel)
  UIUtil.AddButtonListener(self.ui.btn_CardSet, self, self.OnClickSetRfFactorSupportCard)
  UIUtil.AddButtonListener(self.ui.Btn_Reward, self, self.OnClickSupportReward)
  self.RefreshAllRedDotCallback = BindCallback(self, self.RefreshAllRedDot)
end

function UIReinforceCardMain:OnShow()
  self:PlayAniCover()
  UIManager:DeleteWindow(UIWindowTypeID.UIReinforceCardSetSelect)
end

function UIReinforceCardMain:InitReinforceCardMain(actData, closeFunc, playType)
  self.actData = actData
  self.closeFunc = closeFunc
  local title, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(self.actData.actInfo)
  self.expireTime = expireTime
  self.ui.tex_Time.text = ActivityFrameUtil.CombineShowEndTimeStr(title, timeStr)
  self.timerId = TimerManager:StartTimer(1, self.__OnTimeDown, self)
  self:__OnTimeDown()
  self:RefreshLockState()
  self:RefreshAllRedDot()
  self:RefreshSupportReward()
  local reddot = self.actData:GetActivityReddot()
  RedDotController:AddListener(reddot.nodePath, self.RefreshAllRedDotCallback)
  if self.actData:IsActivityRunning() and (playType == nil or playType == 0) then
    local guideId = ConfigData.reinforce_exploration_main[self.actData:GetActFrameId()].guide_id
    GuideManager:StartNewTriggerGuide(guideId)
    guideId = ConfigData.reinforce_exploration_main[self.actData:GetActFrameId()].sec_guide_id
    GuideManager:StartNewTriggerGuide(guideId)
    return
  end
  local win = UIManager:GetWindow(UIWindowTypeID.ClickContinue)
  if win then
    win:OnClickBg()
  end
  if playType == eReinforce.dunPlayType.infiniteLevel then
    self:OnClickInfiniteLevel()
  elseif playType == eReinforce.dunPlayType.HardLevel then
    self:OnClickHardLevel()
  elseif playType == eReinforce.dunPlayType.repeatLevel then
    self:OnClickRepeatLevel()
  end
end

function UIReinforceCardMain:__OnTimeDown()
  local diffStr, diff = ActivityFrameUtil.GetCountdownTimeStr(self.expireTime)
  self.ui.tex_TimeLeft.text = diffStr
  if diff <= 0 then
    self:StopActTimer()
  end
end

function UIReinforceCardMain:StopActTimer()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
end

function UIReinforceCardMain:PlayAniCover()
  self.aniTimer = TimerManager:StartTimer(2, function()
    self:CloseAniTimer()
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end, nil, true)
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(function()
    self:CloseAniTimer()
    self:StopCardMainAni()
  end, nil, nil, nil, true)
end

function UIReinforceCardMain:CloseAniTimer()
  if self.aniTimer ~= nil then
    TimerManager:StopTimer(self.aniTimer)
    self.aniTimer = nil
  end
end

function UIReinforceCardMain:StopCardMainAni()
  local aniState = self.ui.ani_cardMain:get_Item("UI_ReinforceCardMain")
  aniState.time = aniState.length
  self.ui.ani_cardMain:Sample()
end

function UIReinforceCardMain:RefreshLockState()
  for i, obj in pairs(self.ui.list_lockObj) do
    obj:SetActive(not self.actData:IsActivityRunning())
  end
end

function UIReinforceCardMain:RefreshAllRedDot()
  self:RefreshCardMainBlueDot()
  self:RefreshInfinityRedDot()
  self:RefreshChallengeRedDot()
  self:RefreshSetSupportBlueDot()
end

function UIReinforceCardMain:RefreshCardMainBlueDot()
  local rootNode = self.actData:GetActChildRedDot(ActAnniversary24Enum.reddotType.ThreeInOne)
  local childReddot = rootNode:AddChild(ActAnniversary24Enum.reddotSubType.HandBookCollection)
  self.ui.obj_HandBoolBlueDot:SetActive(childReddot ~= nil and childReddot:GetRedDotCount() > 0)
end

function UIReinforceCardMain:RefreshInfinityRedDot()
  local rootNode = self.actData:GetActChildRedDot(ActAnniversary24Enum.reddotType.ThreeInOne)
  local childReddot = rootNode:AddChild(ActAnniversary24Enum.reddotSubType.Inifinity)
  self.ui.obj_infinityRedDot:SetActive(childReddot ~= nil and childReddot:GetRedDotCount() > 0)
end

function UIReinforceCardMain:RefreshChallengeRedDot()
  local rootNode = self.actData:GetActChildRedDot(ActAnniversary24Enum.reddotType.ThreeInOne)
  local childReddot = rootNode:AddChild(ActAnniversary24Enum.reddotSubType.challenge)
  self.ui.obj_challengeRedDot:SetActive(childReddot ~= nil and childReddot:GetRedDotCount() > 0)
end

function UIReinforceCardMain:RefreshSetSupportBlueDot()
  local actAn24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
  local rfDataAll = actAn24Ctrl:GetActFirstData():GetActAnv24RfCardDataAll()
  local isHasEmptyPos = rfDataAll:GetAvailableRfFactorCardAsSupportPos() ~= -1
  local hasCheckSetSupportBlueDot = ReinforceUtil.GetHasCheckSetSupportBlueDot()
  self.ui.setSupportBlueDot:SetActive(isHasEmptyPos and not hasCheckSetSupportBlueDot)
end

function UIReinforceCardMain:SetMainClose(bool)
  if bool then
    UIManager:HideWindow(UIWindowTypeID.UIReinforceCardMain)
  else
    UIManager:ShowWindowOnly(UIWindowTypeID.UIReinforceCardMain)
  end
end

function UIReinforceCardMain:RefreshSupportReward()
  local pickedNum, totalNum = self.actData:GetSupportCardRewardProgress()
  if totalNum <= pickedNum then
    self.ui.Btn_Reward.gameObject:SetActive(false)
    return
  end
  local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleAssistFactorNum, 0)
  local usedTimes = 0
  if counterElem ~= nil and counterElem.nextExpiredTm > PlayerDataCenter.timestamp then
    usedTimes = counterElem.times
  end
  local showNum = math.min(totalNum - pickedNum, usedTimes)
  self.ui.Btn_Reward.gameObject:SetActive(0 < showNum)
  self.ui.Tex_SupportRewardNum.text = tostring(showNum)
end

function UIReinforceCardMain:OnClickGetSysCard()
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardPackShop, function(window)
    local actData = self.actData
    local actId = actData:GetActId()
    local actFrameId = actData:GetActFrameId()
    self:SetMainClose(true)
    window:InitReinforceCardPackShop(actId, actFrameId, function()
      self:SetMainClose(false)
    end)
  end)
end

function UIReinforceCardMain:OnClickCardHandBook()
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardHandBook, function(window)
    local actData = self.actData
    local actId = actData:GetActId()
    local actFrameId = actData:GetActFrameId()
    self:SetMainClose(true)
    window:InitReinforceCardHandBook(actId, actFrameId, function()
      self:SetMainClose(false)
    end)
  end)
end

function UIReinforceCardMain:OnClickInfiniteLevel()
  local anniversary24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
  if not anniversary24Ctrl then
    return
  end
  if not self.actData:IsActivityRunning() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(6033))
    return
  end
  self:SetMainClose(true)
  anniversary24Ctrl:OpenReinforceCardDun(self.actData, function()
    self:SetMainClose(false)
  end, true)
end

function UIReinforceCardMain:OnClickHardLevel()
  local anniversary24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
  if not anniversary24Ctrl then
    return
  end
  if not self.actData:IsActivityRunning() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(6033))
    return
  end
  self:SetMainClose(true)
  anniversary24Ctrl:OpenReinforceCardDun(self.actData, function()
    self:SetMainClose(false)
  end, false)
end

function UIReinforceCardMain:OnClickRepeatLevel()
  local anniversary24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
  if not anniversary24Ctrl then
    return
  end
  if not self.actData:IsActivityRunning() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(6033))
    return
  end
  self:SetMainClose(true)
  anniversary24Ctrl:OpenReinforceCardSet(self.actData, function()
    self:SetMainClose(false)
  end)
end

function UIReinforceCardMain:OnClickSetRfFactorSupportCard()
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardStorage, function(window)
    if window == nil then
      return
    end
    local actAn24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
    local rfDataAll = actAn24Ctrl:GetActFirstData():GetActAnv24RfCardDataAll()
    window:InitRfCardFacStorage(rfDataAll)
    ReinforceUtil.SetHasCheckSetSupportBlueDot(true)
    self:RefreshSetSupportBlueDot()
  end)
end

function UIReinforceCardMain:OnClickSupportReward()
  local actFrameId = self.actData:GetActFrameId()
  local reinforceNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Reinforce)
  reinforceNetCtrl:CS_AssisFactorReward(actFrameId, function(args)
    local rewardDic = args[0]
    local pickedNum, totalCount = self.actData:GetSupportCardRewardProgress()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseDic(rewardDic)
      CRData:SetDownInfo(ConfigData:GetTipContent(59033), string.format("%s/%s", tostring(pickedNum), tostring(totalCount)))
      window:AddAndTryShowReward(CRData)
    end)
    self:RefreshSupportReward()
  end)
end

function UIReinforceCardMain:BackAction()
  local win = UIManager:GetWindow(UIWindowTypeID.ClickContinue)
  if win then
    win:OnClickBg()
  end
  if self.closeFunc then
    self.closeFunc()
  end
  self:Delete()
end

function UIReinforceCardMain:OnDelete()
  self:CloseAniTimer()
  self:StopActTimer()
  local reddot = self.actData:GetActivityReddot()
  RedDotController:RemoveListener(reddot.nodePath, self.RefreshAllRedDotCallback)
  base.OnDelete(self)
end

return UIReinforceCardMain
