_class("BuffViewCloseLineRenderer", BuffViewBase)
BuffViewCloseLineRenderer = BuffViewCloseLineRenderer

function BuffViewCloseLineRenderer:PlayView(TT)
  local buffResult = self._buffResult
  local entity = self._entity
  local entityViewRoot = entity:View().ViewWrapper.GameObject.transform
  local renderers = entityViewRoot:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
  for i = 0, renderers.Length - 1 do
    local line = renderers[i]
    if line then
      line.gameObject:SetActive(false)
    end
  end
end
