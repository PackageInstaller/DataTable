local UIActivityKeyExertionMain = class("UIActivityKeyExertionMain", UIBaseWindow)
local base = UIBaseWindow
local UINActivityKeyExertionTask = require("Game.ActivityKeyExertion.UI.Task.UINActivityKeyExertionTask")
local UINLogicPreviewNode = require("Game.ActivityKeyExertion.UI.Preview.UINLogicPreviewNode")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local JumpManager = require("Game.Jump.JumpManager")
local UINKeyExertionRewardItem = require("Game.ActivityKeyExertion.UI.UINKeyExertionRewardItem")

function UIActivityKeyExertionMain:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  self.resloader = CS.ResLoader.Create()
  self.__TaskUpdateCallback = BindCallback(self, self.__TaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  self._OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.ActivityKeyExertionTokenNumChange, self._OnItemChangeFunc)
  self.__OnRewardTaskCallback = BindCallback(self, self.__OnRewardTask)
  self.__RefreshCallback = BindCallback(self, self.__Refresh)
  self.__itemPool = UIItemPool.New(UINKeyExertionRewardItem, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self.__ShowLogicPreviewNode)
  UIUtil.AddButtonListener(self.ui.btn_Get, self, self.TryOpenPackage)
  UIUtil.AddButtonListener(self.ui.btn_Tip, self, self.__ShowGuideTip)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  self._lastCouldUseItemJump = JumpManager.couldUseItemJump
  JumpManager.couldUseItemJump = false
end

function UIActivityKeyExertionMain:InitKeyExertionMain(keyExertionData)
  self._data = keyExertionData
  self._actId = keyExertionData:GetActId()
  self._controller = ControllerManager:GetController(ControllerTypeId.ActivityKeyExertion, true)
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self._timerId = TimerManager:StartTimer(5, self.__RefreshTime, self)
  self.ui.tex_Title:SetIndex(0, self._data.actInfo.name)
  self.ui.tex_Des.text = self._data:GetKeyExertionActivityDes()
  self.ui.tex_mainDes.text = self._data:GetKeyExertionMainDes()
  self.ui.tex_ButtonGet.text = LanguageUtil.GetLocaleText(self._data:GetKeyExertionMainCfg().button_des)
  self:InitTexBagName()
  local tokenId = self._data:GetKeyExertionTokenId()
  self.ui.img_tokenImage.sprite = CRH:GetSpriteByItemId(tokenId)
  self.ui.img_Logo.texture = self.resloader:LoadABAsset(PathConsts:GetActivityKeyExertionPath(self._data:GetKeyExertionMainCfg().icon_picture))
  self.ui.img_Bottom.texture = self.resloader:LoadABAsset(PathConsts:GetActivityKeyExertionPath(self._data:GetKeyExertionMainCfg().main_picture))
  local mainColor = self._data:GetKeyExertionMainColor()
  self.ui.img_Line.color = mainColor
  self.ui.img_Day.color = mainColor
  self.ui.img_BtnInfo.color = mainColor
  self.ui.img_BtnGet.color = mainColor
  self:RefreshKeyExertionRewards()
  self:InitKeyExertionTask()
  self:__Refresh()
end

function UIActivityKeyExertionMain:InitTexBagName()
  self.ui.tex_BagName.gameObject:SetActive(true)
  self.ui.tex_BagName.text = LanguageUtil.GetLocaleText(self._data:GetKeyExertionMainCfg().bag_des)
  self.ui.tex_BagName.transform.localPosition = Vector3.Temp(table.unpack(self._data:GetKeyExertionMainCfg().button_pos))
  self.ui.tex_BagName.transform.localEulerAngles = Vector3.Temp(table.unpack(self._data:GetKeyExertionMainCfg().button_rotation))
  self.ui.tex_BagName.fontSize = self._data:GetKeyExertionMainCfg().button_size
end

function UIActivityKeyExertionMain:RefreshKeyExertionRewards()
  self.__itemPool:HideAll()
  local mainRewardIds, mainRewardNums = self._data:GetKeyExertionMainReward()
  for iIndex, vRewardId in ipairs(mainRewardIds) do
    local rewardNum = mainRewardNums[iIndex]
    local rewardItem = self.__itemPool:GetOne()
    local isShowAllPicked = self._data:GetBigRewardId() == vRewardId and self._data:GetIsBigRewardAllPicked()
    rewardItem:InitKeyExertionRewardItem(ConfigData.item[vRewardId], rewardNum, isShowAllPicked)
    rewardItem:Show()
  end
end

