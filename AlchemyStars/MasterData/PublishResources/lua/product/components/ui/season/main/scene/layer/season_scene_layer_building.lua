_class("SeasonSceneLayerBuilding", SeasonSceneLayerBase)
SeasonSceneLayerBuilding = SeasonSceneLayerBuilding

function SeasonSceneLayerBuilding:Constructor(sceneRoot)
  self._time = 1
  self._zoneMask = nil
  self._buildingLayer = self._sceneRootTransform:Find(SeasonSceneLayer.Building)
  self._animationRenders = {}
  local seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  self._coverManager = seasonManager:SeasonCoverManager()
  self._coverByNavManager = seasonManager:SeasonCoverByNavManager()
  self._showByNavManager = seasonManager:SeasonShowByNavManager()
  self:_CreateBuildingCover()
end

function SeasonSceneLayerBuilding:Dispose()
  SeasonSceneLayerBuilding.super.Dispose(self)
  if self._tweenTask then
    GameGlobal.TaskManager():KillTask(self._tweenTask)
    self._tweenTask = nil
  end
  table.clear(self._animationRenders)
end

function SeasonSceneLayerBuilding:UnLock(zoneMask, zoneID2Animation)
  local v4 = SeasonTool:GetInstance():GetV4ByZoneMask(zoneMask, zoneID2Animation)
  for zoneID, zoneRenderers in pairs(self._renderers) do
    for _, renderer in pairs(zoneRenderers) do
      if renderer.material then
        renderer.material:SetVector("_AreaUnlockMask", v4)
      end
    end
  end
  self._zoneMask = zoneMask
  self:TweenV4()
end

function SeasonSceneLayerBuilding:_CreateBuildingCover()
  if self._buildingLayer then
    local zoneCount = self._buildingLayer.childCount
    if 0 < zoneCount then
      for i = 0, zoneCount - 1 do
        local zone = self._buildingLayer:GetChild(i)
        if zone then
          local zoneid = i + 1
          local childCount = zone.childCount
          for j = 0, childCount - 1 do
            local building = zone:GetChild(j)
            if string.find(string.lower(building.name), self._coverManager:CoverFlag()) then
              SeasonTool:GetInstance():TryAddCover(zone, building)
            elseif string.find(string.lower(building.name), self._coverByNavManager:CoverFlag()) then
              self:_AddCoverByNav(building)
            elseif string.find(string.lower(building.name), self._showByNavManager:CoverFlag()) then
              self:_AddShowByNav(building)
            else
              local renderers = building.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
              if 0 < renderers.Length then
                for k = 0, renderers.Length - 1 do
                  self:InsertMeshRender(zoneid, renderers[k])
                end
              end
            end
            local grandChildCount = building.childCount
            if 0 < grandChildCount then
              for k = 0, grandChildCount - 1 do
                local grandChild = building:GetChild(k)
                if string.find(string.lower(grandChild.name), self._coverManager:CoverFlag()) then
                  SeasonTool:GetInstance():TryAddCover(building, grandChild)
                elseif string.find(string.lower(grandChild.name), self._coverByNavManager:CoverFlag()) then
                  self:_AddCoverByNav(grandChild)
                elseif string.find(string.lower(grandChild.name), self._showByNavManager:CoverFlag()) then
                  self:_AddShowByNav(grandChild)
                end
              end
            end
          end
        end
      end
    end
  end
end

function SeasonSceneLayerBuilding:TweenV4()
  self._tweenTask = GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT)
    local v4 = SeasonTool:GetInstance():GetV4ByZoneMask(self._zoneMask)
    for zoneID, zoneRenderers in pairs(self._renderers) do
      for _, renderer in pairs(zoneRenderers) do
        if renderer.material then
          renderer.material:DOVector(v4, "_AreaUnlockMask", self._time)
        end
      end
    end
  end)
end

function SeasonSceneLayerBuilding:_AddCoverByNav(coverTrans)
  local name = coverTrans.name
  local sArray = string.split(name, "|")
  if #sArray == 2 then
    local areaName = sArray[2]
    self._coverByNavManager:AddCover(coverTrans.parent, areaName)
  end
end

function SeasonSceneLayerBuilding:_AddShowByNav(coverTrans)
  local name = coverTrans.name
  local sArray = string.split(name, "|")
  if #sArray == 3 then
    local areaName = sArray[2]
    local showOrHide = sArray[3]
    self._showByNavManager:AddCover(coverTrans.parent, areaName, showOrHide)
  end
end
