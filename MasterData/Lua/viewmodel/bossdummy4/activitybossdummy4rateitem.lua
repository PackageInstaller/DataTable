ActivityBossDummy4RateItem = {}

ActivityBossDummy4RateItem.__index = ActivityBossDummy4RateItem

local objs = {
    status_1_go = { path = "status_1", type = "GameObject" },
    text_rate_1 = { path = "status_1/text_rate", type = "Text" },

    status_2_go = { path = "status_2", type = "GameObject" },
    text_rate_2 = { path = "status_2/text_rate", type = "Text" },
    text_delay = { path = "status_2/text_delay", type = "Text" },
    text_unlock_go = { path = "status_2/text_unlock", type = "GameObject" },

    status_3_go = { path = "status_3", type = "GameObject" },
    text_rate_3 = { path = "status_3/text_rate", type = "Text" },

    choose_go = { path = "choose", type = "GameObject" },
}

function ActivityBossDummy4RateItem.New()
    local obj = {}
    setmetatable(obj, ActivityBossDummy4RateItem)
    return obj
end

function ActivityBossDummy4RateItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function ActivityBossDummy4RateItem:SetData(d)
    local data = d.data
    self.config = data.config
    self.status = data.status
    self.callback = data.callback

    self.is_click = false
    self.lockTips = ""

    if self.status == 1 then
        self.status_1_go:SetActive(true)
        self.status_2_go:SetActive(false)
        self.status_3_go:SetActive(false)
        self.text_rate_1.text = LuaMgr.GetLangText(self.config.OptionDescLan)

    elseif self.status == 2 then
        self.status_1_go:SetActive(false)
        self.status_2_go:SetActive(true)
        self.status_3_go:SetActive(false)
        self.text_rate_2.text = LuaMgr.GetLangText(self.config.OptionDescLan)
        if data.islock then
            self.text_unlock_go:SetActive(true)
            self.text_delay.text = ""
            self.lockTips = LuaMgr.GetLangText("ActivityBossDummy4RateItem_0")
        elseif self.config.Delay > 0 then
            self.text_unlock_go:SetActive(false)
            local delayTips = BossDummy3Mgr.GetDelayTimeText(self.config.Delay)
            self.text_delay.text = delayTips
            self.lockTips = delayTips
        end

    elseif self.status == 3 then
        self.status_1_go:SetActive(false)
        self.status_2_go:SetActive(false)
        self.status_3_go:SetActive(true)
        self.text_rate_3.text = LuaMgr.GetLangText(self.config.OptionDescLan)

    end

    self.choose_go:SetActive(false)
    local instance = self

    local function f()
        if instance.status == 1 or instance.status == 3 then
            if instance.is_click == false then
                instance.callback(instance.config.Id)
            end
        else
            if not IsNullOrEmpty(self.lockTips) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, self.lockTips)
            end
        end
    end

    LuaMgr.RemoveClick(self.gameObject:GetComponent("Button"), f)
    LuaMgr.AddClick(self.gameObject:GetComponent("Button"), f)
end

function ActivityBossDummy4RateItem:Clear()

end

function ActivityBossDummy4RateItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
end