require("base_ins_r")
_class("PlayCasterLineRendererInstruction", BaseInstruction)
PlayCasterLineRendererInstruction = PlayCasterLineRendererInstruction

function PlayCasterLineRendererInstruction:Constructor(paramList)
  local group = paramList.group
  self._group = string.split(group, "|")
  self._current = paramList.lineCurrent
  self._target = paramList.lineTarget
  self._targerEffectType = tonumber(paramList.targerEffectType)
  self._lineEffectID = tonumber(paramList.lineEffectID)
end

function PlayCasterLineRendererInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local targetGroupEntities = {}
  if table.intable(self._group, "Monster") then
    local monsterGroup = world:GetGroup(world.BW_WEMatchers.MonsterID)
    table.appendArray(targetGroupEntities, monsterGroup:GetEntities())
    if world:MatchType() == MatchType.MT_BlackFist then
      local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
      local enemyTeam = teamEntity:Team():GetEnemyTeamEntity()
      targetGroupEntities[#targetGroupEntities + 1] = enemyTeam
    end
  end
  if table.intable(self._group, "Trap") then
    local trapGroup = world:GetGroup(world.BW_WEMatchers.Trap)
    table.appendArray(targetGroupEntities, trapGroup:GetEntities())
  end
  if #targetGroupEntities == 0 then
    return
  end
  local targetRoot = GameObjectHelper.FindChild(casterEntity:View().ViewWrapper.GameObject.transform, self._target)
  if not targetRoot then
    return
  end
  for i, entity in ipairs(targetGroupEntities) do
    local effectLineRenderer = entity:EffectLineRenderer()
    if entity:IsViewVisible() and self:OnCheckEntityBuffEffect(entity) then
      local entityViewRoot = entity:View().ViewWrapper.GameObject.transform
      local curRoot = GameObjectHelper.FindChild(entityViewRoot, self._current)
      if not curRoot and EDITOR then
        if entity:TrapID() then
          Log.exception("TrapID:", entity:TrapID():GetTrapID(), "no  :", self._current)
        elseif entity:MonsterID() then
          Log.exception("MonsterID:", entity:MonsterID():GetMonsterID(), "no  :", self._current)
        end
      end
      if curRoot then
        if not effectLineRenderer then
          entity:AddEffectLineRenderer()
          effectLineRenderer = entity:EffectLineRenderer()
        end
        local effectHolderCmpt = entity:EffectHolder()
        if not effectHolderCmpt then
          entity:AddEffectHolder()
          effectHolderCmpt = entity:EffectHolder()
        end
        local effectEntityIdList = effectHolderCmpt:GetEffectIDEntityDic()[self._lineEffectID]
        local effect
        if effectEntityIdList then
          effect = world:GetEntityByID(effectEntityIdList[1])
        end
        if not effect then
          effect = effectService:CreateEffect(self._lineEffectID, entity)
          effectHolderCmpt:AttachPermanentEffect(effect:GetID())
        end
        YIELD(TT)
        if effect and effect:View() and effect:View():GetGameObject() then
          local go = effect:View():GetGameObject()
          local renderers
          renderers = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
          for i = 0, renderers.Length - 1 do
            local line = renderers[i]
            if line then
              line.gameObject:SetActive(true)
            end
          end
          effectLineRenderer:InitEffectLineRenderer(casterEntity:GetID(), curRoot, targetRoot, entityViewRoot, renderers, effect:GetID())
          effectLineRenderer:SetEffectLineRendererShow(casterEntity:GetID(), true)
        end
      end
    end
  end
end

function PlayCasterLineRendererInstruction:OnCheckEntityBuffEffect(entity)
  local pass = false
  local buffView = entity:BuffView()
  if buffView and buffView:HasBuffEffect(self._targerEffectType) then
    pass = true
  end
  return pass
end
