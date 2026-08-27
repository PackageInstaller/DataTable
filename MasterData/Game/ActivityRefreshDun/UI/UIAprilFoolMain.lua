local UIAprilFoolMain = class("UIAprilFoolMain", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local JumpManager = require("Game.Jump.JumpManager")
local TaskEnum = require("Game.Task.TaskEnum")
local ActRefreshDunEnum = require("Game.ActivityRefreshDun.ActRefreshDunEnum")
local UINAprilFoolDunItem = require("Game.ActivityRefreshDun.UI.UINAprilFoolDunItem")
local cs_MessageCommon = CS.MessageCommon

function UIAprilFoolMain:OnInit()
  self.resloader = cs_ResLoader.Create()
  UIUtil.SetTopStatus(self, self.__OnClickClose, nil, BindCallback(self, self.__OnClickInfo))
  UIUtil.AddButtonListener(self.ui.btn_Shop, self, self.__OnClickShop)
  UIUtil.AddButtonListener(self.ui.btn_Task, self, self.__OnClickTask)
  UIUtil.AddButtonListener(self.ui.btn_MiniGame, self, self.__OnClickMiniGame)
  UIUtil.AddButtonListener(self.ui.btn_PlotReview, self, self.__OnClickPhotoReview)
  UIUtil.AddButtonListener(self.ui.btn_Reset, self, self.__OnClickReset)
  self.dunItemPool = UIItemPool.New(UINAprilFoolDunItem, self.ui.obj_dungeonItem)
  self.ui.obj_dungeonItem:SetActive(false)
end

function UIAprilFoolMain:InitAprilFoolMain(ARDctrl, ARDData)
  AudioManager:PlayAudioById(3321)
  self.ARDctrl = ARDctrl
  self.ARDData = ARDData
  self:RefreshAprilFoolMain()
  self:__InitARDTaskReddot()
  self:__InitARDAvgReddot()
end

function UIAprilFoolMain:RefreshAprilFoolMain()
  self:__RefreshAllDunUI()
  self:__RefreshResetUI()
  self:__RefreshActCloseTime()
end

function UIAprilFoolMain:__RefreshAllDunUI()
  self.dunItemPool:HideAll()
  if not self.ARDData:IsActivityRunning() then
    self.ui.obj_times:SetActive(false)
    self.ui.btn_MiniGame.gameObject:SetActive(false)
    return
  end
  local dunList = self.ARDData:GetARDDataList()
  for index, dunId in ipairs(dunList) do
    local ARDDunData = self.ARDData:GetARDDataByDunId(dunId)
    local dunItem = self.dunItemPool:GetOne()
    local parent = self.ui.pos_array[index]
    dunItem:InitAprilFoolDunItem(index, self.ARDctrl, ARDDunData, self.resloader)
    dunItem.transform:SetParent(parent, false)
  end
end

function UIAprilFoolMain:__RefreshResetUI(isTimeUpdate)
  local expireTime = self.ARDData:GetARDExpiredTm()
  local timeData = TimeUtil:TimestampToDate(expireTime, false, true)
  self.ui.tex_TimeBeforeReset:SetIndex(0, tostring(timeData.hour))
  if self.ARDData:IsARDResetRunOut() then
    self.ui.img_btn_Reset:SetIndex(1)
    self.ui.couldReset:SetActive(false)
    self.ui.couldNotReset:SetActive(true)
  else
    self.ui.img_btn_Reset:SetIndex(0)
    self.ui.couldReset:SetActive(true)
    self.ui.couldNotReset:SetActive(false)
    local reSetCostNum = self.ARDData:GetARDResetCost()
    self.ui.tex_ResetItemCount.text = tostring(reSetCostNum)
  end
end

function UIAprilFoolMain:__RefreshActCloseTime()
  local actEndTime = self.ARDData:GetActivityEndTime()
  local date = TimeUtil:TimestampToDate(actEndTime)
  self.ui.tex_ActLeftTime.text = string.format("%02d/%02d/%02d %02d:%02d", date.year, date.month, date.day, date.hour, date.min)
end

function UIAprilFoolMain:__OnClickReset()
  if self.ARDData:IsARDResetRunOut() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7307))
    return
  end
  local resetCostNum = self.ARDData:GetARDResetCost()
  
  local function RealReset()
    local actId = self.ARDData:GetActId()
    self.ARDctrl:ARDBuyReset(actId, function()
      AudioManager:PlayAudioById(1212)
      self:__RefreshAllDunUI()
      self:__RefreshResetUI()
    end)
  end
  
  local function TryBySand()
    local resetCostItem = self.ARDData:GetARDResetCostItemId()
    local backpackNum = PlayerDataCenter:GetItemCount(resetCostItem)
    if backpackNum < resetCostNum then
      local needItemNum = resetCostNum - backpackNum
      local assignMsg = string.format(ConfigData:GetTipContent(10008), needItemNum, needItemNum)
      if Consts.GameChannelType.IsJp() then
        assignMsg = assignMsg .. ConfigData:GetTipContent(334)
      end
      if resetCostItem == ConstGlobalItem.PaidSubItem then
        local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
        return payCtrl:PaidCurrencyExecute(ConstGlobalItem.PaidSubItem, needItemNum, resetCostItem, needItemNum, RealReset, assignMsg)
      else
        return
      end
    else
      RealReset()
    end
  end
  
  local totalNum, unplayedNum = self.ARDData:GetARDLevelNum()
  if 0 < unplayedNum then
    local message = string.format(ConfigData:GetTipContent(7301), tostring(resetCostNum), tostring(unplayedNum))
    cs_MessageCommon.ShowMessageBox(message, TryBySand, nil)
  else
    local message = string.format(ConfigData:GetTipContent(7306), tostring(resetCostNum))
    cs_MessageCommon.ShowMessageBox(message, TryBySand, nil)
  end
