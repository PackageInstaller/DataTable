Simulate_DropGameItem = {};

Simulate_DropGameItem.__index = Simulate_DropGameItem;

local objs = {
    txtInfo={path="root/info",type="Text"},
    imgIcon={path="root/icon",type="Image"},
}



function Simulate_DropGameItem.New()
    local self = {};
    setmetatable(self, Simulate_DropGameItem);
    self.matListVM=nil;
    return self;
end

function Simulate_DropGameItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end




function Simulate_DropGameItem:SetData(pdata)
    self.data=pdata.data
    self.txtInfo.text=self.data.count;
    self.imgIcon.sprite=LuaMgr.GetSprite("Simulate",self.data.iconName);
end


function Simulate_DropGameItem:Clear()
    self.data=nil
end


function Simulate_DropGameItem:Destroy()
    if self.matListVM~=nil then
        self.matListVM:Destroy();
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
end

