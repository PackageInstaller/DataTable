local UIActSum22Main = class("UIActSum22Main", UIBaseWindow)
local base = UIBaseWindow
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local cs_MovieManager = CS.MovieManager.Instance
local cs_MessageCommon = CS.MessageCommon
local UINActSum22MainBtn = require("Game.ActivitySummer.Year22.UINActSum22MainBtn")
local UINActSum22MainSelectBtn = require("Game.ActivitySummer.Year22.UINActSum22MainSelectBtn")
local ActivitySectorIIIEnum = require("Game.ActivitySectorIII.ActivitySectorIIIEnum")
local SnakeGameController = require("Game.TinyGames.Snake.SnakeGameController")

function UIActSum22Main:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickSum22Close, nil, BindCallback(self, self.ShowInfoFunc))
  self.__CoinRefreshCallback = BindCallback(self, self.__CoinRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__CoinRefreshCallback)
  self.__ActivityRunEndCallback = BindCallback(self, self.__ActivityRunEnd)
  MsgCenter:AddListener(eMsgEventId.SectorActivityRunEnd, self.__ActivityRunEndCallback)
end

function UIActSum22Main:OnShow()
  base.OnShow(self)
  self:__PlayEnterEffect()
end

function UIActSum22Main:InitSum22Main(sum22Data, callback)
  AudioManager:PlayAudioById(3340)
  self._sum22Data = sum22Data
  self._callback = callback
  self:__InitBtn()
  if self._timerId == nil then
    self._timerId = TimerManager:StartTimer(1, self.__TimeCountdown, self)
  end
  self._sum22Cfg = self._sum22Data:GetSectorIIIMainCfg()
  self.ui.img_Token.sprite = CRH:GetSpriteByItemId(self._sum22Cfg.token_item, true)
  local nextTime = self._sum22Cfg.main2nd_start
  local timeData = TimeUtil:TimestampToDate(nextTime, false, true)
  local timeStr = string.format("%d/%02d/%02d %02d:%02d", timeData.year, timeData.month, timeData.day, timeData.hour, timeData.min)
  self.ui.tex_tip.text = string.format(ConfigData:GetTipContent(7126), timeStr)
  self:__TimeCountdown()
  self:__CoinRefresh()
  self._actReddot = self._sum22Data:GetActivityReddot()
  if self._actReddot ~= nil then
    self:__RefreshActReddot(self._actReddot)
    self.__RefreshActReddotCallback = BindCallback(self, self.__RefreshActReddot)
    RedDotController:AddListener(self._actReddot.nodePath, self.__RefreshActReddotCallback)
  end
  if self._sum22Data:GetSectorIIIActivityIsRemaster() ~= 0 then
    self.ui.obj_remasterTag:SetActive(true)
  else
    self.ui.obj_remasterTag:SetActive(false)
  end
  
  local function loadNoive_func()
    if self.moviePlayer == nil then
      self.moviePlayer = cs_MovieManager:GetMoviePlayer()
    end
    self.moviePlayer:SetVideoRender(self.ui.movie)
    local path = PathConsts:GetAvgVideoPath(self._sum22Cfg.bg_video)
    self.moviePlayer:PlayVideo(path, nil, 1, false)
    self.moviePlayer:SetLoopSeek(30, 179, false)
    self.moviePlayer:StartSeek(0)
  end
  
  local function info_func()
    local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
    GuidePicture.OpenGuidePicture(26, nil, true)
  end
  
  local avgid = self._sum22Cfg.first_avg
  if 0 < avgid then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local played = avgPlayCtrl:IsAvgPlayed(avgid)
    local actId = self._sum22Data:GetActId()
    if not played and self._sum22Data:IsActivityRunning() then
      self:Hide()
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgid, function()
        if IsNull(self.transform) then
          return
        end
        self:Show()
        loadNoive_func()
        if not PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetSum22ActEnter(actId) then
          info_func()
          PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetSum22ActEnter(actId)
        end
      end)
      return
    elseif not PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetSum22ActEnter(actId) then
      info_func()
      PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetSum22ActEnter(actId)
    end
  end
  loadNoive_func()
end

