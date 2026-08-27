local UIPeriodicChallenge = class("UIPeriodicChallenge", UIBaseWindow)
local base = UIBaseWindow
local PeridicChallengeEnum = require("Game.PeriodicChallenge.PeridicChallengeEnum")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local UINPeriodicChallenge = require("Game.PeriodicChallenge.UI.UINPeriodicChallenge")
local UINPeriodicInfoItem = require("Game.PeriodicChallenge.UI.UINPeriodicInfoItem")
local UINRealDailyInfoNode = require("Game.PeriodicChallenge.UI.UINRealDailyInfoNode")
local UINRealDailyEntry = require("Game.PeriodicChallenge.UI.UINRealDailyEntry")
local UINChallengeTaskInfoItem = require("Game.PeriodicChallenge.UI.UINChallengeTaskInfoItem")
local cs_MessageCommon = CS.MessageCommon
local JumpManager = require("Game.Jump.JumpManager")
local ShopEnum = require("Game.Shop.ShopEnum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function UIPeriodicChallenge:OnInit()
  UIUtil.SetTopStatus(self, self.__OnClickBack, {
    ConstGlobalItem.SKey
  })
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.__CloseLevelDetailWindow)
  UIUtil.AddButtonListener(self.ui.btn_WeeklyShop, self, self.__OnClickWeeklyShop)
  self.infoItemPool = UIItemPool.New(UINPeriodicInfoItem, self.ui.obj_infoItem)
  self.ui.obj_infoItem:SetActive(false)
  self.nodeList = {}
  for i, v in ipairs(self.ui.nodeObjList) do
    local item = UINPeriodicChallenge.New()
    item:Init(v)
    item:Hide()
    table.insert(self.nodeList, item)
  end
  self.challengeTaskInfoItem = UINChallengeTaskInfoItem.New()
  self.challengeTaskInfoItem:Init(self.ui.uI_ChallengeTaskInfoItem)
  self.realDailyEntry = UINRealDailyEntry.New()
  self.realDailyEntry:Init(self.ui.obj_realDailyNode)
  self.realDailyEntry:InitRealDailyEntry(ConfigData.buildinConfig.WeeklyChallengeSectorId, self)
  self.realDailyInfoNode = UINRealDailyInfoNode.New()
  self.realDailyInfoNode:Init(self.ui.obj_realDailyInfoNode)
  self:RefreshRealDailyNode()
  self.__onHasUncompletedEp = BindCallback(self, self.RefreshUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.ChallengeOutOfData, self.__onHasUncompletedEp)
  AudioManager:PlayAudioById(1073)
  self._firstEnter = true
end

function UIPeriodicChallenge:InitPeriodicChallenge(closeCallback)
  self.detailType = SectorLevelDetailEnum.eDetailType.PeriodicChallenge
  self.echallengeType = PeridicChallengeEnum.eChallengeType.daliy
  local lastSelectSector = PlayerDataCenter.sectorStage:GetSelectSectorId()
  local isWeeklyChallengeSector = table.contain(ConfigData.game_config.weeklyChallengeSectorIds, lastSelectSector)
  if not isWeeklyChallengeSector then
    PlayerDataCenter.sectorStage:SetSelectSectorId(nil)
  end
  PlayerDataCenter.sectorStage.lastChallengeType = proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge
  self.closeCallback = closeCallback
  self.infoItemPool:HideAll()
  self.nodeList[1].gameObject:SetActive(true)
  local dungeonId = PlayerDataCenter.periodicChallengeData:GetChallengeId(self.echallengeType)
  self.nodeList[1]:InitPeriodicItem(dungeonId, self.echallengeType, self)
  local infoItem = self.infoItemPool:GetOne(true)
  infoItem:InitPeriodicInfoItem(dungeonId, self.echallengeType, 0)
  infoItem.transform:SetParent(self.nodeList[1].ui.infoHolder.transform)
  infoItem.transform.localPosition = Vector3(0, 0, 0)
  self.challengeTaskInfoItem:Hide()
end

function UIPeriodicChallenge:OnClickDailyBtn()
  self.nodeList[1]:OnClickDetail()
end

function UIPeriodicChallenge:IntroduceBtnFunc()
  local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
  GuidePicture.OpenGuidePicture(PicTipsConsts.WCIntro)
