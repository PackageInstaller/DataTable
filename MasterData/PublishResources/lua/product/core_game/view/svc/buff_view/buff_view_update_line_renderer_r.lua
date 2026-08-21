_class("BuffViewUpdateLineRenderer", BuffViewBase)
BuffViewUpdateLineRenderer = BuffViewUpdateLineRenderer

function BuffViewUpdateLineRenderer:PlayView(TT)
  local buffResult = self._buffResult
  local entity = self._entity
  if not entity:HasView() then
    return
  end
  local entityViewRoot = entity:View().ViewWrapper.GameObject.transform
  local curRoot = GameObjectHelper.FindChild(entityViewRoot, buffResult:GetCurrent())
  local targetRoot
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, monsterEntity in pairs(monsterGroup:GetEntities()) do
    local cBuff = monsterEntity:BuffView()
    if cBuff and cBuff:HasBuffEffect(buffResult:GetBuffEffect()) then
      targetRoot = GameObjectHelper.FindChild(monsterEntity:View().ViewWrapper.GameObject.transform, buffResult:GetTarget())
      break
    end
  end
  if not curRoot or not targetRoot then
    return
  end
  local effectHolderCmpt = entity:EffectHolder()
  if not effectHolderCmpt then
    return
  end
  local effectList = effectHolderCmpt:GetPermanentEffect()
  for i, eff in ipairs(effectList) do
    local e = self._world:GetEntityByID(eff)
    if e:HasView() then
      local go = e:View():GetGameObject()
      local renderers = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
      for i = 0, renderers.Length - 1 do
        local line = renderers[i]
        if line then
          local currentPos = curRoot.position - entityViewRoot.position
          local targetPos = targetRoot.position - entityViewRoot.position
          line.gameObject:SetActive(true)
          line:SetPosition(0, currentPos)
          line:SetPosition(1, targetPos)
        end
      end
    end
  end
end
