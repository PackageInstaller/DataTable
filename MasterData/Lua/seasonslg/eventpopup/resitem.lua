ResItem = {};

ResItem.__index = ResItem;
local objs = {
    rawIcon={ path = "root/rawIcon", type = "RawImage" },
    btnIcon={ path = "root/rawIcon", type = "Button" },
    txtName = { path = "root/name", type = "Text" },
    txtDes= { path = "root/des", type = "Text" },
};

function ResItem.New()
    local self = {};
    setmetatable(self, ResItem);
    return self;
end

function ResItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnIcon,function()
        ConfigHelper.ShowItemTips(self.data.itemId)
    end)
end


function ResItem:SetData(data)
    self.data = data.data;
    local path=ConfigHelper.GetItemHomeIconPath(self.data.itemId)
    self.rawIcon.texture=LuaMgr.GetTexture(path);
    self.txtName.text=self.data.name;
    self.txtDes.text=self.data.des;
end


function ResItem:Clear()
    self.data = nil;

end

function ResItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end