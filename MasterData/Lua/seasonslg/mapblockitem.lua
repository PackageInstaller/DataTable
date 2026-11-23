MapBlockItem = {};

MapBlockItem.__index = MapBlockItem;
local objs = { 
    iconBtn = { path = "root/icon", type = "Button" },
    onDragEvent={ path = "root/icon", type = "OnDragEvent" },

};

function MapBlockItem.New()
    local self = {};    
    setmetatable(self, MapBlockItem);
    return self;
end

function MapBlockItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self:Register();
end

function MapBlockItem:Register()
    local onPointDown=function(eventData)
        self.drag=false;
        self.downTime=UnityEngine.Time.realtimeSinceStartup
    end
    local onPointUp=function(eventData)
        if not self.drag and UnityEngine.Time.realtimeSinceStartup-self.downTime<=0.5 then
            self.data.callBack(self.data.groupIndex,self.data.index);
        end
        if SeasonSLGMapMgr.scrollView~=nil then
            SeasonSLGMapMgr.scrollView:OnEndDrag(eventData);
        end
    end
    local onBeginDrag=function(eventData)
        self.drag=true;
        if SeasonSLGMapMgr.scrollView~=nil then
            SeasonSLGMapMgr.scrollView:OnBeginDrag(eventData);
        end
    end
    local onDrag=function(eventData)
        if SeasonSLGMapMgr.scrollView~=nil then
            SeasonSLGMapMgr.scrollView:OnDrag(eventData);
        end
    end
    self.onDragEvent:SetDragData(onBeginDrag,nil);
    self.onDragEvent:SetData(1,onPointDown,onDrag,onPointUp);
end

































function MapBlockItem:SetData(data)   
    self.data = data.data;
end


function MapBlockItem:Clear()    
    self.data = nil;
   
end

function MapBlockItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end