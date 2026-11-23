AreaMapRoad = {};

AreaMapRoad.__index = AreaMapRoad;

local normal = UnityEngine.Color(1, 1, 1, 1);
local locked = UnityEngine.Color(102/255, 102/255, 102/255, 1);

AreaMapRoad.New = function(road)
    local self = {};
    setmetatable(self, AreaMapRoad);
    self.buildingId = road.buildingId;
    self.image = road:GetComponent("Image");
    return self;
end

function AreaMapRoad:SetData(currentArea)
    local areaMap = DataMgr.Player.areaMaps[currentArea];
    if (areaMap == nil) then return end
    local mapGroup = areaMap.mapGroups[self.buildingId];
    if PlayerAreaMgr.GetAreaModel()==AreaModel.Novel then
        local key=currentArea.."_"..self.buildingId;
        local unlock=PlayerAreaMgr_NovelModel.areaMapBuildingStatus[key];
        mapGroup={id=self.buildingId,lock=not unlock};
    end
    if (mapGroup == nil) then return end
    self.image.color = mapGroup.lock and locked or normal;
end

function AreaMapRoad:Clear()
    self.image = nil;
end