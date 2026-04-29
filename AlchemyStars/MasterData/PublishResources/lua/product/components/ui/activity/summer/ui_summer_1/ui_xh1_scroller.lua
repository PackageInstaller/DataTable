_class("UIXH1Scroller", Object)
UIXH1Scroller = UIXH1Scroller

function UIXH1Scroller:Constructor(rect, loader1, loader2, _1, _2, _3, _4)
  self._rect = rect
  self._root = root
  self._loader1 = loader1
  self._loader2 = loader2
  self._graphic1 = loader1.gameObject:GetComponent(typeof(UnityEngine.UI.Graphic))
  self._graphic2 = loader2.gameObject:GetComponent(typeof(UnityEngine.UI.Graphic))
  self._trans1 = loader1.gameObject:GetComponent(typeof(UnityEngine.RectTransform))
  self._trans2 = loader2.gameObject:GetComponent(typeof(UnityEngine.RectTransform))
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
  self._deltaWidth = self._imageWidth - self._width
  self._left = 0
  self._right = -self._deltaWidth
  local halfWidth = self._rect.sizeDelta.x / 2
  local halfScreenWidth = self._width / 2
  self._1 = -(_1 + halfWidth - halfScreenWidth)
  self._2 = -(_2 + halfWidth - halfScreenWidth)
  self._3 = -(_3 + halfWidth - halfScreenWidth)
  self._4 = -(_4 + halfWidth - halfScreenWidth)
  self._spliter1 = (self._1 + self._2) / 2
  self._spliter2 = (self._3 + self._4) / 2
  self._bgNames = {
    "summer_ludian_tu1",
    "summer_ludian_tu2",
    "summer_ludian_tu3"
  }
  self._current = self:_getBg(true)
  self._loader1.gameObject:SetActive(false)
  self._loader2:LoadImage(self._bgNames[self._current])
  local rate1 = math.abs(self._spliter1) / self._deltaWidth
  local rate2 = math.abs(self._spliter1 - self._spliter2) / self._deltaWidth
  local rate3 = (self._rect.sizeDelta.x - math.abs(self._spliter2)) / self._deltaWidth
  self._scrollRate = {
    rate1,
    rate2,
    rate3
  }
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

function UIXH1Scroller:Dispose()
end

function UIXH1Scroller:OnChange()
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

function UIXH1Scroller:_getBg(isInit)
  local x = self._rect.localPosition.x
  if x > self._spliter1 then
    return 1
  elseif x > self._spliter2 and x < self._spliter1 then
    return 2
  else
    return 3
  end
end

function UIXH1Scroller:_getPos(isInit)
  local x = self._rect.localPosition.x
  if x > self._spliter1 then
    return math.min(x / self._scrollRate[1], self._left)
  elseif x > self._spliter2 and x < self._spliter1 then
    return (x - self._spliter1) / self._scrollRate[2]
  else
    return math.max((x - self._spliter2) / self._scrollRate[3], self._right)
  end
end
