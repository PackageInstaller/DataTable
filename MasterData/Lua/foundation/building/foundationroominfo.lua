FoundationRoomInfo = {};

FoundationRoomInfo.__index = FoundationRoomInfo;

local objs = {
    bgGO = { path = "Bg", type = "GameObject" },
    bgBtn = { path = "Bg", type = "Button" },
    tipsTF = { path = "Tips", type = "Transform" },
    iconGO = { path = "Icon", type = "GameObject" },
    icon = { path = "Icon", type = "RawImage" },
    countGO = { path = "Count", type = "GameObject" },
    countTF = { path = "Count", type = "RectTransform" },
    countText = { path = "Count/Text", type = "Text" },
    idleGO = { path = "Tips/Idle", type = "GameObject" },
    stopWorkGO = { path = "Tips/StopWork", type = "GameObject" },
    completeGO = { path = "Tips/Complete", type = "GameObject" },
    vendingMachineGO = { path = "Tips/VendingMachine", type = "GameObject" },
    teaGO = { path = "Tips/Tea", type = "GameObject" },
    weaponMakeGO = { path = "Tips/WeaponMake", type = "GameObject" },
    upgradeGO = { path = "Tips/Upgrade", type = "GameObject" },
    staminaGO = { path = "Tips/Stamina", type = "GameObject" },
    miniGameGo = { path = "Tips/MiniGame", type = "GameObject" },
    catTF = { path = "Cat", type = "Transform" },
    catGO = { path = "Cat", type = "GameObject" },
}

FoundationRoomInfo.New = function(container, camera)
    local self = {};
    setmetatable(self, FoundationRoomInfo);
    self.container = container;
    self.camera = camera;
    self.prefabPath = "Assets/_BundleResources/UI/Foundation/FoundationRoomInfo.prefab";
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath);
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddPrefabRefCount(self.prefabPath);
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    self.roomId = "";
    self.itemData = nil;
    self.tipsData = nil;
    self.OnClickBg = function()
        if (self.itemData ~= nil) then
if (self.itemData.complete) then
                FoundationMgr.Goto(self.roomId);
            else
                local itemType = self.itemData.type;
if (itemType == 1) then
                    if (self.itemData.itemId ~= "") then
                        PlayerFoundationMgr.GetAllRewards(itemType);
                    elseif (self.itemData.idle) then
                        FoundationMgr.Goto(self.roomId);
                    end
elseif (itemType == 2) then
                    if (self.itemData.stopWork or self.itemData.idle) then
                        FoundationMgr.Goto(self.roomId);
                    elseif (self.itemData.itemId ~= "") then
                        PlayerFoundationMgr.Draw(self.itemData.id);
                    end
elseif (itemType == 3) then
                    FoundationMgr.Goto(self.roomId);
elseif (itemType == 4) then
                    FoundationMgr.Goto(self.roomId);
elseif (itemType == 5) then

elseif (itemType == 6) then

elseif (itemType == 7) then
                    PlayerFoundationMgr.WeaponMadeGather();
elseif (itemType == 8) then

elseif (itemType == 9) then

                end
            end
        else
if (self.roomId == "105") then
                PlayerFoundationMgr.DrawComfort();
            end
        end
    end
    LuaMgr.AddClick(self.bgBtn, self.OnClickBg);
    return self;
end

function FoundationRoomInfo:SetData(roomId, target)
    self.roomId = roomId;
    self:SetItem();
    local p = RectTransformTool.ToContainer(self.camera, target, self.container);
    local config = ConfigMgr.Config.roomMap[roomId];
    if (config ~= nil) then
        p.x = p.x + config.UIPos[1];
        p.y = p.y + config.UIPos[2];
    end
    self.transform.localPosition = Vector3(p.x, p.y, 0);
    if (config ~= nil) then
        p.x = config.TipsPos[1];
        p.y = config.TipsPos[2];
        self.tipsTF.localPosition = Vector3(p.x, p.y, 0);
        p.x = config.CatPos[1];
        p.y = config.CatPos[2];
        self.catTF.localPosition = Vector3(p.x, p.y, 0);
    end
end

