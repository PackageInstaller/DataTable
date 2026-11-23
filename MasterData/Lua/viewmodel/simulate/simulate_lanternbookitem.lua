Simulate_LanternBookItem = {};

Simulate_LanternBookItem.__index = Simulate_LanternBookItem;

local objs = {
    imgIcon={path="root/icon",type="Image"},
    txtName={path="root/name",type="Text"},
    txtCount={path="root/count",type="Text"},
    goTag={path="root/tag",type="GameObject"},
    goLock={path="root/lock",type="GameObject"},
}



function Simulate_LanternBookItem.New()
    local self = {};
    setmetatable(self, Simulate_LanternBookItem);
    return self;
end


function Simulate_LanternBookItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    
end

function Simulate_LanternBookItem:SetData(pdata)
    self.data=pdata.data
    self.imgIcon.sprite=LuaMgr.GetSprite("Simulate",self.data.iconName)
    self.txtName.text=self.data.name;
    self.txtCount.text="";
    SetActive(self.goTag,self.data.isSpecial)
    SetActive(self.goLock,not self.data.isUnLock);
end


function Simulate_LanternBookItem:Clear()
    self.data=nil
end


function Simulate_LanternBookItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

