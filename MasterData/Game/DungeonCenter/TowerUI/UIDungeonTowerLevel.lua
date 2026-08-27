local UIDungeonTowerLevel = class("UIDungeonTowerLevel", UIBaseWindow)
local base = UIBaseWindow
local UINDunTowerLevelItem = require("Game.DungeonCenter.TowerUI.UINDunTowerLevelItem")
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function UIDungeonTowerLevel:OnInit()
  UIUtil.SetTopStatus(self, self._OnClickBack)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.CloseLevelDetailWindow)
  UIUtil.AddButtonListener(self.ui.btn_ToBack, self, self.OnBtnGotoCurTowerLevel)
  UIUtil.AddButtonListener(self.ui.btn_ToNext, self, self.OnBtnGotoCurTowerLevel)
  UIUtil.AddButtonListener(self.ui.btn_dataFile, self, self.OnDataFileClicked)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self.OnRankClicked)
  UIUtil.AddButtonListener(self.ui.btn_SwitchTower, self, self.OnBtnSwitchTowerClick)
  UIUtil.AddButtonListener(self.ui.btn_Racing, self, self.OnBtnRacingClick)
  self.ui.tower_loopScroll.onInstantiateItem = BindCallback(self, self.OnTowerNewItem)
  self.ui.tower_loopScroll.onChangeItem = BindCallback(self, self.OnTowerItemChanged)
  self.ui.tower_loopScroll.onReturnItem = BindCallback(self, self.OnTowerReturnItem)
  self.ui.tower_loopScroll.onValueChanged:AddListener(BindCallback(self, self.OnScrollValueChanged))
  self.__towerItemDic = {}
  self.resloader = CS.ResLoader.Create()
  self.__OnTowerItemSelectedEvent = BindCallback(self, self.__OnTowerItemSelected)
end

function UIDungeonTowerLevel:InitDungeonTowerLevel(dunTowerCtrl, towerTypeData, completeLevel)
  self.__dunTowerCtrl = dunTowerCtrl
  self.__towerTypeData = towerTypeData
  self.__completeLevel = completeLevel or 0
  self.__isAllComplete = completeLevel == self.__towerTypeData:GetTowerTotalLevel()
  self:InitTowerBaseInfoUI()
  self:InitTowerBackImage()
  self:InitTowerLevelListUI()
  local autoProgressShow = self.__dunTowerCtrl:GetNeedAutoShowProgress()
  if autoProgressShow then
    self:InitLastTowerProgressShow()
  end
end

function UIDungeonTowerLevel:InitDungeonTowerLevel4HexaTower(dunHexaTowerCtrl, towerTypeData, completeLevel)
  self.__dunHexaTowerCtrl = dunHexaTowerCtrl
  self.__towerTypeData = towerTypeData
  self.__completeLevel = completeLevel or 0
  self.__isAllComplete = completeLevel == self.__towerTypeData:GetTowerTotalLevel()
  self:InitTowerBaseInfoUI()
  self:InitTowerBackImage()
  self:InitTowerLevelListUI()
  self:InitLastTowerProgressShow()
end

