Dispatch_HeroItem = {};

Dispatch_HeroItem.__index = Dispatch_HeroItem;
local objs = {
    rawIcon = { path = "root/bg/icon", type = "RawImage" },
    txtName={ path = "root/bg/name", type = "Text" },
    txtLevel={ path = "root/bg/level", type = "Text" },
    goDispatch={ path = "root/bg/dispatch", type = "GameObject" },
    goSelect={ path = "root/bg/select", type = "GameObject" },
    goLock={ path = "root/bg/lock", type = "GameObject" },
    goHot={ path = "root/bg/hot", type = "GameObject" },
    btnBg={ path = "root/bg", type = "Button" },
}

function Dispatch_HeroItem.New()
    local self = {};
    setmetatable(self, Dispatch_HeroItem);
    return self;
end

function Dispatch_HeroItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnBg, function()
        if self.data.callBack ~= nil then
            self.data.callBack(self.data.index,self.data.id);
        end
    end)
end











function Dispatch_HeroItem:SetData(pdata)
    self.data = pdata.data
    local path=ConfigHelper.GetCharacterAvatarPath(self.data.id,nil);
    self.rawIcon.texture=LuaMgr.GetTexture(path);
    self.txtName.text=self.data.name;
    self.txtLevel.text="lv."..self.data.level;
    SetActive(self.goHot,self.data.isHot);
    SetActive(self.goDispatch,self.data.lockByEventId~=nil)
    SetActive(self.goSelect,self.data.select);
    SetActive(self.goLock,not self.data.unlock)
end

function Dispatch_HeroItem:Clear()
    self.data = nil;
end

function Dispatch_HeroItem:Destroy()
    self.rawIcon=nil;
    self.txtName=nil;
    self.goLock=nil;
    self.goDispatch=nil;
    self.goSelect=nil;
    self.goHot=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject=nil;
end