function FoundationRoomInfo:SetItem()
    self:SetCount(false);
    self:SetIcon(false);
    self:SetStopWork(false);
    local itemData, tipsData = PlayerFoundationMgr.GetDrawItemByRoom(self.roomId);
    if (itemData ~= nil) then
        self.itemData = itemData;
        if (itemData.itemId ~= "") then
            self.icon.texture = GetItemTexture(itemData.itemId);
            if (itemData.count > 0) then
                self.countText.text = tostring(itemData.count);
                local width = self.countText.preferredWidth;
                width = width > 32 and width - 32 or 0;
                self.countTF.sizeDelta = Vector2(32 + width, 18);
                self:SetCount(true);
            end
            self:SetIcon(true);
            SetActive(self.bgGO, true);
            self:SetStopWork(itemData.stopWork);
        end
    elseif (self:IsComfort()) then
        self.icon.texture = GetItemTexture("3230");
        self:SetIcon(true);
        SetActive(self.bgGO, true);
    else
        SetActive(self.bgGO, false);
        self.itemData = nil;
    end
    self:SetIdle(false);
    self:SetComplete(false);
    self:SetVendingMachine(false);
    self:SetTea(false);
    self:SetMiniGame(false);
    self:SetUpgrade(false);
    self:SetStamina(false);
    if (tipsData ~= nil) then
        if (tipsData.complete) then
            self:SetComplete(true);
        elseif (tipsData.upgrade) then
            self:SetUpgrade(true);
            if (tipsData.weaponMake) then
                self:SetWeaponMake(true);
            end
        else
            if (tipsData.vendingMachine) then
                self:SetVendingMachine(true);
            elseif (tipsData.tea) then
                self:SetTea(true);
            elseif (tipsData.stamina) then
                self:SetStamina(true);
            else
                self:SetIdle(tipsData.idle);
            end
        end
if (tipsData.miniGame) then
            self:SetMiniGame(true);
        end
    end
    if ((itemData ~= nil and itemData.weaponMake) or (tipsData ~= nil and tipsData.weaponMake)) then
        self:SetWeaponMake(true);
    else
        self:SetWeaponMake(false);
    end
    self:SetCat(PlayerFoundationMgr.IsCat(self.roomId));
end

function FoundationRoomInfo:SetCount(status)
    SetActive(self.countGO, status);
end

function FoundationRoomInfo:SetIcon(status)
    SetActive(self.iconGO, status);
end

function FoundationRoomInfo:SetIdle(status)
    SetActive(self.idleGO, status);
end

function FoundationRoomInfo:SetStopWork(status)
    SetActive(self.stopWorkGO, status);
end

function FoundationRoomInfo:SetComplete(status)
    SetActive(self.completeGO, status);
end

function FoundationRoomInfo:SetVendingMachine(status)
    SetActive(self.vendingMachineGO, status);
end

function FoundationRoomInfo:SetTea(status)
    SetActive(self.teaGO, status);
end

function FoundationRoomInfo:SetMiniGame(status)
    SetActive(self.miniGameGo, status);
end

function FoundationRoomInfo:SetWeaponMake(status)
    SetActive(self.weaponMakeGO, status);
end

function FoundationRoomInfo:SetUpgrade(status)
    SetActive(self.upgradeGO, status);
end

function FoundationRoomInfo:SetStamina(status)
    SetActive(self.staminaGO, status);
end

function FoundationRoomInfo:SetCat(status)
    SetActive(self.catGO, status);
end

function FoundationRoomInfo:IsComfort()
    if (self.roomId == "105") then
        local comfort = PlayerFoundationMgr.GetComfort();
        for k, _ in pairs(comfort) do
            return true;
        end
    end
    return false;
end

function FoundationRoomInfo:Clear()
    self.container = nil;
    self.camera = nil;
    self.itemData = nil;
    if (self.icon ~= nil) then

        self.icon = nil;
    end
    if (self.bgBtn ~= nil) then
        LuaMgr.RemoveClick(self.bgBtn, self.OnClickBg);
        self.bgBtn = nil;
        self.OnClickBg = nil;
    end
    if (self.gameObject ~= nil) then
        LuaMgr.RemovePrefabRefCount(self.prefabPath);
        self.transform = nil;
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil;
    end
end