local OasisBuildingItem = class("OasisBuildingItem")
local cs_GameObject = CS.UnityEngine.GameObject
local cs_ResLoader = CS.ResLoader
local CoordinateConvert = require("Game.Oasis.OasisCoordinateConvert")

function OasisBuildingItem:Initialize(unityPosition, size, height, areaTransform)
  self.rootGameObject = cs_GameObject()
  self.rootTransform = self.rootGameObject.transform
  local upgradingEffectRootGo = cs_GameObject("UpgradingEffectRoot")
  self.upgradingEffectTrans = upgradingEffectRootGo.transform
  self.upgradingEffectTrans:SetParent(self.rootTransform)
  self.rootTransform:SetLayer(LayerMask.Raycast)
  self.resloader = cs_ResLoader.Create()
  self.size = size
  self.height = height
  self.unitySize = Vector3.New()
  self.unitySize.y = self.height
  if #self.size ~= 2 then
    error("building size cfg error")
  end
  local sizeType = self.size[1]
  if sizeType == 1 then
    local areaX = self.size[2] * 2 * CoordinateConvert.GetHexWidth()
    local areaZ = ((self.size[2] * 2 - 1) * 3 / 4 + 1) * CoordinateConvert.GetHexHeight()
    self.unitySize.x = areaX
    self.unitySize.z = areaZ
  elseif sizeType == 2 then
    self.unitySize.x = 2 * CoordinateConvert.GetHexWidth()
    self.unitySize.z = 1.75 * CoordinateConvert.GetHexHeight()
  elseif sizeType == 3 then
    self.unitySize.x = 2 * CoordinateConvert.GetHexWidth()
    self.unitySize.z = 2.5 * CoordinateConvert.GetHexHeight()
  end
  self:SetItemArea(areaTransform)
  self.rootTransform.localPosition = unityPosition
end

function OasisBuildingItem:LoadBuildingGo(prefabName, callBack)
  if prefabName == nil then
    if self.buildingData.levelConfig[self.buildingData.level] == nil then
      error("请检查OasisBuilding配表，配置的" .. self.buildingData.id .. "-等级[" .. self.buildingData.level .. "]配置为空")
    end
    local modelId = self.buildingData.levelConfig[self.buildingData.level].modol
    prefabName = ConfigData.oasis_building_model[modelId].model
  end
  if self.__isInLoadingObj then
    self.resloader:Put2Pool()
    self.resloader = cs_ResLoader.Create()
  end
  self.__isInLoadingObj = true
  local path = PathConsts:GetOasisBuildingPrefabPath(prefabName)
  self.resloader:LoadABAssetAsync(path, function(prefab)
    if prefab == nil then
      self.__isInLoadingObj = false
      return
    end
    local go = prefab:Instantiate()
    self:SetGameObject(go)
    self.__isInLoadingObj = false
    self:UpdateCanvasItemPos()
    if callBack ~= nil then
      callBack(self)
    end
  end)
end

function OasisBuildingItem:SetGameObject(gameObject)
  if IsNull(self.rootGameObject) then
    return
  end
  local oldParent
  local isReplace = false
  if not IsNull(self.gameObject) then
    isReplace = true
    oldParent = self.transform.parent
    DestroyUnityObject(self.gameObject)
  end
  gameObject.transform:SetParent(self.rootTransform)
  self.gameObject = gameObject
  self.transform = gameObject.transform
  self.transform.localPosition = Vector3.zero
  self.transform:SetLayer(self.rootGameObject.layer)
  local scale = self.upgradingEffectTrans.localScale
  scale.x = self.unitySize.x
  scale.z = self.unitySize.z
  self.upgradingEffectTrans.localScale = scale
  if isReplace then
    self:SetItemArea(oldParent)
    self:SetPosition(self.buildingData.position)
  end
  if self.buildingData ~= nil then
    local name = tostring(self.buildingData.id)
    self.rootGameObject.name = name
    self.gameObject.name = name
  end
