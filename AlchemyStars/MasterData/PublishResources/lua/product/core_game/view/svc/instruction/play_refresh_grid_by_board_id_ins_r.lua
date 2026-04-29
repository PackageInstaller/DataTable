require("base_ins_r")
_class("PlayRefreshGridByBoardIDInstruction", BaseInstruction)
PlayRefreshGridByBoardIDInstruction = PlayRefreshGridByBoardIDInstruction

function PlayRefreshGridByBoardIDInstruction:Constructor(paramList)
  local str = paramList.sceneEffectIDs
  local strIDs = string.split(str, "|")
  self._sceneEffectIDs = {}
  for _, v in ipairs(strIDs) do
    self._sceneEffectIDs[#self._sceneEffectIDs + 1] = tonumber(v)
  end
  self._sceneEffPos = Vector2(tonumber(paramList.gridPosX), tonumber(paramList.gridPosY))
  str = paramList.sceneChangeEffectIDs
  strIDs = string.split(str, "|")
  self._sceneChangeEffectIDs = {}
  for _, v in ipairs(strIDs) do
    self._sceneChangeEffectIDs[#self._sceneChangeEffectIDs + 1] = tonumber(v)
  end
  self._changeDelayTime = tonumber(paramList.changeDelayTime) or 0
  self._backIntensity = tonumber(paramList.backIntensity)
end

function PlayRefreshGridByBoardIDInstruction:GetCacheResource()
  local t = {}
  for _, value in ipairs(self._sceneEffectIDs) do
    if value and 0 < value then
      table.insert(t, {
        Cfg.cfg_effect[value].ResPath,
        1
      })
    end
  end
  for _, value in ipairs(self._sceneChangeEffectIDs) do
    if value and 0 < value then
      table.insert(t, {
        Cfg.cfg_effect[value].ResPath,
        1
      })
    end
  end
  return t
end

function PlayRefreshGridByBoardIDInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local result = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.RefreshGridByBoardID)
  if result == nil then
    return
  end
  local changeTimes = result:GetSceneChangeTimes()
  local index = 0
  index = math.fmod(changeTimes, #self._sceneEffectIDs)
  if index == 0 then
    index = #self._sceneEffectIDs
  end
  local curSceneEffectID = self._sceneEffectIDs[index]
  local curSceneChangeEffectID = self._sceneChangeEffectIDs[index]
  local effectSvc = world:GetService("Effect")
  effectSvc:CreateEffect(curSceneChangeEffectID, casterEntity)
  if 0 < self._changeDelayTime then
    YIELD(TT, self._changeDelayTime)
  end
  local trapSvc = world:GetService("TrapRender")
  local destroyTrapEntityIDList = result:GetDestroyTrapEntityIDList()
  local trapEntityList = {}
  local trapEntityPlayDieList = {}
  for _, entityID in ipairs(destroyTrapEntityIDList) do
    local entity = world:GetEntityByID(entityID)
    local trapRenderCmpt = entity:TrapRender()
    if trapRenderCmpt and trapRenderCmpt:GetIsPrismGrid() ~= nil then
      table.insert(trapEntityPlayDieList, entity)
    else
      table.insert(trapEntityList, entity)
    end
  end
  trapSvc:PlayTrapDieSkill(TT, trapEntityPlayDieList)
  trapSvc:PlayTrapDieSkill(TT, trapEntityList, true)
  local pieceSvc = world:GetService("Piece")
  local renderBoardEntity = world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local boardSvc = world:GetService("BoardRender")
  for pos, pieceType in pairs(result:GetGridPieceData()) do
    local currentPiece = renderBoardCmpt:GetGridRenderEntity(pos)
    if currentPiece then
      if currentPiece:Piece() and currentPiece:Piece():GetPieceType() ~= pieceType then
        local gridEntity = boardSvc:ChangeGridEntity(pieceType, pos)
        pieceSvc:SetPieceEntityAnimNormal(gridEntity)
      end
      pieceSvc:SetPieceRenderEffect(pos, PieceEffectType.Normal)
    else
      boardSvc:CreateGridEntity(pieceType, pos)
    end
  end
  local effectID = renderBoardCmpt:GetSceneEffectEntityID()
  effectSvc:DestroyEffectByID(effectID)
  local sceneEffEntity = effectSvc:CreateWorldPositionEffect(curSceneEffectID, self._sceneEffPos)
  renderBoardCmpt:SetSceneEffectEntityID(sceneEffEntity:GetID())
  local goRenderSetting = UnityEngine.GameObject.Find("[H3DRenderSetting]")
  local csRenderSetting = goRenderSetting:GetComponent("H3DRenderSetting")
  if csRenderSetting.BackIntensity then
    csRenderSetting.BackIntensity = self._backIntensity
  end
end
