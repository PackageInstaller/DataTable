require("play_grid_range_convert_ins_r")
_class("PlayIsolateConvertInstruction", BaseInstruction)
PlayIsolateConvertInstruction = PlayIsolateConvertInstruction

function PlayIsolateConvertInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local cRoutine = casterEntity:SkillRoutine():GetResultContainer()
  local results = cRoutine:GetEffectResultsAsArray(SkillEffectType.IsolateConvert)
  local result = results[1]
  if not result then
    return
  end
  local tConvertInfo = {}
  local world = casterEntity:GetOwnerWorld()
  local tAtomicData = result:GetAtomicDataArray()
  for _, atomicData in ipairs(tAtomicData) do
    local traps = {}
    local pos = atomicData:GetPosition()
    local oldPieceType = atomicData:GetOldPieceType()
    local newPieceType = atomicData:GetTargetPieceType()
    local flushTrapIds = atomicData:GetDestroyedTrapArray()
    for i, v in ipairs(flushTrapIds) do
      local e = world:GetEntityByID(v)
      table.insert(traps, e)
    end
    local trapServiceRender = world:GetService("TrapRender")
    trapServiceRender:PlayTrapDieSkill(TT, traps)
    for _, trap in ipairs(traps) do
      trapServiceRender:DestroyTrap(TT, trap)
    end
    if newPieceType and newPieceType >= PieceType.None and newPieceType <= PieceType.Any then
      local boardServiceR = world:GetService("BoardRender")
      local newGridEntity = boardServiceR:ReCreateGridEntity(newPieceType, pos)
      if newGridEntity then
        local pieceSvc = world:GetService("Piece")
        pieceSvc:SetPieceEntityAnimNormal(newGridEntity)
      end
    end
    local convertInfo = NTGridConvert_ConvertInfo:New(pos, oldPieceType, newPieceType)
    table.insert(tConvertInfo, convertInfo)
  end
  local svcPlaySkill = world:GetService("PlaySkill")
  local svcPlayBuff = world:GetService("PlayBuff")
  if 0 < #tConvertInfo then
    local notify = NTGridConvert:New(casterEntity, tConvertInfo)
    notify:SetConvertEffectType(SkillEffectType.IsolateConvert)
    notify.__attackPosMatchRequired = true
    svcPlayBuff:PlayBuffView(TT, notify)
  end
end
