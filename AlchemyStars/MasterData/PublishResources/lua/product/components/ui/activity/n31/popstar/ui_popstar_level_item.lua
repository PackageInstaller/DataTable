_class("UIPopStarLevelItem", UICustomWidget)
UIPopStarLevelItem = UIPopStarLevelItem

function UIPopStarLevelItem:OnShow()
  self._up = self:GetGameObject("Up")
  self._down = self:GetGameObject("Down")
  self._normal = self:GetGameObject("Normal")
  self._challenge = self:GetGameObject("Challenge")
  self._stars = {}
  self._stars[1] = self:GetGameObject("Star1")
  self._stars[2] = self:GetGameObject("Star2")
  self._stars[3] = self:GetGameObject("Star3")
  self._normalName = self:GetUIComponent("UILocalizationText", "NormalName")
  self._normalLock = self:GetGameObject("NormalLock")
  self._challengeName = self:GetUIComponent("UILocalizationText", "ChallengeName")
  self._challengeLock = self:GetGameObject("ChallengeLock")
  self._btn = self:GetUIComponent("RectTransform", "Btn")
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIPopStarLevelItem:SetData(levelData, isUp, isLast, callback)
  self._callback = callback
  self._levelData = levelData
  local levelType = self._levelData:GetLevelType()
  self._normal:SetActive(false)
  self._challenge:SetActive(false)
  if levelType == UIActivityPopStarLevelType.Normal then
    self._normal:SetActive(true)
    self._normalName:SetText(self._levelData:GetName())
    self._normalLock:SetActive(not self._levelData:IsOpen())
    local star = self._levelData:GetStar()
    for i = 1, #self._stars do
      self._stars[i]:SetActive(i <= star)
    end
  elseif levelType == UIActivityPopStarLevelType.Challenge then
    self._challenge:SetActive(true)
    self._challengeName:SetText(self._levelData:GetName())
    self._challengeLock:SetActive(not self._levelData:IsOpen())
  end
  if isUp then
    self._btn.anchoredPosition = Vector2(0, 80)
    self._anim:Play("uieff_UIPopStarLevelItem_in01")
  else
    self._btn.anchoredPosition = Vector2(0, 5.6)
    self._anim:Play("uieff_UIPopStarLevelItem_in02")
  end
  self._up:SetActive(false)
  self._down:SetActive(false)
  if not isLast then
    if isUp then
      self._up:SetActive(true)
    else
      self._down:SetActive(true)
    end
  end
end

function UIPopStarLevelItem:SetActive(status)
  self._go:SetActive(status)
end

function UIPopStarLevelItem:BtnOnClick()
  if self._callback then
    self._callback(self._levelData)
  end
end