end

function OasisBuildingItem:SetCanvas(canvas)
  self.canvas = canvas
  local UIbulidData = {
    name = self.buildingData.name,
    nameEn = self.buildingData.nameEn,
    level = self.buildingData.level,
    canLvUp = self.buildingData:CanUpgrade()
  }
  self.canvas:CreateNameItem(self.id, UIbulidData)
  self:UpdateCanvasItemPos()
end

function OasisBuildingItem:SetBuildingData(data)
  self.id = data.id
  self.buildingData = data
  local name = tostring(data.id)
  self.rootGameObject.name = name
  if not IsNull(self.gameObject) then
    self.gameObject.name = name
  end
end

function OasisBuildingItem:Update(timestamp, isSecond)
  if isSecond then
    self.__timeSecond = timestamp
    self:__TimerUpdate(timestamp)
  end
end

function OasisBuildingItem:__TimerUpdate(timestamp)
  local needUpdate = false
  if self.id ~= nil then
    local builtData = self.buildingData
    if builtData ~= nil and builtData.resDatas ~= nil then
      for resId, res in pairs(builtData.resDatas) do
        if not res.resMax then
          needUpdate = true
        end
      end
    end
  end
  if needUpdate then
    self:UpdateBuildingResUI()
  end
end

function OasisBuildingItem:UpdateProcessUI(progress, remainTimeText, waitConfirmOver)
  local position = self:GetUIProcessPos()
  local canvasProgressText
  if waitConfirmOver then
    canvasProgressText = ConfigData:GetTipContent(14023)
  else
    canvasProgressText = remainTimeText
  end
  if self.canvas ~= nil then
    self.canvas:UpdateProcess(self.id, position, progress, canvasProgressText)
  end
end

function OasisBuildingItem:UpdateBuildLevel(builtData)
  self.canvas:UpdateNameItemLevel(self.id, builtData.level)
end

function OasisBuildingItem:SetRoundPosition(unityPosition, setPosition, getAreaList)
  if setPosition == nil then
    setPosition = true
  end
  local oasisPosition = CoordinateConvert.UnityCenterToOasis(unityPosition, self.size)
  unityPosition = CoordinateConvert.ToUnityCenterPos(oasisPosition, self.size)
  if setPosition then
    self.rootTransform.localPosition = unityPosition
  end
  local areaList
  if getAreaList then
    areaList = CoordinateConvert.GetHexArea(oasisPosition, self.size)
  end
  return oasisPosition, unityPosition, areaList
end

function OasisBuildingItem:SetItemArea(areaTransform)
  if self.rootTransform.parent ~= areaTransform then
    self.rootTransform:SetParent(areaTransform)
  end
end

function OasisBuildingItem:SetPosition(oasisPos, needTween)
  local unityPosition = CoordinateConvert.ToUnityCenterPos(oasisPos, self.size)
  if needTween then
    self:_ClearMoveTween()
    self._moveTween = self.rootTransform:DOLocalMove(unityPosition, 0.1):OnUpdate(function()
      self:UpdateCanvasItemPos()
    end)
  else
    self.rootTransform.localPosition = unityPosition
    self:UpdateCanvasItemPos()
  end
end

function OasisBuildingItem:GetBuildItemHeight()
  local modelId = self.buildingData.levelConfig[self.buildingData.level or 1].modol
  local posCfg = ConfigData.oasis_building_model[modelId].res_pos
  return posCfg[2]
end

function OasisBuildingItem:__GetModelCfgPos(param)
  local modelId = self.buildingData.levelConfig[self.buildingData.level or 1].modol
  local posCfg = ConfigData.oasis_building_model[modelId][param]
  local position = self.rootTransform.position
  position.x = position.x + posCfg[1]
  position.y = position.y + posCfg[2]
  position.z = position.z + posCfg[3]
  return position
end

