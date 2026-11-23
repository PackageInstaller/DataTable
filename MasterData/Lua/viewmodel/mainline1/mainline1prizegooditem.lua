MainLine1PrizeGoodItem = {};

MainLine1PrizeGoodItem.__index = MainLine1PrizeGoodItem;

local objs = {
    animator = { path = "", type = "Animator" },
    goods = { path = "good", type = "Transform" },
    sellOut = { path = "sellOut", type = "GameObject" },
    numText = { path = "numImg/Text", type = "Text" },
    effectObj = { path = "effectObj", type = "GameObject" },
    Image1 = { path = "numImg/Image1", type = "GameObject" },
    Image2 = { path = "numImg/Image2", type = "GameObject" },
    Image3 = { path = "numImg/Image3", type = "GameObject" },
}


function MainLine1PrizeGoodItem.New()
    local self = {};
    setmetatable(self, MainLine1PrizeGoodItem);
    return self;
end

function MainLine1PrizeGoodItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function MainLine1PrizeGoodItem:SetData(pdata)
    self.data = pdata.data
    if (self.data.drawData.Time >= 999) then
        self.numText.text = LuaMgr.GetLangText("MainLine1PrizeGoodItem_0");
    else
        self.numText.text = self.data.drawData.reCount;
    end
    SetActive(self.Image1, self.data.drawData.Type ~= 1 and self.data.showType1)
    SetActive(self.Image3, self.data.drawData.Type ~= 1 and not self.data.showType1)
    SetActive(self.Image2, self.data.drawData.Type == 1)
    SetActive(self.sellOut, self:CheckSellOut())
    if self.item == nil then
        self.item = GoodsDataItem.New(self.goods)
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.drawData.Reward[1].id]
    itemConfig["count0"] = self.data.drawData.Reward[1].count
    self.item:SetData(1, itemConfig, 1, false, Vector3(0.65, 0.65, 0.65), false)
    self:ShowEffect(false)
    self:ShowAim(self.data.index)
end

function MainLine1PrizeGoodItem:CheckSellOut()
    return self.data.drawData.reCount == 0
end

function MainLine1PrizeGoodItem:ShowEffect(show)
    SetActive(self.effectObj, show)
end

function MainLine1PrizeGoodItem:GetRewardId()
    return self.data.drawData.Reward[1].id
end

function MainLine1PrizeGoodItem:ShowAim(groupIndex)
    if (self.animator == nil) then return end
    self.coroutine = coroutine_runner.start(
        function()
            SetActive(self.animator.gameObject, false)
            coroutine_runner.wait(0.1 * (groupIndex - 1))
            SetActive(self.animator.gameObject, true)
            self.animator.enabled = false;
            self.animator.enabled = true;
            coroutine_runner.wait(3)
            self.animator.enabled = false;
            self.coroutine = nil
        end)
end

function MainLine1PrizeGoodItem:Clear()
    self.data = nil;
    if self.coroutine ~= nil then
        coroutine_runner.stop(self.coroutine);
        self.coroutine = nil;
        SetActive(self.animator.gameObject, true)
    end
end

function MainLine1PrizeGoodItem:Destroy()
    self.goods = nil;
    self.sellOut = nil;
    self.numText = nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end