function UIActSum22Main:__InitBtn()
  local btnFuncTable = {
    [1] = self.OnEnterMainSecotrLevel,
    [2] = self.OnClickTask,
    [3] = self.OnEnterDeputySectorLevel,
    [4] = self.OnClickShop,
    [5] = self.OnClickTech,
    [6] = self.OnClickGame,
    [7] = self.OnClickRepeatLevel
  }
  self._btnDic = {}
  local isRuning = self._sum22Data:IsActivityRunning()
  local winCfg = ConfigData.activity_summer_entrance_name
  for i, cfg in ipairs(winCfg) do
    if self.ui.btnNode_array[i] ~= nil then
      local item = i == 1 and UINActSum22MainSelectBtn.New() or UINActSum22MainBtn.New()
      item:Init(self.ui.btnNode_array[i])
      self._btnDic[i] = item
      local isUnlock = PlayerDataCenter.timestamp >= cfg.unlock_time
      local bindCallback = BindCallback(self, btnFuncTable[i])
      local bindLockCallback = BindCallback(self, self.OnClickLocked, cfg.unlock_time)
      if i == 4 then
        item:InitSum22Btn(cfg, isUnlock, bindCallback, bindLockCallback)
      else
        item:InitSum22Btn(cfg, isUnlock and isRuning, bindCallback, bindLockCallback)
      end
      if not isUnlock then
        if self._waitLockBtnDic == nil then
          self._waitLockBtnDic = {}
          self._waitLockTimeCount = 0
        end
        if self._waitLockBtnDic[cfg.unlock_time] == nil then
          self._waitLockBtnDic[cfg.unlock_time] = {}
          self._waitLockTimeCount = self._waitLockTimeCount + 1
        end
        table.insert(self._waitLockBtnDic[cfg.unlock_time], i)
      end
    end
  end
end

function UIActSum22Main:SelectSum22Sector(sectorId)
  if sectorId == self._sum22Cfg.main_sector then
    self:OnEnterMainSecotrLevel()
  elseif sectorId == self._sum22Cfg.story_stage then
    self:OnEnterDeputySectorLevel()
  end
end

function UIActSum22Main:__TimeCountdown()
  if self._waitLockBtnDic ~= nil then
    for time, ids in pairs(self._waitLockBtnDic) do
      if time < PlayerDataCenter.timestamp then
        for _, index in ipairs(ids) do
          local item = self._btnDic[index]
          item:RefreshSum22BtnUnlock()
        end
        self._waitLockBtnDic[time] = nil
        self._waitLockTimeCount = self._waitLockTimeCount - 1
      end
    end
    if self._waitLockTimeCount == 0 then
      self._waitLockBtnDic = nil
      self._waitLockTimeCount = nil
    end
  end
  if (self._nextTime or 0) < PlayerDataCenter.timestamp then
    local title, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(self._sum22Data)
    self.ui.tex_endTime.text = title .. "  " .. timeStr
    self._nextTime = expireTime
  end
  local countdownStr, diff = ActivityFrameUtil.GetCountdownTimeStr(self._nextTime)
  self.ui.tex_countDown.text = countdownStr
  if diff < 0 and self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
end

function UIActSum22Main:__CoinRefresh()
  self.ui.tex_Token.text = tostring(PlayerDataCenter:GetItemCount(self._sum22Cfg.token_item))
end

function UIActSum22Main:__ActivityRunEnd(actId)
  if actId == self._sum22Data:GetActId() then
    for k, v in pairs(self._btnDic) do
      if k ~= 4 then
        v:RefreshSum22Locked()
      end
    end
  end
end

function UIActSum22Main:OnEnterMainSecotrLevel()
  if not self._sum22Data:IsActivityRunning() then
    return
  end
  self:_DelayWindowActive(false)
  UIManager:ShowWindowAsync(UIWindowTypeID.ActSum22Map, function(win)
    if win == nil then
      return
    end
    win:InitSum22Map(self._sum22Data, function()
      if not IsNull(self.transform) then
        self:_DelayWindowActive(true)
      end
    end)
  end)
end

function UIActSum22Main:OnClickTask()
  UIManager:ShowWindowAsync(UIWindowTypeID.ActSum22Task, function(win)
    if win == nil then
      return
    end
    win:InitSum22Task(self._sum22Data, function()
      if not IsNull(self.transform) then
        self:__PlayEnterEffect()
      end
    end)
  end)
end

function UIActSum22Main:OnEnterDeputySectorLevel()
  self:Hide()
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, function(win)
    if win == nil then
      return
    end
    win:InitSectorLevel(self._sum22Cfg.story_stage, function()
      if not IsNull(self.transform) then
        self:Show()
      end
    end, nil, nil, nil)
  end)
end

