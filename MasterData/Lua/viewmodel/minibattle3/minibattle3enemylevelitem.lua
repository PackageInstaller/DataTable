MiniBattle3EnemyLevelItem = {};

MiniBattle3EnemyLevelItem.__index = MiniBattle3EnemyLevelItem;

local objs = {
    AnimatorObj = {path = "Anim",type = "GameObject"},
    ClickBtn = { path = "Anim/Group", type = "UIButtonClick" },
    Nametxt = { path = "Anim/Group/LevelName", type = "Text" },
    NormalGo = { path = "Anim/Group/Normal", type = "GameObject" },
    SelectGo = { path = "Anim/Group/Select", type = "GameObject" },
    RewardListRect = { path = "Anim/Group/Reward", type = "RectTransform" },
    LockGo = { path = "Anim/Group/Lock", type = "GameObject" },
    LockTips = { path = "Anim/Group/Lock/Text", type = "Text" },
    LockBtn = { path = "Anim/Group/Lock", type = "UIButtonClick" },
    CanGetGo = { path = "Anim/Group/CanGet", type = "GameObject" },
}

function MiniBattle3EnemyLevelItem.New(obj)
    local self = {};
    setmetatable(self, MiniBattle3EnemyLevelItem);
    self.gameObject = obj
    return self;
end

function MiniBattle3EnemyLevelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClickCommand = function()
        if self.data.onClick ~= nil then
            self.data.onClick(self.data);
        end
    end
    LuaMgr.AddClick(self.ClickBtn, self.onClickCommand);
    LuaMgr.AddClick(self.LockBtn, self.onClickCommand);
    SetActive(self.AnimatorObj, false)
end

function MiniBattle3EnemyLevelItem:SetData(pdata)
    self.data = pdata.data
    self.Nametxt.text = self.data.name
    self.LockTips.text = self.data.lockTips
    SetActive(self.SelectGo, self.data.isSelect)
    SetActive(self.LockGo, self.data.isLock)
    SetActive(self.CanGetGo, self.data.status == 0)

    if self.rewardList == nil then
        self.rewardList = {}
    end
    local itemCount = 0
    if not IsNull(self.data.reward) then
        itemCount = #self.data.reward
        local itemConfig = nil
        for i = 1, itemCount do
            if #self.rewardList < i then
                table.insert(self.rewardList, MiniBattle3BuffRewardItem.New(self.RewardListRect, self.data.goodsItem))
            end
            itemConfig = table.Copy(ConfigMgr.Config.itemMap[self.data.reward[i].id])
            itemConfig["count0"] = self.data.reward[i].count
            local itemData = {
                index = i,
                itemConfig = itemConfig,
                status = self.data.status
            }
            self.rewardList[i]:SetData(itemData)
        end
    end
    for i = itemCount + 1, #self.rewardList do
        self.rewardList[i]:Hide()
    end

    if self.data.animBool then

        SetActive(self.AnimatorObj,true)
    end
    SetActive(self.gameObject, true)
end

function MiniBattle3EnemyLevelItem:Hide()
    SetActive(self.gameObject, false)
end

function MiniBattle3EnemyLevelItem:Clear()
    self.data = nil
    SetActive(self.AnimatorObj,false)
end

function MiniBattle3EnemyLevelItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    if (self.onClickCommand ~= nil) then
        LuaMgr.RemoveClick(self.ClickBtn, self.onClickCommand)
        LuaMgr.RemoveClick(self.LockBtn, self.onClickCommand)
        self.onClickCommand = nil
    end
    if not TableIsNull(self.rewardList) then
        for i = 1, #self.rewardList do
            self.rewardList[i]:Clear()
        end
        self.rewardList = nil
    end
    self.gameObject = nil
end 