_class("DrawCardUIContext", Object)
DrawCardUIContext = DrawCardUIContext

function DrawCardUIContext:Constructor(sceneReq)
  self._sceneResReq = sceneReq
  self._defaultIdx = -1
  self.isDrawCard = false
  self.maxStar = -1
  self.maxStarId = -1
  self.haveMaxS = false
end

function DrawCardUIContext:Dispose()
  self._sceneResReq = nil
  self._defaultIdx = -1
  self.isDrawCard = false
  self.maxStar = -1
  self.maxStarId = -1
  self.haveMaxS = false
end

function DrawCardUIContext:GetDefaultPoolIndex()
  return self._defaultIdx
end

function DrawCardUIContext:SetDefaultPoolIndex(idx)
  self._defaultIdx = idx
end

function DrawCardUIContext:SetStateDrawCard(value)
  self.isDrawCard = value
end

function DrawCardUIContext:GetStateDrawCard()
  return self.isDrawCard
end

function DrawCardUIContext:SetMaxStarPetId(maxStar, maxStarId)
  self.maxStar = maxStar
  self.maxStarId = maxStarId
end

function DrawCardUIContext:GetMaxStarPetId()
  return self.maxStar, self.maxStarId
end

function DrawCardUIContext:SetHaveMaxStarPet(value)
  self.haveMaxS = value
end

function DrawCardUIContext:GetHaveMaxStarPet()
  return self.haveMaxS
end

function DrawCardUIContext:SetPoolID(id)
  self._poolID = id
end

function DrawCardUIContext:SetPoolType(type)
  self._poolType = type
end

function DrawCardUIContext:GetPoolIDAndType()
  return self._poolID, self._poolType
end
