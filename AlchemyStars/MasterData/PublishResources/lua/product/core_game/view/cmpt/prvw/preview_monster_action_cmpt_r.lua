_class("PreviewMonsterActionComponent", Object)
PreviewMonsterActionComponent = PreviewMonsterActionComponent

function PreviewMonsterActionComponent:Constructor()
  self._showMonsterAction = false
  self._monsterEntityID = -1
  self._touchPos = Vector2(0, 0)
  self._touchOffset = Vector2(0, 0)
  self._previewTaskID = nil
end

function PreviewMonsterActionComponent:SetMonsterEntityID(monsterEntityID)
  self._monsterEntityID = monsterEntityID
end

function PreviewMonsterActionComponent:GetMonsterEntityID()
  return self._monsterEntityID
end

function PreviewMonsterActionComponent:ShowMonsterAction(show)
  self._showMonsterAction = show
end

function PreviewMonsterActionComponent:IsShowMonsterAction()
  return self._showMonsterAction
end

function PreviewMonsterActionComponent:SetTouchPosition(touchPosition, offset)
  self._touchPos = touchPosition
  self._touchOffset = offset
end

function PreviewMonsterActionComponent:GetTouchPosition()
  return self._touchPos
end

function PreviewMonsterActionComponent:GetTouchPositionOffset()
  return self._touchOffset
end

function PreviewMonsterActionComponent:SetPreviewTaskID(tid)
  if self._previewTaskID and tid then
    Log.fatal(self._className, "A preview task has already been started. ")
  end
  self._previewTaskID = tid
end

function PreviewMonsterActionComponent:GetPreviewTaskID()
  return self._previewTaskID
end

function PreviewMonsterActionComponent:KillPreviewTask()
  local tid = self:GetPreviewTaskID()
  if tid then
    TaskManager:GetInstance():KillTask(tid)
    self:SetPreviewTaskID(nil)
  end
end

function Entity:PreviewMonsterAction()
  return self:GetComponent(self.WEComponentsEnum.PreviewMonsterAction)
end

function Entity:HasPreviewMonsterAction()
  return self:HasComponent(self.WEComponentsEnum.PreviewMonsterAction)
end

function Entity:AddPreviewMonsterAction()
  local index = self.WEComponentsEnum.PreviewMonsterAction
  local component = PreviewMonsterActionComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePreviewMonsterAction(show, monsterEntityID)
  if self:HasPreviewMonsterAction() then
    local cmpt = self:PreviewMonsterAction()
    cmpt:KillPreviewTask()
  end
  local world = self:GetOwnerWorld()
  local renderEntityService = world:GetService("RenderEntity")
  renderEntityService:DestroyMonsterPreviewAreaOutlineEntity()
  if not show then
    local previewActiveSkillSvc = world:GetService("PreviewActiveSkill")
    world:GetService("MonsterShowRender"):MonsterGridAnimDown()
  end
  local index = self.WEComponentsEnum.PreviewMonsterAction
  local component = PreviewMonsterActionComponent:New()
  component:SetMonsterEntityID(monsterEntityID)
  component:ShowMonsterAction(show)
  self:ReplaceComponent(index, component)
end

function Entity:RemovePreviewMonsterAction()
  if self:HasPreviewMonsterAction() then
    local cmpt = self:PreviewMonsterAction()
    cmpt:KillPreviewTask()
    local world = self:GetOwnerWorld()
    local renderEntityService = world:GetService("RenderEntity")
    renderEntityService:DestroyMonsterPreviewAreaOutlineEntity()
    local previewActiveSkillSvc = world:GetService("PreviewActiveSkill")
    world:GetService("MonsterShowRender"):MonsterGridAnimDown()
    self:RemoveComponent(self.WEComponentsEnum.PreviewMonsterAction)
  end
end
