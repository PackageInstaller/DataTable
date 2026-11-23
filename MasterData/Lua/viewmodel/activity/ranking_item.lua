Ranking_Item = {}

Ranking_Item.__index = Ranking_Item

local objs = 
{
    head_texture    = {path = "head_icon/head", type = "RawImage"},
    head_frame      = {path = "head_icon/frame", type = "Image"},
    power_text      = {path = "power", type = "Text"},
    rank_text       = {path = "text_rank", type = "Text"},
    name_text       = {path = "text_name", type = "Text"},
}

function Ranking_Item.New()
    local obj = {}
    setmetatable(obj, Ranking_Item)
    return obj
end

function Ranking_Item:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function Ranking_Item:SetData(d)
    local data = d.data

    local avatarData = ConfigHelper.GetAvatarFrame(data.avatarid) or ConfigHelper.GetAvatarFrame("SCJ101")
    self.head_texture.texture   = LuaMgr.GetTexture(ConfigHelper.GetHeadIconPath(avatarData.img, avatarData.imgId))
    PlayerAvatarFrameTool.SetAvatarFrame(self.head_frame, data.avatarframeid or "20001")
    self.name_text.text         = tostring(data.name)
    self.power_text.text        = tostring(data.power)
    self.rank_text.text         = tostring(data.index)
end

function Ranking_Item:Clear()
    PlayerAvatarFrameTool.ClearImage(self.head_frame)
end

function Ranking_Item:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.head_frame)
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil
    self.head_texture    = nil
    self.head_frame      = nil
    self.power_text      = nil
    self.rank_text       = nil
    self.name_text       = nil 
end