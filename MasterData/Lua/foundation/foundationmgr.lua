require("Foundation/FoundationOutside")
require("Foundation/FoundationRoom")
require("Foundation/FoundationTeaRoom")
require("Foundation/FoundationExpoHall")
require("Foundation/FoundationWorking")
require("Foundation/FoundationOffice")
require("Foundation/FoundationEditor")
require("Foundation/FoundationConst")
require("Foundation/Building/FoundationGrid")
require("Foundation/Building/FoundationGrids")
require("Foundation/Building/FoundationBuilding")
require("Foundation/Building/FoundationBuildingInteract")
require("Foundation/Character/FoundationCharacter")
require("Foundation/Character/FoundationCharacterTalk")
require("Foundation/Character/FoundationCharacterMsg")
require("Foundation/Character/FoundationCharacterInteract")
require("Foundation/Character/FoundationCharacterFriendly")
require("Foundation/Character/FoundationCharacterFriendFull")
require("Foundation/Character/FoundationCharacterFlyText")
require("Foundation/Character/FoundationCharacterComfort")
require("Foundation/Character/FoundationCharacterAI")
require("Foundation/Character/FoundationActivityCharacterAI")
require("Foundation/Character/FoundationBuildingCharacterAI")
require("Foundation/Character/FoundationSurpriseCharacterAI")
require("Foundation/Character/FoundationUAVCharacterAI")
require("Foundation/Character/FoundationBirdAI")
require("Foundation/Character/FoundationCharacterMgr")
require("Foundation/Building/FoundationBuildingInfo")
require("Foundation/Building/FoundationBuildingMgr")
require("Foundation/Building/FoundationRoomInfo")
require("Foundation/Building/FoundationSceneMgr")
require("Foundation/Building/FoundationOccupy")
require("Foundation/Building/FoundationVendingMachineEffect")
require("Foundation/Building/FoundationVendingMachineUpgrade")
require("ViewModel/MiniGames/MiniGame2048GamePlayFrameWorkMgr")
require("Foundation/FoundationMsgMgr")

FoundationMgr = {};

FoundationMgr.Outside = "FoundationOutside";
FoundationMgr.Room = "FoundationRoom";
FoundationMgr.TeaRoom = "FoundationTeaRoom";
FoundationMgr.ExpoHall = "FoundationExpoHall";
FoundationMgr.Working = "FoundationWorking";
FoundationMgr.Office = "FoundationOffice";
FoundationMgr.Editor = "FoundationEditor";
FoundationMgr.ActivityRoom = "FoundationActivityRoom";
FoundationMgr.DelayClick = false;

local this = {
buildingId = 0,
characterId = 0,
buildingConfigMap = nil,
isEnterRoom = false,
camera = nil,
roomName = nil,
viewModel = nil,
visitor = false,
composeId = nil,
makeId = nil,
matDic = nil,
baseRoomId = "105",
roomId = "105",
composeFormula = nil,
selectTheme = "",
outsideClick = false,
isActivityRoom = false,
};

local gridSize = 1;


FoundationMgr.SetGridSize = function(size)
    gridSize = size;
end


FoundationMgr.GetGridSize = function()
    return gridSize;
end


FoundationMgr.GetGridPos = function(x, y)
    return Vector3(-x * gridSize, 0, y * gridSize);
end


FoundationMgr.GetPosGrid = function(x, y)
    return {x = math.floor(-x / gridSize), y = math.floor(y / gridSize)};
end


FoundationMgr.GetWallGridPos = function(x, y)
    return Vector3(-x * gridSize, y * gridSize, 0);
end


FoundationMgr.GetWall2GridPos = function(x, y)
    return Vector3(0, y * gridSize, x * gridSize);
end


FoundationMgr.GetGridOffset = function()
    return -0.5 * gridSize, -0.5 * gridSize;
end


FoundationMgr.GetMaterial = function(type)
    local material = this.matDic[type];
    if (material == nil) then
        material = LuaMgr.GetMaterial(string.format("Assets/_BundleResources/Foundation/Materials/FoundationGrid%d.mat", type));
        this.matDic[type] = material;
    end
    return material;
end


