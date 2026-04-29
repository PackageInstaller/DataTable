require("pick_up_policy_base")
_class("PickUpPolicy_PetZeta1", PickUpPolicy_Base)
PickUpPolicy_PetZeta1 = PickUpPolicy_PetZeta1

function PickUpPolicy_PetZeta1:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local curBodyArea = petEntity:BodyArea():GetArea()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local hasPieces = {}
  local colorPaletteComponent = petEntity:ColorPalette()
  if colorPaletteComponent then
    hasPieces = colorPaletteComponent:GetPieceTypes()
  end
  local needPieces = {}
  for i = 1, 4 do
    if not table.intable(hasPieces, i) then
      table.insert(needPieces, i)
    end
  end
  local pickPosList = {}
  local targetIDs = {}
  local boardServiceLogic = self._world:GetService("BoardLogic")
  for i = 1, table.count(needPieces) do
    local needPiece = needPieces[i]
    local pieceRange = boardServiceLogic:GetGridPosByPieceType({needPiece})
    local pieceCount = table.count(pieceRange)
    if pieceRange and 0 < pieceCount then
      local randomIndex = math.random(1, pieceCount)
      local randomPos = pieceRange[randomIndex]
      table.insert(pickPosList, randomPos)
    end
  end
  while pickUpNum < table.count(pickPosList) do
    table.removev(pickPosList, pickPosList[#pickPosList])
  end
  if pickUpNum > table.count(pickPosList) then
    local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
    while pickUpNum > table.count(pickPosList) do
      local randomIndex = math.random(1, #validPosList)
      local randomPos = validPosList[randomIndex]
      local curPieceType = boardServiceLogic:GetPieceType(randomPos)
      if not table.icontains(pickPosList, randomPos) and curPieceType ~= PieceType.None then
        table.insert(pickPosList, randomPos)
      end
    end
  end
  return pickPosList, pickPosList, targetIDs
end
