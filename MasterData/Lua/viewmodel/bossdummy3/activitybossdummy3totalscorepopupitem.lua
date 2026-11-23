ActivityBossDummy3TotalScorePopupItem = {}

ActivityBossDummy3TotalScorePopupItem.__index = ActivityBossDummy3TotalScorePopupItem

local objs = 
{
    status_1_go             = { path = "status_1", type = "GameObject" },
    status_1_text_desc      = { path = "status_1/text_desc", type = "Text" },
    status_1_text_progress  = { path = "status_1/Image/Text", type = "Text" },
    status_1_btn            = { path = "status_1/Image", type = "Button" },
    
    status_2_go             = { path = "status_2", type = "GameObject" },
    status_2_text_desc      = { path = "status_2/text_desc", type = "Text" },
    status_2_btn            = { path = "status_2/btn", type = "Button" },

    status_3_go             = { path = "status_3", type = "GameObject" },
    status_3_text_desc      = { path = "status_3/text_desc", type = "Text" },

    reward_1_go             = { path = "group/reward_1", type = "GameObject" },
    reward_2_go             = { path = "group/reward_2", type = "GameObject" },
    reward_3_go             = { path = "group/reward_3", type = "GameObject" },
}

function ActivityBossDummy3TotalScorePopupItem.New()
    local obj = {}
    setmetatable(obj, ActivityBossDummy3TotalScorePopupItem)
    return obj
end

function ActivityBossDummy3TotalScorePopupItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function ActivityBossDummy3TotalScorePopupItem:SetData(d)
    local data = d.data
    local config = data.config
    local callback = data.callback

    local progress = BossDummy3Mgr.GetBossDummy3TotalScore()

    self.status_1_go:SetActive(false)
    self.status_2_go:SetActive(false)
    self.status_3_go:SetActive(false)

    if data.status == 1 then
        self.status_1_go:SetActive(true)
        self.status_1_text_desc.text = LuaMgr.GetLangText("ActivityBossDummy3TotalScorePopupItem_0") .. tostring(data.score)
        self.status_1_text_progress.text = string.format("<color=#FFFFFF>%s</color>/<color=#262429>%s</color>", data.progress, data.score)

        local function f()
            callback(data)
        end
        LuaMgr.AddClick(self.status_1_btn, f)
    elseif data.status == 2 then
        self.status_2_go:SetActive(true)
        self.status_2_text_desc.text = LuaMgr.GetLangText("ActivityBossDummy3TotalScorePopupItem_1") .. tostring(data.score)

        local function f()
            callback(data)
        end
        LuaMgr.RemoveClick(self.status_2_btn, f)
        LuaMgr.AddClick(self.status_2_btn, f)

    elseif data.status == 3 then
        self.status_3_go:SetActive(true)
        self.status_3_text_desc.text = LuaMgr.GetLangText("ActivityBossDummy3TotalScorePopupItem_2") .. tostring(data.score)
        
    end

    self.reward_1_go:SetActive(false)
    self.reward_2_go:SetActive(false)
    self.reward_3_go:SetActive(false)
    for i = 1, #data.reward, 1 do
        if i > 3 then
            break
        end
        local go = self["reward_" .. i .. "_go"]
        go:SetActive(true)

        local item = ConfigMgr.Config.itemMap[data.reward[i].id]
        go.transform:Find("rare"):GetComponent("Image").sprite      = LuaMgr.GetSprite("ItemRare", "itemRare" ..item.rare)
        go.transform:Find("item"):GetComponent("RawImage").texture  = LuaMgr.GetTexture("Images/ItemIcons/itemicon_" .. data.reward[i].id ..".png")
        go.transform:Find("count"):GetComponent("Text").text        = tostring(data.reward[i].count)

        local id = data.reward[i].id
        local function b()
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, id, false, false, false, 0)
        end
        LuaMgr.RemoveClick(go:GetComponent("Button"), b)
        LuaMgr.AddClick(go:GetComponent("Button"), b)
    end
end

function ActivityBossDummy3TotalScorePopupItem:Clear()

end

function ActivityBossDummy3TotalScorePopupItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
end