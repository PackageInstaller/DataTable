FoundationRoom = {};

require("Foundation/FoundationRoomCtrl")
require("Foundation/FoundationRoomSeat")

local this = {
    gameObject = nil,
    transform = nil,
    camera = nil,
    cameraTF = nil,
    animator = nil,
    activityAnimator = nil,
    containerAnimator = nil,
    container = nil,
    gridsTF = nil,
    floorTF = nil,
    wallTF = nil,
    groundTF = nil,
    characterTF = nil,
    grids = nil,
isEdit = false,
isDown = false,
roomId = "",
themeId = "",
roomConfig = nil,
styleConfig = nil,
floorConfig = nil,
groundConfig = nil,
wallConfig = nil,
wall2Config = nil,
buildView = nil,
buildOperate = nil,
    buildViewPos = Vector3(0, 0, 0),
buildViewContainer = nil,
buildingList = {},
building = nil,
floorOccupy = nil,
groundOccupy = nil,
wallOccupy = nil,
setPos = nil,
operateState = nil,
onClick = nil,
offsetPos = nil,
furnitureType = 2,
nowOccupy = nil,
isSelectBuilding = false,
roomScenePath = "",
roomSceneGO = nil,
};

FoundationRoom.Init = function()
    this.gameObject = GameObject.Find(FoundationMgr.Room);
    this.transform = this.gameObject.transform;
    this.container = this.transform:Find("Container");
    this.floorTF = this.transform:Find("Container/Floor");
    this.wallTF = this.transform:Find("Container/Wall");
    this.groundTF = this.transform:Find("Container/Ground");
    this.gridsTF = this.transform:Find("Container/Grids");
    this.characterTF = this.transform:Find("Container/Ground/Character");
end

this.InitCamera = function()
    if (FoundationMgr.IsActivityRoom()) then
        SetActive(this.transform:Find("Camera").gameObject, false);
        SetActive(this.transform:Find("ActivityCamera").gameObject, true);
        this.camera = this.transform:Find("ActivityCamera/Main Camera"):GetComponent("Camera");
        this.cameraTF = this.transform:Find("ActivityCamera");
        this.activityAnimator = this.cameraTF:GetComponent("ModelAnimator");
        this.containerAnimator = this.container:GetComponent("ModelAnimator");
    else
        SetActive(this.transform:Find("Camera").gameObject, true);
        SetActive(this.transform:Find("ActivityCamera").gameObject, false);
        this.camera = this.transform:Find("Camera/Main Camera"):GetComponent("Camera");
        this.cameraTF = this.transform:Find("Camera");
        this.animator = this.cameraTF:GetComponent("AnimatorTrigger");
    end
end

FoundationRoom.Show = function()
    FoundationSceneMgr.Clear();
    this.InitCamera();
    this.roomId = FoundationMgr.GetRoomId();
    FoundationRoomCtrl.Init(this.camera);
    FoundationRoomSeat.Init();
    this.SetRoomConfig();
    this.SetRoomScene();
    this.InitGrids();
    this.transform.localPosition = Vector3.zero;
    this.cameraTF.localPosition = Vector3.zero;
    this.cameraTF.localRotation = UnityEngine.Quaternion.identity;
    this.gameObject:SetActive(true);
    if (FoundationMgr.IsActivityRoom()) then
        if (PlayerFoundationMgr.IsShowAnimator()) then
            PlayerFoundationMgr.SetShowAnimator(false);
            this.activityAnimator:Play("ani_FoundationRoom_specialcamera", false, nil);
            this.containerAnimator:Play("ani_FoundationRoom_container", false, nil);
        end
        LuaMgr.ShowLuaPanel(UIName.ActivityRoomViewModel, this.roomId);
    else
        LuaMgr.ShowLuaPanel(UIName.RoomViewModel, this.roomId);
    end
    this.SetBuildings();
    PlayerFoundationMgr.InitFurnitureId();
    this.PlayVideos();
    LuaMgr.AddUpdate(this.OnUpdate);
    LuaMgr.NextFrame(FoundationRoom.OnShowPlayAudio, 10)
end

FoundationRoom.Hide = function()
    this.gameObject:SetActive(false);
end

FoundationRoom.Clear = function()
    LuaMgr.RemoveUpdate(this.OnUpdate);
    if (this.animator ~= nil) then
        this.animator:Clear();
    end
    this.isEdit = false;
    this.building = nil;
    this.buildView = nil;
    this.buildOperate = nil;
    this.buildViewContainer = nil;
    this.setPos = nil;
    this.operateState = operateState;
    this.RemoveBuildings();
    FoundationRoomCtrl.Clear();
    FoundationRoomSeat.Clear();
    FoundationMsgMgr.ClearDataList();
    this.ClearOccupy();
    if (this.grids ~= nil) then
        this.grids:Hide();
    end
    LuaMgr.RemoveTimer(TimerConst.FundationPlayVoice)
