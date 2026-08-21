_class("DataColorPaletteResult", Object)
DataColorPaletteResult = DataColorPaletteResult

function DataColorPaletteResult:Constructor(entityID)
  self._entityID = entityID
end

function DataColorPaletteResult:EntityID()
  return self._entityID
end
