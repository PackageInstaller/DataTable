local base = require("Game.Lottery.Ctrl.LotteryCtrlBase")
local LotteryShowCtrl = class("LotteryShowCtrl", base)
local UINLtrShowPoint = require("Game.Lottery.UI.Show.UINLtrShowPoint")
local UINLtrShowRing = require("Game.Lottery.UI.Show.UINLtrShowRing")
local UINLtrSWaveRing = require("Game.Lottery.UI.Show.UINLtrSWaveRing")
local UINLtrSPointBingo = require("Game.Lottery.UI.Show.UINLtrSPointBingo")
local LtrShowCfg = require("Game.Lottery.UI.Show.LtrShowCfg")
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local util = require("XLua.Common.xlua_util")
local cs_ResLoader = CS.ResLoader
local cs_DOTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local cs_Material = CS.UnityEngine.Material
local cs_WaitForSeconds = CS.UnityEngine.WaitForSeconds

function LotteryShowCtrl:ctor()
  self.__OnCamReturnEnd = BindCallback(self, self.__CamReturnEnd)
  self.__MainCoroutineFunc = BindCallback(self, self.__MainCoroutine)
  self.tweenList = {}
  self._auBackDic = {}
end

function LotteryShowCtrl:PlayAllDOTween()
  self.allTweensAnimation = self.bind.ui_buttom.transform:GetComponentsInChildren(typeof(CS.DG.Tweening.DOTweenAnimation))
  for i = 0, self.allTweensAnimation.Length - 1 do
    local tween = self.allTweensAnimation[i]
    tween:DORestart(false)
  end
end

function LotteryShowCtrl:LtrShowStart(showRareList, poolType, notNeedPopPreview)
  AudioManager:RemoveAllVoice()
  self._auBack_Start = AudioManager:PlayAudioById(1042, function()
    self._auBack_Start = nil
  end)
  self.showRareList = showRareList
  self.poolType = poolType
  self.notNeedPopPreview = notNeedPopPreview
  if not self:__LoadRes() then
    self:__OnShowStart()
  end
end

function LotteryShowCtrl:_OnClickStart()
  if self.waitStart then
    if self._auBack_Start ~= nil then
      AudioManager:StopAudioByBack(self._auBack_Start)
      self._auBack_Start = nil
    end
    self.bind.startRingDown:SetActive(true)
    self:_PlayAudio(1044)
    self:__ContinuePlayShow()
    self.waitStart = false
    self.ltrCtrl:ChangeLotteryState(LotteryEnum.eLotteryState.LotteryAnimation)
  end
end

function LotteryShowCtrl:__MainCoroutine()
  self:_ChangeRingMaskSize(1)
  while not self._circle1ScanComplete do
    coroutine.yield(nil)
  end
  coroutine.yield(cs_WaitForSeconds(0.5))
  self:_ShowBingo(self.circle1IndexList, self.circle1PointIndexDic, eHeroCardRareType.R)
  coroutine.yield(cs_WaitForSeconds(1))
  if self.scanPointNum == 0 then
    self:_OnShowEnd()
    return
  end
  self:__ContinuePlayShow()
  self.waveRingPool:HideAll()
  self.showRingPool:HideAll()
  self:_ChangeRingMaskSize(2)
  self:_KillWaveTweens()
  self:_BalckBgTween(1500, 2370, 0.155, 0.278)
  self:_ShowQuality1BingoExit()
  while self.scanPointNum > self.scanWaveEndNum do
    coroutine.yield(nil)
  end
  coroutine.yield(cs_WaitForSeconds(0.5))
  self:_ShowBingo(self.circle2IndexList, self.circle2PointIndexDic, eHeroCardRareType.SR)
  coroutine.yield(cs_WaitForSeconds(1))
  if self.scanPointNum == 0 then
    self:_OnShowEnd()
    return
  end
  self:__ContinuePlayShow()
  self.waveRingPool:HideAll()
  self.showRingPool:HideAll()
  self:_ChangeRingMaskSize(3)
  self:_KillWaveTweens()
  self:_BalckBgTween(2370, 3230, 0.278, 0.388)
  self:_ShowQuality2BingoExit()
  while self.scanPointNum > self.scanWaveEndNum do
    coroutine.yield(nil)
  end
  self.mainCo = nil
  self:_OnShowEnd()
end