end

FoundationRoom.Destroy = function()
    this.ClearGrids();
    this.ClearRoomScene();
    this.gameObject = nil;
    this.transform = nil;
    this.camera = nil;
    this.animator = nil;
    this.activityAnimator = nil;
    this.floorTF = nil;
    this.wallTF = nil;
    this.groundTF = nil;
    this.gridsTF = nil;
    this.characterTF = nil;
    this.nowOccupy = nil;
    if (this.floorOccupy ~= nil) then
        this.floorOccupy:Clear();
        this.floorOccupy = nil;
    end
    if (this.groundOccupy ~= nil) then
        this.groundOccupy:Clear();
        this.groundOccupy = nil;
    end
    if (this.wallOccupy ~= nil) then
        this.wallOccupy:Clear();
        this.wallOccupy = nil;
    end
end

FoundationRoom.GetThis = function()
    return this;
end


FoundationRoom.SetBuildView = function(buildView, buildOperate, container, setPos, operateState, onClick)
    this.buildView = buildView;
    this.buildOperate = buildOperate;
    this.buildViewContainer = container;
    this.setPos = setPos;
    this.operateState = operateState;
    this.onClick = onClick;
    this.SetBuildViewPos(10000, 0);
end


FoundationRoom.ClearBuildView = function()
    this.buildView = nil;
    this.buildOperate = nil;
    this.buildViewContainer = nil;
end


