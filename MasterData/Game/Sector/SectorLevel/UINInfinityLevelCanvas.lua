local UINInfinityLevelCanvas = class("UINInfinityLevelCanvas", UIBaseNode)
local base = UIBaseNode
local UINInfinityLevelItem = require("Game.Sector.SectorLevel.UINInfinityLevelItem")
local ePlaceHolderType = require("Game.Sector.Enum.SectorLevelInfinityEnum").ePlaceHolderType
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local UINInfinityWheelItem = require("Game.Sector.SectorLevel.UINInfinityWheelItem")
local SectorEnum = require("Game.Sector.SectorEnum")

function UINInfinityLevelCanvas:OnInit()
  self.sectorId = nil
  self.tweenCompleteEvent = nil
  self.itemDic = {}
  self.levelDataList = {}
  self.bestRecordLevelData = nil
  self.bestCompleteLevelData = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.loopScrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loopScrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.loopScrollRect.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.ui.loopScrollRect.onValueChanged:AddListener(BindCallback(self, self.__OnValueChange))
  self.wheel = UINInfinityWheelItem.New()
  self.wheel:Init(self.ui.wheel)
  self.ui.switchTween.onComplete:AddListener(BindCallback(self, self.OnSwitchTweenComplete))
  self.ui.switchTween.onRewind:AddListener(BindCallback(self, self.OnSwitchTweenRewind))
  self._OnclickLevelItem = BindCallback(self, self.OnclickLevelItem)
end

function UINInfinityLevelCanvas:InitInfinityLevelCanvas(sectorId, autoStateCfg, isUnCompleteEp, tweenCompleteEvent)
  self.sectorId = sectorId
  self.tweenCompleteEvent = tweenCompleteEvent
  if isUnCompleteEp then
    self.lastEpStateCfg = autoStateCfg
  else
    self.lastEpStateCfg = nil
  end
  local locateStageIndex, isWin
  if PlayerDataCenter.sectorStage.lastSatgeData ~= nil then
    locateStageIndex = PlayerDataCenter.sectorStage.lastSatgeData.stageCfg.index
    isWin = PlayerDataCenter.sectorStage.lastSatgeData.isWin
  elseif autoStateCfg ~= nil then
    locateStageIndex = autoStateCfg.endlessCfg.index
    isWin = false
  end
  self.levelDataList = {}
  self:GenLevels(locateStageIndex, isWin)
end

function UINInfinityLevelCanvas:RefreshUncompletedEp(lastEpStateCfg)
  if self.lastEpStateCfg ~= nil then
    local lastIndex = self.lastEpStateCfg.endlessCfg.index
    self.lastEpStateCfg = lastEpStateCfg
    self.levelDataList = {}
    self:GenLevels(lastIndex)
  end
end

function UINInfinityLevelCanvas:SetBackground(texture)
  self.ui.Img_background.texture = texture
end