end

function UIPeriodicChallenge:InitWeeklyChallenge(closeCallback)
  self.detailType = SectorLevelDetailEnum.eDetailType.WeeklyChallenge
  local lastSelectSector = PlayerDataCenter.sectorStage:GetSelectSectorId()
  local isWeeklyChallengeSector = table.contain(ConfigData.game_config.weeklyChallengeSectorIds, lastSelectSector)
  if not isWeeklyChallengeSector then
    PlayerDataCenter.sectorStage:SetSelectSectorId(nil)
  end
  PlayerDataCenter.sectorStage.lastChallengeType = proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
  self.closeCallback = closeCallback
  self.infoItemPool:HideAll()
  for _, periodicChallenge in ipairs(self.nodeList) do
    periodicChallenge:Hide()
  end
  for _, weeklyData in pairs(PlayerDataCenter.allWeeklyChallengeData.dataDic) do
    local weeklyType = weeklyData:GetWeeklyType()
    if weeklyType > #self.nodeList then
      error(" weeklyType out-of-bounds index " .. tostring(weeklyType))
    else
      local item = self.nodeList[weeklyType]
      item:Show()
      item:InitWeeklyItem(weeklyData.id, self)
      local infoItem = self.infoItemPool:GetOne(true)
      infoItem:InitWeeklyInfoItem(weeklyData.id, weeklyType - 1)
      infoItem.transform:SetParent(item.ui.infoHolder.transform)
      infoItem.transform.localPosition = Vector3(0, 0, 0)
    end
  end
  self.challengeTaskInfoItem:Show()
  self.challengeTaskInfoItem:InitTaskInfoItem()
  if self._firstEnter then
    self._firstEnter = nil
    GuideManager:TryTriggerGuide(eGuideCondition.InWeeklyChallenge)
  end
end

function UIPeriodicChallenge:OnClickWeeklyBtn()
  local has, dungoenId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
  if has then
    for i, v in ipairs(self.nodeList) do
      if v.dungeonId == dungoenId then
        v:OnClickDetail()
        break
      end
    end
    if self.realDailyEntry.dungeonId == dungoenId then
      self.realDailyEntry:OnClickDetail()
    end
  end
end

function UIPeriodicChallenge:RefreshUncompletedEp()
  self:__CloseLevelDetailWindow()
  self:RefreshRealDailyNode()
  if self.detailType == SectorLevelDetailEnum.eDetailType.WeeklyChallenge then
    if not PlayerDataCenter.allWeeklyChallengeData:IsExistChallenge() then
      local JumpManager = require("Game.Jump.JumpManager")
      JumpManager:Jump(JumpManager.eJumpTarget.Sector, function(func)
        UIManager:DeleteWindow(UIWindowTypeID.DailyChallenge)
        func()
      end)
    else
      self:InitWeeklyChallenge(self.closeCallback)
    end
  elseif self.detailType == SectorLevelDetailEnum.eDetailType.PeriodicChallenge then
    self:InitPeriodicChallenge(self.closeCallback)
  end
  local challengeTaskUI = UIManager:GetWindow(UIWindowTypeID.SectorTask)
  if challengeTaskUI ~= nil then
    UIUtil.OnClickBackByUiTab(self)
  end
end

function UIPeriodicChallenge:IsRealDailyNodeActive()
  if self.realDailyEntry ~= nil and not IsNull(self.realDailyEntry.gameObject) and self.realDailyEntry.gameObject.activeInHierarchy then
    return true
  end
  return false
end

function UIPeriodicChallenge:RefreshRealDailyNode()
  self.realDailyEntry:Hide()
  self.realDailyInfoNode:Hide()
  local isSystemOpen = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklySector)
  if not isSystemOpen then
    return
  end
  self.realDailyEntry:Show()
  self.realDailyInfoNode:Show()
  local allLevelsInSctor = ConfigData.sector_stage.sectorDiffDic[ConfigData.buildinConfig.WeeklyChallengeSectorId][SectorLevelDetailEnum.eDifficulty.normal]
  local stageCfg
  for iStageId = #allLevelsInSctor, 1, -1 do
    stageCfg = ConfigData.sector_stage[allLevelsInSctor[iStageId]]
    if CheckCondition.CheckLua(stageCfg.pre_condition, stageCfg.pre_para1, stageCfg.pre_para2) then
      self.realDailyEntry:SetDungeonId(stageCfg.id)
      self.realDailyInfoNode:InitRealDailyInfoNode(ConfigData.buildinConfig.WeeklyChallengeSectorId, stageCfg.id)
      return
    end
  end
  if isGameDev then
    error("No available stage Finded! check sector_stage")
  end
  self.realDailyEntry:Hide()
  self.realDailyInfoNode:Hide()
