_class("UIEducationUpBtn", UICustomWidget)
UIEducationUpBtn = UIEducationUpBtn

function UIEducationUpBtn:Constructor()
end

function UIEducationUpBtn:OnShow(uiParams)
  self:UIWidget()
end

function UIEducationUpBtn:OnHide()
end

function UIEducationUpBtn:ButtonOnClick(go)
  if self._clickCB ~= nil then
    self._clickCB(self._element:ElementType())
  end
end

function UIEducationUpBtn:UIWidget()
  self._uiSel = self:GetUIComponent("UIView", "uiSel")
  self._uiUnsel = self:GetUIComponent("UIView", "uiUnsel")
  self._uiRed = self:View():GetUIComponent("UISelectObjectPath", "uiRed")
  self._uiRedSpawn = nil
  self._animationSel = self:GetUIComponent("Animation", "uiSel")
  self._animationUnsel = self:GetUIComponent("Animation", "uiUnsel")
  self._redAnimation = self:GetUIComponent("Animation", "redAnimation")
  local uiSel = {
    root = self._uiSel,
    petElement = self._uiSel:GetUIComponent("Image", "petElement"),
    elementName = self._uiSel:GetUIComponent("UILocalizedTMP", "elementName"),
    stageName = self._uiSel:GetUIComponent("UILocalizationText", "stageName")
  }
  local uiUnsel = {
    root = self._uiUnsel,
    petElement = self._uiUnsel:GetUIComponent("Image", "petElement"),
    elementName = self._uiUnsel:GetUIComponent("UILocalizationText", "elementName"),
    stageName = self._uiUnsel:GetUIComponent("UILocalizationText", "stageName")
  }
  self._uiSel = uiSel
  self._uiUnsel = uiUnsel
end

function UIEducationUpBtn:SetData(element, atlasPropertySel, atlasPropertyUnsel, clickCB)
  self._element = element
  self._atlasPropertySel = atlasPropertySel
  self._atlasPropertyUnsel = atlasPropertyUnsel
  self._clickCB = clickCB
end

function UIEducationUpBtn:GetElementSpriteName()
  if self._nameElementSprite == nil then
    UIEducationUpBtn._nameElementSprite = {
      [ElementType.ElementType_Blue] = "enlighten_zjm_bing",
      [ElementType.ElementType_Red] = "enlighten_zjm_huo",
      [ElementType.ElementType_Green] = "enlighten_zjm_sen",
      [ElementType.ElementType_Yellow] = "enlighten_zjm_lei"
    }
  end
  return self._nameElementSprite[self._element:ElementType()]
end

function UIEducationUpBtn:Flush()
  self._uiSel.petElement.sprite = self._atlasPropertySel:GetSprite(self:GetElementSpriteName())
  self._uiSel.elementName:SetText(self._element:GetName())
  self._uiSel.stageName:SetText(StringTable.Get("str_education_stage_name", self._element:GetCurrentStage()))
  local cfgAttribute = Cfg.cfg_pet_element[self._element:ElementType()]
  self._uiUnsel.petElement.sprite = self._atlasPropertyUnsel:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfgAttribute.Icon))
  self._uiUnsel.elementName:SetText(self._element:GetName())
  self._uiUnsel.stageName:SetText(StringTable.Get("str_education_stage_name", self._element:GetCurrentStage()))
  local showRedDot = self._element:HasRed()
  self._uiRed.gameObject:SetActive(showRedDot)
  if showRedDot and self._uiRedSpawn == nil then
    self._uiRedSpawn = self._uiRed:SpawnOneObject("ManualLoad0")
  end
end

function UIEducationUpBtn:SetSelect(inSelect)
  self._isSelect = inSelect
  self._uiSel.root.gameObject:SetActive(self._isSelect)
  self._uiUnsel.root.gameObject:SetActive(not self._isSelect)
  if self._isSelect then
    self:PlayRed("uieff_UIEducationUpBtn_uired_2")
  else
    self:PlayRed("uieff_UIEducationUpBtn_uired_1")
  end
end

function UIEducationUpBtn:PlaySel(animName)
  self._uiSel.root.gameObject:SetActive(true)
  self._animationSel:Play(animName)
end

function UIEducationUpBtn:PlayUnsel(animName)
  self._uiUnsel.root.gameObject:SetActive(true)
  self._animationUnsel:Play(animName)
end

function UIEducationUpBtn:PlayRed(animName)
  self._redAnimation:Play(animName)
end