function UINInfinityLevelCanvas:GenLevels(selectIndex, justRollto)
  local maxReachedIndex = 0
  local maxCompletedIndex = 0
  local notCompleteLevelIndex
  if ConfigData.endless[self.sectorId] == nil then
    error("can't read endlessCfg with")
    return
  end
  for index, cfg in ipairs(ConfigData.endless[self.sectorId]) do
    local isUnlock = CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
    local lockInfo
    if not isUnlock then
      lockInfo = CheckCondition.GetUnlockInfoLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
    end
    local isForbid = false
    local forbidInfo
    if self.lastEpStateCfg ~= nil then
      if cfg.id == self.lastEpStateCfg.dungeonId then
        isForbid = false
        notCompleteLevelIndex = index
      else
        isForbid = true
        forbidInfo = string.format(ConfigData:GetTipContent(TipContent.Sector_IsExploringOtherSector2endless), LanguageUtil.GetLocaleText(self.lastEpStateCfg.endlessCfg.name), tostring(self.lastEpStateCfg.endlessCfg.index * 10) .. "m")
      end
    end
    local isComplete = PlayerDataCenter.infinityData:IsInfinityDungeonCompleted(cfg.id)
    local passNum = 0
    if not isComplete then
      passNum = PlayerDataCenter.infinityData:GetInfinityDungeonProcess(cfg.id) or 0
    end
    table.insert(self.levelDataList, {
      index = index,
      cfg = cfg,
      isUnlock = isUnlock,
      isForbid = isForbid,
      isComplete = isComplete,
      passNum = passNum,
      lockInfo = lockInfo,
      forbidInfo = forbidInfo
    })
    if isComplete or 0 < passNum then
      maxReachedIndex = index
    end
    if isComplete then
      maxCompletedIndex = index
    end
  end
  self.bestRecordLevelData = self.levelDataList[maxReachedIndex]
  self.bestCompleteLevelData = self.levelDataList[maxCompletedIndex]
  table.insert(self.levelDataList, 1, {
    isPlaceHoleder = true,
    placeHolederType = ePlaceHolderType.Top
  })
  table.insert(self.levelDataList, 1, {
    isPlaceHoleder = true,
    placeHolederType = ePlaceHolderType.None
  })
  table.insert(self.levelDataList, {
    isPlaceHoleder = true,
    placeHolederType = ePlaceHolderType.Down
  })
  table.insert(self.levelDataList, {
    isPlaceHoleder = true,
    placeHolederType = ePlaceHolderType.None
  })
  local num = #self.levelDataList
  self.ui.loopScrollRect.totalCount = num
  self.ui.loopScrollRect:RefillCells()
  local viewSizeY = self.ui.loopScrollRect.sizeOfviewRect.y
  local elementSizeY = self.ui.loopScrollRect:sizeOfItem(1)
  self.rollOffset = viewSizeY / elementSizeY // 2 - 1
  self.wheel:InitWheel(num, viewSizeY, elementSizeY)
  if selectIndex then
    self:Refill2TargetIndex(selectIndex)
    if not justRollto then
      local item = self:__GetItemGoByIndex(selectIndex - 1)
      if item ~= nil then
        item:OnClick()
      end
    end
  elseif notCompleteLevelIndex ~= nil then
    self:Refill2TargetIndex(notCompleteLevelIndex)
    local item = self:__GetItemGoByIndex(notCompleteLevelIndex - 1)
    if item ~= nil then
      item:OnClick()
    end
  else
    self:Roll2TargetIndex()
  end
end

function UINInfinityLevelCanvas:__OnNewItem(go)
  local levelItem = UINInfinityLevelItem.New()
  levelItem:Init(go)
  self.itemDic[go] = levelItem
end

function UINInfinityLevelCanvas:__OnChangeItem(go, index)
  local levelItem = self.itemDic[go]
  if levelItem == nil then
    error("Can't find levelItem by gameObject")
    return
  end
  local levelData = self.levelDataList[index + 1]
  if levelData == nil then
    error("Can't find levelData by index, index = " .. tonumber(index))
    return
  end
  if levelData.isPlaceHoleder then
    levelItem:InitPlaceHolder(levelData, self.ui.obj_IsTop, self.ui.obj_IsDown)
  else
    levelItem:InitInfinityLevel(levelData, self._OnclickLevelItem)
    local selected = false
    if self.lastSelectData ~= nil and self._startSelectedIndex ~= nil and self._startSelectedIndex < levelData.cfg.index and self.lastSelectData.cfg.index >= levelData.cfg.index then
      selected = true
    end
    levelItem:SetInfinityLvItemSelected(selected)
    if self.lastSelectData == levelData then
      self:m_MoveOnItemSelect(levelItem, levelData)
    end
    if self.bestRecordLevelData == levelData then
      self:m_MoveCurDepth(levelItem)
    end
  end
end

