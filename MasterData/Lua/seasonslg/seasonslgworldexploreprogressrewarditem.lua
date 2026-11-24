SeasonSLGWorldExploreProgressRewardItem = {};

SeasonSLGWorldExploreProgressRewardItem.__index = SeasonSLGWorldExploreProgressRewardItem;

local objs = {
    desc = { path = "desc", type = "Text" },
    seasonName= {path = "sName",type = "Text"},
    rewardedObj = { path = "rewarded", type = "GameObject" },
    progressObj = { path = "progress", type = "GameObject" },
    progress = { path = "progress/Text", type = "Text" },
    getBtn = { path = "Button", type = "Button" },
    rewardList = { path = "rewards", type = "Transform" },
    rewardTemp = {path = "temp/GoodsDataItem",type = "GameObject"}
}
local rewarded = false
function SeasonSLGWorldExploreProgressRewardItem.New()
    local self = {};
    setmetatable(self, SeasonSLGWorldExploreProgressRewardItem);
    self.goodsItems = {};
    return self;
end

function SeasonSLGWorldExploreProgressRewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClick = function()
        if self.data.onClick ~= nil then
            self.data.onClick(self.data.targetProgress)
        end
    end
    LuaMgr.AddClick(self.getBtn,self.OnClick)
end

function SeasonSLGWorldExploreProgressRewardItem:SetData(data)
    self.data = data.data;
    if self.data == nil then
        return
    end

    local curShowProgress = self.data.currentProgress >= self.data.targetProgress and self.data.targetProgress or self.data.currentProgress
    self.progress.text = string.format("<color=#cf64c9>%s</color>/%s",tostring(curShowProgress / 100.0) .. "%",tostring(self.data.targetProgress / 100) .. "%")
    local progress = self.data.currentProgress
    rewarded = DataMgr.Player.SeasonalRewardRecords["progress_" .. tostring(self.data.targetProgress)]

    self.desc.text = string.format(LuaMgr.GetLangText("SeasonSLGWorldExploreProgressRewardItem_0"),tostring(self.data.targetProgress / 100) .. "%")
    self.seasonName.text = string.format("<color=#eae3c0>【%s】</color>",LuaMgr.GetLangText(SeasonSLGMapMgr.curSeasonal.NameLan))
    SetActive(self.getBtn.gameObject,false)
    SetActive(self.progressObj,false)
    SetActive(self.rewardedObj,false)
    if rewarded == nil then
        if  progress >= self.data.targetProgress then
            SetActive(self.getBtn.gameObject,true)
        else
            SetActive(self.progressObj,true)
        end
    else
        SetActive(self.rewardedObj,true)
        self.desc.text = string.format(LuaMgr.GetLangText("SeasonSLGWorldExploreProgressRewardItem_1"),tostring(self.data.targetProgress / 100) .. "%")
        self.seasonName.text = string.format("<color=#957cb7>【%s】</color>",SeasonSLGMapMgr.curSeasonal.NameLan)
    end
    self:SetRewards()
    SetActive(self.gameObject, true)
end

function SeasonSLGWorldExploreProgressRewardItem:OnClick()
    if self.data.onClick ~= nil then
        self.data.onClick(self.data.targetProgress)
    end
end

function SeasonSLGWorldExploreProgressRewardItem:SetRewards()
    if self.rewardList == nil then
        return
    end

    for i, v in pairs(self.data.item.Reward) do
        local itemId = v.id
        local count = v.count
        local itemConfig = ConfigMgr.Config.itemMap[itemId]
        if itemConfig ~= nil then
            if self.goodsItems[i] == nil then
                self.goodsItems[i] = GoodsDataItem.New(self.rewardList,self.rewardTemp)
                self.goodsItems[i].tag = self.goodsItems[i].object.transform:Find("get").gameObject
            end
            local itemData = table.Copy(itemConfig)
            itemData.count0 = count
            self.goodsItems[i]:SetData(i, itemData, 1, false, Vector3(1, 1, 1), false)
            self.goodsItems[i]:SetCount(nil, Vector2(-17, 17), Vector3.one)
            self.goodsItems[i]:SetIconBg(false)
            SetActive(self.goodsItems[i].tag,rewarded)
        end
    end

    for i = #self.data.item.Reward + 1, #self.goodsItems do
        self.goodsItems[i]:Hide()
    end
end

function SeasonSLGWorldExploreProgressRewardItem:Clear()
    self.data = nil;
    if self.goodsItems ~= nil then
        for i = 1, #self.goodsItems do
            self.goodsItems[i]:Hide();
        end
    end
    SetActive(self.gameObject, false);
end

function SeasonSLGWorldExploreProgressRewardItem:Destroy()
    if self.goodsItems ~= nil then
        for i = 1, #self.goodsItems do
            self.goodsItems[i]:Clear();
        end
        self.goodsItems = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    LuaMgr.RemoveClick(self.getBtn,self.OnClick)
end