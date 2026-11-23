GuoBaoBuildingInfo = {};

GuoBaoBuildingInfo.__index = GuoBaoBuildingInfo;

local objs = {
    groupTF = { path = "Group", type = "Transform" },
    upLevelGO = { path = "Group/UpLevel", type = "GameObject" },
    showGO = { path = "Group/Show", type = "GameObject" },
    rewardGO = { path = "Group/Reward", type = "GameObject" },
    rewardBtn = { path = "Group/Reward", type = "Button" },
    npcGO = { path = "Group/Npc", type = "GameObject" },
    npcBtn = { path = "Group/Npc", type = "Button" },
    liziGO = { path = "Group/Npc/fx_lizi", type = "GameObject" },
}

GuoBaoBuildingInfo.New = function(container, camera)
    local self = {};
    setmetatable(self, GuoBaoBuildingInfo);
    self.container = container;
    self.camera = camera;
    self.prefabPath = "Assets/_BundleResources/UI/GuoBao/GuoBaoBuildingInfo.prefab";
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath);
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddPrefabRefCount(self.prefabPath);
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    LuaMgr.SetFont(self.transform);
    self.cameraPos = Vector3.zero;
    self.screenRatioOffset = GuoBaoMgr.ScreenRatioOffset();
    self.OnClickReward = function()
        LuaMgr.NextFrame(function()
            LuaMgr.ShowLuaPanel(UIName.GuoBaoUpLevelViewModel, self.building.config);
        end);
    end
    self.OnClickNpc = function()
        LuaMgr.NextFrame(function()
            LuaMgr.ShowLuaPanel(UIName.GuoBaoCollectViewModel);
        end);
    end
    LuaMgr.AddClick(self.rewardBtn, self.OnClickReward);
    LuaMgr.AddClick(self.npcBtn, self.OnClickNpc);
    return self;
end

function GuoBaoBuildingInfo:SetData(building)
    self.building = building;
    self:SetInfo();
    self:SetPosition();
end

function GuoBaoBuildingInfo:SetInfo()
    SetActive(self.upLevelGO, false);
    SetActive(self.showGO, false);
    SetActive(self.rewardGO, false);
    SetActive(self.npcGO, false);
    SetActive(self.liziGO, false);
    local config = self.building.config;
    if (config.Type == 1) then
        local nextConfig = ConfigGuoBaoMgr.GetSimulatedShop(config.Group, config.Level + 1);
        if (nextConfig ~= nil and PlayerGuoBaoMgr.IsBuildingUnlock(nextConfig, false)) then
            if (config.Level == 1) then
                SetActive(self.showGO, true);
            else
                SetActive(self.upLevelGO, PlayerGuoBaoMgr.IsBuildingUpgrade(config));
            end
        end
        SetActive(self.rewardGO, PlayerGuoBaoMgr.IsCollectReward(config.Group));
    elseif (config.Type == 4) then
        SetActive(self.npcGO, true);
        SetActive(self.liziGO, PlayerGuoBaoMgr.IsCollectReceive());
    end
end

function GuoBaoBuildingInfo:SetPosition()
    if (IsObjectNull(self.camera)) then return end
    if (IsObjectNull(self.container)) then return end
    if (RectTransformTool.IsEqualsPos(self.camera.transform, self.cameraPos)) then return end
    if (self.building == nil or IsObjectNull(self.building.transform)) then return end

    local pos = self.camera.transform.position;
    self.cameraPos.x = pos.x;
    self.cameraPos.y = pos.y;
    self.cameraPos.z = pos.z;
    local p = RectTransformTool.ToContainer(self.camera, self.building.transform, self.container);
    local namePos = self.building.config.NamePos;
    pos.x = p.x + namePos[1];
    pos.y = p.y + namePos[2] + self.screenRatioOffset * 200;
    pos.z = 0;
    self.transform.localPosition = pos;
    local uiPos = self.building.config.UiPos;
    pos.x = uiPos[1];
    pos.y = uiPos[2] + self.screenRatioOffset * 50;
    self.groupTF.localPosition = pos;
end

function GuoBaoBuildingInfo:Equals(group)
    return self.building ~= nil 
            and self.building.config ~= nil 
            and self.building.config.Group == group;
end

function GuoBaoBuildingInfo:Clear()
    self.container = nil;
    self.camera = nil;
    self.building = nil;
    if (self.OnClickNpc ~= nil) then
        LuaMgr.RemoveClick(self.npcBtn, self.OnClickNpc);
        self.OnClickNpc = nil;
    end
    if (self.OnClickReward ~= nil) then
        LuaMgr.RemoveClick(self.npcBtn, self.OnClickReward);
        self.OnClickReward = nil;
    end
    if (self.gameObject ~= nil) then
        LuaMgr.RemovePrefabRefCount(self.prefabPath);
        self.transform = nil;
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil;
    end
end