function UINInfinityLevelCanvas:__OnReturnItem(go)
  local levelItem = self.itemDic[go]
  if levelItem == nil then
    error("Can't find levelItem by gameObject")
    return
  end
  local levelData = levelItem.levelData
  if self.lastSelectData == levelData then
    self.ui.obj_arrows:SetActive(false)
    self.ui.obj_SelectTips.gameObject:SetActive(false)
  end
  if self.bestRecordLevelData == levelData then
    self.ui.obj_CurDepth:SetActive(false)
    self.wheel:SetArrowActive(false)
  end
end

function UINInfinityLevelCanvas:__OnValueChange(pos)
  self.wheel:RoteWheel(pos.y)
end

function UINInfinityLevelCanvas:__GetItemGoByIndex(index, isRawIndex)
  if not isRawIndex then
    index = index + 2
  end
  local go = self.ui.loopScrollRect:GetCellByIndex(index)
  if go ~= nil then
    local goodItem = self.itemDic[go]
    return goodItem
  end
  return nil
end

function UINInfinityLevelCanvas:OnclickLevelItem(levelData, levelItem)
  if levelData.isPlaceHoleder then
    return
  end
  self:_SetLvItemSelected(false)
  self.lastSelectData = levelData
  self.wheel:SetArrowActive(true)
  self:m_MoveOnItemSelect(levelItem, levelData)
  if levelData.isUnlock and not levelData.isComplete then
    local startIndex = math.floor((levelData.cfg.index - 1) / SectorEnum.InfinityGroup) * SectorEnum.InfinityGroup
    for i = startIndex, levelData.cfg.index - 1 do
      local lvData = self.levelDataList[i + 3]
      if lvData ~= nil and lvData.isUnlock and not lvData.isComplete then
        self._startSelectedIndex = i
        break
      end
    end
    self:_SetLvItemSelected(true)
  end
  AudioManager:PlayAudioById(1038)
  self:ShowLevelDetailWindow(function(win)
    levelData.bestCompleteLevelData = self.bestCompleteLevelData
    win:InitInfinityLevelDetailNode(self.sectorId, levelData)
  end)
end

function UINInfinityLevelCanvas:_SetLvItemSelected(selected)
  if self.lastSelectData == nil then
    return
  end
  local lvItem = self:__GetItemGoByIndex(self.lastSelectData.cfg.index - 1)
  if lvItem ~= nil then
    lvItem:SetInfinityLvItemSelected(selected)
  end
  if self._startSelectedIndex == nil then
    return
  end
  for index = self._startSelectedIndex, self.lastSelectData.cfg.index - 2 do
    local lvItem = self:__GetItemGoByIndex(index)
    if lvItem ~= nil then
      lvItem:SetInfinityLvItemSelected(selected)
    end
  end
end

function UINInfinityLevelCanvas:m_MoveOnItemSelect(levelItem, levelData)
  levelItem:SetInfinityLvItemSelected(true)
  self.ui.obj_arrows.transform:SetParent(levelItem.ui.obj_SelectArrowHolder.transform)
  self.ui.obj_arrows.transform.anchoredPosition = Vector2.New(0, 0)
  self.ui.obj_arrows:SetActive(true)
  if levelData.isUnlock and not levelData.isComplete then
    self.ui.obj_SelectTips:SetParent(levelItem.ui.obj_selectNode.transform)
    self.ui.obj_SelectTips.anchoredPosition = Vector2.New(0, -75)
    self.ui.obj_SelectTips.gameObject:SetActive(true)
  end
end

function UINInfinityLevelCanvas:m_MoveCurDepth(levelItem)
  self.ui.obj_CurDepth.transform:SetParent(levelItem.ui.obj_curDepthNode.transform)
  self.ui.obj_CurDepth.transform.anchoredPosition = Vector2.New(0, 0)
  self.ui.obj_CurDepth:SetActive(true)
end

function UINInfinityLevelCanvas:ShowLevelDetailWindow(callback)
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevelDetail, function(win)
    local width, duration = win:GetLevelDetailWidthAndDuration()
    win:SetLevelDetaiHideStartEvent(function()
      self.wheel:SetArrowActive(false)
      self:PlayMoveLeftTween(false, width, duration)
    end)
    self:PlayMoveLeftTween(true, width, duration)
    callback(win)
  end)
