_class("GridAddViewSystem_Render", ReactiveSystem)
GridAddViewSystem_Render = GridAddViewSystem_Render

function GridAddViewSystem_Render:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
end

function GridAddViewSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.View)
  local c = Collector:New({group}, {"Added"})
  return c
end

function GridAddViewSystem_Render:Filter(entity)
  return entity:HasPiece() or entity:HasPieceFake()
end

function GridAddViewSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:OnGridViewAdded(entities[i])
  end
end

function GridAddViewSystem_Render:OnGridViewAdded(gridEntity)
  local gridPos = gridEntity:GridLocation().Position
  local pieceService = self._world:GetService("Piece")
  local utilDataSvc = self._world:GetService("UtilData")
  local gameFsmStateID = utilDataSvc:GetCurMainStateID()
  if gameFsmStateID == GameStateID.PickUpActiveSkillTarget then
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
    if pickUpTargetCmpt == nil then
      Log.fatal("pick up target is nil")
      return
    end
    local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
    local configService = self._configService
    local skillConfigData = configService:GetSkillConfigData(activeSkillID)
    local pickUpType = skillConfigData:GetSkillPickType()
    if pickUpType ~= SkillPickUpType.DirectionInstruction and pickUpType ~= SkillPickUpType.Instruction then
      self:_ChangeGridMaterial(gridEntity, gridPos)
    end
  elseif gameFsmStateID == GameStateID.ActiveSkill or gameFsmStateID == GameStateID.PersonaSkill then
  else
    local isMonsterArea = self:_ChangeGridMaterial(gridEntity, gridPos)
    if not isMonsterArea then
    end
  end
end

function GridAddViewSystem_Render:_InitLJSortingOrder(gridEntity)
  local gridGameObj = gridEntity:View().ViewWrapper.GameObject
  local lj_child = GameObjectHelper.FindChild(gridGameObj.transform, "lj_gezi_2")
  if not lj_child then
    return
  end
  local render = lj_child.gameObject:GetComponent(typeof(UnityEngine.MeshRenderer))
  render.sortingOrder = 1
end

function GridAddViewSystem_Render:_ChangeGridMaterial(gridEntity, gridPos)
  local utilDataSvc = self._world:GetService("UtilData")
  local curSt = utilDataSvc:GetCurMainStateID()
  local pieceSvc = self._world:GetService("Piece")
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    local monsterGridPos = e:GridLocation().Position
    if e:HasBodyArea() then
      local bodyAreaCmpt = e:BodyArea()
      local areaArray = bodyAreaCmpt:GetArea()
      for i = 1, #areaArray do
        local curAreaPos = areaArray[i]
        local monsterAreaPos = monsterGridPos + curAreaPos
        if monsterAreaPos == gridPos then
          if curSt ~= GameStateID.Loading then
            pieceSvc:SetPieceAnimDown(gridPos)
          end
          return true
        end
      end
    else
      local monsterAreaPos = monsterGridPos
      if monsterAreaPos == gridPos then
        if curSt ~= GameStateID.Loading then
          pieceSvc:SetPieceAnimDown(gridPos)
        end
        return true
      end
    end
  end
  return false
end
