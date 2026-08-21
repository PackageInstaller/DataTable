_class("UIHomeSecretMsgSwitch", Object)
UIHomeSecretMsgSwitch = UIHomeSecretMsgSwitch

function UIHomeSecretMsgSwitch:Constructor(msgs, text1, text2)
  self._msgs = msgs
  self._trans1 = text1.gameObject:GetComponent(typeof(UnityEngine.RectTransform))
  self._trans2 = text2.gameObject:GetComponent(typeof(UnityEngine.RectTransform))
  self._height = self._trans1.sizeDelta.y
  self._waitTime = 2000
  self._moveTime = 1000
  self._text1 = text1
  self._text2 = text2
  self._items = {
    {
      Rect = self._trans1,
      Text = self._text1
    },
    {
      Rect = self._trans2,
      Text = self._text2
    }
  }
  if #self._msgs == 0 then
  elseif #self._msgs == 1 then
    self._text1:RefreshText(self._msgs[1])
    self._text2.gameObject:SetActive(false)
  else
    self._cur = 1
    self._first = self._items[1]
    self._temp = self._items[2]
    self._first.Text:RefreshText(self._msgs[1])
    self._temp.Text:RefreshText(self._msgs[2])
    GameGlobal.TaskManager():StartTask(self.anim, self)
  end
  self._active = true
end

function UIHomeSecretMsgSwitch:Dispose()
  self._active = false
  if self._moving then
    self._trans1:DOKill()
    self._trans2:DOKill()
  end
end

function UIHomeSecretMsgSwitch:anim(TT)
  while true do
    YIELD(TT, self._waitTime)
    if not self._active then
      return
    end
    self._moving = true
    self._first.Rect:DOAnchorPosY(self._height, self._moveTime / 1000)
    self._temp.Rect:DOAnchorPosY(0, self._moveTime / 1000)
    YIELD(TT, self._moveTime)
    YIELD(TT)
    if not self._active then
      return
    end
    self._moving = false
    self._first.Rect.anchoredPosition = Vector2(0, -self._height)
    self._cur = self._cur + 1
    if self._cur > #self._msgs then
      self._cur = 1
    end
    local next = self._cur + 1
    if next > #self._msgs then
      next = 1
    end
    self._first.Text:RefreshText(self._msgs[next])
    local t = self._temp
    self._temp = self._first
    self._first = t
  end
end
