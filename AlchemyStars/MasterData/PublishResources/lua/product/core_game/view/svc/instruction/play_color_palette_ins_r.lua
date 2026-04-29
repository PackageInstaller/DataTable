require("base_ins_r")
_class("PlayColorPaletteInstruction", BaseInstruction)
PlayColorPaletteInstruction = PlayColorPaletteInstruction

function PlayColorPaletteInstruction:Constructor(paramList)
  self._stageIndex = tonumber(paramList.stageIndex) or 1
end

function PlayColorPaletteInstruction:GetCacheResource()
  local t = {}
  return t
end

function PlayColorPaletteInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if not casterEntity:HasPetPstID() then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ColorPaletteCharge)
  local pieceTypes = {}
  for _, _result in ipairs(resultArray) do
    local result = _result
    if result:GetPieceType() ~= PieceType.None then
      table.insert(pieceTypes, result:GetPieceType())
    end
  end
  if not casterEntity:HasColorPaletteRender() then
    casterEntity:AddColorPaletteRender()
  end
  local renderComponent = casterEntity:ColorPaletteRender()
  local isNotSatisfy = not renderComponent:IsSatisfy()
  renderComponent:AddPieceTypes(pieceTypes)
  world:EventDispatcher():Dispatch(GameEventType.ColorPaletteRefresh, casterEntity:PetPstID():GetPstID(), renderComponent:GetPieceTypes())
  if isNotSatisfy and renderComponent:IsSatisfy() then
    self:_RefreshExtraActiveSkillReady(casterEntity)
    local playBuffSvc = world:GetService("PlayBuff")
    playBuffSvc:PlayBuffView(TT, NTColorPaletteChargeComplete:New(casterEntity, renderComponent:GetPieceTypes()))
  end
end

function PlayColorPaletteInstruction:_RefreshExtraActiveSkillReady(entity)
  local world = entity:GetOwnerWorld()
  local configService = world:GetService("Config")
  local extraSkillList = entity:SkillInfo():GetExtraActiveSkillIDList()
  if extraSkillList then
    for _, extraSkillID in ipairs(extraSkillList) do
      local extraSkillConfigData = configService:GetSkillConfigData(extraSkillID)
      if extraSkillConfigData and extraSkillConfigData:GetSkillTriggerType() == SkillTriggerType.ColorPalette then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.PetExtraActiveSkillGetReady, entity:PetPstID():GetPstID(), extraSkillID, true)
      end
    end
  end
end
