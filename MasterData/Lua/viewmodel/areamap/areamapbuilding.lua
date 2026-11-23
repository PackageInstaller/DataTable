AreaMapBuilding = {};

AreaMapBuilding.__index = AreaMapBuilding;

AreaMapBuilding.New = function(building)
    local self = {};
    setmetatable(self, AreaMapBuilding);
    self.building = building;
    self.buildingId = building.buildingId;
    self.gameObject = building.gameObject;
    self.transform = self.gameObject:GetComponent("RectTransform");
    self.meshGradient = self.gameObject:GetComponentsInChildren(typeof(CS.Laigu.Tools.UIEffects.MeshGradient),true);
   

    self:SetMeshAphlaEnable(false);
    local tf = self.transform:Find("Building_effect");
    if (tf ~= nil) then
        self.effect = tf.gameObject;
    end
    tf = self.transform:Find("Click_building_effect");
    if (tf ~= nil) then
        self.clickEffect = tf.gameObject;
    end
    self.button = self.gameObject:GetComponentInChildren(typeof(UnityEngine.UI.Button));
    self.OnClick = function()
        self:Click();
    end
    LuaMgr.AddClick(self.button, self.OnClick);
    self:SetHiddenBuildingUnlockFX(false);
    self:SetNewHideFx(false);
    self:SetRedNewFx(false);
    self.currentArea = "";
    self.buildingAtlas = "";
    self.isNew = false;
    return self;
end

function AreaMapBuilding:SetInfo(prefab, offset, scale)
    if (self.buildingInfo == nil) then
        self.buildingInfo = AreaMapBuildingInfo.New(prefab, self.transform:Find("Image"));
        self.buildingInfo.transform.localPosition = offset;
        self.buildingInfo.transform.localScale = Vector3(scale, scale, scale);
    end
end

function AreaMapBuilding:SetData(area, atlas, name, isLock, isActive, unlockAnima)
    if self.buildingInfo==nil then
        return;
    end
    self.currentArea = area;
    if (unlockAnima) then
        self:PlayMeshAphla(isLock);
    else

        self:SetMeshAphlaEnable(isLock);
        if isLock then
            self:SetMeshAphlaValue(0.6)
        end
        SetActive(self.buildingInfo.unlockFX, false);
    end
    self.buildingInfo:Clear();
    self.buildingAtlas = atlas;
    self.buildingInfo.atlasName = name
    name = isLock and name .. "_suo" or name;
    if (atlas == "AreaMapRes") then
        name = "ui_qydt_jz_lgzy";
        self.buildingInfo.atlasName = name;
    end
    
    local sprite = LuaMgr.GetSprite(atlas, name);
    SetActive(self.buildingInfo.nameGO, sprite ~= nil);
    self.buildingInfo.nameImg.sprite = sprite;
    SetActive(self.buildingInfo.suoLock, isLock);
    self.buildingInfo.suoTF.anchoredPosition = Vector2.zero;
    SetActive(self.effect, not isLock);
    if (isLock) then
        SetActive(self.gameObject, isActive);
    else
        self:SetFlag();
        self:SetNew();
        self:SetDot();
        self:SetEvents();
        self:SetItems();
        self:SetResBuidlingRedFx();
        SetActive(self.gameObject, true);
    end
end

function AreaMapBuilding:Clear()
    self:RemoveTween();
end

function AreaMapBuilding:Destroy()
    if (self.OnClick ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClick);
        self.OnClick = nil;
    end
    if (self.buildingInfo ~= nil) then
        self.buildingInfo:Destroy();
        self.buildingInfo = nil;
    end
    self.meshGradient = nil;
    self.building = nil;
end

function AreaMapBuilding:SetMeshAphlaEnable(isLock)
    for j=0,self.meshGradient.Length-1,1 do
        self.meshGradient[j].enabled=isLock;
    end
end

function AreaMapBuilding:SetMeshAphlaValue(o)
    for j=0,self.meshGradient.Length-1,1 do
        self.meshGradient[j].Offset=o;
    end
end

