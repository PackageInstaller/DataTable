
RhythmGameChapterMusicItem = {};

RhythmGameChapterMusicItem.__index = RhythmGameChapterMusicItem;

RhythmGameChapterMusicItem.addWidth = 0;


local objs = {
    redIconListener = { path = "Normal/Redbox", type = "RedIconListener" },
    btn = { path = "Normal/Button", type = "Button" },
    imgBg1 = { path = "Normal/ImgBg1", type = "GameObject" },
    imgIcon1 = { path = "Normal/ImgBg1/ImgIcon", type = "Image" },
    imgBg2 = { path = "Normal/ImgBg2", type = "GameObject" },
    imgIcon2 = { path = "Normal/ImgBg2/ImgIcon", type = "Image" },
    nameText = { path = "Normal/Name", type = "Text" },
    imglock = { path = "Normal/Imglock", type = "GameObject" },
    ImglockEffect = { path = "Normal/eff_musicitem", type = "GameObject" },
}

function RhythmGameChapterMusicItem.New()
    local self = {};
    setmetatable(self, RhythmGameChapterMusicItem);
    return self;
end

function RhythmGameChapterMusicItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    SetActive(self.ImglockEffect, false)
    self.OnClickBtn = function()
        if(self.data == nil)then return end
        if (self.data.playerData == nil) then
            local unlockName = ConfigRhythmGameMgr.GetUnlockName(self.data.config.unlockParam)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("10754"), unlockName));
        else
            local refresh = PlayerRhythmGameMgr.UpdateChapterNewDotData(self.config.id)
            if (refresh) then
                PlayerRhythmGameMgr.CheckChapterNewDot()
                RedMgr.Singleton:Refresh()
            end
            if (self.config.type == 2) then
                local isMask = PlayerRhythmGameMgr.GetIsDiscMask()
                local recodeData = DataMgr.Player.dungeonRecords[self.config.eventParam]
                local rating = nil
                if (recodeData ~= nil) then
                    rating = recodeData.historyRating
                end
                if (isMask and rating == "S") then
                    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
                    enterDungeonParams.eventId = self.config.id;
                    enterDungeonParams.dungeonId = self.config.eventParam;
                    BattlePrepareMgr.BattlePrepare(enterDungeonParams);
                else
                    LuaMgr.ShowLuaPanel(UIName.RhythmGameChapterBuffViewModel, self.data);
                end
            else

                LuaMgr.PlayNovel2(self.config.id, self.config.eventParam, function()
                    LuaMgr.Back();

                end)
            end
        end
    end
    LuaMgr.AddClick(self.btn, self.OnClickBtn);
end

function RhythmGameChapterMusicItem:SetData(data)
    self.data = data.data
    self.config = data.data.config
    local str = "12018_" .. self.config.id
    if (#self.redIconListener.RedId ~= 0 and self.redIconListener.RedId ~= str) then
        self.redIconListener.RedId = str
        RedMgr.Singleton:Refresh()
    else
        self.redIconListener.RedId = str
    end
    local bLock = self.data.playerData == nil

    if (not bLock) then
        self.nameText.text = LuaMgr.GetLangText(self.config.namelan)
        if (self.config.type == 2) then
            local recodeData = DataMgr.Player.dungeonRecords[self.config.eventParam]
            if (recodeData ~= nil) then
                local rating = recodeData.historyRating
                self.imgIcon1.sprite = LuaMgr.GetSprite("RhythmGame", ConfigRhythmGameMgr.GetJudgeImg(rating));
            else
                self.imgIcon1.sprite = LuaMgr.GetSprite("RhythmGame", ConfigRhythmGameMgr.GetJudgeImg(nil));
            end
        else
            local bRead = PlayerRhythmGameMgr.GetState(self.config.eventParam)
            self.imgIcon2.sprite = LuaMgr.GetSprite("RhythmGame", ConfigRhythmGameMgr.GetHasLookImg(bRead));
        end
    end
    self.gameObject.name = "MusicItem_"..self.config.id
    if (PlayerRhythmGameMgr.CheckChapterShownById(self.data.config.unlockParam)) then
        if self.startDelay ~= nil then
            coroutine_runner.stop(self.startDelay)
        end
        self.startDelay = coroutine_runner.start(function()

            self:SetBg(true, self.config.type)
            coroutine_runner.wait(0.9)
            SetActive(self.ImglockEffect, true)
            coroutine_runner.wait(0.45)
            self:SetBg(false, self.config.type)
            coroutine_runner.wait(0.55)
            SetActive(self.ImglockEffect, false)
        end)
        return
    end
    self:SetBg(bLock, self.config.type)  
    return
end

function RhythmGameChapterMusicItem:SetBg(_bMask, _type)
    SetActive(self.imgBg1, not _bMask and _type == 2)
    SetActive(self.imgBg2, not _bMask and _type == 1)
    SetActive(self.imglock, _bMask)
    SetActive(self.redIconListener.gameObject,not _bMask)
end

function RhythmGameChapterMusicItem:Clear()
    self.data = nil;
    if (not coroutine_runner.checkIsDestory()) and self.startDelay ~= nil then
        coroutine_runner.stop(self.startDelay);
        self.startDelay = nil;
    end
end

function RhythmGameChapterMusicItem:Destroy()
    if (self.OnClickBtn ~= nil) then
        LuaMgr.RemoveClick(self.btn, self.OnClickBtn);
        self.OnClickBtn = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end