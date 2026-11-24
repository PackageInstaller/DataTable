BossContinueBuffItem = {};

BossContinueBuffItem.__index = BossContinueBuffItem;
local objs = {
    btnRoot={ path = "root", type = "Button" },
    imgIcon = { path = "root/icon", type = "Image" },
    txtDes= { path = "root/des", type = "Text" },
};

function BossContinueBuffItem.New()
    local self = {};
    setmetatable(self, BossContinueBuffItem);
    return self;
end

function BossContinueBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnRoot, function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end);
end


function BossContinueBuffItem:SetData(data)
    self.data = data.data;
    self.imgIcon.sprite=self.data.icon;
    self.txtDes.text=self.data.name;
end


function BossContinueBuffItem:Clear()
    self.data = nil;

end

function BossContinueBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end