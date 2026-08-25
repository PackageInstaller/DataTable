local Instantiate = CS.UnityEngine.GameObject.Instantiate
local Vector3 = CS.UnityEngine.Vector3
local MapItemBase = System.NewClass("MapItemBase")

function MapItemBase:ctor()
  self.go = nil
  self.tf = nil
  self.prefabPath = nil
  self.gridPos = {x = 0, y = 0}
end

function MapItemBase:OnSpawn()
end

function MapItemBase:OnDespawn()
end

function MapItemBase:OnLoad()
end

function MapItemBase:Dispose()
  self:Clear()
  ResLoadMgr.UnloadAssetByTarget(self)
end

function MapItemBase:Clear()
  if self.go then
    CS.UnityEngine.GameObject.Destroy(self.go)
  end
  self.go = nil
  self.tf = nil
  self.__parentTf = nil
end

function MapItemBase:LoadPrefab(prefabPath)
  if type(prefabPath) ~= "string" then
    Logger.Error("MapItemBase.LoadPrefab path is not str: " .. tostring(prefabPath))
    return
  end
  self:Clear()
  local prefab = ResLoadMgr.LoadAsset(prefabPath, self)
  self.prefabPath = prefabPath
  self.go = Instantiate(prefab)
  self.tf = self.go.transform
  if self.__parentTf then
    self.tf.parent = self.__parentTf
  end
  self:OnLoad()
end

function MapItemBase:SetParent(parentTf)
  self.__parentTf = parentTf
  if not self.tf then
    return
  end
  self.tf.parent = parentTf
end

function MapItemBase:SetPosition(posX, posZ, posY)
  if self.tf then
    self.tf.localPosition = Vector3(posX, posY or 0, posZ)
  end
end

function MapItemBase:SetGridPos(posX, posY)
  if self.gridPos then
    self.gridPos.x = posX
    self.gridPos.y = posY
  else
    self.gridPos = {x = posX, y = posY}
  end
end

function MapItemBase:GetGridPos()
  return self.gridPos.x, self.gridPos.y
end

function MapItemBase:UpdateMist()
  local x, y = self:GetGridPos()
  local roleMgr = self.manager:GetComponent(MapRoleManager)
  local effectMgr = self.manager:GetComponent(MapArtEffectManager)
  local curPosX, curPosY = roleMgr:GetRole():GetPrevPos()
  local gridX, gridY = self:GetGridPos()
  effectMgr:PlayOpenMistAndGridAnim(curPosX, curPosY, gridX, gridY)
end

function MapItemBase:IsRoleHere()
  local x, y = self:GetGridPos()
  local roleMgr = self.manager:GetComponent(MapRoleManager)
  local role = roleMgr:GetRole()
  local rolex, roley = role:GetGridPos()
  return x == rolex and y == roley
end

function MapItemBase:PlayAnim(_)
end

return MapItemBase
