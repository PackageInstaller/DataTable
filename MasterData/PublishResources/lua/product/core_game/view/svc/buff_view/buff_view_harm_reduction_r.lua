_class("BuffViewHarmReduction", BuffViewBase)
BuffViewHarmReduction = BuffViewHarmReduction

function BuffViewHarmReduction:PlayView(TT)
  local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
  if coreGameStateID == GameStateID.WaveEnter then
    return
  end
  local buffResult = self._buffResult
  local e = self._viewInstance:Entity()
  local entityID = e:GetID()
  local layer = buffResult:GetLayer()
  local viewValue = self:BuffViewInstance():GetLayerCount() or 0
  local destoryEffectList = {}
  local oldEffectID = self:GetEffectID(viewValue)
  local createEffectID = self:GetEffectID(layer)
  self:BuffViewInstance():SetLayerCount(TT, layer)
  local effectService = self._world:GetService("Effect")
  if createEffectID ~= oldEffectID or createEffectID == 0 then
    local effectHolderCmpt = e:EffectHolder()
    table.insert(destoryEffectList, BattleConst.HarmReductionNormal)
    table.insert(destoryEffectList, BattleConst.HarmReductionInvincible)
    effectService:DestroyEntityEffectByID(e, destoryEffectList)
    if createEffectID and 0 < createEffectID then
      local effect = effectService:CreateEffect(createEffectID, e)
      effectHolderCmpt:AttachPermanentEffect(effect:GetID())
    end
  end
  if 0 < buffResult:GetPreviewSkillID() then
    PlayCloseMonsterPreviewRangeInstruction:_HideMonsterAction(e)
    local skillHolder = buffResult:GetPreviewSkillHolder()
    local playSkillSvc = self._world:GetService("PlaySkill")
    local configSvc = self._world:GetService("Config")
    local skillConfigData = configSvc:GetSkillConfigData(buffResult:GetPreviewSkillID(), skillHolder)
    local skillPhaseArray = skillConfigData:GetSkillPhaseArray()
    playSkillSvc:_SkillRoutineTask(TT, skillHolder, skillPhaseArray, buffResult:GetPreviewSkillID())
  end
  self._world:EventDispatcher():Dispatch(GameEventType.UpdateBossHarmReduction, buffResult)
end

function BuffViewHarmReduction:GetEffectID(layer)
  local effectID = 0
  if 0 < layer and layer < 9 then
    effectID = BattleConst.HarmReductionNormal
  elseif layer == 9 then
    effectID = BattleConst.HarmReductionInvincible
  end
  return effectID
end
