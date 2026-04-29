require("buff_logic_base")
_class("BuffLogicChargeColorPalette", BuffLogicBase)
BuffLogicChargeColorPalette = BuffLogicChargeColorPalette

function BuffLogicChargeColorPalette:Constructor(buffInstance, logicParam)
end

function BuffLogicChargeColorPalette:DoLogic()
  local entity = self._buffInstance:Entity()
  if entity:HasPetPstID() then
    if not entity:HasColorPalette() then
      entity:AddColorPalette()
    end
    local component = entity:ColorPalette()
    local pieceTypes = {
      PieceType.Blue,
      PieceType.Red,
      PieceType.Green,
      PieceType.Yellow
    }
    component:AddPieceTypes(pieceTypes)
    local configService = self._world:GetService("Config")
    local buffLogicService = self._world:GetService("BuffLogic")
    local extraSkillList = entity:SkillInfo():GetExtraActiveSkillIDList()
    if extraSkillList then
      for _, extraSkillID in ipairs(extraSkillList) do
        local extraSkillConfigData = configService:GetSkillConfigData(extraSkillID)
        if extraSkillConfigData and extraSkillConfigData:GetSkillTriggerType() == SkillTriggerType.ColorPalette then
          buffLogicService:ChangePetActiveSkillReady(entity, 1, extraSkillID)
        end
      end
    end
    return BuffResultChargeColorPalette:New(entity:GetID(), pieceTypes)
  end
end
