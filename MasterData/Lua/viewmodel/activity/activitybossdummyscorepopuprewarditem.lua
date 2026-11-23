ActivityBossDummyScorePopupRewardItem = {}

ActivityBossDummyScorePopupRewardItem.__index = ActivityBossDummyScorePopupRewardItem

local objs = 
{
    info_text       = {path = "textDesc", type = "Text"},
    reward_1_obj    = {path = "group/reward_1", type = "GameObject"},
    reward_2_obj    = {path = "group/reward_2", type = "GameObject"},
    reward_3_obj    = {path = "group/reward_3", type = "GameObject"},
    status_1_obj    = {path = "status_1", type = "GameObject"},
    status_2_obj    = {path = "status_2", type = "GameObject"},
    status_3_obj    = {path = "status_3", type = "GameObject"},
}

function ActivityBossDummyScorePopupRewardItem.New()
    local obj = {}
    setmetatable(obj, ActivityBossDummyScorePopupRewardItem)
    return obj
end

function ActivityBossDummyScorePopupRewardItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function ActivityBossDummyScorePopupRewardItem:SetData(d)
    local data = d.data
    local config = data.config

    self.info_text.text = string.format(LuaMgr.GetLangText("ActivityBossDummyScorePopupRewardItem_0"), tostring(config.Credit))

    self.status_1_obj:SetActive(false)
    self.status_2_obj:SetActive(false)
    self.status_3_obj:SetActive(false)

    self["status_" .. tostring(data.status) .. "_obj"]:SetActive(true)

    if data.status == 2 then
        local btn = self.status_2_obj.transform:Find("btn").gameObject:GetComponent("Button")
        local c = config
        local callback = data.callback
        local onclick = function ()
            callback(c)
        end
        btn.onClick:RemoveAllListeners()
        LuaMgr.AddClick(btn, onclick)
    end

    for i = 1, 3 do
        self["reward_" .. tostring(i) .. "_obj"]:SetActive(false)
    end

    for i, v in ipairs(config.Reward) do
        local obj = self["reward_" .. tostring(i) .. "_obj"]
        obj:SetActive(true)
        obj.transform:Find("rare"):GetComponent("Image").sprite     = ConfigHelper.GetRareSprite(ConfigMgr.Config.itemMap[tostring(v.id)].rare)
        obj.transform:Find("item"):GetComponent("RawImage").texture = ConfigHelper.GetItemTexture(tostring(v.id))
        obj.transform:Find("count"):GetComponent("Text").text       = v.count

        local btn = obj:GetComponent("Button")
        local id = v.id .. ""
        local onclick = function ()
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, id, false, false, false, 0);
        end
        btn.onClick:RemoveAllListeners()
        LuaMgr.AddClick(btn, onclick)
    end
end

function ActivityBossDummyScorePopupRewardItem:Clear()

end

function ActivityBossDummyScorePopupRewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
end