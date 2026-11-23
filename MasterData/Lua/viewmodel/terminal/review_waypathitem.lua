Review_WayPathItem = {};

Review_WayPathItem.__index = Review_WayPathItem;

local objs = {
    info={path="info",type="Text"},
    btnJump={path="jump",type="Button"},
}
function Review_WayPathItem.New()
    local self = {};
    setmetatable(self, Review_WayPathItem);
    return self;
end

function Review_WayPathItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnJump, function()
        if self.data.callBack~=nil then
           self.data.callBack(self.data.jumpId);
        end
    end)
   
end

function Review_WayPathItem:SetData(pdata)
    self.data=pdata.data
    self.info.text=self.data.wayName;
    if IsNullOrEmpty(self.data.jumpId) then
        SetActive(self.btnJump.gameObject,false);
        return
    end
    SetActive(self.btnJump.gameObject,true);
    
end
function Review_WayPathItem:Clear()
   self.data=nil
end
function Review_WayPathItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.info=nil;
    self.btnJump=nil;
end

