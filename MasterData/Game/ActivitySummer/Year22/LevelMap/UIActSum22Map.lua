local UIActSum22Map = class("UIActSum22Map", UIBaseWindow)
local base = UIBaseWindow
local UINActSum22MapItem = require("Game.ActivitySummer.Year22.LevelMap.UINActSum22MapItem")
local UINActSum22MapSelected = require("Game.ActivitySummer.Year22.LevelMap.UINActSum22MapSelected")
local UINWAMMMapLineItem = require("Game.ActivitySectorII.MainMap.UI.LevelItem.UINWAMMMapLineItem")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local ActivitySectorIIIEnum = require("Game.ActivitySectorIII.ActivitySectorIIIEnum")
local util = require("XLua.Common.xlua_util")
local cs_LeanTouch = CS.Lean.Touch.LeanTouch
local cs_DOTween = CS.DG.Tweening.DOTween
local scaleRate = 500
local ANI_TIME = 0.5
local DIFF_VECOT3_OPEN = Vector3.New(-500, 0, 0)
local CS_UnityEngine_Time = CS.UnityEngine.Time

function UIActSum22Map:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickMapClose)
  UIUtil.AddButtonListener(self.ui.btn_Map, self, self.OnClickExitDetail)
  UIUtil.AddButtonListener(self.ui.btn_Tech, self, self._OnClickTech)
  self._levelItemPool = UIItemPool.New(UINActSum22MapItem, self.ui.baseItem)
  self.ui.baseItem:SetActive(false)
  self._lineItemPool = UIItemPool.New(UINWAMMMapLineItem, self.ui.line)
  self.ui.line:SetActive(false)
  self._selectNode = UINActSum22MapSelected.New()
  self._selectNode:Init(self.ui.selectItem)
  self._selectNode:Hide()
  self.__OnSelectLevelItemCallback = BindCallback(self, self.__OnSelectLevelItem)
  self.__OnGestureCallback = BindCallback(self, self.__OnGesture)
  self.__OnFingerUpCallback = BindCallback(self, self.__OnFingerUp)
  for k, anim in ipairs(self.ui.anim_iconList) do
    anim:get_Item(anim.clip.name).time = k * 0.75
  end
  self.__OnClickExitDetailCallback = BindCallback(self, self.OnClickExitDetail)
  MsgCenter:AddListener(eMsgEventId.GiveUncompleteExploration, self.__OnClickExitDetailCallback)
  self.__ReCalDragparamCallback = BindCallback(self, self.__ReCalDragparam)
  MsgCenter:AddListener(eMsgEventId.OnScreenSizeChanged, self.__ReCalDragparamCallback)
  self._mapItemDic = {}
  self._resLoader = CS.ResLoader.Create()
end

function UIActSum22Map:OnShow()
  base.OnShow(self)
  cs_LeanTouch.OnGesture("+", self.__OnGestureCallback)
  cs_LeanTouch.OnFingerUp("+", self.__OnFingerUpCallback)
end

function UIActSum22Map:OnHide()
  base.OnHide(self)
  cs_LeanTouch.OnGesture("-", self.__OnGestureCallback)
  cs_LeanTouch.OnFingerUp("-", self.__OnFingerUpCallback)
end

function UIActSum22Map:InitSum22MapResident(sectorId, autoSelectStageCfg, callback)
  local residentCfg = ConfigData.activity_summer_resident[sectorId]
  self.ui.residentHide:SetActive(false)
  self._scaleZoom = residentCfg.scale_zoom
  self._callback = callback
  self._autoSelectStageCfg = autoSelectStageCfg
  self:__InitDragparam()
  self._sector = sectorId
  self.ui.btn_Tech.gameObject:SetActive(false)
  if residentCfg.is_hard_open then
    self:__UnlockHardLevel()
  else
    self:_LockHardLevel()
    self.ui.countHolder:SetActive(false)
  end
  self.ui.lockHolder_main:SetActive(false)
  local SectorIIISectorLevelData = require("Game.ActivitySectorIII.SectorIIISectorLevelData")
  self._sectorStageDataList = SectorIIISectorLevelData.GenSectorIIIMapDatas(self._sector)
  self._isMoving = true
  self._delayCO = GR.StartCoroutine(util.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
    self._delayCO = nil
    self._isMoving = false
    self:__DelayDealInit()
  end))
  self:ShowSectorNameActSum22Map()
end

