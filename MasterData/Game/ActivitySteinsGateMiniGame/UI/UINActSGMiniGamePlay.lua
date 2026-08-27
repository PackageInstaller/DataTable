local UINActSGMiniGamePlay = class("UINActSGMiniGamePlay", UIBaseNode)
local base = UIBaseNode
local ActSGMiniGameEnum = require("Game.ActivitySteinsGateMiniGame.Data.ActSGMiniGameEnum")
local UINActSGMiniGameBallPools = require("Game.ActivitySteinsGateMiniGame.UI.UINActSGMiniGameBallPools")
local UINCarnival22Ball = require("Game.ActivityCarnival.UI.CarnivalMiniGame.UINCarnival22Ball")
local UINCarnival22BallEft = require("Game.ActivityCarnival.UI.CarnivalMiniGame.UINCarnival22BallEft")
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_UnityEngine_Time = CS.UnityEngine.Time
local util = require("XLua.Common.xlua_util")
local cs_MessageCommon = CS.MessageCommon
local BORN_INTERVAL = 0.5
local BORN_MAXlEVEL = 5

function UINActSGMiniGamePlay:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.smallBallPools = UINActSGMiniGameBallPools.New()
  self.smallBallPools:Init(self.ui.obj_smallBallpool)
  self.bigBallPools = UINActSGMiniGameBallPools.New()
  self.bigBallPools:Init(self.ui.obj_bigBallpool)
  self._ballEftPool = UIItemPool.New(UINCarnival22BallEft, self.ui.uI_Carnival22MiniGame_click_new)
  self.ui.uI_Carnival22MiniGame_click_new:SetActive(false)
  local collider2DTrigger = CS.ColliderEventListener.Get(self.ui.line)
  collider2DTrigger:TriggerEnter2DEvent("+", BindCallback(self, self.__VirLineEnter))
  collider2DTrigger:TriggerExit2DEvent("+", BindCallback(self, self.__VirLineExit))
  self.__OnGestureStartEvent = BindCallback(self, self.__OnGestureStart)
  self.__OnGestureEvent = BindCallback(self, self.__OnGesture)
  self.__OnGestureEndEvent = BindCallback(self, self.__OnGestureEnd)
  CS_LeanTouch.OnFingerDown("+", self.__OnGestureStartEvent)
  CS_LeanTouch.OnGesture("+", self.__OnGestureEvent)
  CS_LeanTouch.OnFingerUp("+", self.__OnGestureEndEvent)
  self.__ItemCollidingEvent = BindCallback(self, self.__ItemColliding)
  self.__IEDelayBornNewItemEvent = BindCallback(self, self.__IEDelayBornNewItem)
  self._isPause = false
end

function UINActSGMiniGamePlay:InitActSGMiniGamePlay(gameType, gameData, refreshCallback, endCallback)
  self.gameType = gameType
  self._gameData = gameData
  self.refreshCallback = refreshCallback
  self.endCallback = endCallback
  self._ballPools = {}
  local balls = self.gameType == ActSGMiniGameEnum.GameType.MashUp and self.bigBallPools:GetSGMiniGameBalls() or self.smallBallPools:GetSGMiniGameBalls()
  self._maxLevel = #balls
  for i, obj in ipairs(balls) do
    self._ballPools[i] = UIItemPool.New(UINCarnival22Ball, obj)
  end
  self:__OnStartGame()
end

function UINActSGMiniGamePlay:__OnStartGame()
  AudioManager:PlayAudioById(1225)
  self._isPlaying = true
  self._isPause = false
  self._score = 0
  self._gameData:InitPlayData()
  self.ui.tex_Score.text = tostring(self._score)
  self:__Reset()
  self:__TryGenItem()
  self._dowmTimerId = TimerManager:StartTimer(1, self.__CheckFail, self)
end