this.SetRoomConfig = function()
    this.furnitureType = 2;
    this.roomConfig = ConfigMgr.Config.roomMap[this.roomId];
    this.themeId = FoundationMgr.GetThemeId(this.roomId);
    this.styleConfig = ConfigMgr.Config.RoomStyleMap[this.themeId];
    FoundationMgr.SetGridSize(this.styleConfig.Cell);
    if (this.floorOccupy == nil) then
        this.floorOccupy = FoundationOccupy.New();
    end
    if (this.groundOccupy == nil) then
        this.groundOccupy = FoundationOccupy.New();
    end
    if (this.wallOccupy == nil) then
        this.wallOccupy = FoundationOccupy.New();
    end
    this.floorConfig = ConfigMgr.Config.roomPosMap[this.styleConfig.Floor];
    if (this.floorConfig ~= nil) then
        this.floorTF.localPosition = Vector3(this.floorConfig.Start[1], this.floorConfig.Start[2], this.floorConfig.Start[3]);
    end
    this.groundConfig = ConfigMgr.Config.roomPosMap[this.styleConfig.Ground];
    if (this.groundConfig ~= nil) then
        this.groundTF.localPosition = Vector3(this.groundConfig.Start[1], this.groundConfig.Start[2], this.groundConfig.Start[3]);
        this.InitGroundOccupy();
    end
    this.wallConfig = ConfigMgr.Config.roomPosMap[this.styleConfig.Wall];
    if (this.wallConfig ~= nil) then
        this.wallTF.localPosition = Vector3(this.wallConfig.Start[1], this.wallConfig.Start[2], this.wallConfig.Start[3]);
    end
    this.wall2Config = ConfigMgr.Config.roomPosMap[this.styleConfig.Wall2];
    if (not FoundationMgr.IsActivityRoom() and #this.styleConfig.Camera > 0) then
        FoundationSceneMgr.Init(this.camera, this.styleConfig.Camera[1], this.styleConfig.Camera[2]);
        local pos = this.camera.transform.localPosition;
        pos.x = this.styleConfig.CameraPos;
        this.camera.transform.localPosition = pos;
    end
end


this.SetRoomScene = function()
    local path = string.format("Assets/_BundleResources/Foundation/Room/Foundation%s.prefab", this.styleConfig.Scene);
    if (path == this.roomScenePath and this.roomSceneGO ~= nil) then return end
    
    this.ClearRoomScene();
    this.roomScenePath = path;
    this.roomSceneGO = LuaMgr.GetPrefab(this.roomScenePath);
    this.roomSceneGO.transform:SetParent(this.transform, false);
    LuaMgr.AddPrefabRefCount(this.roomScenePath);
end


this.ClearRoomScene = function()
    if (this.roomSceneGO ~= nil) then
        LuaMgr.DestroyImmediateGO(this.roomSceneGO);
        this.roomSceneGO = nil;
    end
    if (this.roomScenePath ~= "") then
        LuaMgr.RemovePrefabRefCount(this.roomScenePath);
        this.roomScenePath = "";
    end
end


this.InitGroundOccupy = function()
    local p;
    local areaX = this.groundConfig.Area[2];
    local areaY = this.groundConfig.Area[1];
    this.groundOccupy:InitMoveGrids(areaX, areaY);
    local len = #this.groundConfig.Disable;
    for i = 1, len do
        p = this.groundConfig.Disable[i];
        key = this.GetGridKey(p[1], p[2]);
        this.groundOccupy:BanMoveGrid(key, p[1], p[2]);
    end
end


this.GetPosConfig = function(furnitureType)
    if (furnitureType == 1) then
        return this.floorConfig;
    end
    if (furnitureType == 2) then
        return this.groundConfig;
    end
    if (furnitureType == 3) then
        return this.wallConfig;
    end
    return nil;
end


this.GetPosOccupy = function(furnitureType)
    if (furnitureType == 1) then
        return this.floorOccupy;
    end
    if (furnitureType == 2) then
        return this.groundOccupy;
    end
    if (furnitureType == 3) then
        return this.wallOccupy;
    end
end


this.ClearOccupy = function()
    if (this.floorOccupy ~= nil) then
        this.floorOccupy:Clear();
    end
    if (this.groundOccupy ~= nil) then
        this.groundOccupy:Clear();
    end
    if (this.wallOccupy ~= nil) then
        this.wallOccupy:Clear();
    end
end

this.InitGrids = function()
    if (this.grids == nil) then
        this.grids = FoundationGrids.New(this.gridsTF);
    else
        this.grids:Reset();
    end
    local config = this.GetPosConfig(this.furnitureType);
    this.nowOccupy = this.GetPosOccupy(this.furnitureType);
    local areaX = config.Area[2];
    local areaY = config.Area[1];
    this.grids:Generate(areaX, areaY, this.furnitureType);
    local len = #config.Disable;
    for i = 1, len do
        local p = config.Disable[i];
        key = this.GetGridKey(p[1], p[2]);
        this.grids:SetDisableGrid(key);
        this.grids:SetGridType(key, 3);
    end
    if (this.furnitureType == 3 and this.wall2Config ~= nil) then
        local ext = {
            areaX = areaX,
            areaY = areaY,
            offX = this.wall2Config.Start[1],
            offZ = this.wall2Config.Start[3],
        };
        this.grids:Generate(this.wall2Config.Area[2], this.wall2Config.Area[1], this.furnitureType, ext);
        for i = 1, areaY do
            key = this.GetGridKey(areaX, i - 1);
            this.grids:SetDisableGrid(key);
            this.grids:SetGridType(key, 3);
        end
        len = #this.wall2Config.Disable;
        for i = 1, len do
            local p = this.wall2Config.Disable[i];
            key = this.GetGridKey(p[1] + areaX, p[2] + areaY);
            this.grids:SetDisableGrid(key);
            this.grids:SetGridType(key, 3);
        end
    end
    this.gridsTF.localPosition = Vector3(config.Start[1], config.Start[2], config.Start[3]);
    this.grids:Hide();
end


this.ClearGrids = function()
    if (this.grids ~= nil) then
        this.grids:Clear();
        this.grids = nil;
    end
end


this.GetGridKey = function(x, y)
    return string.format("%d_%d", x, y);
end


this.GetBuilding = function(id)
    local building;
    local len = #this.buildingList;
    for i = 1, len do
        building = this.buildingList[i];
        if (building.id == id) then
            return building;
        end
    end
    return nil;
end


this.SetBuildings = function()
    if (FoundationMgr.IsVisitor()) then
        if (FoundationMgr.IsActivityRoom()) then
            local visitRoomData = PlayerFoundationMgr.GetActivityVisitRoom(this.roomId);
            if (visitRoomData ~= nil) then
                local furnitures = visitRoomData.Furnitures;
                for k, v in pairs(furnitures) do
                    this.CreateBuilding(k, v.BuildingId, v.X, v.Y, v.Angle);
                end
            end
        else
            local visitRoomData = PlayerFoundationMgr.GetVisitRoom(this.roomId);
            if (visitRoomData ~= nil) then
                local furnitures = visitRoomData.Furniture;
                for k, v in pairs(furnitures) do
                    if (v.Room == this.roomId) then
                        this.CreateBuilding(k, v.BuildingId, v.X, v.Y, v.Angle);
                    end
                end
            end
        end
    else
        local furnitures = DataMgr.Player.furnitures;
        if (furnitures ~= nil) then
            for k, v in pairs(furnitures) do
                if (v.Room == this.roomId) then
                    this.CreateBuilding(k, v.BuildingId, v.X, v.Y, v.Angle);
                end
            end
        end
    end
end


FoundationRoom.SetBuilding = function(bid)
    local config = ConfigFoundationMgr.GetInteractionById(bid);
    if (config ~= nil) then
        FoundationSceneMgr.SetDrag(false);
        PlayerFoundationMgr.FurnitureItemCount(config.Furniture, -1);
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationRoomFurnitureChange);
        local pos = this.GetFurniturePos(config.FurnitureType);
        local furnitureId = PlayerFoundationMgr.GetFurnitureId();
        local building = this.CreateBuilding(tostring(furnitureId), bid, pos[1], pos[2], 0);
        if (building ~= nil) then
            FoundationRoom.FocusBuilding(building);
        end
    end
