require("pop_star_wait_input_system")
_class("PopStarWaitInputSystem_Render", PopStarWaitInputSystem)
PopStarWaitInputSystem_Render = PopStarWaitInputSystem_Render

function PopStarWaitInputSystem_Render:_DoRenderHidePetEntity(TT, teamEntity)
  local pets = teamEntity:Team():GetTeamPetEntities()
  for _, e in ipairs(pets) do
    e:SetViewVisible(false)
  end
end

function PopStarWaitInputSystem_Render:_DoRenderPieceAnimation(TT)
  local piece_service = self._world:GetService("Piece")
  if piece_service then
    piece_service:SetAllPieceNormal()
  end
end

function PopStarWaitInputSystem_Render:_DoRenderPlayWaitInputBuff(TT)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTWaitInput:New())
end

function PopStarWaitInputSystem_Render:_DoRenderShowPetHeadUI(TT)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowPetInfo, 1)
end

function PopStarWaitInputSystem_Render:_DoRenderShowPlayerTurnInfo(TT, teamEntity)
  if teamEntity == nil then
    return
  end
  local petEntities = self._world:GetGroup(self._world.BW_WEMatchers.PetPstID):GetEntities()
  for _, e in ipairs(petEntities) do
    local pstIDCmpt = e:PetPstID()
    local pstID = pstIDCmpt:GetPstID()
    self._world:EventDispatcher():Dispatch(GameEventType.InOutQueue, pstID, false)
  end
end

function PopStarWaitInputSystem_Render:_DoRenderCompareHPLog(TT)
  local openException = false
  self:_CompareLogicRenderHP(openException)
end

function PopStarWaitInputSystem_Render:_DoRenderComparePieceType(TT)
  if not EDITOR then
    return
  end
  local cPreviewEnv = self._world:GetPreviewEntity():PreviewEnv()
  local cPreviewPieceTypeIndexMap = cPreviewEnv._pieceTypes
  local cPreviewAllPiece = cPreviewEnv:GetAllPieceType()
  local previewPieceDiff = {}
  for posIndex, pieceType in pairs(cPreviewPieceTypeIndexMap) do
    local x = posIndex // 100
    local y = posIndex - x * 100
    if not cPreviewAllPiece[x] then
      table.insert(previewPieceDiff, {
        posIndex = posIndex,
        err = "not found in all piece table"
      })
    elseif cPreviewAllPiece[x][y] ~= pieceType then
      table.insert(previewPieceDiff, {
        posIndex = posIndex,
        err = string.format("different color: _pieceType->%s, _allPieceTable->%s", tostring(pieceType), tostring(cPreviewAllPiece[x][y]))
      })
    end
  end
  local piecePosList = {}
  local tePiece = self._world:GetGroupEntities(self._world.BW_WEMatchers.Piece)
  for _, ePiece in ipairs(tePiece) do
    if not ePiece:HasOutsideRegion() then
      local cPiece = ePiece:Piece()
      local pos = ePiece:GetGridPosition()
      local pieceType = cPiece:GetPieceType()
      local previewEnvType = cPreviewEnv:GetPieceType(pos)
      if pieceType ~= previewEnvType then
        if pieceType == 0 and previewEnvType == 5 then
          Log.fatal("player at any piece pos")
        else
          table.insert(previewPieceDiff, {
            posIndex = pos:Pos2Index(),
            err = string.format("different piece color: piece->%s, previewEnv->%s", pieceType, previewEnvType)
          })
        end
      end
      if not table.icontains(piecePosList, pos) then
        table.insert(piecePosList, pos)
      else
        table.insert(previewPieceDiff, {
          posIndex = pos:Pos2Index(),
          err = "piece entity pos repeat"
        })
      end
    end
  end
  if #previewPieceDiff ~= 0 then
    for _, exception in ipairs(previewPieceDiff) do
      Log.error("[PieceTypeDiff] err: posIndex=", tostring(exception.posIndex), " desc: ", tostring(exception.err))
    end
    Log.exception("[PieceTypeDiff] PieceType conflict. Check log for more information. ")
  end
end

function PopStarWaitInputSystem_Render:_DoRenderSetPreviewTeam(teamEntity)
  self._world:Player():SetPreviewTeamEntity(teamEntity)
end
