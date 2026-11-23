Delegate_FrameItem = {};

Delegate_FrameItem.__index = Delegate_FrameItem;

local objs = {
    free = { path = "free", type = "Transform" },
    active = { path = "active", type = "Transform" },
    headIcon = { path = "active/HeadIcon", type = "RawImage" },
    feelingLevel = { path = "active/feeling/Level", type = "Text" },
    feeling={ path = "active/feeling", type = "GameObject" },
    maxfeeling={path = "active/maxfeeling", type = "GameObject"},
    maxfeelingLevel={path = "active/maxfeeling/Level", type = "Text"},
    iconBtn={path = "active/HeadIcon", type = "Button"},
}

function Delegate_FrameItem.New()
    local self = {};
    setmetatable(self, Delegate_FrameItem);
    return self;
end

function Delegate_FrameItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    if self.iconBtn~=nil then
        LuaMgr.AddClick(self.iconBtn,function()
            if self.data.callBack~=nil then
                self.data.callBack(self.data.index);
            end
        end)
        
    end
end




function Delegate_FrameItem:SetData(pdata)
    self.data = pdata.data;
    SetActive(self.free.gameObject,not pdata.data.isActive)
    SetActive(self.active.gameObject, pdata.data.isActive);
    self.headIcon.texture=pdata.data.headIcon
    if not pdata.data.isActive then return end;
    SetActive(self.feeling,not pdata.data.isMax)
    SetActive(self.maxfeeling,pdata.data.isMax)
    self.feelingLevel.text=pdata.data.feelingLevel
    self.maxfeelingLevel.text=pdata.data.feelingLevel
end

function Delegate_FrameItem:Clear()
    self.data = nil;
    self.headIcon.texture=DefaultTexture
end

function Delegate_FrameItem:Destroy()
    self.data = nil;
    self.headIcon=nil
    self.free=nil
    self.active=nil
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end