function UIDungeonTowerLevel:InitTowerBaseInfoUI()
  self:RefreshDunTowerNoun()
  local isHeax = self.__towerTypeData:IsTypeHeax()
  local isTwinTower = self.__towerTypeData:IsTypeTwinTower()
  local towerId = self.__towerTypeData:GetDungeonTowerTypeId()
  local hasRacing = false
  if (isTwinTower or isHeax) and self.__towerTypeData:GetTowerRacingCfg() ~= nil then
    hasRacing = true
  end
  self.ui.obj_NormalTower:SetActive(not isTwinTower and not isHeax)
  self.ui.obj_TwinTower:SetActive(isTwinTower or isHeax)
  self.ui.btn_Racing.gameObject:SetActive(hasRacing)
  local rankId = self.__towerTypeData:GetTowerRankId()
  self.ui.btn_Rank.gameObject:SetActive(0 < rankId)
  self.ui.redDot_Racing:SetActive(false)
  if isTwinTower or isHeax then
    local totalLevel = self.__towerTypeData:GetTowerTotalLevel()
    self.ui.tex_Progress.text = tostring(self.__completeLevel * 100 // totalLevel) .. "%"
    self.ui.tex_SwitchTowerName.text = self.__towerTypeData:GetDungeonTowerName()
    self.ui.btn_dataFile.gameObject:SetActive(isTwinTower)
    self.ui.btn_dataFile.transform:SetParent(self.ui.dataFileRoot2)
    local isComplete, totalFrame = PlayerDataCenter.dungeonTowerSData:GetTowerTotalRacingFrame(self.__towerTypeData:GetDungeonTowerTypeId())
    if isComplete then
      self.ui.tex_TotalTime:SetIndex(0, BattleUtil.FrameToTimeString(totalFrame, true))
    else
      self.ui.tex_TotalTime:SetIndex(1)
    end
    if self._racingRewardListener == nil then
      function self._racingRewardListener(node)
        if node.nodeId == self.__towerTypeData:GetDungeonTowerTypeId() then
          self:__RefreshRacingReddot()
        end
      end
      
      if isHeax then
        local _, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonSixTower, RedDotStaticTypeId.DunSixTowerTimeLimit)
        local realNode = node:GetChild(self.__towerTypeData:GetDungeonTowerTypeId())
        if realNode ~= nil then
          RedDotController:AddListener(realNode.nodePath, self._racingRewardListener)
        end
      else
        RedDotController:AddListener(RedDotDynPath.DunTwinTowerReward, self._racingRewardListener)
      end
    end
    self:__RefreshRacingReddot()
    local otherHasReddot = false
    if isHeax then
      local _, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonSixTower, RedDotStaticTypeId.DunSixTowerTimeLimit)
      local totalReddot = node:GetRedDotCount()
      if 0 < totalReddot then
        local curCount = 0
        local towerNode = node:GetChild(towerId)
        if towerNode ~= nil then
          curCount = towerNode:GetRedDotCount()
        end
        if 0 < totalReddot - curCount then
          otherHasReddot = true
        end
      end
    else
      local _, twinTowerNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonTower, RedDotStaticTypeId.DungeonTwinTower)
      local totalReddot = twinTowerNode:GetRedDotCount()
      if 0 < totalReddot then
        local curCount = 0
        local twinTowerNode = twinTowerNode:GetChild(towerId)
        if twinTowerNode ~= nil then
          curCount = twinTowerNode:GetRedDotCount()
        end
        if 0 < totalReddot - curCount then
          otherHasReddot = true
        end
      end
    end
    self.ui.redDot_Switch:SetActive(otherHasReddot)
  else
    self.ui.btn_dataFile.transform:SetParent(self.ui.dataFileRoot1)
    self.ui.tex_Name.text = self.__towerTypeData:GetDungeonTowerName()
  end
  self.ui.btn_dataFile.transform.anchoredPosition = Vector2.zero
end

function UIDungeonTowerLevel:__RefreshRacingReddot()
  local isHeax = self.__towerTypeData:IsTypeHeax()
  local towerId = self.__towerTypeData:GetDungeonTowerTypeId()
  local hasRedot = false
  if isHeax then
    local _, twinTowerNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonSixTower, RedDotStaticTypeId.DunSixTowerTimeLimit)
    local rewardNode = twinTowerNode:GetChild(towerId)
    if rewardNode ~= nil then
      hasRedot = rewardNode:GetRedDotCount() > 0
    end
  else
    local _, twinTowerNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonTower, RedDotStaticTypeId.DungeonTwinTower)
    local towerNode = twinTowerNode:GetChild(towerId)
    if towerNode ~= nil then
      hasRedot = towerNode:GetRedDotCount() > 0
    end
    if not hasRedot then
      local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
      local readed = saveUserData:GetDunTwinTowerRacingReaded()
      if not readed then
        hasRedot = true
      end
    end
  end
  self.ui.redDot_Racing:SetActive(hasRedot)
end

function UIDungeonTowerLevel:RefreshDunTowerNoun()
  local totalNum, unlockNum, unreadNum = self.__towerTypeData:GetTowerAvgNounNumInfo()
  self.ui.tex_DataCount:SetIndex(0, tostring(unlockNum), tostring(totalNum))
  self.ui.blueDot_dateFile:SetActive(0 < unreadNum)
