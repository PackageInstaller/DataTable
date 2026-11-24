Boss2BuffItem = {};

Boss2BuffItem.__index = Boss2BuffItem;
local objs = {
    btnRoot={ path = "root", type = "Button" },
    imgIcon = { path = "root/icon", type = "Image" },
    txtDes= { path = "root/des", type = "Text" },
};

function Boss2BuffItem.New()
    local self = {};
    setmetatable(self, Boss2BuffItem);
    return self;
end

function Boss2BuffItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnRoot, function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end);
end


function Boss2BuffItem:SetData(data)
    self.data = data.data;
    self.imgIcon.sprite=self.data.icon;
    self.txtDes.text=self.data.level;
end


function Boss2BuffItem:Clear()
    self.data = nil;

end

function Boss2BuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end