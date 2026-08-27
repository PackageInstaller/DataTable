local base = require("Game.WarChess.Ctrl.Base.WarChessCtrlBase")
local WarChessFogOfWarCtrl = class("WarChessFogOfWarCtrl", base)
local cs_ResLoader = CS.ResLoader
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local cs_MeshRenderer = CS.UnityEngine.MeshRenderer
local cs_Material = CS.UnityEngine.Material
local cs_array = CS.System.Array
local eFogUpdateState = {Running = 1, WaitingDispose = 2}

function WarChessFogOfWarCtrl:ctor(wcCtrl)
  self.resloader = cs_ResLoader.Create()
  self.__isOpenFog = true
  self.fogMap = {}
  self.mapWidth = nil
  self.mapHeight = nil
  self.__allFogTweens = {}
  self.__allFogUpdates = {}
end

function WarChessFogOfWarCtrl:GenFog(BFId)
  local fogRoot = self.wcCtrl.bind.trans_fogRoot
  local mapFogInfo = self.wcCtrl.mapCtrl:GetMapFogInfo(BFId)
  self.__isOpenFog = mapFogInfo.openFogOfWar
  if self.__isOpenFog then
    self.fogMap = {}
    self.mapWidth = mapFogInfo.mapWidth
    self.mapHeight = mapFogInfo.mapHeight
    local fogOfWarPrefab = self.resloader:LoadABAsset(PathConsts:GetWarChessEffectPrefabPath("FXP_WarFog"))
    self.fogItemPool = CommonPool.New(function()
      local fogOfWarObj = fogOfWarPrefab:Instantiate(fogRoot)
      return fogOfWarObj
    end, function(fogOfWarObj)
      fogOfWarObj.gameObject:SetActive(false)
      fogOfWarObj.gameObject.name = "recycled"
      return true
    end)
    local meshRender = fogOfWarPrefab:GetComponentInChildren(typeof(cs_MeshRenderer))
    if not IsNull(meshRender) then
      self.shardFogMats = meshRender.sharedMaterials
    end
    self:UpdateAllFog(BFId)
  end
end

function WarChessFogOfWarCtrl:UpdateFog(sightDiff)
  if not self.__isOpenFog then
    return
  end
  local toOpenFogList = {}
  local toOpenFogCoordinationList = {}
  local hasFogClear = false
  for BFId, diffDatas in pairs(sightDiff) do
    for coordination, bool in pairs(diffDatas.update) do
      local fogOfWarObj = self.fogMap[coordination]
      local x, y = WarChessHelper.Coordination2Pos(coordination)
      if fogOfWarObj ~= nil then
        if bool then
          self:__OpenFog(fogOfWarObj, coordination, x, y, toOpenFogList, toOpenFogCoordinationList)
          hasFogClear = true
        else
          self:__ResetFog(coordination, x, y)
        end
      elseif not bool then
        self:__CreatFog(coordination, x, y)
      end
    end
  end
  if hasFogClear then
    AudioManager:PlayAudioById(1232)
  end
  self:__OpenFogList(toOpenFogList, toOpenFogCoordinationList)
end

function WarChessFogOfWarCtrl:UpdateAllFog(BFId)
  if not self.__isOpenFog then
    return
  end
  local fogDic = self.wcCtrl.mapCtrl:GetWCFogData(BFId)
  if fogDic == nil then
    return
  end
  local toOpenFogList = {}
  local toOpenFogCoordinationList = {}
  for x = 0, self.mapWidth do
    for y = 0, self.mapHeight do
      local coordination = WarChessHelper.Pos2Coordination(Vector2.New(x, y))
      local fogOfWarObj = self.fogMap[coordination]
      if fogOfWarObj ~= nil then
        if fogDic[coordination] then
          self:__OpenFog(fogOfWarObj, coordination, x, y, toOpenFogList, toOpenFogCoordinationList)
        else
          self:__ResetFog(coordination, x, y)
        end
      elseif not fogDic[coordination] then
        self:__CreatFog(coordination, x, y)
      else
        local gridObj = self.wcCtrl.mapCtrl:GetAreaObjectByXY(nil, nil, x, y, false)
        local groundObj = self.wcCtrl.mapCtrl:GetAreaObjectByXY(nil, nil, x, y, true)
        if not IsNull(gridObj) then
          gridObj:SetActive(true)
        end
        if not IsNull(groundObj) then
          groundObj:SetActive(false)
        end
      end
    end
  end
  self:__OpenFogList(toOpenFogList, toOpenFogCoordinationList)
end