end

function UIAprilFoolMain:__OnClickShop()
  local ARDDCfg = self.ARDData:GetARDDCfg()
  UIManager:ShowWindowAsync(UIWindowTypeID.CharacterDungeonShop, function(window)
    window:ExtraInitCharacterDungeonShop({
      currencyId = ARDDCfg.token,
      shop_list = ARDDCfg.shop_list,
      destoryTime = self.ARDData:GetActivityDestroyTime(),
      bornTime = self.ARDData:GetActivityBornTime(),
      color_shop = ARDDCfg.color_shop,
      color_shoplist = ARDDCfg.color_shoplist,
      shop_name = ARDDCfg.shop_name,
      shop_bgfullPath = PathConsts:GetImagePath(ARDDCfg.shop_bg),
      actFrameId = self.ARDData:GetActFrameId()
    })
  end)
end

function UIAprilFoolMain:__OnClickTask()
  JumpManager:Jump(JumpManager.eJumpTarget.DynTask, nil, nil, {
    TaskEnum.eTaskType.LargeActivityTask
  }, true)
end

function UIAprilFoolMain:__OnClickMiniGame()
  local actId = self.ARDData:GetActFrameId()
  local miniGameId = self.ARDData:GetARDMiniGameId()
  local maxScore = self.ARDData:GetARDMiniGameMaxScore()
  UIUtil.HideTopStatus()
  UIManager:ShowWindowAsync(UIWindowTypeID.AprilGameDamie, function(window)
    window:InitDamieWithData(actId, miniGameId, maxScore)
    window:InjectExitAction(function()
      UIUtil.ReShowTopStatus()
    end)
  end)
end

function UIAprilFoolMain:__OnClickPhotoReview()
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroPlotReview, function(window)
    if window == nil then
      return
    end
    local CPRData = self.ARDData:GetARDPlotReviewData()
    window:InitCommonPlotReview(CPRData)
  end)
end

function UIAprilFoolMain:__OnClickInfo()
  local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
  GuidePicture.OpenGuidePicture(ConfigData.game_config.aprilFoolGameGuideID, nil)
end

function UIAprilFoolMain:__InitARDTaskReddot()
  local actFrameId = self.ARDData:GetActFrameId()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, actFrameId, ActRefreshDunEnum.redDotType.task)
  if isOk then
    if self.__refresnTaskReddot == nil then
      function self.__refresnTaskReddot(node)
        self.ui.obj_taks_RedDot:SetActive(node:GetRedDotCount() > 0)
      end
    end
    RedDotController:AddListener(node.nodePath, self.__refresnTaskReddot)
    self.__refresnTaskReddot(node)
  end
end

function UIAprilFoolMain:__RemoveARDTaskReddot()
  local actFrameId = self.ARDData:GetActFrameId()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, actFrameId, ActRefreshDunEnum.redDotType.task)
  if isOk then
    RedDotController:RemoveListener(node.nodePath, self.__refresnTaskReddot)
  end
  self.__refresnTaskReddot = nil
end

function UIAprilFoolMain:__InitARDAvgReddot()
  local actFrameId = self.ARDData:GetActFrameId()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, actFrameId, ActRefreshDunEnum.redDotType.avg)
  if isOk then
    if self.__refresnAvgReddot == nil then
      function self.__refresnAvgReddot(node)
        self.ui.obj_plotReview_RedDot:SetActive(node:GetRedDotCount() > 0)
      end
    end
    RedDotController:AddListener(node.nodePath, self.__refresnAvgReddot)
    self.__refresnAvgReddot(node)
  end
end

function UIAprilFoolMain:__RemoveARDAvgReddot()
  local actFrameId = self.ARDData:GetActFrameId()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, actFrameId, ActRefreshDunEnum.redDotType.avg)
  if isOk then
    RedDotController:RemoveListener(node.nodePath, self.__refresnAvgReddot)
  end
  self.__refresnAvgReddot = nil
end

function UIAprilFoolMain:__OnClickClose(toHome)
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  if sectorCtrl ~= nil then
    sectorCtrl:ResetToNormalState(toHome)
    sectorCtrl:PlaySectorBgm()
  end
  self:Delete()
end

function UIAprilFoolMain:OnDelete()
  self:__RemoveARDTaskReddot()
  self:__RemoveARDAvgReddot()
  self.dunItemPool:DeleteAll()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UIAprilFoolMain
