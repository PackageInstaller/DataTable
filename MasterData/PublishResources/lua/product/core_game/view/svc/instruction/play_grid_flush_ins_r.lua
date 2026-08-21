_class("PlayGridFlushInstruction", BaseInstruction)
PlayGridFlushInstruction = PlayGridFlushInstruction

function PlayGridFlushInstruction:Constructor(paramList)
  self.flushDelayTime = tonumber(paramList.flushDelayTime)
  self.layerDelatTime = tonumber(paramList.layerDelayTime)
end

function PlayGridFlushInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local scope = casterEntity:SkillRoutine():GetResultContainer():GetScopeResult():GetWholeGridRange()
  local world = casterEntity:GetOwnerWorld()
  local utilData = world:GetService("UtilData")
  local maxLen = utilData:GetCurBoardMaxLen()
  local center = Vector2(5, 5)
  local edges = {
    [1] = {
      origin = Vector2(-1, 1),
      dir = Vector2(1, 0)
    },
    [2] = {
      origin = Vector2(1, 1),
      dir = Vector2(0, -1)
    },
    [3] = {
      origin = Vector2(1, -1),
      dir = Vector2(-1, 0)
    },
    [4] = {
      origin = Vector2(-1, -1),
      dir = Vector2(0, 1)
    }
  }
  local waitTasks = {}
  local layers = {}
  layers[1] = {center}
  for i = 6, maxLen do
    local grids = {}
    local layer = i - 5
    for _, edge in ipairs(edges) do
      local start = edge.origin * layer + center
      for j = 1, layer * 2 do
        local pos = start + (j - 1) * edge.dir
        if table.icontains(scope, pos) then
          grids[#grids + 1] = pos
        end
      end
    end
    layers[#layers + 1] = grids
  end
  for i = 1, #layers do
    local grids = layers[i]
    local waitTime = (i - 1) * self.layerDelatTime
    waitTasks[#waitTasks + 1] = GameGlobal.TaskManager():CoreGameStartTask(self.FlushGrids, self, waitTime, casterEntity, grids)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(waitTasks) do
    YIELD(TT)
  end
end

function PlayGridFlushInstruction:FlushGrids(TT, delay, casterEntity, grids)
  local world = casterEntity:GetOwnerWorld()
  local pieceService = world:GetService("Piece")
  YIELD(TT, delay)
  for _, grid in ipairs(grids) do
    pieceService:SetPieceAnimMoveDone(grid)
  end
  YIELD(TT, self.flushDelayTime)
  local playSkillInstructionService = world:GetService("PlaySkillInstruction")
  for _, grid in ipairs(grids) do
    playSkillInstructionService:GridConvert(TT, casterEntity, grid, SkillEffectType.ResetGridElement, nil)
  end
end