this.ReadBuildingConfig = function()
    local str;
    if (LuaMgr.GetPlatform() == "EDITOR") then
        str = FileTool.ReadFile(LuaMgr.GetAssetsPath() .. "/_BundleResources/Foundation/BuildingConfig.bytes");
    else
        str = LuaMgr.GetTextAsset("Assets/_BundleResources/Foundation/BuildingConfig.bytes");
    end
    if (str ~= "") then
        this.buildingConfigMap = json.decode(str);
    else
        this.buildingConfigMap = {};
    end
end


FoundationMgr.GetBuildingConfig = function(bid)
    return this.buildingConfigMap[bid];
end


FoundationMgr.GetBuildingId = function()
    this.buildingId = this.buildingId + 1;
    return this.buildingId;
end

FoundationMgr.GetCurrBuildingId = function()
    return this.buildingId;
end


FoundationMgr.GetCharacterId = function()
    this.characterId = this.characterId + 1;
    return this.characterId;
end


FoundationMgr.IsEnterRoom = function()
    if (this.isEnterRoom) then
        this.isEnterRoom = false;
        return true;
    end
    return false;
end


this.OnCloseOperate = function()
    LuaMgr.HidePanel(UIName.FoundationOperateViewModel);
end


FoundationMgr.CloseOperate = function(delay)
    if (delay) then
        LuaMgr.NextFrame(this.CloseOperate);
    else
        this.OnCloseOperate();
    end
end


this.OnFoundation = function(roomName, isGoto)
    this.ReadBuildingConfig();
    this.matDic = {};
    FoundationOutside.Init();
    FoundationRoom.Init();
    FoundationTeaRoom.Init();
    FoundationExpoHall.Init();
    FoundationWorking.Init();
    FoundationOffice.Init();
    FoundationEditor.Init();
    LuaMgr.ShowLuaPanel(UIName.FoundationUIViewModel);
    LuaMgr.ShowLuaPanel(UIName.FoundationTransitionViewModel);
    roomName = roomName or this.roomName;
    if (roomName ~= nil) then
        FoundationMgr.Enter(roomName, isGoto);
        if (this.viewModel ~= nil) then
            LuaMgr.ShowLuaPanel(this.viewModel);
        end
    else
        FoundationMgr.Enter(FoundationMgr.Outside);
    end
    this.roomName = nil;
    this.viewModel = nil;
    ConfigFoundationMgr.PlayBgmMusic();
    LuaMgr.AddUIEventListener(UIEventConst.TopBarElementClickAdd, this.OnTopBarElementClickAdd);
    LuaMgr.TriggerGuideId();

    MiniGame2048GamePlayFrameWorkMgr.InitData();
    this.SetAntiAliasing();

end


this.SetAntiAliasing = function()
    local foundationAntiAliasing = ConfigMgr.Config.constants.FoundationAntiAliasing;
    local quality = SettingHelper.GetCurImageQuality();
    if (quality.key == ESetting.Image_QualityHigh.key) then
        LuaMgr.AntiAliasing(foundationAntiAliasing[3]);
    elseif (quality.key == ESetting.Image_QualityMiddle.key) then
        LuaMgr.AntiAliasing(foundationAntiAliasing[2]);
    else
        LuaMgr.AntiAliasing(foundationAntiAliasing[1]);
    end
end


this.OnLoadingScene = function()
    LuaMgr.AntiAliasing(0);
    LuaMgr.RemoveUIEventListener(UIEventConst.TopBarElementClickAdd, this.OnTopBarElementClickAdd);
    this.camera = nil;
    this.matDic = nil;
    LuaMgr.HidePanel(UIName.FoundationUIViewModel);
    LuaMgr.HidePanel(UIName.FoundationTransitionViewModel);
    FoundationBuildingMgr.SetUIContainer(nil);
    FoundationCharacterMgr.SetUIContainer(nil);
    FoundationRoomCtrl.SetUIContainer(nil);
    FoundationOutside.Clear();
    FoundationRoom.Clear();
    FoundationTeaRoom.Clear();
    FoundationExpoHall.Clear();
    FoundationWorking.Clear();
    FoundationOffice.Clear();
    FoundationOutside.Destroy();
end


this.OnTopBarElementClickAdd = function()
    this.OnCloseOperate();
end


function FoundationMgr.Open(roomName, viewModel)
    this.roomName = roomName;
    this.viewModel = viewModel;
    this.visitor = false;
    if (roomName == FoundationMgr.Room) then
        FoundationMgr.SetActivityRoom(false);
    elseif (roomName == FoundationMgr.ActivityRoom) then
        FoundationMgr.SetActivityRoom(true);
    end
    LuaMgr.SceneSwitchMark();
    LuaMgr.LoadScene("Foundation", nil, this.OnFoundation);