function AreaMapBuilding:PlayMeshAphla(isLock)
    self:RemoveTween();
    self.tween = DOTWeen.To(function() return 0.4 end, function(o)
        self:SetMeshAphlaValue(o)
    end, 1, 0.3);
    self.tween.onComplete = function()
        self:SetMeshAphlaEnable(isLock);
    end
end

function AreaMapBuilding:RemoveTween()
    if (self.tween ~= nil) then
        self.tween:Kill(false);
        self.tween = nil;
    end
end

function AreaMapBuilding:SetMainBuildingUnlockFx(active)
    if self.buildingInfo == nil then
        return;
    end
    SetActive(self.buildingInfo.suoLock, false);
    SetActive(self.buildingInfo.suoUnlockFx, active);
end

function AreaMapBuilding:SetHiddenBuildingUnlockFX(active)
    if self.building==nil then return end;
    SetActive(self.building.hiddenBuildingUnlockFX, active);
    if (active) then
        self:SetRedNewFx(false);
    end
    SetActive(self.building.hiddenBuildingUnlockFX, active);
end

function AreaMapBuilding:SetNewHideFx(active)
    SetActive(self.building.newHideFx, active);
end

function AreaMapBuilding:SetRedNewFx(active)
    SetActive(self.building.redNewFx, active);
end


function AreaMapBuilding:SetLight(status)
    SetActive(self.clickEffect, status);
    self:SetName(status);
end

function AreaMapBuilding:SetName(status)
    if (self.buildingInfo == nil) then return end

    local name = self.buildingInfo.atlasName;
    if (self.buildingAtlas ~= "AreaMapRes") then
        name = status and name .. "_xz" or name;
    end
    self.buildingInfo.nameImg.sprite = LuaMgr.GetSprite(self.buildingAtlas, name);
end


function AreaMapBuilding:SetItems()



































end


function AreaMapBuilding:AddItem(str, limit)
















end


function AreaMapBuilding:SetEvents()
    if self.buildingInfo==nil then return end;

    if PlayerAreaMgr.GetAreaModel()==AreaModel.Novel then
        SetActive(self.buildingInfo.completeGO, false);
        local isComplete=PlayerAreaMgr_NovelModel.CheckAreaBuildingEventsIsComplete(self.currentArea,self.buildingId);
        SetActive(self.buildingInfo.clearGO, isComplete);
        return;
    end
    if (AreaMapSceneMgr.IsCompleteEvent(self.currentArea, self.buildingId)) then
        if (AreaMapSceneMgr.IsCompleteEvent_S(self.currentArea, self.buildingId) and AreaMapSceneMgr.IsLevelChallenges(self.currentArea, self.buildingId) and AreaMapSceneMgr.IsClearHideEvent(self.currentArea, self.buildingId)) then
            SetActive(self.buildingInfo.completeGO, true);
            SetActive(self.buildingInfo.clearGO, false);
        else
            SetActive(self.buildingInfo.completeGO, false);
            SetActive(self.buildingInfo.clearGO, true);
        end
    else
        SetActive(self.buildingInfo.completeGO, false);
        SetActive(self.buildingInfo.clearGO, false);
    end
end

function AreaMapBuilding:SetOpenTime(lockforTime, show)
    if (not lockforTime) then
        SetActive(self.gameObject, false);
        return;
    end
    if (not show) then return end
    local mapGroup = ConfigMgr.Config.mapGroupTable[self.buildingId];
    if (mapGroup.openType == 1) then


    end
end


function AreaMapBuilding:SetFlag()
    if self.buildingInfo==nil then return end;
    if AreaMapSceneMgr.isFlag then

        SetActive(self.buildingInfo.flagGO, false);
        return;
    end
    if PlayerAreaMgr.GetAreaModel()==AreaModel.Novel then
        local mapGroup=ConfigMgr.Config.areaMapGroup[self.currentArea];
        if mapGroup~=nil then
            for i,v in ipairs(mapGroup) do
                if v.id==self.buildingId and v.category==0 then
                    local flag=PlayerAreaMgr_NovelModel.CheckAreaBuildingIsFlag(self.currentArea,self.buildingId);
                    SetActive(self.buildingInfo.flagGO, flag);
                    return
                end
            end
        end
        SetActive(self.buildingInfo.flagGO, false);
        return;
    end
    local areaMap = DataMgr.Player.areaMaps[self.currentArea];
    if (areaMap == nil) then return end

    local flag = false;
    if (self.currentArea == AreaMapSceneMgr.CurrentLockArea()) then










        local areaEventMap = ConfigMgr.Config.areaEvents;
        if not areaMap.mapGroups[self.buildingId].lock and PlayerAreaMapMgr.CheckBuildUnLock(self.currentArea,self.buildingId) then
            for i,v in pairs(areaEventMap) do
