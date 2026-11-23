FoundationBuildingMgr = {};

local this = {
    buildingTF = nil,
    camera = nil,
    uiContainer = nil,
    roomId = "",
    buildingList = {},
    nextTime = 0,
    cameraTween = nil,
};


FoundationBuildingMgr.Init = function(roomId, container, buildingTF, camera)
    this.roomId = roomId;
    this.buildingTF = buildingTF;
    this.camera = camera;
    FoundationSceneMgr.Clear();
    local roomConfig = ConfigMgr.Config.roomMap[roomId];
    if (roomConfig ~= nil) then
        local styleConfig = ConfigMgr.Config.RoomStyleMap[roomConfig.RoomStyleId];
        if (styleConfig ~= nil) then
            FoundationMgr.SetGridSize(styleConfig.Cell);
            if (#styleConfig.Camera > 0) then
                FoundationSceneMgr.Init(camera, styleConfig.Camera[1], styleConfig.Camera[2]);
            end
            local pos = camera.transform.localPosition;
            pos.x = styleConfig.CameraPos;
            camera.transform.localPosition = pos;
            local roomPosConfig = ConfigMgr.Config.roomPosMap[styleConfig.Ground];
            if (roomPosConfig ~= nil) then
                container.localPosition = Vector3(roomPosConfig.Start[1], roomPosConfig.Start[2], roomPosConfig.Start[3]);
            end
        end
    end
end


FoundationBuildingMgr.Clear = function()
    this.RemoveCameraTween();
    FoundationBuildingMgr.RemoveBuildings();
    this.buildingTF = nil;
    this.camera = nil;
end


FoundationBuildingMgr.SetUIContainer = function(container)
    this.uiContainer = container;
end


FoundationBuildingMgr.SetCharacters = function(cid)
    local building = FoundationBuildingMgr.GetBuildingByCid(cid);
    if (building ~= nil) then
        FoundationCharacterMgr.RemoveBuildingCharacters(building.id);
        local interactions = DataMgr.Player.interactions;
        if (interactions ~= nil) then
            local data = interactions[cid];
            if (data ~= nil) then
                local characters = data.Characters;
                if (IsNull(characters)) then return end
                
                local characterList = {};
                local len = #characters;
                for i = 1, len do
                    characterList[i] = {characterId = characters[i], skinId = HeroManager.GetCharacterSkin(characters[i])};
                    FoundationCharacterMgr.RemoveNotBuildingCharacter(building.id, characters[i]);
                end
                FoundationCharacterMgr.SetCharacters(building, characterList);
            end
        end
    end
end


FoundationBuildingMgr.SetBuildings = function()
    FoundationBuildingMgr.RemoveBuildings();
    local interactionConfig;
    local interactions = DataMgr.Player.interactions;
    for k, _ in pairs(interactions) do
        interactionConfig = ConfigFoundationMgr.GetInteractionById(k);
        if (interactionConfig ~= nil and interactionConfig.Room == this.roomId) then
            if (interactionConfig.Type ~= 12 and interactionConfig.Type ~= 13) then
                FoundationBuildingMgr.AddBuilding(interactionConfig);
                FoundationBuildingMgr.SetCharacters(k);
            end
        end
    end
    FoundationCharacterMgr.AddSurpriseCharacter(this.roomId);

end


FoundationBuildingMgr.RemoveBuildings = function()
    local len = #this.buildingList;
    for i = 1, len do
        this.buildingList[i]:Clear();
    end
    this.buildingList = {};
end


FoundationBuildingMgr.RemoveBuilding = function(id)
    local building;
    local len = #this.buildingList;
    for i = 1, len do
        building = this.buildingList[i];
        if (building.id == id) then
            table.remove(this.buildingList, i);
            building:Clear();
            building = nil;
            break;
        end
    end
end


FoundationBuildingMgr.AddBuilding = function(interaction)
    local config = FoundationMgr.GetBuildingConfig(interaction.Model);
    if (config ~= nil) then
        local building = FoundationBuilding.New(interaction.Model, this.buildingTF);
        local id = FoundationMgr.GetBuildingId();
        building:SetData(tostring(id), interaction);
        if (interaction.Type == 4) then
            building:SetEffect(FoundationVendingMachineEffect.New(building));
            building:SetUpgrade(FoundationVendingMachineUpgrade.New(building));
        end
        building:SetPosition(interaction.Pos[1], interaction.Pos[2]);
        table.insert(this.buildingList, building);
    end
end


FoundationBuildingMgr.GetNewBuildings = function()
    local building;
    local buildingMap = {};
    local len = #this.buildingList;
    for i = 1, len do
        building = this.buildingList[i];
        if (building.config ~= nil) then
            buildingMap[building.config.Id] = true;
        end
    end
    local interactionConfig;
    local newBuildings = {};
    local interactions = DataMgr.Player.interactions;
    for k, _ in pairs(interactions) do
        interactionConfig = ConfigFoundationMgr.GetInteractionById(k);
        if (interactionConfig ~= nil and interactionConfig.Room == this.roomId) then
            if (not buildingMap[interactionConfig.Id]) then
                table.insert(newBuildings, interactionConfig);
            end
        end
    end
    return newBuildings;
end


FoundationBuildingMgr.SetBuildingsInfo = function()
    local building;
    local order = 0;
    local len = #this.buildingList;
    for i = 1, len do
        building = this.buildingList[i];
        if (building.info == nil and building.config ~= nil and building.config.Type ~= 11) then
            building:SetInfo(FoundationBuildingInfo.New(this.uiContainer, this.camera, order));
        end
    end
end


FoundationBuildingMgr.RefreshBuildingInfo = function(id)
    local building = FoundationBuildingMgr.GetBuildingByCid(id);
    if (building ~= nil) then
        if (building.info ~= nil) then
            building.info:SetData(building);
        end
    end
end


FoundationBuildingMgr.GetBuildingById = function(id)
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


FoundationBuildingMgr.GetBuildingByCid = function(cid)
    local building;
    local len = #this.buildingList;
    for i = 1, len do
        building = this.buildingList[i];
        if (building.config ~= nil and building.config.Id == cid) then
            return building;
        end
    end
    return nil;
end


FoundationBuildingMgr.GetBuildingByType = function(type)
    local building;
    local len = #this.buildingList;
    for i = 1, len do
        building = this.buildingList[i];
        if (building.config ~= nil and building.config.Type == type) then
            return building;
        end
    end
    return nil;
end


FoundationBuildingMgr.ClickBuilding = function(building, camera)
    if building.config ~= nil and not IsNullOrEmpty(building.config.Id) then
        if building.config.Id == "30501" then

            if (FeatureManager.IsLock("33001")) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("33001"))
                return
            end
        end
    end
    if (building.config ~= nil) then
        this.RemoveCameraTween();
        LuaMgr.HidePanel(UIName.FoundationOperateViewModel);
        if (#building.config.Camera > 0) then
            local pos = camera.transform.localPosition;
            if (pos.x < building.config.Camera[1] or pos.x > building.config.Camera[2]) then
                local distance = math.abs(pos.x - building.config.CameraJump);
                if (distance > 0.001) then
                    local time = distance > 0.5 and 0.5 or distance;
                    this.cameraTween = camera.transform:DOMoveX(building.config.CameraJump, time):OnComplete(function()
                        this.cameraTween = nil;
                        LuaMgr.ShowLuaPanel(UIName.FoundationOperateViewModel, building, camera);
                    end);
                    return;
                end
            end
        end
    end
    LuaMgr.ShowLuaPanel(UIName.FoundationOperateViewModel, building, camera);
end


FoundationBuildingMgr.IsFocusBuilding = function()
    return this.cameraTween ~= nil;
end


this.RemoveCameraTween = function()
    if (this.cameraTween ~= nil) then
        this.cameraTween:Kill(false);
        this.cameraTween = nil;
    end
end


FoundationBuildingMgr.Update = function()
    FoundationSceneMgr.Update();
    this.UpdateBuildingsInfo();
    local time = os.time();
    if (time >= this.nextTime) then
        this.nextTime = time + 1;
        this.CheckStatus();
    end
end


FoundationBuildingMgr.UpLevel = function(building)
    if (building == nil) then return end
    
    local interactions = DataMgr.Player.interactions;
    if (interactions == nil) then return end

    local data = interactions[building.config.Id];
    this.CheckUpLevel(building.info, data);
end


this.UpdateBuildingsInfo = function()
    local building;
    local len = #this.buildingList;
    for i = 1, len do
        building = this.buildingList[i];
        if (building.info ~= nil) then
            building.info:SetPosition(building);
        end
    end
end


this.CheckStatus = function()
    local interactions = DataMgr.Player.interactions;
    if (interactions == nil) then return end

    local building;
    local len = #this.buildingList;
    for i = 1, len do
        building = this.buildingList[i];
        if (building.config ~= nil and building.info ~= nil) then
            local config = building.config;
            local info = building.info;
            local data = interactions[config.Id];
            if (data ~= nil) then
if (data.LevelupEndTime > 0) then
                    this.CheckUpLevel(info, data);
elseif (config.Type == 1) then
                    this.CheckDraw(info, config, data);
elseif (config.Type == 2) then
                    this.CheckMakeItem(info, config, data);
elseif (config.Type == 3) then
                    this.CheckTea(info, config);
elseif (config.Type == 4) then
                    this.CheckVendingMachine(info, config, data);
elseif (config.Type == 5) then

elseif (config.Type == 6) then
                    this.CheckMain(info, config);
elseif (config.Type == 7) then
                    this.CheckWeaponMake(info, config);
elseif (config.Type == 8) then

elseif (config.Type == 9) then
                    this.CheckCompose(info, config);
                end
            end
        end
    end
end


this.CheckUpLevel = function(info, data)
    local nowTime = LuaMgr.Timestamp();
    if (data.LevelupEndTime > nowTime) then
        info:SetLevelArrow(true);
        info:SetTime(data.LevelupEndTime - nowTime);
        info.completeSound = false;
        info:SetComplete(false);
    else
        info:SetLevelArrow(false);
        info:SetTime(0);
        if (not info.completeSound) then
            info.completeSound = true;
            AudioMgr.Singleton:PlayVoice(Path.audio_PATH.."newUI/Foundation_levelup_2.mp3");
        end
        info:SetComplete(true);
    end
    info:SetDraw(false);
    info:SetMake(false);
    info:SetStopWork(false);
    info:SetIdle(false);
    info:SetVendingMachine(false);
    info:SetCompose(false);
    info:SetWeaponMake(false);
    info:SetUpgrade(false);
end


this.CheckDraw = function(info, config, data)
    local isYieldsDraw = PlayerFoundationMgr.IsYieldsDraw(config, data);
    if (isYieldsDraw) then
        local progress = PlayerFoundationMgr.GetYieldsDrawProgress(config, data);
        info:SetDraw(true, progress);
        info:SetIdle(false);
        info:SetUpgrade(false);
    else
        info:SetDraw(false);
        if (PlayerFoundationMgr.IsUpgrade(config)) then
            info:SetUpgrade(true);
        else
            local isFullWorkCharacter = PlayerFoundationMgr.IsFullWorkCharacter(config.Id);
            info:SetIdle(not isFullWorkCharacter);
        end
    end
    info:SetCompose(false);
    info:SetWeaponMake(false);
end


this.CheckMakeItem = function(info, config, data)
    local hasCharacter = PlayerFoundationMgr.IsWorkCharacter(config.Id);
    local isMake = data.Formula ~= "" and data.Count > 0;
    local isMakeDraw = PlayerFoundationMgr.IsMakeDraw(config, data);
    if (isMakeDraw) then
        info:SetDraw(true, -1);
        info:SetMake(false);
        info:SetStopWork(false);
        info:SetTime(0);
        info:SetIdle(false);
        info:SetUpgrade(false);
    else
        if (PlayerFoundationMgr.IsUpgrade(config)) then
            info:SetUpgrade(true);
        else
            info:SetUpgrade(false);
            if (isMake) then
                info:SetDraw(false);
                info:SetIdle(false);
                if (hasCharacter) then
                    info:SetMake(true);
                    info:SetStopWork(false);
                    local time = PlayerFoundationMgr.GetMakeItemTime(config, data);
                    info:SetTime(time);
                else
                    info:SetMake(false);
                    info:SetStopWork(true);
                    info:SetTime(0);
                end
            else
                info:SetDraw(false);
                info:SetMake(false);
                info:SetStopWork(false);
                info:SetTime(0);
                info:SetIdle(true);
            end
        end
    end
    info:SetCompose(false);
    info:SetWeaponMake(false);
end


this.CheckTea = function(info, config)
    if (PlayerFoundationMgr.IsUpgrade(config)) then
        info:SetUpgrade(true);
    else
        info:SetUpgrade(false);
    end
    info:SetComplete(false);
    info:SetLevelArrow(false);
    info:SetDraw(false);
    info:SetMake(false);
    info:SetStopWork(false);
    info:SetIdle(false);
    info:SetVendingMachine(false);
    info:SetCompose(false);
    info:SetWeaponMake(false);
end


this.CheckVendingMachine = function(info, config, data)
    info:SetVendingMachineTime(0);
    local vendingMachineConfig = ConfigMgr.Config.VendingMachineList[config.Level];
    if (vendingMachineConfig ~= nil) then
        local count = vendingMachineConfig.Frequency - data.TodayCount;
        if (count > 0) then
            local nowTime = LuaMgr.Timestamp();
            info:SetVendingMachineTime(data.VendingEndTime - nowTime);
            info:SetVendingMachine(true);
            info:SetUpgrade(false);
        else
            info:SetVendingMachine(false);
            info:SetUpgrade(PlayerFoundationMgr.IsUpgrade(config));
        end
    else
        info:SetVendingMachine(false);
        info:SetUpgrade(false);
    end
    info:SetComplete(false);
    info:SetLevelArrow(false);
    info:SetDraw(false);
    info:SetMake(false);
    info:SetStopWork(false);
    info:SetIdle(false);
    info:SetCompose(false);
    info:SetWeaponMake(false);
end


this.CheckCompose = function(info, config)
    info:SetComplete(false);
    info:SetLevelArrow(false);
    info:SetDraw(false);
    info:SetMake(false);
    info:SetStopWork(false);
    info:SetIdle(false);
    info:SetVendingMachine(false);
    if (PlayerFoundationMgr.IsUpgrade(config)) then
        info:SetCompose(false);
        info:SetUpgrade(true);
    else
        info:SetCompose(true);
        info:SetUpgrade(false);
    end
    info:SetCompose(true);
    info:SetWeaponMake(false);
end


this.CheckMain = function(info, config)
    info:SetUpgrade(PlayerFoundationMgr.IsUpgrade(config));
end


this.CheckWeaponMake = function(info, config)
    info:SetComplete(false);
    info:SetLevelArrow(false);
    info:SetDraw(false);
    info:SetMake(false);
    info:SetStopWork(false);
    info:SetIdle(false);
    info:SetVendingMachine(false);
    info:SetCompose(false);
    local time = LuaMgr.Timestamp();
    local ordersType = PlayerFoundationMgr.GetWeaponMakeComplete(time);
    if (ordersType ~= nil) then
        local ordersTypeConfig = ConfigMgr.Config.weaponMade.OrdersType[ordersType];
        if (ordersTypeConfig ~= nil) then
            info:SetWeaponMake(true, 3, ordersTypeConfig.Rank);
        else
            info:SetWeaponMake(false);
        end
        info:SetUpgrade(false);
    else
        if (PlayerFoundationMgr.IsUpgrade(config)) then
            info:SetUpgrade(true);
        else
            info:SetUpgrade(false);
            local isIdle = PlayerFoundationMgr.IsWeaponMakeIdle(config);
            if (isIdle) then
                if (PlayerFoundationMgr.CheckWeaponMakeItem()) then
                    info:SetWeaponMake(true, 1);
                    return;
                end
            end
            ordersType = PlayerFoundationMgr.GetWeaponMaking(time);
            if (ordersType ~= nil) then
                local ordersTypeConfig = ConfigMgr.Config.weaponMade.OrdersType[ordersType];
                if (ordersTypeConfig ~= nil) then
                    info:SetWeaponMake(true, 2, ordersTypeConfig.Rank);
                else
                    info:SetWeaponMake(false);
                end
            else
                info:SetIdle(true);
                info:SetWeaponMake(false);
            end
        end
    end
end


FoundationBuildingMgr.Open = function(interactionId)
    local config = ConfigFoundationMgr.GetInteractionById(interactionId);
    if (config ~= nil) then
if (config.Type == 1) then
            LuaMgr.ShowLuaPanel(UIName.FoundationBuildingHeroViewModel, interactionId);
elseif (config.Type == 2) then
            FoundationMgr.SetMakeId(nil);
            LuaMgr.ShowLuaPanel(UIName.FoundationMakeViewModel, interactionId);
elseif (config.Type == 3) then

elseif (config.Type == 4) then
            LuaMgr.ShowLuaPanel(UIName.FoundationVendingMachineViewModel);
elseif (config.Type == 5) then

elseif (config.Type == 6) then

elseif (config.Type == 7) then
            LuaMgr.ShowLuaPanel(UIName.WeaponMakeViewModel);
elseif (config.Type == 8) then

elseif (config.Type == 9) then
            FoundationMgr.SetComposeId(nil);
            LuaMgr.ShowLuaPanel(UIName.FoundationComposeViewModel, interactionId);
elseif (config.Type == 14) then
            LuaMgr.ShowLuaPanel(UIName.TeamWeaponViewModel);
        end
    end
end