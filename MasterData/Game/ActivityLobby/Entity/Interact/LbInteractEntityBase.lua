local LbInteractEntityBase = class("LbInteractEntityBase")
local CS_GameObject = CS.UnityEngine.GameObject
local ActLbEnum = require("Game.ActivityLobby.ActLbEnum")

function LbInteractEntityBase:ctor(lbIntrctData)
  self._lbIntrctData = lbIntrctData
end

function LbInteractEntityBase:InitLbInteractEntityGo()
  local path = self._lbIntrctData:GetLbIntrctObjPath()
  local parentPath = self._lbIntrctData:GetLbIntrctParentObjPath()
  if string.IsNullOrEmpty(path) then
    return
  end
  self.isNeedHide = not string.IsNullOrEmpty(parentPath)
  local realPath, go
  if self.isNeedHide then
    local parentGo = CS_GameObject.Find(parentPath)
    go = parentGo.transform:Find(path).gameObject
    realPath = parentPath .. "/" .. path
    go:SetActive(true)
  else
    go = CS_GameObject.Find(path)
    realPath = path
  end
  if IsNull(go) then
    error("Cant find GameObject, path:" .. tostring(path))
    return
  end
  self.gameObject = go
  self.transform = go.transform
  local rangePath = realPath .. "/" .. ActLbEnum.InteractRangeName
  local interactRangeGO = CS_GameObject.Find(rangePath)
  if IsNull(interactRangeGO) then
    error("Cant find GameObject, path:" .. tostring(rangePath))
  end
  self._intrctRangeGo = interactRangeGO
  self._uiPoint = CS_GameObject.Find(realPath .. "/" .. "UIPoint")
  local fxPath = self._lbIntrctData:GetLbIntrctObjFxPath()
  if not string.IsNullOrEmpty(fxPath) then
    local fxTransform = self.transform:Find(fxPath)
    if IsNull(fxTransform) then
      error("Cant find fx, path:" .. tostring(fxPath))
    else
      self._fxGo = fxTransform.gameObject
    end
  end
  self:UpdLbIntrctEntFxUnlock()
end

function LbInteractEntityBase:GetLbIntrctEntRangeGo()
  return self._intrctRangeGo
end

function LbInteractEntityBase:GetLbIntrctEntData()
  return self._lbIntrctData
end

function LbInteractEntityBase:UpdLbIntrctEntFxUnlock()
  if IsNull(self._fxGo) then
    return
  end
  local unlock = self._lbIntrctData:IsLbIntrctUnlock()
  self._fxGo:SetActive(unlock)
end

function LbInteractEntityBase:SetLbInterctEntFunc(interactFunc)
  self._interactFunc = interactFunc
end

function LbInteractEntityBase:ExcuteLbInterctEntFunc()
  if self._interactFunc ~= nil then
    self._interactFunc(self)
  end
end

function LbInteractEntityBase:SetLbInteractEntCfg(interactEntCfg)
  self._interactEntCfg = interactEntCfg
end

function LbInteractEntityBase:GetLbIntrctEntiUIPintTransform()
  if IsNull(self.gameObject) then
    return nil
  end
  if IsNull(self._uiPoint) then
    error("Cant Get UIPoint, obj:" .. tostring(self.gameObject.name))
    return self.transform
  end
  return self._uiPoint.transform
end

function LbInteractEntityBase:GetLbInteractEntityId()
  return self._lbIntrctData:GetLbIntrctObjId()
end

function LbInteractEntityBase:HideLbEnttRenderer(hide)
end

function LbInteractEntityBase:SetRenderHide(bool)
  self.isRenderHide = bool
end

function LbInteractEntityBase:GetRenderHide()
  return self.isRenderHide
end

function LbInteractEntityBase:SetLbEnityGameObjectActive(bool)
  if IsNull(self.gameObject) then
    return
  end
  self.gameObject:SetActive(bool)
  if bool then
    self:UpdLbIntrctEntFxUnlock()
  end
end

function LbInteractEntityBase:SetLbEnityPos(pos)
  if IsNull(self.gameObject) then
    return
  end
  self.gameObject.transform.position = pos
end

function LbInteractEntityBase:OnDelete()
  if self.isNeedHide then
    self:SetLbEnityGameObjectActive(false)
    self.isNeedHide = nil
  end
end

return LbInteractEntityBase
