YJSYZRewardPopupRewardItem = {}

YJSYZRewardPopupRewardItem.__index = YJSYZRewardPopupRewardItem

local objs =
{
    status_1_go             = { path = "status_1", type = "GameObject" },
    status_1_text_desc      = { path = "status_1/text_desc", type = "Text" },
    status_1_text_progress  = { path = "status_1/Image/Text", type = "Text" },

    status_2_go             = { path = "status_2", type = "GameObject" },
    status_2_text_desc      = { path = "status_2/text_desc", type = "Text" },
    status_2_btn            = { path = "status_2/Image", type = "Button" },

    status_3_go             = { path = "status_3", type = "GameObject" },
    status_3_on             = { path = "status_3_on", type = "GameObject" },
    status_3_text_desc      = { path = "status_3/text_desc", type = "Text" },

    reward_1_go             = { path = "group/reward_1", type = "GameObject" },
    reward_2_go             = { path = "group/reward_2", type = "GameObject" },
    reward_3_go             = { path = "group/reward_3", type = "GameObject" },
}

function YJSYZRewardPopupRewardItem.New()
    local self = {}
    setmetatable(self, YJSYZRewardPopupRewardItem)
    return self
end

function YJSYZRewardPopupRewardItem:Init()
    UITool.Parse(self.gameObject, self, objs)

    self.OnClickStatus2Btn = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.YJSYZGetAward)
    end
    self.OnClickRewardItem_1 = function()
        self:OnClickRewardItem(1)
    end
    self.OnClickRewardItem_2 = function()
        self:OnClickRewardItem(2)
    end
    self.OnClickRewardItem_3 = function()
        self:OnClickRewardItem(3)
    end

    LuaMgr.RemoveClick(self.status_2_btn, self.OnClickStatus2Btn)
    LuaMgr.RemoveClick(self.reward_1_go:GetComponent("Button"), self.OnClickRewardItem_1)
    LuaMgr.RemoveClick(self.reward_2_go:GetComponent("Button"), self.OnClickRewardItem_2)
    LuaMgr.RemoveClick(self.reward_3_go:GetComponent("Button"), self.OnClickRewardItem_3)
    LuaMgr.AddClick(self.status_2_btn, self.OnClickStatus2Btn)
    LuaMgr.AddClick(self.reward_1_go:GetComponent("Button"), self.OnClickRewardItem_1)
    LuaMgr.AddClick(self.reward_2_go:GetComponent("Button"), self.OnClickRewardItem_2)
    LuaMgr.AddClick(self.reward_3_go:GetComponent("Button"), self.OnClickRewardItem_3)
end

function YJSYZRewardPopupRewardItem:SetData(d)
    local data = d.data
    self.data = data

    self.status_1_go:SetActive(false)
    self.status_2_go:SetActive(false)
    self.status_3_go:SetActive(false)
    self.status_3_on:SetActive(false)

    local total = data.total
    local desc = ""
    if data.config ~= nil and data.config.remarksLan ~= nil then
        desc = LuaMgr.GetLangText(data.config.remarksLan)
    end

    if data.status == 1 then
        self.status_1_go:SetActive(true)
        self.status_1_text_desc.text = desc
        self.status_1_text_progress.text = tostring(data.progress or 0) .. "/" .. tostring(total)
    elseif data.status == 2 then
        self.status_2_go:SetActive(true)
        self.status_2_text_desc.text = desc
    elseif data.status == 3 then
        self.status_3_go:SetActive(true)
        self.status_3_on:SetActive(true)
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
        go.transform:Find("rare"):GetComponent("Image").sprite = LuaMgr.GetSprite("ItemRare", "itemRare" .. tostring(item.rare))
        go.transform:Find("item"):GetComponent("RawImage").texture = LuaMgr.GetTexture("Images/ItemIcons/itemicon_" .. tostring(data.reward[i].id) .. ".png")
        go.transform:Find("count"):GetComponent("Text").text = tostring(data.reward[i].count)
    end
end

function YJSYZRewardPopupRewardItem:OnClickRewardItem(index)
    if self.data == nil or self.data.reward == nil or self.data.reward[index] == nil then
        return
    end

    LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, self.data.reward[index].id, false, false, false, 0)
end

function YJSYZRewardPopupRewardItem:Clear()
    self.data = nil
end

function YJSYZRewardPopupRewardItem:Destroy()
    if self.OnClickStatus2Btn ~= nil then
        LuaMgr.RemoveClick(self.status_2_btn, self.OnClickStatus2Btn)
        self.OnClickStatus2Btn = nil
    end
    if self.OnClickRewardItem_1 ~= nil then
        LuaMgr.RemoveClick(self.reward_1_go:GetComponent("Button"), self.OnClickRewardItem_1)
        self.OnClickRewardItem_1 = nil
    end
    if self.OnClickRewardItem_2 ~= nil then
        LuaMgr.RemoveClick(self.reward_2_go:GetComponent("Button"), self.OnClickRewardItem_2)
        self.OnClickRewardItem_2 = nil
    end
    if self.OnClickRewardItem_3 ~= nil then
        LuaMgr.RemoveClick(self.reward_3_go:GetComponent("Button"), self.OnClickRewardItem_3)
        self.OnClickRewardItem_3 = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
end