MiniBattle3BuffRewardItem = {};

MiniBattle3BuffRewardItem.__index = MiniBattle3BuffRewardItem;

local objs = {
    Goods = { path = "Goods", type = "Transform" },
    CanvasGroup = { path = "", type = "CanvasGroup" },
    Finished = { path = "Finished", type = "GameObject" },
    CanGet = { path = "CanGet", type = "GameObject" },
}

function MiniBattle3BuffRewardItem.New(container, object)
    local self = {};
    setmetatable(self, MiniBattle3BuffRewardItem);
    self.object = LuaMgr.InstantiateGO(object, container, false)
    self.transform = self.object.transform
    self.transform:SetParent(container, false)
    self.transform.anchoredPosition = Vector2.zero
    self.rectTransform = self.transform:GetComponent("RectTransform")
    UITool.Parse(self.object, self, objs)
    return self;
end

function MiniBattle3BuffRewardItem:SetData(pdata)
    self.data = pdata
    local itemConfig = nil
    if self.reward == nil then
        self.reward = GoodsDataItem.New(self.Goods)
    end
    self.reward:SetData(self.data.index, self.data.itemConfig, 1, false, Vector3.one, false)
    self.CanvasGroup.alpha = self.data.status == 2 and 0.7 or 1
    SetActive(self.Finished, self.data.status == 2)
    SetActive(self.CanGet, self.data.status == 0)
    SetActive(self.object, true)
end

function MiniBattle3BuffRewardItem:Hide()
    SetActive(self.object, false)
end

function MiniBattle3BuffRewardItem:Clear()
    if self.reward ~= nil then
        self.reward:Clear()
        self.reward = nil
    end
    self.data = nil
end

function MiniBattle3BuffRewardItem:Destroy()
    self.object = nil
end 