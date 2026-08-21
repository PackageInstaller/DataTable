_class("UIChooseMainCgChangeItem", UICustomWidget)
UIChooseMainCgChangeItem = UIChooseMainCgChangeItem

function UIChooseMainCgChangeItem:Constructor()
  self._roleModule = self:GetModule(RoleModule)
  self._assistantType = nil
end

function UIChooseMainCgChangeItem:GetComponents()
  self._scaleSlider = self:GetUIComponent("Slider", "scaleSlider")
  self._spriteImg = self:GetUIComponent("RawImageLoader", "spriteImg")
  self._bgImg = self:GetUIComponent("RawImageLoader", "bgImg")
  self._bgImg2 = self:GetUIComponent("RawImageLoader", "bgImg2")
  self._bgImgGo = self:GetGameObject("bgImg")
  self._bgImgGo2 = self:GetGameObject("bgImg2")
  self._rolePosBg = self:GetGameObject("rolePosBg")
  self._bgPosBg = self:GetGameObject("bgPosBg")
  self._rolePosTxt = self:GetUIComponent("UILocalizationText", "rolePosTxt")
  self._bgPosTxt = self:GetUIComponent("UILocalizationText", "bgPosTxt")
  self._nocgNode = self:GetGameObject("node_no_cg")
  self._cgNode = self:GetGameObject("node_cg")
  self._sliderNode = self:GetGameObject("node_slider")
  self._noSliderNode = self:GetGameObject("node_noslider")
  self._cgtxtNode = self:GetGameObject("node_cgtxt")
  self._bgtxtNode = self:GetGameObject("node_bgtxt")
  self._scaleSlider.onValueChanged:AddListener(function(value)
    if self._assistantType and self._scale and self._scale ~= value then
      self.uiOwner:_OnMainCgChangeScale(self._assistantType, value - self._scale)
      self._scale = value
    end
  end)
  self._sliderGo = self:GetGameObject("sliderImg")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._scaleSlider.gameObject), UIEvent.Press, function(go)
    self.uiOwner:SetIsSliderPointerDown(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._scaleSlider.gameObject), UIEvent.Release, function(go)
    self.uiOwner:SetIsSliderPointerDown(false)
  end)
end

function UIChooseMainCgChangeItem:OnShow(uiParams)
  self:GetComponents()
  self:rolePosBtnOnClick()
  self:RefreshInfo()
  self._scaleSlider.minValue = 0.5
  self._scaleSlider.maxValue = 2
end

function UIChooseMainCgChangeItem:RefreshInfo()
  local iconName = self:_GetSpriteIconName()
  if iconName then
    self._nocgNode:SetActive(false)
    self._cgNode:SetActive(true)
    self._spriteImg:LoadImage(iconName)
  else
    self._nocgNode:SetActive(true)
    self._cgNode:SetActive(false)
  end
  if self._assistantType == UIChooseAssistantType.Change2Cg then
    if iconName then
      self._sliderNode:SetActive(true)
      self._noSliderNode:SetActive(false)
    else
      self._sliderNode:SetActive(false)
      self._noSliderNode:SetActive(true)
    end
  end
  local bgName, isSmallPic = self:_GetBgIconName()
  if bgName then
    if isSmallPic then
      self._bgImg:LoadImage(bgName)
    else
      self._bgImg2:LoadImage(bgName)
    end
    self._bgImgGo:SetActive(isSmallPic)
    self._bgImgGo2:SetActive(not isSmallPic)
  else
    Log.error("bgName is null")
  end
end

function UIChooseMainCgChangeItem:_GetSpriteIconName()
  local petid = self._roleModule:GetResId()
  local defaultPetID = 0
  local grade, skin, asid
  if not petid or petid == -1 then
    return
  end
  if petid ~= 0 then
    defaultPetID = petid
    grade = self._roleModule.m_choose_painting.pet_grade
    skin = self._roleModule.m_choose_painting.skin_id
    asid = self._roleModule.m_choose_painting.board_pet
  else
    defaultPetID = Cfg.cfg_global.main_default_spine_pet_id.IntValue
    grade = 0
    skin = 0
    asid = 0
  end
  local skinCfg = MatchPet.GetPetSkinCfg(defaultPetID, grade, skin, PetSkinEffectPath.HEAD_ICON_CHANGE_ASSIST)
  local iconName
  if asid and asid ~= 0 then
    local cfg = Cfg.cfg_only_assistant[asid]
    if cfg ~= nil then
      iconName = cfg.Icon
    else
      iconName = "1500331_assistant"
      Log.error("_GetSpriteIconName is nil  id:", asid)
    end
  else
    iconName = skinCfg.AircraftBody
  end
  return iconName
