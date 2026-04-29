_class("ColorPaletteComponent", Object)
ColorPaletteComponent = ColorPaletteComponent

function ColorPaletteComponent:Constructor()
  self._pieceTypes = {}
end

function ColorPaletteComponent:GetPieceTypes()
  return self._pieceTypes
end

function ColorPaletteComponent:Clear()
  table.clear(self._pieceTypes)
end

function ColorPaletteComponent:GetPieceTypesCount()
  return table.count(self._pieceTypes)
end

function ColorPaletteComponent:IsSatisfy()
  return self:GetPieceTypesCount() >= PieceType.Yellow
end

function ColorPaletteComponent:AddPieceTypes(pieceTypes)
  if pieceTypes then
    local anyPieces = {}
    for _, pieceType in ipairs(pieceTypes) do
      if pieceType == PieceType.Any then
        table.insert(anyPieces, pieceType)
      elseif not table.icontains(self._pieceTypes, pieceType) then
        table.insert(self._pieceTypes, pieceType)
      end
    end
    local anyCount = #anyPieces
    if 0 < anyCount then
      local tempPieceTypes = {
        PieceType.Blue,
        PieceType.Red,
        PieceType.Green,
        PieceType.Yellow
      }
      for _, pieceType in ipairs(tempPieceTypes) do
        if not table.icontains(self._pieceTypes, pieceType) then
          table.insert(self._pieceTypes, pieceType)
          anyCount = anyCount - 1
        end
        if anyCount <= 0 then
          break
        end
      end
    end
  end
end

function Entity:ColorPalette()
  return self:GetComponent(self.WEComponentsEnum.ColorPalette)
end

function Entity:HasColorPalette()
  return self:HasComponent(self.WEComponentsEnum.ColorPalette)
end

function Entity:AddColorPalette()
  self:AddComponent(self.WEComponentsEnum.ColorPalette, ColorPaletteComponent:New())
end

function Entity:ReplaceColorPalette()
  self:ReplaceComponent(self.WEComponentsEnum.ColorPalette, ColorPaletteComponent:New())
end

function Entity:RemoveColorPalette()
  if self:HasColorPalette() then
    self:RemoveComponent(self.WEComponentsEnum.ColorPalette)
  end
end
