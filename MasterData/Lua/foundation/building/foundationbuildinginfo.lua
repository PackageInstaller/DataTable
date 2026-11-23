FoundationBuildingInfo = {};

FoundationBuildingInfo.__index = FoundationBuildingInfo;

local objs = {
    nameTF = { path = "Name", type = "RectTransform" },
    nameGroupTF = { path = "Name/Group", type = "RectTransform" },
    nameText = { path = "Name/Group/Text", type = "Text" },
    levelGO = { path = "Name/Level", type = "GameObject" },
    levelTF = { path = "Name/Level", type = "RectTransform" },
    levelText = { path = "Name/Level/Group/Text", type = "Text" },
    levelArrow = { path = "Name/Level/Group/Arrow", type = "GameObject" },
    timeGO = { path = "Time", type = "GameObject" },
    hour = { path = "Time/Hour", type = "Text" },
    minute = { path = "Time/Minute", type = "Text" },
    second = { path = "Time/Second", type = "Text" },
    completeTF = { path = "Complete", type = "Transform" },
    completeGO = { path = "Complete", type = "GameObject" },
    completeBtn = { path = "Complete", type = "Button" },
    drawTF = { path = "Draw", type = "Transform" },
    drawGO = { path = "Draw", type = "GameObject" },
    drawBtn = { path = "Draw", type = "Button" },
    drawIcon = { path = "Draw/Icon", type = "RawImage" },
    drawProgress = { path = "Draw/Progress", type = "GameObject" },
    drawProgressValue = { path = "Draw/Progress/ProgressValue", type = "Image" },
    drawProgressFull = { path = "Draw/Progress/ProgressFull", type = "GameObject" },
    drawYWC = { path = "Draw/YWC", type = "GameObject" },
    drawFull = { path = "Draw/Full", type = "GameObject" },
    makeTF = { path = "Make", type = "Transform" },
    makeGO = { path = "Make", type = "GameObject" },
    makeBtn = { path = "Make", type = "Button" },
    makeIcon = { path = "Make/Icon", type = "RawImage" },
    stopWorkTF = { path = "StopWork", type = "Transform" },
    stopWorkGO = { path = "StopWork", type = "GameObject" },
    stopWorkBtn = { path = "StopWork", type = "Button" },
    stopWorkIcon = { path = "StopWork/Icon", type = "RawImage" },
    idleTF = { path = "Idle", type = "Transform" },
    idleGO = { path = "Idle", type = "GameObject" },
    idleBtn = { path = "Idle", type = "Button" },
    vendingMachineTF = { path = "VendingMachine", type = "Transform" },
    vendingMachineGO = { path = "VendingMachine", type = "GameObject" },
    vendingMachineBtn = { path = "VendingMachine", type = "Button" },
    vendingMachineBuyGO = { path = "VendingMachine/Buy", type = "GameObject" },
    vendingMachineInStockGO = { path = "VendingMachine/InStock", type = "GameObject" },
    vendingMachineHour = { path = "VendingMachine/InStock/Time/Hour", type = "Text" },
    vendingMachineMinute = { path = "VendingMachine/InStock/Time/Minute", type = "Text" },
    vendingMachineSecond = { path = "VendingMachine/InStock/Time/Second", type = "Text" },
    composeTF = { path = "Compose", type = "Transform" },
    composeGO = { path = "Compose", type = "GameObject" },
    composeBtn = { path = "Compose", type = "Button" },
    weaponMakeIdleTF = { path = "WeaponMakeIdle", type = "Transform" },
    weaponMakeIdleGO = { path = "WeaponMakeIdle", type = "GameObject" },
    weaponMakeIdleBtn = { path = "WeaponMakeIdle", type = "Button" },
    weaponMakingTF = { path = "WeaponMaking", type = "Transform" },
    weaponMakingGO = { path = "WeaponMaking", type = "GameObject" },
    weaponMakingBtn = { path = "WeaponMaking", type = "Button" },
    weaponMakingIcon = { path = "WeaponMaking/Icon", type = "RawImage" },
    weaponMakeDrawTF = { path = "WeaponMakeDraw", type = "Transform" },
    weaponMakeDrawGO = { path = "WeaponMakeDraw", type = "GameObject" },
    weaponMakeDrawBtn = { path = "WeaponMakeDraw", type = "Button" },
    weaponMakeDrawIcon = { path = "WeaponMakeDraw/Icon", type = "RawImage" },
    upgradeTF = { path = "Upgrade", type = "Transform" },
    upgradeGO = { path = "Upgrade", type = "GameObject" },
    upgradeBtn = { path = "Upgrade", type = "Button" },
}

