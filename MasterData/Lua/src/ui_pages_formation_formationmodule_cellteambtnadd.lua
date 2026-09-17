local this = class("cellTeamBtnAdd", G_UIModuleBase)
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle

function this.bind()
  return {
    txt_posIndex = nil,
    isOn_switchPos = false,
    isOn_addPet = false
  }
end

function this.methods()
  return {
    onClick_addHero = function(self)
      self:emit("onClick_addHero", self.bind)
    end,
    onClick_addPet = function(self)
      self:emit("onClick_addPet", self.bind)
    end,
    onClick_addSwitchPos = function(self)
      self:emit("onClick_addSwitchPos", self.bind)
    end
  }
end

function this:open()
end

function this:refresh()
  self:initCell()
end

function this:initCell()
  if not self.isBind then
    return
  end
  self.bind.txt_posIndex = tostring(self.bind.posIndex)
  local switchPos = self.bind.isChangePosMode == true
  local isPet = self.bind.roleType == L_Const.roleType.pet
  if switchPos ~= self.bind.isOn_switchPos and self.bind.isPlayAnim then
    self:playTeamBtnAnim()
  elseif isPet ~= self.bind.isOn_addPet and self.bind.isPlayAnim then
    self:playTeamBtnAnim()
  end
  self.bind.isOn_switchPos = switchPos
  self.bind.isOn_addPet = isPet
end

function this:setFollow()
  local pointPos = L_FormationManager:getPlacePos(self.bind.posIndex, self.bind.roleType)
  local pointPosStandard = L_FormationManager:getPlacePos(3, L_Const.roleType.pet)
  pointPos.y = pointPosStandard.y + 0.5
  local screenPos = C_CameraManager.mainCamera:WorldToScreenPoint(pointPos)
  local v2 = C_Vector2(screenPos.x, screenPos.y)
  local btnRect = self.uiBinding.gameObject:GetComponent(typeof(C_RectTransform))
  local parent = btnRect.parent
  local _, uiPos = _screenPosToUI(parent, v2, C_CameraManager.uiCamera)
  L_Vector3.setAnchored(btnRect, uiPos)
end

function this:playTeamBtnAnim()
  self.bindComponents.anim_team:Play("anim_formation_hud_add_show")
end

function this:getPosIndex()
  return self.bind.posIndex
end

return this
