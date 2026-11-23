Changan_LevelShopItem = {};

Changan_LevelShopItem.__index = Changan_LevelShopItem;

local objs = {
    iconSprite={path="root/icon",type="Image"},
    iconObj={path="root/icon",type="GameObject"},
    lockObj={path="root/lock",type="GameObject"},
    btn={path="root/btn",type="UIButtonClick"},
    btnObj={path="root/btn",type="GameObject"},
    
}
function Changan_LevelShopItem.New()
    local self = {};
    setmetatable(self, Changan_LevelShopItem);
    return self;
end

function Changan_LevelShopItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Changan_LevelShopItem:SetData(pdata)
    self.data=pdata.data
    self.iconSprite.sprite=pdata.data.icon
    SetActive(self.iconObj,pdata.data.isIcon)
    SetActive(self.lockObj,pdata.data.isLock)
    SetActive(self.btnObj,pdata.data.isDone)
    self.btnCommand=function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index)
        end
    end
    LuaMgr.AddClick(self.btn, self.btnCommand)
end
function Changan_LevelShopItem:Clear()
    LuaMgr.RemoveClick(self.btn, self.btnCommand)
end
function Changan_LevelShopItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

