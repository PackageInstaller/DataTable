_class("SkillEffectCalc_SnakeHeadMove", Object)
SkillEffectCalc_SnakeHeadMove = SkillEffectCalc_SnakeHeadMove

function SkillEffectCalc_SnakeHeadMove:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
  self._monsterShowLogic = self._world:GetService("MonsterShowLogic")
end

function SkillEffectCalc_SnakeHeadMove:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterID = skillEffectCalcParam.casterEntityID
  local targetIDList = skillEffectCalcParam.targetEntityIDs
  local casterEntity = self._world:GetEntityByID(casterID)
  local casterPos = casterEntity:GetGridPosition()
  local effectParam = skillEffectCalcParam.skillEffectParam
  local snakeMoveType = effectParam:GetHeadMoveType()
  local tailMonsterID = effectParam:GetTailMonsterID()
  local boardEntity = self._world:GetBoardEntity()
  local shareResultCmpt = boardEntity:ShareSkillResult()
  local utilDataSvc = self._world:GetService("UtilData")
  local tailEntityList = utilDataSvc:FindMonsterByMonsterID(tailMonsterID)
  local tailEntity = tailEntityList[1]
  local ignorePos
  if snakeMoveType == SnakeMoveType.Move then
    ignorePos = tailEntity:GetGridPosition()
  end
  local result
  if snakeMoveType ~= SnakeMoveType.Attack then
    local utilCalcSvc = self._world:GetService("UtilCalc")
    local retPath = utilCalcSvc:SnakeFindPathMove2PlayerNearestPath(casterEntity, ignorePos)
    if #retPath ~= 0 then
      local pos = retPath[1]
      result = SkillEffectSnakeHeadMoveResult:New(pos, casterPos, false)
    else
      local casterDir = casterEntity:GetGridDirection()
      local offset = {}
      if casterDir == Vector2(0, 1) then
        offset = {
          Vector2(0, 1),
          Vector2(1, 0),
          Vector2(-1, 0)
        }
      elseif casterDir == Vector2(0, -1) then
        offset = {
          Vector2(0, -1),
          Vector2(1, 0),
          Vector2(-1, 0)
        }
      elseif casterDir == Vector2(1, 0) then
        offset = {
          Vector2(0, 1),
          Vector2(1, 0),
          Vector2(0, -1)
        }
      elseif casterDir == Vector2(-1, 0) then
        offset = {
          Vector2(0, 1),
          Vector2(-1, 0),
          Vector2(0, -1)
        }
      end
      local posList = {}
      for i, v in ipairs(offset) do
        local offSetPos = Vector2(casterPos.x + v.x, v.y + casterPos.y)
        if utilCalcSvc:SnakeHeadCheckBlock(offSetPos, ignorePos) then
          table.insert(posList, offSetPos)
        end
      end
      if 0 < #posList then
        local tailPos = tailEntity:GetGridPosition()
        table.sort(posList, function(a, b)
          local disA = Vector2.Distance(a, tailPos)
          local disB = Vector2.Distance(b, tailPos)
          return disA > disB
        end)
        local pos = posList[1]
        result = SkillEffectSnakeHeadMoveResult:New(pos, casterPos, false)
      elseif casterEntity:HasMonsterID() then
        casterEntity:Attributes():Modify("HP", 0)
        self._monsterShowLogic:AddMonsterDeadMark(casterEntity)
        Log.debug("SnakeHeadDead ModifyHP =0 defender=", casterEntity:GetID())
        result = SkillEffectSnakeHeadMoveResult:New(nil, casterPos, true)
      end
    end
  else
    local targetID = targetIDList[1]
    local targetEntity = self._world:GetEntityByID(targetID)
    local pos = targetEntity:GetGridPosition()
    result = SkillEffectSnakeHeadMoveResult:New(pos, casterPos, false)
  end
  shareResultCmpt:AddEntityResult(casterID, result)
  return result
end
