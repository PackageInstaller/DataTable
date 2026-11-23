VoyageRichManGrid = {};

VoyageRichManGrid.__index = VoyageRichManGrid;

VoyageRichManGrid.New = function(modelId, container)
    local self = {};
    setmetatable(self, VoyageRichManGrid);
    self.gameObject = LuaMgr.GetPrefab(string.format("Assets/_BundleResources/Voyage/%s.prefab", modelId));
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    self.pos = Vector3.zero;
    self.config = nil;
    self.event = nil;
    return self;
end

function VoyageRichManGrid:SetData(eventConfig, eventPoolConfig)
    self.config = eventConfig;
    if (self:HasEvent()) then
        if (self.event == nil) then
            self.event = VoyageRichManEvent.New();
        end
        self.event:SetData(self.config, self.transform);
    end
    self.pos.x = eventPoolConfig.GridCo[1];
    self.pos.y = eventPoolConfig.GridCo[2];
    self.pos.z = eventPoolConfig.GridCo[3];
    self.transform.localPosition = self.pos;
    self.transform.localRotation = Quaternion.Euler(-90, eventPoolConfig.GridTurn, 0);
    self.gameObject.name = "Grid" .. eventPoolConfig.GridNumber;
end

function VoyageRichManGrid:HasEvent()
    if (self.config.EventParam[1] ~= VoyageEventConst.Empty) then
        if (StartsWith(self.config.EventID, "reward")) then
            if (PlayerVoyageMgr.IsBox(self.config.EventID)) then
                return false;
            end
        end
        return true;
    end
    return false;
end

function VoyageRichManGrid:Trigger(data)
    if (self.event ~= nil) then
        self.event:Trigger(data);
    else
        LuaMgr.ShowLuaPanel(UIName.VoyageRichManEventViewModel, self.config, data);
    end
end

function VoyageRichManGrid:Clear()
    self.config = nil;
    if (self.event ~= nil) then
        self.event:Clear();
    end
end

function VoyageRichManGrid:Destroy()
    if (self.event ~= nil) then
        self.event:Destroy();
        self.event = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.transform = nil;
    self.gameObject = nil;
end