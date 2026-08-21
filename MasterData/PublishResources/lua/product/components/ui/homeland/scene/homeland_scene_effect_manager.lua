_class("HomelandSceneEffectManager", Object)
HomelandSceneEffectManager = HomelandSceneEffectManager

function HomelandSceneEffectManager:Constructor()
  self._list = {}
  self._indexs = 1
  self._deadList = {}
  self._isOp = false
end

function HomelandSceneEffectManager:Init(homelandClient)
  self._homelandClient = homelandClient
end

function HomelandSceneEffectManager:NewEffect(effectName, inAni, loopAni, outAni)
  local ids = self._indexs
  local hh = HomelandSceneEffect:New(ids, effectName, inAni, loopAni, outAni)
  self._list[ids] = hh
  self._indexs = self._indexs + 1
  return ids, hh
end

function HomelandSceneEffectManager:SetScale(ids, value)
  if self._list[ids] == nil then
    return
  end
  self._list[ids]:SetScale(value)
end

function HomelandSceneEffectManager:SetVisible(ids, value)
  if self._list[ids] == nil then
    return
  end
  self._list[ids]:SetVisible(value)
end

function HomelandSceneEffectManager:UpdatePosRota(ids, pos, rota)
  if self._list[ids] == nil then
    return
  end
  self._list[ids]:UpdatePosRota(pos, rota)
end

function HomelandSceneEffectManager:SetPos(ids, pos)
  if self._list[ids] == nil then
    return
  end
  self._list[ids]:SetPos(pos)
end

function HomelandSceneEffectManager:SetRota(ids, rota)
  if self._list[ids] == nil then
    return
  end
  self._list[ids]:SetRota(rota)
end

function HomelandSceneEffectManager:Execute(ids)
  if self._list[ids] == nil then
    return
  end
  self._list[ids]:Execute()
end

function HomelandSceneEffectManager:Exit(ids)
  if self._list[ids] == nil then
    return
  end
  self._list[ids]:Exit()
end

function HomelandSceneEffectManager:DeletEffect(ids)
  if self._list[ids] == nil then
    return
  end
  self._deadList[ids] = true
  self._isOp = true
end

function HomelandSceneEffectManager:Update(deltaTimeMS)
  if self._isOp == false then
    return
  end
  for k, v in pairs(self._deadList) do
    if self._list[k] ~= nil then
      self._list[k]:Dispose()
      self._list[k] = nil
    end
  end
  self._deadList = {}
  self._isOp = false
end

function HomelandSceneEffectManager:Dispose()
  for k, v in pairs(self._list) do
    v:Dispose()
  end
  self._list = {}
end
