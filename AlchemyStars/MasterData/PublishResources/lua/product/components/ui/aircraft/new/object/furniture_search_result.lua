_class("FurnitureSearchResult", Object)
FurnitureSearchResult = FurnitureSearchResult

function FurnitureSearchResult:Constructor()
  self._module = GameGlobal.GetModule(AircraftModule)
end

function FurnitureSearchResult:Search(id)
  if self._curFur == id then
    return self:MoveNext()
  else
    self._curFur = id
    self._result = {}
    for i = 1, AircraftConst.DecorateAreaCount do
      local furs = self._module:GetFurnitureByArea(i)
      if furs then
        for _, fur in pairs(furs) do
          if fur.asset_id == id then
            self._result[#self._result + 1] = fur
          end
        end
      end
    end
    if #self._result > 0 then
      self._index = 1
      return self._result[1]
    else
      self._curFur = nil
    end
  end
  return nil
end

function FurnitureSearchResult:MoveNext()
  self._index = self._index + 1
  if self._index > #self._result then
    self._index = 1
  end
  return self._result[self._index]
end
