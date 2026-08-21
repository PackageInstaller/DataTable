require("base_ins_r")
_class("PlayFixTrapWallInstruction", BaseInstruction)
PlayFixTrapWallInstruction = PlayFixTrapWallInstruction

function PlayFixTrapWallInstruction:Constructor(paramList)
  self._stageIndex = tonumber(paramList.stageIndex) or 1
end

function PlayFixTrapWallInstruction:GetCacheResource()
  local t = {}
  return t
end

function PlayFixTrapWallInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.FixTrapWall, self._stageIndex)
  if resultArray == nil then
    Log.fatal("PlayFixTrapWallInstruction, result is nil.")
    return
  end
  local result = resultArray[1]
  if result == nil then
    Log.fatal("PlayFixTrapWallInstruction, result is nil.")
    return
  end
  local isAdd = result:GetIsAdd()
  local trapWallPosList = result:GetFixTrapWallPosList()
  local effectService = world:GetService("Effect")
  local renderBoardEntity = world:GetRenderBoardEntity()
  local renderTrapWallComponent = renderBoardEntity:RenderTrapWall()
  if not renderTrapWallComponent then
    renderBoardEntity:AddRenderTrapWall()
    renderTrapWallComponent = renderBoardEntity:RenderTrapWall()
  end
  if isAdd then
    for _, trapWallPos in ipairs(trapWallPosList) do
      local dir = Vector2(0, 0)
      local effectID = BattleConst.TrapWallEffectIDW
      if trapWallPos.x ~= math.ceil(trapWallPos.x) then
        dir = Vector2(1, 0)
        effectID = BattleConst.TrapWallEffectIDL
      end
      local effEntity = effectService:CreateWorldPositionEffect(effectID, trapWallPos)
      renderTrapWallComponent:AddEffectEntity(effEntity:GetID(), trapWallPos)
    end
  else
    for _, pos in ipairs(trapWallPosList) do
      local trapWall = renderTrapWallComponent:GetTrapWall(pos)
      if trapWall then
        local entityID = trapWall:GetEffectEntityID()
        local effectEntity = world:GetEntityByID(entityID)
        if effectEntity then
          world:DestroyEntity(effectEntity)
        end
        renderTrapWallComponent:RemoveTrapWall(pos)
      end
    end
  end
end
