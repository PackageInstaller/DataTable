QinBattleItem = {};

QinBattleItem.__index = QinBattleItem;

local objs = {
    button = { path = "", type = "Button" },
    country = { path = "Country", type = "Image" },
    name = { path = "Name", type = "Text" },
    pass = { path = "Pass", type = "GameObject" },
    perfect = { path = "Perfect", type = "GameObject" },
    frist = { path = "FirstImg", type = "GameObject" },
    fristIcon = { path = "FirstImg/Frist/Icon", type = "RawImage" },
    lock = { path = "Lock", type = "GameObject" },
    lockText = { path = "Lock/Text", type = "Text" },
    fight = { path = "Fight", type = "GameObject" },
};

function QinBattleItem.New(gameObject)
    local self = {};
    setmetatable(self, QinBattleItem);
    UITool.Parse(gameObject, self, objs);
    self.OnClickItem = function()
        if not DataExHelper.CommonActivityCheck(ActivityKey.daqin) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"))
            return ;
        end
        PlayerSlgMgr.UpdateTaskNewDotData(self.data.id)
        local eventData = PlayerQinMgr.GetActivityMapEvent(QinActivityType.daqinMap_main, self.data.id);
        if (eventData == nil) then
            local unlockEvent = ConfigQinMgr.GetMainActivityMapEvent(self.data.unlockParam);
            if (unlockEvent ~= nil) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, self.lockText.text);
            end
            return;
        end
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
        enterDungeonParams.eventId = self.data.id;
        enterDungeonParams.dungeonId = self.data.eventParam;
        BattlePrepareMgr.BattlePrepare(enterDungeonParams);
        LuaMgr.HidePanel(UIName.QinBattleViewModel); 
        PlayerQinMgr.SetOldQuest(DataExHelper.Check_DataExByGroupId(222))       
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
    return self;
end

function QinBattleItem:SetData(data)
    self.data = data;
    self.country.sprite = LuaMgr.GetSprite("Qin", "ui_hd_dq_sp_guo" .. self.data.classId);
    self.name.text = LuaMgr.GetLangText(self.data.namelan);
    local eventData = PlayerQinMgr.GetActivityMapEvent(QinActivityType.daqinMap_main, self.data.id);
    if (eventData ~= nil) then
        if (eventData.complete) then
            local record = DataMgr.Player.dungeonRecords[self.data.eventParam];
            if (record ~= nil and not IsNullOrEmpty(record.historyRating)) then
                SetActive(self.pass, record.historyRating ~= "S");
                SetActive(self.perfect, record.historyRating == "S");
            else
                SetActive(self.pass, false);
                SetActive(self.perfect, false);
            end
            SetActive(self.frist, false);
        else
            SetActive(self.pass, false);
            SetActive(self.perfect, false);
            local dungeonConfig = ConfigMgr.Config.dungeonMap[self.data.eventParam];
            if (dungeonConfig ~= nil) then
                local tempList = dungeonConfig.rateAward[1]                
                local goodsConfig = ConfigMgr.Config.itemMap[tempList.id]                
                self.fristIcon.texture = GetItemTexture(goodsConfig.id);
            end
            SetActive(self.frist, true);
        end
        SetActive(self.fight, true);
        SetActive(self.lock, false);
    else
        local unlockEvent = ConfigQinMgr.GetMainActivityMapEvent(self.data.unlockParam);
        if (unlockEvent ~= nil) then
            self.lockText.text = string.format(LuaMgr.GetLangText("QinBattleItem_0"), LuaMgr.GetLangText(unlockEvent.namelan));
        end
        SetActive(self.pass, false);
        SetActive(self.perfect, false);
        SetActive(self.frist, false);
        SetActive(self.lock, true);
        SetActive(self.fight, false);
    end
end

function QinBattleItem:Clear()
    self.data = nil;
    self.country.sprite = nil;
    self.fristIcon.texture = nil;
end

function QinBattleItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
end