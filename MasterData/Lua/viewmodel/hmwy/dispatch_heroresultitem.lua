Dispatch_HeroResultItem = {};

Dispatch_HeroResultItem.__index = Dispatch_HeroResultItem;
local objs = {
    rawIcon = { path = "root/bg/icon", type = "RawImage" },
    txtLevel={ path = "root/bg/Image/level", type = "Text" },
    imgFillAmount={ path = "root/bg/pro/fillAmount", type = "Image" },
}

function Dispatch_HeroResultItem.New()
    local self = {};
    setmetatable(self, Dispatch_HeroResultItem);
    return self;
end

function Dispatch_HeroResultItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Dispatch_HeroResultItem:SetData(pdata)
    self.data = pdata.data
    local path=ConfigHelper.GetCharacterAvatarPath(self.data.id);
    self.rawIcon.texture=LuaMgr.GetTexture(path);
    self.txtLevel.text="lv."..self.data.level;
    self.imgFillAmount.fillAmount=self.data.pro;
end

function Dispatch_HeroResultItem:Clear()
    self.data = nil;
end

function Dispatch_HeroResultItem:Destroy()
    self.rawIcon=nil;
    self.txtLevel=nil;
    self.imgFillAmount=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject=nil;
end