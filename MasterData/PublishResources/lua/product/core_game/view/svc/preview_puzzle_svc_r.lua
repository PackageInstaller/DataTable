_class("PreviewPuzzleService", BaseService)
PreviewPuzzleService = PreviewPuzzleService

function PreviewPuzzleService:PreEnterPuzzle()
  local previewEntity = self._world:GetPreviewEntity()
  local previewPuzzleCmpt = previewEntity:PreviewPuzzle()
  if previewPuzzleCmpt == nil then
    Log.fatal("PreEnterPuzzle puzzle component is nil")
    return
  end
  previewPuzzleCmpt:SetPuzzleState(PuzzleStateType.PreEnter)
end

function PreviewPuzzleService:EnterPuzzle(entityID, pickUpParam)
  local previewEntity = self._world:GetPreviewEntity()
  local previewPuzzleCmpt = previewEntity:PreviewPuzzle()
  if previewPuzzleCmpt == nil then
    Log.fatal("EnterPuzzle puzzle component is nil")
    return
  end
  local petEntity = self._world:GetEntityByID(entityID)
  if not petEntity then
    Log.fatal("EnterPuzzle pet entity is nil")
    return
  end
  local prePickUpCmpt = petEntity:PreviewPickUpComponent()
  if not prePickUpCmpt then
    Log.fatal("EnterPuzzle PreviewPickUpComponent is nil")
    return
  end
  local pickUpPos = prePickUpCmpt:GetLastPickUpGridPos()
  previewPuzzleCmpt:SetCenterPos(pickUpPos)
  previewPuzzleCmpt:AddPuzzleGridPos(pickUpPos)
  previewPuzzleCmpt:SetPuzzleGridEffID(pickUpParam.PuzzleGirdEffID)
  previewPuzzleCmpt:SetCasterEntityID(entityID)
  local trapServiceRender = self._world:GetService("TrapRender")
  trapServiceRender:OnTakeOutTrapFormPiece(pickUpPos)
  local pieceSvc = self._world:GetService("Piece")
  local pieceEntity = pieceSvc:FindPieceEntity(pickUpPos)
  pieceEntity:SetViewVisible(false)
  previewPuzzleCmpt:SetGapTilePos(pickUpPos)
  local puzzleScopeInfo = pickUpParam.PuzzleScope
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeResult = scopeCalculator:ComputeScopeRange(puzzleScopeInfo.ScopeType, puzzleScopeInfo.ScopeParam, pickUpPos, petEntity:BodyArea():GetArea(), petEntity:GetGridDirection(), puzzleScopeInfo.TargetType, pickUpPos, petEntity)
  previewPuzzleCmpt:SetPuzzleRange(scopeResult:GetAttackRange())
  previewPuzzleCmpt:SetPuzzleState(PuzzleStateType.Enter)
end

function PreviewPuzzleService:LeavePuzzle()
  local previewEntity = self._world:GetPreviewEntity()
  local previewPuzzleCmpt = previewEntity:PreviewPuzzle()
  if previewPuzzleCmpt == nil then
    Log.fatal("LeavePuzzle puzzle component is nil")
    return
  end
  local entityID = previewPuzzleCmpt:GetCasterEntityID()
  local petEntity = self._world:GetEntityByID(entityID)
  if not petEntity then
    Log.fatal("LeavePuzzle pet entity is nil")
    return
  end
  local prePickUpCmpt = petEntity:PreviewPickUpComponent()
  if not prePickUpCmpt then
    Log.fatal("LeavePuzzle PreviewPickUpComponent is nil")
    return
  end
  prePickUpCmpt:ClearGridPos()
  prePickUpCmpt:AddGridPosList(previewPuzzleCmpt:GetPuzzleGridPosList())
  previewEntity:ReplacePreviewPuzzle()
end

function PreviewPuzzleService:PuzzlePickUpGrid(pickUpGridPos)
  GameGlobal.TaskManager():CoreGameStartTask(self.DoMovePuzzleGrid, self, pickUpGridPos)
end

function PreviewPuzzleService:DoMovePuzzleGrid(TT, pickUpPos)
  local pieceSvc = self._world:GetService("Piece")
  local boardRSvc = self._world:GetService("BoardRender")
  local previewEntity = self._world:GetPreviewEntity()
  local previewPuzzleCmpt = previewEntity:PreviewPuzzle()
  if previewPuzzleCmpt == nil then
    Log.fatal("PreEnterPuzzle puzzle component is nil")
    return
  end
  previewPuzzleCmpt:SetPuzzleState(PuzzleStateType.Moving)
  local puzzleEffEntity
  local puzzleEffID = previewPuzzleCmpt:GetPuzzleGridEffID()
  if 0 < puzzleEffID then
    local effSvc = self._world:GetService("Effect")
    puzzleEffEntity = effSvc:CreateWorldPositionEffect(puzzleEffID, pickUpPos)
  end
  local gapPos = previewPuzzleCmpt:GetGapTilePos()
  local gapPieceEntity = pieceSvc:FindPieceEntity(gapPos)
  local pickUpPieceEntity = pieceSvc:FindPieceEntity(pickUpPos)
  local env = previewEntity:PreviewEnv()
  local pickUpPieceType = env:GetPieceType(pickUpPos)
  local gapPieceType = env:GetPieceType(gapPos)
  local trapServiceRender = self._world:GetService("TrapRender")
  trapServiceRender:OnTakeOutTrapFormPiece(pickUpPos)
  pickUpPieceEntity:RemoveGridMove()
  pickUpPieceEntity:AddGridMove(BattleConst.ConveySpeed, gapPos, pickUpPos)
  puzzleEffEntity:AddGridMove(BattleConst.ConveySpeed, gapPos, pickUpPos)
  while pickUpPieceEntity:HasGridMove() or puzzleEffEntity:HasGridMove() do
    YIELD(TT)
  end
  pickUpPieceEntity:SetGridPosition(pickUpPos)
  pickUpPieceEntity:SetLocation(pickUpPos, pickUpPieceEntity:GetGridDirection())
  boardRSvc:ChangeGridEntity(gapPieceType, pickUpPos)
  pickUpPieceEntity:SetViewVisible(false)
  gapPieceEntity:SetViewVisible(true)
  boardRSvc:ChangeGridEntity(pickUpPieceType, gapPos)
  self._world:DestroyEntity(puzzleEffEntity)
  env:SetPieceType(gapPos, pickUpPieceType)
  env:SetPieceType(pickUpPos, gapPieceType)
  previewPuzzleCmpt:SetGapTilePos(pickUpPos)
  previewPuzzleCmpt:AddPuzzleGridPos(pickUpPos)
  previewPuzzleCmpt:SetPuzzleState(PuzzleStateType.Enter)
end

function PreviewPuzzleService:IsPuzzleState()
  local previewEntity = self._world:GetPreviewEntity()
  local previewPuzzleCmpt = previewEntity:PreviewPuzzle()
  if previewPuzzleCmpt == nil then
    return false
  end
  if previewPuzzleCmpt:GetPuzzleState() ~= PuzzleStateType.None then
    return true
  end
  return false
end