end

function UIDungeonTowerLevel:InitTowerBackImage()
  local cgSize = CS.UIManager.Instance.BackgroundStretchSize
  local bgSizeW = self.ui.largeBgWidth
  local bgSizeH = self.ui.largeBgHeight
  local rSizeW = cgSize.x
  local rSizeH = cgSize.x / bgSizeW * bgSizeH
  self.ui.dynBackImage.sizeDelta = Vector2.New(rSizeW, rSizeH)
  self.__totalBackHeight = rSizeH - cgSize.y
end

function UIDungeonTowerLevel:InitLastTowerProgressShow()
  local lastLevel = PlayerDataCenter.cacheSaveData:GetLastDunTowerProgress(self.__towerTypeData:GetDungeonTowerTypeId())
  PlayerDataCenter.cacheSaveData:SaveLastDunTowerProgress(self.__towerTypeData:GetDungeonTowerTypeId(), self.__completeLevel)
  if lastLevel == nil or lastLevel >= self.__completeLevel then
    return
  end
  local nCompleteLevel = self.__completeLevel
  local towerNounId = 0
  for i = lastLevel + 1, nCompleteLevel do
    local towerLevelData = self.__towerTypeData:GetTowerLevelByNum(i)
    if towerLevelData ~= nil then
      local nounId = towerLevelData:GetTowerLevelNounId()
      if 0 < nounId then
        towerNounId = nounId
      end
    end
  end
  if 0 < towerNounId then
    self:__ShowNounUnlock(towerNounId, function()
      self:__PlayTowerUnlockLevelAni(lastLevel, nCompleteLevel)
    end)
  else
    UIUtil.AddOneCover("DungeonTowerLevel")
    self.__effectTimerId = TimerManager:StartTimer(1, function()
      UIUtil.CloseOneCover("DungeonTowerLevel")
      self:__PlayTowerUnlockLevelAni(lastLevel, nCompleteLevel)
    end, nil, true, true)
  end
end

function UIDungeonTowerLevel:__ShowNounUnlock(towerNounId, callback)
  if towerNounId <= 0 then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonTowerSuccess, function(window)
    if window == nil then
      return
    end
    local nounCfg = ConfigData.noun_des[towerNounId]
    window:InitDunTowerNounUnlock(LanguageUtil.GetLocaleText(nounCfg.name))
    window:SetBtnCloseAction(callback)
    AudioManager:PlayAudioById(1124)
  end)
end

function UIDungeonTowerLevel:__PlayTowerUnlockLevelAni(lCompleteLevel, nCompleteLevel)
  local startIndex = self:__GetScrollFillIndex(nCompleteLevel)
  UIUtil.AddOneCover("DungeonTowerLevel")
  local speed = math.clamp((nCompleteLevel - lCompleteLevel) * 500, 500, 10000)
  self.ui.tower_loopScroll:SrollToCell(startIndex, speed, function()
    UIUtil.CloseOneCover("DungeonTowerLevel")
    if nCompleteLevel < self.__towerTypeData:GetTowerTotalLevel() then
      local newLevelNum = nCompleteLevel + 1
      local towerLevelItem = self:GetLevelItemGoByIndex(newLevelNum)
      if towerLevelItem ~= nil then
        UIUtil.AddOneCover("DungeonTowerLevel")
        local towerLevelData = self.__towerTypeData:GetTowerLevelByNum(newLevelNum)
        self.curLvEff = nil
        if towerLevelData ~= nil and towerLevelData:IsTowerFlagLevel() then
          self.curLvEff = self.ui.eff_unlockNewLvGold
          AudioManager:PlayAudioById(1151)
        else
          self.curLvEff = self.ui.eff_unlockNewLevel
          AudioManager:PlayAudioById(1150)
        end
        self:ShowUnlockNewLvEff(self.curLvEff, towerLevelItem.transform)
        self.__effectTimerId = TimerManager:StartTimer(self.ui.time_effUnlock, function()
          self:HideUnlockNewLvEff(self.curLvEff)
          self.curLvEff = nil
          UIUtil.CloseOneCover("DungeonTowerLevel")
        end, nil, true)
        return
      end
    end
  end)
