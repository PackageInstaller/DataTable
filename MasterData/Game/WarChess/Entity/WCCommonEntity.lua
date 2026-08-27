local WCCommonEntity = class("WCCommonEntity")
local cs_ResLoader = CS.ResLoader
local cs_GameObject = CS.UnityEngine.GameObject
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local WarChessHelper = require("Game.WarChess.WarChessHelper")

function WCCommonEntity:ctor(entityData)
  self.__parentGo = nil
  self.resloader = nil
  self.entityData = entityData
  self.entityGo = nil
end

function WCCommonEntity:PreLoadModel(notWait, bind)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.entityGo ~= nil then
    DestroyUnityObject(self.entityGo)
    self.entityGo = nil
  end
  if not IsNull(self.__parentGo) then
    DestroyUnityObject(self.__parentGo)
    self.__parentGo = nil
  end
  local go = cs_GameObject()
  self.__parentGo = go
  local creatLogicPos = self.entityData:GetEntityLogicPos()
  if creatLogicPos ~= nil then
    local pos = Vector3.New(creatLogicPos.x, 0, creatLogicPos.y)
    self:WCEntitySetPos(pos)
  end
  local modelPath = PathConsts:GetWarChessPrefabPath(self.entityData:GetResModelName())
  self.resloader = cs_ResLoader.Create()
  if self.entityData:GetIsEmptyEntity() then
    if notWait then
      self:RealLoadModel(bind)
      return
    end
    return nil, BindCallback(self, self.RealLoadModel)
  end
  if notWait then
    self.__prefab = self.resloader:LoadABAsset(modelPath)
    self:RealLoadModel(bind)
    return
  end
  local areaAwait = self.resloader:LoadABAssetAsyncAwait(modelPath, function(prefab)
    self.__prefab = prefab
  end)
  return areaAwait, BindCallback(self, self.RealLoadModel)
end

function WCCommonEntity:RealLoadModel(bind)
  local creatLogicPos = self.entityData:GetEntityLogicPos()
  local parentName = "Entity:" .. tostring(creatLogicPos.x) .. "," .. tostring(creatLogicPos.y)
  if IsNull(self.__parentGo) then
    self.__parentGo = cs_GameObject()
  end
  self.__parentGo.name = parentName
  self.__parentGo.transform:SetParent(bind.entityRoot)
  if self.__prefab ~= nil then
    self.entityGo = self.__prefab:Instantiate(self.__parentGo.transform)
  end
  if creatLogicPos ~= nil then
    local pos = Vector3.New(creatLogicPos.x, 0, creatLogicPos.y)
    self:WCEntitySetPos(pos)
  end
  self.__prefab = nil
end

function WCCommonEntity:GetWCEntityMoverOverCallback(moveOverCallback)
  self.moveOverCallback = moveOverCallback
end

function WCCommonEntity:WCEntitySetPos(pos, playAnim)
  if not playAnim then
    self.__parentGo.transform.position = pos
    if self.moveOverCallback ~= nil then
      self.moveOverCallback()
      self.moveOverCallback = nil
    end
  else
    self.__parentGo.transform:DOMove(pos, 0.5):OnUpdate(function()
      if not self.entityData:GetWCEntityIsAlive() then
        return
      end
      MsgCenter:Broadcast(eMsgEventId.WC_EntityInfoUpdate, self.entityData)
    end):OnComplete(function()
      if self.moveOverCallback ~= nil then
        self.moveOverCallback()
        self.moveOverCallback = nil
      end
    end)
  end
  local rotate = self.entityData:GetWCEntityRotate()
  if rotate ~= nil then
    self.__parentGo.transform.localRotation = Quaternion.Euler(rotate.x, rotate.y, rotate.z)
  end
end

function WCCommonEntity:WCEntityGetParentGO()
  return self.__parentGo
end

function WCCommonEntity:WCEntityGetShowPos()
  if self.__parentGo == nil then
    return nil
  end
  return self.__parentGo.transform.position
end

function WCCommonEntity:Show()
  self.__parentGo:SetActive(true)
end

function WCCommonEntity:Hide()
  self.__parentGo:SetActive(false)
end

function WCCommonEntity:PlayWCEntityAnimation(animaId, animaTrigger)
  if not self.entityData:GetWCEntityIsAlive() then
    self.entityData:WCDeleteEntityGo()
    return
  end
  local entityGoAnimState = self.__parentGo:GetComponentInChildren(typeof(CS.WarChessGridAnimState))
  if entityGoAnimState ~= nil then
    entityGoAnimState:SetStageValue(animaId)
    if animaTrigger then
      entityGoAnimState:Tigger()
    end
    local nameHash = entityGoAnimState:GetCurrentStateNameHash()
    self.entityData:SaveEnitityAnimArg(nameHash, animaId)
  end
end

function WCCommonEntity:PlayWCEntityDownTween(time, delay)
  if not IsNull(self.__parentGo) then
    self.__parentGo.transform:DOLocalMoveY(-1, time or 0.5):SetDelay(delay or 0):OnComplete(function()
      self.entityData:WCDeleteEntityGo()
    end)
  end
end

function WCCommonEntity:SetWCEntityAnimation(nameHash, animaId)
  if IsNull(self.__parentGo) then
    error("entity is nil")
    return
  end
  local entityGoAnimState = self.__parentGo:GetComponentInChildren(typeof(CS.WarChessGridAnimState))
  if entityGoAnimState ~= nil then
    entityGoAnimState:ReSetState(nameHash, animaId)
  end
end

function WCCommonEntity:EntityOnSceneUnload()
  if not IsNull(self.__parentGo) then
    self.__parentGo.transform:DOKill()
  end
end

function WCCommonEntity:Delete()
  if self.__parentGo ~= nil then
    DestroyUnityObject(self.__parentGo)
    self.__parentGo = nil
  end
  self.entityGo = nil
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
end

return WCCommonEntity
