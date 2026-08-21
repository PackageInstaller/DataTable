_class("UILuckLandLevelLine", UICustomWidget)
UILuckLandLevelLine = UILuckLandLevelLine

function UILuckLandLevelLine:OnShow(uiParams)
  self:_InitWidget()
end

function UILuckLandLevelLine:_InitWidget()
  self._right = self:GetGameObject("Right")
  self._left = self:GetGameObject("Left")
  self._animation = self:GetUIComponent("Animation", "Animation")
end

function UILuckLandLevelLine:SetData(index, isShow, play)
  self._index = index
  local show = self._index % 2 == 1
  self._right:SetActive(show)
  self._left:SetActive(not show)
  self.view:GetGameObject():SetActive(isShow)
  if play then
    self:StartTask(function(TT)
      YIELD(TT, index * 100)
      self:PlayAnimation(true)
    end, self)
  end
end

function UILuckLandLevelLine:PlayAnimation(isIn)
  if self._animation then
    if isIn then
      self._animation:Play("uieff_UILuckLandLevelLine_in")
    else
      self._animation:Play("uieff_UILuckLandLevelLine_out")
    end
  end
end
