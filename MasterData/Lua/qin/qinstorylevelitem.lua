QinStoryLevelItem = {};

QinStoryLevelItem.__index = QinStoryLevelItem;

local pos = Vector3(0, 0, 0);

local objs = { 
    animator = { path = "", type = "Animator" },
    groupBtn = { path = "Group/Btn", type = "Button" },
    groupTF = { path = "Group", type = "Transform" },
    avgGO = { path = "Group/Avg", type = "GameObject" },
    avgReplay = { path = "Group/Avg/Replay", type = "GameObject" },
    avgNum = { path = "Group/Avg/Num", type = "Text" },
    avgName = { path = "Group/Avg/Name", type = "Text" },
    avgNew = { path = "Group/Avg/New", type = "GameObject" },
    avgLock = { path = "Group/Avg/Lock", type = "GameObject" },
    battle1GO = { path = "Group/Battle1", type = "GameObject" },
    battle1Name = { path = "Group/Battle1/Name", type = "Text" },
    battle1Count = { path = "Group/Battle1/Count", type = "GameObject" },
    battle1CountText = { path = "Group/Battle1/Count/Text", type = "Text" },
    battle1Evaluate = { path = "Group/Battle1/Evaluate", type = "GameObject" },
    battle1EvaluateImg = { path = "Group/Battle1/Evaluate/Text", type = "Image" },
    battle1ItemsGO = { path = "Group/Battle1/Items", type = "GameObject" },
    battle1ItemsTF = { path = "Group/Battle1/Items", type = "Transform" },
    battle1New = { path = "Group/Battle1/New", type = "GameObject" },
    battle1Lock = { path = "Group/Battle1/Lock", type = "GameObject" },
    battle2GO = { path = "Group/Battle2", type = "GameObject" },
    battle2Name = { path = "Group/Battle2/Name", type = "Text" },
    battle2Country = { path = "Group/Battle2/Country", type = "Image" },
    battle2Evaluate = { path = "Group/Battle2/Evaluate", type = "GameObject" },
    battle2EvaluateImg = { path = "Group/Battle2/Evaluate/Text", type = "Image" },
    battle2New = { path = "Group/Battle2/New", type = "GameObject" },
    battle2Lock = { path = "Group/Battle2/Lock", type = "GameObject" },
    battle2Frist = { path = "Group/Battle2/Frist", type = "GameObject" },
    battle2FristIcon = { path = "Group/Battle2/Frist/Icon", type = "RawImage" },
    title1 = { path = "Group/Battle2/Title", type = "GameObject" },
    title2 = { path = "Group/Battle2/Title2", type = "GameObject" },
    fxLoop = { path = "Group/Battle2/fx_loop", type = "GameObject" },
};

function QinStoryLevelItem.New()
    local self = {};    
    setmetatable(self, QinStoryLevelItem);
    return self;
end

function QinStoryLevelItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.playAnimator = true
    self.itemList = {};
    self.OnClickItem = function()
        if not DataExHelper.CommonActivityCheck(ActivityKey.daqin) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"))
            return ;
        end
        local type = self.data.type;       
        PlayerSlgMgr.UpdateChapterNewDotData(self.data.config.id)
        self:RefreshNew()
        if (type == 1) then
            if (self:IsUnlock(QinActivityType.daqinMap)) then
                LuaMgr.PlayNovel(self.data.config.eventParam, function()
                    LuaMgr.ShowLuaPanel(UIName.QinLevelStoryViewModel, 1);
                end);
            end
        elseif (type == 2) then
            if (self:IsUnlock(QinActivityType.daqinMap_normal)) then
                local stageId = DataMgr.Player.Qin.StageId;                
                if (stageId ~= "") then
                    if (stageId == self.data.config.id) then
                        PlayerQinMgr.SetPlayAudio(true)
                        LuaMgr.ShowLuaPanel(UIName.QinSurveyViewModel);
                    else
                        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("QinLevelItem_0"));
                    end
                    return;
                end
                local levelConfig = ConfigQinMgr.GetLevelConfig(self.data.config.eventParam);                
                if (levelConfig ~= nil) then                  
                    if (PlayerQinMgr.IsFastBattle()) then
                        local record = DataMgr.Player.dungeonRecords[self.data.config.eventParam];
                        if (record ~= nil and record.historyRating == "S") then
                            local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
                            enterDungeonParams.eventId = self.data.config.id;
                            enterDungeonParams.dungeonId = self.data.config.eventParam;
                            BattlePrepareMgr.BattlePrepare(enterDungeonParams);
                            return;
                        end
                    end                    
                    PlayerQinMgr.EnterStageHeroChoice(levelConfig.Id);
                end
            end
        elseif (type == 3) then
            if (self:IsUnlock(QinActivityType.daqinMap_hard)) then
                local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
                enterDungeonParams.eventId = self.data.config.id;
                enterDungeonParams.dungeonId = self.data.config.eventParam;
                BattlePrepareMgr.BattlePrepare(enterDungeonParams);
            end
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function QinStoryLevelItem:SetData(data)   
    self.data = data.data;   
    pos.y = (self.data.num % 2 == 0) and -9 or 138;
    self.groupBtn.transform.localPosition = pos;
    self.avgGO.transform.localPosition = pos;
    self.battle1GO.transform.localPosition = pos;
    self.battle2GO.transform.localPosition = pos;
    local type = self.data.type;
    if (type == 1) then
        SetActive(self.avgGO, true);
        SetActive(self.battle1GO, false);
        SetActive(self.battle2GO, false);
        SetActive(self.avgReplay, false);       
        SetActive(self.avgLock, false);
        local numStr = tostring(self.data.num);
        if (self.data.num < 10) then
            numStr = "0" .. numStr .. ".";
        else
            numStr =  numStr .. ".";
        end
        self.avgNum.text = numStr;
        self.avgName.text = LuaMgr.GetLangText(self.data.config.namelan);
        local eventData = PlayerQinMgr.GetActivityMapEvent(QinActivityType.daqinMap, self.data.config.id);
        if (eventData ~= nil) then
            if (eventData.complete) then
                SetActive(self.avgReplay, true);          
            end
        else
            SetActive(self.avgLock, true);
        end       
    elseif (type == 2) then
        SetActive(self.avgGO, false);
        SetActive(self.battle1GO, true);
        SetActive(self.battle2GO, false);
        SetActive(self.battle1Count, false);
        SetActive(self.battle1Evaluate, false);        
        SetActive(self.battle1Lock, false);
        self.battle1Name.text = LuaMgr.GetLangText(self.data.config.namelan);
       
        self:SetCount();
        self:SetItems();
        local eventData = PlayerQinMgr.GetActivityMapEvent(QinActivityType.daqinMap_normal, self.data.config.id);
        if (eventData ~= nil) then
            if (eventData.complete) then
                local record = DataMgr.Player.dungeonRecords[self.data.config.eventParam];
                if (record ~= nil and not IsNullOrEmpty(record.historyRating)) then
                    self.battle1EvaluateImg.sprite = LuaMgr.GetSprite("Qin", "ui_qin_pj_" .. record.historyRating);
                    SetActive(self.battle1Evaluate, true);
                end           
            end
        else
            SetActive(self.battle1Lock, true);
        end      
    elseif (type == 3) then
        SetActive(self.avgGO, false);
        SetActive(self.battle1GO, false);
        SetActive(self.battle2GO, true);
        SetActive(self.battle2Evaluate, false);        
        SetActive(self.battle2Lock, false);
        SetActive(self.battle2Frist, false);
        self.battle2Name.text = LuaMgr.GetLangText(self.data.config.namelan);
        SetActive(self.title1,self.data.num < 4)
        SetActive(self.title2,self.data.num >= 4)
        SetActive(self.fxLoop,self.data.num >= 4)

        local record = DataMgr.Player.dungeonRecords[self.data.config.eventParam];
        if (record == nil or record.completeCount <= 0) then
            local dungeonConfig = ConfigMgr.Config.dungeonMap[self.data.config.eventParam];
            if (dungeonConfig ~= nil) then
                self.battle2FristIcon.texture = GetItemTexture(dungeonConfig.firstDropShow);
                SetActive(self.battle2Frist, true);
            end
        end
        local eventData = PlayerQinMgr.GetActivityMapEvent(QinActivityType.daqinMap_hard, self.data.config.id);
        if (eventData ~= nil) then
            if (eventData.complete) then
                if (record ~= nil and not IsNullOrEmpty(record.historyRating)) then
                    self.battle2EvaluateImg.sprite = LuaMgr.GetSprite("Qin", "ui_qin_pj_" .. record.historyRating);
                    SetActive(self.battle2Evaluate, true);
                end            
            end
        else
            SetActive(self.battle2Lock, true);
        end       
    end
    self:RefreshNew()






    PlayerQinMgr.SetPlayQinLevelItemAnimationId(self.data.config.id)
