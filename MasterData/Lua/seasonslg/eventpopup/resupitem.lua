ResUpItem = {};

ResUpItem.__index = ResUpItem;
local objs = {
    rawIcon={ path = "root/rawIconRes", type = "RawImage" },
    btnIcon={ path = "root/rawIconRes", type = "Button" },
    txtName = { path = "root/name", type = "Text" },
    txtCur= { path = "root/cur", type = "Text" },
    txtTar= { path = "root/tar", type = "Text" },
};

function ResUpItem.New()
    local self = {};
    setmetatable(self, ResUpItem);
    return self;
end

function ResUpItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnIcon,function()
        ConfigHelper.ShowItemTips(self.data.itemId)
    end)
end


function ResUpItem:SetData(data)
    self.data = data.data;
    local path=ConfigHelper.GetItemHomeIconPath(self.data.itemId)
    self.rawIcon.texture=LuaMgr.GetTexture(path);
    self.txtName.text=string.format("%s",self.data.name);
    self.txtCur.text=self.data.curNum .. LuaMgr.GetLangText("ResUpItem_0");







end


function ResUpItem:Clear()
    self.data = nil;

end

function ResUpItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end