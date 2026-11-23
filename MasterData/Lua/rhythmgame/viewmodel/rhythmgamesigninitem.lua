RhythmGameSignInItem = {};

RhythmGameSignInItem.__index = RhythmGameSignInItem;

local objs = {
    received = { path = "Received", type = "GameObject" },
    now = { path = "Now", type = "GameObject" },
    nowReceiveBtn = { path = "Receive", type = "Button" },
    nowReceiveGo = { path = "Receive", type = "GameObject" },
    after = { path = "After", type = "GameObject" },
    day = { path = "Day", type = "Text" },
    goodsTF = { path = "Goods", type = "RectTransform" },
    goodsCG = { path = "Goods", type = "CanvasGroup" },
    receivedMask = { path = "ReceivedMask", type = "GameObject" },
}

function RhythmGameSignInItem.New()
    local self = {};
    setmetatable(self, RhythmGameSignInItem);
    return self;
end

function RhythmGameSignInItem:Init()
    self.itemList = {}
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickReceive = function()
        DataExHelper.EX_GetAward(self.data.config.id, function(_result)
            LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameSignReceive);
        end)
    end
    LuaMgr.AddClick(self.nowReceiveBtn, self.OnClickReceive);
end

function RhythmGameSignInItem:SetData(data)
    self.data = data.data;
    self.day.text = self.data.index
    if (self.data.data ~= nil) then
        SetActive(self.now, self.data.data.state == 2);
        SetActive(self.nowReceiveGo, self.data.data.state == 2);
        SetActive(self.after, self.data.data.state == 1);
        local mask = self.data.data.state == 3        
        SetActive(self.receivedMask, mask)
        if(mask)then
            self.goodsCG.alpha = 0.6
        else
            self.goodsCG.alpha = 1
        end       
    else
        SetActive(self.after, true);
        SetActive(self.now, false);
        SetActive(self.receivedMask, false)
        SetActive(self.nowReceiveGo, false);       
    end
    self:SetItemList()
end

function RhythmGameSignInItem:SetItemList()
    local scale = Vector3(0.85, 0.85, 0.85);
    local rewards = self.data.config.reward;
    local itemMap = ConfigMgr.Config.itemMap;
    local len = #rewards;
    for i = 1, len do
        local item = self.itemList[i];
        if (item == nil) then
            item = GoodsDataItem.New(self.goodsTF);
            self.itemList[i] = item;
        end
        local itemData = table.Copy(itemMap[rewards[i].id]);
        itemData.count0 = rewards[i].count;
        item:SetData(i, itemData, 1, false, scale,false);
    end
end

function RhythmGameSignInItem:Clear()
    self.data = nil;
end

function RhythmGameSignInItem:Destroy()
    if (self.OnClickReceive ~= nil) then
        LuaMgr.RemoveClick(self.nowReceiveBtn, self.OnClickReceive);
        self.OnClickReceive = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end