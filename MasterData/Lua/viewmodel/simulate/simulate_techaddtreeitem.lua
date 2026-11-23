Simulate_TechAddTreeItem = {};

Simulate_TechAddTreeItem.__index = Simulate_TechAddTreeItem;

local objs = {
    txtDes={path="root/des",type="Text"},
}



function Simulate_TechAddTreeItem.New()
    local self = {};
    setmetatable(self, Simulate_TechAddTreeItem);
    return self;
end


function Simulate_TechAddTreeItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function Simulate_TechAddTreeItem:SetData(pdata)
    self.data=pdata.data
    self.txtDes.text=self.data.text;
end



function Simulate_TechAddTreeItem:Clear()
    self.data=nil
end


function Simulate_TechAddTreeItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