function WarChessFogOfWarCtrl:__OpenFogList(fogOfWarObjList, coordinationList)
  if fogOfWarObjList == nil or #fogOfWarObjList == 0 then
    return
  end
  local templetMatList
  local firstFogObj = fogOfWarObjList[1]
  local meshRender = firstFogObj:GetComponentInChildren(typeof(cs_MeshRenderer))
  local materials = meshRender.sharedMaterials
  templetMatList = cs_array.CreateInstance(typeof(cs_Material), materials.Length)
  for index = 0, materials.Length - 1 do
    local oldMat = materials[index]
    local newMat = cs_Material(oldMat)
    templetMatList[index] = newMat
  end
  
  local function changeMatFunc(matList)
    for _, fogOfWarObj in ipairs(fogOfWarObjList) do
      local meshRender = fogOfWarObj:GetComponentInChildren(typeof(cs_MeshRenderer))
      meshRender.sharedMaterials = matList
    end
  end
  
  changeMatFunc(templetMatList)
  local timeCount = 0
  local MaxTimeCount = 0.5
  
  local function disposeFunc(updateFogMatFunc)
    self.__allFogUpdates[updateFogMatFunc] = nil
    UpdateManager:RemoveUpdate(updateFogMatFunc)
    changeMatFunc(self.shardFogMats)
    for index = 0, templetMatList.Length - 1 do
      DestroyUnityObject(templetMatList[index])
    end
  end
  
  local updateFogMatFunc
  
  function updateFogMatFunc()
    if self.__allFogUpdates[updateFogMatFunc] == eFogUpdateState.WaitingDispose then
      disposeFunc(updateFogMatFunc)
      return
    end
    local deltaTime = Time.deltaTime
    if timeCount > MaxTimeCount then
      disposeFunc(updateFogMatFunc)
      for index, fogOfWarObj in ipairs(fogOfWarObjList) do
        local coordination = coordinationList[index]
        if self.fogMap[coordination] ~= nil then
          self.fogItemPool:PoolPut(fogOfWarObj)
          self.fogMap[coordination] = nil
        end
      end
      return
    end
    timeCount = timeCount + deltaTime
    for index = 0, templetMatList.Length - 1 do
      templetMatList[index]:SetFloat("_Alpha", 1 - timeCount / MaxTimeCount)
    end
  end
  
  UpdateManager:AddUpdate(updateFogMatFunc)
  self.__allFogUpdates[updateFogMatFunc] = eFogUpdateState.Running
end

function WarChessFogOfWarCtrl:__OpenFog(fogOfWarObj, coordination, x, y, toOpenFogList, toOpenFogCoordinationList)
  self.__allFogTweens[fogOfWarObj] = fogOfWarObj.transform:DOLocalMoveY(-0.5, 0.5):OnComplete(function()
    self.__allFogTweens[fogOfWarObj] = nil
  end)
  table.insert(toOpenFogList, fogOfWarObj)
  table.insert(toOpenFogCoordinationList, coordination)
  local gridObj = self.wcCtrl.mapCtrl:GetAreaObjectByXY(nil, nil, x, y, false)
  local groundObj = self.wcCtrl.mapCtrl:GetAreaObjectByXY(nil, nil, x, y, true)
  if not IsNull(gridObj) then
    gridObj:SetActive(true)
  end
  if not IsNull(groundObj) then
    groundObj:SetActive(false)
  end
end

function WarChessFogOfWarCtrl:__ResetFog(coordination, x, y)
  local fogOfWarObj = self.fogMap[coordination]
  if fogOfWarObj == nil then
    return
  end
  fogOfWarObj.gameObject:SetActive(true)
  fogOfWarObj.transform.position = Vector3.New(x, 0, y)
  fogOfWarObj.gameObject.name = tostring(x) .. "," .. tostring(y)
  local meshRender = fogOfWarObj:GetComponentInChildren(typeof(cs_MeshRenderer))
  if not IsNull(meshRender) then
    meshRender.sharedMaterials = self.shardFogMats
  end
  local gridObj = self.wcCtrl.mapCtrl:GetAreaObjectByXY(nil, nil, x, y, false)
  local groundObj = self.wcCtrl.mapCtrl:GetAreaObjectByXY(nil, nil, x, y, true)
  if not IsNull(gridObj) then
    gridObj:SetActive(false)
  end
  if not IsNull(groundObj) then
    groundObj:SetActive(true)
  end
end

function WarChessFogOfWarCtrl:__CreatFog(coordination, x, y)
  local fogOfWarObj = self.fogItemPool:PoolGet()
  self.fogMap[coordination] = fogOfWarObj
  self:__ResetFog(coordination, x, y)
end

function WarChessFogOfWarCtrl:DisposeAllTween()
  for fogOfWarObj, tween in pairs(self.__allFogTweens) do
    tween:Kill(false)
  end
  for key, _ in pairs(self.__allFogUpdates) do
    self.__allFogUpdates[key] = eFogUpdateState.WaitingDispose
  end
  self.__allFogTweens = {}
end

function WarChessFogOfWarCtrl:OnSceneUnload()
  self:DisposeAllTween()
  self.fogMap = {}
  self.fogItemPool = nil
end

return WarChessFogOfWarCtrl
