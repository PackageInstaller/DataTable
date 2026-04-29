_class("StoryEntitySpotLight", StoryEntityMovable)
StoryEntitySpotLight = StoryEntitySpotLight

function StoryEntitySpotLight:Constructor(ID, gameObject, resRequest, storyManager, entityConfig)
  StoryEntitySpotLight.super.Constructor(self, ID, gameObject, resRequest, storyManager)
  self._type = StoryEntityType.SpotLight
  self._rawImage = gameObject:GetComponent("RawImage")
  self._rawImageColor = self._rawImage.color
  self._rectTransform = gameObject:GetComponent("RectTransform")
end

function StoryEntitySpotLight:_TriggerKeyframe(keyframeData)
  StoryEntitySpotLight.super._TriggerKeyframe(self, keyframeData)
  if keyframeData.WidthHeight then
    self._rectTransform.sizeDelta = Vector2(keyframeData.WidthHeight[1], keyframeData.WidthHeight[2])
  end
  if keyframeData.FullScreen ~= nil then
    if keyframeData.FullScreen then
      self:_SetPicFullScreen(self._rectTransform)
    else
      self._storyManager:SetUIBlackSideSize(0, 0)
    end
  end
end

function StoryEntitySpotLight:_SetPicFullScreen(rectTransform)
  local fullPicWidth = 2532
  local fullPicHeight = 1170
  local screenWidth, screenHeight = self._storyManager:GetUICanvasSize()
  local picAspect = fullPicWidth / fullPicHeight
  local screenAspect = screenWidth / screenHeight
  local blackSideHeight = 0
  local blackSideWidth = 0
  if picAspect > screenAspect then
    local picHeight = fullPicHeight * screenWidth / fullPicWidth
    rectTransform.sizeDelta = Vector2(screenWidth, picHeight)
    blackSideHeight = math.abs(screenHeight - picHeight) / 2
  elseif picAspect < screenAspect then
    local picWidth = fullPicWidth * screenHeight / fullPicHeight
    rectTransform.sizeDelta = Vector2(picWidth, screenHeight)
    blackSideWidth = math.abs(screenWidth - picWidth) / 2
  else
    rectTransform.sizeDelta = Vector2(screenWidth, screenHeight)
  end
  self._storyManager:SetUIBlackSideSize(blackSideWidth, blackSideHeight)
end

function StoryEntitySpotLight:_SetAlpha(alpha)
  self._rawImageColor.a = alpha
  self._rawImage.color = self._rawImageColor
end

function StoryEntitySpotLight:GetMaterial()
  return self._rawImage.material
end
