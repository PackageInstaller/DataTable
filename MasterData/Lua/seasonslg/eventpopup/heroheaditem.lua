HeroHeadItem = {};

HeroHeadItem.__index = HeroHeadItem;
local objs = {
    btnBg = { path = "root/bg", type = "Button" },
    goHeadInfo={ path = "root/headInfo", type = "GameObject" },
    rawIcon= { path = "root/headInfo/avatar", type = "RawImage" },
    imgRare= { path = "root/headInfo/rare", type = "Image" },
    imgJob={ path = "root/headInfo/jobBg/job", type = "Image" },
    txtSLevel={ path = "root/headInfo/slv/Text", type = "Text" },
    txtLevel={ path = "root/headInfo/lv/Text", type = "Text" },
    goSelect={ path = "root/headInfo/select", type = "GameObject" },

    imgNum={ path = "root/headInfo/select/num", type = "Image" },
    goSuo={ path = "root/headInfo/Suo", type = "GameObject" },
};

function HeroHeadItem.New()
    local self = {};
    setmetatable(self, HeroHeadItem);
    return self;
end

function HeroHeadItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnBg, function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end);
end










function HeroHeadItem:SetData(data)
    self.data = data.data;
    if IsNullOrEmpty(self.data.id) then
        SetActive(self.goHeadInfo,false)
        return;
    end
    if self.goSuo~=nil then
        SetActive(self.goSuo,self.data.lock)
    end
    SetActive(self.goHeadInfo,true);
    local path=ConfigHelper.GetCharacterAvatarPath(self.data.id,self.data.skinId);
    self.rawIcon.texture=LuaMgr.GetTexture(path);
    self.imgRare.sprite=HeroMgr.GetHeroRareIcon(self.data.id)
    self.imgJob.sprite=LuaMgr.GetSprite("JobIcon","job_"..self.data.job)
    self.txtLevel.text=self.data.level;
    self.txtSLevel.text=tostring(ConfigCharacterMgr.GetSeasonalHeroLevel(self.data.id));
    if not self.data.select then
        SetActive(self.goSelect,false);
    else
        SetActive(self.goSelect,true);

        SetActive(self.imgNum.transform.gameObject,self.data.selectIndex>0)
        self.imgNum.sprite=LuaMgr.GetSprite("SLGSeason","sjz-zlfy-rw-pqch-sz"..self.data.selectIndex)
    end
end


function HeroHeadItem:Clear()
    self.data = nil;

end

function HeroHeadItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end