FoundationBuildingInfo.New = function(container, camera, order)
    local self = {};
    setmetatable(self, FoundationBuildingInfo);
    self.container = container;
    self.camera = camera;
    self.prefabPath = "Assets/_BundleResources/UI/Foundation/FoundationBuildingInfo.prefab";
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath);
    if (order > 0) then
        self.canvas = RaycastTool.AddCanvas(self.gameObject, order);
        self.OnNextFrame = function()
            self.canvas.overrideSorting = true;
        end
        LuaMgr.NextFrame(self.OnNextFrame);
    end
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddPrefabRefCount(self.prefabPath);
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    LuaMgr.SetFont(self.transform);
    self.cid = 0;
    self.cameraPos = Vector3.zero;
    self.screenRatioOffset = FoundationMgr.ScreenRatioOffset();
    self.completeSound = true;
    self.OnClickComplete = function()
        FoundationMgr.CloseOperate(false);
        PlayerFoundationMgr.RefreshLevel(self.cid);
    end
    self.OnClickDraw = function()
        FoundationMgr.CloseOperate(true);
        PlayerFoundationMgr.Draw(self.cid);
    end
    self.OnClickMake = function()
        FoundationMgr.CloseOperate(false);
        LuaMgr.ShowLuaPanel(UIName.FoundationMakeViewModel, self.cid);
    end
    self.OnClickIdle = function()
        FoundationMgr.CloseOperate(false);
        FoundationBuildingMgr.Open(self.cid);
    end
    self.OnClickVendingMachine = function()
        FoundationMgr.CloseOperate(false);
        if (PlayerFoundationMgr.IsVendingMachineInStock(self.cid)) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("FoundationBuildingInfo_0"));
        else
            FoundationBuildingMgr.Open(self.cid);
        end
    end
    self.OnClickCompose = function()
        FoundationMgr.CloseOperate(false);
        FoundationBuildingMgr.Open(self.cid);
    end
    self.OnClickWeaponMakeIdle = function()
        FoundationMgr.CloseOperate(false);
        FeatureManager.GotoPanel("1031");
    end
    self.OnClickWeaponMaking = function()
        FoundationMgr.CloseOperate(false);
        FeatureManager.GotoPanel("1031");
    end
    self.OnClickWeaponMakeDraw = function()
        FoundationMgr.CloseOperate(false);
        PlayerFoundationMgr.WeaponMadeGather();
    end
    self.OnClickUpgrade = function()
        FoundationMgr.CloseOperate(false);
        LuaMgr.ShowLuaPanel(UIName.FoundationUpLevelViewModel, self.cid);
    end
    LuaMgr.AddClick(self.completeBtn, self.OnClickComplete);
    LuaMgr.AddClick(self.drawBtn, self.OnClickDraw);
    LuaMgr.AddClick(self.makeBtn, self.OnClickMake);
    LuaMgr.AddClick(self.stopWorkBtn, self.OnClickMake);
    LuaMgr.AddClick(self.idleBtn, self.OnClickIdle);
    LuaMgr.AddClick(self.vendingMachineBtn, self.OnClickVendingMachine);
    LuaMgr.AddClick(self.composeBtn, self.OnClickCompose);
    LuaMgr.AddClick(self.weaponMakeIdleBtn, self.OnClickWeaponMakeIdle);
    LuaMgr.AddClick(self.weaponMakingBtn, self.OnClickWeaponMaking);
    LuaMgr.AddClick(self.weaponMakeDrawBtn, self.OnClickWeaponMakeDraw);
    LuaMgr.AddClick(self.upgradeBtn, self.OnClickUpgrade);
    return self;
