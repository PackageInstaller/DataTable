local WCHeroEntity = class("WCHeroEntity")
local util = require("XLua.Common.xlua_util")
local cs_ResLoader = CS.ResLoader
local cs_GameObject = CS.UnityEngine.GameObject
local WCFairyEntity = require("Game.WarChess.Entity.WCFairyEntity")
local Ghost_Color = Color.New(0.18, 0.91, 0.93)
local Not_Ghost_Color = Color.New(0.5471, 0.5471, 0.5471)

function WCHeroEntity:ctor(heroData, teamIndex)
  self.__parentGo = nil
  self.animator = nil
  self.heroData = heroData
  self.heroId = heroData.dataId
  self.teamIndex = teamIndex
  self.resloader = nil
  self.heroGo = nil
  self.__isGhost = false
  self.fairyData = nil
  self.fiaryEntity = nil
  self.couldSelectFxGo = nil
end

function WCHeroEntity:CheckFirstHeroModel(heroData, notWait, heroEntityRoot)
  local loadedFairyId = self.fiaryEntity ~= nil and self.fiaryEntity.dynFairyData:GetFairyID() or 0
  local fairyId = self.fairyData ~= nil and self.fairyData:GetFairyID() or 0
  local isHaveSameFairy = loadedFairyId == fairyId
  if (heroData == nil or self.heroData:GetResModelName() == heroData:GetResModelName()) and isHaveSameFairy then
    return
  end
  self.heroData = heroData
  self.heroId = heroData.dataId
  local showPos = self:WCHeroEntityGetShowPos()
  return self:WCLoadHeroModel(Vector2.New(showPos.x, showPos.z), notWait, heroEntityRoot)
end

function WCHeroEntity:WCLoadHeroModel(creatLogicPos, notWait, heroEntityRoot, teamData)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.heroGo ~= nil then
    DestroyUnityObject(self.heroGo)
    self.heroGo = nil
  end
  self.resloader = cs_ResLoader.Create()
  if creatLogicPos ~= nil then
    self.__creatLogicPos = creatLogicPos
  end
  if not IsNull(self.__parentGo) then
    DestroyUnityObject(self.__parentGo)
    self.__parentGo = nil
  end
  local go = cs_GameObject("Team:" .. tostring(self.teamIndex))
  self.__parentGo = go
  if self.__creatLogicPos ~= nil then
    local pos = Vector3.New(self.__creatLogicPos.x, 0, self.__creatLogicPos.y)
    self:WCHeroEntitySetPos(pos)
  end
  local fairyAwait, loadCallback
  if self.fairyData ~= nil then
    if self.fiaryEntity ~= nil then
      self.fiaryEntity:Delete()
      self.fiaryEntity = nil
    end
    self.fiaryEntity = WCFairyEntity.New(self.teamIndex)
    fairyAwait, loadCallback = self.fiaryEntity:CheckFiaryData(self.fairyData, notWait, self)
  elseif self.fiaryEntity ~= nil then
    self.fiaryEntity:Delete()
    self.fiaryEntity = nil
  end
  local modelPath = PathConsts:GetCharacterModelPathEx(self.heroData:GetResModelName())
  local animatorCtrlPath = PathConsts:GetWarChessCharCtrlPath(self.heroData:GetResModelName())
  local heroAwait = self.resloader:LoadABAssetAsyncAwait(modelPath, function(heroPrefab)
    self.__heroPrefab = heroPrefab
    if notWait and self.__animatorCtrl ~= nil then
      self:RealLoadModel(heroEntityRoot, teamData)
      return
    end
  end)
  local animatorAwait = self.resloader:LoadABAssetAsyncAwait(animatorCtrlPath, function(animatorCtrl)
    self.__animatorCtrl = animatorCtrl
    if notWait and self.__heroPrefab ~= nil then
      self:RealLoadModel(heroEntityRoot, teamData)
      return
    end
  end)
  return {
    heroAwait,
    animatorAwait,
    fairyAwait
  }, {
    BindCallback(self, self.RealLoadModel, heroEntityRoot, teamData),
    loadCallback
  }
end

function WCHeroEntity:RealLoadModel(heroEntityRoot, teamData)
  if IsNull(self.__parentGo) then
    self.__parentGo = cs_GameObject("Team:" .. tostring(self.teamIndex))
  end
  self.__parentGo.transform:SetParent(heroEntityRoot)
  if self.__creatLogicPos ~= nil then
    local pos = Vector3.New(self.__creatLogicPos.x, 0, self.__creatLogicPos.y)
    self:WCHeroEntitySetPos(pos)
  end
  if self.__heroPrefab ~= nil then
    self.heroGo = self.__heroPrefab:Instantiate(self.__parentGo.transform)
    self.animator = self.heroGo:FindComponent(eUnityComponentID.Animator)
    self.animator.runtimeAnimatorController = self.__animatorCtrl
  end
  self.__heroPrefab = nil
  self.__animatorCtrl = nil
  if teamData ~= nil then
    local isGhost = teamData:GetWCTeamIsGhost()
    self:SetWCHeroIsGhost(isGhost, true)
  else
    self:SetWCHeroIsGhost(self.__isGhost, true)
  end
