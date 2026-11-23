
RhythmGameChapterBigItem = {};

RhythmGameChapterBigItem.__index = RhythmGameChapterBigItem;

RhythmGameChapterBigItem.addWidth = 0;


local objs = {
    imgBgBigChapter = { path = "ImgBgBigChapter", type = "RawImage" },
    imgBigChapterLock = { path = "ImgBigChapterLock", type = "GameObject" },
    btn = { path = "BtnBigChapter", type = "Button" },
    redIconListener = { path = "RewardsBox/RedBox", type = "RedIconListener" },
    rewardsBox = { path = "RewardsBox", type = "GameObject" },
    rewardsBoxBg1 = { path = "RewardsBox/RewardsBoxBg1", type = "GameObject" },
    rewardsBoxBg2 = { path = "RewardsBox/RewardsBoxBg2", type = "GameObject" },
    imgIcon = { path = "RewardsBox/ImgIcon", type = "Image" },
    rewards = { path = "RewardsBox/Rewards", type = "Transform" },
    textName = { path = "RewardsBox/TextName", type = "Text" },
    ImglockEffect = { path = "eff_BigChapterItem_unlock", type = "GameObject" },
}

function RhythmGameChapterBigItem.New()
    local self = {};
    setmetatable(self, RhythmGameChapterBigItem);
    return self;
end

function RhythmGameChapterBigItem:Init()
    self.itemList = {}
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickBtn = function()
        if (self.data.playerData == nil) then
            local unlockName = ConfigRhythmGameMgr.GetUnlockName(self.data.config.unlockParam)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("10754"), unlockName));
        else
            local refresh = PlayerRhythmGameMgr.UpdateChapterNewDotData(self.config.id)
            if (refresh) then
                PlayerRhythmGameMgr.CheckChapterNewDot()
                RedMgr.Singleton:Refresh()
            end
            local isMask = PlayerRhythmGameMgr.GetIsDiscMask()
            local recodeData = DataMgr.Player.dungeonRecords[self.config.eventParam]
            local rating = nil
            if (recodeData ~= nil) then
                rating = recodeData.historyRating
            end
            if (isMask and rating == "S") then
                local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
                enterDungeonParams.eventId = self.data.config.id;
                enterDungeonParams.dungeonId = self.data.config.eventParam;
                BattlePrepareMgr.BattlePrepare(enterDungeonParams);
            else
                LuaMgr.ShowLuaPanel(UIName.RhythmGameChapterBuffViewModel, self.data);
            end
        end
    end
    LuaMgr.AddClick(self.btn, self.OnClickBtn);
end

function RhythmGameChapterBigItem:SetData(data)
    self.data = data.data
    self.index = self.data.index
    self.config = data.data.config
    self.redIconListener.RedId = "12018_" .. self.config.id
    local itemTexture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/RhythmGame/%s.png",
self.config.cover))
    if (itemTexture ~= nil) then
        self.imgBgBigChapter.texture = itemTexture
    end
    SetActive(self.rewardsBoxBg1, self.index == 1)
    SetActive(self.rewardsBoxBg2, self.index ~= 1)
    local recodeData = DataMgr.Player.dungeonRecords[self.config.eventParam]
    if (recodeData ~= nil) then
        local rating = recodeData.historyRating
        self.imgIcon.sprite = LuaMgr.GetSprite("RhythmGame", ConfigRhythmGameMgr.GetJudgeImg(rating));
    else
        self.imgIcon.sprite = LuaMgr.GetSprite("RhythmGame", ConfigRhythmGameMgr.GetJudgeImg(nil));
    end
    self.textName.text = LuaMgr.GetLangText(self.config.namelan)
    self:HideItemList()
    self:SetItemList()
    if (PlayerRhythmGameMgr.CheckChapterShownById(self.data.config.unlockParam)) then
        if self.startDelay ~= nil then
            coroutine_runner.stop(self.startDelay)
        end
        self.startDelay = coroutine_runner.start(function()
            SetActive(self.imgBigChapterLock, true)
            SetActive(self.rewardsBox, false)
            coroutine_runner.wait(0.9)
            SetActive(self.ImglockEffect, true)
            coroutine_runner.wait(0.45)
            SetActive(self.imgBigChapterLock, false)
            SetActive(self.rewardsBox, true)
            coroutine_runner.wait(0.55)
            SetActive(self.ImglockEffect, false)
        end)
        return
    end   
    local lock = self.data.playerData == nil
    SetActive(self.imgBigChapterLock, lock)
    SetActive(self.rewardsBox, not lock)
end

function RhythmGameChapterBigItem:SetItemList()
    local scale = Vector3(0.6, 0.6, 0.6);
    local dungeonConfig = ConfigMgr.Config.dungeonMap[self.config.eventParam]

    local tempList = NumTool.split(dungeonConfig.firstDropShow, ';')
    local itemMap = ConfigMgr.Config.itemMap;
    local len = #tempList;
    for i = 1, len do
        if (i > 3) then break end
        local item = self.itemList[i];
        if (item == nil) then
            item = GoodsDataItem.New(self.rewards);
            self.itemList[i] = item;
        end
        local itemData = table.Copy(itemMap[tempList[i]]);
        item:SetData(i, itemData, 1, false, scale, false, true);
    end
end

function RhythmGameChapterBigItem:HideItemList()
    local len = #self.itemList;
    for i = 1, len do
        self.itemList[i]:Hide();
    end
end

function RhythmGameChapterBigItem:ClearItemList()
    local len = #self.itemList;
    for i = 1, len do
        self.itemList[i]:Clear();
    end
    self.itemList = nil;
end

function RhythmGameChapterBigItem:Clear()
    self.data = nil;
    if (not coroutine_runner.checkIsDestory()) and self.startDelay ~= nil then
        coroutine_runner.stop(self.startDelay);
        self.startDelay = nil;
    end
end

function RhythmGameChapterBigItem:Destroy()
    if (self.OnClickBtn ~= nil) then
        LuaMgr.RemoveClick(self.btn, self.OnClickBtn);
        self.OnClickBtn = nil;
    end
    self:ClearItemList()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end