function UIActSum22Map:ShowSectorNameActSum22Map()
  if self.normalSectorInfoNode == nil then
    local prefab = self._resLoader:LoadABAsset(PathConsts:GetUIPrefabPath("UI_NormalSectorInfo"))
    local go = prefab:Instantiate(self.transform)
    local UINSectorInfoNormal = require("Game.Sector.SectorLevel.UINSectorInfoNormal")
    self.normalSectorInfoNode = UINSectorInfoNormal.New()
    self.normalSectorInfoNode:Init(go)
  end
  self.normalSectorInfoNode:UpdateSectorInfoNormal(ConfigData.sector[self._sector])
end

function UIActSum22Map:InitSum22Map(sum22Data, callback)
  self._sum22Data = sum22Data
  self._callback = callback
  self.ui.anim_main:Play()
  local actReddot = self._sum22Data:GetActivityReddot()
  if actReddot ~= nil then
    self._techReddot = actReddot:GetChild(ActivitySectorIIIEnum.eActRedDotTypeId.tech)
    self._UpdTechRedDotFunc = BindCallback(self, self._UpdTechRedDot)
    self:_UpdTechRedDot(self._techReddot)
    RedDotController:AddListener(self._techReddot.nodePath, self._UpdTechRedDotFunc)
  end
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self._scaleZoom = self._sum22Data:GetSectorIIIMainCfg().scale_zoom
  self:__InitDragparam()
  self._sector = self._sum22Data:GetSectorIIIMainCfg().main_sector
  self._isLockHard = false
  self._isLockMain2nd = false
  local needTimedown = false
  self._hardUnlockTime = self._sum22Data:GetSectorIIIHardOpenTime()
  self._mainNextUnlockTime = self._sum22Data:GetSectorIIIMainNextOpenTime()
  if PlayerDataCenter.timestamp < self._hardUnlockTime then
    self:_LockHardLevel()
    local timeData = TimeUtil:TimestampToDate(self._hardUnlockTime, false, true)
    self.ui.tex_DayCount:SetIndex(0, string.format("%02d", timeData.month), string.format("%02d", timeData.day), string.format("%02d", timeData.hour), string.format("%02d", timeData.min))
    self._isLockHard = true
  else
    self:__UnlockHardLevel()
  end
  if PlayerDataCenter.timestamp < self._mainNextUnlockTime then
    self.ui.lockHolder_main:SetActive(true)
    local timeData = TimeUtil:TimestampToDate(self._mainNextUnlockTime, false, true)
    self.ui.tex_DayCount_main:SetIndex(0, string.format("%02d", timeData.month), string.format("%02d", timeData.day), string.format("%02d", timeData.hour), string.format("%02d", timeData.min))
    self._isLockMain2nd = true
  else
    self.ui.lockHolder_main:SetActive(false)
  end
  self._sectorStage2nd = self._sum22Data:GetSectorIIIMainCfg().main2nd_id
  self._sectorStageDataList = self._sum22Data:GetSectorIIISectorMain()
  self._isMoving = true
  self._delayCO = GR.StartCoroutine(util.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
    self._delayCO = nil
    self._isMoving = false
    self:__DelayDealInit()
  end))
end

function UIActSum22Map:__DelayDealInit()
  self:__GenMap(true)
  if self._isInitHard or self._isInitMain2nd then
    self._timerId = TimerManager:StartTimer(1, self.__CountDownTime, self)
    self:__CountDownTime()
  end
end