function LotteryShowCtrl:_ClearMainCo()
  if self.mainCo ~= nil then
    GR.StopCoroutine(self.mainCo)
    self.mainCo = nil
  end
end

function LotteryShowCtrl:__LoadRes()
  if self.__resLoaded then
    return false
  end
  self.resLoader = cs_ResLoader.Create()
  local path = PathConsts:GetLotteryModelPath("LotteryShow")
  self.resLoader:LoadABAssetAsync(path, function(prefab)
    if prefab == nil then
      return
    end
    self.ltrShowGo = prefab:Instantiate()
    self.bind = {}
    UIUtil.LuaUIBindingTable(self.ltrShowGo, self.bind)
    UIUtil.AddButtonListener(self.bind.btn_start, self, self._OnClickStart)
    local codeActionBinding = self.bind.timeLine:FindComponent(eUnityComponentID.CodeActionBinding)
    codeActionBinding:RegisterAction("WaitStart", BindCallback(self, self.__OnWaitStart))
    codeActionBinding:RegisterAction("StartCamMove", BindCallback(self, self.__OnStartCamMove))
    codeActionBinding:RegisterAction("Quilaty1Stop", BindCallback(self, self.__OnQuilaty1Stop))
    codeActionBinding:RegisterAction("Quilaty2Stop", BindCallback(self, self.__OnQuilaty2Stop))
    codeActionBinding:RegisterAction("Quilaty3Stop", BindCallback(self, self.__OnQuilaty3Stop))
    self.bind.uI_LSPoint:SetActive(false)
    self.showPointPool = UIItemPool.New(UINLtrShowPoint, self.bind.uI_LSPoint)
    self.bind.uI_LSPointBingo:SetActive(false)
    self.pointBingoPool = UIItemPool.New(UINLtrSPointBingo, self.bind.uI_LSPointBingo)
    self.bind.imgRing:SetActive(false)
    self.showRingPool = UIItemPool.New(UINLtrShowRing, self.bind.imgRing)
    self.bind.waveRing:SetActive(false)
    self.waveRingPool = UIItemPool.New(UINLtrSWaveRing, self.bind.waveRing)
    self.__resLoaded = true
    self:__OnShowStart()
  end)
  return true
end

function LotteryShowCtrl:__OnWaitStart()
  self:__StopShowCo()
  self.waitStart = true
  self.ltrCtrl:ChangeLotteryState(LotteryEnum.eLotteryState.WaitStartShow)
end

function LotteryShowCtrl:__OnShowStart()
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  self.waitStart = false
  self.ltrShowGo:SetActive(true)
  self.showPointPool:HideAll()
  self.showRingPool:HideAll()
  self.waveRingPool:HideAll()
  self.pointBingoPool:HideAll()
  self:_SetBlackBgSize(0)
  self.scanWaveEndNum = 0
  self.bind.cM_vcam_1end:SetActive(false)
  self.bind.timeLine.gameObject:SetActive(true)
  self.bind.startRingDown:SetActive(false)
  UIManager:HideWindow(UIWindowTypeID.LotteryWindow)
  self:_ClearMainCo()
  self._circle1ScanComplete = false
  self.mainCo = GR.StartCoroutine(util.cs_generator(self.__MainCoroutineFunc))
  self:__StopShowCo()
  self.bind.timeLine:RebuildGraph()
  self.__ltrShowCo = TimelineUtil.Play(self.bind.timeLine)
  self:PlayAllDOTween()
end

