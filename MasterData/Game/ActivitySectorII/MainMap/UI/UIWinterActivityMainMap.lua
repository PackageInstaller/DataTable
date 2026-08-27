local UIWinterActivityMainMap = class("UIWinterActivityMainMap", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local UINWAMMMapNode = require("Game.ActivitySectorII.MainMap.UI.UINWAMMMapNode")
local JumpManager = require("Game.Jump.JumpManager")
local TaskEnum = require("Game.Task.TaskEnum")
local ActivitySectorIIEnum = require("Game.ActivitySectorII.ActivitySectorIIEnum")

function UIWinterActivityMainMap:OnInit()
  self.actId = nil
  self.actFrameId = nil
  self.resloader = cs_ResLoader.Create()
  self.mapNode = nil
  self.__barWin = nil
  self.__SetWAMapInfoNodeActive = BindCallback(self, self.SetWAMapInfoNodeActive)
  self.__showIntroduce = BindCallback(self, self.__ShowIntroduce)
  UIUtil.SetTopStatus(self, self.OnClickClose, nil, self.__showIntroduce)
  UIUtil.AddButtonListener(self.ui.btn_Challenge, self, self.OnClickWADungeon)
  UIUtil.AddButtonListener(self.ui.btn_FlappyBird, self, self.OnClickFlappyBird)
end

function UIWinterActivityMainMap:PlayWinterActivityMainMapBgm()
  AudioManager:PlayAudioById(3110)
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Sector.name, eAuSelct.Sector.levelSelect)
end

function UIWinterActivityMainMap:InitWinActMainMapResident(sectorIIData, cantShowDetail)
  self._isResident = true
  self.SectorIIData = sectorIIData
  self:PlayWinterActivityMainMapBgm()
  if self.mapNode == nil then
    self.mapNode = UINWAMMMapNode.New()
    self.mapNode:Init(self.ui.obj_map)
  end
  self.mapNode:InitWAMMMap(self.transform, sectorIIData, self.__SetWAMapInfoNodeActive, self.resloader, cantShowDetail)
  PlayerDataCenter.sectorStage:SetSelectSectorId(sectorIIData:GetSectorIISectorId())
  self.ui.timer:SetActive(false)
  self.ui.obj_remasterTag:SetActive(false)
  self.ui.bottomRight.gameObject:SetActive(false)
  local pos = Vector2.Temp(0, -161)
  self.ui.obj_infoNode.transform.anchoredPosition = pos
  self.ui.obj_map.transform.anchoredPosition = pos
end

function UIWinterActivityMainMap:InitWAMainMap(actId, cantShowDetail)
  self:PlayWinterActivityMainMapBgm()
  self.actId = actId
  self.__barWin = UIManager:ShowWindow(UIWindowTypeID.Win21SectorBar)
  self.__barWin:InitSectorBar(actId)
  local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
  local SectorIIData = sectorIICtrl:GetSectorIIDataByActId(self.actId)
  if self.mapNode == nil then
    self.mapNode = UINWAMMMapNode.New()
    self.mapNode:Init(self.ui.obj_map)
  end
  self.mapNode:InitWAMMMap(self.transform, SectorIIData, self.__SetWAMapInfoNodeActive, self.resloader, cantShowDetail)
  self.SectorIIData = SectorIIData
  self.actFrameId = SectorIIData:GetSectorIIActFrameId()
  PlayerDataCenter.sectorStage:SetSelectSectorId(SectorIIData:GetSectorIISectorId())
  local activityFrameData = SectorIIData:GetActivityFrameData()
  local endTime = activityFrameData:GetActivityEndTime()
  self:RefreshActTime(endTime)
  local isFinished = not SectorIIData:IsActivityRunning()
  if isFinished then
    self:ShowActivtyFinishedUI()
  else
    self:RefreshActivityEndTime(endTime)
    self:SetIsFinishedUI(false)
    self.__timerId = TimerManager:StartTimer(1, function()
      self:RefreshActivityEndTime(endTime)
    end, self, false, false, false)
  end
  self:__InitSectorIIDungeonReddot()
  if self.SectorIIData:GetSectorIIActivityIsRemaster() then
    self.ui.obj_remasterTag:SetActive(true)
  else
    self.ui.obj_remasterTag:SetActive(false)
  end
  GuideManager:TryTriggerGuide(eGuideCondition.ActSectorIIMain)
end