end

function FoundationBuildingInfo:SetData(building)
    self.gameObject.name = tostring(building.id);
    self.cid = building.config.Id;
    SetActive(self.levelArrow, false);
    SetActive(self.timeGO, false);
    SetActive(self.completeGO, false);
    SetActive(self.drawGO, false);
    SetActive(self.makeGO, false);
    SetActive(self.stopWorkGO, false);
    SetActive(self.idleGO, false);
    SetActive(self.vendingMachineGO, false);
    SetActive(self.composeGO, false);
    SetActive(self.weaponMakeIdleGO, false);
    SetActive(self.weaponMakingGO, false);
    SetActive(self.weaponMakeDrawGO, false);
    SetActive(self.upgradeGO, false);
    self:SetName();
    self:SetItem();
    self:SetPosition(building);
end

function FoundationBuildingInfo:SetPosition(building)    
    if (self.camera == nil or LuaMgr.IsObjectNull(self.camera))then return end
    if (self.container == nil or LuaMgr.IsObjectNull(self.container))then return end
    if (building == nil or LuaMgr.IsObjectNull(building.transform))then return end
    if (RectTransformTool.IsEqualsPos(self.camera.transform, self.cameraPos)) then return end
    
    local pos = self.camera.transform.position;
    self.cameraPos.x = pos.x;
    self.cameraPos.y = pos.y;
    self.cameraPos.z = pos.z;
    local p = RectTransformTool.ToContainer(self.camera, building.transform, self.container);
    local namePos = building.config.NamePos;
    pos.x = p.x + namePos[1];
    pos.y = p.y + namePos[2] + self.screenRatioOffset * 200;
    pos.z = 0;
    self.transform.localPosition = pos;
    local uiPos = building.config.UIPos;
    pos.x = uiPos[1];
    pos.y = uiPos[2] + self.screenRatioOffset * 50;
    self.completeTF.localPosition = pos;
    self.drawTF.localPosition = pos;
    self.makeTF.localPosition = pos;
    self.stopWorkTF.localPosition = pos;
    self.idleTF.localPosition = pos;
    self.vendingMachineTF.localPosition = pos;
    self.composeTF.localPosition = pos;
    self.weaponMakeIdleTF.localPosition = pos;
    self.weaponMakingTF.localPosition = pos;
    self.weaponMakeDrawTF.localPosition = pos;
    self.upgradeTF.localPosition = pos;
end

function FoundationBuildingInfo:SetName()
    local interaction = ConfigFoundationMgr.GetInteractionById(self.cid);
    if (interaction ~= nil) then
        self.nameText.text = LuaMgr.GetLangText(interaction.NameLan);
        local width = self.nameText.preferredWidth;
        if (interaction.Hide == 0) then
            width = width > 66 and width - 66 or 0;
            self.nameGroupTF.anchoredPosition = Vector2(74 + width * 0.5, 2);
            self.levelText.text = "lv." .. interaction.Level;
            if (self.levelArrow.activeSelf) then
                self.levelTF.anchoredPosition = Vector2(-74, 2);
                self.levelTF.sizeDelta = Vector2(76, 28);
                width = width + 20;
            else
                self.levelTF.anchoredPosition = Vector2(-64, 2);
                self.levelTF.sizeDelta = Vector2(56, 28);
            end
            self.nameTF.sizeDelta = Vector2(200 + width, 72);
            SetActive(self.levelGO, true);
        else
            width = width < 200 and 200 or width;
            self.nameGroupTF.anchoredPosition = Vector2(width * 0.5, 2);
            self.nameTF.sizeDelta = Vector2(width, 72);
            SetActive(self.levelGO, false);
        end
    end
end

