BattlePrepareSuspend_HeadItem = {};

BattlePrepareSuspend_HeadItem.__index = BattlePrepareSuspend_HeadItem;

local objs = {
    icon = { path = "headBg/icon", type = "RawImage" },
    rare = { path = "headBg/rare", type = "Image" },
    name = { path = "name", type = "Text" },
}

function BattlePrepareSuspend_HeadItem.New()
    local self = {};
    setmetatable(self, BattlePrepareSuspend_HeadItem);
    return self;
end

function BattlePrepareSuspend_HeadItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function BattlePrepareSuspend_HeadItem:SetData(pdata)
    self.data = pdata;
    self.icon.texture=pdata.data.icon
    self.rare.sprite=pdata.data.rare
    self.name.text=pdata.data.name
end

function BattlePrepareSuspend_HeadItem:Clear()
    self.data = nil;
end

function BattlePrepareSuspend_HeadItem:Destroy()
    self.data = nil;
    self.icon.texture=nil
    self.rare.sprite=nil
    self.name.text=nil
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end