local UIActivitySaveMoneyMain = class("UIActivitySaveMoneyMain", UIBaseWindow)
local base = UIBaseWindow
local JumpManager = require("Game.Jump.JumpManager")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivitySaveMoneyEnum = require("Game.ActivitySaveMoney.Enum.ActivitySaveMoneyEnum")
local UINAcitvitySaveMoneySaveOptionItem = require("Game.ActivitySaveMoney.UI.UINAcitvitySaveMoneySaveOptionItem")
local UINAcitvitySaveMoneyWithdrawOptionItem = require("Game.ActivitySaveMoney.UI.UINAcitvitySaveMoneyWithdrawOptionItem")
local UINSaveMoneyRewardItem = require("Game.ActivitySaveMoney.UI.UINSaveMoneyRewardItem")
local CS_DOTweenAnimation = CS.DG.Tweening.DOTweenAnimation
local __InitTopNodeTime = {
  [ActivitySaveMoneyEnum.SaveMoneyActivityState.saveState] = function(self)
    local startTime, endTime = self.saveMoneyData:GetSaveMoneyStateStartEndTimeByState(ActivitySaveMoneyEnum.SaveMoneyActivityState.saveState)
    self.ui.tex_StartTime.text = startTime
    self.ui.tex_EndTime.text = endTime
    self.ui.tex_Rank:SetIndex(0)
  end,
  [ActivitySaveMoneyEnum.SaveMoneyActivityState.getState] = function(self)
    local startTime, endTime = self.saveMoneyData:GetSaveMoneyStateStartEndTimeByState(ActivitySaveMoneyEnum.SaveMoneyActivityState.getState)
    self.ui.tex_StartTime.text = startTime
    self.ui.tex_EndTime.text = endTime
    self.ui.tex_Rank:SetIndex(1)
  end
}
local __InitChildUIFunc = {
  [ActivitySaveMoneyEnum.SaveMoneyActivityState.saveState] = function(self)
    self.ui.obj_Save:SetActive(true)
    __InitTopNodeTime[ActivitySaveMoneyEnum.SaveMoneyActivityState.saveState](self)
    for _, saveCfg in ipairs(self.saveMoneyData:GetSaveMoneySaveCfg()) do
      local saveItem = self.saveOptionItemPool:GetOne()
      saveItem:InitSaveMoneyOptionItem(self.resloader, saveCfg)
    end
  end,
  [ActivitySaveMoneyEnum.SaveMoneyActivityState.getState] = function(self)
    self.ui.obj_Withdraw:SetActive(true)
    if self.forceShowSaveTime then
      __InitTopNodeTime[ActivitySaveMoneyEnum.SaveMoneyActivityState.saveState](self)
    else
      __InitTopNodeTime[ActivitySaveMoneyEnum.SaveMoneyActivityState.getState](self)
    end
    local saveCfg = self.saveMoneyData:GetSaveMoneySaveCfg()[self.saveMoneyData.saveLevel]
    if saveCfg == nil then
      return
    end
    self.withdrawOptionItem:InitSaveMoneyOptionItem(self.resloader, saveCfg)
    local rewardCfgs = self.saveMoneyData:GetSaveMoneySelectedLevelCfg()
    for index, rewardCfg in ipairs(rewardCfgs) do
      local rewardItem = self.saveMoneyRewardItemPool:GetOne(true)
      rewardItem:InitSaveMoneyRewardItem(rewardCfg)
      self.rewardItems[index] = rewardItem
    end
  end,
  [ActivitySaveMoneyEnum.SaveMoneyActivityState.expire] = function(self)
    UIUtil.ReturnHome()
  end
}

function UIActivitySaveMoneyMain:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  self.saveMoneyController = ControllerManager:GetController(ControllerTypeId.ActivitySaveMoney, true)
  self.resloader = CS.ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Background, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Tip, self, self.__ShowGuideTip)
  self.saveOptionItemPool = UIItemPool.New(UINAcitvitySaveMoneySaveOptionItem, self.ui.obj_SaveOptionItem, false)
  self.saveMoneyRewardItemPool = UIItemPool.New(UINSaveMoneyRewardItem, self.ui.obj_StageItem, false)
  self.withdrawOptionItem = UINAcitvitySaveMoneyWithdrawOptionItem.New()
  self.withdrawOptionItem:Init(self.ui.obj_WithdrawOptionItem)
  self._lastCouldUseItemJump = JumpManager.couldUseItemJump
  JumpManager.couldUseItemJump = false
  self.TweenDic = self.transform:GetComponentsInChildren(typeof(CS_DOTweenAnimation))
