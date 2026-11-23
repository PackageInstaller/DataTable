AreaDaily_equip = {};

AreaDaily_equip.__index = AreaDaily_equip;

local objs = {
    root = { path = "root", type = "Transform" },
   
}


function AreaDaily_equip.New()
    local self = {};
    setmetatable(self, AreaDaily_equip);
    return self;
end

function AreaDaily_equip:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function AreaDaily_equip:SetData(pdata)
    self.data=pdata.data
    if self.item==nil then
        self.item=GoodsDataItem.New(self.root);
    end
    self.item:SetEquipConfig(self.data.equipId,Vector3(0.4,0.4,0.4));
end



function AreaDaily_equip:Clear()
    self.data = nil;
end

function AreaDaily_equip:Destroy()
    self.root=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end