end


FoundationRoom.FocusBuilding = function(building)
    this.building = building;
    FoundationSceneMgr.SetDrag(false);
    this.SetFurnitureType(building.config.FurnitureType);
    this.SetOperateState(building.config.Rotate);
    this.RemoveBuildingOccupy(building, this.nowOccupy);
    this.AddBuildingOccupy(building, this.nowOccupy);
    this.GotoBuilding(building);
    if (FoundationMgr.IsActivityRoom()) then
        this.grids:Show();
        this.CalcBuildViewPos(building);
    else
        if (not FoundationRoomCtrl.CheckAniState(building.config.FurnitureType)) then
            this.grids:Show();
            this.CalcBuildViewPos(building);
        else
            this.SetBuildViewPos(10000, 0);
        end
    end
end


this.GotoBuilding = function(building)
    local posConfig = this.GetPosConfig(building.config.FurnitureType);
    local x = building.transform.localPosition.x + posConfig.Start[1];
    FoundationSceneMgr.Goto(x);
end


this.SetFurnitureType = function(type)
    if (this.furnitureType ~= type) then
        this.furnitureType = type;
        this.InitGrids();
    end
end


this.GetFurniturePos = function(furnitureType)
    if (furnitureType == 1) then
        return this.styleConfig.Initialput[1];
    elseif (furnitureType == 2) then
        return this.styleConfig.Initialput[2];
    elseif (furnitureType == 3) then
        return this.styleConfig.Initialput[3];
    end
    return nil;
end


this.CreateBuilding = function(id, bid, x, y, angle)
    local config = ConfigFoundationMgr.GetInteractionById(bid);
    if (config ~= nil) then
        local occupy;
        local container;
        if (config.FurnitureType == 1) then
            occupy = this.floorOccupy;
            container = this.floorTF;
        elseif (config.FurnitureType == 2) then
            occupy = this.groundOccupy;
            container = this.groundTF;
        elseif (config.FurnitureType == 3) then
            occupy = this.wallOccupy;
            container = this.wallTF;
        end
        local building = FoundationBuilding.New(config.Model, container);
        building:SetData(id, config);
        local ext = this.CheckWallCorner(building, x);
        building:SetPosition(x, y, ext);
        if (ext == nil) then
            building:SetAngle(angle);
        end
        if (config.Intertag == 2) then
            building:SetEffect(FoundationBuildingInteract.New(building));
        end
        table.insert(this.buildingList, building);
        this.AddBuildingOccupy(building, occupy);
        return building;
    end
    return nil;
end


this.ClearBuilding = function()
    if (this.building ~= nil) then
        local building;
        local len = #this.buildingList;
        for i = 1, len do
            building = this.buildingList[i];
            if (building.id == this.building.id) then
                table.remove(this.buildingList, i);
                break;
            end
        end
        this.building:Clear();
        this.building = nil;
    end
end


this.RemoveBuildings = function()
    local len = #this.buildingList;
    for i = 1, len do
        this.buildingList[i]:Clear();
    end
    this.buildingList = {};
end


FoundationRoom.RemoveBuilding = function()
    if (this.building ~= nil) then
        PlayerFoundationMgr.FurnitureItemCount(this.building.config.Furniture, 1);
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationRoomFurnitureChange);
        this.RemoveBuildingOccupy(this.building, this.nowOccupy);
    end
    this.ClearBuilding();
    this.grids:SetAllGridType(0);
    this.SetBuildViewPos(10000, 0);
    FoundationSceneMgr.SetDrag(true);
end


FoundationRoom.RotationBuilding = function()
    if (this.building ~= nil) then
        local angle = (this.building.angle + 90) % 360;
        this.building:SetAngle(angle);
        this.RemoveBuildingOccupy(this.building, this.nowOccupy);
        this.AddBuildingOccupy(this.building, this.nowOccupy);
    end
end


