require("sp_base_inst")
_class("SkillPreviewInitArrowByScopeInstruction", SkillPreviewBaseInstruction)
SkillPreviewInitArrowByScopeInstruction = SkillPreviewInitArrowByScopeInstruction

function SkillPreviewInitArrowByScopeInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local renderBoardEntity = world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local configService = world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, casterEntity)
  local validGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, casterEntity)
  local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, casterEntity)
  local finalGridList = {}
  for _, v2 in ipairs(validGridList) do
    if not table.icontains(invalidGridList, v2) then
      table.insert(finalGridList, v2)
    end
  end
  local v2Center = previewContext:GetCasterPos()
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  local tmpDirMap = {}
  for _, v2 in ipairs(finalGridList) do
    local v2Relative = v2 - v2Center
    local relativeX = v2Relative.x
    local relativeY = v2Relative.y
    if 0 < relativeX then
      if 0 < relativeY then
        tmpDirMap[2] = 2
      elseif relativeY < 0 then
        tmpDirMap[4] = 4
      else
        tmpDirMap[3] = 3
      end
    elseif relativeX < 0 then
      if 0 < relativeY then
        tmpDirMap[8] = 8
      elseif relativeY < 0 then
        tmpDirMap[6] = 6
      else
        tmpDirMap[7] = 7
      end
    elseif 0 < relativeY then
      tmpDirMap[1] = 1
    elseif relativeY < 0 then
      tmpDirMap[5] = 5
    end
  end
  local tDirection = {}
  for _, directionIndex in pairs(tmpDirMap) do
    table.insert(tDirection, directionIndex)
  end
  previewActiveSkillService:ShowPickUpArrow(tDirection, nil, casterEntity:GetGridPosition())
end
