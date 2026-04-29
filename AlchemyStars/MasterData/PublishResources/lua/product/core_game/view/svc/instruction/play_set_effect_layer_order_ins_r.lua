require("base_ins_r")
_class("PlaySetEffectLayerOrderInstruction", BaseInstruction)
PlaySetEffectLayerOrderInstruction = PlaySetEffectLayerOrderInstruction

function PlaySetEffectLayerOrderInstruction:Constructor(paramList)
  self._trapID = tonumber(paramList.trapID)
  self._layerName = paramList.layerName
end

function PlaySetEffectLayerOrderInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if not APPVER_LAYERORDER then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  if self._trapID and self._trapID > 0 then
    local entityList = {}
    local trapGroup = world:GetGroup(world.BW_WEMatchers.Trap)
    for _, e in ipairs(trapGroup:GetEntities()) do
      local trapRenderCmpt = e:TrapRender()
      if trapRenderCmpt and not trapRenderCmpt:GetHadPlayDestroy() and self._trapID == trapRenderCmpt:GetTrapID() then
        table.insert(entityList, e)
      end
    end
    for _, e in ipairs(entityList) do
      local go = e:View():GetGameObject()
      local tLayerOrderComponent = go.gameObject:GetComponent(typeof(TLayerOrderComponent))
      if tLayerOrderComponent then
        tLayerOrderComponent:SetSortLayer(self._layerName)
      end
    end
  end
end
