local WCFairyEntity = class("WCFairyEntity")
local util = require("XLua.Common.xlua_util")
local cs_ResLoader = CS.ResLoader
local cs_GameObject = CS.UnityEngine.GameObject

function WCFairyEntity:ctor(teamIndex)
  self.__parentGo = nil
  self.animator = nil
  self.teamIndex = teamIndex
  self.resloader = nil
  self.dynFairyData = nil
  self.fairyGo = nil
end

function WCFairyEntity:CheckFiaryData(dynFairyData, notWait, parentHeroEntity, heroEntityRoot)
  if dynFairyData == nil or self.dynFairyData ~= nil and self.dynFairyData:GetFairyPrefabResStr() == dynFairyData:GetFairyPrefabResStr() then
    return
  end
  self.dynFairyData = dynFairyData
  return self:WCLoadFairyModel(notWait, parentHeroEntity, heroEntityRoot)
end

function WCFairyEntity:WCLoadFairyModel(notWait, parentHeroEntity, heroEntityRoot)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.fairyGo ~= nil then
    DestroyUnityObject(self.fairyGo)
    self.fairyGo = nil
  end
  self.resloader = cs_ResLoader.Create()
  if not IsNull(self.__parentGo) then
    DestroyUnityObject(self.__parentGo)
    self.__parentGo = nil
  end
  local go = cs_GameObject("Fairy:" .. tostring(self.teamIndex))
  self.__parentGo = go
  local modelPath = self.dynFairyData:GetFairyPrefabResStr()
  local fairyAwait = self.resloader:LoadABAssetAsyncAwait(modelPath, function(prefab)
    self.__prefab = prefab
    if notWait then
      self:RealLoadModel(parentHeroEntity, heroEntityRoot)
      return
    end
  end)
  return fairyAwait, BindCallback(self, self.RealLoadModel, parentHeroEntity, heroEntityRoot)
end

function WCFairyEntity:RealLoadModel(parentHeroEntity, heroEntityRoot)
  if IsNull(self.__parentGo) then
    self.__parentGo = cs_GameObject("Fairy:" .. tostring(self.teamIndex))
  end
  self.__parentGo.transform:SetParent(heroEntityRoot)
  if self.__prefab ~= nil then
    self.fairyGo = self.__prefab:Instantiate(self.__parentGo.transform)
    self.animator = self.fairyGo:FindComponent(eUnityComponentID.Animator)
  end
  self:WCFairyEntitySetPos2ParentHero(parentHeroEntity)
  self.__prefab = nil
end

function WCFairyEntity:GetWCFairyEntityGo()
  return self.__parentGo
end

function WCFairyEntity:GetWCHeroParentGo()
  return self.__parentGo
end

function WCFairyEntity:WCFairyEntitySetPos2ParentHero(parentHeroEntity)
  local pos, rotate = self:GetFairyEntityTargetPosAndRotate(parentHeroEntity)
  self:WCFairyEntitySetPos(pos)
  self:WCFairyntitySetRotate(rotate)
end

function WCFairyEntity:GetFairyEntityTargetPosAndRotate(parentHeroEntity)
  local heroPos = parentHeroEntity:WCHeroEntityGetShowPos()
  local forwardDir = parentHeroEntity:WCHeroEntityGetForward()
  local rightDir = parentHeroEntity:WCHeroEntityGetRight()
  local pos = Vector3.Temp(heroPos.x, heroPos.y + 0.25, heroPos.z) - Vector3.Normalize(forwardDir) * 0.35 + Vector3.Normalize(rightDir) * 0.35
  local rotate = Quaternion.LookRotation(forwardDir, Vector3.up)
  return pos, rotate
end

function WCFairyEntity:WCFairyEntitySetPos(pos)
  self.__parentGo.transform.position = pos
end

function WCFairyEntity:WCFairyntitySetRotate(rotate)
  self.__parentGo.transform.localRotation = rotate
end

function WCFairyEntity:WCFairyEntityGetPos()
  local pos = self.__parentGo.transform.position
  return Vector3.New(pos.x, pos.y, pos.z)
end

function WCFairyEntity:WCFairyntityGetRotate()
  local r = self.__parentGo.transform.localRotation
  return Quaternion.New(r.x, r.y, r.z, r.w)
end

function WCFairyEntity:WCFairyAnimatorSetWalk(bool, v)
  if self.animator == nil then
    return
  end
  if bool then
    if v == nil then
      v = 1
    end
    self.animator:SetFloat("DormWalkSpeed", v)
  else
    self.animator:SetFloat("DormWalkSpeed", 0)
  end
end

function WCFairyEntity:Show()
  self.__parentGo:SetActive(true)
end

function WCFairyEntity:Hide()
  self.__parentGo:SetActive(false)
end

function WCFairyEntity:Delete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.__parentGo ~= nil then
    DestroyUnityObject(self.__parentGo)
    self.__parentGo = nil
  end
end

return WCFairyEntity
