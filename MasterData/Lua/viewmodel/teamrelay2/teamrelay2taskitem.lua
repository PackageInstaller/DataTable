require("ViewModel/TeamRelay2/TeamRelay2RewardItem")

TeamRelay2TaskItem = {};

TeamRelay2TaskItem.__index = TeamRelay2TaskItem;

local objs = {
    animGo = { path = "Group", type = UITool.GameObject },
    descText = { path = "Group/Text", type = UITool.Text },
    rewardContainer = { path = "Group/RewardContent", type = UITool.Transform },
    ClaimableBtn = { path = "Group/Claimable", type = UITool.Button },
    ReceivedGo = { path = "Group/Received", type = UITool.GameObject },
    ProgressGo = { path = "Group/Progress", type = UITool.GameObject },
    progressTxt = { path = "Group/Progress/Text", type = UITool.Text },
}

function TeamRelay2TaskItem.New()
    local self = {};
    setmetatable(self, TeamRelay2TaskItem);
    return self;
end

function TeamRelay2TaskItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.rewardItemList = {}
    self.OnClickItem = function()
        if self.data.onClickCallBack ~= nil then
            self.data.onClickCallBack(self.data.id)
        end
    end
    LuaMgr.AddClick(self.ClaimableBtn, self.OnClickItem);
    SetActive(self.animGo, false)
end

function TeamRelay2TaskItem:SetData(pdata)
    self.data = pdata.data;
    self.descText.text = self.data.desc;
    self.progressTxt.text = self.data.progressStr;
    for i, itemData in ipairs(self.data.rewards) do
        if not self.rewardItemList[i] then
            table.insert(self.rewardItemList, TeamRelay2RewardItem.New(self.data.rewardTemplate, self.rewardContainer))
        end
        itemData.isCount = true
        itemData.isClaimed = false
        self.rewardItemList[i]:SetData(itemData)
    end
    for i = #self.data.rewards + 1, #self.rewardItemList do
        self.rewardItemList[i]:Hide()
    end
    SetActive(self.ClaimableBtn.gameObject, self.data.status == TeamRelay2Mgr.LevelStatus.CanClaim)
    SetActive(self.ReceivedGo, self.data.status == TeamRelay2Mgr.LevelStatus.Claimed)
    SetActive(self.ProgressGo, self.data.status == TeamRelay2Mgr.LevelStatus.NotCompleted or self.data.status == TeamRelay2Mgr.LevelStatus.Locked)
    SetActive(self.animGo, self.data.animBool)
end

function TeamRelay2TaskItem:Clear()
    SetActive(self.animGo, false)
    for i, v in ipairs(self.rewardItemList) do
        v:Clear()
    end
    self.data = nil;
end

function TeamRelay2TaskItem:Destroy()
    for i, v in ipairs(self.rewardItemList) do
        v:Destroy()
    end
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.ClaimableBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end