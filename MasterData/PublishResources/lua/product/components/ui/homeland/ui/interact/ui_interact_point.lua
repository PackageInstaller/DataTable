_class("UIInteractPoint", UICustomWidget)
UIInteractPoint = UIInteractPoint

function UIInteractPoint:OnShow(uiParams)
  self._interactBtn = self:GetUIComponent("RectTransform", "InteractBtn")
  self._btnParent = self:GetUIComponent("RectTransform", "InteractBtnParent")
  self._titleLabel = self:GetUIComponent("UILocalizationText", "Title")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._redGo = self:GetGameObject("Red")
  self._iconImg = self:GetUIComponent("RawImageLoader", "Icon")
  self:AttachEvent(GameEventType.RefreshInteractUI, self.RefreshRedPoint)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
  self._anim:Play("ui_interact_point_anim_in")
  self._interval = 0
end

function UIInteractPoint:OnHide()
  self:DetachEvent(GameEventType.RefreshInteractUI, self.RefreshRedPoint)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
end

function UIInteractPoint:ScreenPointToLocalPointInRectangle(rect, screenPoint, camera)
  local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, screenPoint, camera, nil)
  return pos
end

function UIInteractPoint:Refresh(interactPoint)
  self._interactPoint = interactPoint
  local pointType = interactPoint:GetPointType()
  if pointType == InteractPointType.PetCommunication then
    local name = interactPoint:GetBuild():PetName()
    self._titleLabel:SetText(name)
  elseif pointType == InteractPointType.Breed then
    self:_RefreshBreedLand()
  elseif pointType == InteractPointType.TaskNpc then
    local name = interactPoint:GetBuild():GetName()
    self._titleLabel:SetText(name)
  else
    self._titleLabel:SetText(interactPoint:GetPointName())
  end
  self._redGo:SetActive(self._interactPoint:GetRedPointStatus())
  if self._imgName ~= interactPoint:GetPointIcon() then
    self._imgName = interactPoint:GetPointIcon()
    self._iconImg:LoadImage(self._imgName)
  end
  if pointType == InteractPointType.Build then
    self:RefreshForgeData()
  end
  self:RefreshRedPoint()
  self:_FinishGuide()
end

function UIInteractPoint:RefreshRedPoint()
  self._redGo:SetActive(self._interactPoint:GetRedPointStatus())
end

function UIInteractPoint:RefreshForgeData()
  local mHomeland = GameGlobal.GetModule(HomelandModule)
  local data = mHomeland:GetForgeData()
  data:Init(mHomeland:GetHomelandInfo())
end

function UIInteractPoint:InteractBtnOnClick()
  if not self._interactPoint then
    Log.fatal("can not find interact point  text:" .. self._titleLabel.text)
    return
  end
  self._interactPoint:Interact(self)
end

function UIInteractPoint:_RefreshBreedLand()
  local land = self._interactPoint:GetBuild()
  if not land then
    return
  end
  local title = self._interactPoint:GetPointName()
  if land:InBreeding() then
    local remainTime = land:GetRemainTime()
    if remainTime <= 0 then
      title = StringTable.Get("str_homeland_breed_reap")
    else
      title = HomelandBreedTool.GetRemainTime(remainTime)
    end
  end
  self._titleLabel:SetText(title)
end

function UIInteractPoint:_AfterUILayerChanged()
  if not self._interactPoint then
    return
  end
  if self._interactPoint:GetPointType() == InteractPointType.Breed then
    self:_RefreshBreedLand()
  end
end

function UIInteractPoint:_FinishGuide()
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule:GuideInProgress() then
    local guides = guideModule:GetCurGuides()
    if guides then
      for _, guide in pairs(guides) do
        local curStep = guide:GetCurStep()
        if curStep and curStep.show then
          local param = curStep:GetBtnGuideCfg()
          local interactObjID = 0
          local interactObj = self._interactPoint:GetBuild()
          if HomelandTaskNPC:IsInstanceOfType(interactObj) then
            interactObjID = interactObj.npcID
          end
          if HomelandPet:IsInstanceOfType(interactObj) then
            interactObjID = interactObj:TemplateID()
          end
          if HomeBuilding:IsInstanceOfType(interactObj) then
            interactObjID = interactObj:GetBuildId()
          end
          if param and param.areaArgs and param.areaArgs[1] == interactObjID then
            GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Button)
          end
        end
      end
    end
  end
end

function UIInteractPoint:GetInteractBtn()
  return self._interactBtn.gameObject
end

function UIInteractPoint:GetBuild()
  return self._interactPoint:GetBuild()
end

function UIInteractPoint:GetPointType()
  return self._interactPoint:GetPointType()
end

function UIInteractPoint:OnUpdate(ms)
  if self._interactPoint then
    self._interval = self._interval + ms
    if self._interval >= 1000 then
      if self._interactPoint:GetPointType() == InteractPointType.Breed then
        self:_RefreshBreedLand()
      end
      self._interval = 0
    end
  end
end