function UIActSum22Map:__GenMap(isCo)
  local playMoudle = SectorStageDetailHelper.SectorPlayMoudle(self._sector)
  local _, unCompleteStageId = SectorStageDetailHelper.HasUnCompleteStage(playMoudle)
  if unCompleteStageId == nil and self._autoSelectStageCfg ~= nil then
    unCompleteStageId = self._autoSelectStageCfg.id
  end
  self._autoSelectStageCfg = nil
  local defaultSelectItem, lastStageItem
  local newUnlockStageDatas = {}
  local newUnlockIndexDatas = {}
  for index, levelData in ipairs(self._sectorStageDataList) do
    if isCo and index % 7 == 0 then
      coroutine.yield()
    end
    local oldUnlockState = levelData:GetIsLevelUnlock()
    levelData:RefreshSIILevelState()
    if self._mapItemDic[levelData] == nil then
      if levelData:GetSectroIILevelIsHard() then
      end
      local stageId = levelData:GetLevelSageId()
      if stageId ~= nil and self._sectorStage2nd and PlayerDataCenter.timestamp < self._mainNextUnlockTime and stageId >= self._sectorStage2nd then
        break
      end
      if levelData:GetIsLevelUnlock() then
        if not oldUnlockState then
          table.insert(newUnlockStageDatas, levelData)
          table.insert(newUnlockIndexDatas, index)
        else
          local item = self._levelItemPool:GetOne()
          item:InitSum22MapItem(levelData, index, self.__OnSelectLevelItemCallback)
          item.transform.localPosition = levelData:GetIsLevelPos()
          item.transform:SetParent(self.ui.levelLayer)
          self._mapItemDic[levelData] = item
          lastStageItem = item
          if unCompleteStageId ~= nil and stageId == unCompleteStageId then
            defaultSelectItem = item
          end
          if index ~= 1 and not levelData:IsSectorIIIStageIsolated() then
            local preData = self._sectorStageDataList[index - 1]
            local startPos = preData:GetIsLevelLinePos()
            local endPos = levelData:GetIsLevelLinePos()
            local line = self._lineItemPool:GetOne()
            line:InitWAMMMapLine(startPos, endPos)
            line.transform:SetParent(self.ui.lineLayer)
          end
        end
      end
    end
  end
  if 0 < #newUnlockStageDatas then
    self:__TrackLevel(newUnlockStageDatas, newUnlockIndexDatas, defaultSelectItem)
  elseif defaultSelectItem ~= nil then
    self:__ForceLevel(defaultSelectItem, true)
  elseif lastStageItem ~= nil then
    self:__ForceLevel(lastStageItem)
  end
end

function UIActSum22Map:_LockHardLevel()
  self.ui.unlockHolder:SetActive(false)
  self.ui.lockHolder:SetActive(true)
  self.ui.img_DiffcultArea:SetIndex(0)
end

function UIActSum22Map:__UnlockHardLevel()
  self.ui.lockHolder:SetActive(false)
  self.ui.unlockHolder:SetActive(true)
  self.ui.img_DiffcultArea:SetIndex(1)
end

function UIActSum22Map:__UnlockMain2nd()
  self._sectorStageDataList = self._sum22Data:GetSectorIIISectorMain()
  local sectorStage2nd = self._sum22Data:GetSectorIIIMainCfg().main2nd_id
  for index, levelData in pairs(self._sectorStageDataList) do
    levelData:RefreshSIILevelState()
    if not levelData:GetSectroIILevelIsHard() and not (sectorStage2nd > levelData:GetLevelSageId()) and levelData:GetIsLevelUnlock() then
      local item = self._levelItemPool:GetOne()
      item:InitSum22MapItem(levelData, index, self.__OnSelectLevelItemCallback)
      item.transform.localPosition = levelData:GetIsLevelPos()
      item.transform:SetParent(self.ui.levelLayer)
      self._mapItemDic[levelData] = item
      if index ~= 1 and not levelData:IsSectorIIIStageIsolated() then
        local preData = self._sectorStageDataList[index - 1]
        local startPos = preData:GetIsLevelLinePos()
        local endPos = levelData:GetIsLevelLinePos()
        local line = self._lineItemPool:GetOne()
        line:InitWAMMMapLine(startPos, endPos)
        line.transform:SetParent(self.ui.lineLayer)
      end
    end
  end
end

function UIActSum22Map:__CountDownTime()
  if self._isLockHard and PlayerDataCenter.timestamp >= self._hardUnlockTime then
    self._isLockHard = false
    self:__UnlockHardLevel()
  end
  if self._isLockMain2nd and PlayerDataCenter.timestamp >= self._mainNextUnlockTime then
    self._isLockMain2nd = false
    self:__UnlockMain2nd()
  end
  if not self._isLockHard and not self._isLockMain2nd and self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
end