end

function UIPeriodicChallenge:OnClickItemCallback(item, flag)
  if flag then
    if self.selectedItem ~= nil then
      self.selectedItem:SetSelectState(false)
    end
    self.selectedItem = item
    self:OnSelectSectorLevel(item)
  else
    self.selectedItem = nil
  end
end

function UIPeriodicChallenge:__CloseLevelDetailWindow()
  if self.selectedItem ~= nil then
    UIUtil.OnClickBackByWinId(UIWindowTypeID.SectorLevelDetail)
  end
end

function UIPeriodicChallenge:OnSelectSectorLevel(item)
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevelDetail, function(window)
    window:SetLevelDetaiHideStartEvent(function()
      self:PlayMoveLeftTween(false)
      item:SetSelectState(false)
      self:OnClickItemCallback(item, false)
    end)
    window:SetLevelDetaiHideEndEvent(function()
    end)
    local width, duration = window:GetLevelDetailWidthAndDuration()
    self:PlayMoveLeftTween(true, width, duration)
    item:SetSelectState(true)
    if item.detailType == SectorLevelDetailEnum.eDetailType.PeriodicChallenge then
      window:InitPeriodicChallengeDetailNode(item.dungeonId, item.eChallenge)
    elseif item.detailType == SectorLevelDetailEnum.eDetailType.WeeklyChallenge then
      local data = PlayerDataCenter.allWeeklyChallengeData.dataDic[item.dungeonId]
      local isLocked = not data:IsUnlockWeeklyChallenge()
      window:InitWeeklyChallengeDetailNode(item.dungeonId, isLocked)
      if isLocked then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(CheckCondition.GetUnlockInfoLua(data.cfg.pre_condition, data.cfg.pre_para1, data.cfg.pre_para2))
      end
    end
  end)
end

function UIPeriodicChallenge:PlayMoveLeftTween(isLeft, offset, duration)
  local var = self.ui.obj_levelNode.transform
  if self.__moveLeftTween == nil then
    local endValue = Vector2.unity_vector2(1 - offset / (var.rect.width + self.ui.moveLeftTwenOffset), 1)
    self.__moveLeftTween = var:DOAnchorMax(endValue, duration):SetAutoKill(false)
    self.__moveLeftTweenDuration = duration
  end
  if self.currentMoveLeft ~= nil and self.currentMoveLeft == isLeft then
    return
  end
  self.currentMoveLeft = isLeft
  if isLeft then
    self.__moveLeftTween:PlayForward()
  else
    self.__moveLeftTween:PlayBackwards()
  end
end

function UIPeriodicChallenge:__OnClickWeeklyShop()
  JumpManager:DirectShowShop(nil, nil, ShopEnum.ShopId.weekly)
end

function UIPeriodicChallenge:__OnClickBack(toHome)
  UIManager:DeleteWindow(UIWindowTypeID.SectorLevelDetail)
  if self.closeCallback ~= nil then
    self.closeCallback(toHome)
  end
  self:Delete()
end

function UIPeriodicChallenge:OnDelete()
  self.challengeTaskInfoItem:Delete()
  self.realDailyEntry:Delete()
  self.realDailyInfoNode:Delete()
  for i, v in ipairs(self.nodeList) do
    v:Delete()
  end
  MsgCenter:RemoveListener(eMsgEventId.ChallengeOutOfData, self.__onHasUncompletedEp)
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  if self.__moveLeftTween ~= nil then
    self.__moveLeftTween:Kill()
    self.__moveLeftTween = nil
  end
  local sectorLevelDetail = UIManager:GetWindow(UIWindowTypeID.SectorLevelDetail)
  if sectorLevelDetail ~= nil then
    sectorLevelDetail:SetLevelDetaiHideStartEvent(nil)
  end
  base.OnDelete(self)
end

return UIPeriodicChallenge
