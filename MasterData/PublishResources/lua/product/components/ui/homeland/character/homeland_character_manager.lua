_class("HomelandCharacterManager", Object)
HomelandCharacterManager = HomelandCharacterManager

function HomelandCharacterManager:Constructor()
  self._mainCharacterController = HomelandMainCharacterController:New()
  self._npcVisDic = {}
end

function HomelandCharacterManager:Init(homelandClient)
  self._mainCharacterController:Init(homelandClient)
end

function HomelandCharacterManager:Dispose()
  self._mainCharacterController:Dispose()
  self._npcVisDic = {}
end

function HomelandCharacterManager:Update(deltaTimeMS)
  self._mainCharacterController:Update(deltaTimeMS)
end

function HomelandCharacterManager:MainCharacterController()
  return self._mainCharacterController
end

function HomelandCharacterManager:GetCharacterTransform()
  return self._mainCharacterController:Transform()
end

function HomelandCharacterManager:OnModeChanged(TT, mode)
  self._mainCharacterController:OnModeChanged(TT, mode)
end

function HomelandCharacterManager:CharacterInteractable(interactPointType)
  local state = self._mainCharacterController:State()
  if state == HomelandActorStateType.Axe and interactPointType == InteractPointType.CutTree then
    return true
  elseif state == HomelandActorStateType.Pick and interactPointType == InteractPointType.Mining then
    return true
  elseif interactPointType == InteractPointType.TracePoint then
    return true
  else
    return state == HomelandActorStateType.Idle or state == HomelandActorStateType.Run or state == HomelandActorStateType.Swim or state == HomelandActorStateType.Navigate
  end
end

function HomelandCharacterManager:RegisterNpc(npcGO)
  if npcGO then
    self._npcVisDic[npcGO] = npcGO.activeSelf
  end
end

function HomelandCharacterManager:UnRegisterNpc(npcGO)
  if npcGO then
    self._npcVisDic[npcGO] = nil
  end
end

function HomelandCharacterManager:HideNpcs()
  for npc, _ in pairs(self._npcVisDic) do
    self._npcVisDic[npc] = npc.activeSelf
    npc:SetActive(false)
  end
end

function HomelandCharacterManager:RevertNpcs()
  for npc, vis in pairs(self._npcVisDic) do
    npc:SetActive(vis)
  end
end
