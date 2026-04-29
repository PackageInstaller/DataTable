_class("UIHomelandMinimapIconPet", UIHomelandMinimapIconBase)
UIHomelandMinimapIconPet = UIHomelandMinimapIconPet

function UIHomelandMinimapIconPet:OnShow(uiParams)
  self._rawImageLoader = self:GetUIComponent("RawImageLoader", "RawImage")
  self._selectGO = self:GetGameObject("Selected")
  self._eventBubble = self:GetGameObject("EventBubble")
  self._treasureBubble = self:GetGameObject("TreasureBubble")
  self._headBGGo = self:GetGameObject("HeadBG")
end

function UIHomelandMinimapIconPet:OnInitDone()
  self.pet = self:GetIconData():GetParam()
  self.cfg = Cfg.cfg_pet[self.pet:TemplateID()]
  local skinID = self.pet:ClothSkinID()
  local skinCfg = Cfg.cfg_pet_skin[skinID]
  self._rawImageLoader:LoadImage(skinCfg.Head)
  local behaviorType = self.pet:GetPetBehavior():GetCurBehaviorType()
  self._treasureBubble:SetActive(behaviorType == HomelandPetBehaviorType.TreasureIdle)
  self._eventBubble:SetActive(behaviorType == HomelandPetBehaviorType.StoryWaitingBuild or behaviorType == HomelandPetBehaviorType.StoryWaitingBuildStand or behaviorType == HomelandPetBehaviorType.StoryWaitingStand or behaviorType == HomelandPetBehaviorType.StoryWaitingWalk)
  
  function self._behaviorChangeCallback(type)
    self:OnPetBehaviorChanged(type)
  end
  
  self.pet:RegisterBehaviorChangeCallback(self._behaviorChangeCallback)
end

function UIHomelandMinimapIconPet:OnHide()
  self.pet:UnRegisterBehaviorChangeCallback(self._behaviorChangeCallback)
end

function UIHomelandMinimapIconPet:OnPetBehaviorChanged(behaviorType)
  self._treasureBubble:SetActive(behaviorType == HomelandPetBehaviorType.TreasureIdle)
  self._eventBubble:SetActive(behaviorType == HomelandPetBehaviorType.StoryWaitingBuild or behaviorType == HomelandPetBehaviorType.StoryWaitingBuildStand or behaviorType == HomelandPetBehaviorType.StoryWaitingStand or behaviorType == HomelandPetBehaviorType.StoryWaitingWalk)
end

function UIHomelandMinimapIconPet:OnSelected()
  self._selectGO:SetActive(true)
end

function UIHomelandMinimapIconPet:OnUnSelected()
  self._selectGO:SetActive(false)
end

function UIHomelandMinimapIconPet:GetShowIconOffset()
  return Vector2(0, -30)
end

function UIHomelandMinimapIconPet:GetIconMultiSelectPositionOffset()
  return Vector2(0, 30)
end

function UIHomelandMinimapIconPet:GetShowName()
  return StringTable.Get(self.cfg.Name)
end

function UIHomelandMinimapIconPet:GetMutilSelectedPosition()
  return self._headBGGo.transform.position
end

function UIHomelandMinimapIconPet:GetAnimationName(animType)
  if not self._animationNames then
    self._animationNames = {}
    self._animationNames[MinimapIconAnimationType.IN] = "UIHomelandMinimapPetIcon_in"
    self._animationNames[MinimapIconAnimationType.OUT] = "UIHomelandMinimapPetIcon_out"
    self._animationNames[MinimapIconAnimationType.SELECT] = "UIHomelandMinimapPetIcon_Selected_in"
    self._animationNames[MinimapIconAnimationType.UNSELECT] = "UIHomelandMinimapPetIcon_Selected_out"
    self._animationNames[MinimapIconAnimationType.EXPANSION] = "UIHomelandMinimapPetIcon_blue"
  end
  return self._animationNames[animType]
end

function UIHomelandMinimapIconPet:IsMarkSelf(type, id)
  if type == HomelandMimimapIconMarkType.Pet then
    local cfg = Cfg.cfg_homeland_event[id]
    if cfg then
      local petid = self.pet:TemplateID()
      local cfgPetID = cfg.PetID
      if cfgPetID and cfgPetID == petid then
        return true
      end
    end
  elseif type == HomelandMimimapIconMarkType.FishingMatch then
    local petid = self.pet:TemplateID()
    return petid == id
  end
  return false
end
