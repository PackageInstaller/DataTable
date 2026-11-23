CrisisContract4TaskItem = {};

CrisisContract4TaskItem.__index = CrisisContract4TaskItem;

local objs = {
    bg_1 = { path = "Group/Bg1", type = "GameObject" },
    bg_2 = { path = "Group/Bg2", type = "GameObject" },
    mask = { path = "Group/Mask", type = "GameObject" },
    rewardContent = { path = "Group/RewardScrollView/Viewport/Content", type = "Transform" },
    RewardItemTemp = { path = "Group/RewardScrollView/Viewport/Content/RewardItem", type = "GameObject" },
    score = { path = "Group/Desc/Score/ScoreText", type = "Text" },
    canGetBtn = { path = "Group/BtnGroup/CanGetBtn", type = "Button" },
    progressBtn = { path = "Group/BtnGroup/ProgressBtn", type = "Button" },
    finishedBtn = { path = "Group/BtnGroup/FinishedBtn", type = "Button" },
    animatorObj = { path = "Group", type = "GameObject" },
}

function CrisisContract4TaskItem.New()
    local self = {};
    setmetatable(self, CrisisContract4TaskItem);
    return self;
end

function CrisisContract4TaskItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.canGetBtn, function()
        if self.data.callBack ~= nil then
            self.data.callBack(self.data.index);
        end
    end);
    LuaMgr.AddClick(self.progressBtn, function()
        if self.data.callBack ~= nil then
            self.data.callBack(self.data.index);
        end
    end);
    LuaMgr.AddClick(self.finishedBtn, function()
        if self.data.callBack ~= nil then
            self.data.callBack(self.data.index);
        end
    end);
    SetActive(self.RewardItemTemp, false)
    self.rewardItemTrList = {}
    SetActive(self.animatorObj, false)
end

function CrisisContract4TaskItem:SetData(pdata)
    self.data = pdata.data
    if self.data.animBool then

        SetActive(self.animatorObj, true)
    end
    SetActive(self.bg_1, self.data.isCanGet)
    SetActive(self.bg_2, self.data.isProgress or self.data.isFinish)
    SetActive(self.mask, self.data.isFinish)
    SetActive(self.canGetBtn.gameObject, self.data.isCanGet)
    SetActive(self.progressBtn.gameObject, self.data.isProgress)
    SetActive(self.finishedBtn.gameObject, self.data.isFinish)
    self.score.text = tostring(self.data.target)
    
    local index = 1
    for i, v in ipairs(self.data.rewardList) do
        local goodsItem = nil
        if self.rewardItemTrList[i] == nil then
            local obj = LuaMgr.InstantiateGO(self.RewardItemTemp, self.rewardContent, false)
            SetActive(obj, true)
            self.rewardItemTrList[i] = GoodsDataItem.New(obj.transform:Find("GoodsItem"))
            self.rewardItemTrList[i].FinishedObj = obj.transform:Find("Finished").gameObject
        end
        SetActive(self.rewardItemTrList[i].gameObject, true)
        local itemConfig = ConfigMgr.Config.itemMap[v.id]
        itemConfig["count0"] = v.count
        self.rewardItemTrList[i]:SetData(1, itemConfig, 1, false, Vector3(0.5, 0.5, 0.5), false)
        SetActive(self.rewardItemTrList[i].FinishedObj, self.data.isFinish)
        index = index + 1
    end
    for i = index, #self.rewardItemTrList do
        self.rewardItemTrList[i]:Hide()
        SetActive(self.rewardItemTrList[i].FinishedObj, false)
    end
    SetActive(self.gameObject, true)
end

function CrisisContract4TaskItem:Hide()
    SetActive(self.gameObject, false)
end

function CrisisContract4TaskItem:Clear()
    for i, v in ipairs(self.rewardItemTrList) do
        v:Hide()
    end
    LuaMgr.RemoveTimer(TimerConst.CrisisContract2TaskItemShow + self.data.index)
    self.data = nil
    SetActive(self.animatorObj, false)
end

function CrisisContract4TaskItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.bg_1 = nil
    self.bg_2 = nil
    self.mask = nil
    self.desc = nil
    self.rewardContent = nil
    self.canGetBtn = nil
    self.progressBtn = nil
    self.finishedBtn = nil
end