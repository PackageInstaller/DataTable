Simulate_EmployeeGroup = {};

Simulate_EmployeeGroup.__index = Simulate_EmployeeGroup;

local objs = {
    
}



function Simulate_EmployeeGroup.New()
    local self = {};
    setmetatable(self, Simulate_EmployeeGroup);
    return self;
end


function Simulate_EmployeeGroup:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.employeeUIList=UIListView.New(self.transform)
end


function Simulate_EmployeeGroup:SetData(pdata)
    self.data=pdata.data
    self.employeeUIList:Clear();
    self.data=pdata.data
    local list={}
    for i,v in ipairs(self.data.list) do
        local employeeData=UIListData.GetData(self.data.ItemObj,"Simulate_EmployeeItem",v);
        table.insert(list,employeeData);
    end
    self.employeeUIList:SetData(list);
end


function Simulate_EmployeeGroup:Clear()
    self.employeeUIList:Clear();
    self.data=nil
end


function Simulate_EmployeeGroup:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

