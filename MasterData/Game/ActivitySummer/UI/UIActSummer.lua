local UIActSummer = class("UIActSummer", UIBaseWindow)
local base = UIBaseWindow
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function UIActSummer:OnInit()
  UIUtil.SetTopStatus(self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Main, self, self.OnClickMainEp)
  UIUtil.AddButtonListener(self.ui.btn_Challenge, self, self.OnClickChallenge)
  UIUtil.AddButtonListener(self.ui.btn_Weekly, self, self.OnClickWeekly)
  UIUtil.AddButtonListener(self.ui.btn_ActShop, self, self.OnClickSummerShop)
  self.__OnListenUpdate = BindCallback(self, self.OnListenItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnListenUpdate)
  self.__OnRefreshTimeDayPass = BindCallback(self, self.__RefreshTimeDayPass)
  MsgCenter:AddListener(eMsgEventId.SectorActivityTimePass, self.__OnRefreshTimeDayPass)
  self._unlockMat = CS.UnityEngine.Object.Instantiate(self.ui.img_btn_Main.material)
  self._unlockMat:SetFloat("_Intensity", 5)
  self.__OnShowSummerUI = BindCallback(self, self.OnShowSummerUI)
  self.__OnEnterSectorISector = BindCallback(self, self.OnEnterSectorISector)
end

function UIActSummer:InitActivitySummer(sectorIData, normalDungeonCallback, closeCallback)
  AudioManager:PlayAudioById(3108)
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Sector.name, eAuSelct.Sector.roomSelect)
  self.summerData = sectorIData
  self.summerCfg = self.summerData:GetSectorICfg()
  self._coinId = self.summerData:GetActSectorIDataCoinId()
  self.normalDungeonCallback = normalDungeonCallback
  self.closeCallback = closeCallback
  self.ui.img_btn_Main.material = self._unlockMat
  self.ui.img_btn_Challenge.material = self._unlockMat
  self.ui.img_Item.sprite = CRH:GetSpriteByItemId(self._coinId)
  self.sectorList = {
    self.summerCfg.easy_stage,
    self.summerCfg.hard_stage
  }
  self:_PlayWinTweenOrComplete(self.summerData)
  self:RefreshSummer()
  self:__InitActReddot()
  if self.summerCfg.first_avg > 0 then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local played = avgPlayCtrl:IsAvgPlayed(self.summerCfg.first_avg)
    if not played and self.summerData:IsActivityRunning() then
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, self.summerCfg.first_avg)
    end
  end
end

function UIActSummer:__InitActReddot()
  if self.__onActivitySectorIReddot == nil then
    function self.__onActivitySectorIReddot(node)
      self.ui.obj_challengeRedDot:SetActive(node:GetRedDotCount() > 0)
    end
    
    local node = self.summerData:GetActivityReddot()
    if node ~= nil then
      self.ui.obj_challengeRedDot:SetActive(node:GetRedDotCount() > 0)
      RedDotController:AddListener(node.nodePath, self.__onActivitySectorIReddot)
    end
  end
end

function UIActSummer:RefreshSummer()
  self.ui.tex_Count.text = PlayerDataCenter:GetItemCount(self._coinId)
  self:__RefreshTimeOutData()
  self:__RefreshTimeDayPass()
  self:__RefreshTimeWeeklyState()
  if self._outDataTime > PlayerDataCenter.timestamp and self.timerId == nil then
    self.timerId = TimerManager:StartTimer(1, self.OnTimerEndTimeCountDown, self)
  end
  self:OnTimerEndTimeCountDown()
end

function UIActSummer:__RefreshTimeOutData()
  self._outDataTime = self.summerData:GetActivityEndTime()
  if self._outDataTime > PlayerDataCenter.timestamp then
    local date = TimeUtil:TimestampToDate(self._outDataTime, false, true)
    self.ui.tex_Time:SetIndex(0, string.format("%02d", date.year), string.format("%02d", date.month), string.format("%02d", date.day), string.format("%02d", date.hour), string.format("%02d", date.min))
    self.ui.challengeLockItem:SetActive(false)
    self.ui.tex_ChallengeCount.gameObject:SetActive(true)
  else
    self._outDataTime = self.summerData:GetActivityDestroyTime()
    local date = TimeUtil:TimestampToDate(self._outDataTime, false, true)
    self.ui.tex_Time:SetIndex(1, string.format("%02d", date.year), string.format("%02d", date.month), string.format("%02d", date.day), string.format("%02d", date.hour), string.format("%02d", date.min))
    self.ui.challengeLockItem:SetActive(true)
    self.ui.tex_ChallengeCount.gameObject:SetActive(false)
  end
  if self._outDataTime < PlayerDataCenter.timestamp and self.timerId ~= nil then
    self.timerId = TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
end

function UIActSummer:__RefreshTimeDayPass()
  local _, battleCount, allCount = self.summerData:GetSectorIBattleCount()
  local remainCount = allCount - battleCount
  self.ui.tex_ChallengeCount:SetIndex(0, string.format("%d/%d", remainCount, allCount))
  self._nextDayTime = nil
  self.ui.tex_challenge_Time.gameObject:SetActive(false)
  if not self.summerData:IsActivityRunning() then
    return
  end
  local nextShowTime = self.summerData:GetNextExpireTimeInShow()
  if nextShowTime > self.summerData:GetActivityEndTime() then
    return
  end
  self.ui.tex_challenge_Time.gameObject:SetActive(true)
  self._nextDayTime = nextShowTime
end

function UIActSummer:__RefreshTimeWeeklyState()
  local islock = false
  self.ui.weeklyLockItem:SetActive(islock)
  self.ui.fade_Weekly.alpha = islock and 0.6 or 1
  self._weeklyTime = islock and self.summerCfg.weekly_time or nil
