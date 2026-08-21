_class("InputComponent", Object)
InputComponent = InputComponent

function InputComponent:Constructor(world)
  self._world = world
  self._touchHasBegin = nil
  self._touchMoving = nil
  self._touchBeginPos = nil
  self._touchMovePos = nil
  self._touchMovePosArray = nil
  self._touchEndPos = nil
  self._touchHasEnd = nil
  self._preTouchEndTime = 0
  self._isDoubleClick = false
  self._doubleClickInternal = 400
  self._doubleClickPos = nil
  self._isPreviewActiveSkill = false
  self._isPlayPreviewActiveSkill = false
end

function InputComponent:Destructor()
end

function InputComponent:Initialize()
end

function InputComponent:GetTouchBeginPosition()
  return self._touchBeginPos
end

function InputComponent:GetTouchMovePosition()
  return self._touchMovePos
end

function InputComponent:GetTouchMovePositionArray()
  return self._touchMovePosArray
end

function InputComponent:GetTouchEndPosition()
  return self._touchEndPos
end

function InputComponent:GetDoubleClickPosition()
  return self._doubleClickPos
end

function InputComponent:IsTouchMoving()
  return self._touchMoving
end

function InputComponent:TouchHasBegin()
  return self._touchHasBegin
end

function InputComponent:TouchEnd()
  return self._touchHasEnd
end

function InputComponent:IsDoubleClick()
  return self._isDoubleClick
end

function InputComponent:SetTouchBegin(begin)
  self._touchHasBegin = begin
end

function InputComponent:SetTouchMoving(moving)
  self._touchMoving = moving
end

function InputComponent:SetTouchBeginPosition(pos)
  self._touchBeginPos = pos
  self:SetTouchBegin(true)
end

function InputComponent:SetTouchMovePosition(pos)
  self._touchMovePos = pos
  self:SetTouchMoving(true)
end

function InputComponent:SetTouchMovePositionList(posArray)
  self._touchMovePosArray = posArray
  self:SetTouchMoving(true)
end

function InputComponent:SetTouchEndPosition(pos)
  self._touchEndPos = pos
  self:SetTouchEnd(true)
  self:SetTouchBegin(false)
  self:SetTouchMoving(false)
  self:SetDoubleClick(false)
end

function InputComponent:SetTouchEnd(hasEnd)
  self._touchHasEnd = hasEnd
end

function InputComponent:SetDoubleClickPos(doubleClickPos)
  self:SetDoubleClick(true)
  self._doubleClickPos = doubleClickPos
end

function InputComponent:SetDoubleClick(dbClick)
  self._isDoubleClick = dbClick
end

function InputComponent:SetPreviewActiveSkill(isPreview)
  self._isPreviewActiveSkill = isPreview
end

function InputComponent:SetPreviewActiveSkillPlay(isPlay)
  self._isPlayPreviewActiveSkill = isPlay
end

function InputComponent:IsPreviewActiveSkillPlaying()
  return self._isPlayPreviewActiveSkill
end

function InputComponent:IsPreviewActiveSkill()
  return self._isPreviewActiveSkill
end

function MainWorld:Input()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.Input)
end

function MainWorld:HasInput()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.Input) ~= nil
end

function MainWorld:AddInput()
  local index = self.BW_UniqueComponentsEnum.Input
  local component = InputComponent:New(self)
  component:Initialize()
  self:SetUniqueComponent(index, component)
end

function MainWorld:RemoveInput()
  if self:HasInput() then
    self:SetUniqueComponent(self.BW_UniqueComponentsEnum.Input, nil)
  end
end
