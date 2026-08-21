require("base_ins_r")
_class("PlayShowLineRendererInstruction", BaseInstruction)
PlayShowLineRendererInstruction = PlayShowLineRendererInstruction

function PlayShowLineRendererInstruction:Constructor(paramList)
  self._show = tonumber(paramList.show) == 1
  self._selfAll = tonumber(paramList.selfAll) == 1
  self._isTrap = tonumber(paramList.isTrap) == 1
end

function PlayShowLineRendererInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local monsterGroup = world:GetGroup(world.BW_WEMatchers.MonsterID)
  if self._isTrap then
    monsterGroup = world:GetGroup(world.BW_WEMatchers.Trap)
  end
  for i, entity in ipairs(monsterGroup:GetEntities()) do
    local effectID
    local effectLineRenderer = entity:EffectLineRenderer()
    if effectLineRenderer then
      effectLineRenderer:SetEffectLineRendererShow(casterEntity:GetID(), self._show)
      effectID = effectLineRenderer:GetEffectLineRendererEffectID(casterEntity:GetID())
    end
    local buffView = entity:BuffView()
    local notOpenLineEffectObjName = buffView:GetBuffValue("NotOpenLineEffectObjName")
    local effectHolderCmpt = entity:EffectHolder()
    if effectHolderCmpt then
      local effectList = effectHolderCmpt:GetPermanentEffect()
      for i, eff in ipairs(effectList) do
        if effectID and effectID == eff or self._selfAll then
          local e = world:GetEntityByID(eff)
          if e and e:HasView() then
            local go = e:View():GetGameObject()
            local renderers = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
            for i = 0, renderers.Length - 1 do
              local line = renderers[i]
              if line and notOpenLineEffectObjName ~= line.gameObject.name then
                line.gameObject:SetActive(self._show)
              end
            end
          end
        end
      end
    end
  end
end
