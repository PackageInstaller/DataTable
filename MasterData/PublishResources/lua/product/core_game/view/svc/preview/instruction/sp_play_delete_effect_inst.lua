require("sp_base_inst")
_class("SkillPreviewPlayDeleteEffectInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayDeleteEffectInstruction = SkillPreviewPlayDeleteEffectInstruction

function SkillPreviewPlayDeleteEffectInstruction:Constructor(params)
  self._effectID = tonumber(params.EffectID)
  self._isPet1702361 = tonumber(params.isPet1702361)
end

function SkillPreviewPlayDeleteEffectInstruction:DoInstruction(TT, casterEntity, previewContext)
  local playEntity = casterEntity
  if self._isPet1702361 == 1 then
    local sPreviewSkill = previewContext:GetWorld():GetService("PreviewActiveSkill")
    playEntity = sPreviewSkill:GetPet1702361Entity(casterEntity, previewContext)
  end
  local world = previewContext:GetWorld()
  local holderCmp = playEntity:EffectHolder()
  if not holderCmp then
    return
  end
  local effectID = self._effectID
  local idDic = holderCmp:GetEffectIDEntityDic()
  local entityList = idDic[effectID]
  if entityList then
    for _, entityID in pairs(entityList) do
      if entityID then
        local entity = world:GetEntityByID(entityID)
        if entity then
          world:DestroyEntity(entity)
        end
      end
    end
    idDic[effectID] = nil
  end
end
