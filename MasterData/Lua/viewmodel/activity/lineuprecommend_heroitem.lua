LineupRecommend_HeroItem = {}

LineupRecommend_HeroItem.__index = LineupRecommend_HeroItem

local objs = 
{
    icon        = {path = "icon", type = "RawImage"},
    rare        = {path = "icon/rare", type = "Image"},
    job         = {path = "zz", type = "Image"},
    level       = {path = "level", type = "Text"},
    star        = {path = "HeroZZ/Text", type = "Text"},
    staricon    = {path = "HeroZZ", type = "Image"},
}

function LineupRecommend_HeroItem.New()
    local obj = {}
    setmetatable(obj, LineupRecommend_HeroItem)
    return obj
end

function LineupRecommend_HeroItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function LineupRecommend_HeroItem:SetData(d)
    local data = d.data

    self.icon.texture       = data.icon_texture
    self.rare.sprite        = data.rare_sprite
    self.job.sprite         = data.job_sprite
    self.level.text         = tostring(data.level)

    local zzStr = data.star > 0 and "<color=#262429>%s</color>" or "<color=#aca9a3>%s</color>"
    if data.star == 0 then
        self.staricon.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_zz2")
        self.star.text = string.format(zzStr, tostring(HeroMgr.GetNumStr(1)))
    else
        self.staricon.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_zz1")
        self.star.text = string.format(zzStr, tostring(HeroMgr.GetNumStr(data.star)))
    end
end

function LineupRecommend_HeroItem:Clear()

end

function LineupRecommend_HeroItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil
    self.border     = nil
    self.icon       = nil
    self.rare       = nil
    self.job        = nil
    self.level      = nil
    self.star       = nil
    self.staricon   = nil
end