function UINActSGMiniGamePlay:__OnEndGame()
  self._isPlaying = false
  self.startNum = 0
  self:__Reset()
  local isNewHistory = self._score > self._gameData:GetTinyGameHistoryScore()
  self._gameData:SetNumIsNew(isNewHistory)
  self._gameData:SetNowScore(self._score)
  self._gameData:UploadTinyGameScore(self._score, function()
    if not IsNull(self.transform) and self.refreshCallback then
      self.refreshCallback()
    end
  end)
  if self.endCallback then
    self.endCallback()
  end
end

function UINActSGMiniGamePlay:__Reset()
  for i, poll in pairs(self._ballPools) do
    poll:HideAll()
  end
  for i, eft in ipairs(self._ballEftPool.listItem) do
    eft.transform:SetParent(self.ui.eftPool)
  end
  self._ballEftPool:HideAll()
  self._itemGoDic = {}
  self._collisionLineDic = {}
  self._collisioLineCount = 0
  self._waitItem = nil
  self._nextBornTime = 0
  if self._dowmTimerId ~= nil then
    TimerManager:StopTimer(self._dowmTimerId)
    self._dowmTimerId = nil
  end
  if self._ieDelayBornCo ~= nil then
    GR.StopCoroutine(self._ieDelayBornCo)
    self._ieDelayBornCo = nil
  end
  self._ballToEftDic = {}
end

function UINActSGMiniGamePlay:__TryGenItem()
  if self._waitItem ~= nil then
    return
  end
  local index = self.gameType == ActSGMiniGameEnum.GameType.MashUp and self:_RandomBigger() or self:_SpecialRandomSmall()
  self._waitItem = self:__CreateNewItem(index, Vector3.zero)
  self._waitItem:SetRigidBody(false)
end

local rateDic = {
  [2] = 80,
  [3] = 70,
  [4] = 60,
  [5] = 50
}

function UINActSGMiniGamePlay:_SpecialRandomSmall()
  self.startNum = self.startNum or 0
  self.startNum = self.startNum + 1
  if self.startNum <= 2 then
    self.lastIndex = 2
    return 1
  end
  local ranNum = math.random(2, BORN_MAXlEVEL)
  if self.lastIndex and 1 < self.lastIndex and self.isNeedJudge then
    local num = math.random(1, 100)
    if ranNum == self.lastIndex or num <= rateDic[ranNum] then
      ranNum = self.lastIndex
      self.isNeedJudge = false
      self.lastIndex = nil
      return ranNum
    end
  end
  self.lastIndex = ranNum
  self.isNeedJudge = true
  return ranNum
end

function UINActSGMiniGamePlay:_RandomBigger()
  return math.random(1, BORN_MAXlEVEL)
end

function UINActSGMiniGamePlay:__OnGestureStart(finger)
  if self._isPause then
    return
  end
  local result = CS_LeanTouch.RaycastGui(finger.ScreenPosition)
  if result.Count == 0 or result[0].gameObject ~= self.ui.bk then
    return
  end
  if self._waitItem == nil then
    return
  end
  local leftX, rightX = self:__GetWallBorder()
  local pos = TransitionScreenPoint(UIManager:GetUICamera(), self._waitItem.gameObject, finger.ScreenPosition)
  if rightX < pos.x or leftX > pos.x then
    return
  end
  self._touchIndex = finger.Index
  local itemRadius = self._waitItem:GetColliderRadius()
  if self._dragLimitX == nil then
    self._dragLimitX = {}
  end
  self._dragLimitX.left = leftX + itemRadius
  self._dragLimitX.right = rightX - itemRadius
end

function UINActSGMiniGamePlay:__OnGesture(fingerList)
  if self._waitItem == nil then
    return
  end
  local finger
  for i = 0, fingerList.Count - 1 do
    local item = fingerList[i]
    if item.Index == self._touchIndex then
      finger = item
      break
    end
  end
  if finger == nil then
    return
  end
  local pos = TransitionScreenPoint(UIManager:GetUICamera(), self._waitItem.gameObject, finger.ScreenPosition)
  pos.x = math.clamp(pos.x, self._dragLimitX.left, self._dragLimitX.right)
  pos.y = self._waitItem.transform.localPosition.y
  pos.z = self._waitItem.transform.localPosition.z
  self._waitItem.transform.localPosition = pos
