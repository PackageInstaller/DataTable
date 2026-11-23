VoyageRichManEvent = {};

VoyageRichManEvent.__index = VoyageRichManEvent;

VoyageRichManEvent.New = function()
    local self = {};
    setmetatable(self, VoyageRichManEvent);
    self.modelId = "";
    self.OnComplete = function()
        LuaMgr.ShowLuaPanel(UIName.VoyageRichManEventViewModel, self.config, self.data);
        self.data = nil;
    end
    return self;
end

function VoyageRichManEvent:SetData(config, parent)
    self.config = config;
    if (config.EventModelID ~= "") then
        self:SetModel(parent);
    end
end

function VoyageRichManEvent:SetModel(parent)
    if (self.modelId ~= self.config.EventModelID) then
        self:DestroyModel();
        self.modelId = self.config.EventModelID;
        self.gameObject = LuaMgr.GetPrefab(string.format("Assets/_BundleResources/Voyage/%s.prefab", self.modelId));
        self.gameObject.transform:SetParent(parent, false);
        self.animator = self.gameObject:GetComponent("ModelAnimator");
        if (self.animator ~= nil) then
            self.animator:Stop();
        end
    end
end

function VoyageRichManEvent:Trigger(data)
    if (self.animator ~= nil) then
        self.data = data;
        self.animator:Play(false, self.OnComplete);
    else
        LuaMgr.ShowLuaPanel(UIName.VoyageRichManEventViewModel, self.config, data);
    end
end

function VoyageRichManEvent:DestroyModel()
    self.modelId = "";
    if (self.gameObject ~= nil) then
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil;
        self.animator = nil;
    end
end

function VoyageRichManEvent:Clear()
    self.config = nil;
    self.data = nil;
    if (self.gameObject ~= nil) then
        SetActive(self.gameObject, false);
    end
    if (self.animator ~= nil) then
        self.animator:Stop();
    end
end

function VoyageRichManEvent:Destroy()
    self:DestroyModel();
end