end

function WCHeroEntity:GetWCHeroEntityGo()
  return self.__parentGo
end

function WCHeroEntity:GetWCHeroEntityTeamIndex()
  return self.teamIndex
end

function WCHeroEntity:WCHeroEntityGetShowPos()
  return self.__parentGo.transform.position
end

function WCHeroEntity:WCHeroEntitySetPos(pos, notQuickMoveFairy)
  self.__parentGo.transform.position = pos
  if not notQuickMoveFairy and self.fiaryEntity ~= nil then
    self.fiaryEntity:WCFairyEntitySetPos2ParentHero(self)
  end
end

function WCHeroEntity:WCHeroEntityGetForward()
  local forward = self.__parentGo.transform.forward
  return Vector3.New(forward.x, forward.y, forward.z)
end

function WCHeroEntity:WCHeroEntityGetRight()
  local right = self.__parentGo.transform.right
  return Vector3.New(right.x, right.y, right.z)
end

function WCHeroEntity:WCHeroEntityGetRotate()
  return self.__parentGo.transform.localRotation
end

function WCHeroEntity:WCHeroEntitySetRotate(rotate)
  self.__parentGo.transform.localRotation = rotate
end

function WCHeroEntity:WCAnimatorCrossFade(aniName, transTime)
  transTime = transTime or 0.25
  if self.animator == nil then
    return
  end
  self.animator:CrossFadeInFixedTime(aniName, transTime)
end

function WCHeroEntity:WCAnimatorSetTrigger(trigger)
  if self.animator == nil then
    return
  end
  self.animator:SetTrigger(trigger)
end

function WCHeroEntity:WCAnimatorSetBool(boolName, value)
  if self.animator == nil then
    return
  end
  self.animator:SetBool(boolName, value)
end

function WCHeroEntity:WCAnimatorSetFloat(floatName, value)
  if self.animator == nil then
    return
  end
  self.animator:SetFloat(floatName, value)
end

function WCHeroEntity:WCAnimatorSetPickFloat(bool)
  if self.animator == nil then
    return
  end
  self.animator:SetBool("WarChess_Float", bool)
end

function WCHeroEntity:WCAnimatorSetWalk(bool)
  if self.animator == nil then
    return
  end
  self.animator:SetBool("WarChess_Walk", bool)
end

function WCHeroEntity:SetWCHeroIsGhost(bool, isForce)
  if bool == self.__isGhost and not isForce then
    return
  end
  self.__isGhost = bool
  if bool then
    local mats = self.__parentGo:GetComponentsInChildren(typeof(CS.UnityEngine.SkinnedMeshRenderer))
    for i = 0, mats.Length - 1 do
      local matArray = mats[i].materials
      for j = 0, matArray.Length - 1 do
        local mat = matArray[j]
        mat:SetColor("_Color", Ghost_Color)
        mat:SetFloat("_MainTexInvisible", 0.6)
      end
    end
  else
    local mats = self.__parentGo:GetComponentsInChildren(typeof(CS.UnityEngine.SkinnedMeshRenderer))
    for i = 0, mats.Length - 1 do
      local matArray = mats[i].materials
      for j = 0, matArray.Length - 1 do
        local mat = matArray[j]
        mat:SetColor("_Color", Not_Ghost_Color)
        mat:SetFloat("_MainTexInvisible", 0)
      end
    end
  end
end

function WCHeroEntity:SetWCHeroTeamFairyData(fairyData)
  self.fairyData = fairyData
  if self.fiaryEntity ~= nil then
    self.fiaryEntity:CheckFiaryData(self.fairyData, true, self)
  end
end

function WCHeroEntity:ForceUpdateFairyData(fairyData)
  self.fairyData = fairyData
  if self.fairyData == nil then
    if self.fiaryEntity ~= nil then
      self.fiaryEntity:Delete()
      self.fiaryEntity = nil
    end
    return
  end
  if self.fiaryEntity == nil then
    self.fiaryEntity = WCFairyEntity.New(self.teamIndex)
  end
  self.fiaryEntity:CheckFiaryData(self.fairyData, true, self)
end

function WCHeroEntity:GetWCHeroFairyEntity()
  return self.fiaryEntity
end

function WCHeroEntity:GetWCHeroParentGo()
  return self.__parentGo
end

function WCHeroEntity:Show()
  self.__parentGo:SetActive(true)
  if self.fiaryEntity ~= nil then
    self.fiaryEntity:Show()
  end
end

function WCHeroEntity:Hide()
  self.__parentGo:SetActive(false)
  if self.fiaryEntity ~= nil then
    self.fiaryEntity:Hide()
  end
end

function WCHeroEntity:Delete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.fiaryEntity ~= nil then
    self.fiaryEntity:Delete()
    self.fiaryEntity = nil
  end
  if self.__parentGo ~= nil then
    DestroyUnityObject(self.__parentGo)
    self.__parentGo = nil
  end
end

return WCHeroEntity