FoundationRoom.GetPutFurniture = function()
    local building;
    local putCount;
    local putMap = {};
    local len = #this.buildingList;
    for i = 1, len do
        building = this.buildingList[i];
        putCount = putMap[building.config.Furniture];
        putCount = putCount == nil and 1 or putCount + 1;
        putMap[building.config.Furniture] = putCount;
    end
    return putMap;
end


FoundationRoom.GetPutFurnitureScore = function()
    local building;
    local score = 0;
    local len = #this.buildingList;
    for i = 1, len do
        building = this.buildingList[i];
        if (building ~= nil and building.config ~= nil) then
            score = score + building.config.Comfort;
        end
    end
    return score;
end


this.PlayVideos = function()
    local len = #this.buildingList;
    for i = 1, len do
        this.buildingList[i]:PlayVideo();
    end
end


this.StopVideos = function()
    local len = #this.buildingList;
    for i = 1, len do
        this.buildingList[i]:StopVideo();
    end
end


FoundationRoom.Reset = function()
    PlayerFoundationMgr.InitFurnitureItems();
    LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationRoomFurnitureChange);
    this.building = nil;
    this.SetBuildViewPos(10000, 0);
    this.ClearOccupy();
    this.InitGroundOccupy();
    this.RemoveBuildings();
    this.SetBuildings();
    this.grids:SetAllGridType(0);
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("FoundationRoom_8"));
    FoundationSceneMgr.SetDrag(true);
end


FoundationRoom.Save = function(callback)
    this.building = nil;
    this.SetBuildViewPos(10000, 0);
    this.grids:SetAllGridType(0);
    if (not this.IsLegalBuildings()) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("FoundationRoom_9"));
        return;
    end
    local obj;
    local building;
    local furnitures = {};
    local len = #this.buildingList;
    for i = 1, len do
        building = this.buildingList[i];
        obj = {Room=this.roomId, BuildingId=building.config.Id, X=building.x, Y=building.y, Angle=building.angle};
        furnitures[building.id] = obj;
    end
    PlayerFoundationMgr.SetFurnitures(this.roomId, furnitures, callback);
end


FoundationRoom.IsChange = function()
    local furnitures = DataMgr.Player.furnitures;
    if (furnitures ~= nil) then
        local count = 0;
        for _, v in pairs(furnitures) do
            if (v.Room == this.roomId) then
                count = count + 1;
            end
        end
        local len = #this.buildingList;
        if (count ~= len) then
            return true;
        end
        local building;
        local furniture;
        for i = 1, len do
            building = this.buildingList[i];
            furniture = furnitures[building.id];
            if (furniture == nil) then 
                return true;
            end
            if (furniture.X ~= building.x or furniture.Y ~= building.y or furniture.Angle ~= building.angle) then
                return true;
            end
        end
    end
    return false;
end


FoundationRoom.ClearAll = function()
    PlayerFoundationMgr.InitFurnitureItems();
    PlayerFoundationMgr.ClearFurnitureItems(this.roomId);
    LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationRoomFurnitureChange);
    this.building = nil;
    this.SetBuildViewPos(10000, 0);
    this.grids:SetAllGridType(0);
    this.ClearOccupy();
    this.InitGroundOccupy();
    this.RemoveBuildings();
    FoundationSceneMgr.SetDrag(true);
end


FoundationRoom.PutFurniture = function()
    local furnitureId;
    local interaction;
    local roomputMap = ConfigMgr.Config.RoomputMap;
    local roomPutId = this.styleConfig.Roomputid;
    for _, v in pairs(roomputMap) do
        if (v.Room == roomPutId) then
            interaction = ConfigFoundationMgr.GetInteractionById(v.Furniture);
            if (interaction ~= nil) then
                if (PlayerFoundationMgr.GetFurnitureItemCount(interaction.Furniture) > 0) then
                    PlayerFoundationMgr.FurnitureItemCount(interaction.Furniture, -1);
                    furnitureId = PlayerFoundationMgr.GetFurnitureId();
                    this.CreateBuilding(tostring(furnitureId), v.Furniture, v.Coordinate[1], v.Coordinate[2], v.Direction);
                end
            end
        end
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationRoomFurnitureChange);
end


FoundationRoom.Print = function()
    local str = "";
    local len = #this.buildingList;
    for i = 1, len do
        local building = this.buildingList[i];
        str = str .. this.styleConfig.Roomputid .. "	" .. building.config.Id .. "	" .. "[" .. building.x .. ";" .. building.y .. "]	" .. building.angle .. "\r\n";
    end
    print(str);
end


this.IsDisableGrid = function(config, x, y)
    local p;
    local len = #config.Disable;
    for i = 1, len do
        p = config.Disable[i];
        if (p[1] == x and p[2] == y) then
            return true;
        end
    end
    return false;
end