function FoundationBuildingInfo:SetItem()
    local config = ConfigFoundationMgr.GetInteractionById(self.cid);
    if (config ~= nil) then
        if (config.Type == 1) then
            local itemId = PlayerFoundationMgr.GetDrawItemId(config, nil);
            local icon = GetItemTexture(itemId);
            self.drawIcon.texture = icon;
            self.stopWorkIcon.texture = icon;
        else
            local data = DataMgr.Player.interactions[self.cid];
            local itemId = PlayerFoundationMgr.GetDrawItemId(config, data);
            if (itemId ~= "") then
                local icon = GetItemTexture(itemId);
                self.drawIcon.texture = icon;
                self.makeIcon.texture = icon;
                self.stopWorkIcon.texture = icon;
            end
        end
    end
end

function FoundationBuildingInfo:SetTime(time)
    if (LuaMgr.IsObjectNull(self.timeGO)) or self.timeGO==nil then return end
    if (time > 0) then
        if (not self.timeGO.activeSelf) then
            self.timeGO:SetActive(true);
        end
        local h, m, s = GetTimeHMS(time);
        self.hour.text = h;
        self.minute.text = m;
        self.second.text = s;
    else
        if (self.timeGO.activeSelf) then
            self.timeGO:SetActive(false);
        end
    end
end

function FoundationBuildingInfo:SetComplete(status)
    SetActive(self.completeGO, status);
end

function FoundationBuildingInfo:SetDraw(status, progress)
    if (status) then
        SetActive(self.drawGO, true);
        if (progress >= 0) then
            if (progress >= 1) then
                SetActive(self.drawProgressFull, true);
                SetActive(self.drawYWC, false);
                SetActive(self.drawFull, true);
            else
                self.drawProgressValue.fillAmount = progress;
                SetActive(self.drawProgressFull, false);
                SetActive(self.drawYWC, true);
                SetActive(self.drawFull, false);
            end
            SetActive(self.drawProgress, true);
        else
            SetActive(self.drawProgress, false);
            SetActive(self.drawYWC, true);
            SetActive(self.drawFull, false);
        end
    else
        SetActive(self.drawGO, false);
        SetActive(self.drawYWC, false);
    end
end

function FoundationBuildingInfo:SetMake(status)
    if (LuaMgr.IsObjectNull(self.makeGO)) or self.makeGO==nil then return end
    if (status) then
        if (not self.makeGO.activeSelf) then
            self.makeGO:SetActive(true);
            self:SetItem();
        end
    else
        if (self.makeGO.activeSelf) then
            self.makeGO:SetActive(false);
        end
    end
end

function FoundationBuildingInfo:SetLevelArrow(status)
    if (LuaMgr.IsObjectNull(self.levelArrow)) or self.levelArrow==nil then return end
    
    if (status) then
        if (not self.levelArrow.activeSelf) then
            self.levelArrow:SetActive(true);
            self:SetName();
        end
    else
        if (self.levelArrow.activeSelf) then
            self.levelArrow:SetActive(false);
            self:SetName();
        end
    end
end

function FoundationBuildingInfo:SetStopWork(status)
    SetActive(self.stopWorkGO, status);
end

function FoundationBuildingInfo:SetIdle(status)
    SetActive(self.idleGO, status);
end

function FoundationBuildingInfo:SetVendingMachine(status)
    SetActive(self.vendingMachineGO, status);
end

function FoundationBuildingInfo:SetVendingMachineTime(time)
    if (time > 0) then
        local h, m, s = GetTimeHMS(time);
        self.vendingMachineHour.text = h;
        self.vendingMachineMinute.text = m;
        self.vendingMachineSecond.text = s;
        SetActive(self.vendingMachineInStockGO, true);
        SetActive(self.vendingMachineBuyGO, false);
    else
        SetActive(self.vendingMachineInStockGO, false);
        SetActive(self.vendingMachineBuyGO, true);
    end
end

function FoundationBuildingInfo:SetCompose(status)
    SetActive(self.composeGO, status);
end