end

function UINInfinityLevelCanvas:Roll2TargetIndex(index)
  if self.bestRecordLevelData == nil then
    return
  end
  local targetIndex
  if index == nil then
    targetIndex = self.bestRecordLevelData.index - self.rollOffset
    if targetIndex < 0 then
      targetIndex = 0
    end
  elseif index < 0 or index >= self.bestRecordLevelData.index then
    error("can't roll to index " .. tostring(index))
    targetIndex = 0
  else
    targetIndex = index - self.rollOffset
  end
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
  self.ui.loopScrollRect:SrollToCell(targetIndex, 8000, function()
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    if index == nil or index == #ConfigData.endless[self.sectorId] then
      return
    end
    self.ui.loopScrollRect:RefillCells(targetIndex)
  end)
end

function UINInfinityLevelCanvas:Refill2TargetIndex(index)
  local targetIndex = index - self.rollOffset
  if targetIndex < 0 then
    targetIndex = 0
  end
  self.ui.loopScrollRect:RefillCells(targetIndex)
end

function UINInfinityLevelCanvas:PlayDiffLevelCanvasSwitchTween(isUpTween)
  self.gameObject.transform:SetAsLastSibling()
  if isUpTween then
    self.ui.switchTween:DORestart()
  else
    self.__isBackwardsTween = true
    self.ui.switchTween:DOComplete()
    self.ui.switchTween:DOPlayBackwards()
  end
  local continueWindow = UIManager:ShowWindow(UIWindowTypeID.ClickContinue)
  continueWindow:InitContinue(nil, nil, nil, Color.clear, false)
end

function UINInfinityLevelCanvas:OnSwitchTweenComplete()
  if self.__isBackwardsTween then
    return
  end
  self:OnSwitchTweenEndEvent()
end

function UINInfinityLevelCanvas:OnSwitchTweenRewind()
  if not self.__isBackwardsTween then
    return
  end
  self.__isBackwardsTween = false
  self:OnSwitchTweenEndEvent()
end

function UINInfinityLevelCanvas:OnSwitchTweenEndEvent()
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  self.ui.switchTween:DORewind()
  if self.tweenCompleteEvent ~= nil then
    self.tweenCompleteEvent()
  end
end

function UINInfinityLevelCanvas:PlayMoveLeftTween(isLeft, offset, duration)
  if self.__moveLeftTween == nil then
    local endValue = Vector2.unity_vector2(1 - offset / self.transform.rect.width, 1)
    self.__moveLeftTween = self.ui.UI_SectorLevel:DOAnchorMax(endValue, duration):SetAutoKill(false)
  end
  if self.__moveLeftTween2 == nil then
    local endValue2 = Vector2.unity_vector2(offset / self.transform.rect.width / 2, 0)
    self.__moveLeftTween2 = self.ui.ui_wheel:DOAnchorMin(endValue2, duration):SetAutoKill(false)
  end
  if isLeft then
    self.__moveLeftTween:PlayForward()
    self.__moveLeftTween2:PlayForward()
  else
    self.__moveLeftTween:PlayBackwards()
    self.__moveLeftTween2:PlayBackwards()
  end
end

function UINInfinityLevelCanvas:OnHide()
  self.ui.obj_arrows:SetActive(false)
  self.ui.obj_SelectTips.gameObject:SetActive(false)
  self.ui.obj_CurDepth:SetActive(false)
end

function UINInfinityLevelCanvas:OnDelete()
  if self.__moveLeftTween ~= nil then
    self.__moveLeftTween:Kill()
    self.__moveLeftTween = nil
  end
  if self.__moveLeftTween2 ~= nil then
    self.__moveLeftTween2:Kill()
    self.__moveLeftTween2 = nil
  end
  base.OnDelete(self)
end

return UINInfinityLevelCanvas
