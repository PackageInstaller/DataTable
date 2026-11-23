BattlePrepare_HeadItem = {};

BattlePrepare_HeadItem.__index = BattlePrepare_HeadItem;

local objs = {
    icon = { path = "headBg/icon", type = "RawImage" },
    rare = { path = "headBg/rare", type = "Image" },
    name = { path = "name", type = "Text" },
}

function BattlePrepare_HeadItem.New()
    local self = {};
    setmetatable(self, BattlePrepare_HeadItem);
    return self;
end

function BattlePrepare_HeadItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function BattlePrepare_HeadItem:SetData(pdata)
    self.data = pdata;
    self.icon.texture=pdata.data.icon
    self.rare.sprite=pdata.data.rare
    self.name.text=pdata.data.name
end

function BattlePrepare_HeadItem:Clear()
    self.data = nil;
end

function BattlePrepare_HeadItem:Destroy()
    self.data = nil;
    self.icon.texture=nil
    self.rare.sprite=nil
    self.name.text=nil
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end