this.IsLegalBuilding = function(building)
    local obj;
    local occupy;
    local furnitureType = building.config.FurnitureType;
    local posConfig = this.GetPosConfig(furnitureType);
    local areaX = posConfig.Area[2];
    local cornerX = posConfig.Area[2];
    local areaY = posConfig.Area[1];
    if (this.wall2Config ~= nil) then
        areaX = areaX + this.wall2Config.Area[2];
    end
    local len = #building.occupy;
    for i = 1, len do
        obj = building.occupy[i];
        if (obj.x < 0 or obj.x >= areaX or obj.y < 0 or obj.y >= areaY) then
            return false;
        end
        if (this.IsDisableGrid(posConfig, obj.x, obj.y)) then
            return false;
        end
        if (this.wall2Config ~= nil and obj.x == cornerX) then
            return false;
        end
        occupy = this.GetPosOccupy(building.config.FurnitureType);
        if (not occupy:IsLegal(obj.key)) then
            return false;
        end
    end
    return true;
end


this.IsLegalBuildings = function()
    local len = #this.buildingList;
    for i = 1, len do
        if (not this.IsLegalBuilding(this.buildingList[i])) then
            return false;
        end
    end
    return true;
end


this.CheckBuildingPos = function(building, x, y)
    local obj;
    local nx, ny;
    local furnitureType = building.config.FurnitureType;
    local posConfig = this.GetPosConfig(furnitureType);
    local areaX = posConfig.Area[2];
    local areaY = posConfig.Area[1];
    if (furnitureType == 3 and this.wall2Config ~= nil) then
        areaX = areaX + this.wall2Config.Area[2];
    end
    local len = #building.occupy;
    for i = 1, len do
        obj = building.occupy[i];
        nx = obj.x - building.x + x;
        if (nx < 0 or nx >= areaX) then
            x = building.x;
        end
        ny = obj.y - building.y + y;
        if (ny < 0 or ny >= areaY) then
            y = building.y;
        end
    end
    return x, y;
end


this.CheckWallCorner = function(building, x)
    if (building.config.FurnitureType == 3 and this.wallConfig ~= nil and this.wall2Config ~= nil) then
        local areaX = this.wallConfig.Area[2];
        if (x >= areaX) then
            local ext = {
                offX = this.wall2Config.Start[1],
                offZ = this.wall2Config.Start[3],
                angle = 90,
            };
            return ext;
        end
    end
    return nil;
end


this.IsBuildingInteract = function(character)
    local building;
    local pos;
    local fRoomInterAct;
    local fRoomInterActMap = ConfigMgr.Config.FRoomInterActMap;
    local len = #this.buildingList;
    for i = 1, len do
        building = this.buildingList[i];
        if (building.config ~= nil and building.config.Intertag >= 1) then
            fRoomInterAct = fRoomInterActMap[building.config.Id];
            if (fRoomInterAct ~= nil and fRoomInterAct.CharacterID == character.characterId) then
                pos = building.transform.localPosition - character.transform.localPosition;
                if (pos.magnitude <= fRoomInterAct.Distance) then
                    return {config=fRoomInterAct, building=building};
                end
            end
        end
    end
    return nil;
end


this.SetPos = function(x, y)
    if (this.setPos ~= nil) then
        this.setPos(x, y);
    end
end


this.AddBuildingOccupy = function(building, occupy)
    building.occupy = {};
    local config = FoundationMgr.GetBuildingConfig(building.bid);
    if (config == nil) then
        print(building.bid .. ", building config is Null.");
        return;
    end
    local grid, grid2;
    local gridX;
    local gridY;
    local key;
    local angle = building.angle % 360;
    local len = #config.grids;
    for i = 1, len do
        grid = config.grids[i];
        if (angle > 0) then
            grid2 = FoundationTool.RectRotation(grid.x, grid.y, angle);
            gridX = building.x + math.floor(grid2.x + 0.5);
            gridY = building.y + math.floor(grid2.z + 0.5);
        else
            gridX = building.x + grid.x;
            gridY = building.y + grid.y;
        end
        key = this.GetGridKey(gridX, gridY);
        table.insert(building.occupy, {x = gridX, y = gridY, key = key});
        occupy:AddOccupyId(key, building.id);
        occupy:SetMoveGrid(key, gridX, gridY);
    end
    this.SetPos(building.x, building.y);
    this.SetGridOccupy(building);
    FoundationRoomSeat.Add(building);
end


