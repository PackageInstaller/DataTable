Rogue_TopResItem = {};

Rogue_TopResItem.__index = Rogue_TopResItem;

local objs = {
    rawIcon = { path = "root/icon", type = "RawImage" },
    txtNum = { path = "root/num", type = "Text" },
};

function Rogue_TopResItem.New()
    local self = {};
    setmetatable(self, Rogue_TopResItem);
    return self;
end

function Rogue_TopResItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Rogue_TopResItem:SetData(data)
    self.data = data.data;
    self.rawIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(self.data.itemId))
    self.txtNum.text=self.data.num;
end


function Rogue_TopResItem:Clear()
    self.data = nil;
end

function Rogue_TopResItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end