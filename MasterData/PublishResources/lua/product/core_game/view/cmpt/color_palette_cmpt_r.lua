_class("ColorPaletteRenderComponent", Object)
ColorPaletteRenderComponent = ColorPaletteRenderComponent

function ColorPaletteRenderComponent:Constructor()
  self._pieceTypes = {}
end

function ColorPaletteRenderComponent:GetPieceTypes()
  return self._pieceTypes
end

function ColorPaletteRenderComponent:Clear()
  table.clear(self._pieceTypes)
end

function ColorPaletteRenderComponent:GetPieceTypesCount()
  return table.count(self._pieceTypes)
end

function ColorPaletteRenderComponent:IsSatisfy()
  return self:GetPieceTypesCount() >= PieceType.Yellow
end

function ColorPaletteRenderComponent:AddPieceTypes(pieceTypes)
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

function Entity:ColorPaletteRender()
  return self:GetComponent(self.WEComponentsEnum.ColorPaletteRender)
end

function Entity:HasColorPaletteRender()
  return self:HasComponent(self.WEComponentsEnum.ColorPaletteRender)
end

function Entity:AddColorPaletteRender()
  self:AddComponent(self.WEComponentsEnum.ColorPaletteRender, ColorPaletteRenderComponent:New())
end

function Entity:ReplaceColorPaletteRender()
  self:ReplaceComponent(self.WEComponentsEnum.ColorPaletteRender, ColorPaletteRenderComponent:New())
end

function Entity:RemoveColorPaletteRender()
  if self:HasColorPaletteRender() then
    self:RemoveComponent(self.WEComponentsEnum.ColorPaletteRender)
  end
end