end


function FoundationMgr.Visitor(roomName, isWithOutScene)
    this.roomName = roomName;
    this.visitor = true;
    if (roomName == FoundationMgr.Room) then
        FoundationMgr.SetActivityRoom(false);
    elseif (roomName == FoundationMgr.ActivityRoom) then
        FoundationMgr.SetActivityRoom(true);
    end
    if (isWithOutScene) then
        LuaMgr.ShowLuaPanel(UIName.FoundationTransitionViewModel, this.OnChangeFriendRoom);
        return;
    end
    LuaMgr.SceneSwitchMark();
    LuaMgr.LoadScene("Foundation", nil, this.OnFoundation);
end


this.OnChangeFriendRoom = function()
    FoundationRoom.Clear();
    FoundationRoom.Show();
end


function FoundationMgr.Clear()
    this.OnLoadingScene();
end


function FoundationMgr.Back()
    local roomName = LuaMgr.GetCurRoom();
    this.OnFoundation(roomName, true);
end


function FoundationMgr.Enter(type, isGoto)
    FoundationOutside.Clear();
    FoundationRoom.Clear();
    FoundationTeaRoom.Clear();
    FoundationExpoHall.Clear();
    FoundationWorking.Clear();
    FoundationOffice.Clear();
    FoundationOutside.Hide();
    FoundationRoom.Hide();
    FoundationExpoHall.Hide();
    FoundationTeaRoom.Hide();
    FoundationWorking.Hide();
    FoundationOffice.Hide();
    FoundationEditor.Hide();
    this.isEnterRoom = true;
    LuaMgr.SetCurRoom(type);
    if (type == FoundationMgr.Outside) then
        FoundationOutside.Show();
    elseif (type == FoundationMgr.Room) then
        FoundationMgr.SetActivityRoom(false);
        FoundationMgr.SetRoomId(FoundationMgr.GetBaseRoomId());
        FoundationRoom.Show();
    elseif (type == FoundationMgr.ActivityRoom) then
        FoundationMgr.SetActivityRoom(true);
        FoundationMgr.SetRoomId("201");
        FoundationRoom.Show();
    elseif (type == FoundationMgr.TeaRoom) then
        FoundationTeaRoom.Show();
    elseif (type == FoundationMgr.ExpoHall) then
        FoundationExpoHall.Show(isGoto);
    elseif (type == FoundationMgr.Working) then
        FoundationWorking.Show(isGoto);
    elseif (type == FoundationMgr.Office) then
        FoundationOffice.Show(isGoto);
    elseif (type == FoundationMgr.Editor) then
        FoundationEditor.Show();
    end
end


FoundationMgr.Goto = function(roomId)
    if (roomId == "101") then
        FoundationMgr.Enter(FoundationMgr.ExpoHall);
    elseif (roomId == "102") then
        FoundationMgr.Enter(FoundationMgr.Working);
    elseif (roomId == "103") then
        FoundationMgr.Enter(FoundationMgr.Office);
    elseif (roomId == "104") then
        FoundationMgr.Enter(FoundationMgr.TeaRoom);
    end
end


FoundationMgr.ClickSound = function()
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/Click_light.mp3");
end


FoundationMgr.StopVoice = function()
    AudioMgr.Singleton:Clear();
end


FoundationMgr.SetCamera = function(camera)
    this.camera = camera;
end


FoundationMgr.GetCamera = function()
    return this.camera;
end


FoundationMgr.GetBuilding = function(id)
    local building = FoundationBuildingMgr.GetBuildingByCid(id);
    if (building ~= nil) then
        return building.gameObject;
    end
    return nil;
end


FoundationMgr.SetComposeId = function(id)
    this.composeId = id;
end


FoundationMgr.GetComposeId = function()
    return this.composeId;
end


FoundationMgr.SetMakeId = function(id)
    this.makeId = id;
end


FoundationMgr.GetMakeId = function()
    return this.makeId;
end


FoundationMgr.SetRoomId = function(id)
    this.roomId = id;
end


FoundationMgr.GetRoomId = function()
    return this.roomId;
end


FoundationMgr.GetBaseRoomId = function()
    return this.baseRoomId;
end


FoundationMgr.SetActivityRoom = function(isActivityRoom)
    this.isActivityRoom = isActivityRoom;
