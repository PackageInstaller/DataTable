require("base_ins_r")
_class("PlayCasterShowLineRendererInstruction", BaseInstruction)
PlayCasterShowLineRendererInstruction = PlayCasterShowLineRendererInstruction

function PlayCasterShowLineRendererInstruction:Constructor(paramList)
  self._show = tonumber(paramList.show) == 1
end

function PlayCasterShowLineRendererInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local effectHolderCmpt = casterEntity:EffectHolder()
  if not effectHolderCmpt then
    return
  end
  local buffView = casterEntity:BuffView()
  local notOpenLineEffectObjName = buffView:GetBuffValue("NotOpenLineEffectObjName")
  local effectList = effectHolderCmpt:GetPermanentEffect()
  for i, eff in ipairs(effectList) do
    local e = world:GetEntityByID(eff)
    if e and e:HasView() then
      local go = e:View():GetGameObject()
      local renderers = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
      if renderers then
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
