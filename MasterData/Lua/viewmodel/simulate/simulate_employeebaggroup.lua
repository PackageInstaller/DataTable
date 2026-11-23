Simulate_EmployeeBagGroup = {};

Simulate_EmployeeBagGroup.__index = Simulate_EmployeeBagGroup;

local objs = {
    
}



function Simulate_EmployeeBagGroup.New()
    local self = {};
    setmetatable(self, Simulate_EmployeeBagGroup);
    return self;
end


function Simulate_EmployeeBagGroup:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.employeeUIList=UIListView.New(self.transform)
end









function Simulate_EmployeeBagGroup:SetData(pdata)
    self.employeeUIList:Clear();
    self.data=pdata.data
    local list={}
    for i,v in ipairs(self.data.list) do
        local employeeData=UIListData.GetData(self.data.ItemObj,"Simulate_EmployeeBagItem",v);
        table.insert(list,employeeData);
    end
    self.employeeUIList:SetData(list);
end


function Simulate_EmployeeBagGroup:Clear()
    self.employeeUIList:Clear();
    self.data=nil
end


function Simulate_EmployeeBagGroup:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

