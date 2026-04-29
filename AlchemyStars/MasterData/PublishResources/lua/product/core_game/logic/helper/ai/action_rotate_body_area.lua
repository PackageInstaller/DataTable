require("ai_node_new")
_class("ActionRotateBodyArea", AINewNode)
ActionRotateBodyArea = ActionRotateBodyArea

function ActionRotateBodyArea:OnBegin()
  local cGridLocation = self.m_entityOwn:GridLocation()
  local pos = cGridLocation.Position
  local cBodyArea = self.m_entityOwn:BodyArea()
  local area = cBodyArea:GetArea()
  local newArea = {}
  local isClockwise = self:GetLogicData(-1)
  for i, v in ipairs(area) do
    if isClockwise then
      table.insert(newArea, Vector2(v.y, -v.x))
    else
      table.insert(newArea, Vector2(-v.y, v.x))
    end
  end
  self.m_entityOwn:ReplaceBodyArea(newArea)
  if isClockwise then
    cGridLocation.Offset = Vector2(cGridLocation.Offset.y, -cGridLocation.Offset.x)
  else
    cGridLocation.Offset = Vector2(-cGridLocation.Offset.y, cGridLocation.Offset.x)
  end
  local triggerSvc = self._world:GetService("Trigger")
  triggerSvc:Notify(NTBodyAreaChange:New(self.m_entityOwn))
  local aiRecorderCmpt = self._world:GetBoardEntity():AIRecorder()
  aiRecorderCmpt:AddRotateBodyAreaResult(self.m_entityOwn:GetID(), RotateBodyAreaResult:New(newArea))
end

function ActionRotateBodyArea:OnUpdate()
  return AINewNodeStatus.Success
end
