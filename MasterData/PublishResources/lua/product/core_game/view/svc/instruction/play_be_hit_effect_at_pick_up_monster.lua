require("base_ins_r")
_class("PlayBeHitEffectAtPickUpMonsterInstruction", BaseInstruction)
PlayBeHitEffectAtPickUpMonsterInstruction = PlayBeHitEffectAtPickUpMonsterInstruction

function PlayBeHitEffectAtPickUpMonsterInstruction:Constructor(paramList)
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._pickUpIndex = tonumber(paramList.pickUpIndex) or 1
end

function PlayBeHitEffectAtPickUpMonsterInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local oriEntity = casterEntity
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    local cSuperEntity = casterEntity:SuperEntityComponent()
    oriEntity = cSuperEntity:GetSuperEntity()
  end
  local world = oriEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local renderPickUpComponent = oriEntity:RenderPickUpComponent()
  if not renderPickUpComponent then
    return
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local pickUpGridArray = renderPickUpComponent:GetAllValidPickUpGridPos()
  local v2PickupPos = pickUpGridArray[self._pickUpIndex]
  local targetEntity = self:_FindTargetEntityOnPos(v2PickupPos, world)
  if not targetEntity then
    return
  end
  local playDamageService = world:GetService("PlayDamage")
  local damageGridPos = v2PickupPos
  local damageShowType = playDamageService:SingleOrGrid(skillID)
  if self._hitEffectID and self._hitEffectID > 0 then
    local beHitEffectEntity = effectService:CreateBeHitEffect(self._hitEffectID, targetEntity, damageShowType, damageGridPos)
    if beHitEffectEntity ~= nil then
      local effectCtrl = beHitEffectEntity:EffectController()
      if effectCtrl ~= nil and casterEntity ~= nil then
        effectCtrl:SetEffectCasterID(casterEntity:GetID())
      end
    end
  end
end

function PlayBeHitEffectAtPickUpMonsterInstruction:GetCacheResource()
  local t = {}
  if self._hitEffectID and self._hitEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayBeHitEffectAtPickUpMonsterInstruction:_FindTargetEntityOnPos(v2Pos, world)
  if world:MatchType() == MatchType.MT_BlackFist then
    local enemyTeamEntity = world:Player():GetCurrentEnemyTeamEntity()
    if enemyTeamEntity and enemyTeamEntity:GetRenderGridPosition() == v2Pos then
      return enemyTeamEntity
    end
  else
    local monster_group = world:GetGroup(world.BW_WEMatchers.MonsterID)
    for _, e in ipairs(monster_group:GetEntities()) do
      local monsterPos = e:GetRenderGridPosition()
      local bodyAreaList = e:BodyArea():GetArea()
      for _, bodyArea in ipairs(bodyAreaList) do
        local pos = monsterPos + bodyArea
        if pos == v2Pos then
          return e
        end
      end
    end
  end
end
