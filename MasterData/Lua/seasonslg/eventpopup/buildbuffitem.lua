BuildBuffItem = {};

BuildBuffItem.__index = BuildBuffItem;
local objs = {
    rawIcon={ path = "root/icon", type = "RawImage" },
    iconSprite = { path = "root/buffIcon", type = "Image" },
    txtDes= { path = "root/des", type = "Text" },
    btnIcon={ path = "root/icon", type = "Button" },
};

function BuildBuffItem.New()
    local self = {};
    setmetatable(self, BuildBuffItem);
    return self;
end

function BuildBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnIcon,function()
        if not self.data.isBuff then
            ConfigHelper.ShowItemTips(self.data.itemId)
        end
    end)
end


function BuildBuffItem:SetData(data)
    self.data = data.data;
    if self.data.isBuff then
        SetActive(self.rawIcon.gameObject,false)
        SetActive(self.iconSprite.gameObject,true)
        self.iconSprite.sprite = LuaMgr.GetSprite("BuffIcon", self.data.itemId)
    else
        SetActive(self.rawIcon.gameObject,true)
        SetActive(self.iconSprite.gameObject,false)
        local path=ConfigHelper.GetItemHomeIconPath(self.data.itemId)
        self.rawIcon.texture=LuaMgr.GetTexture(path);
    end

    self.txtDes.text=self.data.des;
end


function BuildBuffItem:Clear()
    self.data = nil;

end

function BuildBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end