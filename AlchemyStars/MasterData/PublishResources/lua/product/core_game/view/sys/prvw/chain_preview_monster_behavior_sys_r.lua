_class("ChainPreviewMonsterBehaviorSystem_Render", Object)
ChainPreviewMonsterBehaviorSystem_Render = ChainPreviewMonsterBehaviorSystem_Render

function ChainPreviewMonsterBehaviorSystem_Render:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  self._skillCalculater = SkillScopeCalculator:New(utilScopeSvc)
  self._renderEntityService = world:GetService("RenderEntity")
  self._entityPoolServiceRender = world:GetService("EntityPool")
end

function ChainPreviewMonsterBehaviorSystem_Render:Execute()
  local reBoard = self._world:GetRenderBoardEntity()
  if reBoard == nil then
    return
  end
  local chainPreviewMonsterBehaviorCmpt = reBoard:ChainPreviewMonsterBehavior()
  if not chainPreviewMonsterBehaviorCmpt then
    return
  end
  local previewMonsterRange = chainPreviewMonsterBehaviorCmpt:GetPreviewMonsterRange()
  if table.count(previewMonsterRange) == 0 then
    return
  end
  local needRefresh = chainPreviewMonsterBehaviorCmpt:GetNeedRefresh()
  if not needRefresh then
    return
  end
  local chainPath = chainPreviewMonsterBehaviorCmpt:GetChainPath()
  for entityID, skillID in pairs(previewMonsterRange) do
    local entity = self._world:GetEntityByID(entityID)
    if entity then
      local posSelf = entity:GetGridPosition()
      local bodyArea = entity:BodyArea():GetArea()
      local skillConfigData = self._configService:GetSkillConfigData(skillID)
      local skillResult = self._skillCalculater:CalcSkillScope(skillConfigData, posSelf, Vector2(0, 1), bodyArea)
      local posList = skillResult:GetAttackRange()
      local showArea = true
      if table.count(chainPath) == 0 then
        showArea = false
      end
      for _, grid in ipairs(chainPath) do
        if not table.intable(posList, grid) then
          showArea = false
          break
        end
      end
      local outlineEntityList = chainPreviewMonsterBehaviorCmpt:GetOutlineEntityList(entityID)
      if showArea then
        if not outlineEntityList then
          outlineEntityList = self._renderEntityService:CreateAreaOutlineEntity(posList, EntityConfigIDRender.WarningArea)
          for i, outlineEntity in ipairs(outlineEntityList) do
            outlineEntity:ReplaceDamageWarningAreaElement(entityID, EntityConfigIDRender.WarningArea)
          end
          chainPreviewMonsterBehaviorCmpt:SetOutlineEntityList(entityID, outlineEntityList)
        end
      else
        if outlineEntityList and table.count(outlineEntityList) > 0 then
          for i, outlineEntity in ipairs(outlineEntityList) do
            local cmpt = outlineEntity:DamageWarningAreaElement()
            cmpt:ClearOwnerEntityID()
            self._entityPoolServiceRender:DestroyCacheEntity(outlineEntity, EntityConfigIDRender.WarningArea)
          end
        end
        chainPreviewMonsterBehaviorCmpt:SetOutlineEntityList(entityID, nil)
      end
    end
  end
  chainPreviewMonsterBehaviorCmpt:SetNeedRefresh(false)
end
