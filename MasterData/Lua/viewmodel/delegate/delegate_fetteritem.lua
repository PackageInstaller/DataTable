Delegate_FetterItem = {};

Delegate_FetterItem.__index = Delegate_FetterItem;

local objs = {
    free = { path = "free", type = "Transform" },
    active = { path = "active", type = "Transform" },
    fetterRare = { path = "active", type = "Image" },
    fetterIcon = { path = "active/icon", type = "Image" },
}

function Delegate_FetterItem.New()
    local self = {};
    setmetatable(self, Delegate_FetterItem);
    return self;
end

function Delegate_FetterItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Delegate_FetterItem:SetData(pdata)
    self.data = pdata;
    SetActive(self.free.gameObject,not pdata.data.isActive)
    SetActive(self.active.gameObject, pdata.data.isActive);
    if pdata.data.isActive then
        self.fetterRare.sprite=pdata.data.fetterRare
        self.fetterIcon.sprite=pdata.data.fetterIcon
    end
end

function Delegate_FetterItem:Clear()
    self.data = nil;
    self.fetterRare.sprite=DefaultSprite
    self.fetterIcon.sprite=DefaultSprite
end

function Delegate_FetterItem:Destroy()
    self.data = nil;
    self.headIcon=nil
    self.level=nil
    self.free=nil
    self.active=nil
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end