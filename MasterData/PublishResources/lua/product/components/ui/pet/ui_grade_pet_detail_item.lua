_class("UIGradePetDetailItem", UICustomWidget)
UIGradePetDetailItem = UIGradePetDetailItem

function UIGradePetDetailItem:Constructor()
  self._index = 0
  self._isCurrent = false
  self._controllerName = "UIGradeInterfaceController"
end

function UIGradePetDetailItem:OnShow(uiParams)
  self._cg = self:GetUIComponent("RawImageLoader", "cg")
  self._rawImage = self:GetUIComponent("RawImage", "cg")
  self._cgGo = self:GetGameObject("cg")
  self._center = self:GetUIComponent("RectTransform", "center")
  self._rect2 = self:GetUIComponent("RectTransform", "rect2")
  self._group2 = self:GetUIComponent("CanvasGroup", "rect2")
  self._fx = self:GetGameObject("fx")
  self:AttachEvents()
end

function UIGradePetDetailItem:GetC2C()
  return self._off
end

function UIGradePetDetailItem:GetCgName()
  local isHaveNewDraw = false
  if self._bodyDiff ~= nil then
    isHaveNewDraw = true
  end
  local cgName
  if isHaveNewDraw then
    local next_grade = self._petInfo:GetPetGrade() + 1
    if next_grade > self._petInfo:GetMaxGrade() then
      next_grade = self._petInfo:GetMaxGrade()
      Log.fatal("[PetGrade] cant get new body", self._petInfo:GetTemplateID())
    end
    local _cfg_grade_cur = Cfg.cfg_pet_grade({
      PetID = self._petInfo:GetTemplateID(),
      Grade = self._petInfo:GetPetGrade()
    })
    local _cfg_grade_next = Cfg.cfg_pet_grade({
      PetID = self._petInfo:GetTemplateID(),
      Grade = next_grade
    })
    if _cfg_grade_next[1].SkinId ~= _cfg_grade_cur[1].SkinId then
      cgName = HelperProxy:GetInstance():GetPetStaticBody(self._petInfo:GetTemplateID(), next_grade, 0, PetSkinEffectPath.NO_EFFECT)
    else
      cgName = HelperProxy:GetInstance():GetPetStaticBody(self._petInfo:GetTemplateID(), next_grade, self._petInfo:GetSkinId(), PetSkinEffectPath.BODY_GRADE)
    end
  else
    cgName = self._petInfo:GetPetStaticBody(PetSkinEffectPath.BODY_GRADE)
  end
  return cgName
end

function UIGradePetDetailItem:AttachEvents()
  self:AttachEvent(GameEventType.GradeCheckIsCurrent, self.GradeCheckIsCurrent)
  self:AttachEvent(GameEventType.PetUpGradeEvent, self.PetUpGradeEvent)
  self:AttachEvent(GameEventType.PlayAnimation_UIGradePetDetailItem, self.PlayAnimation_UIGradePetDetailItem)
  self:AttachEvent(GameEventType.PetUpGradeChangeCgEvent, self.PetUpGradeChangeCgEvent)
end

function UIGradePetDetailItem:RemoveEvents()
  self:DetachEvent(GameEventType.GradeCheckIsCurrent, self.GradeCheckIsCurrent)
  self:DetachEvent(GameEventType.PetUpGradeEvent, self.PetUpGradeEvent)
  self:DetachEvent(GameEventType.PlayAnimation_UIGradePetDetailItem, self.PlayAnimation_UIGradePetDetailItem)
  self:DetachEvent(GameEventType.PetUpGradeChangeCgEvent, self.PetUpGradeChangeCgEvent)
end

function UIGradePetDetailItem:PetUpGradeEvent(pstid)
  if pstid == self._pstid then
    local anim = self:GetUIComponent("Animation", "anim")
    anim:Play("UIGradePetDetailItem")
  end
end

function UIGradePetDetailItem:PlayAnimation_UIGradePetDetailItem(pstid)
  if pstid == self._pstid then
    local anim = self:GetUIComponent("Animation", "anim")
    anim:Play("UIGradePetDetailItem_1")
  end
  self._fx:SetActive(false)
end

function UIGradePetDetailItem:PetUpGradeChangeCgEvent(pstid)
  if pstid == self._pstid then
    local petModule = self:GetModule(PetModule)
    self._petInfo = petModule:GetPet(self._pstid)
    self:LoadCgSync(self._petInfo:GetPetStaticBody(PetSkinEffectPath.BODY_GRADE))
  end
end

function UIGradePetDetailItem:GradeCheckIsCurrent(idx)
  self._isCurrent = self._index == idx
end

function UIGradePetDetailItem:OnHide()
  self._index = 0
  self:RemoveEvents()
end

function UIGradePetDetailItem:OnHideCallBack()
end

function UIGradePetDetailItem:SetData(index, pet, curridx)
  self._index = index
  self:GradeCheckIsCurrent(curridx)
  self._petInfo = pet
  self._pstid = self._petInfo:GetPstID()
  local size = Cfg.cfg_global.ui_interface_common_size.ArrayValue
  self._cgGo:GetComponent("RectTransform").sizeDelta = Vector2(size[1], size[2])
  self:LoadCgSync(self._petInfo:GetPetStaticBody(PetSkinEffectPath.BODY_GRADE))
end

function UIGradePetDetailItem:LoadCgSync(matName)
  self._cg:LoadImage(matName)
  UICG.SetTransform(self._cgGo.transform, self._controllerName, matName)
  local alpha = 1
  if not self._isCurrent then
    alpha = 0
  end
  self._group2.alpha = alpha
end

function UIGradePetDetailItem:ChangeCanvasGroupAlpha(all, centerX)
  self._off = self._center.position.x - centerX
  local rate = self._off / all
  rate = tonumber(string.format("%.3f", rate))
  if 1 < rate then
    rate = 1
  elseif rate < -1 then
    rate = -1
  end
  local alpha = 1 - math.abs(rate)
  self._rect2.anchoredPosition = Vector2(-500 * rate, 0)
  self._group2.alpha = alpha * 1.2
end
