Dispatch_HeroIcon = {};

Dispatch_HeroIcon.__index = Dispatch_HeroIcon;
local objs = {
    rawIcon = { path = "root/icon", type = "RawImage" },
    goLock= { path = "root/lock", type = "GameObject" },
    btnBg={ path = "root", type = "Button" },
}

function Dispatch_HeroIcon.New()
    local self = {};
    setmetatable(self, Dispatch_HeroIcon);
    self.isActive = false;
    return self;
end

function Dispatch_HeroIcon:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnBg, function()
        if self.data.callBack ~= nil then
            self.data.callBack(self.data.index);
        end
    end)
end

function Dispatch_HeroIcon:SetData(pdata)
    self.data = pdata.data
    if self.data.id~=nil then
        SetActive(self.rawIcon.gameObject,true);
        local path=ConfigHelper.GetCharacterAvatarPath(self.data.id,nil);
        self.rawIcon.texture=LuaMgr.GetTexture(path);
    else
        SetActive(self.rawIcon.gameObject,false);
    end
    SetActive(self.goLock,self.data.isLock);
end

function Dispatch_HeroIcon:Clear()
    self.data = nil;
end

function Dispatch_HeroIcon:Destroy()
    self.rawIcon=nil;
    self.btnBg=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject=nil;
end