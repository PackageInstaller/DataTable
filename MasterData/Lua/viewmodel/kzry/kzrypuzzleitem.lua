KZRYPuzzleItem = {};

KZRYPuzzleItem.__index = KZRYPuzzleItem;

local objs = {
    groupBtn = { path = "Group", type = "Button" },
    unlock = { path = "Group/Unlock", type = "Image" },
    lock = { path = "Group/Lock", type = "Image" },
    lockNum = { path = "Group/Lock/TextNum", type = "Text" },
    imgName = { path = "Group/ImgName", type = "Image" },
    rewardBox = { path = "Group/RewardBox", type = "Transform" },
};

function KZRYPuzzleItem.New()
    local self = {};
    setmetatable(self, KZRYPuzzleItem);
    return self;
end

function KZRYPuzzleItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self:InitRewardBox()
    self.OnClickItem = function()
        if (self.isFinish and self.callback ~= nil) then
            self.callback(self.data.group)
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function KZRYPuzzleItem:SetData(data)
    self.data = data.data.config;
    self.callback = data.data.callback
    self.isFinish = true
    local isLock = false
    local quest = self.data.questList[1]
    local finishNum, maxNum = KZRYMgr.GetEventsProByGroup(self.data.group.id);
    self.isFinish = finishNum >= maxNum;
    if (self.isFinish) then
        local name = string.format("ui_hd_kz_zx_jw_pic0%s_%s", quest.parameter, 1)
        self.unlock.sprite = LuaMgr.GetSprite("KZRY", name);
        isLock = false;
    else
        local name = string.format("ui_hd_kz_zx_jw_pic0%s_%s", quest.parameter, 0)
        self.lock.sprite = LuaMgr.GetSprite("KZRY", name);
        self.lockNum.text = string.format("<size=30><color=#ffffff>%s</color></size>/%s", finishNum, maxNum)
        isLock = true;
    end
    SetActive(self.unlock.gameObject, not isLock);
    SetActive(self.lock.gameObject, isLock);
    local imgName = string.format("ui_hd_kz_zx_gk_st%s_%s", quest.parameter, isLock and "0" or "1")
    self.imgName.sprite = LuaMgr.GetSprite("KZRY", imgName);
    self:RefreshRewardBox()
end

function KZRYPuzzleItem:InitRewardBox()
    self.rewardBoxList = {}
    self.rewardItems = {}
    for i = 1, self.rewardBox.childCount do
        local cache = {}
        local reward = self.rewardBox:GetChild(i - 1);
        cache.obj = reward;
        cache.boxBtn = reward:Find("boxBtn"):GetComponent("Button");
        cache.boxTras = reward:Find("boxTras")
        cache.ImgLineR = reward:Find("ImgLineR"):GetComponent("Image");
        cache.ImgGet = reward:Find("ImgGet").gameObject;
        cache.ImgRed = reward:Find("ImgRed").gameObject;
        cache.TextParam = reward:Find("TextParam"):GetComponent("Text");
        table.insert(self.rewardBoxList, cache);
    end
end

function KZRYPuzzleItem:RefreshRewardBox()
    if (self.rewardItems ~= nil) then
        for k, v in pairs(self.rewardItems) do
            v:Hide();
        end
    end
    for key, value in ipairs(self.data.questList) do
        local cacheBox = self.rewardBoxList[key];
        if (self.rewardItems[key] == nil) then
            self.rewardItems[key] = GoodsDataItem.New(cacheBox.boxTras);
        end
        local rewardObj = self.rewardItems[key]
        local itemData = table.Copy(ConfigMgr.Config.itemMap[value.reward[1].id]);
        itemData.count0 = value.reward[1].count
        rewardObj:SetData(1, itemData, 1, false, Vector3(0.45, 0.45, 0.45), false);
        local state = DataExHelper.Check_RewardState(value.id);
        cacheBox.ImgRed:SetActive(false);
        cacheBox.ImgGet:SetActive(false);
        cacheBox.TextParam.text = value.progress
        SetActive(cacheBox.boxBtn.gameObject, false)
        cacheBox.boxBtn.onClick:RemoveAllListeners();
        if (state ~= nil and state > 1) then
            cacheBox.ImgLineR.color = UnityEngine.Color(1, 1, 1, 1)
            if (state == 2) then
                cacheBox.ImgRed:SetActive(true);
                SetActive(cacheBox.boxBtn.gameObject, true)
                LuaMgr.AddClick(cacheBox.boxBtn, function()

                    DataExHelper.EX_GetAward(value.id, function(_result)
                        LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameQuestReceive);
                    end)
                end)
            elseif (state == 3) then
                cacheBox.ImgGet:SetActive(true);
            end
        else
            cacheBox.ImgLineR.color = UnityEngine.Color(59 / 255, 70 / 255, 1, 1)
        end
    end
end

function KZRYPuzzleItem:Clear()
    self.data = nil;
end

function KZRYPuzzleItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end