_class("UIActivityN5Scroller", Object)
UIActivityN5Scroller = UIActivityN5Scroller

function UIActivityN5Scroller:Constructor(rect, loader1, loader2, bgNames, spliterNodes)
  self._rect = rect
  self._loader1 = loader1
  self._loader2 = loader2
  self._graphic1 = loader1.gameObject:GetComponent(typeof(UnityEngine.UI.Graphic))
  self._graphic2 = loader2.gameObject:GetComponent(typeof(UnityEngine.UI.Graphic))
  self._trans1 = loader1.gameObject:GetComponent(typeof(UnityEngine.RectTransform))
  self._trans2 = loader2.gameObject:GetComponent(typeof(UnityEngine.RectTransform))
  self._bgNames = bgNames
  local defaultAspect = 1.7777777777777777
  local aspect = UnityEngine.Screen.width / UnityEngine.Screen.height
  local width = 0
  if math.abs(aspect - defaultAspect) < 0.01 then
    width = UnityEngine.Screen.width
  elseif defaultAspect < aspect then
    width = math.ceil(1080 * aspect)
  else
    width = 1920
  end
  self._width = width
  self._imageWidth = width + 200
  if self._imageWidth > 2539 then
    self._imageWidth = 2539
  end
  self._deltaWidth = self._imageWidth - self._width
  if 0 > self._deltaWidth then
    self._deltaWidth = 0
  end
  self._left = 0
  self._right = -self._deltaWidth
  local halfWidth = self._rect.sizeDelta.x / 2
  local halfScreenWidth = self._width / 2
  self._spliterNodePosVec = {}
  for index, nodePos in ipairs(spliterNodes) do
    local tarPos = -(nodePos + halfWidth - halfScreenWidth)
    table.insert(self._spliterNodePosVec, tarPos)
  end
  self._spliterPosVec = {}
  self._calRatePosVec = {}
  local spFlag = 0
  local spPos1 = 0
  for index, nodePos in ipairs(self._spliterNodePosVec) do
    spFlag = spFlag + 1
    if spFlag == 2 then
      spFlag = 0
      local spliterPos = (spPos1 + nodePos) / 2
      table.insert(self._spliterPosVec, spliterPos)
      table.insert(self._calRatePosVec, math.abs(spliterPos))
    else
      spPos1 = nodePos
    end
  end
  table.insert(self._calRatePosVec, self._rect.sizeDelta.x)
  self._current = self:_getBg(true)
  self._loader1.gameObject:SetActive(false)
  self._loader2:LoadImage(self._bgNames[self._current])
  self._scrollRate = {}
  local lastSpPos = 0
  for index, spPos in ipairs(self._calRatePosVec) do
    local rate = math.abs(spPos - lastSpPos) / self._deltaWidth
    table.insert(self._scrollRate, rate)
    lastSpPos = spPos
  end
  local x = self:_getPos(true)
  self._trans2.anchoredPosition = Vector2(x, 0)
  self._player = EZTL_Player:New()
  self._tl = EZTL_Sequence:New({
    EZTL_Callback:New(function()
      self._loader1.gameObject:SetActive(true)
      self._trans1.anchoredPosition = self._trans2.anchoredPosition:Clone()
      self._graphic1.color = Color(1, 1, 1, 1)
      self._graphic2.color = Color(1, 1, 1, 0)
    end, "打开1"),
    EZTL_Parallel:New({
      EZTL_AlphaTween:New(self._graphic1, 0.5, 200, "透明度切换"),
      EZTL_AlphaTween:New(self._graphic2, 1, 500, "透明度切换")
    }, EZTL_EndTag.All, nil, ""),
    EZTL_Callback:New(function()
      self._loader1.gameObject:SetActive(false)
      self._graphic2.color = Color(1, 1, 1, 1)
    end, "关闭1")
  }, "背景切换动画")
end

function UIActivityN5Scroller:Dispose()
  if self._player:IsPlaying() then
    self._player:Stop()
  end
end

function UIActivityN5Scroller:OnChange()
  local bg = self:_getBg(false)
  if bg and self._current ~= bg then
    local old = self._current
    self._current = bg
    Log.fatal("切换背景", self._current)
    self._loader1:LoadImage(self._bgNames[old])
    self._loader2:LoadImage(self._bgNames[self._current])
    if self._player:IsPlaying() then
      self._player:Stop()
    end
    self._player:Play(self._tl)
  end
  local x = self:_getPos(false)
  if x then
    self._trans2.anchoredPosition = Vector2(x, 0)
  end
end

function UIActivityN5Scroller:_getBg(isInit)
  local x = self._rect.localPosition.x
  local absX = math.abs(x)
  local vecNum = #self._spliterPosVec
  local periodRight = vecNum + 1
  for i = 1, vecNum do
    local spPos = self._spliterPosVec[i]
    local absSpPos = math.abs(spPos)
    if absX < absSpPos then
      periodRight = i
      break
    end
  end
  return periodRight
end

function UIActivityN5Scroller:_getPos(isInit)
  local x = self._rect.localPosition.x
  local absX = math.abs(x)
  local vecNum = #self._spliterPosVec
  local periodRight = vecNum + 1
  for i = 1, vecNum do
    local spPos = self._spliterPosVec[i]
    local absSpPos = math.abs(spPos)
    if absX < absSpPos then
      periodRight = i
      break
    end
  end
  if periodRight == 1 then
    return math.min(x / self._scrollRate[periodRight], self._left)
  elseif periodRight == vecNum + 1 then
    return math.max((x - self._spliterPosVec[vecNum]) / self._scrollRate[periodRight], self._right)
  else
    return (x - self._spliterPosVec[periodRight - 1]) / self._scrollRate[periodRight]
  end
end
