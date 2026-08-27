local UISpring23Main = class("UISpring23Main", UIBaseWindow)
local base = UIBaseWindow
local ActivityHallowmasEnum = require("Game.ActivityHallowmas.ActivityHallowmasEnum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local cs_MessageCommon = CS.MessageCommon

function UISpring23Main:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseSpring)
  UIUtil.AddButtonListener(self.ui.btn_story, self, self.OnClickStory)
  UIUtil.AddButtonListener(self.ui.btn_hard, self, self.OnClickStory)
  UIUtil.AddButtonListener(self.ui.btn_StartListen, self, self.OnClickStrartPlay)
end

function UISpring23Main:InitSpring23Main(actSpringData, enterFunc, backCallback)
  AudioManager:PlayAudioById(3360)
  self._data = actSpringData
  self._enterFunc = enterFunc
  self._backCallback = backCallback
end

function UISpring23Main:__TryOpenNewUnlock()
  local actUnlockInfo = self._data:GetActHallowmasUnlockInfo()
  if actUnlockInfo:IsExistActUnlockInfo() then
    UIManager:ShowWindowAsync(UIWindowTypeID.Christmas22Unlock, function(window)
      if window == nil then
        return
      end
      window:Christmas22UnlockBindFunc(BindCallback(self, self.OnClickStorySector), BindCallback(self, self.OnClickSeason), BindCallback(self, self.OnClickDungeon))
      window:InitChristmas22NewUnlock(actUnlockInfo, self._data)
    end)
  end
end

function UISpring23Main:EnterChristmas22Sector(selectSector)
  if selectSector ~= self._cfg.story_stage then
    return
  end
  self:OnClickStorySector()
end

function UISpring23Main:__OnTimeDown()
  if self._expireTime == nil or self._expireTime > PlayerDataCenter.timestamp then
    local title, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(self._data)
    self.ui.title.text = title
    self.ui.tex_Timer.text = timeStr
    self._expireTime = expireTime
  end
  local diffStr, diff = ActivityFrameUtil.GetCountdownTimeStr(self._expireTime)
  self.ui.tex_Days.text = diffStr
  if diff <= 0 then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
end

function UISpring23Main:__Refresh()
  self.ui.tex_bound_Progress:SetIndex(0, tostring(self._data:GetHallowmasLv()), tostring(self._data:GetHallowmasCurExp()), tostring(self._data:GetHallowmasCurExpLimit()))
  local taskCount = table.count(self._data:GetHallowmasDailyTaskIdDic())
  self.ui.tex_task_Progress.text = tostring(taskCount) .. "/" .. tostring(self._cfg.task_limit)
  local isUnComplete = WarChessSeasonManager:GetUncompleteWCSData()
  self.ui.img_ListeningBg:SetActive(isUnComplete)
end

function UISpring23Main:__RefreshReddot(reddot)
  local taskRed = reddot:GetChild(ActivityHallowmasEnum.reddotType.DailyTask)
  local expRed = reddot:GetChild(ActivityHallowmasEnum.reddotType.Exp)
  local achievementRed = reddot:GetChild(ActivityHallowmasEnum.reddotType.Achievement)
  local sectorAvgRed = reddot:GetChild(ActivityHallowmasEnum.reddotType.SectorAvg)
  local techRed = reddot:GetChild(ActivityHallowmasEnum.reddotType.Tech)
  local taskRedCount = taskRed ~= nil and taskRed:GetRedDotCount() or 0
  local expRedCount = expRed ~= nil and expRed:GetRedDotCount() or 0
  local achievementRedCount = achievementRed ~= nil and achievementRed:GetRedDotCount() or 0
  local sectorAvgRedCount = sectorAvgRed ~= nil and sectorAvgRed:GetRedDotCount() or 0
  local techRedCount = techRed ~= nil and techRed:GetRedDotCount() or 0
  self._btnNodeDic[BtnEnum.StorySector]:SetChristmasBtnRed(0 < sectorAvgRedCount)
  self._btnNodeDic[BtnEnum.Tech]:SetChristmasBtnRed(0 < techRedCount)
  self._btnNodeDic[BtnEnum.Bonus]:SetChristmasBtnRed(0 < expRedCount)
  self._btnNodeDic[BtnEnum.Task]:SetChristmasBtnRed(0 < taskRedCount or 0 < achievementRedCount)
end

function UISpring23Main:SetXMasDunSectorCallback(callback)
  self.xMasDunCallback = callback
end

function UISpring23Main:OnClickStory()
end

function UISpring23Main:OnClickHardDun()
end

function UISpring23Main:OnClickSeason()
  local isUnComplete = WarChessSeasonManager:GetUncompleteWCSData()
  if isUnComplete then
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas)
    ctrl:ContinuehallowmasSeason()
    return
  end
  if not SectorStageDetailHelper.IsWarchessSeasonNoCollide(self._cfg.warchess_season_id, true) then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Christmas22ModeSelect, function(window)
    if window == nil then
      return
    end
    window:InitChristmas22ModeSelect(self._data)
  end)
end

function UISpring23Main:OnClickStrartPlay()
  if self._data == nil then
    error("spring act data not exist")
    return
  end
  local mainCfg = self._data:GetSpringMainCfg()
  local sectorId = mainCfg.main_stage
  if not SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Spring23LevelModSelect, function(window)
    if window == nil then
      return
    end
    window:InitSpring23ModeSelect(self._data)
  end)
end

function UISpring23Main:OnCloseSpring()
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  if sectorCtrl ~= nil then
    sectorCtrl:PlaySectorBgm()
  end
  self:Delete()
  if self._backCallback then
    self._backCallback(false)
  end
end

function UISpring23Main:OnDelete()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  if self._reddot ~= nil then
    RedDotController:RemoveListener(self._reddot.nodePath, self._reddotFunc)
    self._reddot = nil
  end
  base.OnDelete(self)
end

return UISpring23Main
