Simulate_LanternItem = {};

Simulate_LanternItem.__index = Simulate_LanternItem;

local objs = {
    imgIcon={path="root/icon",type="Image"},
    txtName={path="root/name",type="Text"},
    txtCount={path="root/count",type="Text"},
    goTag={path="root/tag",type="GameObject"},
}



function Simulate_LanternItem.New()
    local self = {};
    setmetatable(self, Simulate_LanternItem);
    return self;
end


function Simulate_LanternItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    
end

function Simulate_LanternItem:SetData(pdata)
    self.data=pdata.data
    self.imgIcon.sprite=LuaMgr.GetSprite("Simulate",self.data.iconName)
    self.txtName.text=self.data.name;
    self.txtCount.text=self.data.count;
    SetActive(self.goTag,self.data.isSpecial)
end


function Simulate_LanternItem:Clear()
    self.data=nil
end


function Simulate_LanternItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