function UIActSum22Map:__OnSelectLevelItem(levelData, levelItem)
  if self._isMoving or self._isDraging then
    return
  end
  local playMoudle = SectorStageDetailHelper.SectorPlayMoudle(self._sector)
  local has, unCompleteStageId = SectorStageDetailHelper.HasUnCompleteStage(playMoudle)
  if has and unCompleteStageId ~= levelData.stageId then
    SectorStageDetailHelper.TryToShowCurrentLevelTips(playMoudle)
    return
  end
  if self._selectLevelItem == levelItem then
    return
  end
  if self._selectLevelItem ~= nil then
    self._selectLevelItem:SetSum22MapItemSelectState(false)
  end
  self._selectLevelItem = levelItem
  self._selectLevelItem:SetSum22MapItemSelectState(true)
  self._selectNode:Show()
  self._selectNode:InitMapSelected(levelData)
  self._selectNode.transform.localPosition = levelItem.transform.localPosition
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevelDetail, function(win)
    if win == nil then
      return
    end
    if levelData:GetIsBattle() then
      win:InitSectorLevelDetail(self._sector, levelData:GetLevelEpStageCfg().id, not levelData:GetIsLevelUnlock())
    else
      win:InitSectorLevelAvgDetail(self._sector, levelData:GetLevelAvgCfg(), function()
        if not IsNull(self.transform) then
          levelData:RefreshSIILevelState()
          levelItem:RefreshSum22MapItemCompleteState()
          self:__GenMap()
        end
      end, not levelData:GetIsLevelUnlock())
    end
    self:__MovingWhenOpenLevel(levelItem)
    win:SetLevelDetaiHideStartEvent(function()
      if IsNull(self.transform) then
        return
      end
      self:__MovingWhenExitLevel(levelItem)
      self._selectLevelItem:SetSum22MapItemSelectState(false)
      self._selectLevelItem = nil
    end)
    win:SetLevelDetaiHideEndEvent(function()
      if IsNull(self.transform) then
        return
      end
      self._selectNode:Hide()
    end)
  end)
end

function UIActSum22Map:OnClickExitDetail()
  if not self._isDraging then
    local detailWin = UIManager:GetWindow(UIWindowTypeID.SectorLevelDetail)
    if detailWin ~= nil and detailWin.active and self._selectLevelItem ~= nil then
      UIUtil.OnClickBackByWinId(UIWindowTypeID.SectorLevelDetail)
    end
  end
end

function UIActSum22Map:_OnClickTech()
  if self._isMoving then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ActSum22StrategyMain, function(win)
    if win == nil then
      return
    end
    win:InitActSum22StrategyMain(self._sum22Data)
  end)
end

function UIActSum22Map:_UpdTechRedDot(node)
  self.ui.techBlueDot:SetActive(node:GetRedDotCount() > 0)
end

function UIActSum22Map:__MovingWhenExitLevel(levelItem)
  if self._movingTween ~= nil then
    self._movingTween:Kill()
    self._movingTween = nil
  end
  self._isMoving = true
  self._movingTween = cs_DOTween.Sequence()
  self._movingTween:Append(self.ui.map_parent:DOLocalMove(Vector3.zero, ANI_TIME))
  self._movingTween:AppendCallback(function()
    self._isMoving = false
    self._movingTween = nil
  end)
  self._movingTween:SetAutoKill(true)
end

function UIActSum22Map:__MovingWhenOpenLevel(levelItem)
  if self._movingTween ~= nil then
    self._movingTween:Kill()
    self._movingTween = nil
  end
  self._isMoving = true
  local targetPos = self:__GetCenterPos(levelItem)
  self._movingTween = cs_DOTween.Sequence()
  self._movingTween:Append(self.ui.map:DOLocalMove(targetPos, ANI_TIME))
  self._movingTween:Join(self.ui.map_parent:DOLocalMove(DIFF_VECOT3_OPEN, ANI_TIME))
  self._movingTween:AppendCallback(function()
    self._isMoving = false
    self._movingTween = nil
  end)
  self._movingTween:SetAutoKill(true)
end

function UIActSum22Map:__ForceLevel(levelItem, isOpen)
  if self._movingTween ~= nil then
    self._movingTween:Kill()
    self._movingTween = nil
  end
  self._isMoving = true
  local targetPos = self:__GetCenterPos(levelItem)
  self._movingTween = cs_DOTween.Sequence()
  self._movingTween:Append(self.ui.map:DOLocalMove(targetPos, ANI_TIME))
  self._movingTween:AppendCallback(function()
    self._isMoving = false
    self._movingTween = nil
    if isOpen then
      self:__OnSelectLevelItem(levelItem:GetSum22SectorLevelData(), levelItem)
    end
  end)
  self._movingTween:SetAutoKill(true)
end