end

function UINActSGMiniGamePlay:__OnGestureEnd(finger)
  if self._touchIndex ~= finger.Index then
    return
  end
  self._touchIndex = nil
  if self._waitItem == nil then
    return
  end
  AudioManager:PlayAudioById(1226)
  self._waitItem:SetRigidBody(true)
  self._waitItem = nil
  local realBornTime = self.gameType == ActSGMiniGameEnum.GameType.MashUp and BORN_INTERVAL or BORN_INTERVAL * 2
  self._nextBornTime = CS_UnityEngine_Time.time + realBornTime
  self._ieDelayBornCo = GR.StartCoroutine(util.cs_generator(self.__IEDelayBornNewItemEvent))
end

function UINActSGMiniGamePlay:__VirLineEnter(other)
  local ball = self._itemGoDic[other.gameObject]
  if ball == nil or self._collisionLineDic[ball] ~= nil then
    return
  end
  self._collisionLineDic[ball] = CS_UnityEngine_Time.time
  self._collisioLineCount = self._collisioLineCount + 1
end

function UINActSGMiniGamePlay:__VirLineExit(other)
  local ball = self._itemGoDic[other.gameObject]
  if ball == nil then
    return
  end
  if self._collisionLineDic[ball] == nil then
    return
  end
  self._collisionLineDic[ball] = nil
  self._collisioLineCount = self._collisioLineCount - 1
end

function UINActSGMiniGamePlay:__ItemColliding(item, other)
  if self._itemGoDic[item.gameObject] == nil then
    return
  end
  local otherItem = self._itemGoDic[other.gameObject]
  if otherItem == nil then
    return
  end
  local nowId = item:GetWaltermelonType()
  if nowId >= self._maxLevel or nowId ~= otherItem:GetWaltermelonType() then
    return
  end
  local nowPos
  local itemSpeed = item:GetRigidSpeed()
  local otherSpeed = otherItem:GetRigidSpeed()
  if itemSpeed.sqrMagnitude < otherSpeed.sqrMagnitude then
    nowPos = item.transform.localPosition
  else
    nowPos = otherItem.transform.localPosition
  end
  nowPos.y = nowPos.y - item:GetColliderRadius()
  self:__CleatOldItem(item)
  self:__CleatOldItem(otherItem)
  local newItem = self:__CreateNewItem(nowId + 1, nowPos)
  self:_CheckPowerEffects(nowId + 1)
  newItem:SetRigidBody(true)
  AudioManager:PlayAudioById(1227)
  self:__ShowCollidingEft(nowId + 1, newItem)
  self._score = self._score + self._gameData:GetMashScore(nowId + 1)
  self.ui.tex_Score.text = tostring(self._score)
end

function UINActSGMiniGamePlay:_CheckPowerEffects(needId)
  if self.powerEffectTimer then
    self.ui.mashUpShow:SetActive(false)
    self.ui.mashDownShow:SetActive(false)
    self.ui.mashDownShow2:SetActive(false)
    TimerManager:StopTimer(self.powerEffectTimer)
    self.powerEffectTimer = nil
  end
  local needObj
  if self.gameType == ActSGMiniGameEnum.GameType.MashUp and needId == self.ui.mash_up_id then
    needObj = self.ui.mashUpShow
  end
  if self.gameType == ActSGMiniGameEnum.GameType.MashDown then
    if needId == self.ui.mash_down_small then
      needObj = self.ui.mashDownShow
    elseif needId == self.ui.mash_down_big then
      needObj = self.ui.mashDownShow2
    end
  end
  if needObj then
    needObj:SetActive(true)
    self.powerEffectTimer = TimerManager:StartTimer(1, function()
      needObj:SetActive(false)
    end, nil, true)
  end
