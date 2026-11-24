BuildCostItem = {};

BuildCostItem.__index = BuildCostItem;
local objs = {
    rawIcon={ path = "rawCostIcon", type = "RawImage" },
    select= { path = "select", type = "GameObject" },
    btn={ path = "rawCostIcon", type = "Button" },
};

function BuildCostItem.New()
    local self = {};
    setmetatable(self, BuildCostItem);
    return self;
end

function BuildCostItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btn,function()
        if self.data.callBack ~= nil then
            self.data.callBack(self.data.id)
        end
    end)
end


function BuildCostItem:SetData(data)
    self.data = data.data;
    local path=ConfigHelper.GetItemIconPath(self.data.id)
    self.rawIcon.texture=LuaMgr.GetTexture(path);
    self:SetSelect(self.data.select);
end

function BuildCostItem:SetSelect(select)
    SetActive(self.select,select);
end


function BuildCostItem:Clear()
    self.data = nil;

end

function BuildCostItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end