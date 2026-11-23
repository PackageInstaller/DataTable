Delegate_FavorItem = {};

Delegate_FavorItem.__index = Delegate_FavorItem;

local objs = {
    rootObj={path="",type="GameObject"},


    fxObj={path = "fx", type = "GameObject"},
    bgSprite = { path = "Bg", type = "Image" },
    iconTexture = { path = "Icon", type = "RawImage" },
    frameSprite={path = "Frame", type = "Image"},
    favorNum = { path = "Icon/ChangedFavor/Text", type = "Text" },
    
}

function Delegate_FavorItem.New()
    local self = {};
    setmetatable(self, Delegate_FavorItem);
    return self;
end

function Delegate_FavorItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Delegate_FavorItem:SetData(pdata)
    self.data = pdata.data;
    self.bgSprite.sprite=pdata.data.bgSprite
    self.frameSprite.sprite=pdata.data.frameSprite
    self.iconTexture.texture=pdata.data.iconTexture
    self.favorNum.text=pdata.data.favorNum
    SetActive(self.gameObject,false)
    SetActive(self.fxObj,false);

end

function Delegate_FavorItem:SetAddFavor(value)
    SetActive(self.gameObject,true)
    if not self.data.isMax then
        self.favorNum.text=value
    end
    SetActive(self.fxObj,false);
    SetActive(self.fxObj,true);
end

function Delegate_FavorItem:Clear()
    self.data = nil;
end

function Delegate_FavorItem:Destroy()
    self.data = nil;
    self.bgSprite=nil
    self.frameSprite=nil
    self.iconTexture=nil
    self.favorNum=nil
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end