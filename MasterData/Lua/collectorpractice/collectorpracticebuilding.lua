
CollectorPracticeBuilding = {};

CollectorPracticeBuilding.__index = CollectorPracticeBuilding;

CollectorPracticeBuilding.New = function(bid, container)
    local self = {};
    setmetatable(self, CollectorPracticeBuilding);
    self.id = "";
    self.config = nil;
    self.bid = bid;
    self.x = 0;
    self.y = 0;
    self.gameObject = LuaMgr.GetPrefab("Assets/_BundleResources/Collector/Prefabs/BuildModelSnowMan.prefab")

    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    self.info = nil;
    return self;
end

function CollectorPracticeBuilding:SetData(id, config, navPos)
    self.id = id;
    self.config = config;
    self.gameObject.name = tostring(id);
    self.navMeshPos = navPos
end

function CollectorPracticeBuilding:SetInfo(info)
    self.info = info;
    self.info:SetData(self);
end

function CollectorPracticeBuilding:SetPosition(x, y)
    self.x = x;
    self.y = y;
end

function CollectorPracticeBuilding:SetGroupPos(pos)
    self.group.localPosition = pos;
end

function CollectorPracticeBuilding:Clear()
    self.config = nil;
    self.occupy = nil;
    if (self.info ~= nil) then
        self.info:Clear();
        self.info = nil;
    end
    if (self.gameObject ~= nil) then
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.transform = nil;
        self.gameObject = nil;
    end
end