this.SetGridOccupy = function(building)
    local tBuilding;
    local occupyLen;
    local key;
    local furnitureType = building.config.FurnitureType;
    this.grids:SetAllGridType(0);
    local len = #this.buildingList;
    for i = 1, len do
        tBuilding = this.buildingList[i];
        if (tBuilding.config.FurnitureType == furnitureType) then
            if (this.IsLegalBuilding(tBuilding)) then
                if (building.id == tBuilding.id) then
                    occupyLen = #tBuilding.occupy;
                    for j = 1, occupyLen do
                        key = tBuilding.occupy[j].key;
                        if (this.grids:IsDisableGrid(key)) then
                            this.grids:SetGridType(key, 3);
                        else
                            this.grids:SetGridType(key, 1); 
                        end
                    end
                end
            else
                occupyLen = #tBuilding.occupy;
                for j = 1, occupyLen do
                    key = tBuilding.occupy[j].key;
                    if (this.grids:IsDisableGrid(key)) then
                        this.grids:SetGridType(key, 3);
                    else
                        this.grids:SetGridType(key, 2); 
                    end
                end
            end
        end
    end
end


this.RemoveBuildingOccupy = function(building, occupy)
    if (building.occupy ~= nil) then
        local obj;
        local len = #building.occupy;
        for i = 1, len do
            obj = building.occupy[i];
            occupy:RemoveOccupyId(obj.key, building.id);
            occupy:SetMoveGrid(obj.key, obj.x, obj.y);
        end
    end
    FoundationRoomSeat.Remove(building);
end


this.SetBuildViewPos = function(x, y)
    if (this.buildView ~= nil) then
        this.buildViewPos.x = x;
        this.buildViewPos.y = y;
        this.buildView.localPosition = this.buildViewPos;
    end
end


this.SetBuildOperate = function(isOperate)
    if (this.buildOperate ~= nil) then
        SetActive(this.buildOperate, isOperate);
    end
end


this.SetOperateState = function(rotate)
    if (this.operateState ~= nil) then
        this.operateState(rotate == 1);
    end
end


this.CalcBuildViewPos = function(building)
    local grid = this.grids:Get(building.x, building.y);
    if (grid ~= nil) then
        local pos = RectTransformTool.ToContainer(this.camera, grid.transform, this.buildViewContainer);
        this.SetBuildViewPos(pos.x, pos.y);
    end
end


this.OnUpdate = function()
    local isMove = FoundationSceneMgr.IsMove();
    FoundationSceneMgr.Update();
    this.CheckClick(isMove);
    FoundationRoomCtrl.CheckCharacter();
    FoundationRoomCtrl.CheckComfort(false);
    FoundationRoomCtrl.CheckFlyTexts();
    FoundationMsgMgr.Update();
end


this.CheckClick = function(isMove)
    if (isMove) then return end
    
    if (RaycastTool.GetMouseButtonUp(0)) then
        local isPointerOverGameObject = RaycastTool.IsPointerOverGameObject();
        if (this.building ~= nil) then
            this.building:SetGroup(false, nil);
            if (not isPointerOverGameObject and not this.isSelectBuilding) then
                this.building = nil;
            end
            this.SetBuildOperate(true);
            FoundationSceneMgr.ClearMove();
            FoundationSceneMgr.SetDrag(true);
            this.isDown = false;
        else
            if (not isPointerOverGameObject) then
                FoundationRoomCtrl.CheckAniState(0);
                this.grids:Hide();
                this.SetBuildViewPos(10000, 0);
                if (FoundationMgr.DelayClick) then
                    FoundationMgr.DelayClick = false;
                    return;
                end
                if (not this.isEdit) then
                    if this.onClick ~= nil then
                        this.onClick();
                    end
                end
            end
        end
        return;
    end
    if (RaycastTool.IsPointerOverGameObject()) then return end
    
    if (this.isEdit and this.building ~= nil and this.isDown) then
        local pos = RaycastTool.GetMousePosition();
        FoundationSceneMgr.OutOfScreen(pos);
        if (this.offsetPos ~= nil) then
            pos = pos - this.offsetPos;
        end
        local obj = RaycastTool.GetClickInfo(this.camera, pos, 100, "Floor");
        if (obj ~= nil) then
            FoundationSceneMgr.SetDrag(false);
            local name = obj.name;
            local list = NumTool.split(name, "_");
            local x = tonumber(list[1]);
            local y = tonumber(list[2]);
            this.building:SetGroup(true, this.SetBuildOperate);
            if (x ~= this.building.x or y ~= this.building.y) then
                this.building:SetGroupDelay(0);
                x, y = this.CheckBuildingPos(this.building, x, y);
                local ext = this.CheckWallCorner(this.building, x);
                this.building:SetPosition(x, y, ext);
                this.RemoveBuildingOccupy(this.building, this.nowOccupy);
                this.AddBuildingOccupy(this.building, this.nowOccupy);
                this.CalcBuildViewPos(this.building);
                this.SetBuildOperate(false);
            end
        end
    elseif (RaycastTool.GetMouseButtonDown(0)) then
        if (FoundationRoomCtrl.IsPlayAni()) then return end
        
        local obj = RaycastTool.GetClickInfo(this.camera, 100, "Character");
        if (obj ~= nil) then
            local character = FoundationRoomCtrl.GetCharacter(obj.name);
            if (character ~= nil) then
                character:Click();
                this.lastPlayVoiceTime = LuaMgr.Timestamp()
                return
            end
        end
        if (this.isEdit) then
            obj = RaycastTool.GetClickInfo(this.camera, 100, "SceneDynamic");
            if (obj ~= nil) then
                this.building = this.GetBuilding(obj.name);
                this.isSelectBuilding = true;
                FoundationSceneMgr.SetDrag(false);
                this.SetFurnitureType(this.building.config.FurnitureType);
                this.SetOperateState(this.building.config.Rotate);
                this.RemoveBuildingOccupy(this.building, this.nowOccupy);
                this.AddBuildingOccupy(this.building, this.nowOccupy);
                local downPos = RaycastTool.GetMousePosition();
                local grid = this.grids:Get(this.building.x, this.building.y);
                if (grid ~= nil) then
                    local gridPos = RaycastTool.GetClickPosition(this.camera, grid.transform.position);
                    this.offsetPos = downPos - gridPos;
                    if (not FoundationRoomCtrl.CheckAniState(this.building.config.FurnitureType)) then
                        this.grids:Show();
                        this.CalcBuildViewPos(this.building);
                    else
                        this.SetBuildViewPos(10000, 0);
                    end
                end
                this.isDown = true;
                return;
            else
                this.isSelectBuilding = false;
            end
            if (this.IsLegalBuildings()) then
                this.grids:SetAllGridType(0);
            end
            this.SetBuildViewPos(10000, 0);
        end
    end