if v.category==0 and v.groupId == self.buildingId then
                    if v.type==1 and not DataHelper.CheckNovelComplete(v.id) then
                        flag=true;
                        AreaMapSceneMgr.isFlag=true;
                        break
                    elseif v.type==2 and (DataMgr.Player.dungeonRecords[v.id]==nil or DataMgr.Player.dungeonRecords[v.id].completeCount==0) then
                        flag=true;
                        AreaMapSceneMgr.isFlag=true;
                        break
                    end
                end
            end
        end
    end
    SetActive(self.buildingInfo.flagGO, flag);
end



function AreaMapBuilding:SetNew()
    if self.buildingInfo==nil then return end;
    SetActive(self.buildingInfo.newGO, false);


end

function AreaMapBuilding:SetResBuidlingRedFx()
    if (self.building==nil or self.building.redNewFx == nil) then return end

    local areaMap = DataMgr.Player.areaMaps[self.currentArea];
    if (areaMap == nil) then return end

    local config;
    local areaEventMap = ConfigMgr.Config.areaEvents;
    local dungeonRecords = DataMgr.Player.dungeonRecords;
    local list = {};
    for k, v in pairs(areaMap.areaEvents) do
        config = areaEventMap[k];
        if (config ~= nil and config.groupId == self.buildingId and v.type ~= AreaEventType.Shop) then
            if (dungeonRecords[config.unlockParam] ~= nil) then
                table.insert(list, config);
            end
        end
    end
    local isNew = false;
    local len = #list;
    for i = 1, len do
        if (dungeonRecords[list[i].id] == nil) then
            isNew = true;
            break;
        end
    end
    self:SetRedNewFx(isNew);
end


function AreaMapBuilding:SetDot()
    if self.buildingInfo==nil then return end;
    local isDot = PlayerAreaMapMgr.CheckAreaMapBuildingEvent(self.currentArea, self.buildingId);
    SetActive(self.buildingInfo.dotGO, isDot);
end

function AreaMapBuilding:Click()
    if (not AreaMapSceneMgr.isClick) then return end
    
    local areaMapData = DataMgr.Player.areaMaps[self.currentArea];
    if (areaMapData == nil) then return end

    local isLock=false;
    if PlayerAreaMgr.GetAreaModel()==AreaModel.Novel then
        local key=self.currentArea.."_"..self.buildingId
        isLock=not PlayerAreaMgr_NovelModel.areaMapBuildingStatus[key]
    else
        local mapGroup = areaMapData.mapGroups[self.buildingId];
        isLock=mapGroup == nil or mapGroup.lock
    end
    if isLock then
        local config = ConfigAreaMapMgr.GetAreaMapGroup(self.currentArea, self.buildingId);
        if (config == nil) then return end

        local eventConfig = ConfigMgr.Config.areaEvents[config.unlockParam];
        if (eventConfig == nil) then return end

        local name = "";
        if (eventConfig.type == AreaEventType.AVG) then
            local narrative = ConfigMgr.Config.narrativeMap[eventConfig.eventParam];
            if (narrative == nil) then return end

            name = LuaMgr.GetLangText(narrative.nameLan);
        else
            local dungeon = ConfigMgr.Config.dungeonMap[eventConfig.eventParam];
            if (dungeon == nil) then return end
            name = LuaMgr.GetLangText(dungeon.NameLan);
        end
        if (IsNullOrEmpty(name)) then return end

        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.gsub(ConfigMgr.LangGlobal("2024"), "{0}", name));
        return;
    end
    if (self.isNew) then
        PlayerAreaMapMgr.ModifyAreaMapBuildingStatus(self.currentArea, self.buildingId);
        self:SetNew();
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.AreaMapClickBuilding, self.buildingId);
end