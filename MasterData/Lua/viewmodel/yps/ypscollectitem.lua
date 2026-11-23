PackUpCollectItem = {};

PackUpCollectItem.__index = PackUpCollectItem;

local objs = {
    rewardBox = { path = "Bg/Reward", type = "Transform" },
    btnGet = { path = "Bg/ButtonGet", type = "Button" },
    btnFinishGo = { path = "Bg/ButtonFinish", type = "GameObject" },
    textPecent = { path = "Bg/Image/TextPecent", type = "Text" },
}

function PackUpCollectItem.New()
    local self = {};
    setmetatable(self, PackUpCollectItem);
    return self;
end

function PackUpCollectItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.itemReward = GoodsDataItem.New(self.rewardBox);
    self.BtnGetOnClick = function()
        if (self.callback) then
            self.callback();
        end
    end
    LuaMgr.AddClick(self.btnGet, self.BtnGetOnClick);
end

function PackUpCollectItem:SetData(pdata)
    local cache = pdata.data
    local scale = Vector3(1, 1, 1);
    local reward = cache.config.UnClock[1]
    local itemData = table.Copy(ConfigMgr.Config.itemMap[reward.id]);
    local item = DataMgr.Player.items[reward.id]
    self.itemReward:SetData(1, itemData, 1, false, scale, nil, true);
    local str = LuaMgr.GetLangText(itemData.nameLan)
    if (item) then
        str = string.format("%s：<color=ffffff>%s</color>", str, item.count0)
    else
        str = string.format("%s：<color=ffffff>%s</color>", str, 0)
    end
    self.textPecent.text = str
    SetActive(self.itemReward.gameObject, true)
    local isFinish = cache.finish == 1
    SetActive(self.btnGet.gameObject, not isFinish and cache.canGet)
    SetActive(self.btnFinishGo, isFinish)
    SetActive(self.gameObject, true)
    self.callback = cache.callBack
end

function PackUpCollectItem:Hide()
    SetActive(self.gameObject, false)
end

function PackUpCollectItem:Clear()
    self.data = nil
end

function PackUpCollectItem:Destroy()
    if (self.BtnGetOnClick ~= nil) then
        LuaMgr.RemoveClick(self.btnGet, self.BtnGetOnClick);
        self.BtnGetOnClick = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
end