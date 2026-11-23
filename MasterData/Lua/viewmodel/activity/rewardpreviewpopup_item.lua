RewardPreviewPopup_Item = {}

RewardPreviewPopup_Item.__index = RewardPreviewPopup_Item

local objs = 
{
    rank_text           = {path = "info_text", type = "Text"},
    current_rank_obj    = {path = "Image_1", type = "GameObject"},
    rank_1_obj          = {path = "group/rank_1", type = "GameObject"},
    rank_2_obj          = {path = "group/rank_2", type = "GameObject"},
    rank_3_obj          = {path = "group/rank_3", type = "GameObject"},
    rank_other_obj      = {path = "group/rank_other", type = "GameObject"},
}

function RewardPreviewPopup_Item.New()
    local obj = {}
    setmetatable(obj, RewardPreviewPopup_Item)
    return obj
end

function RewardPreviewPopup_Item:Init()
    UITool.Parse(self.gameObject, self, objs)

    self.listView   = UIListView.New(self.gameObject.transform:Find("Content").gameObject.transform)
    self.itemObj    = self.gameObject.transform:Find("template/reward_item").gameObject
end

function RewardPreviewPopup_Item:SetData(d)
    local data = d.data

    if data.rank == 1 then
        self.rank_1_obj:SetActive(true)
        self.rank_2_obj:SetActive(false)
        self.rank_3_obj:SetActive(false)
        self.rank_other_obj:SetActive(false)
    elseif data.rank == 2 then
        self.rank_1_obj:SetActive(false)
        self.rank_2_obj:SetActive(true)
        self.rank_3_obj:SetActive(false)
        self.rank_other_obj:SetActive(false)
    elseif data.rank == 3 then
        self.rank_1_obj:SetActive(false)
        self.rank_2_obj:SetActive(false)
        self.rank_3_obj:SetActive(true)
        self.rank_other_obj:SetActive(false)
    else
        self.rank_1_obj:SetActive(false)
        self.rank_2_obj:SetActive(false)
        self.rank_3_obj:SetActive(false)
        self.rank_other_obj:SetActive(true)
    end

    self.rank_text.text = tostring(data.rank_text)
    if data.is_current then
        self.current_rank_obj:SetActive(true)
    else
        self.current_rank_obj:SetActive(false)
    end

    self.listView:Clear(true)
    local data_list = {}

    for _, v in ipairs(data.reward_data) do
        local data = UIListData.GetData(self.itemObj, "RewardPreviewPopup_RewardItem", v);
        table.insert(data_list, data)
    end

    self.listView:SetData(data_list, true)
end

function RewardPreviewPopup_Item:Clear()
    self.listView:Clear()
end

function RewardPreviewPopup_Item:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    UIListView.ClearItem("RewardPreviewPopup_RewardItem")
    self.gameObject         = nil
    self.rank_text          = nil
    self.current_rank_obj   = nil
    self.rank_1_obj         = nil
    self.rank_2_obj         = nil
    self.rank_3_obj         = nil
    self.rank_other_obj     = nil
end