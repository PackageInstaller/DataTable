_class("BuffViewChargeColorPalette", BuffViewBase)
BuffViewChargeColorPalette = BuffViewChargeColorPalette

function BuffViewChargeColorPalette:PlayView(TT)
  local buffResult = self._buffResult
  local entity = self._world:GetEntityByID(buffResult:GetEntityID())
  if not entity:HasColorPaletteRender() then
    entity:AddColorPaletteRender()
  end
  local renderComponent = entity:ColorPaletteRender()
  renderComponent:AddPieceTypes(buffResult:GetPieceTypes())
  self._world:EventDispatcher():Dispatch(GameEventType.ColorPaletteRefresh, entity:PetPstID():GetPstID(), buffResult:GetPieceTypes())
end
