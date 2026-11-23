Rogue_ResultBuffItem = {};

Rogue_ResultBuffItem.__index = Rogue_ResultBuffItem;

local objs = {
    imgRare = { path = "root/rare", type = "Image" },
    imgIcon = { path = "root/rare/icon", type = "Image" },
};

function Rogue_ResultBuffItem.New()
    local self = {};
    setmetatable(self, Rogue_ResultBuffItem);
    return self;
end

function Rogue_ResultBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function Rogue_ResultBuffItem:SetData(data)
    self.data = data.data;
    self.imgRare.sprite=LuaMgr.GetSprite("Rogue","ui_xhyt_csqzxbfd_0"..self.data.rare)
    self.imgIcon.sprite=LuaMgr.GetSprite("BuffIcon",self.data.icon)
end

function Rogue_ResultBuffItem:Clear()
    self.data = nil;
end

function Rogue_ResultBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end