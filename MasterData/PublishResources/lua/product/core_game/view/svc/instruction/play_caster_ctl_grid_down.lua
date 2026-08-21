require("base_ins_r")
_class("PlayCasterControlGridDownInstruction", BaseInstruction)
PlayCasterControlGridDownInstruction = PlayCasterControlGridDownInstruction

function PlayCasterControlGridDownInstruction:Constructor(paramList)
  self._enable = tonumber(paramList.enable)
end

function PlayCasterControlGridDownInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local entity = casterEntity
  if casterEntity:HasSuperEntity() then
    local super = casterEntity:GetSuperEntity()
    if super then
      entity = super
    end
  end
  if entity:MonsterID() then
    local monsterIDCmpt = entity:MonsterID()
    monsterIDCmpt:SetNeedGridDownEnable(self._enable == 1)
  elseif entity:HasTrapID() then
    local trapRender = entity:TrapRender()
    trapRender:SetNeedGridDownEnable(self._enable == 1)
  end
  local world = entity:GetOwnerWorld()
  local bodyAreaCmpt = entity:BodyArea()
  local areaArray = bodyAreaCmpt:GetArea()
  local pieceSvc = world:GetService("Piece")
  local monsterGridPos = entity:GetRenderGridPosition()
  for i = 1, #areaArray do
    local curAreaPos = areaArray[i]
    local pos = Vector2(curAreaPos.x + monsterGridPos.x, curAreaPos.y + monsterGridPos.y)
    if self._enable == 1 then
      pieceSvc:SetPieceAnimDark(pos)
    else
      pieceSvc:SetPieceAnimNormal(pos)
    end
  end
end