function FoundationBuildingInfo:SetWeaponMake(active, type, data)
    if (active) then
        if (type == 1) then
            SetActive(self.weaponMakeIdleGO, true);
            SetActive(self.weaponMakingGO, false);
            SetActive(self.weaponMakeDrawGO, false);
        elseif (type == 2) then
            self.weaponMakingIcon.texture = GetItemTexture(data);
            SetActive(self.weaponMakeIdleGO, false);
            SetActive(self.weaponMakingGO, true);
            SetActive(self.weaponMakeDrawGO, false);
        elseif (type == 3) then
            self.weaponMakeDrawIcon.texture = GetItemTexture(data);
            SetActive(self.weaponMakeIdleGO, false);
            SetActive(self.weaponMakingGO, false);
            SetActive(self.weaponMakeDrawGO, true);
        end
    else
        SetActive(self.weaponMakeIdleGO, false);
        SetActive(self.weaponMakingGO, false);
        SetActive(self.weaponMakeDrawGO, false);
    end
end

function FoundationBuildingInfo:SetUpgrade(status)
    SetActive(self.upgradeGO, status);
end

function FoundationBuildingInfo:Clear()
    if (self.OnNextFrame ~= nil) then
        LuaMgr.RemoveNextFrame(self.OnNextFrame);
        self.OnNextFrame = nil;
    end
    self.container = nil;
    self.camera = nil;
    self.canvas = nil;
    self.nameTF = nil;
    self.nameText = nil;
    self.levelTF = nil;
    self.levelText = nil;
    self.levelArrow = nil;
    self.timeGO = nil;
    self.hour = nil;
    self.minute = nil;
    self.second = nil;
    if (self.drawIcon ~= nil) then

        self.drawIcon = nil;
    end
    if (self.makeIcon ~= nil) then

        self.makeIcon = nil;
    end
    if (self.stopWorkIcon ~= nil) then

        self.stopWorkIcon = nil;
    end
    if (self.weaponMakingIcon ~= nil) then

        self.weaponMakingIcon = nil;
    end
    if (self.weaponMakeDrawIcon ~= nil) then

        self.weaponMakeDrawIcon = nil;
    end
    if (self.OnClickComplete ~= nil) then
        LuaMgr.RemoveClick(self.completeBtn, self.OnClickComplete);
        self.OnClickComplete = nil;
    end
    if (self.OnClickDraw ~= nil) then
        LuaMgr.RemoveClick(self.drawBtn, self.OnClickDraw);
        self.OnClickDraw = nil;
    end
    if (self.OnClickMake ~= nil) then
        LuaMgr.RemoveClick(self.makeBtn, self.OnClickMake);
        LuaMgr.RemoveClick(self.stopWorkBtn, self.OnClickMake);
        self.OnClickMake = nil;
    end
    if (self.OnClickIdle ~= nil) then
        LuaMgr.RemoveClick(self.idleBtn, self.OnClickIdle);
        self.OnClickIdle = nil;
    end
    if (self.OnClickVendingMachine ~= nil) then
        LuaMgr.RemoveClick(self.vendingMachineBtn, self.OnClickVendingMachine);
        self.OnClickVendingMachine = nil;
    end
    if (self.OnClickCompose ~= nil) then
        LuaMgr.RemoveClick(self.composeBtn, self.OnClickCompose);
        self.OnClickCompose = nil;
    end
    if (self.OnClickWeaponMakeIdle ~= nil) then
        LuaMgr.RemoveClick(self.weaponMakeIdleBtn, self.OnClickWeaponMakeIdle);
        self.OnClickWeaponMakeIdle = nil;
    end
    if (self.OnClickWeaponMaking ~= nil) then
        LuaMgr.RemoveClick(self.weaponMakingBtn, self.OnClickWeaponMaking);
        self.OnClickWeaponMaking = nil;
    end
    if (self.OnClickWeaponMakeDraw ~= nil) then
        LuaMgr.RemoveClick(self.weaponMakeDrawBtn, self.OnClickWeaponMakeDraw);
        self.OnClickWeaponMakeDraw = nil;
    end
    if (self.OnClickUpgrade ~= nil) then
        LuaMgr.RemoveClick(self.upgradeBtn, self.OnClickUpgrade);
        self.OnClickUpgrade = nil;
    end
    if (self.gameObject ~= nil) then
        LuaMgr.RemovePrefabRefCount(self.prefabPath);
        self.transform = nil;
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil;
    end
end