_class("EffectManager", Object)
EffectManager = EffectManager

function EffectManager.Init()
  EffectManager.pools = {}
  EffectManager.usings = {}
end

function EffectManager.Acquire(effName, parent, pos, length)
  if EffectManager.pools == nil then
    return nil
  end
  local pool = EffectManager.pools[effName]
  if pool == nil or #pool <= 0 then
    local eff = EffectManager.CreateEffect(effName, parent, pos)
    EffectManager.usings[#EffectManager.usings + 1] = {
      effName,
      eff,
      length
    }
    return eff
  end
  local eff = pool[#pool]
  table.remove(pool, #pool)
  local go = eff.Obj
  go:SetActive(true)
  go.transform:SetParent(parent)
  go.transform.localScale = Vector3(1, 1, 1)
  local tran = go:GetComponent("RectTransform")
  tran.anchoredPosition = pos
  EffectManager.usings[#EffectManager.usings + 1] = {
    effName,
    eff,
    length
  }
  return eff
end

function EffectManager.Recycle(effName, eff)
  if eff == nil then
    return
  end
  if EffectManager.pools == nil then
    EffectManager.DestroyEffect(eff)
    return
  end
  local pool = EffectManager.pools[effName]
  if pool == nil then
    pool = {}
    EffectManager.pools[effName] = pool
  end
  eff.Obj:SetActive(false)
  pool[#pool + 1] = eff
end

function EffectManager.Destroy()
  if EffectManager.pools == nil then
    return
  end
  for k, pool in pairs(EffectManager.pools) do
    for i = 1, #pool do
      EffectManager.DestroyEffect(pool[i])
    end
  end
  EffectManager.pools = nil
  for i = 1, #EffectManager.usings do
    EffectManager.DestroyEffect(EffectManager.usings[i][2])
  end
end

function EffectManager.CreateEffect(effName, parent, pos)
  local eff = ResourceManager:GetInstance():SyncLoadAsset(effName, LoadType.GameObject)
  if not eff or not eff.Obj then
    Log.fatal("[bounce]加载特效失败")
    return
  end
  local go = eff.Obj
  go:SetActive(true)
  go.transform:SetParent(parent)
  go.transform.localScale = Vector3(1, 1, 1)
  local tran = go:GetComponent("RectTransform")
  tran.anchoredPosition = pos
  return eff
end

function EffectManager.DestroyEffect(eff)
  if eff then
    eff:Dispose()
  end
end

function EffectManager.Update(deltaTimeMS)
  local removes = {}
  for i = 1, #EffectManager.usings do
    local t = EffectManager.usings[i]
    t[3] = t[3] - deltaTimeMS
    if t[3] <= 0 then
      EffectManager.Recycle(t[1], t[2])
      removes[#removes + 1] = i
    end
  end
  for i = 1, #removes do
    table.remove(EffectManager.usings, removes[i])
  end
end
