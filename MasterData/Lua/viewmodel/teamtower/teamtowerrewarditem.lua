
TeamTowerRewardItem = {};

TeamTowerRewardItem.__index = TeamTowerRewardItem;



local objs = {
    desc = { path = "desc", type = "Text" },
    rewardContent = { path = "rewardContent", type = "RectTransform" },
    progress = { path = "progress", type = "Text" },
    awardStateBtn = { path = "awardStateBtn", type = "Button" },
    rewardedState = { path = "rewardedState", type = "GameObject" },
}

function TeamTowerRewardItem.New()
    local self = {};
    setmetatable(self, TeamTowerRewardItem);
    return self;
end

function TeamTowerRewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickBtn = function()
        TeamTowerMgr.GetReward({self.config.Id},self.data.success,nil)
    end
    LuaMgr.AddClick(self.awardStateBtn, self.OnClickBtn);
end

function TeamTowerRewardItem:SetData(data)
    self.data = data.data
    self.rewardState = data.data.rewardState
    self.config = data.data.config
    if self.rewardState == 0 then
        SetActive(self.awardStateBtn.gameObject,true)
        SetActive(self.rewardedState,false)
    elseif self.rewardState == 1 then
        SetActive(self.rewardedState,true)
        SetActive(self.awardStateBtn.gameObject,false)
    else

        SetActive(self.rewardedState,false)
        SetActive(self.awardStateBtn.gameObject,false)
    end
    self.desc.text = string.format(LuaMgr.GetLangText("TeamTowerRewardItem_0"),LuaMgr.GetLangText(self.config.DisplayFloorLan))

    if self.rewardList == nil then
        self.rewardList = {}
    end
    local itemCount = 0
    if not IsNull(self.config.Reward) then
        itemCount = #self.config.Reward
        for i = 1, itemCount do
            if #self.rewardList < i then
                table.insert(self.rewardList, LuaMgr.InstantiateGO(self.data.goodItem,self.rewardContent.transform, false):GetComponent("GoodsViewModel"))
            end
            SetActive(self.rewardList[i].gameObject,true)
            self.rewardList[i]:SetData(self.config.Reward[i].id,self.config.Reward[i].count,1,0.45,true)
        end
    end
    for i = itemCount + 1, #self.rewardList do
        SetActive(self.rewardList[i].gameObject,false) 
    end
    
end

function TeamTowerRewardItem:Clear()
    self.data = nil;
end

function TeamTowerRewardItem:Destroy()
    if (self.OnClickBtn ~= nil and self.btn ~= nil) then
        LuaMgr.RemoveClick(self.btn, self.OnClickBtn);
        self.OnClickBtn = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end