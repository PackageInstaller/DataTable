local ThrowGiftsLevelCtrl = class("ThrowGiftsLevelCtrl", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local nMarkWidth = 36
local nMarkHeight = 56
ThrowGiftsLevelCtrl._mapNodeConfig = {
  Scene = {sComponentName = "Transform"},
  rtScene = {
    sNodeName = "Scene",
    sComponentName = "RectTransform"
  },
  rtGoalRoot = {sComponentName = "Transform"},
  rtObstacleRoot = {sComponentName = "Transform"},
  rtSpecialObstacleRoot = {sComponentName = "Transform"},
  rtBeginning = {
    sComponentName = "RectTransform"
  },
  rttBeginningDrag = {
    sComponentName = "UIDrag",
    callback = "OnDrag_Beginning"
  },
  rtBeginningLine = {
    sComponentName = "RectTransform"
  },
  rtPenguinRoot = {sComponentName = "Transform"},
  BeginningDot = {
    sComponentName = "RectTransform",
    sNodeName = "imgBeginningDot_",
    nCount = 30
  },
  templateBullet = {},
  rtBeginningPos = {
    sComponentName = "RectTransform"
  },
  rtBottle = {
    sComponentName = "RectTransform"
  },
  rtBottleAnim = {sComponentName = "Animator", sNodeName = "rtBottle"},
  BeginningPenguinRoot = {sComponentName = "Animator"},
  rtBlindLevelTrack = {
    sCtrlName = "Game.UI.Activity.ThrowGifts.ThrowGiftLevelTrackLineCtrl"
  },
  rtTemplateTrack = {},
  TMPBeginningCountHint = {sComponentName = "TMP_Text"},
  imgBeginningHint = {},
  rtPenguinBeginningHint = {sComponentName = "Transform"},
  rtPenguinBeginningHintAnim = {
    sNodeName = "rtPenguinBeginningHint",
    sComponentName = "Animator"
  },
  imgInfinite = {},
  penguinRoot = {},
  rtTemplateGuideTrack = {},
  goBeginningMark = {},
  rtBeginningMark = {
    sComponentName = "RectTransform"
  },
  rtDebug = {}
}
ThrowGiftsLevelCtrl._mapEventConfig = {}
ThrowGiftsLevelCtrl._mapRedDotConfig = {}

function ThrowGiftsLevelCtrl:Awake()
  self.bDebugMode = false
  self.curGiftPenguin = nil
  self.nLevelType = 0
  self.tbObstacle = {}
  self.mapGoal = {}
  self.tbGiftPenguin = {}
  self.sceneSize = {0, 0}
  self.scenePivot = {0, 0}
  self.mapItemPoolConfig = {}
  self.activeGoal = {}
  self.nTotalPenguinCount = -1
  self.curPenguinIdx = 1
  self.curPenguinType = 1
  self.nNextPenguinType = 1
  self.curPenguinSpecialType = 0
  self.defaultPenguinSpecialType = 0
  self.nLevelTime = -1
  self.nLevelScore = 0
  self.nTotalThrowGiftCount = 0
  self.nTotalHitGoalCount = 0
  self.nTotalUseItemCount = 0
  self.mapItemUseCount = {}
  self.bProcessing = false
  self.mapExObstacleOrigin = {}
  self.tbExObstacleCur = {}
  self.bFlying = false
  self.nFlyingTime = 0
  self.maxVelocity = 1200
  self.minVelovity = 400
  self.nLinePointInterval = 0.05
  self.nGoalSpeed = 100
  self.nAngelMax = 90
  self.nAngleMin = -30
  self.nAG = 500
  self.nNavigationPenguinSpeed = 600
  self.nCurActiveItem = 0
  self.mapCurActiveState = {}
  self.tbItemTrackCtrl = {}
  self.tbGuideTrackCtrl = {}
  self.curDragBeginPos = nil
  self.dragState = false
  self._mapNode.rtBeginningLine.gameObject:SetActive(false)
  self._mapNode.templateBullet.gameObject:SetActive(false)
  self._mapNode.imgBeginningHint:SetActive(false)
  
  local function forEachItemPool(mapData)
    if self.mapItemPoolConfig[mapData.PoolId] == nil then
      self.mapItemPoolConfig[mapData.PoolId] = {}
    end
    table.insert(self.mapItemPoolConfig[mapData.PoolId], {
      nItemId = mapData.ItemId,
      Weight = mapData.Weight
    })
  end
  
  ForEachTableLine(DataTable.ThrowGiftItemPool, forEachItemPool)
end

function ThrowGiftsLevelCtrl:FadeIn()
end

function ThrowGiftsLevelCtrl:FadeOut()
end

function ThrowGiftsLevelCtrl:OnEnable()
  self.rootPath = self._panel._rootPath
  EventManager.Hit("ThrowGiftSetSpeacialFunc", self)
  self._mapNode.BeginningPenguinRoot.gameObject:SetActive(false)
  self._mapNode.penguinRoot:SetActive(false)
  self._mapNode.rtBottleAnim:Play("rtBottle_Empty")
  self._mapNode.goBeginningMark:SetActive(false)
end

function ThrowGiftsLevelCtrl:OnDisable()
  if self.beginningTweener ~= nil then
    self.beginningTweener:Kill()
    self.beginningTweener = nil
  end
  if self.mapUpdateTimer ~= nil then
    self.mapUpdateTimer:Cancel()
    self.mapUpdateTimer = nil
  end
  self:ClearTrackLine()
  if self.tbGuideTrackCtrl ~= nil and #self.tbGuideTrackCtrl ~= 0 then
    self:ClearGuideLine()
  end
end

function ThrowGiftsLevelCtrl:OnDestroy()
end

function ThrowGiftsLevelCtrl:OnRelease()
end

function ThrowGiftsLevelCtrl:ClearTrackLine()
  for _, mapCtrl in ipairs(self.tbItemTrackCtrl) do
    mapCtrl:DestroyAll()
    self:UnbindCtrlByNode(mapCtrl)
  end
  self._mapNode.rtBlindLevelTrack:DestroyAll()
  self.tbItemTrackCtrl = {}
end

function ThrowGiftsLevelCtrl:ClearGuideLine()
  for _, mapCtrl in ipairs(self.tbGuideTrackCtrl) do
    mapCtrl:DestroyAll()
    self:UnbindCtrlByNode(mapCtrl)
  end
  self.tbGuideTrackCtrl = {}
end

function ThrowGiftsLevelCtrl:SetLevel(parent, nLevelId, mapActData)
  self.nLevelScore = 0
  self.parent = parent
  self.actData = mapActData
  self.nLevelId = nLevelId
  self.mapItemUseCount = {}
  local mapLevelCfgData = ConfigTable.GetData("ThrowGiftLevel", nLevelId)
  if mapLevelCfgData == nil then
    return
  end
  self.mapLevelCfgData = mapLevelCfgData
  local mapFloorCfgData = ConfigTable.GetData("ThrowGiftFloor", self.mapLevelCfgData.FloorId)
  if mapFloorCfgData == nil then
    return
  end
  self.defaultPenguinSpecialType = self.mapLevelCfgData.DefaultPenguinItemId
  self.maxVelocity = mapFloorCfgData.SpeedMax
  self.minVelovity = mapFloorCfgData.SpeedMin
  self.nAngleMin = mapFloorCfgData.AngelMin
  self.nAG = mapFloorCfgData.Gravity
  if self.mapLevelCfgData.FlightPath == true then
    self._mapNode.rtBlindLevelTrack.gameObject:SetActive(true)
  end
  self.mapFloorCfgData = mapFloorCfgData
  self.nTotalPenguinCount = self.mapFloorCfgData.GiftNum
  if self.nTotalPenguinCount == 0 then
    self.nTotalPenguinCount = -1
  end
  self.nLevelTime = self.mapLevelCfgData.CountDownLimit
  if self.nLevelTime == 0 then
    self.nLevelTime = -1
  end
  self.curPenguinIdx = 1
  self.sceneSize = {
    self._mapNode.Scene.rect.width,
    self._mapNode.Scene.rect.height
  }
  self.scenePivot = {
    self._mapNode.Scene.pivot.x,
    self._mapNode.Scene.pivot.y
  }
  local rtView = self.gameObject:GetComponent("RectTransform")
  self.viewSize = {0, 0}
  if rtView ~= nil then
    self.viewSize = {
      rtView.rect.width,
      rtView.rect.height
    }
  end
  self._mapNode.rtDebug:SetActive(self.bDebugMode)
  local nStaticChildCount = self._mapNode.rtObstacleRoot.childCount
  for i = 0, nStaticChildCount - 1 do
    local goObstacle = self._mapNode.rtObstacleRoot:GetChild(i)
    if goObstacle ~= nil then
      local rtObstacle = goObstacle:GetComponent("RectTransform")
      if rtObstacle ~= nil then
        local tbBounds = self:GetLocalSpaceRect(rtObstacle, rtObstacle.parent)
        table.insert(self.tbObstacle, tbBounds)
        print(tbBounds[1] .. " " .. tbBounds[2] .. " " .. tbBounds[3] .. " " .. tbBounds[4] .. " ")
      end
    end
  end
  local nSpecialChildCount = self._mapNode.rtSpecialObstacleRoot.childCount
  for i = 0, nSpecialChildCount - 1 do
    local goObstacle = self._mapNode.rtSpecialObstacleRoot:GetChild(i)
    if goObstacle ~= nil then
      local rtObstacle = goObstacle:GetComponent("RectTransform")
      if rtObstacle ~= nil then
        local sName = rtObstacle.gameObject.name
        local nId = tonumber(sName)
        if nId == nil then
          printError("Special obstacl name error!" .. sName)
        else
          local mapExObstacleCfgData = ConfigTable.GetData("ThrowGiftSpecialObstacle", nId)
          if mapExObstacleCfgData ~= nil then
            local nInstanceId = rtObstacle.gameObject:GetInstanceID()
            self.mapExObstacleOrigin[nInstanceId] = {}
            local tbBounds = self:GetLocalSpaceRect(rtObstacle, rtObstacle.parent)
            self.mapExObstacleOrigin[nInstanceId].tbBounds = tbBounds
            self.mapExObstacleOrigin[nInstanceId].mapConfig = mapExObstacleCfgData
            self.mapExObstacleOrigin[nInstanceId].gameObject = rtObstacle.gameObject
            table.insert(self.tbExObstacleCur, nInstanceId)
            print(tbBounds[1] .. " " .. tbBounds[2] .. " " .. tbBounds[3] .. " " .. tbBounds[4] .. " ")
          end
        end
      end
    end
  end
  local nGoalSpawnpointCount = self._mapNode.rtGoalRoot.childCount
  for i = 0, nGoalSpawnpointCount - 1 do
    local goGoalSpawnpoint = self._mapNode.rtGoalRoot:GetChild(i)
    if goGoalSpawnpoint ~= nil then
      local sName = goGoalSpawnpoint.gameObject.name
      local nId = tonumber(sName)
      if nId == nil then
        printError("配置错误 无法转换为ID:" .. sName)
      else
        local mapSpConfig = ConfigTable.GetData("ThrowGiftSpawnPoints", nId)
        if mapSpConfig ~= nil then
          self.mapGoal[nId] = {}
          self.mapGoal[nId].rtPoint = goGoalSpawnpoint
          self.mapGoal[nId].mapConfig = mapSpConfig
          self.mapGoal[nId].tbExtractedItems = {}
          local nItemPoolId = mapSpConfig.ItemPool
          self.mapGoal[nId].tbOrginPool = self.mapItemPoolConfig[nItemPoolId] == nil and {} or clone(self.mapItemPoolConfig[nItemPoolId])
          self.mapGoal[nId].curCondId = {}
          self.mapGoal[nId].nCurGoalIdx = 1
          self.mapGoal[nId].VxDir = 1
          self.mapGoal[nId].VyDir = 1
        end
      end
    end
  end
  for nSpawnPointId, mapConfigData in pairs(self.mapGoal) do
    if mapConfigData.mapConfig.InitShow then
      self:CreateGoal(nSpawnPointId, mapConfigData)
    end
  end
  if self.mapUpdateTimer ~= nil then
    self.mapUpdateTimer:Cancel()
    self.mapUpdateTimer = nil
  end
  self.mapUpdateTimer = self:AddTimer(0, 0, "OnUpdate", true, true, true)
  if 0 < #mapFloorCfgData.GuideLine then
    for _, nGuideLineId in ipairs(mapFloorCfgData.GuideLine) do
      local mapGuideLineData = ConfigTable.GetData("ThrowGiftGuideLine", nGuideLineId)
      if mapGuideLineData ~= nil then
        local rtTrack = instantiate(self._mapNode.rtTemplateGuideTrack, self._mapNode.rtScene)
        rtTrack.transform:SetAsFirstSibling()
        rtTrack:SetActive(true)
        local mapTrackCtrl = self:BindCtrlByNode(rtTrack.gameObject, "Game.UI.Activity.ThrowGifts.ThrowGiftLevelGuideTrackLineCtrl")
        mapTrackCtrl:InitLine(mapGuideLineData, self._mapNode.rtBeginning.anchoredPosition, self.nAG, self.maxVelocity)
        table.insert(self.tbGuideTrackCtrl, mapTrackCtrl)
      end
    end
  end
end

function ThrowGiftsLevelCtrl:FlyOver(nDelayTime, tbHitGoalId)
  self.nLevelType = 0
  self.bProcessing = true
  
  local function waitAnim()
    if self.mapLevelCfgData.ThrowGiftLevelCond == GameEnum.ThrowGiftLevelCond.ThrowCount or self.mapLevelCfgData.ThrowGiftLevelCond == GameEnum.ThrowGiftLevelCond.ThrowCountAfterTime then
      self.parent:SetTarget(self.nTotalThrowGiftCount)
    elseif self.mapLevelCfgData.ThrowGiftLevelCond == GameEnum.ThrowGiftLevelCond.Score or self.mapLevelCfgData.ThrowGiftLevelCond == GameEnum.ThrowGiftLevelCond.ScoreAfterTime then
      self.parent:SetTarget(self.nLevelScore)
    elseif self.mapLevelCfgData.ThrowGiftLevelCond == GameEnum.ThrowGiftLevelCond.HitCount or self.mapLevelCfgData.ThrowGiftLevelCond == GameEnum.ThrowGiftLevelCond.HitCountAfterTime then
      self.parent:SetTarget(self.nTotalHitGoalCount)
    end
    if self.mapLevelCfgData.ThrowGiftLevelCond == GameEnum.ThrowGiftLevelCond.ThrowCount then
      self.parent:SetTarget(self.nTotalThrowGiftCount)
      if self.nTotalThrowGiftCount >= self.mapLevelCfgData.throwGiftLevelParams then
        self:LevelEnd(true, 0)
        return
      end
    elseif self.mapLevelCfgData.ThrowGiftLevelCond == GameEnum.ThrowGiftLevelCond.Score then
      self.parent:SetTarget(self.nLevelScore)
      if self.nLevelScore >= self.mapLevelCfgData.throwGiftLevelParams then
        self:LevelEnd(true, 0)
        return
      end
    elseif self.mapLevelCfgData.ThrowGiftLevelCond == GameEnum.ThrowGiftLevelCond.HitCount then
      self.parent:SetTarget(self.nTotalHitGoalCount)
      if self.nTotalHitGoalCount >= self.mapLevelCfgData.throwGiftLevelParams then
        self:LevelEnd(true, 0)
        return
      end
    end
    if self.nTotalPenguinCount ~= 0 then
      self.beginningTweener = DOTween.To(function()
        return self._mapNode.rtBottle.localEulerAngles.z - 360
      end, function(v)
        self._mapNode.rtBottle.localEulerAngles = Vector3(0, 0, v)
      end, 0, 0.5):OnComplete(function()
        self:SetBeginningAngle(0, 0)
        NovaAPI.SetTMPText(self._mapNode.TMPBeginningCountHint, self.nTotalPenguinCount)
        if self.curPenguinIdx > #self.mapFloorCfgData.InitialGiftSort then
          if 0 < #self.mapFloorCfgData.GiftRandom then
            self.curPenguinType = self.nNextPenguinType
          else
            self.curPenguinType = 1
          end
        else
          self.curPenguinType = self.mapFloorCfgData.InitialGiftSort[self.curPenguinIdx]
        end
        self.curPenguinIdx = self.curPenguinIdx + 1
        self._mapNode.BeginningPenguinRoot.gameObject:SetActive(true)
        self._mapNode.rtBottleAnim:Play("rtBottle_in")
        self._mapNode.BeginningPenguinRoot:Play("penguinRoot_jump")
        WwiseAudioMgr:PostEvent("Mode_Present_shylock_jump")
        local nSpecialType = self.curPenguinSpecialType == 0 and self.defaultPenguinSpecialType or self.curPenguinSpecialType
        self:SetPenguinType(self._mapNode.BeginningPenguinRoot.transform, self.curPenguinType, nSpecialType)
        self:SetPenguinType(self._mapNode.rtBottle:Find("AnimRoot/penguinRoot"), self.curPenguinType, nSpecialType)
        self:SetBeginningAngle(0, 0)
        
        local function wait()
          self._mapNode.imgBeginningHint:SetActive(true)
          local nCurSpecialType = self.curPenguinSpecialType == 0 and self.defaultPenguinSpecialType or self.curPenguinSpecialType
          self:SetPenguinType(self._mapNode.rtPenguinBeginningHint, self.curPenguinType, nCurSpecialType)
          if self.nTotalPenguinCount ~= 0 then
            self._mapNode.BeginningPenguinRoot.gameObject:SetActive(true)
            self._mapNode.BeginningPenguinRoot:Play("penguinRoot_in")
            WwiseAudioMgr:PostEvent("Mode_Present_shylock")
            self.nNextPenguinType = 1
            if self.curPenguinIdx > #self.mapFloorCfgData.InitialGiftSort then
              if 0 < #self.mapFloorCfgData.GiftRandom then
                self.nNextPenguinType = self.mapFloorCfgData.GiftRandom[math.random(#self.mapFloorCfgData.GiftRandom)]
              else
                self.nNextPenguinType = 1
              end
            else
              self.nNextPenguinType = self.mapFloorCfgData.InitialGiftSort[self.curPenguinIdx]
            end
            self:SetPenguinType(self._mapNode.BeginningPenguinRoot.transform, self.nNextPenguinType, self.defaultPenguinSpecialType)
          else
            self._mapNode.BeginningPenguinRoot.gameObject:SetActive(false)
          end
        end
        
        local function waitAnimEnd()
          self.nLevelType = 1
          if self.mapLevelCfgData.SwitchArrow == true then
            self.parent:SetViewBtn(1)
          end
        end
        
        self:AddTimer(1, 0.5, wait, true, true, true)
        self:AddTimer(1, 1, waitAnimEnd, true, true, true)
      end)
    else
      self._mapNode.BeginningPenguinRoot.gameObject:SetActive(false)
      self:LevelEnd(false, 1)
      return
    end
    local bNeedProcessingItem = false
    if tbHitGoalId ~= nil and 0 < #tbHitGoalId then
      local tbItemsRandom = {}
      local tbSpawnPointData = {}
      for _, HitGoalId in ipairs(tbHitGoalId) do
        local mapSpawnPointData = self.mapGoal[HitGoalId]
        if mapSpawnPointData ~= nil and 0 < #mapSpawnPointData.tbOrginPool then
          local tbCurPool = {}
          if mapSpawnPointData.mapConfig.PoolType then
            for _, mapItemData in ipairs(mapSpawnPointData.tbOrginPool) do
              if 1 > table.indexof(mapSpawnPointData.tbExtractedItems, mapItemData.nItemId) then
                table.insert(tbCurPool, mapItemData)
              end
            end
            if #tbCurPool < 2 then
              tbCurPool = {}
              mapSpawnPointData.tbExtractedItems = {}
              for _, mapItemData in ipairs(mapSpawnPointData.tbOrginPool) do
                table.insert(tbCurPool, mapItemData)
              end
            end
          else
            for _, mapItemData in ipairs(mapSpawnPointData.tbOrginPool) do
              table.insert(tbCurPool, mapItemData)
            end
          end
          local tbItems = {}
          for i = 1, 2 do
            local selected = 0
            local totalWeight = 0
            for _, mapItemData in ipairs(tbCurPool) do
              totalWeight = totalWeight + mapItemData.Weight
            end
            local random = math.random(0, totalWeight)
            local curWeight = 0
            for nIdx, mapItemData in ipairs(tbCurPool) do
              curWeight = curWeight + mapItemData.Weight
              if random <= curWeight then
                table.insert(tbItems, mapItemData.nItemId)
                selected = nIdx
                break
              end
            end
            table.remove(tbCurPool, selected)
          end
          if 0 < #tbItems then
            table.insert(tbItemsRandom, tbItems)
            table.insert(tbSpawnPointData, mapSpawnPointData)
          end
        end
      end
      if 0 < #tbItemsRandom then
        do
          local function callback(tbIdx)
            self:Pause(false)
            
            self.bProcessing = false
            for i = 1, #tbItemsRandom do
              local nIdx = tbIdx[i]
              local mapSpawnPointData = tbSpawnPointData[i]
              if mapSpawnPointData ~= nil and mapSpawnPointData.mapConfig.PoolType then
                table.insert(mapSpawnPointData.tbExtractedItems, tbItemsRandom[i][nIdx])
              end
            end
          end
          
          bNeedProcessingItem = true
          self.parent:OpenItemSelect(tbItemsRandom, callback)
          self:Pause(true)
        end
      end
    end
    if not bNeedProcessingItem then
      self.bProcessing = false
    end
    local rtScenePos = self._mapNode.rtScene.anchoredPosition
    self._mapNode.rtScene.anchoredPosition = Vector2(0, rtScenePos.y)
    for nInstanceId, mapConfig in pairs(self.mapExObstacleOrigin) do
      if mapConfig.mapConfig.Reset and table.indexof(self.tbExObstacleCur, nInstanceId) < 1 then
        table.insert(self.tbExObstacleCur, nInstanceId)
        mapConfig.gameObject:SetActive(true)
      end
    end
  end
  
  if nDelayTime == nil or nDelayTime == 0 then
    waitAnim()
  else
    self:AddTimer(1, nDelayTime, waitAnim, true, true, true)
  end
end

function ThrowGiftsLevelCtrl:LevelEnd(bPass, nCond)
  if self.mapUpdateTimer ~= nil then
    self.mapUpdateTimer:Cancel()
    self.mapUpdateTimer = nil
  end
  self.parent:LevelEnd()
  local bShowPenguin = false
  if bPass and self.mapFloorCfgData.GiftNum > 0 then
    self.nLevelScore = self.nLevelScore + 20 * math.max(0, self.nTotalPenguinCount)
    bShowPenguin = true
  end
  
  local function openSettle(changeInfo)
    self.parent:OpenSettle(bPass, self.nLevelScore, self.nTotalHitGoalCount, self.nTotalPenguinCount, bShowPenguin, changeInfo)
  end
  
  if self.actData ~= nil then
    local tbUseItems = {}
    for nItemId, nCount in pairs(self.mapItemUseCount) do
      table.insert(tbUseItems, {ItemId = nItemId, Count = nCount})
    end
    self.actData:SettleLevels(self.nLevelId, self.nTotalThrowGiftCount, self.nTotalHitGoalCount, self.nLevelScore, tbUseItems, bPass, openSettle)
  else
    openSettle()
  end
end

function ThrowGiftsLevelCtrl:Pause(bPause)
  if bPause then
    WwiseAudioMgr:PostEvent("Mode_Present_sidechain_in")
  else
    WwiseAudioMgr:PostEvent("Mode_Present_sidechain_out")
  end
  if self.mapUpdateTimer ~= nil then
    self.mapUpdateTimer:Pause(bPause)
  end
end

function ThrowGiftsLevelCtrl:ActiveItem(nItemId)
  if self.mapItemUseCount[nItemId] == nil then
    self.mapItemUseCount[nItemId] = 0
  end
  self.mapItemUseCount[nItemId] = self.mapItemUseCount[nItemId] + 1
  if nItemId == 101 then
    if 0 < self.nLevelTime then
      self.nLevelTime = self.nLevelTime + 11
      self.parent:AddTimeAnim()
      WwiseAudioMgr:PostEvent("Mode_Present_prop_overtime")
    end
  elseif 106 <= nItemId and nItemId <= 110 then
    self.curPenguinSpecialType = nItemId
    self._mapNode.rtPenguinBeginningHintAnim:Play("imgBeginningHint_in")
    if not self.bFlying and (self.nLevelType == 1 or self.nLevelType == 3) then
      if nItemId == 108 then
        WwiseAudioMgr:PostEvent("Mode_Present_prop_anteena")
      elseif nItemId == 109 then
        WwiseAudioMgr:PostEvent("Mode_Present_prop_spring")
      elseif nItemId == 110 then
        WwiseAudioMgr:PostEvent("Mode_Present_prop_magic")
      else
        WwiseAudioMgr:PostEvent("Mode_Present_prop_gear")
      end
      self:SetPenguinType(self._mapNode.rtBottle:Find("AnimRoot/penguinRoot"), self.curPenguinType, nItemId)
      self:SetPenguinType(self._mapNode.rtPenguinBeginningHint, self.curPenguinType, nItemId)
      self._mapNode.rtBottleAnim:Play("rtBottle_switch")
      self._mapNode.rtPenguinBeginningHintAnim:Play("imgBeginningHint_in")
    else
      self:SetPenguinType(self._mapNode.rtPenguinBeginningHint, self.curPenguinType, nItemId)
      self:SetPenguinType(self._mapNode.BeginningPenguinRoot.transform, self.curPenguinType, nItemId)
      self:SetPenguinType(self._mapNode.rtBottle:Find("AnimRoot/penguinRoot"), self.curPenguinType, nItemId)
    end
  else
    self.mapCurActiveState[nItemId] = 16
    self.parent:SetFx(self.mapCurActiveState)
    if nItemId == 105 then
      WwiseAudioMgr:PostEvent("Mode_Present_prop_power")
      local nSpecialType = self.curPenguinSpecialType == 0 and self.defaultPenguinSpecialType or self.curPenguinSpecialType
      if not self.bFlying and (self.nLevelType == 1 or self.nLevelType == 3) then
        self:SetPenguinType(self._mapNode.BeginningPenguinRoot.transform, self.nNextPenguinType, self.defaultPenguinSpecialType)
        self:SetPenguinType(self._mapNode.rtBottle:Find("AnimRoot/penguinRoot"), self.curPenguinType, nSpecialType)
        self:SetPenguinType(self._mapNode.rtPenguinBeginningHint, self.curPenguinType, nSpecialType)
      else
        self:SetPenguinType(self._mapNode.BeginningPenguinRoot.transform, self.nNextPenguinType, nSpecialType)
        self:SetPenguinType(self._mapNode.rtBottle:Find("AnimRoot/penguinRoot"), self.curPenguinType, nSpecialType)
        self:SetPenguinType(self._mapNode.rtPenguinBeginningHint, self.curPenguinType, nSpecialType)
      end
    elseif nItemId == 102 then
      self._mapNode.imgInfinite:SetActive(true)
      WwiseAudioMgr:PostEvent("Mode_Present_prop_infinite")
      self._mapNode.TMPBeginningCountHint.gameObject:SetActive(false)
    elseif nItemId == 103 then
      WwiseAudioMgr:PostEvent("Mode_Present_lowtime_lp")
    elseif nItemId == 104 then
      WwiseAudioMgr:PostEvent("Mode_Present_doubletime_lp")
    end
    self.parent:SetBuffShow(nItemId, true)
    self.parent:SetBuffTime(nItemId, 15)
  end
end

function ThrowGiftsLevelCtrl:LevelStart()
  self.nLevelType = 0
  
  local function GuideCallback()
    self.nLevelType = 1
    self._mapNode.penguinRoot:SetActive(true)
    if self.nTotalPenguinCount ~= 0 then
      if self.nTotalPenguinCount >= 0 then
        NovaAPI.SetTMPText(self._mapNode.TMPBeginningCountHint, self.nTotalPenguinCount)
        self._mapNode.TMPBeginningCountHint.gameObject:SetActive(true)
        self._mapNode.imgInfinite:SetActive(false)
      else
        self._mapNode.TMPBeginningCountHint.gameObject:SetActive(false)
        self._mapNode.imgInfinite:SetActive(true)
      end
      if self.curPenguinIdx > #self.mapFloorCfgData.InitialGiftSort then
        if 0 < #self.mapFloorCfgData.GiftRandom then
          self.curPenguinType = self.mapFloorCfgData.GiftRandom[math.random(#self.mapFloorCfgData.GiftRandom)]
        else
          self.curPenguinType = 1
        end
      else
        self.curPenguinType = self.mapFloorCfgData.InitialGiftSort[self.curPenguinIdx]
      end
      self.curPenguinIdx = self.curPenguinIdx + 1
      self._mapNode.BeginningPenguinRoot.gameObject:SetActive(true)
      self._mapNode.rtBottleAnim:Play("rtBottle_in")
      self._mapNode.BeginningPenguinRoot:Play("penguinRoot_jump")
      WwiseAudioMgr:PostEvent("Mode_Present_shylock_jump")
      local nSpecialType = self.curPenguinSpecialType == 0 and self.defaultPenguinSpecialType or self.curPenguinSpecialType
      self:SetPenguinType(self._mapNode.BeginningPenguinRoot.transform, self.curPenguinType, nSpecialType)
      self:SetPenguinType(self._mapNode.rtBottle:Find("AnimRoot/penguinRoot"), self.curPenguinType, nSpecialType)
      self:SetBeginningAngle(0, 0)
      
      local function wait()
        if self.nTotalPenguinCount ~= 0 then
          self._mapNode.BeginningPenguinRoot.gameObject:SetActive(true)
          self._mapNode.BeginningPenguinRoot:Play("penguinRoot_in")
          WwiseAudioMgr:PostEvent("Mode_Present_shylock")
          self.nNextPenguinType = 1
          if self.curPenguinIdx > #self.mapFloorCfgData.InitialGiftSort then
            if 0 < #self.mapFloorCfgData.GiftRandom then
              self.nNextPenguinType = self.mapFloorCfgData.GiftRandom[math.random(#self.mapFloorCfgData.GiftRandom)]
            else
              self.nNextPenguinType = 1
            end
          else
            self.nNextPenguinType = self.mapFloorCfgData.InitialGiftSort[self.curPenguinIdx]
          end
          self:SetPenguinType(self._mapNode.BeginningPenguinRoot.transform, self.nNextPenguinType, nSpecialType)
        else
          self._mapNode.BeginningPenguinRoot.gameObject:SetActive(false)
        end
        self._mapNode.imgBeginningHint:SetActive(true)
        self:SetPenguinType(self._mapNode.rtPenguinBeginningHint, self.curPenguinType, nSpecialType)
        self.nLevelType = 1
        if self.mapLevelCfgData.SwitchArrow == true then
          self.parent:SetViewBtn(1)
        end
      end
      
      wait()
    else
      self._mapNode.BeginningPenguinRoot.gameObject:SetActive(false)
      self:LevelEnd()
    end
  end
  
  local function completeCallback()
    if self.actData ~= nil then
      if self.mapFloorCfgData.DictionaryID > 0 and self.actData:GetDicFirstIn(self.mapFloorCfgData.DictionaryID) then
        EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, self.mapFloorCfgData.DictionaryID, true, GuideCallback)
      else
        GuideCallback()
      end
    else
      GuideCallback()
    end
  end
  
  if self.mapLevelCfgData.SwitchArrow == true then
    self.nLevelType = 3
    local maxScenePosX = -math.abs((1 - self.scenePivot[1]) * self.sceneSize[1])
    self.beginningTweener = DOTween.To(function()
      return 0
    end, function(v)
      local sum = v <= 0.5 and v or v <= 2.5 and 0.5 or 3 - v
      local posX = math.sin(math.pi * sum) * maxScenePosX
      local rtScenePos = self._mapNode.rtScene.anchoredPosition
      self._mapNode.rtScene.anchoredPosition = Vector2(posX, rtScenePos.y)
    end, 3, 3):OnComplete(function()
      completeCallback()
    end)
  else
    completeCallback()
  end
end

function ThrowGiftsLevelCtrl:ChangeView(bShow)
  if bShow then
    if self.nLevelType == 3 then
      return
    end
    self.nLevelType = 3
    local maxScenePosX = -math.abs((1 - self.scenePivot[1]) * self.sceneSize[1])
    self.beginningTweener = DOTween.To(function()
      return 0
    end, function(v)
      local sum = v <= 0.5 and v or v <= 2.5 and 0.5 or 3 - v
      local posX = math.sin(math.pi * sum) * maxScenePosX
      local rtScenePos = self._mapNode.rtScene.anchoredPosition
      self._mapNode.rtScene.anchoredPosition = Vector2(posX, rtScenePos.y)
    end, 0.5, 0.5):OnComplete(function()
      self.parent:SetViewBtn(2)
    end)
  else
    if self.nLevelType ~= 3 then
      return
    end
    local maxScenePosX = -math.abs((1 - self.scenePivot[1]) * self.sceneSize[1])
    self.beginningTweener = DOTween.To(function()
      return 2.5
    end, function(v)
      local sum = v <= 0.5 and v or v <= 2.5 and 0.5 or 3 - v
      local posX = math.sin(math.pi * sum) * maxScenePosX
      local rtScenePos = self._mapNode.rtScene.anchoredPosition
      self._mapNode.rtScene.anchoredPosition = Vector2(posX, rtScenePos.y)
    end, 3, 0.5):OnComplete(function()
      if self.mapLevelCfgData.SwitchArrow == true then
        self.parent:SetViewBtn(1)
      end
      self.nLevelType = 1
    end)
  end
end

function ThrowGiftsLevelCtrl:CheckCollision(bounds1, bounds2, OffsetX1, OffsetY1, OffsetX2, OffsetY2)
  local bHit = false
  local bestNX, bestNY, minDepth = 0, 0, 0
  bHit = bounds1[2] + OffsetX1 >= bounds2[1] + OffsetX2 and bounds1[1] + OffsetX1 <= bounds2[2] + OffsetX2 and bounds1[4] + OffsetY1 >= bounds2[3] + OffsetY2 and bounds1[3] + OffsetY1 <= bounds2[4] + OffsetY2
  if bHit then
    print("Check SAT")
    bHit, bestNX, bestNY, minDepth = self:CheckSAT(bounds1, bounds2, OffsetX1, OffsetY1, OffsetX2, OffsetY2)
  end
  return bHit, bestNX, bestNY, minDepth
end

function ThrowGiftsLevelCtrl.SATGetAxes(corners)
  local ex1 = corners[2].x - corners[1].x
  local ey1 = corners[2].y - corners[1].y
  local len1 = math.sqrt(ex1 * ex1 + ey1 * ey1)
  local ex2 = corners[3].x - corners[2].x
  local ey2 = corners[3].y - corners[2].y
  local len2 = math.sqrt(ex2 * ex2 + ey2 * ey2)
  local ax1, ay1, ax2, ay2 = 0, 1, 1, 0
  if 1.0E-5 < len1 then
    ax1 = -ey1 / len1
    ay1 = ex1 / len1
  end
  if 1.0E-5 < len2 then
    ax2 = -ey2 / len2
    ay2 = ex2 / len2
  end
  return ax1, ay1, ax2, ay2
end

function ThrowGiftsLevelCtrl.SATProject(corner1, corner2, corner3, corner4, offsetX, offsetY, axisX, axisY)
  local v = (corner1.x + offsetX) * axisX + (corner1.y + offsetY) * axisY
  local pMin, pMax = v, v
  v = (corner2.x + offsetX) * axisX + (corner2.y + offsetY) * axisY
  if pMin > v then
    pMin = v
  end
  if pMax < v then
    pMax = v
  end
  v = (corner3.x + offsetX) * axisX + (corner3.y + offsetY) * axisY
  if pMin > v then
    pMin = v
  end
  if pMax < v then
    pMax = v
  end
  v = (corner4.x + offsetX) * axisX + (corner4.y + offsetY) * axisY
  if pMin > v then
    pMin = v
  end
  if pMax < v then
    pMax = v
  end
  return pMin, pMax
end

function ThrowGiftsLevelCtrl:CheckSAT(tbBounds1, tbBounds2, OffsetX1, OffsetY1, OffsetX2, OffsetY2)
  local minDepth = math.huge
  local bestNX, bestNY = 0, 0
  local ax1, ay1, ax2, ay2 = tbBounds1[9], tbBounds1[10], tbBounds1[11], tbBounds1[12]
  local ax3, ay3, ax4, ay4 = tbBounds2[9], tbBounds2[10], tbBounds2[11], tbBounds2[12]
  local cornersA1, cornersB1, cornersC1, cornersD1 = tbBounds1[5], tbBounds1[6], tbBounds1[7], tbBounds1[8]
  local cornersA2, cornersB2, cornersC2, cornersD2 = tbBounds2[5], tbBounds2[6], tbBounds2[7], tbBounds2[8]
  local min1, max1 = 0, 0
  local min2, max2 = 0, 0
  local overlap = 0
  min1, max1 = self.SATProject(cornersA1, cornersB1, cornersC1, cornersD1, OffsetX1, OffsetY1, ax1, ay1)
  min2, max2 = self.SATProject(cornersA2, cornersB2, cornersC2, cornersD2, OffsetX2, OffsetY2, ax1, ay1)
  if min2 >= max1 or min1 >= max2 then
    return false, 0, 0, 0
  end
  overlap = math.min(max1, max2) - math.max(min1, min2)
  if minDepth > overlap then
    minDepth = overlap
    bestNX = ax1
    bestNY = ay1
  end
  min1, max1 = self.SATProject(cornersA1, cornersB1, cornersC1, cornersD1, OffsetX1, OffsetY1, ax2, ay2)
  min2, max2 = self.SATProject(cornersA2, cornersB2, cornersC2, cornersD2, OffsetX2, OffsetY2, ax2, ay2)
  if min2 >= max1 or min1 >= max2 then
    return false, 0, 0, 0
  end
  overlap = math.min(max1, max2) - math.max(min1, min2)
  if minDepth > overlap then
    minDepth = overlap
    bestNX = ax2
    bestNY = ay2
  end
  min1, max1 = self.SATProject(cornersA1, cornersB1, cornersC1, cornersD1, OffsetX1, OffsetY1, ax3, ay3)
  min2, max2 = self.SATProject(cornersA2, cornersB2, cornersC2, cornersD2, OffsetX2, OffsetY2, ax3, ay3)
  if min2 >= max1 or min1 >= max2 then
    return false, 0, 0, 0
  end
  overlap = math.min(max1, max2) - math.max(min1, min2)
  if minDepth > overlap then
    minDepth = overlap
    bestNX = ax3
    bestNY = ay3
  end
  min1, max1 = self.SATProject(cornersA1, cornersB1, cornersC1, cornersD1, OffsetX1, OffsetY1, ax4, ay4)
  min2, max2 = self.SATProject(cornersA2, cornersB2, cornersC2, cornersD2, OffsetX2, OffsetY2, ax4, ay4)
  if min2 >= max1 or min1 >= max2 then
    return false, 0, 0, 0
  end
  overlap = math.min(max1, max2) - math.max(min1, min2)
  if minDepth > overlap then
    minDepth = overlap
    bestNX = ax4
    bestNY = ay4
  end
  local c1x = (cornersA1.x + OffsetX1 + cornersB1.x + OffsetX1 + cornersC1.x + OffsetX1 + cornersD1.x + OffsetX1) * 0.25
  local c1y = (cornersA1.y + OffsetY1 + cornersB1.y + OffsetY1 + cornersC1.y + OffsetY1 + cornersD1.y + OffsetY1) * 0.25
  local c2x = (cornersA2.x + OffsetX2 + cornersB2.x + OffsetX2 + cornersC2.x + OffsetX2 + cornersD2.x + OffsetX2) * 0.25
  local c2y = (cornersA2.y + OffsetY2 + cornersB2.y + OffsetY2 + cornersC2.y + OffsetY2 + cornersD2.y + OffsetY2) * 0.25
  if (c1x - c2x) * bestNX + (c1y - c2y) * bestNY < 0 then
    bestNX = -bestNX
    bestNY = -bestNY
  end
  return true, bestNX, bestNY, minDepth
end

function ThrowGiftsLevelCtrl.ReflectVelocity(vx, vy, nx, ny, restitution)
  restitution = restitution or 1.0
  local dot = vx * nx + vy * ny
  if 0 <= dot then
    return vx, vy
  end
  local scale = (1.0 + restitution) * dot
  return vx - scale * nx, vy - scale * ny
end

function ThrowGiftsLevelCtrl:GetLocalSpaceRect(rectTransform, parent)
  local corners = CS.System.Array.CreateInstance(typeof(Vector3), 4)
  rectTransform:GetLocalCorners(corners)
  local c0 = corners[0]
  local c1 = corners[1]
  local c2 = corners[2]
  local c3 = corners[3]
  local p0 = parent:InverseTransformPoint(rectTransform:TransformPoint(c0))
  local p1 = parent:InverseTransformPoint(rectTransform:TransformPoint(c1))
  local p2 = parent:InverseTransformPoint(rectTransform:TransformPoint(c2))
  local p3 = parent:InverseTransformPoint(rectTransform:TransformPoint(c3))
  local p0x, p0y = p0.x, p0.y
  local p1x, p1y = p1.x, p1.y
  local p2x, p2y = p2.x, p2.y
  local p3x, p3y = p3.x, p3.y
  local xMin = math.min(p0x, p1x, p2x, p3x)
  local xMax = math.max(p0x, p1x, p2x, p3x)
  local yMin = math.min(p0y, p1y, p2y, p3y)
  local yMax = math.max(p0y, p1y, p2y, p3y)
  local ax1, ay1, ax2, ay2 = self.SATGetAxes({
    p0,
    p1,
    p2,
    p3
  })
  return {
    xMin,
    xMax,
    yMin,
    yMax,
    p0,
    p1,
    p2,
    p3,
    ax1,
    ay1,
    ax2,
    ay2
  }
end

function ThrowGiftsLevelCtrl:OnUpdate()
  if self.mapUpdateTimer == nil then
    return
  end
  local nDeltaTime = math.min(self.mapUpdateTimer:GetDelTime(), 0.032)
  if self.nLevelTime > 0 then
    if self.nLevelType == 1 then
      if self.mapCurActiveState[103] ~= nil then
        self.nLevelTime = self.nLevelTime - nDeltaTime * 0.5
      else
        self.nLevelTime = self.nLevelTime - nDeltaTime
      end
    end
    self.nLevelTime = math.max(self.nLevelTime, 0)
    self.parent:SetTime(self.nLevelTime)
    if self.nLevelTime <= 0 then
      if self.mapLevelCfgData.ThrowGiftLevelCond == GameEnum.ThrowGiftLevelCond.ThrowCountAfterTime then
        if self.nTotalThrowGiftCount >= self.mapLevelCfgData.throwGiftLevelParams then
          self:LevelEnd(true, 0)
        else
          self:LevelEnd(false, 1)
        end
      elseif self.mapLevelCfgData.ThrowGiftLevelCond == GameEnum.ThrowGiftLevelCond.ScoreAfterTime then
        if self.nLevelScore >= self.mapLevelCfgData.throwGiftLevelParams then
          self:LevelEnd(true, 0)
        else
          self:LevelEnd(false, 1)
        end
      elseif self.mapLevelCfgData.ThrowGiftLevelCond == GameEnum.ThrowGiftLevelCond.HitCountAfterTime then
        if self.nTotalHitGoalCount >= self.mapLevelCfgData.throwGiftLevelParams then
          self:LevelEnd(true, 0)
        else
          self:LevelEnd(false, 1)
        end
      else
        self:LevelEnd(false, 2)
      end
      return
    end
  end
  local tbRemovedState = {}
  for nState, nTime in pairs(self.mapCurActiveState) do
    self.mapCurActiveState[nState] = self.mapCurActiveState[nState] - nDeltaTime
    self.parent:SetBuffTime(nState, nTime)
    if 0 >= self.mapCurActiveState[nState] then
      table.insert(tbRemovedState, nState)
      self.parent:SetBuffShow(nState, false)
    end
  end
  local bChange = 0 < #tbRemovedState
  for _, nState in ipairs(tbRemovedState) do
    self.mapCurActiveState[nState] = nil
    if nState == 105 then
      self:SetPenguinType(self._mapNode.BeginningPenguinRoot.transform, self.nNextPenguinType, 0)
      self:SetPenguinType(self._mapNode.rtBottle:Find("AnimRoot/penguinRoot"), self.curPenguinType, self.curPenguinSpecialType)
      self:SetPenguinType(self._mapNode.rtPenguinBeginningHint, self.curPenguinType, self.curPenguinSpecialType)
      if self.bFlying and self.curGiftPenguin ~= nil then
        local goPenguin = self.curGiftPenguin.goGiftPenguin
        local rtPenguin = goPenguin:GetComponent("RectTransform")
        local goImgRoot = rtPenguin:Find("imgRoot")
        local imgFx = goImgRoot:Find("imgFx")
        imgFx.gameObject:SetActive(false)
      end
    elseif nState == 103 then
      WwiseAudioMgr:PostEvent("Mode_Present_lowtime_lp_stop")
    elseif nState == 104 then
      WwiseAudioMgr:PostEvent("Mode_Present_doubletime_lp_stop")
    elseif nState == 102 and 0 <= self.nTotalPenguinCount then
      self._mapNode.imgInfinite:SetActive(false)
      self._mapNode.TMPBeginningCountHint.gameObject:SetActive(true)
    end
  end
  if bChange then
    self.parent:SetFx(self.mapCurActiveState)
  end
  for nId, mapAciveGoal in pairs(self.activeGoal) do
    local mapConfig = self.mapGoal[nId]
    local moveX = 0
    local moveY = 0
    if mapConfig ~= nil then
      moveX = mapConfig.mapConfig.MoveX
      moveY = mapConfig.mapConfig.MoveY
      if 0 < moveX or 0 < moveY then
        local curPos = mapAciveGoal.rtGoal.anchoredPosition
        local rtSpawnPoint = mapConfig.rtPoint
        local nXMax = rtSpawnPoint.anchoredPosition.x + moveX
        local nYMax = rtSpawnPoint.anchoredPosition.y + moveY
        local nXMin = rtSpawnPoint.anchoredPosition.x - moveX
        local nYMin = rtSpawnPoint.anchoredPosition.y - moveY
        local nCurMove = 0
        if self.mapCurActiveState[103] ~= nil then
          nCurMove = self.nGoalSpeed * nDeltaTime * 0.5
        else
          nCurMove = self.nGoalSpeed * nDeltaTime
        end
        local nAfterX = curPos.x + nCurMove * mapConfig.VxDir
        local nAfterY = curPos.y + nCurMove * mapConfig.VyDir
        if nXMax < nAfterX then
          nAfterX = nXMax
          mapConfig.VxDir = -mapConfig.VxDir
        elseif nXMin > nAfterX then
          nAfterX = nXMin
          mapConfig.VxDir = -mapConfig.VxDir
        end
        if nYMax < nAfterY then
          nAfterY = nYMax
          mapConfig.VyDir = -mapConfig.VyDir
        elseif nYMin > nAfterY then
          nAfterY = nYMin
          mapConfig.VyDir = -mapConfig.VyDir
        end
        mapAciveGoal.OffsetX = nAfterX - mapAciveGoal.initialPosX
        mapAciveGoal.OffsetY = nAfterY - mapAciveGoal.initialPosY
        mapAciveGoal.rtGoal.anchoredPosition = Vector2(nAfterX, nAfterY)
      end
    end
  end
  if not self.bFlying then
    return
  end
  if self.curGiftPenguin == nil then
    return
  end
  local nCurPosX, nCurPosY, tbCachedGoalId
  if self.curGiftPenguin.nSpecialType == 106 then
    nCurPosX, nCurPosY = self:NavigationPenguinUpdate(nDeltaTime)
  elseif self.curGiftPenguin.nSpecialType == 107 then
    nCurPosX, nCurPosY = self:HelmetPenguinUpdate(nDeltaTime)
  elseif self.curGiftPenguin.nSpecialType == 108 then
    nCurPosX, nCurPosY = self:AntennaPenguinUpdate(nDeltaTime)
  elseif self.curGiftPenguin.nSpecialType == 109 then
    nCurPosX, nCurPosY = self:BouncePenguinUpdate(nDeltaTime)
  elseif self.curGiftPenguin.nSpecialType == 110 then
    nCurPosX, nCurPosY, tbCachedGoalId = self:SplitPenguinUpdate(nDeltaTime)
  else
    nCurPosX, nCurPosY = self:NormalPenguinUpdate(nDeltaTime)
  end
  if not self.bFlying then
    local tbHitGoalId = {}
    if tbCachedGoalId ~= nil and 0 < #tbCachedGoalId then
      for _, tbResult in ipairs(tbCachedGoalId) do
        self:HitGoal(tbResult[2], tbResult[1])
        table.insert(tbHitGoalId, tbResult[1])
      end
    end
    self:FlyOver(0.5, tbHitGoalId)
    return
  end
  local tbHitGoalId = {}
  if self.curGiftPenguin.nSpecialType == 110 and self.curGiftPenguin.bSplit then
    local tbCurHit = self:SplitPenguinGoalCheck()
    if 0 < #tbCurHit then
      for _, tbResult in ipairs(tbCurHit) do
        self:HitGoal(tbResult[2], tbResult[1])
      end
      if not self.bFlying then
        self.curGiftPenguin = nil
        for _, tbResult in ipairs(tbCurHit) do
          table.insert(tbHitGoalId, tbResult[1])
        end
      end
    end
  elseif self.curGiftPenguin.nSpecialType == 109 then
    local hitGoalId, hitPos = self:BouncePenguinGoalCheck(nCurPosX, nCurPosY)
    if 0 < hitGoalId then
      self:HitGoal(hitPos, hitGoalId)
      table.insert(tbHitGoalId, hitGoalId)
    end
  else
    local hitGoalId, hitPos = self:NormalGoalCheck(nCurPosX, nCurPosY)
    if 0 < hitGoalId then
      self:HitGoal(hitPos, hitGoalId)
      table.insert(tbHitGoalId, hitGoalId)
    end
  end
  if not self.bFlying then
    self:FlyOver(0.5, tbHitGoalId)
    return
  end
  local rtScenePos = self._mapNode.rtScene.anchoredPosition
  local curPosXInScreen = self.sceneSize[1] * 0.5 + nCurPosX + rtScenePos.x
  if curPosXInScreen > self.viewSize[1] / 2 then
    local sumX = curPosXInScreen - self.viewSize[1] / 2
    local nFinX = rtScenePos.x - sumX
    local maxScenePosX = (1 - self.scenePivot[1]) * self.sceneSize[1]
    if nFinX <= -math.abs(maxScenePosX) then
      nFinX = -math.abs(maxScenePosX)
    end
    self._mapNode.rtScene.anchoredPosition = Vector2(nFinX, rtScenePos.y)
  end
end

function ThrowGiftsLevelCtrl:CheckSpeed(nVy, nAngle)
  local bSpeedCheck = true
  if nAngle < 45 or 315 < nAngle then
    bSpeedCheck = nVy <= 0
  elseif nAngle < 135 or 225 < nAngle then
    bSpeedCheck = true
  else
    bSpeedCheck = 0 <= nVy
  end
  return bSpeedCheck
end

function ThrowGiftsLevelCtrl:NormalGoalCheck(nCurPosX, nCurPosY)
  local nSumX = nCurPosX - self.curGiftPenguin.mapStartPos.x
  local nSumY = nCurPosY - self.curGiftPenguin.mapStartPos.y
  if self.mapLevelCfgData.FlightPath == true and self.nFlyingTime - self._mapNode.rtBlindLevelTrack.nPrevTimer >= self.nLinePointInterval * 2 then
    self._mapNode.rtBlindLevelTrack.nPrevTimer = self.nFlyingTime
    self._mapNode.rtBlindLevelTrack:AddDot(Vector2(nCurPosX, nCurPosY))
  end
  local hitGoalId = 0
  local hitPos
  for nId, mapAciveGoal in pairs(self.activeGoal) do
    local GoalParentPos = mapAciveGoal.rtGoal.anchoredPosition
    local nGoalParentAngle = mapAciveGoal.rtGoal.localEulerAngles.z % 360
    local bHitGoal = self:CheckCollision(self.curGiftPenguin.tbBounds, mapAciveGoal.tbBoundsHitArea, nSumX, nSumY, mapAciveGoal.OffsetX, mapAciveGoal.OffsetY)
    if bHitGoal then
      local curVy = self.curGiftPenguin.nVelocityY
      if not self:CheckSpeed(curVy, nGoalParentAngle) and self.curGiftPenguin.nSpecialType ~= 106 and self.curGiftPenguin.nSpecialType ~= 107 then
        print("hit goal edge")
        self:DestroyPenguin()
        self.curGiftPenguin = nil
        self.bFlying = false
        break
      else
        print("hit goal！")
        hitPos = Vector2(nCurPosX, nCurPosY)
        destroy(self.curGiftPenguin.goGiftPenguin.gameObject)
        hitGoalId = nId
        self.curGiftPenguin = nil
        self.bFlying = false
        break
      end
    end
    if self.curGiftPenguin.nSpecialType ~= 107 then
      local bHitObstacle = self:CheckCollision(self.curGiftPenguin.tbBounds, mapAciveGoal.tbBoundsObstacle, nSumX, nSumY, mapAciveGoal.OffsetX, mapAciveGoal.OffsetY)
      if bHitObstacle then
        self:DestroyPenguin()
        self.bFlying = false
        break
      end
    end
  end
  return hitGoalId, hitPos
end

function ThrowGiftsLevelCtrl:SplitPenguinGoalCheck()
  local tbCurHit = {}
  for _, mapSubPenguin in ipairs(self.curGiftPenguin.tbSubPenguin) do
    if mapSubPenguin.bFlying then
      local hitGoalId = 0
      local hitPos
      local nSumX = mapSubPenguin.curPosX - mapSubPenguin.mapStartPos.x
      local nSumY = mapSubPenguin.curPosY - mapSubPenguin.mapStartPos.y
      for nId, mapAciveGoal in pairs(self.activeGoal) do
        local bHitGoal = self:CheckCollision(mapSubPenguin.tbBounds, mapAciveGoal.tbBoundsHitArea, nSumX, nSumY, mapAciveGoal.OffsetX, mapAciveGoal.OffsetY)
        if bHitGoal then
          print("hit goal！")
          hitPos = Vector2(mapSubPenguin.curPosX, mapSubPenguin.curPosY)
          destroy(mapSubPenguin.goGiftPenguin.gameObject)
          mapSubPenguin.goGiftPenguin = nil
          hitGoalId = nId
          mapSubPenguin.bFlying = false
          table.insert(tbCurHit, {hitGoalId, hitPos})
          table.insert(self.curGiftPenguin.tbCacheSubPenguinGoal, {hitGoalId, hitPos})
          break
        end
        local bHitObstacle = self:CheckCollision(mapSubPenguin.tbBounds, mapAciveGoal.tbBoundsObstacle, nSumX, nSumY, mapAciveGoal.OffsetX, mapAciveGoal.OffsetY)
        if bHitObstacle then
          self:DestroySubPenguin(mapSubPenguin)
          mapSubPenguin.bFlying = false
          break
        end
      end
    end
  end
  if self.mapLevelCfgData.FlightPath == true and self.nFlyingTime - self._mapNode.rtBlindLevelTrack.nPrevTimer >= self.nLinePointInterval * 2 then
    self._mapNode.rtBlindLevelTrack.nPrevTimer = self.nFlyingTime
    for _, mapSubPenguin in ipairs(self.curGiftPenguin.tbSubPenguin) do
      if mapSubPenguin.bFlying then
        self._mapNode.rtBlindLevelTrack:AddDot(Vector2(mapSubPenguin.curPosX, mapSubPenguin.curPosY))
      end
    end
  end
  local bHasSubPenguin = false
  for _, mapSubPenguin in ipairs(self.curGiftPenguin.tbSubPenguin) do
    if mapSubPenguin.bFlying then
      bHasSubPenguin = true
    end
  end
  self.bFlying = bHasSubPenguin
  if not self.bFlying then
    self.curGiftPenguin = nil
  end
  return tbCurHit
end

function ThrowGiftsLevelCtrl:BouncePenguinGoalCheck(nCurPosX, nCurPosY)
  local nSumX = nCurPosX - self.curGiftPenguin.mapStartPos.x
  local nSumY = nCurPosY - self.curGiftPenguin.mapStartPos.y
  if self.mapLevelCfgData.FlightPath == true and self.nFlyingTime - self._mapNode.rtBlindLevelTrack.nPrevTimer >= self.nLinePointInterval * 2 then
    self._mapNode.rtBlindLevelTrack.nPrevTimer = self.nFlyingTime
    self._mapNode.rtBlindLevelTrack:AddDot(Vector2(nCurPosX, nCurPosY))
  end
  local hitGoalId = 0
  local hitPos
  local curVy = self.curGiftPenguin.nVelocityY
  for nId, mapAciveGoal in pairs(self.activeGoal) do
    local GoalParentPos = mapAciveGoal.rtGoal.anchoredPosition
    local bHitGoal, bestNX, bestNY, minDepth = self:CheckCollision(self.curGiftPenguin.tbBounds, mapAciveGoal.tbBoundsHitArea, nSumX, nSumY, mapAciveGoal.OffsetX, mapAciveGoal.OffsetY)
    local nGoalParentAngle = mapAciveGoal.rtGoal.localEulerAngles.z % 360
    if bHitGoal then
      if not self:CheckSpeed(curVy, nGoalParentAngle) then
        if self.curGiftPenguin.nHitCount < 3 then
          WwiseAudioMgr:PostEvent("Mode_Present_spring")
          self.curGiftPenguin.nHitCount = self.curGiftPenguin.nHitCount + 1
          nCurPosX = nCurPosX + bestNX * minDepth
          nCurPosY = nCurPosY + bestNY * minDepth
          nSumX = nSumX + bestNX * minDepth
          nSumY = nSumY + bestNY * minDepth
          self.curGiftPenguin.curPosX = nCurPosX
          self.curGiftPenguin.curPosY = nCurPosY
          self.curGiftPenguin.goGiftPenguin.anchoredPosition = Vector2(nCurPosX, nCurPosY)
          self.curGiftPenguin.mapStartPos = self.curGiftPenguin.goGiftPenguin.anchoredPosition
          local vxAfter, vyAfter = self.ReflectVelocity(self.curGiftPenguin.nVelocityX, curVy, bestNX, bestNY, 1)
          self.curGiftPenguin.nHitTime = self.nFlyingTime
          self.curGiftPenguin.nVelocityX = vxAfter
          self.curGiftPenguin.nVelocityY = vyAfter
          self.curGiftPenguin.tbBounds = self:GetLocalSpaceRect(self.curGiftPenguin.goGiftPenguin, self.curGiftPenguin.goGiftPenguin.parent)
          break
        else
          self:DestroyPenguin()
          self.bFlying = false
          break
        end
      else
        print("hit goal！")
        hitPos = Vector2(nCurPosX, nCurPosY)
        destroy(self.curGiftPenguin.goGiftPenguin.gameObject)
        hitGoalId = nId
        self.curGiftPenguin = nil
        self.bFlying = false
        break
      end
    end
    local bHitObstacle, bestNXObstacle, bestNYObstacle, minDepthObstacle = self:CheckCollision(self.curGiftPenguin.tbBounds, mapAciveGoal.tbBoundsObstacle, nSumX, nSumY, mapAciveGoal.OffsetX, mapAciveGoal.OffsetY)
    if bHitObstacle then
      if self.curGiftPenguin.nHitCount < 3 then
        self.curGiftPenguin.nHitCount = self.curGiftPenguin.nHitCount + 1
        nCurPosX = nCurPosX + bestNXObstacle * minDepthObstacle
        nCurPosY = nCurPosY + bestNYObstacle * minDepthObstacle
        nSumX = nSumX + bestNXObstacle * minDepthObstacle
        nSumY = nSumY + bestNYObstacle * minDepthObstacle
        self.curGiftPenguin.curPosX = nCurPosX
        self.curGiftPenguin.curPosY = nCurPosY
        self.curGiftPenguin.goGiftPenguin.anchoredPosition = Vector2(nCurPosX, nCurPosY)
        self.curGiftPenguin.mapStartPos = self.curGiftPenguin.goGiftPenguin.anchoredPosition
        local vxAfter, vyAfter = self.ReflectVelocity(self.curGiftPenguin.nVelocityX, curVy, bestNXObstacle, bestNYObstacle, 1)
        self.curGiftPenguin.nHitTime = self.nFlyingTime
        self.curGiftPenguin.nVelocityX = vxAfter
        self.curGiftPenguin.nVelocityY = vyAfter
        self.curGiftPenguin.tbBounds = self:GetLocalSpaceRect(self.curGiftPenguin.goGiftPenguin, self.curGiftPenguin.goGiftPenguin.parent)
        break
      else
        self:DestroyPenguin()
        self.bFlying = false
        break
      end
    end
  end
  return hitGoalId, hitPos
end

function ThrowGiftsLevelCtrl:NormalPenguinUpdate(nDeltaTime)
  self.nFlyingTime = self.nFlyingTime + nDeltaTime
  local nCurPosX = self.curGiftPenguin.curPosX + nDeltaTime * self.curGiftPenguin.nVelocityX
  local nCurPosY = self.curGiftPenguin.curPosY + nDeltaTime * self.curGiftPenguin.nVelocityY - 0.5 * self.nAG * nDeltaTime * nDeltaTime
  self.curGiftPenguin.nVelocityY = self.curGiftPenguin.nVelocityY - self.nAG * nDeltaTime
  self.curGiftPenguin.curPosX = nCurPosX
  self.curGiftPenguin.curPosY = nCurPosY
  self.curGiftPenguin.goGiftPenguin.anchoredPosition = Vector2(nCurPosX, nCurPosY)
  local nSumX = nCurPosX - self.curGiftPenguin.mapStartPos.x
  local nSumY = nCurPosY - self.curGiftPenguin.mapStartPos.y
  local curVy = self.curGiftPenguin.nVelocityY
  if self.curGiftPenguin.rtImgRoot ~= nil then
    local nFlyAngle = math.deg(math.atan(curVy, self.curGiftPenguin.nVelocityX))
    self.curGiftPenguin.rtImgRoot.localEulerAngles = Vector3(0, 0, nFlyAngle)
  end
  for _, tbBounds in ipairs(self.tbObstacle) do
    local bHit = self:CheckCollision(self.curGiftPenguin.tbBounds, tbBounds, nSumX, nSumY, 0, 0)
    if bHit then
      self:DestroyPenguin()
      self.bFlying = false
      break
    end
  end
  if not self.bFlying then
    return
  end
  if nCurPosX > 0.5 * self.sceneSize[1] or nCurPosX < -0.5 * self.sceneSize[1] or nCurPosY > 0.5 * self.sceneSize[2] or nCurPosY < -0.5 * self.sceneSize[2] then
    print("hit border")
    self:DestroyPenguin()
    self.bFlying = false
  end
  if not self.bFlying then
    return
  end
  local tbHittedObs = {}
  for _, nSpecialId in ipairs(self.tbExObstacleCur) do
    local mapConfig = self.mapExObstacleOrigin[nSpecialId]
    if mapConfig ~= nil then
      local bHit = self:CheckCollision(self.curGiftPenguin.tbBounds, mapConfig.tbBounds, nSumX, nSumY, 0, 0)
      if bHit then
        local nType, Param, bRemove
        self.bFlying, nType, Param, bRemove = self:HitSpecialObstacle(nSpecialId)
        self:SpecialObstacleFunc(self.curGiftPenguin, nDeltaTime, nType, Param)
        if bRemove then
          table.insert(tbHittedObs, nSpecialId)
        end
        if not self.bFlying then
          self:DestroyPenguin()
          break
        end
      end
    end
  end
  for _, nId in ipairs(tbHittedObs) do
    table.removebyvalue(self.tbExObstacleCur, nId, true)
  end
  return nCurPosX, nCurPosY
end

function ThrowGiftsLevelCtrl:BouncePenguinUpdate(nDeltaTime)
  self.nFlyingTime = self.nFlyingTime + nDeltaTime
  local nCurPosX = self.curGiftPenguin.curPosX + nDeltaTime * self.curGiftPenguin.nVelocityX
  local nCurPosY = self.curGiftPenguin.curPosY + nDeltaTime * self.curGiftPenguin.nVelocityY - 0.5 * self.nAG * nDeltaTime * nDeltaTime
  self.curGiftPenguin.nVelocityY = self.curGiftPenguin.nVelocityY - self.nAG * nDeltaTime
  self.curGiftPenguin.curPosX = nCurPosX
  self.curGiftPenguin.curPosY = nCurPosY
  local curVy = self.curGiftPenguin.nVelocityY
  self.curGiftPenguin.goGiftPenguin.anchoredPosition = Vector2(nCurPosX, nCurPosY)
  local nSumX = nCurPosX - self.curGiftPenguin.mapStartPos.x
  local nSumY = nCurPosY - self.curGiftPenguin.mapStartPos.y
  if self.curGiftPenguin.rtImgRoot ~= nil then
    local nFlyAngle = math.deg(math.atan(curVy, self.curGiftPenguin.nVelocityX))
    self.curGiftPenguin.rtImgRoot.localEulerAngles = Vector3(0, 0, nFlyAngle)
  end
  for _, tbBounds in ipairs(self.tbObstacle) do
    local bHit, bestNX, bestNY, minDepth = self:CheckCollision(self.curGiftPenguin.tbBounds, tbBounds, nSumX, nSumY, 0, 0)
    if bHit then
      if self.curGiftPenguin.nHitCount < 3 then
        WwiseAudioMgr:PostEvent("Mode_Present_spring")
        self.curGiftPenguin.nHitCount = self.curGiftPenguin.nHitCount + 1
        nCurPosX = nCurPosX + bestNX * minDepth
        nCurPosY = nCurPosY + bestNY * minDepth
        nSumX = nSumX + bestNX * minDepth
        nSumY = nSumY + bestNY * minDepth
        self.curGiftPenguin.curPosX = nCurPosX
        self.curGiftPenguin.curPosY = nCurPosY
        self.curGiftPenguin.goGiftPenguin.anchoredPosition = Vector2(nCurPosX, nCurPosY)
        self.curGiftPenguin.mapStartPos = self.curGiftPenguin.goGiftPenguin.anchoredPosition
        local vxAfter, vyAfter = self.ReflectVelocity(self.curGiftPenguin.nVelocityX, curVy, bestNX, bestNY, 1)
        self.curGiftPenguin.nHitTime = self.nFlyingTime
        self.curGiftPenguin.nVelocityX = vxAfter
        self.curGiftPenguin.nVelocityY = vyAfter
        self.curGiftPenguin.tbBounds = self:GetLocalSpaceRect(self.curGiftPenguin.goGiftPenguin, self.curGiftPenguin.goGiftPenguin.parent)
        break
      else
        self:DestroyPenguin()
        self.bFlying = false
        break
      end
    end
  end
  if not self.bFlying then
    return
  end
  if nCurPosX > 0.5 * self.sceneSize[1] or nCurPosX < -0.5 * self.sceneSize[1] or nCurPosY > 0.5 * self.sceneSize[2] or nCurPosY < -0.5 * self.sceneSize[2] then
    print("hit border")
    self:DestroyPenguin()
    self.bFlying = false
  end
  if not self.bFlying then
    return
  end
  local tbHittedObs = {}
  for _, nSpecialId in ipairs(self.tbExObstacleCur) do
    local mapConfig = self.mapExObstacleOrigin[nSpecialId]
    if mapConfig ~= nil then
      local bHit = self:CheckCollision(self.curGiftPenguin.tbBounds, mapConfig.tbBounds, nSumX, nSumY, 0, 0)
      if bHit then
        local nType, Param, bRemove
        self.bFlying, nType, Param, bRemove = self:HitSpecialObstacle(nSpecialId)
        self:SpecialObstacleFunc(self.curGiftPenguin, nDeltaTime, nType, Param)
        if bRemove then
          table.insert(tbHittedObs, nSpecialId)
        end
        if not self.bFlying then
          self:DestroyPenguin()
          break
        end
      end
    end
  end
  for _, nId in ipairs(tbHittedObs) do
    table.removebyvalue(self.tbExObstacleCur, nId, true)
  end
  return nCurPosX, nCurPosY
end

function ThrowGiftsLevelCtrl:AntennaPenguinUpdate(nDeltaTime)
  self.nFlyingTime = self.nFlyingTime + nDeltaTime
  local nCurPosX = self.curGiftPenguin.curPosX + nDeltaTime * self.curGiftPenguin.nVelocityX
  local nCurPosY = self.curGiftPenguin.curPosY + nDeltaTime * self.curGiftPenguin.nVelocityY - 0.5 * self.nAG * nDeltaTime * nDeltaTime
  self.curGiftPenguin.nVelocityY = self.curGiftPenguin.nVelocityY - self.nAG * nDeltaTime
  self.curGiftPenguin.curPosX = nCurPosX
  self.curGiftPenguin.curPosY = nCurPosY
  local curVy = self.curGiftPenguin.nVelocityY
  self.curGiftPenguin.goGiftPenguin.anchoredPosition = Vector2(nCurPosX, nCurPosY)
  local nSumX = nCurPosX - self.curGiftPenguin.mapStartPos.x
  local nSumY = nCurPosY - self.curGiftPenguin.mapStartPos.y
  if self.tbItemTrackCtrl[self.curGiftPenguin.nTrackIdx] ~= nil then
    local mapTrackCtrl = self.tbItemTrackCtrl[self.curGiftPenguin.nTrackIdx]
    if self.nFlyingTime - mapTrackCtrl.nPrevTimer >= self.nLinePointInterval * 2 then
      mapTrackCtrl.nPrevTimer = self.nFlyingTime
      mapTrackCtrl:AddDot(Vector2(nCurPosX, nCurPosY))
    end
  end
  if self.curGiftPenguin.rtImgRoot ~= nil then
    local nFlyAngle = math.deg(math.atan(curVy, self.curGiftPenguin.nVelocityX))
    self.curGiftPenguin.rtImgRoot.localEulerAngles = Vector3(0, 0, nFlyAngle)
  end
  for _, tbBounds in ipairs(self.tbObstacle) do
    local bHit = self:CheckCollision(self.curGiftPenguin.tbBounds, tbBounds, nSumX, nSumY, 0, 0)
    if bHit then
      self:DestroyPenguin()
      self.bFlying = false
      break
    end
  end
  if not self.bFlying then
    return
  end
  if nCurPosX > 0.5 * self.sceneSize[1] or nCurPosX < -0.5 * self.sceneSize[1] or nCurPosY > 0.5 * self.sceneSize[2] or nCurPosY < -0.5 * self.sceneSize[2] then
    print("hit border")
    self:DestroyPenguin()
    self.bFlying = false
  end
  if not self.bFlying then
    return
  end
  local tbHittedObs = {}
  for _, nSpecialId in ipairs(self.tbExObstacleCur) do
    local mapConfig = self.mapExObstacleOrigin[nSpecialId]
    if mapConfig ~= nil then
      local bHit = self:CheckCollision(self.curGiftPenguin.tbBounds, mapConfig.tbBounds, nSumX, nSumY, 0, 0)
      if bHit then
        local nType, Param, bRemove
        self.bFlying, nType, Param, bRemove = self:HitSpecialObstacle(nSpecialId)
        self:SpecialObstacleFunc(self.curGiftPenguin, nDeltaTime, nType, Param)
        if bRemove then
          table.insert(tbHittedObs, nSpecialId)
        end
        if not self.bFlying then
          self:DestroyPenguin()
          break
        end
      end
    end
  end
  for _, nId in ipairs(tbHittedObs) do
    table.removebyvalue(self.tbExObstacleCur, nId, true)
  end
  return nCurPosX, nCurPosY
end

function ThrowGiftsLevelCtrl:HelmetPenguinUpdate(nDeltaTime)
  self.nFlyingTime = self.nFlyingTime + nDeltaTime
  local nCurPosX = self.curGiftPenguin.curPosX + nDeltaTime * self.curGiftPenguin.nVelocityX
  local nCurPosY = self.curGiftPenguin.curPosY + nDeltaTime * self.curGiftPenguin.nVelocityY - 0.5 * self.nAG * nDeltaTime * nDeltaTime
  self.curGiftPenguin.nVelocityY = self.curGiftPenguin.nVelocityY - self.nAG * nDeltaTime
  self.curGiftPenguin.curPosX = nCurPosX
  self.curGiftPenguin.curPosY = nCurPosY
  local curVy = self.curGiftPenguin.nVelocityY
  self.curGiftPenguin.goGiftPenguin.anchoredPosition = Vector2(nCurPosX, nCurPosY)
  local nSumX = nCurPosX - self.curGiftPenguin.mapStartPos.x
  local nSumY = nCurPosY - self.curGiftPenguin.mapStartPos.y
  if self.curGiftPenguin.rtImgRoot ~= nil then
    local nFlyAngle = math.deg(math.atan(curVy, self.curGiftPenguin.nVelocityX))
    self.curGiftPenguin.rtImgRoot.localEulerAngles = Vector3(0, 0, nFlyAngle)
  end
  if nCurPosX > 0.5 * self.sceneSize[1] or nCurPosX < -0.5 * self.sceneSize[1] or nCurPosY > 0.5 * self.sceneSize[2] or nCurPosY < -0.5 * self.sceneSize[2] then
    print("hit border")
    self:DestroyPenguin()
    self.bFlying = false
  end
  if not self.bFlying then
    return
  end
  local tbHittedObs = {}
  for _, nSpecialId in ipairs(self.tbExObstacleCur) do
    local mapConfig = self.mapExObstacleOrigin[nSpecialId]
    if mapConfig ~= nil then
      local bHit = self:CheckCollision(self.curGiftPenguin.tbBounds, mapConfig.tbBounds, nSumX, nSumY, 0, 0)
      if bHit then
        local bFlying, nType, Param, bRemove
        bFlying, nType, Param, bRemove = self:HitSpecialObstacle(nSpecialId)
        self:SpecialObstacleFunc(self.curGiftPenguin, nDeltaTime, nType, Param)
        if bRemove then
          table.insert(tbHittedObs, nSpecialId)
        end
      end
    end
  end
  for _, nId in ipairs(tbHittedObs) do
    table.removebyvalue(self.tbExObstacleCur, nId, true)
  end
  return nCurPosX, nCurPosY
end

function ThrowGiftsLevelCtrl:NavigationPenguinUpdate(nDeltaTime)
  local function checkGetGoal(nCurPosX, nCurPosY)
    for nId, mapAciveGoal in pairs(self.activeGoal) do
      if nCurPosX >= mapAciveGoal.tbBoundsHitArea[1] and nCurPosX <= mapAciveGoal.tbBoundsHitArea[2] and nCurPosY >= mapAciveGoal.tbBoundsHitArea[4] then
        return mapAciveGoal.rtGoal
      end
    end
    return nil
  end
  
  self.nFlyingTime = self.nFlyingTime + nDeltaTime
  self.curGiftPenguin.nVelocityY = math.max(0, self.curGiftPenguin.nVelocityY - self.nAG * nDeltaTime)
  local nCurPosY = 0
  local nCurPosX = 0
  if self.curGiftPenguin.targetGoal == nil then
    if self.curGiftPenguin.nVelocityY > 0 then
      nCurPosX = self.curGiftPenguin.curPosX + nDeltaTime * self.curGiftPenguin.nVelocityX
      nCurPosY = self.curGiftPenguin.curPosY + nDeltaTime * self.curGiftPenguin.nVelocityY - 0.5 * self.nAG * nDeltaTime * nDeltaTime
    else
      nCurPosY = self.curGiftPenguin.curPosY
      local nVelocityX = self.curGiftPenguin.nVelocityX < 600 and 600 or self.curGiftPenguin.nVelocityX
      nCurPosX = self.curGiftPenguin.curPosX + nDeltaTime * nVelocityX
      self.curGiftPenguin.nVelocityY = 0
    end
    local checkGoal = checkGetGoal(nCurPosX, nCurPosY)
    if checkGoal ~= nil then
      self.curGiftPenguin.targetGoal = checkGoal
      self.curGiftPenguin.nGetTargetTime = self.nFlyingTime
    end
  else
    nCurPosY = self.curGiftPenguin.curPosY - nDeltaTime * self.nNavigationPenguinSpeed
    local nTargetX = self.curGiftPenguin.targetGoal.anchoredPosition.x
    nCurPosX = self.curGiftPenguin.goGiftPenguin.anchoredPosition.x
    local sumMove = math.min(self.maxVelocity, (nTargetX - nCurPosX) / 0.1) * nDeltaTime
    nCurPosX = sumMove + nCurPosX
  end
  self.curGiftPenguin.curPosX = nCurPosX
  self.curGiftPenguin.curPosY = nCurPosY
  self.curGiftPenguin.goGiftPenguin.anchoredPosition = Vector2(nCurPosX, nCurPosY)
  local nSumX = nCurPosX - self.curGiftPenguin.mapStartPos.x
  local nSumY = nCurPosY - self.curGiftPenguin.mapStartPos.y
  local curVy = self.curGiftPenguin.nVelocityY
  if self.curGiftPenguin.rtImgRoot ~= nil then
    if self.curGiftPenguin.targetGoal == nil then
      local nFlyAngle = math.deg(math.atan(curVy, self.curGiftPenguin.nVelocityX))
      self.curGiftPenguin.rtImgRoot.localEulerAngles = Vector3(0, 0, nFlyAngle)
    else
      local nCurAngle = self.curGiftPenguin.rtImgRoot.localEulerAngles.z
      local nAngle = 90 * nDeltaTime
      nCurAngle = math.min(nCurAngle + nAngle, 90)
      self.curGiftPenguin.rtImgRoot.localEulerAngles = Vector3(0, 0, nCurAngle)
    end
  end
  for _, tbBounds in ipairs(self.tbObstacle) do
    local bHit = self:CheckCollision(self.curGiftPenguin.tbBounds, tbBounds, nSumX, nSumY, 0, 0)
    if bHit then
      print("hit Obstacle")
      self:DestroyPenguin()
      self.curGiftPenguin = nil
      self.bFlying = false
      break
    end
  end
  if not self.bFlying then
    return
  end
  if nCurPosX > 0.5 * self.sceneSize[1] or nCurPosX < -0.5 * self.sceneSize[1] or nCurPosY > 0.5 * self.sceneSize[2] or nCurPosY < -0.5 * self.sceneSize[2] then
    print("hit border")
    self:DestroyPenguin()
    self.bFlying = false
  end
  if not self.bFlying then
    return
  end
  local tbHittedObs = {}
  for _, nSpecialId in ipairs(self.tbExObstacleCur) do
    local mapConfig = self.mapExObstacleOrigin[nSpecialId]
    if mapConfig ~= nil then
      local bHit = self:CheckCollision(self.curGiftPenguin.tbBounds, mapConfig.tbBounds, nSumX, nSumY, 0, 0)
      if bHit then
        local nType, Param, bRemove
        self.bFlying, nType, Param, bRemove = self:HitSpecialObstacle(nSpecialId)
        self:SpecialObstacleFunc(self.curGiftPenguin, nDeltaTime, nType, Param)
        if bRemove then
          table.insert(tbHittedObs, nSpecialId)
        end
        if not self.bFlying then
          self:DestroyPenguin()
          break
        end
      end
    end
  end
  for _, nId in ipairs(tbHittedObs) do
    table.removebyvalue(self.tbExObstacleCur, nId, true)
  end
  return nCurPosX, nCurPosY
end

function ThrowGiftsLevelCtrl:SplitPenguinUpdate(nDeltaTime)
  local nCurPosX, nCurPosY = 0, 0
  local tbCachedGoalId = {}
  
  local function Split(mapPenguin, nAngle, nVelocity, initPos)
    mapPenguin.bSplit = true
    local goPenguin = instantiate(self._mapNode.templateBullet, self._mapNode.rtPenguinRoot)
    local rtPenguin = goPenguin:GetComponent("RectTransform")
    local goImgRoot = rtPenguin:Find("imgRoot")
    local imgFx = goImgRoot:Find("imgFx")
    local rtRed = goImgRoot:Find("penguin_red")
    local rtYellow = goImgRoot:Find("penguin_yellow")
    local rtGreen = goImgRoot:Find("penguin_green")
    local rtGoggles = goImgRoot:Find("penguin_goggles")
    local rtAntenna = goImgRoot:Find("penguin_antenna")
    local rtHelmet = goImgRoot:Find("penguin_helmet")
    local rtImgRoot
    if goImgRoot ~= nil then
      rtImgRoot = goImgRoot:GetComponent("RectTransform")
    end
    rtPenguin.anchoredPosition = initPos
    rtRed.gameObject:SetActive(mapPenguin.nType == 2)
    rtYellow.gameObject:SetActive(mapPenguin.nType == 3)
    rtGreen.gameObject:SetActive(mapPenguin.nType == 1)
    rtGoggles.gameObject:SetActive(false)
    rtAntenna.gameObject:SetActive(false)
    rtHelmet.gameObject:SetActive(false)
    imgFx.gameObject:SetActive(self.mapCurActiveState[105] ~= nil)
    rtPenguin.anchoredPosition = initPos
    goPenguin:SetActive(true)
    local mapGiftPenguin = {
      goGiftPenguin = rtPenguin,
      nState = 0,
      nType = mapPenguin.nType,
      nStartAngle = nAngle,
      nVelocityX = nVelocity * math.cos(math.rad(nAngle)),
      nVelocityY = nVelocity * math.sin(math.rad(nAngle)),
      mapStartPos = initPos,
      rtImgRoot = rtImgRoot,
      tbBounds = self:GetLocalSpaceRect(rtPenguin, rtPenguin.parent),
      curPosX = initPos.x,
      curPosY = initPos.y,
      bFlying = true,
      nHitTime = 0
    }
    return mapGiftPenguin
  end
  
  if self.curGiftPenguin.bSplit then
    local bHasSubPenguin = false
    self.nFlyingTime = self.nFlyingTime + nDeltaTime
    for _, mapSubPenguin in ipairs(self.curGiftPenguin.tbSubPenguin) do
      if mapSubPenguin.bFlying then
        nCurPosX = mapSubPenguin.curPosX + nDeltaTime * mapSubPenguin.nVelocityX
        nCurPosY = mapSubPenguin.curPosY + nDeltaTime * mapSubPenguin.nVelocityY - 0.5 * self.nAG * nDeltaTime * nDeltaTime
        mapSubPenguin.nVelocityY = mapSubPenguin.nVelocityY - self.nAG * nDeltaTime
        mapSubPenguin.curPosX = nCurPosX
        mapSubPenguin.curPosY = nCurPosY
        mapSubPenguin.goGiftPenguin.anchoredPosition = Vector2(nCurPosX, nCurPosY)
        local nSumX = nCurPosX - mapSubPenguin.mapStartPos.x
        local nSumY = nCurPosY - mapSubPenguin.mapStartPos.y
        local curVy = mapSubPenguin.nVelocityY
        if mapSubPenguin.rtImgRoot ~= nil then
          local nFlyAngle = math.deg(math.atan(curVy, mapSubPenguin.nVelocityX))
          mapSubPenguin.rtImgRoot.localEulerAngles = Vector3(0, 0, nFlyAngle)
        end
        for _, tbBounds in ipairs(self.tbObstacle) do
          local bHit = self:CheckCollision(mapSubPenguin.tbBounds, tbBounds, nSumX, nSumY, 0, 0)
          if bHit then
            print("hit Obstacle")
            self:DestroySubPenguin(mapSubPenguin)
            mapSubPenguin.bFlying = false
            break
          end
        end
        if mapSubPenguin.bFlying and (nCurPosX > 0.5 * self.sceneSize[1] or nCurPosX < -0.5 * self.sceneSize[1] or nCurPosY > 0.5 * self.sceneSize[2] or nCurPosY < -0.5 * self.sceneSize[2]) then
          print("hit border")
          self:DestroySubPenguin(mapSubPenguin)
          mapSubPenguin.bFlying = false
        end
        if mapSubPenguin.bFlying then
          local tbHittedObs = {}
          for _, nSpecialId in ipairs(self.tbExObstacleCur) do
            local mapConfig = self.mapExObstacleOrigin[nSpecialId]
            if mapConfig ~= nil then
              local bHit = self:CheckCollision(mapSubPenguin.tbBounds, mapConfig.tbBounds, nSumX, nSumY, 0, 0)
              if bHit then
                local nType, Param, bRemove
                mapSubPenguin.bFlying, nType, Param, bRemove = self:HitSpecialObstacle(nSpecialId)
                self:SpecialObstacleFunc(mapSubPenguin, nDeltaTime, nType, Param)
                if bRemove then
                  table.insert(tbHittedObs, nSpecialId)
                end
                if not mapSubPenguin.bFlying then
                  self:DestroySubPenguin(mapSubPenguin)
                  break
                end
              end
            end
          end
          for _, nId in ipairs(tbHittedObs) do
            table.removebyvalue(self.tbExObstacleCur, nId, true)
          end
        end
        if mapSubPenguin.bFlying then
          bHasSubPenguin = true
        end
      end
    end
    self.bFlying = bHasSubPenguin
    if not self.bFlying then
      tbCachedGoalId = clone(self.curGiftPenguin.tbCacheSubPenguinGoal)
      self.curGiftPenguin = nil
    end
  else
    self.nFlyingTime = self.nFlyingTime + nDeltaTime
    nCurPosX = self.curGiftPenguin.curPosX + nDeltaTime * self.curGiftPenguin.nVelocityX
    nCurPosY = self.curGiftPenguin.curPosY + nDeltaTime * self.curGiftPenguin.nVelocityY - 0.5 * self.nAG * nDeltaTime * nDeltaTime
    self.curGiftPenguin.nVelocityY = self.curGiftPenguin.nVelocityY - self.nAG * nDeltaTime
    self.curGiftPenguin.curPosX = nCurPosX
    self.curGiftPenguin.curPosY = nCurPosY
    self.curGiftPenguin.goGiftPenguin.anchoredPosition = Vector2(nCurPosX, nCurPosY)
    local nSumX = nCurPosX - self.curGiftPenguin.mapStartPos.x
    local nSumY = nCurPosY - self.curGiftPenguin.mapStartPos.y
    local curVy = self.curGiftPenguin.nVelocityY
    if self.curGiftPenguin.rtImgRoot ~= nil then
      local nFlyAngle = math.deg(math.atan(curVy, self.curGiftPenguin.nVelocityX))
      self.curGiftPenguin.rtImgRoot.localEulerAngles = Vector3(0, 0, nFlyAngle)
    end
    for _, tbBounds in ipairs(self.tbObstacle) do
      local bHit = self:CheckCollision(self.curGiftPenguin.tbBounds, tbBounds, nSumX, nSumY, 0, 0)
      if bHit then
        self:DestroyPenguin()
        self.bFlying = false
        break
      end
    end
    if not self.bFlying then
      return 0, 0, tbCachedGoalId
    end
    if nCurPosX > 0.5 * self.sceneSize[1] or nCurPosX < -0.5 * self.sceneSize[1] or nCurPosY > 0.5 * self.sceneSize[2] or nCurPosY < -0.5 * self.sceneSize[2] then
      print("hit border")
      self:DestroyPenguin()
      self.bFlying = false
    end
    if not self.bFlying then
      return 0, 0, {}
    end
    local tbHittedObs = {}
    for _, nSpecialId in ipairs(self.tbExObstacleCur) do
      local mapConfig = self.mapExObstacleOrigin[nSpecialId]
      if mapConfig ~= nil then
        local bHit = self:CheckCollision(self.curGiftPenguin.tbBounds, mapConfig.tbBounds, nSumX, nSumY, 0, 0)
        if bHit then
          local nType, Param, bRemove
          self.bFlying, nType, Param, bRemove = self:HitSpecialObstacle(nSpecialId)
          self:SpecialObstacleFunc(self.curGiftPenguin, nDeltaTime, nType, Param)
          if bRemove then
            table.insert(tbHittedObs, nSpecialId)
          end
          if not self.bFlying then
            self:DestroyPenguin()
            break
          end
        end
      end
    end
    for _, nId in ipairs(tbHittedObs) do
      table.removebyvalue(self.tbExObstacleCur, nId, true)
    end
    if self.bFlying and curVy <= 0 then
      self.curGiftPenguin.bSplit = true
      local initPos = self.curGiftPenguin.goGiftPenguin.anchoredPosition
      local nCurVelocity = math.sqrt(self.curGiftPenguin.nVelocityY * self.curGiftPenguin.nVelocityY + self.curGiftPenguin.nVelocityX * self.curGiftPenguin.nVelocityX)
      local nFlyAngle = math.deg(math.atan(self.curGiftPenguin.nVelocityY, self.curGiftPenguin.nVelocityX))
      for i = -1, 1 do
        local mapSubPenguin = Split(self.curGiftPenguin, nFlyAngle + 20 * i, nCurVelocity, initPos)
        table.insert(self.curGiftPenguin.tbSubPenguin, mapSubPenguin)
      end
      WwiseAudioMgr:PostEvent("Mode_Present_split")
      self:DestroySubPenguin(self.curGiftPenguin, true)
    end
  end
  return nCurPosX, nCurPosY, tbCachedGoalId
end

function ThrowGiftsLevelCtrl:SetBeginningAngle(nAngle, nVelocity)
  local fixedAngle = nAngle == 0 and 0 or nAngle - 90
  self._mapNode.rtBottle.localEulerAngles = Vector3(0, 0, fixedAngle)
  self._mapNode.goBeginningMark.transform.localEulerAngles = Vector3(0, 0, fixedAngle)
  local sumScale = nVelocity / self.maxVelocity * 0.2
  local sumHeight = nVelocity / self.maxVelocity * 3
  self._mapNode.rtBottle.localScale = Vector3(1 + sumScale, 1 - sumScale, 1)
  self._mapNode.rtBeginningMark.sizeDelta = Vector2(nMarkWidth, nMarkHeight * (1 + sumHeight))
end

function ThrowGiftsLevelCtrl:SetBeginningLine(nAngle, nVelocity)
  if self.curPenguinSpecialType == 106 then
    if nVelocity == 0 then
      self._mapNode.rtBeginningLine.gameObject:SetActive(false)
      return
    end
    self._mapNode.rtBeginningLine.gameObject:SetActive(true)
    self._mapNode.rtBeginningLine.position = self._mapNode.rtBeginningPos.position
    local vX = nVelocity * math.cos(math.rad(nAngle))
    local vY = nVelocity * math.sin(math.rad(nAngle))
    local t_stop = vY / self.nAG
    if t_stop < 0 then
      t_stop = 0
    end
    for i = 1, 30 do
      if i <= 10 then
        local dotx = self.nLinePointInterval * i * vX
        local dotY = 0
        if t_stop >= self.nLinePointInterval * i then
          dotY = self.nLinePointInterval * i * vY - 0.5 * self.nAG * (self.nLinePointInterval * i) * (self.nLinePointInterval * i)
        else
          dotY = t_stop * vY - 0.5 * self.nAG * t_stop * t_stop
        end
        self._mapNode.BeginningDot[i].anchoredPosition = Vector2(dotx, dotY)
        self._mapNode.BeginningDot[i].gameObject:SetActive(true)
      else
        self._mapNode.BeginningDot[i].gameObject:SetActive(false)
      end
    end
  elseif self.curPenguinSpecialType == 108 then
    if nVelocity == 0 then
      self._mapNode.rtBeginningLine.gameObject:SetActive(false)
      return
    end
    self._mapNode.rtBeginningLine.gameObject:SetActive(true)
    self._mapNode.rtBeginningLine.position = self._mapNode.rtBeginningPos.position
    local vX = nVelocity * math.cos(math.rad(nAngle))
    local vY = nVelocity * math.sin(math.rad(nAngle))
    for i = 1, 30 do
      local dotx = self.nLinePointInterval * i * vX
      local dotY = self.nLinePointInterval * i * vY - 0.5 * self.nAG * (self.nLinePointInterval * i) * (self.nLinePointInterval * i)
      self._mapNode.BeginningDot[i].anchoredPosition = Vector2(dotx, dotY)
      self._mapNode.BeginningDot[i].gameObject:SetActive(true)
    end
  else
    if nVelocity == 0 then
      self._mapNode.rtBeginningLine.gameObject:SetActive(false)
      return
    end
    self._mapNode.rtBeginningLine.gameObject:SetActive(true)
    self._mapNode.rtBeginningLine.position = self._mapNode.rtBeginningPos.position
    local vX = nVelocity * math.cos(math.rad(nAngle))
    local vY = nVelocity * math.sin(math.rad(nAngle))
    for i = 1, 30 do
      if i <= 10 then
        local dotx = self.nLinePointInterval * i * vX
        local dotY = self.nLinePointInterval * i * vY - 0.5 * self.nAG * (self.nLinePointInterval * i) * (self.nLinePointInterval * i)
        self._mapNode.BeginningDot[i].anchoredPosition = Vector2(dotx, dotY)
        self._mapNode.BeginningDot[i].gameObject:SetActive(true)
      else
        self._mapNode.BeginningDot[i].gameObject:SetActive(false)
      end
    end
  end
end

function ThrowGiftsLevelCtrl:HitSpecialObstacle(nSpecialId)
  local mapOriginConfig = self.mapExObstacleOrigin[nSpecialId]
  local nType = 0
  local Param = {}
  if mapOriginConfig ~= nil then
    if mapOriginConfig.mapConfig.Type == GameEnum.SpecialObstacleType.Obstacle then
      mapOriginConfig.gameObject:SetActive(false)
      return false, nType, Param, true
    elseif mapOriginConfig.mapConfig.Type == GameEnum.SpecialObstacleType.Score then
      mapOriginConfig.gameObject:SetActive(false)
      local nScore = mapOriginConfig.mapConfig.Param[1]
      if nScore ~= nil then
        self:AddScore(nScore)
      end
      return true, nType, Param, true
    elseif mapOriginConfig.mapConfig.Type == GameEnum.SpecialObstacleType.WindForce then
      nType = 1
      Param.WindForce = mapOriginConfig.mapConfig.Param[1] * 10
      Param.nAngle = mapOriginConfig.gameObject.transform.localEulerAngles.z
      return true, nType, Param, false
    elseif mapOriginConfig.mapConfig.Type == GameEnum.SpecialObstacleType.Portal then
      nType = 2
      Param.Exit = mapOriginConfig.mapConfig.Param[1]
      return true, nType, Param, false
    end
  end
  return true, nType, Param, true
end

function ThrowGiftsLevelCtrl:SpecialObstacleFunc(mapPenguin, nDeltaTime, nType, Param)
  if nType == nil or Param == nil then
    return
  end
  if nType == 1 then
    local nAcceleration = Param.WindForce * nDeltaTime
    local nAccelerationX = nAcceleration * math.cos(math.rad(Param.nAngle))
    local nAccelerationY = nAcceleration * math.sin(math.rad(Param.nAngle))
    mapPenguin.nVelocityX = mapPenguin.nVelocityX + nAccelerationX
    mapPenguin.nVelocityY = mapPenguin.nVelocityY + nAccelerationY
  elseif nType == 2 then
    WwiseAudioMgr:PostEvent("Mode_Present_portals")
    local nExitId = Param.Exit
    local mapExitConfig
    for nInstanceId, mapObstacle in pairs(self.mapExObstacleOrigin) do
      if mapObstacle.mapConfig.Id == nExitId then
        mapExitConfig = mapObstacle
        break
      end
    end
    if mapExitConfig ~= nil then
      local rtExit = mapExitConfig.gameObject:GetComponent("RectTransform")
      local nCurVelocity = math.sqrt(mapPenguin.nVelocityY * mapPenguin.nVelocityY + mapPenguin.nVelocityX * mapPenguin.nVelocityX)
      local nFlyAngle = rtExit.localEulerAngles.z
      mapPenguin.goGiftPenguin.anchoredPosition = rtExit.anchoredPosition
      mapPenguin.nVelocityX = nCurVelocity * math.cos(math.rad(nFlyAngle))
      mapPenguin.nVelocityY = nCurVelocity * math.sin(math.rad(nFlyAngle))
      mapPenguin.tbBounds = self:GetLocalSpaceRect(mapPenguin.goGiftPenguin.transform, mapPenguin.goGiftPenguin.transform.parent)
      mapPenguin.curPosX = rtExit.anchoredPosition.x
      mapPenguin.curPosY = rtExit.anchoredPosition.y
      mapPenguin.mapStartPos = rtExit.anchoredPosition
    end
  end
end

function ThrowGiftsLevelCtrl:AddScore(nScore)
  self.nLevelScore = self.nLevelScore + nScore
  if self.mapCurActiveState[104] ~= nil then
    self.nLevelScore = self.nLevelScore + nScore
  end
  self.parent:SetScore(self.nLevelScore)
end

function ThrowGiftsLevelCtrl:SetPenguinType(rtPenguinRoot, nType, nSpecialType)
  if rtPenguinRoot == nil then
    return
  end
  local rtRed = rtPenguinRoot:Find("penguin_red")
  local rtYellow = rtPenguinRoot:Find("penguin_yellow")
  local rtGreen = rtPenguinRoot:Find("penguin_green")
  local rtGoggles = rtPenguinRoot:Find("penguin_goggles")
  local rtAntenna = rtPenguinRoot:Find("penguin_antenna")
  local rtHelmet = rtPenguinRoot:Find("penguin_helmet")
  local rtSplit = rtPenguinRoot:Find("Penguin_split")
  local rtSpring = rtPenguinRoot:Find("Penguin_spring")
  local imgFx = rtPenguinRoot:Find("imgFx")
  rtRed.gameObject:SetActive(nType == 2)
  rtYellow.gameObject:SetActive(nType == 3)
  rtGreen.gameObject:SetActive(nType == 1)
  rtGoggles.gameObject:SetActive(nSpecialType == 106)
  rtAntenna.gameObject:SetActive(nSpecialType == 108)
  rtHelmet.gameObject:SetActive(nSpecialType == 107)
  if rtSplit ~= nil then
    rtSplit.gameObject:SetActive(nSpecialType == 110)
    rtSpring.gameObject:SetActive(nSpecialType == 109)
  end
  imgFx.gameObject:SetActive(self.mapCurActiveState[105] ~= nil)
end

function ThrowGiftsLevelCtrl:CreateGoal(nSpawnPointId, mapConfig)
  if self.activeGoal[nSpawnPointId] ~= nil then
    return
  end
  local pointOriginPosX = mapConfig.rtPoint.anchoredPosition.x
  local pointOriginPosY = mapConfig.rtPoint.anchoredPosition.y
  local randomX = math.random(-mapConfig.mapConfig.SpawnRangeTypeX, mapConfig.mapConfig.SpawnRangeTypeX)
  local randomY = math.random(-mapConfig.mapConfig.SpawnRangeTypeY, mapConfig.mapConfig.SpawnRangeTypeY)
  local nType = 0
  if mapConfig.mapConfig.IsRandom then
    nType = mapConfig.mapConfig.GoalType[math.random(1, #mapConfig.mapConfig.GoalType)]
  else
    if mapConfig.nCurGoalIdx > #mapConfig.mapConfig.GoalType then
      mapConfig.nCurGoalIdx = 1
    end
    nType = mapConfig.mapConfig.GoalType[mapConfig.nCurGoalIdx]
    mapConfig.nCurGoalIdx = mapConfig.nCurGoalIdx + 1
  end
  local sPath = string.format(self.rootPath, nType)
  local goGoalPerfab = GameResourceLoader.LoadAsset(ResTypeAny, Settings.AB_ROOT_PATH .. sPath, typeof(Object))
  if goGoalPerfab ~= nil then
    local goGoal = instantiate(goGoalPerfab, self._mapNode.rtGoalRoot)
    self.activeGoal[nSpawnPointId] = {}
    local rtGoal = goGoal:GetComponent("RectTransform")
    rtGoal.anchoredPosition = Vector2(pointOriginPosX + randomX, pointOriginPosY + randomY)
    local rtHitArea = rtGoal:Find("HitArea")
    local rtObstacle = rtGoal:Find("Obstacle")
    local rtItemBuff = rtGoal:Find("AnimRoot/imgItembuff")
    if rtItemBuff ~= nil then
      rtItemBuff.gameObject:SetActive(0 < mapConfig.mapConfig.ItemPool)
    end
    if rtHitArea == nil or rtObstacle == nil then
      printError("预制体结构错误：" .. sPath)
      destroy(goGoal)
      return
    end
    self.activeGoal[nSpawnPointId].rtGoal = rtGoal
    self.activeGoal[nSpawnPointId].nType = nType
    local rtCompHitArea = rtHitArea:GetComponent("RectTransform")
    local rtCompObstacle = rtObstacle:GetComponent("RectTransform")
    self.activeGoal[nSpawnPointId].tbBoundsHitArea = self:GetLocalSpaceRect(rtCompHitArea, rtGoal.parent)
    self.activeGoal[nSpawnPointId].tbBoundsObstacle = self:GetLocalSpaceRect(rtCompObstacle, rtGoal.parent)
    self.activeGoal[nSpawnPointId].OffsetX = 0
    self.activeGoal[nSpawnPointId].OffsetY = 0
    self.activeGoal[nSpawnPointId].initialPosX = pointOriginPosX + randomX
    self.activeGoal[nSpawnPointId].initialPosY = pointOriginPosY + randomY
    local TMPNode
    local rtTMPScore = rtGoal:Find("AnimRoot/TMPLevelScoreAdd")
    if rtTMPScore ~= nil then
      TMPNode = rtTMPScore:GetComponent("TMP_Text")
    end
    self.activeGoal[nSpawnPointId].TMPScore = TMPNode
  end
end

function ThrowGiftsLevelCtrl:CreateThrowPenguin(nAngle, nVelocity, initPos, nType, nSpecialType)
  self._mapNode.imgBeginningHint:SetActive(false)
  local goPenguin = instantiate(self._mapNode.templateBullet, self._mapNode.rtPenguinRoot)
  local rtPenguin = goPenguin:GetComponent("RectTransform")
  local goImgRoot = rtPenguin:Find("imgRoot")
  local imgFx = goImgRoot:Find("imgFx")
  local rtRed = goImgRoot:Find("penguin_red")
  local rtYellow = goImgRoot:Find("penguin_yellow")
  local rtGreen = goImgRoot:Find("penguin_green")
  local rtGoggles = goImgRoot:Find("penguin_goggles")
  local rtAntenna = goImgRoot:Find("penguin_antenna")
  local rtHelmet = goImgRoot:Find("penguin_helmet")
  local rtSplit = goImgRoot:Find("Penguin_split")
  local rtSpring = goImgRoot:Find("Penguin_spring")
  local rtImgRoot
  if goImgRoot ~= nil then
    rtImgRoot = goImgRoot:GetComponent("RectTransform")
  end
  rtRed.gameObject:SetActive(nType == 2)
  rtYellow.gameObject:SetActive(nType == 3)
  rtGreen.gameObject:SetActive(nType == 1)
  rtGoggles.gameObject:SetActive(nSpecialType == 106)
  rtAntenna.gameObject:SetActive(nSpecialType == 108)
  rtHelmet.gameObject:SetActive(nSpecialType == 107)
  rtSplit.gameObject:SetActive(nSpecialType == 110)
  rtSpring.gameObject:SetActive(nSpecialType == 109)
  imgFx.gameObject:SetActive(self.mapCurActiveState[105] ~= nil)
  rtPenguin.anchoredPosition = initPos
  goPenguin:SetActive(true)
  if self.mapLevelCfgData.FlightPath == true then
    self._mapNode.rtBlindLevelTrack:Reset()
  end
  local mapGiftPenguin = {
    goGiftPenguin = rtPenguin,
    nState = 0,
    nSpecialType = nSpecialType,
    nType = nType,
    nStartAngle = nAngle,
    nVelocityX = nVelocity * math.cos(math.rad(nAngle)),
    nVelocityY = nVelocity * math.sin(math.rad(nAngle)),
    mapStartPos = initPos,
    rtImgRoot = rtImgRoot,
    tbBounds = self:GetLocalSpaceRect(rtPenguin, rtPenguin.parent),
    curPosX = initPos.x,
    curPosY = initPos.y,
    targetGoal = nil,
    nGetTargetTime = 0,
    nTrackIdx = 0,
    nHitCount = 0,
    tbSubPenguin = {},
    bSplit = false,
    tbCacheSubPenguinGoal = {},
    nHitTime = 0
  }
  if nSpecialType == 108 then
    local rtTrack = instantiate(self._mapNode.rtTemplateTrack, self._mapNode.rtScene)
    rtTrack.transform:SetAsFirstSibling()
    rtTrack:SetActive(true)
    local mapTrackCtrl = self:BindCtrlByNode(rtTrack.gameObject, "Game.UI.Activity.ThrowGifts.ThrowGiftLevelTrackLineCtrl")
    mapTrackCtrl:Reset()
    table.insert(self.tbItemTrackCtrl, mapTrackCtrl)
    mapGiftPenguin.nTrackIdx = #self.tbItemTrackCtrl
  end
  return mapGiftPenguin
end

function ThrowGiftsLevelCtrl:HitGoal(hitPos, hitGoalId)
  local mapSpawnPointData = self.mapGoal[hitGoalId]
  if mapSpawnPointData == nil then
    return
  end
  local mapCurGoalCfg = self.activeGoal[hitGoalId]
  if mapCurGoalCfg == nil then
    return
  end
  if self.tbGuideTrackCtrl ~= nil and #self.tbGuideTrackCtrl ~= 0 then
    self:ClearGuideLine()
  end
  local nType = self.activeGoal[hitGoalId].nType % 10
  local nScore = (self.curPenguinType == nType or self.mapCurActiveState[105] ~= nil) and 200 or 100
  self:AddScore(nScore)
  if self.activeGoal[hitGoalId].TMPScore ~= nil then
    if self.mapCurActiveState[104] ~= nil then
      nScore = nScore * 2
    end
    NovaAPI.SetTMPText(self.activeGoal[hitGoalId].TMPScore, string.format("+%d", nScore))
  end
  self.nTotalHitGoalCount = self.nTotalHitGoalCount + 1
  WwiseAudioMgr:PostEvent("Mode_Present_in")
  self.activeGoal[hitGoalId] = nil
  
  local function AfterAnim()
    destroy(mapCurGoalCfg.rtGoal.gameObject)
    if mapSpawnPointData.mapConfig.ActiveCond == GameEnum.ThrowGiftSpawnCond.Random then
      local tbRandom = {}
      for _, nCondSpawnId in ipairs(mapSpawnPointData.mapConfig.SpawnParam) do
        if self.activeGoal[nCondSpawnId] == nil then
          table.insert(tbRandom, nCondSpawnId)
        end
      end
      if 0 < #tbRandom then
        local nRandomId = tbRandom[math.random(1, #tbRandom)]
        if nRandomId ~= nil then
          local mapConfig = self.mapGoal[nRandomId]
          if mapConfig ~= nil then
            self:CreateGoal(nRandomId, mapConfig)
          end
        end
      end
    else
      for nId, mapGoalCfg in pairs(self.mapGoal) do
        if mapGoalCfg.mapConfig.ActiveCond > 0 and #mapGoalCfg.mapConfig.SpawnParam > 0 and 0 < table.indexof(mapGoalCfg.mapConfig.SpawnParam, hitGoalId) then
          if mapGoalCfg.mapConfig.ActiveCond == GameEnum.ThrowGiftSpawnCond.Partial then
            if self.activeGoal[nId] == nil then
              self:CreateGoal(nId, mapGoalCfg)
            end
          elseif mapGoalCfg.mapConfig.ActiveCond == GameEnum.ThrowGiftSpawnCond.All then
            table.insert(mapGoalCfg.curCondId, hitGoalId)
            local bActive = true
            for _, nCondSpawnId in ipairs(mapGoalCfg.mapConfig.SpawnParam) do
              if 1 > table.indexof(mapGoalCfg.curCondId, nCondSpawnId) then
                bActive = false
                break
              end
            end
            if bActive and self.activeGoal[nId] == nil then
              mapGoalCfg.curCondId = {}
              self:CreateGoal(nId, mapGoalCfg)
            end
          end
        end
      end
    end
  end
  
  local rtAnimRoot = mapCurGoalCfg.rtGoal:Find("AnimRoot")
  local rtItemBuff = mapCurGoalCfg.rtGoal:Find("AnimRoot/imgItembuff")
  if rtItemBuff ~= nil then
    rtItemBuff.gameObject:SetActive(false)
  end
  if rtAnimRoot == nil then
    AfterAnim()
  else
    local animComp = rtAnimRoot:GetComponent("Animator")
    if animComp == nil then
      AfterAnim()
    else
      animComp:Play("BasketFx_in")
      self:AddTimer(1, 0.5, AfterAnim, true, true, true)
    end
  end
end

function ThrowGiftsLevelCtrl:DestroyPenguin()
  WwiseAudioMgr:PostEvent("Mode_Present_out")
  local tempPenguin = self.curGiftPenguin.goGiftPenguin.gameObject.transform
  self.curGiftPenguin = nil
  
  local function wait()
    destroy(tempPenguin.gameObject)
  end
  
  local imgRoot = tempPenguin:Find("imgRoot")
  local imgSmoke = tempPenguin:Find("imgSmoke")
  if imgRoot == nil or imgSmoke == nil then
    wait()
    return
  end
  imgRoot.gameObject:SetActive(false)
  imgSmoke.gameObject:SetActive(true)
  self:AddTimer(1, 0.5, wait, true, true, true)
end

function ThrowGiftsLevelCtrl:DestroySubPenguin(mapSubPenguin, bMainPenguin)
  if bMainPenguin ~= true then
    WwiseAudioMgr:PostEvent("Mode_Present_out")
  end
  local tempPenguin = mapSubPenguin.goGiftPenguin.gameObject.transform
  
  local function wait()
    destroy(tempPenguin.gameObject)
  end
  
  mapSubPenguin.goGiftPenguin = nil
  local imgRoot = tempPenguin:Find("imgRoot")
  local imgSmoke = tempPenguin:Find("imgSmoke")
  if imgRoot == nil or imgSmoke == nil then
    wait()
    return
  end
  imgRoot.gameObject:SetActive(false)
  imgSmoke.gameObject:SetActive(true)
  self:AddTimer(1, 0.5, wait, true, true, true)
end

function ThrowGiftsLevelCtrl:OnDrag_Beginning(mDrag)
  if self.nLevelType ~= 1 or self.bFlying then
    return
  end
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    local a = self.sceneSize[1] * self.scenePivot[1]
    local b = self.sceneSize[1] / 2
    local c = a - b
    self.curDragBeginPos = {
      x = self._mapNode.rtBeginning.anchoredPosition.x - c,
      y = self._mapNode.rtBeginning.anchoredPosition.y
    }
    local uipos = GameUIUtils.ScreenPointToLocalPoint(mDrag.EventData.position, self._mapNode.rtScene)
    local nSumX = self.curDragBeginPos.x - uipos.x
    local nSumY = self.curDragBeginPos.y - uipos.y
    local nVelocity = 0
    if 0 < nSumX then
      nVelocity = math.sqrt(nSumY * nSumY + nSumX * nSumX) * 2.5
      if nVelocity > self.maxVelocity then
        nVelocity = self.maxVelocity
      elseif nVelocity < 10 then
        nVelocity = 0
      end
    end
    local nAngle = math.atan(nSumY, nSumX) * 180 / math.pi
    if nAngle > self.nAngelMax then
      nAngle = self.nAngelMax
    elseif nAngle < self.nAngleMin then
      nAngle = self.nAngleMin
    end
    self.nCurAngle = nAngle
    if nVelocity < self.minVelovity then
      nVelocity = self.minVelovity
    end
    self.nCurVelocity = nVelocity
    self._mapNode.goBeginningMark:SetActive(true)
    self:SetBeginningAngle(nAngle, nVelocity)
    self:SetBeginningLine(nAngle, nVelocity)
    WwiseAudioMgr:PostEvent("Mode_Present_pre_lp")
    self.parent:SetViewBtn(0)
  elseif mDrag.DragEventType == AllEnum.UIDragType.Drag then
    if self.curDragBeginPos == nil then
      return
    end
    local uipos = GameUIUtils.ScreenPointToLocalPoint(mDrag.EventData.position, self._mapNode.rtScene)
    local nSumX = self.curDragBeginPos.x - uipos.x
    local nSumY = self.curDragBeginPos.y - uipos.y
    local nVelocity = 0
    if 0 < nSumX then
      nVelocity = math.min(1, math.sqrt(nSumY * nSumY + nSumX * nSumX) / 400) * self.maxVelocity
      if nVelocity > self.maxVelocity then
        nVelocity = self.maxVelocity
      elseif nVelocity < 10 then
        nVelocity = 0
      end
    end
    local nAngle = math.atan(nSumY, nSumX) * 180 / math.pi
    if nAngle > self.nAngelMax then
      nAngle = self.nAngelMax
    elseif nAngle < self.nAngleMin then
      nAngle = self.nAngleMin
    end
    self.nCurAngle = nAngle
    if nVelocity < self.minVelovity then
      nVelocity = self.minVelovity
    end
    self.nCurVelocity = nVelocity
    self:SetBeginningAngle(nAngle, nVelocity)
    self:SetBeginningLine(nAngle, nVelocity)
    if self.tbGuideTrackCtrl ~= nil then
      for _, mapLineCtrl in ipairs(self.tbGuideTrackCtrl) do
        mapLineCtrl:SetLineActive(nAngle, nVelocity)
      end
    end
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    WwiseAudioMgr:PostEvent("Mode_Present_pre_lp_stop")
    self._mapNode.goBeginningMark:SetActive(false)
    if self.curDragBeginPos == nil then
      return
    end
    if self.nCurVelocity == 0 then
      if self.mapLevelCfgData.SwitchArrow == true then
        self.parent:SetViewBtn(1)
      end
      self.curDragBeginPos = nil
      return
    end
    self.nTotalThrowGiftCount = self.nTotalThrowGiftCount + 1
    self.curDragBeginPos = nil
    self.bFlying = true
    self.nFlyingTime = 0
    self:SetBeginningAngle(self.nCurAngle, 0)
    self:SetBeginningLine(0, 0)
    local nStartVelocity = self.nCurVelocity
    local nStartAngle = self.nCurAngle
    self.nCurAngle = 0
    self.nCurVelocity = 0
    self._mapNode.rtBottleAnim:Play("rtBottle_out")
    WwiseAudioMgr:PostEvent("Mode_Present_fire")
    
    local function wait()
      local worldPos = self._mapNode.rtBeginningPos:TransformPoint(Vector3.zero)
      local sumPos = self._mapNode.rtBeginning:InverseTransformPoint(worldPos)
      local beginningPos = self._mapNode.rtBeginning.anchoredPosition
      local nSpecialType = self.curPenguinSpecialType == 0 and self.defaultPenguinSpecialType or self.curPenguinSpecialType
      local mapGiftPenguin = self:CreateThrowPenguin(nStartAngle, nStartVelocity, Vector2(beginningPos.x + sumPos.x, beginningPos.y + sumPos.y), self.curPenguinType, nSpecialType)
      self.curPenguinSpecialType = 0
      self.curGiftPenguin = mapGiftPenguin
      if 0 < self.nTotalPenguinCount and self.mapCurActiveState[102] == nil then
        self.nTotalPenguinCount = self.nTotalPenguinCount - 1
      end
      NovaAPI.SetTMPText(self._mapNode.TMPBeginningCountHint, self.nTotalPenguinCount)
    end
    
    self:AddTimer(1, 0.12, wait, true, true, true)
  end
end

return ThrowGiftsLevelCtrl
