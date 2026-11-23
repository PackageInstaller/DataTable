YPSGameFinishFoodItem = {};

YPSGameFinishFoodItem.__index = YPSGameFinishFoodItem;

local objs = {
    ani = { path = "", type = "Animator" },
    group = { path = "Group", type = "GameObject" },
    icon = { path = "Group/nor/icon", type = "RawImage" },
    nor = { path = "Group/nor", type = "GameObject" },
    lock = { path = "Group/lock", type = "GameObject" },
}

function YPSGameFinishFoodItem.New(prefab, parent)
    local self = {};
    setmetatable(self, YPSGameFinishFoodItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject.transform;
    UITool.Parse(self.gameObject, self, objs);
    return self;
end

function YPSGameFinishFoodItem:SetData(data)
    self.data = data;
    SetActive(self.lock, data.isLock);
    if (self.data.config ~= nil) then
        self.icon.texture = YPSGameMgr.GetTexture(data.config.Icon);
        SetActive(self.nor, true);
    else
        SetActive(self.nor, false);
    end
    self.ani.enabled = false
    if (data.isNew) then
        self.ani.enabled = true       
    end
    SetActive(self.gameObject, true);
end

function YPSGameFinishFoodItem:ShowItem(bShow)
    SetActive(self.group, bShow)
end

function YPSGameFinishFoodItem:Clear()
    self.data = nil;
    SetActive(self.gameObject, false);
end

function YPSGameFinishFoodItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end