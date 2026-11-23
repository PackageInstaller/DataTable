Rogue_ResultHeadItem = {};

Rogue_ResultHeadItem.__index = Rogue_ResultHeadItem;

local objs = {
    rawHeadIcon={ path = "root/iconRaw", type = "RawImage" },
    imgHeadRare={ path = "root/rareImg", type = "Image" },
    imgHeadJob={ path = "root/jobBg/jobImg", type = "Image" },
    txtHeadLevel={ path = "root/level", type = "Text" },
};

function Rogue_ResultHeadItem.New()
    local self = {};
    setmetatable(self, Rogue_ResultHeadItem);
    return self;
end

function Rogue_ResultHeadItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Rogue_ResultHeadItem:SetData(data)
    self.data = data.data;
    self.rawHeadIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(self.data.id))
    self.imgHeadRare.sprite=LuaMgr.GetSprite("CommonRes","ui_zd_jntx_"..self.data.rare)
    self.imgHeadJob.sprite=LuaMgr.GetSprite("JobIcon","job_"..self.data.job)
    self.txtHeadLevel.text=self.data.level;
end

function Rogue_ResultHeadItem:Clear()
    self.data = nil;
end

function Rogue_ResultHeadItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end