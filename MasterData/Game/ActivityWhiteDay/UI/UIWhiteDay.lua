local UIWhiteDay = class("UIWhiteDay", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local ActivityWhiteDayEnum = require("Game.ActivityWhiteDay.ActivityWhiteDayEnum")
local JumpManager = require("Game.Jump.JumpManager")
local UINWhiteDayLineSlotNode = require("Game.ActivityWhiteDay.UI.UINWhiteDayLineSlotNode")
local UINWhiteDayInfoBtnNode = require("Game.ActivityWhiteDay.UI.UINWhiteDayInfoBtnNode")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")

function UIWhiteDay:OnInit()
  self.resloader = cs_ResLoader.Create()
  self.lineId2ItemDic = {}
  self.lineTimerId = nil
  self.infoBtnNode = UINWhiteDayInfoBtnNode.New()
  self.infoBtnNode:Init(self.ui.obj_btn_Info)
  self.slotItemPool = UIItemPool.New(UINWhiteDayLineSlotNode, self.ui.obj_OrderSlot)
  self.ui.obj_OrderSlot:SetActive(false)
  self.__showIntroduce = BindCallback(self, self.__ShowIntroduce)
  UIUtil.SetTopStatus(self, self.__OnClickClose, nil, self.__showIntroduce)
  self.__onPop2Front = BindCallback(self, self.__TryPhotoGuide)
  UIUtil.SetBack2FrontCallback(self.__onPop2Front)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self.OnClickWDFactoryInfo)
  UIUtil.AddButtonListener(self.ui.btn_Photo, self, self.OnClickWDPhotoAlbum)
  UIUtil.AddButtonListener(self.ui.btn_Task, self, self.OnClickWDTask)
  UIUtil.AddButtonListener(self.ui.btn_SectorLv, self, self.OnClickWDSectorLevel)
  UIUtil.AddButtonListener(self.ui.btn_miniGame, self, self.OnClickWDMiniGame)
  UIUtil.AddButtonListener(self.ui.btn_HideUI, self, self.OnBtnHideUI)
  self.__onWDOrderChanged = BindCallback(self, self.__OnWDOrderChanged)
  MsgCenter:AddListener(eMsgEventId.WhiteDayOrderChange, self.__onWDOrderChanged)
  self.__TaskUpdateCallback = BindCallback(self, self.__TaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  self.__photoUpdate = BindCallback(self, self.__PhotoUpdate)
  MsgCenter:AddListener(eMsgEventId.WhiteDayPhotoChange, self.__photoUpdate)
end

function UIWhiteDay:InitWhiteDayUI(AWDCtrl, AWDData)
  self.AWDCtrl = AWDCtrl
  self.AWDData = AWDData
  self._endtime = AWDData:GetActivityEndTime()
  local title, timeStr = ActivityFrameUtil.GetShowEndTimeStr(AWDData)
  self.ui.tex_Time.text = timeStr
  self.infoBtnNode:InitWhiteDayInfoNode(AWDCtrl, AWDData)
  if self.lineTimerId ~= nil then
    TimerManager:StopTimer(self.lineTimerId)
    self.lineTimerId = nil
  end
  self.lineTimerId = TimerManager:StartTimer(1, self.__OnWDTimeUpdate, self, false, nil, true)
  self:__OnWDTimeUpdate()
  self:RefreshOrderSlotNodes()
  self:__InitWDTaskReddot()
  self:__InitWDPhotoReddot()
  self:__PhotoUpdate()
end

function UIWhiteDay:RefreshOrderSlotNodes()
  local lineList = self.AWDData:GetWDFactoryAllLineList()
  self.slotItemPool:HideAll()
  for _, lineId in pairs(lineList) do
    local item = self.slotItemPool:GetOne()
    self.lineId2ItemDic[lineId] = item
    local AWDLineData = self.AWDData:GetWDFactoryLineData(lineId)
    item:InitWhiteDayLineSlot(self.AWDCtrl, AWDLineData, self.resloader)
    item.transform.anchoredPosition = self.AWDCtrl:GetWDFactoryLineUIPos(lineId)
  end
end

function UIWhiteDay:__OnWDTimeUpdate()
  for lineId, slotItem in pairs(self.lineId2ItemDic) do
    slotItem:RefreshAWDOrderProcess()
  end
  local countdownStr, diff = ActivityFrameUtil.GetCountdownTimeStr(self._endtime)
  self.ui.tex_Days.text = countdownStr
end

function UIWhiteDay:__OnWDOrderChanged(changedLineId, isAcc)
  self.infoBtnNode:RefreshWDInfoNode()
  for lineId, slotItem in pairs(self.lineId2ItemDic) do
    slotItem:RefreshAWDLineSlot()
    if lineId == changedLineId and isAcc then
      slotItem:WDSlotPlayAccEffect()
    end
  end
  self:__TryPhotoGuide()
end

function UIWhiteDay:OnClickWDFactoryInfo()
  UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDayFactoryLevel, function(window)
    if window == nil then
      return
    end
    window:InitWDFactoryLevel(self.AWDData)
  end)
end

function UIWhiteDay:OnClickWDPhotoAlbum()
  UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDayAlbum, function(window)
    if window == nil then
      return
    end
    window:InitWDAlbun(self.AWDCtrl, self.AWDData)
  end)
end

function UIWhiteDay:OnClickWDTask()
  UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDayTask, function(window)
    if window == nil then
      return
    end
    window:InitWDTask(self.AWDCtrl, self.AWDData)
  end)
