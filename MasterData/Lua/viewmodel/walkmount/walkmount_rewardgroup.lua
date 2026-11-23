WalkMount_RewardGroup = {};

WalkMount_RewardGroup.__index = WalkMount_RewardGroup;
require("ViewModel/WalkMount/WalkMount_RewardItem")
local objs = {
    textTitle={ path = "title/name", type = "Text" },
    content = { path = "content", type = "Transform" },
}

function WalkMount_RewardGroup.New()
    local self = {};
    setmetatable(self, WalkMount_RewardGroup);
    return self;
end

function WalkMount_RewardGroup:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.contentList=UIListView.New(self.content)
end

function WalkMount_RewardGroup:SetData(pdata)
    self.data = pdata;
    self.textTitle.text=tostring(pdata.data.title);
    local content=pdata.data.content
    local itemObj=pdata.data.rewardItemObj;
    local itemList={}
    for i,v in ipairs(content) do
        local isRe=self.CheckReward(pdata.data.type,v)
        local rewardItem={
            id=v,
            isRewarded=isRe,
        }
        local rewardData=UIListData.GetData(itemObj,"WalkMount_RewardItem",rewardItem);
        table.insert(itemList,rewardData);
    end
    self.contentList:SetData(itemList)
end

function WalkMount_RewardGroup.CheckReward(type,rewardId)
    local dataLottery=DataMgr.Player.lottery;
    if(dataLottery==nil or dataLottery[type]==nil) then return true end;
    local rewards=dataLottery[type];
    for i,v in ipairs(rewards) do
        if(v==rewardId) then
            return false;
        end
    end
    return true;
end


function WalkMount_RewardGroup:Clear()
    self.data = nil;
end

function WalkMount_RewardGroup:Destroy()
    self.textTitle=nil;
    self.content=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end