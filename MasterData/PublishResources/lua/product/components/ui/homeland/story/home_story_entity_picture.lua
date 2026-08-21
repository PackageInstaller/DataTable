_class("HomeStoryEntityPicture", HomeStoryEntityMovable)
HomeStoryEntityPicture = HomeStoryEntityPicture
local StoryPictureScrollType = {
  LeftToRight = 1,
  RightToLeft = 2,
  UpToDown = 3,
  DownToUp = 4,
  Spread = 5,
  HorizontalSpread = 6,
  VerticalSpread = 7
}
_enum("StoryPictureScrollType", StoryPictureScrollType)

function HomeStoryEntityPicture:Constructor(ID, gameObject, resRequest, storyManager, entityConfig)
  HomeStoryEntityPicture.super.Constructor(self, ID, gameObject, resRequest, storyManager)
  self._type = HomeStoryEntityType.Picture
  self._picObject = gameObject
  self._picCmp = gameObject:GetComponent("RawImage")
  self._picColor = self._picCmp.color
  self._inScrolling = false
  self._scrollStartFromCover = true
  self._scrollType = nil
  self._scrollStartTime = 0
  self._scrollDuration = 0
  local newGameObject = UnityEngine.GameObject:New(gameObject.name)
  newGameObject.transform:SetParent(gameObject.transform.parent, false)
  newGameObject.transform.localPosition = gameObject.transform.localPosition
  newGameObject:SetActive(gameObject.activeSelf)
  self._gameObject = newGameObject
  self._maskObject = UnityEngine.GameObject.Instantiate(storyManager:GetMaskTemplate(), newGameObject.transform)
  self._maskObject:SetActive(true)
  self._maskObject.transform.localPosition = Vector3.zero
  gameObject.transform:SetParent(self._maskObject.transform, false)
  gameObject:SetActive(true)
  if entityConfig.FitSize then
    local canvasRect = storyManager:GetCanvasRect()
    local picRect = gameObject:GetComponent("RectTransform")
    local targetWidth = canvasRect.width + 300
    local targetHeight = picRect.sizeDelta.y * targetWidth / picRect.sizeDelta.x
    picRect.sizeDelta = Vector2(targetWidth, targetHeight)
  end
end

function HomeStoryEntityPicture:_TriggerKeyframe(keyframeData)
  HomeStoryEntityPicture.super._TriggerKeyframe(self, keyframeData)
  if keyframeData.Scroll ~= nil then
    self._inScrolling = true
    self._scrollStartFromCover = keyframeData.Scroll.StartFromCover
    self._scrollType = StoryPictureScrollType[keyframeData.Scroll.Toward]
    self._scrollStartTime = keyframeData.Time
    self._scrollDuration = keyframeData.Scroll.Duration
    self._maskObject:GetComponent("Image").enabled = true
    self._maskObject:GetComponent("Mask").enabled = true
    local maskRect = self._maskObject:GetComponent("RectTransform")
    local picRect = self._picObject:GetComponent("RectTransform")
    if self._scrollStartFromCover then
      if self._scrollType == StoryPictureScrollType.LeftToRight or self._scrollType == StoryPictureScrollType.RightToLeft or self._scrollType == StoryPictureScrollType.HorizontalSpread then
        maskRect.sizeDelta = Vector2(0, picRect.sizeDelta.y)
      elseif self._scrollType == StoryPictureScrollType.UpToDown or self._scrollType == StoryPictureScrollType.DownToUp or self._scrollType == StoryPictureScrollType.VerticalSpread then
        maskRect.sizeDelta = Vector2(picRect.sizeDelta.x, 0)
      elseif self._scrollType == StoryPictureScrollType.Spread then
        maskRect.sizeDelta = Vector2.zero
      end
    else
      maskRect.sizeDelta = picRect.sizeDelta
    end
    if self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.LeftToRight or not self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.RightToLeft then
      maskRect.pivot = Vector2(0, 0.5)
      maskRect.transform.localPosition = Vector3(-picRect.sizeDelta.x / 2, maskRect.transform.localPosition.y, maskRect.transform.localPosition.z)
      picRect.anchorMin = Vector2(0, 0.5)
      picRect.anchorMax = Vector2(0, 0.5)
      picRect.transform.localPosition = Vector3(picRect.sizeDelta.x / 2, picRect.transform.localPosition.y, picRect.transform.localPosition.z)
    elseif self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.RightToLeft or not self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.LeftToRight then
      maskRect.pivot = Vector2(1, 0.5)
      maskRect.transform.localPosition = Vector3(picRect.sizeDelta.x / 2, maskRect.transform.localPosition.y, maskRect.transform.localPosition.z)
      picRect.anchorMin = Vector2(1, 0.5)
      picRect.anchorMax = Vector2(1, 0.5)
      picRect.transform.localPosition = Vector3(-picRect.sizeDelta.x / 2, picRect.transform.localPosition.y, picRect.transform.localPosition.z)
    elseif self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.UpToDown or not self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.DownToUp then
      maskRect.pivot = Vector2(0.5, 1)
      maskRect.transform.localPosition = Vector3(maskRect.transform.localPosition.x, picRect.sizeDelta.y / 2, maskRect.transform.localPosition.z)
      picRect.anchorMin = Vector2(0.5, 1)
      picRect.anchorMax = Vector2(0.5, 1)
      picRect.transform.localPosition = Vector3(picRect.transform.localPosition.x, -picRect.sizeDelta.y / 2, picRect.transform.localPosition.z)
    elseif self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.DownToUp or not self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.UpToDown then
      maskRect.pivot = Vector2(0.5, 0)
      maskRect.transform.localPosition = Vector3(maskRect.transform.localPosition.x, -picRect.sizeDelta.y / 2, maskRect.transform.localPosition.z)
      picRect.anchorMin = Vector2(0.5, 0)
      picRect.anchorMax = Vector2(0.5, 0)
      picRect.transform.localPosition = Vector3(picRect.transform.localPosition.x, picRect.sizeDelta.y / 2, picRect.transform.localPosition.z)
    elseif self._scrollType == StoryPictureScrollType.Spread then
    elseif self._scrollType == StoryPictureScrollType.HorizontalSpread then
    elseif self._scrollType == StoryPictureScrollType.VerticalSpread then
    end
  end
