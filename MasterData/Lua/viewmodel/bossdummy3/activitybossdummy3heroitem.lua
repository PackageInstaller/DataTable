ActivityBossDummy3HeroItem = {}

ActivityBossDummy3HeroItem.__index = ActivityBossDummy3HeroItem

local objs = 
{
    icon_texture    = { path = "icon", type = "RawImage" },
    rare_img        = { path = "icon/rare", type = "Image" },
    job_img         = { path = "zz", type = "Image" },
    text_desc       = { path = "Image/textdesc", type = "Text" },
    text_value      = { path = "Image/textvalue", type = "Text" },
}

function ActivityBossDummy3HeroItem.New()
    local obj = {}
    setmetatable(obj, ActivityBossDummy3HeroItem)
    return obj
end

function ActivityBossDummy3HeroItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function ActivityBossDummy3HeroItem:SetData(d)
    local data      = d.data
    local config    = data.config
    local index     = data.index

    local heroId = config.ReCommend[index]
    self.icon_texture.texture   = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(heroId))
    self.rare_img.sprite        = LuaMgr.GetSprite("CommonRes","ui_ty_kp_pz_"..ConfigMgr.Config.characterTable[heroId].rare)
    self.job_img.sprite         = LuaMgr.GetSprite("JobIcon", "job_" .. ConfigMgr.Config.characterTable[heroId].job)
    self.text_desc.text         = ConfigMgr.LangGlobal(config.ConditionDesc[index][1])
    self.text_value.text        = ConfigMgr.LangGlobal(config.ConditionDesc[index][2])

    local instance = self
    self.config = config
    self.index = index

    local function a()
        LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3BonusDescPopupViewModel, instance.config, instance.index)
    end

    LuaMgr.RemoveClick(self.gameObject:GetComponent("Button"), a)
    LuaMgr.AddClick(self.gameObject:GetComponent("Button"), a)
end

function ActivityBossDummy3HeroItem:Clear()

end

function ActivityBossDummy3HeroItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
end