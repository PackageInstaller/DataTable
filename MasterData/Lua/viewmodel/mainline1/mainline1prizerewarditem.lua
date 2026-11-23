MainLine1PrizeRewardItem = {};

require("ViewModel/MainLine1/MainLine1PrizeGoodItem")

MainLine1PrizeRewardItem.__index = MainLine1PrizeRewardItem;

local objs = {   
    content = { path = "content", type = "Transform" },
    transform = { path = "", type = "Transform" }
}

function MainLine1PrizeRewardItem.New()
    local self = {};
    setmetatable(self, MainLine1PrizeRewardItem);
    return self;
end

function MainLine1PrizeRewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function MainLine1PrizeRewardItem:SetData(pdata)
    self.data = pdata.data;   
    self.goodsUIList = UIListView.New(self.content)
    local len = math.ceil(#self.data.dataList / 5)
    self.transform.sizeDelta = Vector2(491, len * 110 + 10);
    local list = {}
    for i, v in ipairs(self.data.dataList) do
        local rewardItem = {
            index = i,
            drawData = v,
            showType1 = self.data.showType1,
        }
        local rewardData = UIListData.GetData(self.data.goodItemObj, "MainLine1PrizeGoodItem", rewardItem)
        table.insert(list, rewardData);
    end
    self.goodsUIList:SetData(list);
end

function MainLine1PrizeRewardItem:Clear()
    self.data = nil;
    self.goodsUIList:Clear();   
end

function MainLine1PrizeRewardItem:Destroy()   
    self.content = nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end