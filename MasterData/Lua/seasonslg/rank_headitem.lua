
Rank_HeadItem = {};

Rank_HeadItem.__index = Rank_HeadItem;
local objs = {
    rawIcon= { path = "root/headInfo/avatar", type = "RawImage" },
    imgRare= { path = "root/headInfo/rare", type = "Image" },
    imgJob={ path = "root/headInfo/job", type = "Image" },
    txtSLevel={ path = "root/headInfo/slv/Text", type = "Text" },
    txtLevel={ path = "root/headInfo/lv", type = "Text" },
};

function Rank_HeadItem.New()
    local self = {};
    setmetatable(self, Rank_HeadItem);
    return self;
end

function Rank_HeadItem:Init()
    UITool.Parse(self.gameObject, self, objs);

end






function Rank_HeadItem:SetData(data)
    self.data=data.data;
    local cfgHero=ConfigMgr.Config.characterTable[self.data.id]
    local path=ConfigHelper.GetCharacterAvatarPath(self.data.id);
    self.rawIcon.texture=LuaMgr.GetTexture(path);

    self.imgRare.sprite=LuaMgr.GetSprite("CommonRes","ui_home_kbn_tx"..self.data.rare)
    self.imgJob.sprite=LuaMgr.GetSprite("JobIcon","job_"..cfgHero.job)
    self.txtLevel.text=self.data.level;
    if self.data.sLevel>0 then
        SetActive(self.txtSLevel.transform.parent.gameObject,true);
        self.txtSLevel.text=self.data.sLevel;
    else
        SetActive(self.txtSLevel.transform.parent.gameObject,false);
    end
end

function Rank_HeadItem:Clear()
    self.data=nil;
end

function Rank_HeadItem:Destroy()

    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end