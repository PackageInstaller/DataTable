BossBuffItem = {};

BossBuffItem.__index = BossBuffItem;
local objs = {
    btnRoot={ path = "root", type = "Button" },
    imgIcon = { path = "root/icon", type = "Image" },
    txtDes= { path = "root/des", type = "Text" },
};

function BossBuffItem.New()
    local self = {};
    setmetatable(self, BossBuffItem);
    return self;
end

function BossBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnRoot, function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end);
end


function BossBuffItem:SetData(data)
    self.data = data.data;
    self.imgIcon.sprite=self.data.icon;
    self.txtDes.text=self.data.name;
end


function BossBuffItem:Clear()
    self.data = nil;

end

function BossBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end