ProductItem = {};

ProductItem.__index = ProductItem;
local objs = {
    txtName = { path = "root/name", type = "Text" },
    txtDes= { path = "root/des", type = "Text" },
};

function ProductItem.New()
    local self = {};
    setmetatable(self, ProductItem);
    return self;
end

function ProductItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function ProductItem:SetData(data)
    self.data = data.data;
    self.txtName.text=self.data.name;
    self.txtDes.text=self.data.des;
end


function ProductItem:Clear()
    self.data = nil;

end

function ProductItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end