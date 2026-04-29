require("base_ins_r")
_class("PlayMonsterVisibleInstruction", BaseInstruction)
PlayMonsterVisibleInstruction = PlayMonsterVisibleInstruction

function PlayMonsterVisibleInstruction:Constructor(paramList)
  local param = tonumber(paramList.visible)
  if param == 1 then
    self._visible = true
  else
    self._visible = false
  end
end

function PlayMonsterVisibleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local offsetY = self._visible and 0 or 1000
  local group = world:GetGroup(world.BW_WEMatchers.EntityType)
  for _, e in ipairs(group:GetEntities()) do
    if e:EntityType().Value == EntityType.Monster and not e:HasShowDeath() then
      self:SetMonsterPos(e, offsetY)
      if e:MonsterID() and e:MonsterID():GetSnakeBodyEffectID() then
        local bodyEffectList = self:GetBodyEffect(e)
        for index, id in ipairs(bodyEffectList) do
          local bodyEffectEntity = world:GetEntityByID(id)
          self:SetMonsterPos(bodyEffectEntity, offsetY)
        end
      end
    end
  end
  local group = world:GetGroup(world.BW_WEMatchers.EntityType)
  for _, e in ipairs(group:GetEntities()) do
    if e:EntityType().Value == EntityType.HPSlider then
      e:SetViewVisible(self._visible)
    end
  end
end

function PlayMonsterVisibleInstruction:SetMonsterPos(monsterEntity, offsetY)
  local location = monsterEntity:Location()
  if location then
    local gridWorldPos = monsterEntity:GetPosition()
    local gridWorldNew = UnityEngine.Vector3.New(gridWorldPos.x, offsetY, gridWorldPos.z)
    monsterEntity:SetPosition(gridWorldNew)
  end
end

function PlayMonsterVisibleInstruction:GetBodyEffect(casterEntity)
  local bodyEffectList = {}
  local effectID = casterEntity:MonsterID():GetSnakeBodyEffectID()
  if casterEntity:HasEffectHolder() then
    local effectHolderCmpt = casterEntity:EffectHolder()
    local effectDictList = effectHolderCmpt:GetEffectIDEntityDic()
    for effectID, entityIDList in pairs(effectDictList) do
      if effectID == effectID then
        for i, id in ipairs(entityIDList) do
          table.insert(bodyEffectList, id)
        end
        break
      end
    end
  end
  return bodyEffectList
end
