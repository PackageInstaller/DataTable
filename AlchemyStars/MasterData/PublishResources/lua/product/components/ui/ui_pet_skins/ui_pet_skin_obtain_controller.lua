_class("UIPetSkinObtainController", UIController)
UIPetSkinObtainController = UIPetSkinObtainController

function UIPetSkinObtainController:Constructor()
end

function UIPetSkinObtainController:OnShow(uiParams)
  local skinInfo = uiParams[1]
  if not skinInfo then
    self:Close()
    return
  end
  self._callback = uiParams[2]
  self._curAnim = nil
  local id = skinInfo.assetid
  local petId = 0
  local skinId = 0
  local isNew = true
  skinId = id
  local curSkinCfg = Cfg.cfg_pet_skin[skinId]
  if curSkinCfg then
    petId = curSkinCfg.PetId
  end
  self._getSkinInfo = ObtainPet:New(petId, isNew, skinId)
  self:InitWidget()
  self._anim = self:getAnim(self._getSkinInfo)
  self._anim:SetAsFirst()
  self._anim:Prepare()
  self:PlayAnimation()
end

function UIPetSkinObtainController:OnHide()
  if self._curAnim then
    self._curAnim:Dispose()
    self._curAnim = nil
  end
end

function UIPetSkinObtainController:getAnim(pet)
  return PetSkinObtainAnim:New(pet, nil, self:GetGameObject())
end

function UIPetSkinObtainController:InitWidget()
  self.closeBtnArea = self:GetGameObject("CloseBtnArea")
end

function UIPetSkinObtainController:CloseBtnOnClick(go)
  self:Close()
end

function UIPetSkinObtainController:Close()
  if self._callback then
    self._callback()
  end
end

function UIPetSkinObtainController:PlayAnimation()
  if self._curAnim then
    self._curAnim:Dispose()
    self._curAnim = nil
  end
  self.closeBtnArea:SetActive(false)
  self._curAnim = self._anim
  self._curAnim:Start()
  self._isPlaying = true
end

function UIPetSkinObtainController:OnUpdate(dtMS)
  if self._curAnim and self._isPlaying then
    self._curAnim:Update(dtMS)
    if self._curAnim:IsOver() then
      self.closeBtnArea:SetActive(true)
      self._isPlaying = false
    end
  end
end
