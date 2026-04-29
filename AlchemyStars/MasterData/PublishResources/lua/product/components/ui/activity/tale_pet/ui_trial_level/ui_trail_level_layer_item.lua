_class("UITrailLevelLayerItem", UICustomWidget)
UITrailLevelLayerItem = UITrailLevelLayerItem

function UITrailLevelLayerItem:OnShow()
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._normalBg = self:GetGameObject("NormalBg")
  self._normalSelected = self:GetGameObject("NormalSelected")
  self._finalBg = self:GetGameObject("FinalBg")
  self._finalSelected = self:GetGameObject("FinalSelected")
  self._iconImg = self:GetUIComponent("RawImageLoader", "Icon")
  self._iconImage = self:GetUIComponent("RawImage", "Icon")
  self._normalBtnTran = self:GetUIComponent("RectTransform", "NormalBtn")
  self._redGo = self:GetGameObject("Red")
  self._redGo:SetActive(false)
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._go = self:GetGameObject("NormalBtn")
end

function UITrailLevelLayerItem:Refresh(levelLayerData, trailLevelController)
  self._levelLayerData = levelLayerData
  local levelDatas = levelLayerData:GetLevelDatas()
  self._trailLevelController = trailLevelController
  self._nameLabel:SetText(levelLayerData:GetLayerName())
  self._iconImg:LoadImage(levelLayerData:GetLayerIcon())
  self:RefreshSelectStatus(false)
  if levelLayerData:GetLayerType() == TrailLevelLayerType.Final then
    local talePetModule = GameGlobal.GetModule(TalePetModule)
    if talePetModule:HasOpenFinalLevel() then
      local levelDatas = levelLayerData:GetLevelDatas()
      if levelDatas then
        for i = 1, #levelDatas do
          local levelData = levelDatas[1]
          if not levelData:IsComplete() then
            self._redGo:SetActive(true)
            break
          end
        end
      end
    else
      self._nameLabel.color = Color(0.43529411764705883, 0.43529411764705883, 0.43529411764705883, 1)
      self._iconImage.color = Color(1, 1, 1, 0.5)
    end
  end
end

function UITrailLevelLayerItem:NormalBtnOnClick()
  self._trailLevelController:OnLevelLayerItemSelect(self, self._levelLayerData)
end

function UITrailLevelLayerItem:Select(isEnter)
  self:RefreshSelectStatus(true, isEnter)
end

function UITrailLevelLayerItem:UnSelect(isEnter)
  self:RefreshSelectStatus(false, isEnter)
end

function UITrailLevelLayerItem:RefreshSelectStatus(isSelected, isEnter)
  if self._levelLayerData:GetLayerType() == TrailLevelLayerType.Normal then
    self._normalBg:SetActive(not isSelected)
    self._normalSelected:SetActive(isSelected)
    self._finalBg:SetActive(false)
    self._finalSelected:SetActive(false)
    if not isEnter then
      if isSelected then
        self._anim:Play("uieff_UITrailLevelLayerItem_chenge_2")
      else
        self._anim:Play("uieff_UITrailLevelLayerItem_chenge_1")
      end
    end
  elseif self._levelLayerData:GetLayerType() == TrailLevelLayerType.Final then
    self._normalBg:SetActive(false)
    self._normalSelected:SetActive(false)
    self._finalBg:SetActive(not isSelected)
    self._finalSelected:SetActive(isSelected)
    if not isEnter then
      if isSelected then
        self._anim:Play("uieff_UITrailLevelLayerItem_finalchenge_2")
      else
        self._anim:Play("uieff_UITrailLevelLayerItem_finalchenge_1")
      end
    end
  end
  if isSelected then
    self._iconImage.color = Color(1, 1, 1, 1)
  else
    self._iconImage.color = Color(1, 1, 1, 0.8)
  end
end

function UITrailLevelLayerItem:PlayEnterAnim(isSelected)
  if self._levelLayerData:GetLayerType() == TrailLevelLayerType.Normal then
    if isSelected then
      self._anim:Play("uieff_UITrailLevelLayerItem_in_1")
    else
      self._anim:Play("uieff_UITrailLevelLayerItem_in_2")
    end
  elseif self._levelLayerData:GetLayerType() == TrailLevelLayerType.Final then
    if isSelected then
      self._anim:Play("uieff_UITrailLevelLayerItem_finalin_1")
    else
      self._anim:Play("uieff_UITrailLevelLayerItem_finalin_2")
    end
  end
  self._go:SetActive(true)
end

function UITrailLevelLayerItem:HideSelf()
  self._go:SetActive(false)
end