end

function UIActivitySaveMoneyMain:InitSaveMoneyMain(actId, isPop)
  self.isPop = isPop
  self.saveMoneyData = self.saveMoneyController:GetSaveMoneyDataByActId(actId)
  if self.saveMoneyData == nil then
    return
  end
  if isPop then
    self.ui.tog_Popup.gameObject:SetActive(true)
    self.ui.btn_Close.gameObject:SetActive(true)
    self.ui.btn_Background.gameObject:SetActive(true)
    local scale = self.ui.obj_Main.transform.localScale
    scale.x = 0.9
    scale.y = 0.9
    self.ui.obj_Main.transform.localScale = scale
  else
    self.ui.tog_Popup.gameObject:SetActive(false)
    self.ui.btn_Close.gameObject:SetActive(false)
    self.ui.btn_Background.gameObject:SetActive(false)
    local scale = self.ui.obj_Main.transform.localScale
    scale.x = 1
    scale.y = 1
    self.ui.obj_Main.transform.localScale = scale
    self.saveMoneyData:SetSaveMoneyUILooked()
    for i = 0, self.TweenDic.Length - 1 do
      local tween = self.TweenDic[i]
      tween:DOComplete()
    end
  end
  self:RefreshSaveMoneyUI()
end

function UIActivitySaveMoneyMain:RefreshSaveMoneyUI()
  self.ui.obj_Save:SetActive(false)
  self.ui.obj_Withdraw:SetActive(false)
  self.saveOptionItemPool:HideAll()
  self.saveMoneyRewardItemPool:HideAll()
  self.rewardItems = {}
  local currentTm = PlayerDataCenter.timestamp
  local saveEndTm = self.saveMoneyData:GetSaveMoneyMainCfg().save_end_time
  self.forceShowSaveTime = currentTm <= saveEndTm
  if self._countDowntimer ~= nil then
    TimerManager:StopTimer(self._countDowntimer)
    self._countDowntimer = nil
  end
  self._countDowntimer = TimerManager:StartTimer(1, self.__TimerCountdown, self)
  self:__TimerCountdown()
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(self.saveMoneyData:GetActivityName())
  self.ui.tex_Des.text = ConfigData:GetTipContent(self.saveMoneyData:GetSaveMoneyMainCfg().activity_des)
  local currentActivityState = self.saveMoneyData:GetSaveMoneyActivityState()
  if __InitChildUIFunc[currentActivityState] ~= nil then
    __InitChildUIFunc[currentActivityState](self)
  end
end

function UIActivitySaveMoneyMain:SetCloseCallback(closeCallback)
  self._closeCallback = closeCallback
end

function UIActivitySaveMoneyMain:__ShowGuideTip()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    local mainCfg = self.saveMoneyData:GetSaveMoneyMainCfg()
    window:InitCommonInfo(ConfigData:GetTipContent(mainCfg.task_rule_id), ConfigData:GetTipContent(mainCfg.task_rule_title), nil, true)
  end)
end

function UIActivitySaveMoneyMain:__TimerCountdown()
  for _, rewardItem in pairs(self.rewardItems) do
    rewardItem:SetRewardItemTimeRemain()
  end
  local countdownStr, diff = self.saveMoneyData:GetSaveMoneyCountDownTimeByState()
  if self.forceShowSaveTime then
    countdownStr, diff = self.saveMoneyData:GetSaveMoneyCountDownTimeByState(ActivitySaveMoneyEnum.SaveMoneyActivityState.saveState)
  else
    countdownStr, diff = self.saveMoneyData:GetSaveMoneyCountDownTimeByState(ActivitySaveMoneyEnum.SaveMoneyActivityState.getState)
  end
  self.ui.tex_Time.text = countdownStr
end

function UIActivitySaveMoneyMain:BackAction()
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
  self:Delete()
end

function UIActivitySaveMoneyMain:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIActivitySaveMoneyMain:OnDelete()
  JumpManager.couldUseItemJump = self._lastCouldUseItemJump
  self.saveOptionItemPool:DeleteAll()
  self.saveMoneyRewardItemPool:DeleteAll()
  if self.ui.tog_Popup.isOn then
    self.saveMoneyData:SetSaveMoneyCantPopToday()
  end
  TimerManager:StopTimer(self._countDowntimer)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UIActivitySaveMoneyMain
