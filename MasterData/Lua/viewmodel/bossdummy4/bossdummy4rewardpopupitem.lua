BossDummy4RewardPopupItem = {}

BossDummy4RewardPopupItem.__index = BossDummy4RewardPopupItem

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

function BossDummy4RewardPopupItem.New()
    local obj = {}
    setmetatable(obj, BossDummy4RewardPopupItem)
    return obj
end

function BossDummy4RewardPopupItem:Init()
    UITool.Parse(self.gameObject, self, objs)

    self.OnClickItem = function()
        if self.callback ~= nil then
            self.callback(self.data)
        end
    end
    self.OnClickRewardItem_1 = function()
        LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, self.data.reward[1].id, false, false, false, 0)
    end
    self.OnClickRewardItem_2 = function()
        LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, self.data.reward[2].id, false, false, false, 0)
    end
    self.OnClickRewardItem_3 = function()
        LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, self.data.reward[3].id, false, false, false, 0)
    end
    LuaMgr.AddClick(self.status_1_btn, self.OnClickItem)
    LuaMgr.AddClick(self.status_2_btn, self.OnClickItem)
    LuaMgr.AddClick(self.reward_1_go:GetComponent("Button"), self.OnClickRewardItem_1)
    LuaMgr.AddClick(self.reward_2_go:GetComponent("Button"), self.OnClickRewardItem_2)
    LuaMgr.AddClick(self.reward_3_go:GetComponent("Button"), self.OnClickRewardItem_3)
end

function BossDummy4RewardPopupItem:SetData(d)
    local data = d.data
    self.data = data
    self.callback = data.callback

    local progress = BossDummy3Mgr.GetBossDummy3TotalScore()

    self.status_1_go:SetActive(false)
    self.status_2_go:SetActive(false)
    self.status_3_go:SetActive(false)

    local desc = LuaMgr.GetLangText(data.config.remarksLan)
    if data.status == 1 then
        self.status_1_go:SetActive(true)
        self.status_1_text_desc.text = desc
        self.status_1_text_progress.text = string.format("<color=#FFFFFF>%s</color>/<color=#262429>%s</color>", data.progress, data.score)
    elseif data.status == 2 then
        self.status_2_go:SetActive(true)
        self.status_2_text_desc.text = desc

    elseif data.status == 3 then
        self.status_3_go:SetActive(true)
        self.status_3_text_desc.text = desc
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
    end
end

function BossDummy4RewardPopupItem:Clear()
    self.data = nil
    self.callback = nil
end

function BossDummy4RewardPopupItem:Destroy()
    if self.OnClickItem ~= nil then
        LuaMgr.RemoveClick(self.status_1_btn, self.OnClickItem);
        LuaMgr.RemoveClick(self.status_2_btn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    if self.OnClickRewardItem_1 ~= nil then
        LuaMgr.AddClick(self.reward_1_go:GetComponent("Button"), self.OnClickRewardItem_1)
        self.OnClickRewardItem_1 = nil
    end
    if self.OnClickRewardItem_2 ~= nil then
        LuaMgr.AddClick(self.reward_2_go:GetComponent("Button"), self.OnClickRewardItem_2)
        self.OnClickRewardItem_2 = nil
    end
    if self.OnClickRewardItem_3 ~= nil then
        LuaMgr.AddClick(self.reward_3_go:GetComponent("Button"), self.OnClickRewardItem_3)
        self.OnClickRewardItem_3 = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
end