end

function UIDungeonTowerLevel:ShowUnlockNewLvEff(objEff, parent)
  objEff.transform:SetParent(parent)
  objEff.transform.anchoredPosition3D = Vector3.zero
  objEff:SetActive(true)
end

function UIDungeonTowerLevel:HideUnlockNewLvEff(objEff)
  objEff:SetActive(false)
  objEff.transform:SetParent(self.ui.hideNode)
end

function UIDungeonTowerLevel:InitTowerLevelListUI()
  local totalItemCount = self.__towerTypeData:GetTowerTotalLevel() + 2
  self.__totalItemCount = totalItemCount
  self.ui.tower_loopScroll.totalCount = totalItemCount
  local baseItemHeight = self.ui.ly_towerItem.preferredHeight
  local scrollRectHeight = self.ui.tower_loopScroll.transform.rect.height
  local ableScrollHeight = baseItemHeight * totalItemCount - scrollRectHeight
  self.__itemRatioUnit = baseItemHeight / ableScrollHeight
  self.__minSlideRatio = self.__itemRatioUnit / 2
  self.__cycleLayerRatio = 1 / self.__itemRatioUnit / self.ui.cycleLayerCount
  self.__layerScrollDistance = self.ui.layerScrollSpeed * baseItemHeight * self.ui.cycleLayerCount
  self.__startLayerPos = 1 - self.ui.startLayerOffset * self.__itemRatioUnit + scrollRectHeight / ableScrollHeight * 1.1
  local fillLevel = PlayerDataCenter.cacheSaveData:GetLastDunTowerProgress(self.__towerTypeData:GetDungeonTowerTypeId())
  if fillLevel == nil or fillLevel >= self.__completeLevel then
    fillLevel = self.__completeLevel
  end
  local startIndex = self:__GetScrollFillIndex(fillLevel)
  self.ui.tower_loopScroll:RefillCells(startIndex)
  local posY = self.ui.tower_loopScroll.verticalNormalizedPosition
  self:__SetTowerLoopRectPosY(posY)
end

function UIDungeonTowerLevel:__GetScrollFillIndex(levelNum)
  local startIndex = math.clamp(levelNum - 1, 0, self.__towerTypeData:GetTowerTotalLevel())
  return startIndex
end

function UIDungeonTowerLevel:OnTowerNewItem(go)
  local levelItem = UINDunTowerLevelItem.New()
  levelItem:Init(go)
  levelItem:BindTowerItemCommon(self.__towerTypeData:IsTypeTwinTower(), self.resloader, self.__OnTowerItemSelectedEvent, self.ui.obj_SelectLevel, self.ui.obj_NewLevel, self.ui.obj_Down)
  self.__towerItemDic[go] = levelItem
end

function UIDungeonTowerLevel:OnTowerReturnItem(go)
  local levelItem = self.__towerItemDic[go]
  if levelItem == nil then
    return
  end
  levelItem:ClearItemTowerLevel()
end

function UIDungeonTowerLevel:OnTowerItemChanged(go, index)
  local towerLevelItem = self.__towerItemDic[go]
  if towerLevelItem == nil then
    error("Can't find towerlevelItem by gameObject")
    return
  end
  local num = index
  if num == 0 then
    towerLevelItem:InitTowerLevelItemKeep(DungeonLevelEnum.TowerLevelItemType.TopEmpty, self.ui.obj_Top)
    return
  end
  if num == self.__towerTypeData:GetTowerTotalLevel() + 1 then
    towerLevelItem:InitTowerLevelItemKeep(DungeonLevelEnum.TowerLevelItemType.DownEmpty, self.ui.obj_Top)
    return
  end
  local towerLevelData = self.__towerTypeData:GetTowerLevelByNum(num)
  if towerLevelData == nil then
    error("dungeon tower level cfg is null,level_num:" .. tostring(num))
    return
  end
  towerLevelItem:InitTowerLevelItem(towerLevelData, self.__completeLevel)
  towerLevelItem:SetAsSelectTowerLevel(towerLevelData == self.__selectTowerLevelData)
end

function UIDungeonTowerLevel:OnScrollValueChanged(vec2)
  local posY = vec2.y
  self:__SetTowerLoopRectPosY(posY)
