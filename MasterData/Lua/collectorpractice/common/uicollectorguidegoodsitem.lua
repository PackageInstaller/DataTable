UICollectorGuideGoodsItem = {}

UICollectorGuideGoodsItem.__index = UICollectorGuideGoodsItem


function UICollectorGuideGoodsItem.New(prefab, parent)
    local self = {}
    setmetatable(self, UICollectorGuideGoodsItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.uiGoodsItem = uiLink:Get("uiGoodsItem"):GetComponent("GoodsViewModel");
    return self
end

function UICollectorGuideGoodsItem:Destroy()
    self.gameObject = nil
    self.transform = nil
    self.uiGoodsItem = nil;
end

function UICollectorGuideGoodsItem:SetData(itemId, itemCount)
    SetActive(self.gameObject,true);
    self.uiGoodsItem:SetData(itemId, itemCount, 1, 1, true)
end

function UICollectorGuideGoodsItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end

function UICollectorGuideGoodsItem:Hide()
    SetActive(self.gameObject, false)
end