end

function HomeStoryEntityPicture:_SetPicFullScreen(rectTrans)
  local fullPicWidth = 2532
  local fullPicHeight = 1170
  local screenWidth, screenHeight = GameGlobal.UIStateManager():CallUIMethod("UIStoryController", "GetCanvasSize")
  local picAspect = fullPicWidth / fullPicHeight
  local screenAspect = screenWidth / screenHeight
  local blackSideHeight = 0
  local blackSideWidth = 0
  if picAspect > screenAspect then
    local picHeight = fullPicHeight * screenWidth / fullPicWidth
    rectTrans.sizeDelta = Vector2(screenWidth, picHeight)
    blackSideHeight = math.abs(screenHeight - picHeight) / 2
  elseif picAspect < screenAspect then
    local picWidth = fullPicWidth * screenHeight / fullPicHeight
    rectTrans.sizeDelta = Vector2(picWidth, screenHeight)
    blackSideWidth = math.abs(screenWidth - picWidth) / 2
  else
    rectTrans.sizeDelta = Vector2(screenWidth, screenHeight)
  end
  GameGlobal.UIStateManager():CallUIMethod("UIStoryController", "SetBlackSideSize", blackSideWidth, blackSideHeight)
end

function HomeStoryEntityPicture:_UpdateAnimation(time)
  local res = HomeStoryEntityPicture.super._UpdateAnimation(self, time)
  if self._inScrolling and self._scrollType then
    local t = 1
    if self._scrollDuration > 0 then
      t = (time - self._scrollStartTime) / self._scrollDuration
    end
    if 1 < t then
      t = 1
    end
    local effectT = t
    if not self._scrollStartFromCover then
      effectT = 1 - effectT
    end
    if not self._maskRect then
      self._maskRect = self._maskObject:GetComponent("RectTransform")
    end
    if not self._picRect then
      self._picRect = self._picObject:GetComponent("RectTransform")
    end
    if self._scrollType == StoryPictureScrollType.LeftToRight or self._scrollType == StoryPictureScrollType.RightToLeft or self._scrollType == StoryPictureScrollType.HorizontalSpread then
      self._maskRect.sizeDelta = Vector2(lmathext.lerp(0, self._picRect.sizeDelta.x, effectT), self._picRect.sizeDelta.y)
    elseif self._scrollType == StoryPictureScrollType.UpToDown or self._scrollType == StoryPictureScrollType.DownToUp or self._scrollType == StoryPictureScrollType.VerticalSpread then
      self._maskRect.sizeDelta = Vector2(self._picRect.sizeDelta.x, lmathext.lerp(0, self._picRect.sizeDelta.y, effectT))
    elseif self._scrollType == StoryPictureScrollType.Spread then
      self._maskRect.sizeDelta = Vector2(lmathext.lerp(0, self._picRect.sizeDelta.x, effectT), lmathext.lerp(0, self._picRect.sizeDelta.y, effectT))
    end
    if 1 <= t then
      self._inScrolling = false
    end
    return false
  else
    return res
  end
end

function HomeStoryEntityPicture:_SetAlpha(alpha)
  self._picColor.a = alpha
  self._picCmp.color = self._picColor
end

function HomeStoryEntityPicture:_SetBrightness(brightness)
  self._picColor:Set(brightness, brightness, brightness, self._picColor.a)
  self._picCmp.color = self._picColor
end
