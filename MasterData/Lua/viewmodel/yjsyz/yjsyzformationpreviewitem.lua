YJSYZFormationPreviewItem = {}
YJSYZFormationPreviewItem.__index = YJSYZFormationPreviewItem

local objs = {
    text_team = { path = "text_team", type = "Text" },
    text_point = { path = "text_point", type = "Text" },
    buff_icon = { path = "buff/icon", type = "Image" },
    hero_list_go = { path = "hero_list", type = "GameObject" },
}

function YJSYZFormationPreviewItem.New()
    local self = {}
    setmetatable(self, YJSYZFormationPreviewItem)
    return self
end

function YJSYZFormationPreviewItem:Init()
    UITool.Parse(self.gameObject, self, objs)

    self.hero_item_list = {}
    for i = 1, 6 do
        local hero_tr = self.hero_list_go.transform:Find("hero_item_" .. i)
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

function YJSYZFormationPreviewItem:SetData(d)
    self.data = d.data
    self.text_team.text = LuaMgr.GetLangText("YJSYZFormationPreviewItem_0") .. tostring(self.data.index or 0) .. LuaMgr.GetLangText("YJSYZFormationPreviewItem_1")
    self.text_point.text = LuaMgr.GetLangText("YJSYZFormationPreviewItem_2") .. tostring(self.data.score or 0)
    if self.data.buff_id ~= nil then
        local buff_config = ConfigMgr.Config.buffMap[tostring(self.data.buff_id)]
        if buff_config ~= nil and buff_config.BuffIcon ~= nil then
            self.buff_icon.sprite = LuaMgr.GetSprite("BuffIcon", buff_config.BuffIcon)
        end
    end

    local hero_list = self.data.hero_list or {}
    for i = 1, 6 do
        local item = self.hero_item_list[i]

        if item ~= nil and item.gameObject ~= nil then
            if hero_list == nil or i > #hero_list then
                item.gameObject:SetActive(false)
            else
                local hero_id = hero_list[i]
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
end

function YJSYZFormationPreviewItem:Clear()
    self.data = nil
end

function YJSYZFormationPreviewItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
end