require("base_ins_r")
_class("PlayCloseMonsterPreviewRangeInstruction", BaseInstruction)
PlayCloseMonsterPreviewRangeInstruction = PlayCloseMonsterPreviewRangeInstruction

function PlayCloseMonsterPreviewRangeInstruction:Constructor(paramList)
end

function PlayCloseMonsterPreviewRangeInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self:_HideMonsterAction(casterEntity)
end

function PlayCloseMonsterPreviewRangeInstruction:_HideMonsterAction(casterEntity)
  local monsterEntityID = casterEntity:GetID()
  local world = casterEntity:GetOwnerWorld()
  local renderEntityService = world:GetService("RenderEntity")
  renderEntityService:DestroyMonsterPreviewAreaOutlineEntity()
  local previewActiveSkillSvc = world:GetService("PreviewActiveSkill")
  world:GetService("MonsterShowRender"):MonsterGridAnimDown()
  local previewEntity = world:GetPreviewEntity()
  local renderStatCmpt = previewEntity:RenderState()
  local skillTipsEntityID = renderStatCmpt:GetSkillTipsEntityID()
  if skillTipsEntityID ~= -1 then
    local skillTipsEntity = world:GetEntityByID(skillTipsEntityID)
    skillTipsEntity:SetViewVisible(false)
  end
  local monsterEntity = world:GetEntityByID(monsterEntityID)
  local holderCmp = monsterEntity:EffectHolder()
  if not holderCmp then
    return
  end
  local idDic = holderCmp:GetEffectIDEntityDic()
  local entityList = idDic[BattleConst.MonsterAttackRangeTextEffect]
  if entityList then
    for k, entityId in pairs(entityList) do
      local entity = world:GetEntityByID(entityId)
      if entity then
        world:DestroyEntity(entity)
      end
    end
    idDic[BattleConst.MonsterAttackRangeTextEffect] = nil
  end
end

function PlayCloseMonsterPreviewRangeInstruction:_RemoveMonsterAttackText(world, monsterEntityID)
  local monsterEntity = world:GetEntityByID(monsterEntityID)
  local holderCmp = monsterEntity:EffectHolder()
  if not holderCmp then
    return
  end
  local idDic = holderCmp:GetEffectIDEntityDic()
  local entityList = idDic[BattleConst.MonsterAttackRangeTextEffect]
  if entityList then
    for k, entityId in pairs(entityList) do
      local entity = world:GetEntityByID(entityId)
      if entity then
        world:DestroyEntity(entity)
      end
    end
    idDic[BattleConst.MonsterAttackRangeTextEffect] = nil
  end
end