function UIActSum22Main:OnClickShop()
  UIManager:ShowWindowAsync(UIWindowTypeID.ActSum22Shop, function(win)
    if win == nil then
      return
    end
    win:InitSum22Shop(self._sum22Data, function()
      if not IsNull(self.transform) then
        self:__PlayEnterEffect()
      end
    end)
  end)
end

function UIActSum22Main:_DelayWindowActive(active)
  if active then
    TimerManager:StopTimer(self._activeTimerId)
    self:Show()
  else
    self._activeTimerId = TimerManager:StartTimer(1, self.Hide, self, true)
  end
end

function UIActSum22Main:OnClickTech()
  UIManager:ShowWindowAsync(UIWindowTypeID.ActSum22StrategyMain, function(win)
    if win == nil then
      return
    end
    win:InitActSum22StrategyMain(self._sum22Data)
  end)
end

function UIActSum22Main:OnClickGame()
  local snakeCtrl = SnakeGameController.New(self._sum22Data, false)
  snakeCtrl:EnterSnakeGame()
  local sum22Data = self._sum22Data
  snakeCtrl:BindSnakeExitEvent(function()
    local LastPlayData = require("Game.Sector.Data.LastPlayData")
    local lastPlayData = LastPlayData.New():SetLPDActData(sum22Data):SetLPDActId(sum22Data:GetActId())
    PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
  end)
end

function UIActSum22Main:OnClickRepeatLevel()
  if not self._sum22Data:IsActivityRunning() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ActSum22DunRepeat, function(win)
    if win == nil then
      return
    end
    self:_DelayWindowActive(false)
    win:InitSum22DunRepeat(self._sum22Data, function()
      if not IsNull(self.transform) then
        self:_DelayWindowActive(true)
        self:__PlayEnterEffect()
      end
    end)
  end)
end

function UIActSum22Main:OnClickLocked(time)
  if not self._sum22Data:IsActivityRunning() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(6033))
    return
  end
  local str = os.date(ConfigData:GetTipContent(921), time)
  cs_MessageCommon.ShowMessageTipsWithErrorSound(str)
end

function UIActSum22Main:__PlayEnterEffect()
  for i, v in ipairs(self.ui.tweens_show) do
    v:DORewind()
    v:DOPlayForward()
  end
  for i, v in ipairs(self.ui.anis_enter) do
    v:Play()
  end
end

function UIActSum22Main:OnClickSum22Close(isToHome)
  if not isToHome then
    local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
    if sectorCtrl ~= nil then
      sectorCtrl:PlaySectorBgm()
    end
  end
  self:Delete()
  if self._callback ~= nil then
    self._callback(false)
  end
end

function UIActSum22Main:ShowInfoFunc()
  local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
  GuidePicture.OpenGuidePicture(self._sum22Cfg.guide_id, nil)
end

function UIActSum22Main:__RefreshActReddot(actRedDot)
  local taskNode = actRedDot:GetChild(ActivitySectorIIIEnum.eActRedDotTypeId.task)
  local techNode = actRedDot:GetChild(ActivitySectorIIIEnum.eActRedDotTypeId.tech)
  local mapNode = actRedDot:GetChild(ActivitySectorIIIEnum.eActRedDotTypeId.map)
  local isTaskRed = taskNode ~= nil and taskNode:GetRedDotCount() > 0
  local isTechRed = techNode ~= nil and techNode:GetRedDotCount() > 0
  local isMapRed = mapNode ~= nil and mapNode:GetRedDotCount() > 0
  self.ui.taskRedDot:SetActive(isTaskRed)
  self.ui.techBlueDot:SetActive(isTechRed)
  self.ui.mapBlueDot:SetActive(isMapRed or isTechRed)
end

function UIActSum22Main:OnDelete()
  if self._actReddot ~= nil then
    RedDotController:RemoveListener(self._actReddot.nodePath, self.__RefreshActReddotCallback)
  end
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__CoinRefreshCallback)
  MsgCenter:RemoveListener(eMsgEventId.SectorActivityRunEnd, self.__ActivityRunEndCallback)
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  TimerManager:StopTimer(self._activeTimerId)
  if self.moviePlayer ~= nil then
    self.moviePlayer:ReSet()
    cs_MovieManager:ReturnMoviePlayer(self.moviePlayer)
    self.moviePlayer = nil
  end
  for i, v in ipairs(self.ui.tweens_show) do
    v:DOKill()
  end
  base.OnDelete(self)
end

return UIActSum22Main