end

function UIWhiteDay:SpecialJump2WD(actSpecialJumpId)
  if actSpecialJumpId == 1 then
    self:OnClickWDMiniGame()
  elseif actSpecialJumpId == 2 then
    self:OnClickWDSectorLevel()
  end
end

function UIWhiteDay:OnClickWDSectorLevel()
  self.AWDCtrl:OpenWhitrDaySector(self.AWDData)
end

function UIWhiteDay:OnBtnHideUI()
  self.AWDCtrl:GetWhiteDaySceneCtrl():EnterWDCameraControlMode()
end

function UIWhiteDay:OnClickWDMiniGame()
  local Game2048Controller = require("Game.TinyGames.2048.Game2048Controller")
  local gameCtrl = Game2048Controller.New()
  local actFrameId = self.AWDData:GetActFrameId()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, actFrameId, ActivityWhiteDayEnum.redDotType.task)
  gameCtrl:InitGame2048(self.AWDData.actInfo.id, self.AWDData:GetAWDGame2048Id(), node, nil, nil, true)
  gameCtrl:Set2048CtrlDeleteCallback(function()
    self.AWDCtrl:SetWD2048GameCtrl(nil)
  end)
  self.AWDCtrl:SetWD2048GameCtrl(gameCtrl)
end

function UIWhiteDay:__ShowIntroduce()
  local tips = self.AWDData:GetWDCfg().tips
  local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
  GuidePicture.OpenGuidePicture(tips)
end

function UIWhiteDay:__InitWDTaskReddot()
  local actFrameId = self.AWDData:GetActFrameId()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, actFrameId, ActivityWhiteDayEnum.redDotType.task)
  if isOk then
    if self.__refresnTaskReddot == nil then
      function self.__refresnTaskReddot(node)
        self.ui.obj_TaskRedDot:SetActive(node:GetRedDotCount() > 0)
      end
    end
    RedDotController:AddListener(node.nodePath, self.__refresnTaskReddot)
    self.__refresnTaskReddot(node)
  end
end

function UIWhiteDay:__RemoveWDTaskReddot()
  local actFrameId = self.AWDData:GetActFrameId()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, actFrameId, ActivityWhiteDayEnum.redDotType.task)
  if isOk then
    RedDotController:RemoveListener(node.nodePath, self.__refresnTaskReddot)
  end
  self.__refresnTaskReddot = nil
end

function UIWhiteDay:__InitWDPhotoReddot()
  local actFrameId = self.AWDData:GetActFrameId()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, actFrameId, ActivityWhiteDayEnum.redDotType.photoNode)
  if isOk then
    if self.__refresnPhotoReddot == nil then
      function self.__refresnPhotoReddot(node)
        self.ui.obj_PhotoBlueDot:SetActive(node:GetRedDotCount() > 0)
      end
    end
    RedDotController:AddListener(node.nodePath, self.__refresnPhotoReddot)
    self.__refresnPhotoReddot(node)
  end
end

function UIWhiteDay:__RemoveWDPhotoReddot()
  local actFrameId = self.AWDData:GetActFrameId()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, actFrameId, ActivityWhiteDayEnum.redDotType.photoNode)
  if isOk then
    RedDotController:RemoveListener(node.nodePath, self.__refresnPhotoReddot)
  end
  self.__refresnPhotoReddot = nil
end

function UIWhiteDay:SetWDCanvasGroupState(active)
  self.ui.canvasGroup.blocksRaycasts = active
  if active then
    self.ui.canvasGroup.alpha = 1
  else
    self.ui.canvasGroup.alpha = 0
  end
end

function UIWhiteDay:__TaskUpdate(taskData)
  for k, v in pairs(self.slotItemPool.listItem) do
    v:TryRefreshWDEventTween(taskData)
  end
end

function UIWhiteDay:__PhotoUpdate()
  local unlockedNum = self.AWDData:GetWDUnlockedPhotoNum()
  local allNum = self.AWDData:GetWDAllPhotoNum()
  self.ui.tex_PhotoNum:SetIndex(0, tostring(unlockedNum), tostring(allNum))
end

function UIWhiteDay:__TryPhotoGuide()
  if self.AWDData:GetWDUnlockedPhotoNum() == 0 then
    local randomId, randomNum = self.AWDData:GetWDRandomPhotoItemIdAndNum()
    local exchangeId, exchangeNum = self.AWDData:GetWDExchangePhotoItemIdAndNum()
    local randomNum = PlayerDataCenter:GetItemCount(randomId) // randomNum
    local exchangeNum = PlayerDataCenter:GetItemCount(exchangeId) // exchangeNum
    if 0 < randomNum + exchangeNum then
      GuideManager:StartNewTriggerGuide(6030002)
    end
  end
end

function UIWhiteDay:__OnClickClose(toHome)
  self:Delete()
  self.AWDCtrl:CloseWhiteDay()
end

function UIWhiteDay:OnDelete()
  if self.lineTimerId ~= nil then
    TimerManager:StopTimer(self.lineTimerId)
    self.lineTimerId = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self:__RemoveWDTaskReddot()
  self:__RemoveWDPhotoReddot()
  self.slotItemPool:DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.WhiteDayOrderChange, self.__onWDOrderChanged)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.WhiteDayPhotoChange, self.__photoUpdate)
  base.OnDelete(self)
end

return UIWhiteDay
