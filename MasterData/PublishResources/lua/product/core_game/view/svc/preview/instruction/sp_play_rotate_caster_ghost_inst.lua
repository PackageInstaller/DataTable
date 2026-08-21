require("sp_base_inst")
_class("SkillPreviewPlayRotateCasterGhostInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayRotateCasterGhostInstruction = SkillPreviewPlayRotateCasterGhostInstruction

function SkillPreviewPlayRotateCasterGhostInstruction:Constructor(params)
  self.DirCount = tonumber(params.DirCount) or 2
end

function SkillPreviewPlayRotateCasterGhostInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  local ghost = previewPickUpComponent:GetRotateGhost()
  local curDir = previewPickUpComponent:GetReflectDir()
  local nxtDir = ReflectDirectionType.Heng
  if not curDir then
    nxtDir = ReflectDirectionType.Heng
  elseif self.DirCount == 2 then
    if curDir == ReflectDirectionType.Heng then
      nxtDir = ReflectDirectionType.Shu
    elseif curDir == ReflectDirectionType.Shu then
      nxtDir = ReflectDirectionType.Heng
    end
  elseif self.DirCount == 4 then
    if curDir == ReflectDirectionType.Heng then
      nxtDir = ReflectDirectionType.Na
    elseif curDir == ReflectDirectionType.Na then
      nxtDir = ReflectDirectionType.Shu
    elseif curDir == ReflectDirectionType.Shu then
      nxtDir = ReflectDirectionType.Pie
    elseif curDir == ReflectDirectionType.Pie then
      nxtDir = ReflectDirectionType.Heng
    end
  end
  local casterPos = casterEntity:GetGridPosition()
  local centerPos = previewContext:GetPickUpPos()
  local tarPos = CalcReflectPos(casterPos, centerPos, nxtDir)
  ghost:SetDirection(tarPos - centerPos)
  previewPickUpComponent:SetReflectDir(nxtDir)
  previewPickUpComponent:SetReflectPos(tarPos)
  local skillPreviewConfigData = previewContext:GetConfigData()
  local scopeParam = skillPreviewConfigData:GetPreviewScopeParam()
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  local scopeResult = previewActiveSkillService:CalcScopeResult(scopeParam, casterEntity)
  previewContext:SetScopeResult(scopeResult:GetAttackRange())
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local targetIDList = utilScopeSvc:SelectSkillTarget(casterEntity, scopeParam:GetScopeTargetType(), scopeResult)
  previewContext:SetTargetEntityIDList(targetIDList)
end
