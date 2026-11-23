UIWeeklyRewardSLotItem = {}
UIWeeklyRewardSLotItem.__index = UIWeeklyRewardSLotItem


function UIWeeklyRewardSLotItem.New()
    local self = {}
    setmetatable(self, UIWeeklyRewardSLotItem)
    return self
end

function UIWeeklyRewardSLotItem:Init()
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.rectBG = uiLink:Get("rectBG"):GetComponent("RectTransform");
    self.textTargetCount = uiLink:Get("textTargetCount"):GetComponent("Text");
    self.btnClickReward = uiLink:Get("btnClickReward"):GetComponent("Button");
    self.goReceivedReward = uiLink:Get("goReceivedReward");
    self.goLockReward = uiLink:Get("goLockReward");
    self.goGoodsItem = uiLink:Get("goGoodsItem"):GetComponent("GoodsViewModel");
    uiLink:AddClickEvent("btnClickReward", function()
        self.fun();
    end);
    return self
end

function UIWeeklyRewardSLotItem:Destroy()
    self.gameObject = nil
    self.transform = nil
    self.rectBG = nil;
    self.textTargetCount = nil;
    self.btnClickReward = nil;
    self.goReceivedReward = nil;
    self.goLockReward = nil;
    self.goGoodsItem = nil;
end





function UIWeeklyRewardSLotItem:SetData(data)
    local trueData=data.data;
    SetActive(self.gameObject, true);
    SetActive(self.goReceivedReward,trueData.isReceived);
    SetActive(self.goLockReward,trueData.isLock);
    if not (trueData.isReceived or trueData.isLock) then
        self.rectBG.anchoredPosition=Vector2(0,10);
    else
        self.rectBG.anchoredPosition=Vector2(0,0);
    end
    self.fun=trueData.fun;
    self.textTargetCount.text=tostring(trueData.targetCount);
    self.goGoodsItem:SetData(tostring(trueData.itemId),tonumber(trueData.count), 1, 1, true,true);
end

function UIWeeklyRewardSLotItem:Hide()
    SetActive(self.gameObject, false);
end

function UIWeeklyRewardSLotItem:Clear()
    SetActive(self.gameObject, false);
end