end

function QinStoryLevelItem:RefreshNew()
    local type = self.data.type;
    if (type == 1) then       
        if(PlayerSlgMgr.CheckChapterNewDotDataById(QinActivityType.daqinMap, self.data.config.id))then
            SetActive(self.avgNew, true);
        else
            SetActive(self.avgNew, false);
        end
    elseif (type == 2) then        
        if(PlayerSlgMgr.CheckChapterNewDotDataById(QinActivityType.daqinMap_normal, self.data.config.id))then
            SetActive(self.battle1New, true);
        else
            SetActive(self.battle1New, false);
        end
    elseif (type == 3) then        
        if(PlayerSlgMgr.CheckChapterNewDotDataById(QinActivityType.daqinMap_hard, self.data.config.id))then
            SetActive(self.battle2New, true);
        else
            SetActive(self.battle2New, false);
        end
    end
end

function QinStoryLevelItem:SetCount()
    local levelConfig = ConfigQinMgr.GetLevelConfig(self.data.config.eventParam);
    if (levelConfig == nil) then return end
    
    local qinData = DataMgr.Player.Qin;
    if (qinData.StageId == levelConfig.Id) then
        self.battle1CountText.text = string.format("%d<color=#a1906a>/%d</color>", qinData.Storey, #levelConfig.LevelLayer);
        SetActive(self.battle1Count, true);
    else
        SetActive(self.battle1Count, false);
    end
end

function QinStoryLevelItem:SetItems()
    local dungeonConfig = ConfigMgr.Config.dungeonMap[self.data.config.eventParam];
    if (dungeonConfig == nil) then return end

    local item;
    local itemData;
    local dropShow;
    local scale = Vector3(0.4, 0.4, 1);
    local record = DataMgr.Player.dungeonRecords[self.data.config.eventParam];
    if (record == nil) then
        dropShow = dungeonConfig.firstDropShow;
    else
        dropShow = dungeonConfig.fixedDropShow;
    end
    local len = 0;
    if (dropShow ~= "") then
        local dropItems = NumTool.split(dropShow, ';');
        len = #dropItems;
        if (len > 3) then
            len = 3;
        end
        for i = 1, len do
            item = self.itemList[i];
            if (item == nil) then
                item = GoodsDataItem.New(self.battle1ItemsTF);
                self.itemList[i] = item;
            end
            itemData = table.Copy(ConfigMgr.Config.itemMap[dropItems[i]]);
            item:SetData(i, itemData, 1, false, scale, false, true);
        end
        SetActive(self.battle1ItemsGO, true);
    else
        SetActive(self.battle1ItemsGO, false);
    end
    local rlen = #self.itemList;
    for i = len + 1, rlen do
        self.itemList[i]:Hide();
    end
end

function QinStoryLevelItem:IsUnlock(type)
    local eventData = PlayerQinMgr.GetActivityMapEvent(type, self.data.config.id);
    if (eventData == nil) then      
        local dungeonConfig = ConfigMgr.Config.dungeonMap[self.data.config.unlockParam];  
        local name = ""
        if(dungeonConfig ~= nil)then
            name = LuaMgr.GetLangText(dungeonConfig.NameLan)
        else
            name = ConfigSlgMgr.GetUnlockName(self.data.config.unlockParam)
        end
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10001"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tipStr,name))        
        return false;
    end
    return true;
end

function QinStoryLevelItem:Clear()    
    self.data = nil;
    self.battle1EvaluateImg.sprite = nil;
    self.battle2Country.sprite = nil;
    self.battle2EvaluateImg.sprite = nil;
    self.battle2FristIcon.texture = nil;
end

function QinStoryLevelItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    if (self.itemList ~= nil) then
        local len = #self.itemList;
        for i = 1, len do
            self.itemList[i]:Clear();
        end
        self.itemList = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end