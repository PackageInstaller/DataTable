require("base_ins_r")
_class("PlayColorPaletteClearInstruction", BaseInstruction)
PlayColorPaletteClearInstruction = PlayColorPaletteClearInstruction

function PlayColorPaletteClearInstruction:Constructor(paramList)
end

function PlayColorPaletteClearInstruction:GetCacheResource()
  local t = {}
  return t
end

function PlayColorPaletteClearInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if not casterEntity:HasPetPstID() then
    return
  end
  if not casterEntity:HasColorPaletteRender() then
    casterEntity:AddColorPaletteRender()
  end
  local renderComponent = casterEntity:ColorPaletteRender()
  local world = casterEntity:GetOwnerWorld()
  world:EventDispatcher():Dispatch(GameEventType.ColorPaletteRefresh, casterEntity:PetPstID():GetPstID(), renderComponent:GetPieceTypes())
end