end


FoundationRoom.OnChooseNewCharacter = function()
    this.OnChooseNewCharacter()
end

FoundationRoom.OnShowPlayAudio = function()
    this.SetDefaultCharacterList()
    this.CharacterPlayVoice(FoundationCharacter.VoiceType.Idle)
    this.lastPlayVoiceTime = LuaMgr.Timestamp()
    LuaMgr.RemoveTimer(TimerConst.FundationPlayVoice)
    LuaMgr.AddTimer(TimerConst.FundationPlayVoice, this.CharacterIdelPlayVoiceTimer, 1, -1, false)
end


this.SetDefaultCharacterList = function()
    if this.defaultCharacterIds == nil then
        this.defaultCharacterIds = FoundationRoomCtrl.GetAllCharacter()
    else
        local newCharacterIDs = FoundationRoomCtrl.GetAllCharacter()
        this.deltaCharacters = {}
        local tempOldCharacterIDDic = {}
        for i = 1, #this.defaultCharacterIds do
            local characterID = this.defaultCharacterIds[i]
            tempOldCharacterIDDic[characterID] = characterID
        end
        for j = 1, #newCharacterIDs do
            local newCharacterID = newCharacterIDs[j]
            if tempOldCharacterIDDic[newCharacterID] == nil then
                table.insert(this.deltaCharacters, newCharacterID)
            end
        end
    end
end

this.OnChooseNewCharacter = function()
    if this.deltaCharacters == nil or #this.deltaCharacters == 0 then
        return
    end
    this.defaultCharacterIds = FoundationRoomCtrl.GetAllCharacter()
    this.lastPlayVoiceTime = LuaMgr.Timestamp()
    this.CharacterPlayVoice(FoundationCharacter.VoiceType.Enter, this.deltaCharacters)
end

this.CharacterIdelPlayVoiceTimer = function()
    if this.lastPlayVoiceTime == nil then
        return
    end
    local curTime = LuaMgr.Timestamp()
    local intervalTime = ConfigMgr.Config.constants.CompanyVoiceTime or 5
    if curTime - this.lastPlayVoiceTime > intervalTime then
        this.CharacterPlayVoice(FoundationCharacter.VoiceType.Idle)
        this.lastPlayVoiceTime = curTime
    end
end




this.CharacterPlayVoice = function(type, characterIDs)
    if characterIDs == nil then
        characterIDs = FoundationRoomCtrl.GetAllCharacter()
    end
    if #characterIDs == 0 then
        return
    end
    local randomIndex = math.random(1, #characterIDs)
    local characterID = characterIDs[randomIndex]
    local character = FoundationRoomCtrl.GetCharacterByCid(characterID)
    if not character then
        return
    end
    character:PlayVoiceByType(type)
end

