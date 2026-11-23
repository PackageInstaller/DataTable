ActivityBossDummy3DifficultyItem = {}

ActivityBossDummy3DifficultyItem.__index = ActivityBossDummy3DifficultyItem

local objs = 
{
    reward_item_1_go        = { path = "reward_item_1", type = "GameObject"},
    reward_item_1_rare      = { path = "reward_item_1/status_1/rare", type = "Image"},
    reward_item_1_icon      = { path = "reward_item_1/status_1/icon", type = "RawImage"},
    reward_item_1_count     = { path = "reward_item_1/status_1/count", type = "Text"},
    reward_item_1_mask_go   = { path = "reward_item_1/Mask", type = "GameObject"},

    reward_item_2_go        = { path = "reward_item_2", type = "GameObject"},
    reward_item_2_rare      = { path = "reward_item_2/status_1/rare", type = "Image"},
    reward_item_2_icon      = { path = "reward_item_2/status_1/icon", type = "RawImage"},
    reward_item_2_count     = { path = "reward_item_2/status_1/count", type = "Text"},
    reward_item_2_mask_go   = { path = "reward_item_2/Mask", type = "GameObject"},

    reward_item_3_go        = { path = "reward_item_3", type = "GameObject"},
    reward_item_3_rare      = { path = "reward_item_3/status_1/rare", type = "Image"},
    reward_item_3_icon      = { path = "reward_item_3/status_1/icon", type = "RawImage"},
    reward_item_3_count     = { path = "reward_item_3/status_1/count", type = "Text"},
    reward_item_3_mask_go   = { path = "reward_item_3/Mask", type = "GameObject"},

    status_1_go             = { path = "status_1", type = "GameObject" },
    status_1_klq_go         = { path = "klq_img", type = "GameObject" },
    status_2_go             = { path = "status_2", type = "GameObject" },
    status_3_go             = { path = "status_3", type = "GameObject" },

    choose_go               = { path = "choose", type = "GameObject" },
}

function ActivityBossDummy3DifficultyItem.New()
    local obj = {}
    setmetatable(obj, ActivityBossDummy3DifficultyItem)
    return obj
end

function ActivityBossDummy3DifficultyItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function ActivityBossDummy3DifficultyItem:SetData(d)
    local data              = d.data
    local status            = data.status
    local config            = data.config
    local click_callback    = data.click_callback
    local receive_callback  = data.receive_callback
    local instance          = self

    self.config         = config
    self.is_can_receive = false
    self.is_click       = false
    self.status         = data.status

    self.choose_go:SetActive(false)
    self.reward_item_1_go:SetActive(false)
    self.reward_item_2_go:SetActive(false)
    self.reward_item_3_go:SetActive(false)
    self.status_1_go:SetActive(false)
    self.status_2_go:SetActive(false)
    self.status_3_go:SetActive(false)

    local function a1()
        if 1 <= #config.Reward then
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, config.Reward[1].id, false, false, false, 0)
        end
    end

    local function a2()
        if 1 <= #config.Reward then
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, config.Reward[2].id, false, false, false, 0)
        end
    end

    local function a3()
        if 1 <= #config.Reward then
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, config.Reward[3].id, false, false, false, 0)
        end
    end

    local function f()
        if instance.is_can_receive then
            receive_callback(instance.config.Id)
        else
            if instance.is_click == false then
                if instance.status == 1 or instance.status == 2 then
                    click_callback(instance.config.Id)
                else
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, BossDummy3Mgr.GetDelayTimeText(instance.config.Delay))
                end
            end
        end
    end

    LuaMgr.RemoveClick(self.reward_item_1_go:GetComponent("Button"), a1)
    LuaMgr.RemoveClick(self.reward_item_2_go:GetComponent("Button"), a2)
    LuaMgr.RemoveClick(self.reward_item_3_go:GetComponent("Button"), a3)
    LuaMgr.RemoveClick(self.gameObject:GetComponent("Button"), f)
    

    for i = 1, 3 do
        if i <= #config.Reward then
            local e = config.Reward[i]
            local item = ConfigMgr.Config.itemMap[e.id]
            self["reward_item_" .. i .. "_go"]:SetActive(true)
            self["reward_item_" .. i .. "_rare"].sprite     = LuaMgr.GetSprite("ItemRare", "itemRare" ..item.rare)
            self["reward_item_" .. i .. "_icon"].texture    = LuaMgr.GetTexture("Images/ItemIcons/itemicon_" .. e.id ..".png")
            self["reward_item_" .. i .. "_count"].text      = tostring(e.count)
        else
            self["reward_item_" .. i .. "_go"]:SetActive(false)
        end
    end

    if status == 1 then
        self.status_1_go:SetActive(true)
        self.status_1_go.transform:Find("level_img/text_level").gameObject:GetComponent("Text").text = LuaMgr.GetLangText(config.OptionDescLan)
        if data.is_can_receive then
            self.is_can_receive = true
            self.status_1_klq_go:SetActive(true)
        else
            self.status_1_klq_go:SetActive(false)
        end
        self.reward_item_1_mask_go:SetActive(false)
        self.reward_item_2_mask_go:SetActive(false)
        self.reward_item_3_mask_go:SetActive(false)

    elseif status == 2 then
        self.status_2_go:SetActive(true)
        self.status_2_go.transform:Find("level_img/text_level").gameObject:GetComponent("Text").text = LuaMgr.GetLangText(config.OptionDescLan)
        self.status_1_klq_go:SetActive(false)
        
        self.reward_item_1_mask_go:SetActive(true)
        self.reward_item_2_mask_go:SetActive(true)
        self.reward_item_3_mask_go:SetActive(true)
        
    elseif status == 3 then
        self.status_3_go:SetActive(true)
        self.status_3_go.transform:Find("level_img/text_level").gameObject:GetComponent("Text").text    = LuaMgr.GetLangText(config.OptionDescLan)
        self.status_3_go.transform:Find("text_close").gameObject:GetComponent("Text").text              = BossDummy3Mgr.GetDelayTimeText(config.Delay)
        self.status_1_klq_go:SetActive(false)

        self.reward_item_1_mask_go:SetActive(false)
        self.reward_item_2_mask_go:SetActive(false)
        self.reward_item_3_mask_go:SetActive(false)
    end

    LuaMgr.AddClick(self.gameObject:GetComponent("Button"), f)
    if self.status == 1 or self.status == 3 then
        LuaMgr.AddClick(self.reward_item_1_go:GetComponent("Button"), a1)
        LuaMgr.AddClick(self.reward_item_2_go:GetComponent("Button"), a2)
        LuaMgr.AddClick(self.reward_item_3_go:GetComponent("Button"), a3)
    end
end

function ActivityBossDummy3DifficultyItem:Clear()

end

function ActivityBossDummy3DifficultyItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
end