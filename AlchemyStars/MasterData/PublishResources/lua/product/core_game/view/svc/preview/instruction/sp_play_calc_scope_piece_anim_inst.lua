require("sp_base_inst")
_class("SkillPreviewPlayCalcScopePieceAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayCalcScopePieceAnimInstruction = SkillPreviewPlayCalcScopePieceAnimInstruction

function SkillPreviewPlayCalcScopePieceAnimInstruction:Constructor(params)
  self._scopeAnim = params.ScopeAnim
  self._skillID = tonumber(params.skillID)
end

function SkillPreviewPlayCalcScopePieceAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  if not self._skillID then
    return
  end
  local world = previewContext:GetWorld()
  local casterPos = casterEntity:GetGridPosition()
  local bodyArea = casterEntity:BodyArea():GetArea()
  local configService = world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(self._skillID)
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, casterPos, casterEntity)
  if not scopeResult then
    return
  end
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  previewActiveSkillService:DoConvert(scopeResult:GetAttackRange(), self._scopeAnim)
end
