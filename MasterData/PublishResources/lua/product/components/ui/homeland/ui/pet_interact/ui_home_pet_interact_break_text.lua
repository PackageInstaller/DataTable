_class("UIHomePetInteractBreakText", Object)
UIHomePetInteractBreakText = UIHomePetInteractBreakText

function UIHomePetInteractBreakText:SetData(richText, canvas)
  self._richText = richText
  self._canvas = canvas
  self._startTime = 0
  self._splitChar = "|"
  self._breakTime = 20
  self._breakIdx = 0
  self._active = false
  self._doing = false
end

function UIHomePetInteractBreakText:SetBreakTime(breakTime)
  self._breakTime = breakTime
end

function UIHomePetInteractBreakText:SetActive(active)
  self._active = active
end

function UIHomePetInteractBreakText:Stop()
  self._doing = false
  local showC = self._wordTotalCount
  if self._hideTextAnim then
    showC = -1
  end
  self._richText.ShowCharCount = showC
  if self._callback then
    self._callback(self._callbackParams, self._callbackParams2)
    self._callback = nil
    self._callbackParams = nil
    self._callbackParams2 = nil
  end
end

function UIHomePetInteractBreakText:SetText(content, callback)
  self._contentStr, self._breakIndexList, self._wordTotalCount, self._yieldTime, self._hideTextAnim = self:_GetContentInfo(content)
  self._contentStr = string.gsub(self._contentStr, "$$", "$")
  local name = GameGlobal.GetModule(RoleModule):GetName()
  if string.isnullorempty(name) then
    name = StringTable.Get("str_guide_moren_name")
  end
  self._contentStr = string.gsub(self._contentStr, "PlayerName", name)
  self._richText:SetText(self._contentStr)
  local newStr = HomeStoryHelper:GetInstance():FilterHtml(self._contentStr)
  local charIndex = HomeStoryHelper:GetInstance():GetstringCount(newStr)
  local emojiWidth = HomeStoryHelper:GetInstance():GetEmojiWidth(self._contentStr)
  local endFlagPos = HomeStoryHelper:GetInstance():GetPosWithTextIndexVert(self._canvas, self._richText, newStr, charIndex, 3)
  local endFlagOffset = Vector3(emojiWidth, 0, 0)
  if self._active then
    if self._yieldTime > 0 then
      self._breakIdx = 0
      local showC = 0
      if self._hideTextAnim then
        showC = -1
      end
      self._richText.ShowCharCount = showC
      self._contentTypeTime = self._breakIndexList[1] * self._breakTime
      self._time = 0
      self._doing = true
      self._callback = callback
      self._callbackParams = endFlagPos
      self._callbackParams2 = endFlagOffset
    elseif callback then
      callback(endFlagPos, endFlagOffset)
    end
    return self._yieldTime
  end
end

function UIHomePetInteractBreakText:Update(dms)
  if self._doing then
    self._time = self._time + dms
    local breakPercent = 1
    if self._contentTypeTime > 0 then
      breakPercent = self._time / self._contentTypeTime
      if 1 < breakPercent then
        breakPercent = 1
      end
    end
    local wordCount = -1
    if self._breakIdx == 0 then
      wordCount = math.floor(breakPercent * self._breakIndexList[self._breakIdx + 1])
    else
      if not self._breakIndexList[self._breakIdx + 1] then
        local a = 1
      end
      wordCount = math.floor(lmathext.lerp(self._breakIndexList[self._breakIdx], self._breakIndexList[self._breakIdx + 1], breakPercent))
    end
    local showC = wordCount
    if self._hideTextAnim then
      showC = -1
    end
    self._richText.ShowCharCount = showC
    if breakPercent == 1 then
      self._breakIdx = self._breakIdx + 1
      if self._breakIdx >= #self._breakIndexList then
        self._doing = false
        if self._callback then
          self._callback(self._callbackParams, self._callbackParams2)
          self._callback = nil
          self._callbackParams = nil
          self._callbackParams2 = nil
        end
      else
        self._contentTypeTime = self._breakTime * (self._breakIndexList[self._breakIdx + 1] - self._breakIndexList[self._breakIdx])
      end
    end
  end
end

function UIHomePetInteractBreakText:Dispose()
  self._doing = false
  self._richText = nil
end

function UIHomePetInteractBreakText:_GetContentInfo(str)
  local plainStr = string.gsub(str, "<size=%d*>", "")
  plainStr = string.gsub(plainStr, "</size>", "")
  plainStr = string.gsub(plainStr, "<color=#%x*>", "")
  plainStr = string.gsub(plainStr, "</color>", "")
  plainStr = string.gsub(plainStr, "<sprite.*/>", "a")
  local finalStr = string.gsub(str, self._splitChar, "")
  local breakIndexList = {}
  local charCount = 0
  for uchar in string.gmatch(plainStr, "[%z\001-\127Â-ô][€-¿]*") do
    if uchar == self._splitChar then
      breakIndexList[#breakIndexList + 1] = charCount
    else
      charCount = charCount + 1
    end
  end
  breakIndexList[#breakIndexList + 1] = charCount
  local yieldTime = 0
  if 0 < #breakIndexList then
    yieldTime = charCount * self._breakTime
  end
  local hideTextAnim = self:CheckHideTextAnim(str)
  return finalStr, breakIndexList, charCount, yieldTime, hideTextAnim
end

function UIHomePetInteractBreakText:CheckHideTextAnim(str)
  local hide = HelperProxy:GetInstance():CheckTextIncludeImg(str)
  return hide
end