function UIActSum22Map:__TrackLevel(newUnlockStageDatas, newUnlockIndexDatas, defaultSelectItem)
  if self._movingTween ~= nil then
    self._movingTween:Kill()
    self._movingTween = nil
  end
  self._isMoving = true
  self._movingTween = cs_DOTween.Sequence()
  local curScale = self._scaleLimitSize[2]
  local lastScaleSize = self.ui.map.localScale
  self.ui.map.localScale = Vector3.New(curScale, curScale, curScale)
  self:__CalLimitDragRange(curScale)
  local pos = self:__GetMapCorrectPos(self.ui.map.localPosition)
  self.ui.map.localPosition = pos
  for i, levelData in ipairs(newUnlockStageDatas) do
    local index = newUnlockIndexDatas[i]
    local item = self._levelItemPool:GetOne()
    item:InitSum22MapItem(levelData, index, self.__OnSelectLevelItemCallback)
    item.transform.localPosition = levelData:GetIsLevelPos()
    item.transform:SetParent(self.ui.levelLayer)
    item:Hide()
    self._mapItemDic[levelData] = item
    local targetPos = self:__GetCenterPos(item)
    self._movingTween:Append(self.ui.map:DOLocalMove(targetPos, ANI_TIME))
    self._movingTween:AppendCallback(function()
      item:Show()
    end)
    self._movingTween:AppendInterval(ANI_TIME)
    if 1 < index and not levelData:IsSectorIIIStageIsolated() then
      self._movingTween:AppendCallback(function()
        local preData = self._sectorStageDataList[index - 1]
        local startPos = preData:GetIsLevelLinePos()
        local endPos = levelData:GetIsLevelLinePos()
        local line = self._lineItemPool:GetOne()
        line:InitWAMMMapLine(startPos, endPos)
        line.transform:SetParent(self.ui.lineLayer)
      end)
      self._movingTween:AppendInterval(ANI_TIME * 3)
    end
  end
  self._movingTween:AppendCallback(function()
    local time = CS_UnityEngine_Time.time
    
    local function coFunc()
      while true do
        coroutine.yield(nil)
        local diff = CS_UnityEngine_Time.time - time
        if diff >= ANI_TIME then
          self.ui.map.localScale = lastScaleSize
          self:__CalLimitDragRange(lastScaleSize.x)
          local pos = self:__GetMapCorrectPos(self.ui.map.localPosition)
          self.ui.map.localPosition = pos
          break
        end
        local scale = curScale - (curScale - lastScaleSize.x) * (diff / ANI_TIME)
        self.ui.map.localScale = Vector3.New(scale, scale, scale)
        self:__CalLimitDragRange(scale)
        local pos = self:__GetMapCorrectPos(self.ui.map.localPosition)
        self.ui.map.localPosition = pos
      end
      self._coFunc = nil
      self._isMoving = false
      self._movingTween = nil
      if defaultSelectItem ~= nil then
        self:__ForceLevel(defaultSelectItem, true)
      end
    end
    
    self._coFunc = GR.StartCoroutine(util.cs_generator(coFunc))
  end)
end

function UIActSum22Map:__GetCenterPos(levelItem)
  local targetPos = self.ui.map.parent:InverseTransformPoint(levelItem.transform.position)
  targetPos = Vector3.New(self.ui.map.transform.localPosition.x - targetPos.x, self.ui.map.transform.localPosition.y - targetPos.y, 0)
  targetPos = self:__GetMapCorrectPos(targetPos)
  return targetPos
end

function UIActSum22Map:__InitDragparam()
  local xMap = self.ui.map.rect.width
  local yMap = self.ui.map.rect.height
  self._defaultMapSize = {xMap, yMap}
  local BackgroundStretchSize = UIManager.BackgroundStretchSize
  local scaleLimitMin = math.max(BackgroundStretchSize.x / xMap, BackgroundStretchSize.y / yMap, self._scaleZoom[2])
  self._scaleLimitSize = {
    scaleLimitMin,
    math.max(scaleLimitMin, self._scaleZoom[1])
  }
  local curScale = self._scaleZoom[3]
  curScale = math.clamp(curScale, self._scaleLimitSize[1], self._scaleLimitSize[2])
  self.ui.map.localScale = Vector3.New(curScale, curScale, curScale)
  self:__CalLimitDragRange(curScale)
end

function UIActSum22Map:__ReCalDragparam()
  local xMap = self._defaultMapSize[1]
  local yMap = self._defaultMapSize[2]
  local BackgroundStretchSize = UIManager.BackgroundStretchSize
  local scaleLimitMin = math.max(BackgroundStretchSize.x / xMap, BackgroundStretchSize.y / yMap, self._scaleZoom[2])
  self._scaleLimitSize = {
    scaleLimitMin,
    math.max(scaleLimitMin, self._scaleZoom[1])
  }
  self:__CalLimitDragRange(self.ui.map.localScale.x)
  local pos = self:__GetMapCorrectPos(self.ui.map.localPosition)
  self.ui.map.localPosition = pos