end

function UIChooseMainCgChangeItem:_GetBgIconName()
  local isSmallPic = true
  local id = self._roleModule:UI_GetMainBgID()
  local type = self._roleModule.m_choose_painting.background_type
  id = id == 0 and 2 or id
  type = type == 0 and 1 or type
  local bgName
  if type == UIChooseAssistantBgType.Normal then
    local cfg = Cfg.cfg_main_bg[id]
    if not cfg then
      return
    end
    bgName = cfg.BG
  else
    local cfg = Cfg.cfg_cg_book[id]
    if not cfg then
      return
    end
    bgName = cfg.Preview
    if cfg.StaticPic then
      bgName = cfg.StaticPic
      isSmallPic = false
    end
  end
  return bgName, isSmallPic
end

function UIChooseMainCgChangeItem:SetScale(uiChooseAssistantType, scale)
  if not scale then
    return
  end
  if uiChooseAssistantType == UIChooseAssistantType.Change2Bg then
    self._bgScale = scale
  elseif uiChooseAssistantType == UIChooseAssistantType.Change2Cg then
    self._cgScale = scale
  end
  if self._assistantType == uiChooseAssistantType then
    if scale <= 0 then
      Log.debug("[FX] SET scale", scale)
      scale = 1
    end
    self._scale = scale
    if self._scaleSlider.value ~= scale then
      self._scaleSlider.value = scale
    end
  end
end

function UIChooseMainCgChangeItem:SpriteBtnOnClick()
  self:ShowDialog("UIChooseAssistantController")
end

function UIChooseMainCgChangeItem:BgBtnOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIChooseMainBgController")
end

function UIChooseMainCgChangeItem:SpriteBtn2OnClick()
  self:SpriteBtnOnClick()
end

function UIChooseMainCgChangeItem:BgBtn2OnClick()
  self:BgBtnOnClick()
end

function UIChooseMainCgChangeItem:SpriteBtn3OnClick()
  self:SpriteBtnOnClick()
end

local grayColor = Color(0.23921568627450981, 0.23921568627450981, 0.23921568627450981, 1)

function UIChooseMainCgChangeItem:rolePosBtnOnClick()
  if self._assistantType ~= UIChooseAssistantType.Change2Cg then
    self._scale = nil
    self._rolePosTxt.color = Color.white
    self._bgPosTxt.color = grayColor
    self._rolePosBg:SetActive(true)
    self._bgPosBg:SetActive(false)
    self._cgtxtNode:SetActive(true)
    self._bgtxtNode:SetActive(false)
    if self:_GetSpriteIconName() then
      self._sliderNode:SetActive(true)
      self._noSliderNode:SetActive(false)
    else
      self._sliderNode:SetActive(false)
      self._noSliderNode:SetActive(true)
    end
    self._assistantType = UIChooseAssistantType.Change2Cg
    self.uiOwner:PetBtnOnClick()
    local minScale, MaxScale = self.uiOwner:GetMinAndMaxScale(UIChooseAssistantType.Change2Cg)
    self._scaleSlider.minValue = minScale
    self._scaleSlider.maxValue = MaxScale
    self:SetScale(UIChooseAssistantType.Change2Cg, self._cgScale)
  end
end

function UIChooseMainCgChangeItem:bgPosBtnOnClick()
  if self._assistantType ~= UIChooseAssistantType.Change2Bg then
    self._scale = nil
    self._rolePosTxt.color = grayColor
    self._bgPosTxt.color = Color.white
    self._rolePosBg:SetActive(false)
    self._bgPosBg:SetActive(true)
    self._cgtxtNode:SetActive(false)
    self._bgtxtNode:SetActive(true)
    self._sliderNode:SetActive(true)
    self._noSliderNode:SetActive(false)
    self._assistantType = UIChooseAssistantType.Change2Bg
    self.uiOwner:BgBtnOnClick()
    local minScale, MaxScale = self.uiOwner:GetMinAndMaxScale(UIChooseAssistantType.Change2Bg)
    self._scaleSlider.minValue = minScale
    self._scaleSlider.maxValue = MaxScale
    self:SetScale(UIChooseAssistantType.Change2Bg, self._bgScale)
  end
end