end

function UIActSummer:OnTimerEndTimeCountDown()
  local remainTime = self._outDataTime - PlayerDataCenter.timestamp
  if 0 < remainTime then
    if 86400 < remainTime then
      self.ui.tex_Day:SetIndex(0, tostring(math.ceil(remainTime / 86400)))
    elseif 3600 < remainTime then
      self.ui.tex_Day:SetIndex(1, tostring(math.ceil(remainTime / 3600)))
    else
      self.ui.tex_Day:SetIndex(2, tostring(math.ceil(remainTime / 60)))
    end
  else
    self:__RefreshTimeOutData()
  end
  if self._weeklyTime ~= nil then
    local coutdown = self._weeklyTime - PlayerDataCenter.timestamp
    if 0 < coutdown then
      if 86400 < coutdown then
        self.ui.tex_unlcokTime:SetIndex(0, tostring(math.ceil(coutdown / 86400)))
      elseif 3600 < coutdown then
        self.ui.tex_unlcokTime:SetIndex(1, tostring(math.ceil(coutdown / 3600)))
      else
        self.ui.tex_unlcokTime:SetIndex(2, tostring(math.ceil(coutdown / 60)))
      end
    else
      self:__RefreshTimeWeeklyState()
    end
  end
  if self._nextDayTime ~= nil then
    local coutdown = self._nextDayTime - PlayerDataCenter.timestamp
    if 0 < coutdown then
      local str = TimeUtil:TimestampToTime(coutdown)
      self.ui.tex_challenge_Time:SetIndex(0, str)
    else
      self._nextDayTime = self:__RefreshTimeDayPass()
    end
  end
end

function UIActSummer:_PlayWinTweenOrComplete(summerData)
  if summerData:GetMainWindowIsFirstInit() then
    summerData:SetMainWindowIsFirstInit(false)
  else
    for _, compoment in ipairs(self.ui.DOTweens) do
      compoment:DOComplete()
    end
  end
end

function UIActSummer:OnClickMainEp()
  if not self.summerData:IsActivityRunning() then
    self:OnEnterSectorISector(self.summerCfg.hard_stage)
    return
  end
  local flag, defaultSectorId = self.summerData:GetLastSectorISector()
  if flag then
    self:OnEnterSectorISector(defaultSectorId)
    return
  end
  if not SectorStageDetailHelper.IsSectorNoCollide(self.summerCfg.hard_stage, true) then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ActSummerLvSwitch, function(window)
    if window == nil then
      return
    end
    local defaultSelectIndex = 1
    local stageId = ConfigData.sector_stage.sectorDiffDic[self.summerCfg.hard_stage][1][1]
    if stageId ~= nil then
      local stageCfg = ConfigData.sector_stage[stageId]
      if stageCfg ~= nil then
        local preStageId = stageCfg.pre_stage[1]
        defaultSelectIndex = PlayerDataCenter.sectorStage:IsStageComplete(preStageId) and #self.sectorList or defaultSelectIndex
      end
    end
    window:InitIActSummerLvSwitch(self.sectorList, defaultSelectIndex, self.__OnEnterSectorISector)
  end)
end

function UIActSummer:OnClickChallenge()
  if not self.summerData:IsActivityRunning() then
    return
  end
  self:OnEnterSectorISector(self.summerCfg.rechallenge_stage)
end

function UIActSummer:OnEnterSectorISector(sectorId)
  if SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) and self.normalDungeonCallback ~= nil then
    self:OnHideSummerUI()
    self.normalDungeonCallback(sectorId, 1, nil, self.__OnShowSummerUI)
  end
end

function UIActSummer:OnClickWeekly()
  if self.summerCfg.weekly_time > PlayerDataCenter.timestamp then
    return
  end
  JumpManager:Jump(JumpManager.eJumpTarget.WeeklyChallenge)
end

function UIActSummer:OnClickSummerShop()
  UIManager:ShowWindowAsync(UIWindowTypeID.ActSum21Exchange, function(win)
    if win == nil then
      return
    end
    win:InitActSum21Exchange(self.summerData, true)
  end)
end

function UIActSummer:OnListenItemUpdate(itemUpdate)
  if itemUpdate[self._coinId] ~= nil then
    self.ui.tex_Count.text = PlayerDataCenter:GetItemCount(self._coinId)
  end
end

function UIActSummer:OnHideSummerUI()
  UIManager:HideWindow(UIWindowTypeID.ActSummer)
end

function UIActSummer:OnShowSummerUI()
  UIManager:ShowWindowOnly(UIWindowTypeID.ActSummer)
end

function UIActSummer:_OnClickClose(isToHome)
  if not isToHome then
    local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
    if sectorCtrl ~= nil then
      sectorCtrl:PlaySectorBgm()
    end
  end
  if self.closeCallback ~= nil then
    self.closeCallback(isToHome)
  end
  self:Delete()
end

function UIActSummer:__RemoveActReddot()
  if self.__onActivitySectorIReddot ~= nil then
    local node = self.summerData:GetActivityReddot()
    if node ~= nil then
      RedDotController:RemoveListener(node.nodePath, self.__onActivitySectorIReddot)
    end
    self.__onActivitySectorIReddot = nil
  end
end

function UIActSummer:OnDelete()
  base.OnDelete(self)
  DestroyUnityObject(self._unlockMat)
  self:__RemoveActReddot()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnListenUpdate)
  MsgCenter:RemoveListener(eMsgEventId.SectorActivityTimePass, self.__OnRefreshTimeDayPass)
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
end

return UIActSummer