end

function UINActSGMiniGamePlay:__CleatOldItem(item)
  self:__VirLineExit(item.gameObject)
  self._itemGoDic[item.gameObject] = nil
  local pool = self._ballPools[item:GetWaltermelonType()]
  pool:HideOne(item)
  local eft = self._ballToEftDic[item]
  if eft == nil then
    return
  end
  self._ballToEftDic[item] = nil
  if eft.transform:IsChildOf(item.transform) then
    self:__CycleCollidingEft(eft)
  end
end

function UINActSGMiniGamePlay:__CreateNewItem(waltermelonType, pos)
  local newItem = self._ballPools[waltermelonType]:GetOne()
  newItem.transform:SetParent(self.ui.imgHolder.transform)
  newItem:InitWaltermelonItem(waltermelonType, self.__ItemCollidingEvent)
  self._itemGoDic[newItem.gameObject] = newItem
  pos.y = pos.y + newItem:GetColliderRadius()
  newItem.transform.localPosition = pos
  return newItem
end

function UINActSGMiniGamePlay:__CheckFail()
  if self._waitDelEfts == nil then
    self._waitDelEfts = {}
  else
    table.removeall(self._waitDelEfts)
  end
  for i, eft in ipairs(self._ballEftPool.listItem) do
    if eft:IsBallEftFnish() then
      table.insert(self._waitDelEfts, eft)
    end
  end
  for i, eft in ipairs(self._waitDelEfts) do
    self:__CycleCollidingEft(eft)
  end
  if self._collisioLineCount == 0 then
    return
  end
  for item, _ in pairs(self._collisionLineDic) do
    if item:GetRigidSpeed().sqrMagnitude >= 0.001 then
      return
    end
  end
  self:__OnEndGame()
end

function UINActSGMiniGamePlay:__IEDelayBornNewItem()
  while CS_UnityEngine_Time.time < self._nextBornTime do
    coroutine.yield(nil)
  end
  self:__TryGenItem()
  self._ieDelayBornCo = nil
end

function UINActSGMiniGamePlay:__GetWallBorder()
  if self._leftWallLimitX == nil then
    self._leftWallLimitX = self.ui.wall_left.transform.localPosition.x - self.ui.wall_left.transform.rect.x
  end
  if self._rightWallLimitX == nil then
    self._rightWallLimitX = self.ui.wall_right.transform.localPosition.x + self.ui.wall_right.transform.rect.x
  end
  return self._leftWallLimitX, self._rightWallLimitX
end

function UINActSGMiniGamePlay:__ShowCollidingEft(index, ball)
  local item = self._ballEftPool:GetOne()
  item:InitBallEft(index, self.gameType == ActSGMiniGameEnum.GameType.MashDown)
  item.transform:SetParent(ball.transform)
  item.transform.anchoredPosition = Vector2.zero
  self._ballToEftDic[ball] = item
end

function UINActSGMiniGamePlay:__CycleCollidingEft(item)
  self._ballEftPool:HideOne(item)
  item.transform:SetParent(self.ui.eftPool)
end

function UINActSGMiniGamePlay:BackAction()
  self:Hide()
end

function UINActSGMiniGamePlay:SetSGMiniGamePause(bool)
  self._isPause = bool
end

function UINActSGMiniGamePlay:CheckSGMiniGameExit(callback)
  self._isPause = true
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(7200), function()
    self._gameData:UploadTinyGameScore(self._score)
    callback()
  end, function()
    self._isPause = false
  end)
end

function UINActSGMiniGamePlay:OnHide()
  self:__Reset()
  for i, pool in pairs(self._ballPools) do
    pool:DeleteAll()
  end
  self._ballPools = nil
end

function UINActSGMiniGamePlay:OnDelete()
  if self.powerEffectTimer then
    TimerManager:StopTimer(self.powerEffectTimer)
    self.powerEffectTimer = nil
  end
end

return UINActSGMiniGamePlay
