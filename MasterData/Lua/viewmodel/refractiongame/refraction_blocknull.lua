Refraction_BlockNull = {};

Refraction_BlockNull.__index = Refraction_BlockNull;

local objs = {

  
}



function Refraction_BlockNull.New()
    local self = {};
    setmetatable(self, Refraction_BlockNull);
    return self;
end


function Refraction_BlockNull:Init()
    UITool.Parse(self.gameObject, self, objs);
    
end


function Refraction_BlockNull:SetData(pdata)
    self.data=pdata.data
    self.transform.anchoredPosition=self.data.data.pos
    self.gameObject.name="init_"..self.data.data.index
end



function Refraction_BlockNull:Clear()
    self.data=nil
    
end


function Refraction_BlockNull:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
   
end

