GuoBaoScene = {};

local this = {
    gameObject = nil,
    transform = nil,
    container = nil,
    camera = nil,
    characterTF = nil,
    buildingTF = nil,
    buildingList = nil,
    buildingInfos = nil,
    characterTime = 0,
    npcList = nil,
};

GuoBaoScene.Init = function()
    this.gameObject = GameObject.Find("GuoBao");
    this.transform = this.gameObject.transform;
    this.container = this.transform:Find("Container");
    this.camera = this.transform:Find("Camera/MainCamera"):GetComponent("Camera");
    this.buildingTF = this.transform:Find("Container/Building");
    this.characterTF = this.transform:Find("Container/Character");
    local lines = this.transform:Find("Container/Lines");
    GuoBaoSceneLineMgr.Init(lines);
end

GuoBaoScene.Show = function()
    GuoBaoMgr.SetCamera(this.camera);
    GuoBaoSceneMgr.Clear();
    GuoBaoSceneMgr.Init(this.camera, -3, 1.36);
    GuoBaoSceneMgr.Goto(1.2);
    GuoBaoCharacterMgr.Init(this.camera, this.characterTF);
    LuaMgr.AddUpdate(this.OnUpdate);
    LuaMgr.AddUIEventListener(UIEventConst.GuoBaoBuildingRefresh, this.OnBuildingRefresh);
    GuoBaoCharacterMgr.AddNpc("D0014", "D0014051", "", Vector3(-1.965,0,2.411));
    GuoBaoCharacterMgr.AddNpc("A0162", "A0162001", "", Vector3(-5.33,0,2.072));
end

GuoBaoScene.Destroy = function()
    LuaMgr.RemoveUpdate(this.OnUpdate);
    LuaMgr.RemoveUIEventListener(UIEventConst.GuoBaoBuildingRefresh, this.OnBuildingRefresh);
    GuoBaoCharacterMgr.Clear();
    GuoBaoSceneLineMgr.Clear();
    GuoBaoScene.ClearBuildingInfos();
    this.ClearBuildings();
    this.gameObject = nil;
    this.transform = nil;
    this.container = nil;
    this.camera = nil;
end


GuoBaoScene.SetBuildings = function()
    if (this.buildingList ~= nil) then return end

    this.buildingList = {};
    local building;
    local simulatedShopList = ConfigGuoBaoMgr.GetSimulatedShopList();
    local len = #simulatedShopList;
    for i = 1, len do
        building = GuoBaoBuilding.New(simulatedShopList[i], this.buildingTF);
        building:SetData();
        this.buildingList[i] = building;
    end
    this.AddNpc();
end


this.UpgradeBuilding = function(group)
    local building;
    local buildingInfo;
    local len = #this.buildingInfos;
    for i = 1, len do
        buildingInfo = this.buildingInfos[i];
        if (buildingInfo:Equals(group)) then
            break;
        end
    end
    len = #this.buildingList;
    for i = 1, len do
        building = this.buildingList[i];
        if (building.config.Group == group) then
            table.remove(this.buildingList, i);
            building:Destroy();
            break;
        end
    end
    building = GuoBaoBuilding.New(group, this.buildingTF);
    building:SetData();
    building:UpgradeEffect();
    table.insert(this.buildingList, building);
    if (buildingInfo ~= nil) then
        buildingInfo:SetData(building);
    end
end


this.ClearBuildings = function()
    if (this.buildingList == nil) then return end
    
    local len = #this.buildingList;
    for i = 1, len do
        this.buildingList[i]:Destroy();
    end
    this.buildingList = nil;
end


this.CheckBuildingEffects = function()
    if (this.buildingList == nil) then return end

    local len = #this.buildingList;
    for i = 1, len do
        this.buildingList[i]:CheckEffect();
    end
end


GuoBaoScene.SetBuildingInfos = function(uiContainer)
    if (this.buildingInfos ~= nil) then return end

    this.buildingInfos = {};
    local buildingInfo;
    local len = #this.buildingList;
    for i = 1, len do
        buildingInfo = GuoBaoBuildingInfo.New(uiContainer, GuoBaoMgr.GetCamera());
        buildingInfo:SetData(this.buildingList[i]);
        this.buildingInfos[i] = buildingInfo;
    end
