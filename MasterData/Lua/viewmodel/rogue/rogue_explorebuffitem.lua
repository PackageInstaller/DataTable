Rogue_ExploreBuffItem = {};

Rogue_ExploreBuffItem.__index = Rogue_ExploreBuffItem;

local objs = { 
    iconImg = { path = "root/buffIcon", type = "Image" },
    nameTxt = { path = "root/buffName", type = "Text" },
    desTxt={ path = "root/buffInfo", type = "Text" },
};

function Rogue_ExploreBuffItem.New()
    local self = {};
    setmetatable(self, Rogue_ExploreBuffItem);
    return self;
end


function Rogue_ExploreBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Rogue_ExploreBuffItem:SetData(data)
    self.data = data.data;
    self.iconImg.sprite=LuaMgr.GetSprite("BuffIcon",self.data.icon);
    self.nameTxt.text=self.data.name;
    self.desTxt.text=self.data.des;
end


function Rogue_ExploreBuffItem:Clear()
    self.data = nil;
end

function Rogue_ExploreBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end