end

function UIActSum22Map:__CalLimitDragRange(scale)
  local BackgroundStretchSize = UIManager.BackgroundStretchSize
  if self._dragLimitRange == nil then
    self._dragLimitRange = {}
  end
  self._dragLimitRange[1] = math.max(0, (self._defaultMapSize[1] * scale - BackgroundStretchSize.x) / 2)
  self._dragLimitRange[2] = math.max(0, (self._defaultMapSize[2] * scale - BackgroundStretchSize.y) / 2)
end

function UIActSum22Map:__GetMapCorrectPos(pos)
  pos.x = math.clamp(pos.x, -self._dragLimitRange[1], self._dragLimitRange[1])
  pos.y = math.clamp(pos.y, -self._dragLimitRange[2], self._dragLimitRange[2])
  return pos
end

function UIActSum22Map:__OnGesture(fingerList)
  if self._isMoving then
    return
  end
  local result = cs_LeanTouch.RaycastGui(fingerList[0].ScreenPosition)
  if result.Count == 0 or not result[0].gameObject.transform:IsChildOf(self.ui.map) then
    return
  end
  if Vector2.Distance(fingerList[0].ScreenPosition, fingerList[0].LastScreenPosition) < 1.0E-4 then
    return
  end
  if fingerList.Count == 1 then
    local finger = fingerList[0]
    if not self._isDraging and Vector2.Distance(finger.StartScreenPosition, finger.ScreenPosition) > 30 then
      self._isDraging = true
    end
    self:__OnMoveMap(finger)
  elseif fingerList.Count == 2 then
    self._isDraging = true
    self:__OnScaleMap(fingerList[0], fingerList[1])
  end
end

function UIActSum22Map:__OnFingerUp()
  self._isDraging = false
end

function UIActSum22Map:__OnMoveMap(touch)
  local diffPos = touch.ScreenPosition - touch.LastScreenPosition
  diffPos = Vector3.New(diffPos.x, diffPos.y, 0)
  local targetPos = self.ui.map.localPosition + diffPos
  local targetPos = self:__GetMapCorrectPos(targetPos)
  self.ui.map.localPosition = targetPos
end

function UIActSum22Map:__OnScaleMap(touch1, touch2)
  local lastDiffX = touch1.LastScreenPosition.x - touch2.LastScreenPosition.x
  local lastDiffY = touch1.LastScreenPosition.y - touch2.LastScreenPosition.y
  local curDiffX = touch1.ScreenPosition.x - touch2.ScreenPosition.x
  local curDiffY = touch1.ScreenPosition.y - touch2.ScreenPosition.y
  local diff = math.sqrt(curDiffX ^ 2 + curDiffY ^ 2) - math.sqrt(lastDiffX ^ 2 + lastDiffY ^ 2)
  local lastScale = self.ui.map.localScale.x
  local scale = math.clamp(lastScale + diff / scaleRate, self._scaleLimitSize[1], self._scaleLimitSize[2])
  if scale == lastScale then
    return
  end
  self.ui.map.localScale = Vector3.New(scale, scale, scale)
  self:__CalLimitDragRange(scale)
  local pos = self:__GetMapCorrectPos(self.ui.map.localPosition)
  self.ui.map.localPosition = pos
end

function UIActSum22Map:OnClickMapClose(isToHome)
  UIManager:DeleteWindow(UIWindowTypeID.SectorLevelDetail)
  self:Delete()
  if self._callback ~= nil then
    self._callback(isToHome)
  end
end

function UIActSum22Map:OnDelete()
  if self._techReddot ~= nil then
    RedDotController:RemoveListener(self._techReddot.nodePath, self._UpdTechRedDotFunc)
  end
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  if self.normalSectorInfoNode ~= nil then
    self.normalSectorInfoNode:Delete()
  end
  MsgCenter:RemoveListener(eMsgEventId.GiveUncompleteExploration, self.__OnClickExitDetailCallback)
  MsgCenter:RemoveListener(eMsgEventId.OnScreenSizeChanged, self.__ReCalDragparamCallback)
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  if self._movingTween ~= nil then
    self._movingTween:Kill()
    self._movingTween = nil
  end
  if self._delayCO ~= nil then
    GR.StopCoroutine(self._delayCO)
    self._delayCO = nil
  end
  if self._coFunc ~= nil then
    GR.StopCoroutine(self._coFunc)
    self._coFunc = nil
  end
  base.OnDelete(self)
end

return UIActSum22Map
