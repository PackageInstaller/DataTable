require("sp_base_inst")
_class("SkillPreviewPlayTargetSnipeEffectInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayTargetSnipeEffectInstruction = SkillPreviewPlayTargetSnipeEffectInstruction

function SkillPreviewPlayTargetSnipeEffectInstruction:Constructor(params)
end

function SkillPreviewPlayTargetSnipeEffectInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local targetIDList = previewContext:GetTargetEntityIDList()
  targetIDList = table.unique(targetIDList)
  local effectEntityList = {}
  local effectSvc = world:GetService("Effect")
  local renderBattleService = world:GetService("RenderBattle")
  local element = casterEntity:Element():GetPrimaryType()
  local previewIndex = previewContext:_GetPreviewIndex()
  for _, id in pairs(targetIDList) do
    local entity = world:GetEntityByID(id)
    if entity and entity:HasTeam() then
      entity = entity:GetTeamLeaderPetEntity()
    end
    local effectEntity = effectSvc:CreateEffect(BattleConst.ChainSkillSnipeEffectID, entity, true)
    renderBattleService:PlaySnipeEffectAnimation(effectEntity, element)
    table.insert(effectEntityList, effectEntity)
  end
  GameGlobal.TaskManager():CoreGameStartTask(self._PlaySnipeEffect, self, effectEntityList, element, world, previewIndex)
end

function SkillPreviewPlayTargetSnipeEffectInstruction:_PlaySnipeEffect(TT, effectList, element, world, previewIndex)
  local renderBattleService = world:GetService("RenderBattle")
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  while true do
    YIELD(TT, 1000)
    local newPreviewIndex = previewActiveSkillService:GetPreviewIndex()
    if newPreviewIndex ~= previewIndex then
      return
    end
    for i, effectEntity in ipairs(effectList) do
      renderBattleService:PlaySnipeEffectAnimation(effectEntity, element)
    end
  end
end
