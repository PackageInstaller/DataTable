_class("ChainMoveData", Object)
ChainMoveData = ChainMoveData

function ChainMoveData:Constructor(petEntityID, pos, chainIndex)
  self.petEntityID = petEntityID
  self.pos = pos
  self.chainIndex = chainIndex
end

function ChainMoveData:GetPetEntityID()
  return self.petEntityID
end

function ChainMoveData:GetPos()
  return self.pos
end

function ChainMoveData:GetChainIndex()
  return self.chainIndex
end
