MiniBattle5BuffRewardItem = {};

MiniBattle5BuffRewardItem.__index = MiniBattle5BuffRewardItem;

local objs = {
    Goods = { path = "Goods", type = "Transform" },
    CanvasGroup = { path = "", type = "CanvasGroup" },
    Finished = { path = "Finished", type = "GameObject" },
}

function MiniBattle5BuffRewardItem.New(container, object)
    local self = {};
    setmetatable(self, MiniBattle5BuffRewardItem);
    self.object = LuaMgr.InstantiateGO(object, container, false)
    self.transform = self.object.transform
    self.transform:SetParent(container, false)
    self.transform.anchoredPosition = Vector2.zero
    self.rectTransform = self.transform:GetComponent("RectTransform")
    UITool.Parse(self.object, self, objs)
    return self;
end

function MiniBattle5BuffRewardItem:SetData(pdata)
    self.data = pdata
    local itemConfig = nil
    if self.reward == nil then
        self.reward = GoodsDataItem.New(self.Goods)
    end
    self.reward:SetData(self.data.index, self.data.itemConfig, 1, false, Vector3.one, false)
    self.CanvasGroup.alpha = self.data.isFinish and 0.7 or 1
    SetActive(self.Finished, self.data.isFinish)
    SetActive(self.object, true)
end

function MiniBattle5BuffRewardItem:Hide()
    SetActive(self.object, false)
end

function MiniBattle5BuffRewardItem:Clear()
    if self.reward ~= nil then
        self.reward:Clear()
        self.reward = nil
    end
    self.data = nil
end

function MiniBattle5BuffRewardItem:Destroy()
    self.object = nil
end 