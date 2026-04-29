require("base_ins_r")
_class("PlayPuzzleInstruction", BaseInstruction)
PlayPuzzleInstruction = PlayPuzzleInstruction

function PlayPuzzleInstruction:Constructor(paramList)
  self._gridEffectID = tonumber(paramList.gridEffectID)
  self._convertDelayTime = tonumber(paramList.convertDelayTime)
end

function PlayPuzzleInstruction:GetCacheResource()
  local t = {}
  if self._gridEffectID and self._gridEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayPuzzleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local result = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Puzzle)
  if result == nil then
    Log.fatal("PlayPuzzleInstruction, result is nil.")
    return
  end
  local pieceSvc = world:GetService("Piece")
  local boardRSvc = world:GetService("BoardRender")
  local exchangePieceTypeList = result:GetExchangePieceTypeList()
  local exchangePiecePosList = {}
  for _, exchangeInfo in ipairs(exchangePieceTypeList) do
    local oldPos = exchangeInfo[1]
    local oldPieceType = exchangeInfo[2]
    local newPos = exchangeInfo[3]
    local newPieceType = exchangeInfo[4]
    boardRSvc:ChangeGridEntity(newPieceType, oldPos)
    boardRSvc:ChangeGridEntity(oldPieceType, newPos)
    if not table.icontains(exchangePiecePosList, oldPos) then
      table.insert(exchangePiecePosList, oldPos)
    end
    if not table.icontains(exchangePiecePosList, newPos) then
      table.insert(exchangePiecePosList, newPos)
    end
  end
  local convertInfo = result:GetConvertInfo()
  local gridPos = convertInfo[1]
  local targetGridType = convertInfo[3]
  local effectSvc = world:GetService("Effect")
  effectSvc:CreateWorldPositionEffect(self._gridEffectID, gridPos)
  YIELD(TT, self._convertDelayTime)
  boardRSvc:ReCreateGridEntity(targetGridType, gridPos, false)
  local gridEntity = pieceSvc:FindPieceEntity(gridPos)
  gridEntity:SetViewVisible(true)
  pieceSvc:RefreshPieceAnim()
  local tConvertInfo = result:GetNotifyConvertArray()
  local nt = NTGridConvert:New(casterEntity, tConvertInfo)
  nt:SetConvertEffectType(result:GetEffectType())
  local playBuffSvc = world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, nt)
  local trapServiceRender = world:GetService("TrapRender")
  for _, pos in ipairs(exchangePiecePosList) do
    trapServiceRender:OnGiveBackTrapToPiece(pos)
  end
end
