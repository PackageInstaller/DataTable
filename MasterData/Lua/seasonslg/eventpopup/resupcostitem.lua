ResUpCostItem = {};

ResUpCostItem.__index = ResUpCostItem;
local objs = {
    rawIcon={ path = "root/icon", type = "RawImage" },
    btnIcon={ path = "root/icon", type = "Button" },
    txtCost = { path = "root/cost", type = "Text" },
    goCompete= { path = "root/compete", type = "GameObject" },
};

function ResUpCostItem.New()
    local self = {};
    setmetatable(self, ResUpCostItem);
    return self;
end

function ResUpCostItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnIcon,function()
        ConfigHelper.ShowItemTips(self.data.itemId)
    end)
end





function ResUpCostItem:SetData(data)
    self.data = data.data;
    local path=ConfigHelper.GetItemHomeIconPath(self.data.itemId)
    self.rawIcon.texture=LuaMgr.GetTexture(path);
    self.txtCost.text=string.format("<color=#CF64C9>%s</color>/%s",self.data.myCount,self.data.count);
    SetActive(self.goCompete,self.data.myCount>=self.data.count);
end


function ResUpCostItem:Clear()
    self.data = nil;

end

function ResUpCostItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end