function UIActivityKeyExertionMain:__Refresh()
  self.ui.tex_PackageCount:SetIndex(0, LanguageUtil.GetLocaleText(self._data:GetKeyExertionMainCfg().bag_des), tostring(self._data:GetKeyExertionOpenedPackageNum()))
  self.ui.tex_TokenCount:SetIndex(0, tostring(self._data:GetKeyExertionPackageFragmentNum()), tostring(self._data:GetKeyExertionPackageFragmentMaxNum()))
  self:__RefreshOpenPackageButton()
  self:__RefreshTime()
end

function UIActivityKeyExertionMain:__ShowLogicPreviewNode()
  if not self._previewNode then
    self._previewNode = UINLogicPreviewNode.New()
    self._previewNode:Init(self.ui.logicPreviewNode)
  end
  self._previewNode:InitLogicPreviewNode(self._data)
  self._previewNode:Show()
end

function UIActivityKeyExertionMain:UpdateLogicPreviewNode()
  if not self._previewNode then
    return
  end
  self._previewNode:UpdateCurrentNode()
end

function UIActivityKeyExertionMain:__ShowGuideTip()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(self._data:GetKeyExertionMainCfg().task_rule_id), ConfigData:GetTipContent(self._data:GetKeyExertionMainCfg().task_rule_title), nil, true)
  end)
end

function UIActivityKeyExertionMain:InitKeyExertionTask()
  self._currentTaskItem = UINActivityKeyExertionTask.New()
  self._currentTaskItem:Init(self.ui.task)
  self._currentTaskItem:InitActivityKeyExertionTask(self._data, self.__OnRewardTaskCallback)
end

function UIActivityKeyExertionMain:__OnRewardTask(taskData, taskItem)
  self._controller:ReqKeyExertionCommitTask(self._actId, taskData.id, function()
    taskItem:RefreshKeyExertionTaskPicked()
  end)
end

function UIActivityKeyExertionMain:__TaskUpdate(taskData)
  if self._currentTaskItem:GetActivityKeyExertionId() == taskData.id then
    self._currentTaskItem:RefreshKeyExertionTask()
  end
end

function UIActivityKeyExertionMain:__ItemUpdate(tokenId)
  if tokenId == self._data:GetKeyExertionTokenId() then
    self:__Refresh()
  end
end

function UIActivityKeyExertionMain:__RefreshOpenPackageButton()
  local isOpenPackage = self._data:CanKeyExertionOpenPackage()
  self.ui.btn_Get.interactable = isOpenPackage
  local mainColor = self._data:GetKeyExertionMainColor()
  self.ui.img_BtnGet.color = isOpenPackage and mainColor or self.ui.colseGetBtnColor
  self.ui.tex_Get.color = isOpenPackage and self.ui.openGetTextColor or self.ui.colseGetTextColor
end

function UIActivityKeyExertionMain:TryOpenPackage()
  if self._data:CanKeyExertionOpenPackage() then
    self._controller:ReqKeyExertionOpenPackage(self._actId, self.__RefreshCallback)
  end
end

function UIActivityKeyExertionMain:__RefreshTime()
  if (self._endTime or 0) < PlayerDataCenter.timestamp then
    local startTimeTable = TimeUtil:TimestampToDate(self._data:GetActivityBornTime(), false, true)
    self.ui.tex_Time0:SetIndex(0, string.format("%02d/%02d", startTimeTable.month, startTimeTable.day), string.format("%02d:%02d", startTimeTable.hour, startTimeTable.sec))
    local endTimeTable = TimeUtil:TimestampToDate(self._data:GetActivityEndTime(), false, true)
    self.ui.tex_Time1:SetIndex(0, string.format("%02d/%02d", endTimeTable.month, endTimeTable.day), string.format("%02d:%02d", endTimeTable.hour, endTimeTable.sec))
    self._endTime = self._data:GetActivityEndTime()
  end
  local countdownStr, diff = ActivityFrameUtil.GetCountdownTimeStr(self._endTime)
  self.ui.tex_Day.text = countdownStr
  if diff < 0 and self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
end

function UIActivityKeyExertionMain:BackAction()
  self:Delete()
end

function UIActivityKeyExertionMain:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIActivityKeyExertionMain:OnDelete()
  self:OnCloseWin()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.ActivityKeyExertionTokenNumChange, self._OnItemChangeFunc)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.__itemPool:DeleteAll()
  if self._previewNode ~= nil then
    self._previewNode:Delete()
  end
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  JumpManager.couldUseItemJump = self._lastCouldUseItemJump
  base.OnDelete(self)
end

return UIActivityKeyExertionMain
