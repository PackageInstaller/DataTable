Refraction_HighPointItem = {};

Refraction_HighPointItem.__index = Refraction_HighPointItem;

local objs = {
    highObj={path="root/hight",type="GameObject"},
    initObj={path="root/init",type="GameObject"},
}

function Refraction_HighPointItem.New()
    local self = {};
    setmetatable(self, Refraction_HighPointItem);
    return self;
end


function Refraction_HighPointItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Refraction_HighPointItem:SetData(pdata)
    self.data=pdata.data
    SetActive(self.initObj,self.data.index==1)
    SetActive(self.highObj,self.data.index~=1)
    self.transform.anchoredPosition=Vector2(self.data.pos.x,self.data.pos.y);
end


function Refraction_HighPointItem:Clear()
    self.data=nil
    
end


function Refraction_HighPointItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
   
end

