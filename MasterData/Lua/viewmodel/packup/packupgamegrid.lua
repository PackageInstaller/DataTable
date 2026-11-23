PackUpGameGrid = {};

PackUpGameGrid.__index = PackUpGameGrid;

local objs = {
    icon = { path = "icon", type = "Transform" },
}

function PackUpGameGrid.New()
    local self = {};
    setmetatable(self, PackUpGameGrid);
    return self;
end

function PackUpGameGrid:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function PackUpGameGrid:SetActive(isOn)
    SetActive(self.icon.gameObject, isOn);
end

function PackUpGameGrid:SetData(pdata)
    self.gameObject.name = pdata.data.pos[1] .. "," .. pdata.data.pos[2]  
    self:CheckState(0)
    self:SetActive(pdata.data.isOn)
end

function PackUpGameGrid:CheckState(state)  
    for i = 0, self.icon.childCount - 1 do
        local child = self.icon:GetChild(i);
        SetActive(child.gameObject, i == state);         
    end 
end

function PackUpGameGrid:Clear()

end

function PackUpGameGrid:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end