end

function UIDungeonTowerLevel:__SetTowerLoopRectPosY(posY)
  self.ui.dynBackImage.anchoredPosition = Vector2.New(0, self.__totalBackHeight * math.clamp(posY, 0, 1))
  local t = (self.__startLayerPos + posY) * self.__cycleLayerRatio
  local pos = t - math.floor(t)
  if 0.5 < pos then
    pos = -(1 - pos) * 2
  else
    pos = pos * 2
  end
  self.ui.middleLayerNode.transform.anchoredPosition = Vector2(0, pos * self.__layerScrollDistance)
  local lastRectY = posY
  if self.__loopRectY == nil then
    self.__loopRectY = posY
  end
  if not self.__isAllComplete and self.__selectTowerLevelData == nil and math.abs(lastRectY - self.__loopRectY) >= self.__minSlideRatio then
    self.__loopRectY = posY
    self:RefreshGotoCurLevel()
  end
end

function UIDungeonTowerLevel:RefreshGotoCurLevel()
  local levelNum = self.__completeLevel + 1
  local towerLevelItem = self:GetLevelItemGoByIndex(levelNum)
  if towerLevelItem ~= nil then
    self.ui.btn_ToBack.gameObject:SetActive(false)
    self.ui.btn_ToNext.gameObject:SetActive(false)
    return
  end
  local isUp = false
  for go, towerItem in pairs(self.__towerItemDic) do
    local towerLevelData = towerItem:GetItemTowerLevelData()
    if towerLevelData ~= nil and levelNum < towerLevelData:GetDunTowerLevelNum() then
      isUp = true
      break
    end
  end
  self.ui.btn_ToBack.gameObject:SetActive(isUp)
  self.ui.btn_ToNext.gameObject:SetActive(not isUp)
end

function UIDungeonTowerLevel:GetLevelItemGoByIndex(index)
  local go = self.ui.tower_loopScroll:GetCellByIndex(index)
  if go ~= nil then
    local towerLevelItem = self.__towerItemDic[go]
    return towerLevelItem
  end
  return nil
end

function UIDungeonTowerLevel:OnBtnGotoCurTowerLevel()
  local startIndex = self:__GetScrollFillIndex(self.__completeLevel)
  UIUtil.AddOneCover("DungeonTowerLevel")
  AudioManager:PlayAudioById(1152)
  self.ui.tower_loopScroll:SrollToCell(startIndex, 10000, function()
    UIUtil.CloseOneCover("DungeonTowerLevel")
  end)
end

function UIDungeonTowerLevel:__OnTowerItemSelected(towerLevelItem, towerLevelData)
  if self.__selectTowerLevelData == towerLevelData then
    return
  end
  self.ui.btn_ToBack.gameObject:SetActive(false)
  self.ui.btn_ToNext.gameObject:SetActive(false)
  if self.__selectTowerLevelData ~= nil then
    self:__CancelLastLevelSelect()
  end
  towerLevelItem:SetAsSelectTowerLevel(true)
  self.__selectTowerLevelData = towerLevelData
  local towerTypeId = self.__towerTypeData:GetDungeonTowerTypeId()
  local isLocked = towerLevelData:GetDunTowerLevelNum() > PlayerDataCenter.dungeonTowerSData:GetTowerCompleteLevel(towerTypeId) + 1
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonLevelDetail, function(window)
    window:SetDunLevelDetaiHideStartEvent(function()
      self:__PlayMoveLeftTween(false)
      self:__CancelLastLevelSelect()
      self:RefreshGotoCurLevel()
    end)
    window:SetDunLevelDetaiHideEndEvent(function()
    end)
    local width, duration = window:GetDLevelDetailWidthAndDuration()
    self:__PlayMoveLeftTween(true, width, duration)
    window:InitDungeonLevelDetail(towerLevelData, isLocked)
  end)
end

function UIDungeonTowerLevel:__PlayMoveLeftTween(isLeft, offset, duration)
  local var = self.ui.obj_mainNode.transform
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

