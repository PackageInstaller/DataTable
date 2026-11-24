YJSYZGuildRankingPanelRankItem = {}

YJSYZGuildRankingPanelRankItem.__index = YJSYZGuildRankingPanelRankItem

local objs =
{
    text_rank = { path = "rank/Text", type = "Text" },
    rank_1_go = { path = "rank/bg/rank_1", type = "GameObject" },
    rank_2_go = { path = "rank/bg/rank_2", type = "GameObject" },
    rank_3_go = { path = "rank/bg/rank_3", type = "GameObject" },
    rank_go   = { path = "rank/bg/rank", type = "GameObject" },

    head = { path = "name/head_icon/head", type = "RawImage" },
    frame = { path = "name/head_icon/frame", type = "Image" },
    text_name = { path = "name/text_name", type = "Text" },
    text_point = { path = "point", type = "Text" },

    hero_list_go = { path = "hero_list", type = "GameObject" },
}

function YJSYZGuildRankingPanelRankItem.New()
    local obj = {}
    setmetatable(obj, YJSYZGuildRankingPanelRankItem)
    return obj
end

function YJSYZGuildRankingPanelRankItem:Init()
    UITool.Parse(self.gameObject, self, objs)

    self.hero_item_list = {}
    for i = 1, 6 do
        local hero_tr = self.hero_list_go.transform:Find("hero_" .. i)
        if hero_tr ~= nil then
            local item = {
                gameObject = hero_tr.gameObject,
                icon = hero_tr:Find("icon"):GetComponent("RawImage"),
                rare = hero_tr:Find("icon/rare"):GetComponent("Image"),
                job = hero_tr:Find("zz"):GetComponent("Image"),
            }
            table.insert(self.hero_item_list, item)
        end
    end
end

function YJSYZGuildRankingPanelRankItem:SetData(d)
    local data = d.data

    self.text_rank.text = tostring(data.rank or 0)
    self.text_name.text = tostring(data.name or "")
    self.text_point.text = tostring(data.point or 0)

    self.rank_1_go:SetActive(data.rank == 1)
    self.rank_2_go:SetActive(data.rank == 2)
    self.rank_3_go:SetActive(data.rank == 3)
    self.rank_go:SetActive(data.rank ~= 1 and data.rank ~= 2 and data.rank ~= 3)

    local avatarData = ConfigHelper.GetAvatarFrame(data.avatarid) or ConfigHelper.GetAvatarFrame("SCJ101")
    self.head.texture = LuaMgr.GetTexture(ConfigHelper.GetHeadIconPath(avatarData.img, avatarData.imgId))
    PlayerAvatarFrameTool.SetAvatarFrame(self.frame, data.avatarframeid or "20001")
    self.frame:SetNativeSize()

    local hero_list = data.hero_list or {}
    for i = 1, 6 do
        local item = self.hero_item_list[i]
        local hero_id = hero_list[i]

        if item ~= nil and item.gameObject ~= nil then
            if hero_id == nil or hero_id == "" then
                item.gameObject:SetActive(false)
            else
                local hero_cfg = ConfigMgr.Config.characterTable[hero_id]
                if hero_cfg == nil then
                    item.gameObject:SetActive(false)
                else
                    item.gameObject:SetActive(true)
                    item.icon.texture = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(hero_id))
                    item.rare.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_" .. tostring(hero_cfg.rare))
                    item.job.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. tostring(hero_cfg.job))
                end
            end
        end
    end
end

function YJSYZGuildRankingPanelRankItem:Clear()
    PlayerAvatarFrameTool.ClearImage(self.frame)
end

function YJSYZGuildRankingPanelRankItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.frame)
    LuaMgr.DestroyImmediateGO(self.gameObject)
end