function LotteryShowCtrl:__OnStartCamMove()
  local allCfgNum = #LtrShowCfg.CircleOnePoint
  local allNum = #self.showRareList + math.random(10, 15)
  if allCfgNum < allNum then
    error("LtrShowCfg.CircleOnePoint error")
    return
  end
  self.maxRare = eHeroCardRareType.R
  local tempRIndexList = {}
  for k, rare in ipairs(self.showRareList) do
    if rare == eHeroCardRareType.R then
      table.insert(tempRIndexList, k)
    end
    if rare > self.maxRare then
      self.maxRare = rare
    end
  end
  local randomNum = 0
  local extraScanIndexDic = {}
  if self.poolType == LotteryEnum.eLotteryPoolType.Paid and #self.showRareList == 10 then
    local count = math.random(0, randomNum)
    for i = 1, count do
      local index = math.random(1, #tempRIndexList)
      table.remove(tempRIndexList, index)
      extraScanIndexDic[index] = true
    end
  end
  local tempIndexList = {}
  for i = 1, allCfgNum do
    table.insert(tempIndexList, i)
  end
  self.circle1IndexCfgBingoList = {}
  local indexList = {}
  for i = 1, allNum do
    local randomIndex = math.random(1, #tempIndexList)
    local posCfgIndex = tempIndexList[randomIndex]
    table.remove(tempIndexList, randomIndex)
    local rare = self.showRareList[i]
    local extraScan = extraScanIndexDic[i]
    local tarPosCfg = LtrShowCfg.CircleOnePoint[posCfgIndex]
    local tarPos = Vector2.New(tarPosCfg[1], tarPosCfg[2])
    local startPos = self.bind.uI_LSMainPoint.anchoredPosition
    local sqrMagnt = Vector2.New(startPos.x - tarPos.x, startPos.y - tarPos.y):SqrMagnitude()
    table.insert(indexList, {
      tarPos = tarPos,
      sqrMagnt = sqrMagnt,
      rare = rare,
      extraScan = extraScan
    })
  end
  table.sort(indexList, function(a, b)
    return a.sqrMagnt < b.sqrMagnt
  end)
  self.indexList = indexList
  local pintIndex = 1
  self.circle1PointIndexDic = {}
  self.circle1IndexList = indexList
  for k, v in ipairs(indexList) do
    if v.extraScan or v.rare ~= nil and v.rare > eHeroCardRareType.R then
      table.insert(self.circle1IndexCfgBingoList, k)
    end
  end
  local rareColor = self.bind.rareColorList[eHeroCardRareType.R]
  local waveRing1 = self.waveRingPool:GetOne()
  waveRing1:InitLtrSWaveRing(Vector2.zero, rareColor)
  local showRing1 = self.showRingPool:GetOne()
  showRing1:InitLtrShowRing(self.bind.uI_LSMainPoint.anchoredPosition, rareColor)
  self:_PlayAudio(1045)
  
  local function tweenFunc(x)
    showRing1:SetLtrShowRingSize(Vector2.New(x, x))
    if 1400 < x then
      showRing1:LtrShowRingFade()
    end
    local sqrMagnt = x / 2 * (x / 2)
    local indexCfg = indexList[pintIndex]
    while pintIndex <= #indexList and sqrMagnt >= indexCfg.sqrMagnt do
      local pointItem = self.showPointPool:GetOne()
      local pos = indexCfg.tarPos
      pointItem:InitLtrShowPoint(pos, self.bind.uI_LSMainPoint.anchoredPosition, indexCfg.rare)
      self.circle1PointIndexDic[pintIndex] = pointItem
      pintIndex = pintIndex + 1
      indexCfg = indexList[pintIndex]
    end
    if 720 <= x then
      local size = (x - 720) / 780 * 0.155
      self:_SetBlackBgSize(size)
    end
  end
  
  self.showRare1Tween = cs_DOTween.To(function()
    return 0
  end, function(x)
    local ok, err = xpcall(tweenFunc, debug.traceback, x)
    if not ok then
      error(err)
    end
  end, 1500, 4):SetEase(cs_Ease.OutSine):OnComplete(function()
    self._circle1ScanComplete = true
  end)
  table.insert(self.tweenList, self.showRare1Tween)
end

function LotteryShowCtrl:_ShowBingo(circleIndexList, circlePointIndexDic, curRare)
  self.pointBingoPool:HideAll()
  self.scanPointNum = 0
  for k, v in ipairs(circleIndexList) do
    if v.rare ~= nil then
      local pointItem = circlePointIndexDic[k]
      if curRare < v.rare or v.extraScan then
        local pointBingo = self.pointBingoPool:GetOne()
        pointBingo:InitLtrSPointBingo(v.tarPos)
        pointItem:SetLtrPointBingo(pointBingo)
        self.scanPointNum = self.scanPointNum + 1
      elseif v.rare == curRare then
        pointItem:ShowLtrSPointFlare()
      end
    end
  end
end

function LotteryShowCtrl:_ShowQuality1BingoExit()
  local allCfgNum = #LtrShowCfg.CircleTwoPoint
  local allNum = self.scanPointNum + math.random(5, 10)
  if allCfgNum < allNum then
    error(string.format("LtrShowCfg.CircleTwoPoint error, allNum:%s, allCfgNum:%S", allNum, allCfgNum))
    return
  end
  local tempIndexList = {}
  for i = 1, allCfgNum do
    table.insert(tempIndexList, i)
  end
  local circle2IndexList = {}
  self.circle2IndexList = circle2IndexList
  self.circle2IndexCfgBingoList = {}
  local scanPointIndex = 1
  local randomIndexList = {}
  for i = 1, allNum do
    local index = math.random(1, #tempIndexList)
    local posCfgIndex = tempIndexList[index]
    table.remove(tempIndexList, index)
    local posCfg = LtrShowCfg.CircleTwoPoint[posCfgIndex]
    local tarPos = Vector2.New(posCfg[1], posCfg[2])
    local indexList = randomIndexList[scanPointIndex]
    local isFirst = false
    if indexList == nil then
      indexList = {}
      randomIndexList[scanPointIndex] = indexList
      isFirst = true
    end
    local circle1IndexCfg = self.circle1IndexList[self.circle1IndexCfgBingoList[scanPointIndex]]
    local startPos = circle1IndexCfg.tarPos
    local pointRare
    if isFirst then
      pointRare = circle1IndexCfg.rare
    end
    local sqrMagnt = Vector2.New(startPos.x - tarPos.x, startPos.y - tarPos.y):SqrMagnitude()
    local cfg = {
      scanPointIndex = scanPointIndex,
      tarPos = tarPos,
      sqrMagnt = sqrMagnt,
      rare = pointRare
    }
    table.insert(indexList, cfg)
    if isFirst then
      table.insert(circle2IndexList, cfg)
      if pointRare > eHeroCardRareType.SR then
        table.insert(self.circle2IndexCfgBingoList, #circle2IndexList)
      end
    end
    scanPointIndex = scanPointIndex + 1
    if scanPointIndex > self.scanPointNum then
      scanPointIndex = 1
    end
  end
  for k, v in pairs(randomIndexList) do
    table.sort(v, function(a, b)
      return a.sqrMagnt < b.sqrMagnt
    end)
  end
  scanPointIndex = 1
  self.circle2PointIndexDic = {}
  local isLastCircle = self.maxRare == eHeroCardRareType.SR
  for k, v in ipairs(self.circle1IndexCfgBingoList) do
    local pointItem = self.circle1PointIndexDic[v]
    local pointBingo = pointItem:GetLtrPointBingo()
    pointBingo:PlayLtrSPointBingoExit()
    coroutine.yield(cs_WaitForSeconds(0.5))
    local circle1IndexCfg = self.circle1IndexList[v]
    local rareColor = self.bind.rareColorList[eHeroCardRareType.SR]
    local pointItem = self.circle1PointIndexDic[v]
    local indexList = randomIndexList[scanPointIndex]
    self:_PlayAudio(1046)
    self:_ShowScanWave(rareColor, pointItem, circle1IndexCfg.extraScan, indexList, isLastCircle)
    scanPointIndex = scanPointIndex + 1
  end
end

function LotteryShowCtrl:_ShowScanWave(rareColor, pointItem, isExtra, indexList, isCircleLast)
  local waveRingItem = self.waveRingPool:GetOne()
  local fromItem = pointItem
  local centerPos = pointItem.transform.anchoredPosition
  local pos = centerPos - self.bind.uI_LSMainPoint.anchoredPosition
  pos = pos * 1024 / 3230
  waveRingItem:InitLtrSWaveRing(pos, rareColor)
  local pointIndex = 1
  local ringItem = self.showRingPool:GetOne()
  ringItem:InitLtrShowRing(centerPos, rareColor)
  local scanOk = false
  
  local function tweenFunc(x)
    ringItem:SetLtrShowRingSize(Vector2.New(x, x))
    if 1500 < x then
      ringItem:LtrShowRingFade()
    end
    local sqrMagnt = x / 2 * (x / 2)
    local indexCfg = indexList[pointIndex]
    while pointIndex <= #indexList and sqrMagnt >= indexCfg.sqrMagnt do
      local pointItem = self.showPointPool:GetOne()
      local pos = indexCfg.tarPos
      pointItem:InitLtrShowPoint(pos, centerPos, indexCfg.rare, fromItem)
      if indexCfg.rare ~= nil then
        if isCircleLast then
          pointItem:ShowLtrSPointFlare()
        end
        self.circle2PointIndexDic[indexCfg.scanPointIndex] = pointItem
        self.scanWaveEndNum = self.scanWaveEndNum + 1
        scanOk = true
      end
      pointIndex = pointIndex + 1
      indexCfg = indexList[pointIndex]
    end
  end
  
  self.showScanTween = cs_DOTween.To(function()
    return 0
  end, function(x)
    local ok, err = xpcall(tweenFunc, debug.traceback, x)
    if not ok then
      error(err)
    end
  end, 2500, 6.67):SetEase(cs_Ease.OutSine):OnComplete(function()
    if isExtra then
      pointItem:ShowLtrSPointFlare()
    end
    if not scanOk then
      self.scanWaveEndNum = self.scanWaveEndNum + 1
    end
  end)
  table.insert(self.tweenList, self.showScanTween)
end

function LotteryShowCtrl:_BalckBgTween(from, to, balckBgSizeFrom, balckBgSizeTo, delayTime)
  if delayTime == nil then
    delayTime = 1.4
  end
  
  local function tweenFunc(x)
    local size = (x - from) / (to - from) * (balckBgSizeTo - balckBgSizeFrom) + balckBgSizeFrom
    self:_SetBlackBgSize(size)
  end
  
  self._blackBgTween = cs_DOTween.To(function()
    return from
  end, function(x)
    local ok, err = xpcall(tweenFunc, debug.traceback, x)
    if not ok then
      error(err)
    end
  end, to, 4):SetEase(cs_Ease.OutSine):SetDelay(delayTime)
  table.insert(self.tweenList, self._blackBgTween)
end

function LotteryShowCtrl:__OnQuilaty1Stop()
  self:__StopShowCo()
end

function LotteryShowCtrl:__OnQuilaty2Stop()
  self:__StopShowCo()
end

function LotteryShowCtrl:_ShowQuality2BingoExit()
  self.scanWaveEndNum = 0
  local allCfgNum = #LtrShowCfg.CircleThreePoint
  local allNum = self.scanPointNum + math.random(5, 10)
  if allCfgNum < allNum then
    error(string.format("LtrShowCfg.CircleThreePoint error, allNum:%s, allCfgNum:%S", allNum, allCfgNum))
    return
  end
  local tempIndexList = {}
  for i = 1, allCfgNum do
    table.insert(tempIndexList, i)
  end
  local scanPointIndex = 1
  local randomIndexList = {}
  for i = 1, allNum do
    local index = math.random(1, #tempIndexList)
    local posCfgIndex = tempIndexList[index]
    table.remove(tempIndexList, index)
    local posCfg = LtrShowCfg.CircleThreePoint[posCfgIndex]
    local tarPos = Vector2.New(posCfg[1], posCfg[2])
    local indexList = randomIndexList[scanPointIndex]
    local isFirst = false
    if indexList == nil then
      indexList = {}
      randomIndexList[scanPointIndex] = indexList
      isFirst = true
    end
    local circle2IndexCfg = self.circle2IndexList[self.circle2IndexCfgBingoList[scanPointIndex]]
    local startPos = circle2IndexCfg.tarPos
    local pointRare
    if isFirst then
      pointRare = circle2IndexCfg.rare
    end
    local sqrMagnt = Vector2.New(startPos.x - tarPos.x, startPos.y - tarPos.y):SqrMagnitude()
    local cfg = {
      index = index,
      scanPointIndex = scanPointIndex,
      tarPos = tarPos,
      sqrMagnt = sqrMagnt,
      rare = pointRare
    }
    table.insert(indexList, cfg)
    scanPointIndex = scanPointIndex + 1
    if scanPointIndex > self.scanPointNum then
      scanPointIndex = 1
    end
  end
  for k, v in pairs(randomIndexList) do
    table.sort(v, function(a, b)
      return a.sqrMagnt < b.sqrMagnt
    end)
  end
  scanPointIndex = 1
  self.circle3PointIndexDic = {}
  for k, v in ipairs(self.circle2IndexCfgBingoList) do
    local pointItem = self.circle2PointIndexDic[v]
    local pointBingo = pointItem:GetLtrPointBingo()
    pointBingo:PlayLtrSPointBingoExit()
    coroutine.yield(cs_WaitForSeconds(0.5))
    local rareColor = self.bind.rareColorList[eHeroCardRareType.SSR]
    local pointItem = self.circle2PointIndexDic[v]
    local indexList = randomIndexList[scanPointIndex]
    self:_PlayAudio(1047)
    self:_ShowScanWave(rareColor, pointItem, false, indexList, true)
    scanPointIndex = scanPointIndex + 1
  end
end

function LotteryShowCtrl:__OnQuilaty3Stop()
  self:__StopShowCo()
end

function LotteryShowCtrl:_OnShowEnd()
  self:_ClearMainCo()
  self:__CamReturn()
end

function LotteryShowCtrl:__CamReturn()
  self.bind.cM_vcam_1end:SetActive(true)
  self.bind.timeLine.gameObject:SetActive(false)
  self:__StopShowCo()
  self.backTimelineCo = TimelineUtil.Play(self.bind.timeLine_Back, self.__OnCamReturnEnd)
end

function LotteryShowCtrl:__StopBackTimelineCo()
  if self.backTimelineCo ~= nil then
    TimelineUtil.StopTlCo(self.backTimelineCo)
    self.backTimelineCo = nil
  end
end

function LotteryShowCtrl:__CamReturnEnd()
  self.ltrCtrl:LtrShowEnd(nil, self.notNeedPopPreview)
end

function LotteryShowCtrl:__ContinuePlayShow()
  self:__StopShowCo()
  self.__ltrShowCo = TimelineUtil.Play(self.bind.timeLine, nil, true)
end

function LotteryShowCtrl:__StopShowCo()
  if self.__ltrShowCo ~= nil then
    TimelineUtil.StopTlCo(self.__ltrShowCo)
    self.__ltrShowCo = nil
  end
end

function LotteryShowCtrl:_KillWaveTweens()
  while #self.tweenList > 0 do
    local tween = table.remove(self.tweenList)
    if tween ~= nil then
      tween:Kill()
    end
  end
end

function LotteryShowCtrl:SkipShow()
  self:__StopShowCo()
  self:_ClearMainCo()
  self:__StopBackTimelineCo()
  self:_CloseAllAudio()
  self:_KillWaveTweens()
  for i = 0, self.allTweensAnimation.Length - 1 do
    local tween = self.allTweensAnimation[i]
    tween:DOPause()
  end
  self.ltrCtrl:LtrShowEnd(true, self.notNeedPopPreview)
end

function LotteryShowCtrl:_SetBlackBgSize(size)
  if self.blackBgMat == nil then
    self.blackBgMat = cs_Material(self.bind.blackBg.material)
    self.bind.blackBg.material = self.blackBgMat
  end
  self.blackBgMat:SetFloat("_Waiquan", size)
end

function LotteryShowCtrl:HideLtrShow()
  self.ltrShowGo:SetActive(false)
end

function LotteryShowCtrl:_ChangeRingMaskSize(circleId)
  if self.ringMaskMat == nil then
    self.ringMaskMat = cs_Material(self.bind.img_RingMask.material)
    self.bind.img_RingMask.material = self.ringMaskMat
  end
  local cfg = LtrShowCfg.CircleRingMask[circleId]
  self.ringMaskMat:SetFloat("_DAXIAO", cfg.Size)
  self.ringMaskMat:SetFloat("_Waiquan", cfg.OutSize)
end

function LotteryShowCtrl:_PlayAudio(audioId)
  local audioBack = AudioManager:PlayAudioById(audioId, function(auback)
    self._auBackDic[auback] = nil
  end)
  self._auBackDic[audioBack] = true
end

function LotteryShowCtrl:_CloseAllAudio()
  if self._auBack_Start ~= nil then
    AudioManager:StopAudioByBack(self._auBack_Start)
    self._auBack_Start = nil
  end
  for auback, v in pairs(self._auBackDic) do
    AudioManager:StopAudioByBack(auback)
  end
  self._auBackDic = {}
end

function LotteryShowCtrl:OnDelete()
  UIManager:DeleteWindow(UIWindowTypeID.LotteryShow)
  self:__StopShowCo()
  self:_ClearMainCo()
  self:__StopBackTimelineCo()
  self:_CloseAllAudio()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  if self.showPointPool ~= nil then
    self.showPointPool:DeleteAll()
  end
  if self.showRingPool ~= nil then
    self.showRingPool:DeleteAll()
  end
  if self.waveRingPool ~= nil then
    self.waveRingPool:DeleteAll()
  end
  if self.pointBingoPool ~= nil then
    self.pointBingoPool:DeleteAll()
  end
  self:_KillWaveTweens()
  DestroyUnityObject(self.ltrShowGo)
  DestroyUnityObject(self.blackBgMat)
  DestroyUnityObject(self.ringMaskMat)
end

return LotteryShowCtrl
