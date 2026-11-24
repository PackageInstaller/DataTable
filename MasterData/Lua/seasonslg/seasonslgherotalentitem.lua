
SeasonSLGHeroTalentItem = {};

SeasonSLGHeroTalentItem.__index = SeasonSLGHeroTalentItem;
local objs = {
    goLine={ path = "root/Line", type = "GameObject" },
    goLineGray = { path = "root/Line/gray", type = "GameObject" },
    goLineActive = { path = "root/Line/active", type = "GameObject" },
    imgIcon={ path = "root/Item/Icon", type = "Image" },
    goLock={ path = "root/Item/Lock", type = "GameObject" },
    goSelected={ path = "root/Item/Selected", type = "GameObject" },
    goUnlock={ path = "root/Item/Unlock", type = "GameObject" },
    btnIcon={ path = "root/Item/Icon", type = "UIButtonClick" },
    goSuo={ path = "root/Item/suo", type = "GameObject" },
    goGray={ path = "root/Line/gray", type = "GameObject" },
    goActive={ path = "root/Line/active", type = "GameObject" },
    goUpLevel={ path = "root/Item/LevelGroup", type = "GameObject" },
    goCanLevel={ path = "root/Item/LevelGroup/CanUpgrade", type = "GameObject" },
    goFullLevel={ path = "root/Item/LevelGroup/FullLevel", type = "GameObject" },
    txtName={ path = "root/Item/name", type = "Text" },

};

function SeasonSLGHeroTalentItem.New()
    local self = {};
    setmetatable(self, SeasonSLGHeroTalentItem);
    return self;
end

function SeasonSLGHeroTalentItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnIcon,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end

function SeasonSLGHeroTalentItem:SetData(data)
    self.data=data.data;
    SetActive(self.goLine,self.data.index>1);
    self.txtName.text=self.data.name;
    local iconName=(self.data.isUnLock and self.data.curLevel>0) and self.data.iconName.."_gh" or self.data.iconName.."_1";
    self.imgIcon.sprite=LuaMgr.GetSprite("SeasonSLGAtlas",iconName)
    SetActive(self.goLock,not self.data.isUnLock or self.data.curLevel==0)
    SetActive(self.goUnlock,self.data.isUnLock and self.data.curLevel>0)
    SetActive(self.goUpLevel, self.data.isUnLock and self.data.curLevel>0)
    SetActive(self.goSuo,not self.data.isUnLock);
    SetActive(self.goFullLevel,self.data.isUnLock and  self.data.curLevel==self.data.maxLevel)
    SetActive(self.goCanLevel,self.data.isUnLock and  self.data.curLevel<self.data.maxLevel)
    SetActive(self.goSelected,self.data.isSelect);
    SetActive(self.goGray,not self.data.isUnLock or self.data.curLevel==0)
    SetActive(self.goActive, self.data.isUnLock and self.data.curLevel>0)

end

function SeasonSLGHeroTalentItem:Clear()
    self.data=nil;
end

function SeasonSLGHeroTalentItem:Destroy()

    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end