end


FoundationMgr.IsActivityRoom = function()
    return this.isActivityRoom;
end


FoundationMgr.GetThemeId = function(roomId)
    if (FoundationMgr.IsVisitor()) then
        local visitRoomData = PlayerFoundationMgr.GetVisitRoom(roomId);
        if (visitRoomData ~= nil and visitRoomData.FoundRoom ~= nil) then
            return visitRoomData.FoundRoom.Style;
        end
    end
    local room = DataMgr.Player.foundRooms[roomId];
    if (room ~= nil) then
        return room.Style;
    else
        local roomConfig = ConfigMgr.Config.roomMap[roomId];
        if (roomConfig ~= nil) then
            return roomConfig.RoomStyleId;
        end
    end
    return "";
end


FoundationMgr.SetComposeFormula = function(formula)
    this.composeFormula = formula;
end


FoundationMgr.ComposeNotEnough = function(itemId)
    if (this.composeFormula ~= nil) then
        local formula = ConfigMgr.Config.FormulaMap[this.composeFormula];
        if (formula ~= nil and #formula.Produce > 0) then
            if (not IsNull(formula.Cost)) then
                local costItem;
                local len = #formula.Cost;
                for i = 1, len do
                    costItem = formula.Cost[i];
                    if (costItem.id == itemId) then
                        local item = DataMgr.Player.items[costItem.id];
                        local itemCount = item ~= nil and item.count0 or 0;
                        if (itemCount < costItem.count) then
                            HeroParameter.SaveTarItem(itemId, costItem.count - itemCount);
                        else
                            HeroParameter.EmptyTarItem();
                        end
                        break;
                    end
                end
            end
        end
    end
end


FoundationMgr.SetSelectTheme = function(theme)
    this.selectTheme = theme;
end


FoundationMgr.GetSelectTheme = function()
    return this.selectTheme;
end


FoundationMgr.GetThemePutCount = function(roomPutId)
    local put;
    local count;
    local config;
    local putCount = 0;
    local itemMap = {};
    local roomId = FoundationMgr.GetRoomId();
    local putList = ConfigFoundationMgr.GetStylePutList(roomPutId);
    local len = #putList;
    for i = 1, len do
        put = putList[i];
        count = itemMap[put.Furniture];
        if (count == nil) then
            config = ConfigFoundationMgr.GetInteractionById(put.Furniture);
            if (config ~= nil) then
                count = PlayerFoundationMgr.GetFurnitureItemCount(config.Furniture);
            end
            if (count == nil) then
                count = 0;
            end
            count = count + PlayerFoundationMgr.GetPutFurnitureCount(roomId, put.Furniture);
            itemMap[put.Furniture] = count;
        end
        if (count >= 1) then
            itemMap[put.Furniture] = count - 1;
            putCount = putCount + 1;
        end
    end
    return putCount, len;
end


FoundationMgr.GetThemeFurniturePutCount = function(roomPutId, furnitureId)
    local put;
    local count;
    local config;
    local putCount = 0;
    local itemMap = {};
    local roomId = FoundationMgr.GetRoomId();
    local putList = ConfigFoundationMgr.GetStylePutList(roomPutId);
    local len = #putList;
    for i = 1, len do
        put = putList[i];
        if (put.Furniture == furnitureId) then
            count = itemMap[put.Furniture];
            if (count == nil) then
                config = ConfigFoundationMgr.GetInteractionById(put.Furniture);
                if (config ~= nil) then
                    count = PlayerFoundationMgr.GetFurnitureItemCount(config.Furniture);
                end
                if (count == nil) then
                    count = 0;
                end
                count = count + PlayerFoundationMgr.GetPutFurnitureCount(roomId, put.Furniture);
                itemMap[put.Furniture] = count;
            end
            putCount = putCount + 1;
            return count, putCount;
        end
    end
    return 0, 0;
end


FoundationMgr.ScreenRatioOffset = function()
    local designRatio = 16 / 9;
    local screenRatio = UnityEngine.Screen.width / UnityEngine.Screen.height;
    if (screenRatio < designRatio) then
        return designRatio - screenRatio;
    end
    return 0;
end


FoundationMgr.SetOutsideClick = function(isClick)
    this.outsideClick = isClick;
end


FoundationMgr.IsOutsideClick = function()
    return this.outsideClick;
end


FoundationMgr.IsVisitor = function()
    return this.visitor;
end