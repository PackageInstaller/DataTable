require("base_ins_r")
_class("PlayChangeBuffLayerInstruction", BaseInstruction)
PlayChangeBuffLayerInstruction = PlayChangeBuffLayerInstruction

function PlayChangeBuffLayerInstruction:Constructor(paramList)
  self._stageIndex = tonumber(paramList.stageIndex) or 1
end

function PlayChangeBuffLayerInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local buffResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ChangeBuffLayer, self._stageIndex)
  if not buffResultArray or table.count(buffResultArray) == 0 then
    return
  end
  local playBuffService = world:GetService("PlayBuff")
  for _, result in ipairs(buffResultArray) do
    local entityID = result:GetEntityID()
    local entity = world:GetEntityByID(entityID)
    local buffEffectType = result:GetTargetBuffEffectType()
    local layerCount = result:GetLayer()
    local buffseq = result:GetTargetBuffSeq()
    local buffView = entity:BuffView()
    local viewInstance = buffView:GetBuffViewInstance(buffseq)
    if viewInstance then
      viewInstance:SetLayerCount(TT, layerCount)
      if entity:HasPetPstID() then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, entity:PetPstID():GetPstID(), layerCount)
      end
    end
  end
  world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
end
