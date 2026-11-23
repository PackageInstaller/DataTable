RewardPreviewPopup_RewardItem = {}

RewardPreviewPopup_RewardItem.__index = RewardPreviewPopup_RewardItem

local objs = 
{



    goods_view_model = {path = "", type = "GoodsViewModel"}
}

function RewardPreviewPopup_RewardItem.New()
    local obj = {}
    setmetatable(obj, RewardPreviewPopup_RewardItem)
    return obj
end

function RewardPreviewPopup_RewardItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function RewardPreviewPopup_RewardItem:SetData(d)
    local data = d.data


    self.goods_view_model:SetData(data.id, tonumber(data.count), 1, 0.40625, true)




end

function RewardPreviewPopup_RewardItem:Clear()

end

function RewardPreviewPopup_RewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil
end