function UIWinterActivityMainMap:OnClickFlappyBird()
  if not self.SectorIIData:IsActivityRunning() then
    return
  end
  local activityFwId = self.SectorIIData:GetSectorIIActFrameId()
  local birdConfigId = self.SectorIIData:GetSectorIIFlappyBirdId()
  local joinRewards = self.SectorIIData:GetSectorIIFlappyBirdIsJoinRewards()
  local maxScore = self.SectorIIData:GetSectorIIFlappyBirdMineMaxScore()
  local setMaxScore = BindCallback(self.SectorIIData, self.SectorIIData.SetSectorIIFlappyBirdMineMaxScore)
  local setJoinRewards = BindCallback(self.SectorIIData, self.SectorIIData.SetSectorIIFlappyBirdIsJoinRewards)
  UIUtil.HideTopStatus()
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local playEndTime = self.SectorIIData:GetActivityEndTime()
  local ctrl
  if self.SectorIIData:GetSectorIIActivityIsRemaster() then
    ctrl = require("Game.TinyGames.FlappyBird.Ctrl.FlappyBirdController").New(activityFwId, birdConfigId, joinRewards, maxScore, nil, nil, true)
  else
    ctrl = require("Game.TinyGames.FlappyBird.Ctrl.FlappyBirdController").New(activityFwId, birdConfigId, joinRewards, maxScore)
  end
  ctrl:SetFlappyBirdActEndTime(playEndTime)
  ctrl:InjectExitAction(function()
    UIUtil.ReShowTopStatus()
    self:PlayWinterActivityMainMapBgm()
  end)
  ctrl:InjectModifyBirdMsgAction(setMaxScore, setJoinRewards)
  ctrl:ShowFlappyBirdUI()
  AudioManager:PlayAudioById(1139)
end

function UIWinterActivityMainMap:OnClickWADungeon()
  if not self.SectorIIData:IsActivityRunning() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivityWinterDungeon, function(win)
    if win ~= nil then
      if self.waDungeonCallBack then
        self.waDungeonCallBack()
        self.waDungeonCallBack = nil
      end
      self:Hide()
      self.__barWin.transform:SetAsLastSibling()
      win:InitWADungeon(self.actId, self.__barWin, function()
        self:Show()
        self.mapNode:SetDetailCantShow(false)
      end)
    end
  end)
end

function UIWinterActivityMainMap:SetWADungeonCallBack(callBack)
  self.waDungeonCallBack = callBack
end

function UIWinterActivityMainMap:RefreshActivityEndTime(timestamp)
  if timestamp == -1 then
    self.ui.tex_ActLeftDay:SetIndex(3)
    self.ui.tex_ActEndTime.text = "N/A"
    return
  end
  if timestamp < PlayerDataCenter.timestamp then
    TimerManager:StopTimer(self.__timerId)
    return
  end
  local remainTime = timestamp - PlayerDataCenter.timestamp
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remainTime, false, true)
  if 0 < d then
    self.ui.tex_ActLeftDay:SetIndex(0, tostring(d))
  elseif 0 < h then
    self.ui.tex_ActLeftDay:SetIndex(1, string.format("%02d", h))
  else
    m = 0 < m and m or 1
    self.ui.tex_ActLeftDay:SetIndex(2, string.format("%02d", m))
  end
end

function UIWinterActivityMainMap:RefreshActTime(timestamp)
  local date = TimeUtil:TimestampToDate(timestamp)
  self.ui.tex_ActEndTime.text = string.format("%02d/%02d/%02d %02d:%02d", date.year, date.month, date.day, date.hour, date.min)
end

function UIWinterActivityMainMap:SetWAMapInfoNodeActive(bool)
  self.ui.obj_infoNode:SetActive(bool)
  if self._isResident then
    return
  end
  if bool then
    self.__barWin:Show()
  else
    self.__barWin:Hide()
  end
end

function UIWinterActivityMainMap:ShowActivtyFinishedUI()
  self.ui.tex_ActLeftDay:SetIndex(4)
  self:SetIsFinishedUI(true)
  self.mapNode:RefreshSectroIIMapRedddot()
end

function UIWinterActivityMainMap:SetIsFinishedUI(active)
  for _, obj in ipairs(self.ui.isFinished) do
    obj:SetActive(active)
  end
end

function UIWinterActivityMainMap:OnClickClose(toHome)
  self:Delete()
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  if sectorCtrl ~= nil then
    sectorCtrl:ResetToNormalState(toHome, self._isResident)
    sectorCtrl:PlaySectorBgm()
  end
end

function UIWinterActivityMainMap:__InitSectorIIDungeonReddot()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, self.actFrameId, ActivitySectorIIEnum.eActSectorIIRedDotTypeId.dungeon)
  if isOk then
    if self.__refresnDungeonReddot == nil then
      function self.__refresnDungeonReddot(node)
        self.ui.obj_blueDot_dungeon:SetActive(node:GetRedDotCount() > 0)
      end
    end
    RedDotController:AddListener(node.nodePath, self.__refresnDungeonReddot)
    self.__refresnDungeonReddot(node)
  end
end

function UIWinterActivityMainMap:__RemoveSectorIIDungeonReddot()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, self.actFrameId, ActivitySectorIIEnum.eActSectorIIRedDotTypeId.dungeon)
  if isOk then
    RedDotController:RemoveListener(node.nodePath, self.__refresnDungeonReddot)
  end
  self.__refresnDungeonReddot = nil
end

function UIWinterActivityMainMap:__ShowIntroduce()
  local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
  GuidePicture.OpenGuidePicture(ConfigData.game_config.win21GuideNum, nil)
end

function UIWinterActivityMainMap:OnDelete()
  UIManager:DeleteWindow(UIWindowTypeID.Win21SectorBar)
  self:__RemoveSectorIIDungeonReddot()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.mapNode ~= nil then
    self.mapNode:Delete()
  end
  if self.__timerId ~= nil then
    TimerManager:StopTimer(self.__timerId)
    self.__timerId = nil
  end
  base.OnDelete(self)
end

return UIWinterActivityMainMap
