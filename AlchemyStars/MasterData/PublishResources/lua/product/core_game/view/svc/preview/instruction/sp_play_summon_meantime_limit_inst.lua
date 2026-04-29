require("sp_base_inst")
_class("SkillPreviewPlaySummonMeantimeLimitInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlaySummonMeantimeLimitInstruction = SkillPreviewPlaySummonMeantimeLimitInstruction

function SkillPreviewPlaySummonMeantimeLimitInstruction:Constructor(params)
  self._visible = tonumber(params.visible)
  self._trapID = tonumber(params.trapID)
  self._limitCount = tonumber(params.limitCount)
end

function SkillPreviewPlaySummonMeantimeLimitInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local battleFlags = world:BattleFlags()
  local entityIDList = battleFlags:GetSummonMeantimeLimitEntityID(self._trapID)
  if table.count(entityIDList) < self._limitCount then
    return
  end
  for _, entityID in ipairs(entityIDList) do
    local entity = world:GetEntityByID(entityID)
    local location = entity:Location()
    if location then
      local gridWorldPos = entity:GetPosition()
      local gridWorldNew = UnityEngine.Vector3.New(gridWorldPos.x, 0, gridWorldPos.z)
      entity:SetPosition(gridWorldNew)
    end
  end
  local targetEntityID = entityIDList[1]
  local targetEntity = world:GetEntityByID(targetEntityID)
  if not targetEntity then
    return
  end
  local secondEntityID = entityIDList[2]
  local secondEntity = world:GetEntityByID(secondEntityID)
  if not secondEntity then
    return
  end
  if previewContext:GetPickUpPos() == secondEntity:GridLocation():GetGridPos() then
    targetEntity = secondEntity
  end
  local location = targetEntity:Location()
  if location then
    local gridWorldPos = targetEntity:GetPosition()
    local offsetY = self._visible == 1 and 0 or 1000
    local gridWorldNew = UnityEngine.Vector3.New(gridWorldPos.x, offsetY, gridWorldPos.z)
    targetEntity:SetPosition(gridWorldNew)
  end
end