function UIDungeonTowerLevel:__CancelLastLevelSelect()
  if self.__selectTowerLevelData == nil then
    return
  end
  local selectTowerData = self.__selectTowerLevelData
  self.__selectTowerLevelData = nil
  local towerItem = self:GetLevelItemGoByIndex(selectTowerData:GetDunTowerLevelNum())
  if towerItem ~= nil then
    towerItem:SetAsSelectTowerLevel(false)
  end
end

function UIDungeonTowerLevel:CloseLevelDetailWindow()
  if self.__selectTowerLevelData ~= nil then
    UIUtil.OnClickBackByWinId(UIWindowTypeID.DungeonLevelDetail)
  end
end

function UIDungeonTowerLevel:_OnClickBack(toHome)
  self:Delete()
end

function UIDungeonTowerLevel:OnDataFileClicked()
  UIManager:ShowWindowAsync(UIWindowTypeID.AvgNounDes, function(win)
    win:InitAvgNounDes(false, nil, self.__towerTypeData:GetTowerAvgNounType())
    win:BindAvgNounCloseEvent(function()
      self:RefreshDunTowerNoun()
    end)
  end)
end

function UIDungeonTowerLevel:OnRankClicked()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRank, function(rankWindow)
    if rankWindow == nil then
      return
    end
    rankWindow:InitCommonRank(self.__towerTypeData:GetTowerRankId())
  end)
end

function UIDungeonTowerLevel:OnBtnSwitchTowerClick()
  if self.__dunTowerCtrl ~= nil then
    self.__dunTowerCtrl:RequestRacingRankSelfInfo(function(myRankDetail)
      UIManager:ShowWindowAsync(UIWindowTypeID.DungeonTwinTowerSelect, function(window)
        if window == nil then
          return
        end
        window:InitDunTwinTowerSelect(self.__dunTowerCtrl, self.__towerTypeData:GetDungeonTowerTypeId(), myRankDetail)
      end)
    end)
  else
    local towerId = self.__towerTypeData:GetDungeonTowerTypeId()
    local isPeriodic = self.__towerTypeData:GetIsPeriodic()
    local normalTowwerIdList = self.__dunHexaTowerCtrl:GetCurrentNormalTower()
    local periodicTowwerIdList = self.__dunHexaTowerCtrl:GetCurrentTimeLimitTower()
    local isHavePeriodic = 0 < #periodicTowwerIdList
    local window = UIManager:ShowWindow(UIWindowTypeID.DungeonHexaTowerSelect)
    if window == nil then
      return
    end
    window:RefreshSelectNode(self.__dunHexaTowerCtrl, isHavePeriodic, normalTowwerIdList, periodicTowwerIdList, towerId)
    window:HexaTowerSelectTag(isPeriodic)
  end
end

function UIDungeonTowerLevel:OnBtnRacingClick()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  if saveUserData:SetDunTwinTowerRacingReaded(true) then
    self:__RefreshRacingReddot()
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonTowerRacing, function(window)
    if window == nil then
      return
    end
    window:InitTowerRacing(self.__towerTypeData)
  end)
end

function UIDungeonTowerLevel:GenCoverJumpReturnCallback()
  return function()
    self:RefreshDunTowerNoun()
  end
end

function UIDungeonTowerLevel:OnDelete()
  UIUtil.CloseOneCover("DungeonTowerLevel")
  if self._racingRewardListener ~= nil then
    local isHeax = self.__towerTypeData:IsTypeHeax()
    if isHeax then
      local _, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonSixTower, RedDotStaticTypeId.DunSixTowerTimeLimit)
      local realNode = node:GetChild(self.__towerTypeData:GetDungeonTowerTypeId())
      if realNode ~= nil then
        RedDotController:RemoveListener(realNode.nodePath, self._racingRewardListener)
      end
    else
      RedDotController:RemoveListener(RedDotDynPath.DunTwinTowerReward, self._racingRewardListener)
    end
  end
  TimerManager:StopTimer(self.__effectTimerId)
  if self.__moveLeftTween ~= nil then
    self.__moveLeftTween:Kill()
    self.__moveLeftTween = nil
  end
  UIManager:DeleteWindow(UIWindowTypeID.DungeonLevelDetail)
  base.OnDelete(self)
end

return UIDungeonTowerLevel
