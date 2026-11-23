
RhythmGameChapterItem = {};

RhythmGameChapterItem.__index = RhythmGameChapterItem;

RhythmGameChapterItem.addWidth = 0;


local objs = {
    pos1GO = { path = "Pos1", type = "GameObject" },
    pos1TF = { path = "Pos1", type = "Transform" },
    pos2GO = { path = "Pos2", type = "GameObject" },
    pos2TF = { path = "Pos2", type = "Transform" },
    line1 = { path = "Pos1/ImageLine1", type = "GameObject" },
    line2 = { path = "Pos2/ImageLine2", type = "GameObject" },
    boxChapterItem = { path = "BoxChapterItem", type = "Transform" },
    icon = { path = "BoxChapterItem/ImgBgChapterIcon", type = "RawImage" },
    iconGO = { path = "BoxChapterItem/ImgBgChapterItem", type = "GameObject" },
    imgIcon = { path = "BoxChapterItem/ImgBgChapterItem/ImgTitle/ImgIcon", type = "Image" },
    textName = { path = "BoxChapterItem/ImgBgChapterItem/ImgTitle/Name", type = "Text" },
    textNameGO = { path = "BoxChapterItem/ImgBgChapterItem/ImgTitle/Name", type = "GameObject" },
    rewards = { path = "BoxChapterItem/ImgBgChapterItem/Rewards", type = "Transform" },
    lockGO = { path = "BoxChapterItem/ImgBgChapterItemLock", type = "GameObject" },
    btn = { path = "BoxChapterItem/BtnChapterItem", type = "Button" },
    redIconListener = { path = "BoxChapterItem/ImgBgChapterItem/RedBox", type = "RedIconListener" },
    ImglockEffect = { path = "BoxChapterItem/eff_ChapterItem_unlock", type = "GameObject" },
}

function RhythmGameChapterItem.New()
    local self = {};
    setmetatable(self, RhythmGameChapterItem);
    return self;
end

function RhythmGameChapterItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    SetActive(self.ImglockEffect, false)
    self.OnClickBtn = function()
        if(self.data.playerData == nil)then
            local unlockName = ConfigRhythmGameMgr.GetUnlockName(self.data.config.unlockParam)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("10754"), unlockName));
        else    
            local refresh = PlayerRhythmGameMgr.UpdateChapterNewDotData(self.config.id)
            if(refresh)then
                PlayerRhythmGameMgr.CheckChapterNewDot()
                RedMgr.Singleton:Refresh()
            end      
            local isMask = PlayerRhythmGameMgr.GetIsDiscMask()
            local recodeData = DataMgr.Player.dungeonRecords[self.config.eventParam]
            local rating = nil
            if(recodeData ~= nil)then
                rating = recodeData.historyRating               
            end              
            if(isMask and rating == "S")then
                local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
                enterDungeonParams.eventId = self.data.config.id;
                enterDungeonParams.dungeonId = self.data.config.eventParam;
                BattlePrepareMgr.BattlePrepare(enterDungeonParams);
            else
                LuaMgr.ShowLuaPanel(UIName.RhythmGameChapterBuffViewModel, self.data);
            end            
        end         
    end
    self.itemList = {};
    LuaMgr.AddClick(self.btn, self.OnClickBtn);
end

function RhythmGameChapterItem:SetData(data)
    self.data = data.data
    self.config = data.data.config   
    local str = "12018_".. self.config.id
    if(#self.redIconListener.RedId ~= 0 and self.redIconListener.RedId ~= str)then      
        self.redIconListener.RedId = str
        RedMgr.Singleton:Refresh()
    else
        self.redIconListener.RedId = str
    end
    self.textName.text = LuaMgr.GetLangText(self.config.namelan)
    local recodeData = DataMgr.Player.dungeonRecords[self.config.eventParam]
    if(recodeData ~= nil)then
        local rating = recodeData.historyRating
        self.imgIcon.sprite = LuaMgr.GetSprite("RhythmGame",ConfigRhythmGameMgr.GetJudgeImg(rating));
    else
        self.imgIcon.sprite = LuaMgr.GetSprite("RhythmGame",ConfigRhythmGameMgr.GetJudgeImg(nil));
    end     
    SetActive(self.line1,not self.data.isLast)
    SetActive(self.line2,not self.data.isLast)
    local itemTexture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/RhythmGame/%s.png", self.config.cover))   
    if(itemTexture ~= nil)then
        self.icon.texture = itemTexture
    else

        LuaDebug.error(str)
    end   
    self:SetPos(self.data.index % 2)   
    self:HideItemList()
    self:SetItemList()
    if (PlayerRhythmGameMgr.CheckChapterShownById(self.data.config.unlockParam)) then
        if self.startDelay ~= nil then
            coroutine_runner.stop(self.startDelay)
        end
        self.startDelay = coroutine_runner.start(function()
            self:IsMask(true) 
            coroutine_runner.wait(0.9)
            SetActive(self.ImglockEffect, true)
            coroutine_runner.wait(0.45)
            self:IsMask(false) 
            coroutine_runner.wait(0.55)            
            SetActive(self.ImglockEffect, false)
        end)
        return
    end   
    self:IsMask(self.data.playerData == nil) 
end

function RhythmGameChapterItem:SetItemList()
    local scale = Vector3(0.6, 0.6, 0.6);
    local dungeonConfig = ConfigMgr.Config.dungeonMap[self.config.eventParam]

    local tempList = NumTool.split(dungeonConfig.firstDropShow, ';')   
    local itemMap = ConfigMgr.Config.itemMap;
    local len = #tempList;
    for i = 1, len do
        if(i > 3)then break end
        local item = self.itemList[i];
        if (item == nil) then
            item = GoodsDataItem.New(self.rewards);

            self.itemList[i] = item;

        end
        local itemData = table.Copy(itemMap[tempList[i]]);

        item:SetData(i, itemData, 1, false, scale,false,true);
    end
end

function RhythmGameChapterItem:HideItemList()
    local len = #self.itemList;
    for i = 1, len do
        self.itemList[i]:Hide();
    end
end

function RhythmGameChapterItem:ClearItemList()
    local len = #self.itemList;
    for i = 1, len do
        self.itemList[i]:Clear();
    end
    self.itemList = nil;
end

function RhythmGameChapterItem:SetPos(_pos)
    SetActive(self.pos1GO, _pos == 0)
    SetActive(self.pos2GO, _pos ~= 0)
    if (_pos == 0) then
        self.boxChapterItem.localPosition = self.pos1TF.localPosition
    else      
        self.boxChapterItem.localPosition = self.pos2TF.localPosition
    end
end

function RhythmGameChapterItem:IsMask(_bMask)
    SetActive(self.iconGO, not _bMask)
    SetActive(self.lockGO, _bMask)
end

function RhythmGameChapterItem:Clear()
    self.data = nil;
    if (not coroutine_runner.checkIsDestory()) and self.startDelay ~= nil then
        coroutine_runner.stop(self.startDelay);
        self.startDelay = nil;
    end
end

function RhythmGameChapterItem:Destroy()
    if (self.OnClickBtn ~= nil) then
        LuaMgr.RemoveClick(self.btn, self.OnClickBtn);
        self.OnClickBtn = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self:ClearItemList()
    self.gameObject = nil;
end