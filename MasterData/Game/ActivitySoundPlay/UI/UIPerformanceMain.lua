local base = UIBaseWindow
local UIPerformanceMain = class("UIPerformanceMain", base)
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local SectorEnum = require("Game.Sector.SectorEnum")
local TaskEnum = require("Game.Task.TaskEnum")

function UIPerformanceMain:OnInit()
  local TopStatusData = UIUtil.CreateNewTopStatusData(self)
  TopStatusData.topBtnOnlyReturn = true
  TopStatusData:SetTopStatusBackAction(self.Delete):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_PlayFree, self, self.OnClickFreePlay)
  UIUtil.AddButtonListener(self.ui.btn_Play, self, self.OnClickSoundPlay)
  UIUtil.AddButtonListener(self.ui.btn_ShowTask, self, self.OnClickShowTask)
  UIUtil.AddButtonListener(self.ui.btn_Tip, self, self.OnClickTips)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.UINBaseItemWithCount)
  self.ui.UINBaseItemWithCount:SetActive(false)
  self.__OnPerformanceChange = BindCallback(self, self.OnPerformanceChange)
  MsgCenter:AddListener(eMsgEventId.TinyGameDataChange, self.__OnPerformanceChange)
end

function UIPerformanceMain:InitPerformanceMain(closeCallback)
  self.closeCallback = closeCallback
  self.miniGameMusicController = ControllerManager:GetController(ControllerTypeId.MiniGameMusic, true)
  self.tinigameData = self.miniGameMusicController:GetTinyGameSoundPlayData()
  self:RefreshReward()
  self:RefreshActivityTime()
end

function UIPerformanceMain:OnPerformanceChange()
  self:RefreshReward()
  self:RefreshActivityTime()
end

function UIPerformanceMain:RefreshRewardProgress(currentPoint, nextRewardPoint)
  self.ui.tex_rewardProgress:SetIndex(0, tostring(currentPoint), tostring(nextRewardPoint))
end

function UIPerformanceMain:RefreshReward()
  local currentPoint = self.tinigameData:GetTinyGameRewardLevelPoint()
  local rewardCfg = self.tinigameData:GetNextRewardCfg()
  self:RefreshRewardProgress(currentPoint, rewardCfg.point)
  self.rewardItemPool:HideAll()
  if rewardCfg ~= nil then
    for k, id in ipairs(rewardCfg.rewardIds) do
      local num = rewardCfg.rewardNums[k]
      local itemCfg = ConfigData.item[id]
      local rewardItem = self.rewardItemPool:GetOne()
      rewardItem:InitItemWithCount(itemCfg, num)
    end
  end
  self:RefreshRewardRedPoint()
end

function UIPerformanceMain:RefreshRewardRedPoint()
  local isActiveRedPoint = self.tinigameData:IsSoundPlayTaskComplete() or self.tinigameData:IsSoundPlayAchieveComplete()
  self.ui.obj_redDot:SetActive(isActiveRedPoint)
end

function UIPerformanceMain:RefreshActivityTime()
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(self.tinigameData._uid)
  local bornTime = actFrameData:GetActivityStartTime()
  local destoryTime = actFrameData:GetActivityEndTime()
  self.ui.tex_Before.text = TimeUtil:TimestampToDateString(bornTime, false, true, "%m/%d %H:%M")
  self.ui.tex_After.text = TimeUtil:TimestampToDateString(destoryTime, false, true, "%m/%d %H:%M")
end

function UIPerformanceMain:OnClickFreePlay()
  UIManager:ShowWindowAsync(UIWindowTypeID.PerformancePlay, function(window)
    if window == nil then
      return
    end
    local musicCfg = ConfigData.tiny_game_instrument[1]
    window:InitMiniGameMusic(musicCfg)
  end)
end

function UIPerformanceMain:OnClickSoundPlay()
  UIManager:ShowWindowAsync(UIWindowTypeID.PerformanceSelect, function(win)
    win:InitPerformanceSelect()
  end)
end

function UIPerformanceMain:OnClickShowTask()
  UIManager:ShowWindowAsync(UIWindowTypeID.PerformanceGameTask, function(win)
    if win == nil then
      return
    end
    win:InitPerformanceTask(self.tinigameData)
  end)
end

function UIPerformanceMain:OnClickTips()
  local cfg = self.tinigameData.mainCfg
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(cfg.task_rule_id), ConfigData:GetTipContent(cfg.task_rule_title))
  end)
end

function UIPerformanceMain:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TinyGameDataChange, self.__OnPerformanceChange)
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self.rewardItemPool:DeleteAll()
  self.rewardItemPool = nil
end

return UIPerformanceMain