end


this.CheckBuildingInfos = function()
    if (this.buildingInfos == nil) then return end

    local buildingInfo;
    local len = #this.buildingInfos;
    for i = 1, len do
        buildingInfo = this.buildingInfos[i];
        buildingInfo:SetInfo();
        buildingInfo:SetPosition();
    end
end


GuoBaoScene.ClearBuildingInfos = function()
    if (this.buildingInfos == nil) then return end
    
    local len = #this.buildingInfos;
    for i = 1, len do
        this.buildingInfos[i]:Clear();
    end
    this.buildingInfos = nil;
end


this.OnBuildingRefresh = function(args)
    this.UpgradeBuilding(args[0]);
end


this.AddNpc = function()
    local building;
    local len = #this.buildingList;
    for i = 1, len do
        building = this.buildingList[i];
        if (building.config.Group == "200") then
            GuoBaoCharacterMgr.AddNpc("D0039", "D0039051", "npc", building.transform.localPosition);
            break;
        end
    end
end


this.GenCharacter = function()
    local time = os.time();
    if (time < this.characterTime) then return end
    if (not LuaMgr.IsPanelOpen(UIName.GuoBaoViewModel)) then return end
    
    if (this.npcList == nil or #this.npcList <= 0) then
        this.npcList = {};
        local shopNPCs = ConfigMgr.Config.ShopNPCs;
        local len = #shopNPCs;
        for i = 1, len do
            this.npcList[i] = shopNPCs[i];
        end
    end
    this.characterTime = time + 5;
    local index = math.random(1, #this.npcList);
    local shopNpc = this.npcList[index];
    table.remove(this.npcList, index);
    GuoBaoCharacterMgr.AddCharacter({characterId=shopNpc.ID, skinId=shopNpc.Skin, data=shopNpc});
end


this.OnUpdate = function()
    GuoBaoSceneMgr.Update();
    GuoBaoCharacterMgr.CheckCharacters();
    this.CheckBuildingEffects();
    this.CheckBuildingInfos();
    this.GenCharacter();
    this.CheckClick();
end


this.CheckClick = function()
    if (RaycastTool.GetMouseButtonUp(0)) then
        if (LuaMgr.OutOfScreen()) then return end
        if (GuoBaoSceneMgr.IsMove()) then return end
        if (not LuaMgr.HasNormalStack(UIName.GuoBaoViewModel)) then return end
        if (RaycastTool.IsPointerOverGameObject() and not LuaMgr.IsGuide()) then return end
        
        local obj = RaycastTool.GetClickInfo(this.camera, 100, "Character");
        if (obj ~= nil) then
            local character = GuoBaoCharacterMgr.GetCharacter(obj.name);
            if (character ~= nil and character.data == "npc") then
                LuaMgr.ShowLuaPanel(UIName.GuoBaoCollectViewModel);
                return;
            end
        end
        obj = FoundationSceneMgr.Click(this.camera, 100, "SceneDynamic");
        if (obj ~= nil) then
            local id = string.gsub(obj.name, "Building", "");
            local config = ConfigMgr.Config.SimulatedShopMap[id];
            if (config == nil) then return end
            if (not PlayerGuoBaoMgr.IsBuildingUnlock(config, true)) then return end
            
            if (config.Type == 1) then
                if (config.Level == 1) then
                    PlayerGuoBaoMgr.SimulatedShopUpgrade(config.Group);
                else
                    LuaMgr.ShowLuaPanel(UIName.GuoBaoUpLevelViewModel, config);
                end
            elseif (config.Type == 2) then
                PlayerGuoBaoMgr.SimulatedShopWishList();
            elseif (config.Type == 3) then
                if (PlayerGuoBaoMgr.IsFZQKUnlock()) then
                    LuaMgr.ShowLuaPanel(UIName.GuoBaoDrawViewModel);
                end
            end
        end
    end
end