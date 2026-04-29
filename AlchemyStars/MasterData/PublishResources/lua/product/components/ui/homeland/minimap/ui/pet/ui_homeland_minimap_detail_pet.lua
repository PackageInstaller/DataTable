_class("UIHomelandMinimapDetailPet", UIHomelandMinimapDetailBase)
UIHomelandMinimapDetailPet = UIHomelandMinimapDetailPet

function UIHomelandMinimapDetailPet:OnShow()
  self._iconLoader = self:GetUIComponent("RawImageLoader", "HeadIcon")
  self._nameTxt = self:GetUIComponent("UILocalizationText", "NameTxt")
  self._contentTxt = self:GetUIComponent("UILocalizationText", "ContentTxt")
end

function UIHomelandMinimapDetailPet:OnInitDone()
  self.pet = self:GetIconData():GetParam()
  local skinID = self.pet:ClothSkinID()
  local skinCfg = Cfg.cfg_pet_skin[skinID]
  local petCfg = Cfg.cfg_pet[self.pet:TemplateID()]
  self._iconLoader:LoadImage(skinCfg.Head)
  local petName = StringTable.Get(petCfg.Name)
  self._nameTxt:SetText(petName)
  local behaviorType = self.pet:GetPetBehavior():GetCurBehaviorType()
  if behaviorType == HomelandPetBehaviorType.TreasureIdle then
    self._contentTxt:SetText(StringTable.Get("str_homeland_minimap_pet_treasure", petName))
  elseif behaviorType == HomelandPetBehaviorType.StoryWaitingBuild or behaviorType == HomelandPetBehaviorType.StoryWaitingBuildStand or behaviorType == HomelandPetBehaviorType.StoryWaitingStand or behaviorType == HomelandPetBehaviorType.StoryWaitingWalk then
    self._contentTxt:SetText(StringTable.Get("str_homeland_minimap_pet_event", petName))
  else
    self._contentTxt:SetText(StringTable.Get(petCfg.Desc))
  end
  self._titleRect = self:GetUIComponent("RectTransform", "Title")
  if self._titleRect then
    local titleWidth = self._nameTxt.preferredWidth
    if 350 < titleWidth then
      titleWidth = 350
    end
    self._titleRect.sizeDelta = Vector2(titleWidth, self._titleRect.sizeDelta.y)
  end
end

function UIHomelandMinimapDetailPet:ExitOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapCloseDetailUI)
  self:OnClose()
end

function UIHomelandMinimapDetailPet:BtnBGOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapCloseDetailUI)
  self:OnClose()
end

function UIHomelandMinimapDetailPet:GetCloseAnimtionName()
  return "UIHomelandMinimapDetailPet_out"
end