function OasisBuildingItem:GetUIResPos()
  return self:__GetModelCfgPos("res_pos")
end

function OasisBuildingItem:GetUINamePos()
  return self:__GetModelCfgPos("name_pos")
end

function OasisBuildingItem:GetBuildSelectUIPos()
  return self:__GetModelCfgPos("select_pos")
end

function OasisBuildingItem:GetUIProcessPos()
  local uiPosition = self.rootTransform.position + Vector3.New(-self.unitySize.y * 0.5, 7, 0)
  return uiPosition
end

function OasisBuildingItem:UpdateBuildingResUI()
  local builtData = self.buildingData
  local resDatas = builtData:GetResDatas()
  if resDatas == nil then
    return
  end
  if self._resTabSort == nil then
    self._resTabSort = {}
  else
    for i = 1, #self._resTabSort do
      table.remove(self._resTabSort)
    end
  end
  for k, v in pairs(resDatas) do
    table.insert(self._resTabSort, v)
  end
  table.sort(self._resTabSort, function(a, b)
    return a.id < b.id
  end)
  local window = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if window ~= nil then
    if self.buildingData:IsBuildResPeriodOk() then
      window.oasisResNode:TryCreateOasisResItem(self.id, self._resTabSort[1].id)
      window.oasisResNode:UpdateOasisResData(self.id, self._resTabSort)
    else
      window.oasisResNode:RecycleOasisResItem(self.id)
    end
  end
  self.resItemId = self._resTabSort[1].id
  MsgCenter:Broadcast(eMsgEventId.BuildingProduceUpdate, self.id, self._resTabSort)
end

function OasisBuildingItem:UpdateCanvasItemPos()
  if self.buildingData == nil or self.canvas == nil then
    return
  end
  local namePos = self:GetUINamePos()
  if namePos ~= nil then
    self.canvas:UpdateNamePos(self.id, namePos)
  end
  local processPos = self:GetUIProcessPos()
  self.canvas:UpdateProcessPos(self.id, processPos)
end

function OasisBuildingItem:Show(show)
  if show then
    self.rootTransform:SetLayer(LayerMask.Raycast)
  else
    self.rootTransform:SetLayer(LayerMask.Hide)
  end
end

function OasisBuildingItem:UpdateState()
  local builtData = self.buildingData
  if builtData.state == proto_object_BuildingState.BuildingStateNormal then
    if self.canvas ~= nil then
      self.canvas:SetBuildName3dItemCanLevelUp(self.id, self.buildingData:CanUpgrade())
    end
  elseif builtData.state == proto_object_BuildingState.BuildingStateCreate or builtData.state == proto_object_BuildingState.BuildingStateUpgrade then
  end
end

function OasisBuildingItem:GetUnitySize()
  return self.unitySize
end

function OasisBuildingItem:EnterFocusLayer(enter)
  if enter then
    self.rootTransform:SetLayer(LayerMask.Focus)
  else
    self.rootTransform:SetLayer(LayerMask.Raycast)
  end
end

function OasisBuildingItem:GetUnityPostion()
  return self.rootTransform.position
end

function OasisBuildingItem:BuildGoIsInLoading()
  return self.__isInLoadingObj
end

function OasisBuildingItem:_ClearMoveTween()
  if self._moveTween ~= nil then
    self._moveTween:Kill()
    self._moveTween = nil
  end
end

function OasisBuildingItem:GetResItemId()
  return self.resItemId
end

function OasisBuildingItem:GetBuildingId()
  return self.buildingData.id
end

function OasisBuildingItem:OnDelete()
  self:_ClearMoveTween()
  if self.canvas ~= nil then
    self.canvas:RecycleUI(self.id)
    self.canvas = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
end

function OasisBuildingItem:DeleteEntity()
  if self.rootGameObject ~= nil then
    cs_GameObject.Destroy(self.rootGameObject)
    self.rootGameObject = nil
  end
end

return OasisBuildingItem
