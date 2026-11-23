GuoBaoLevelItem = {};

GuoBaoLevelItem.__index = GuoBaoLevelItem;

local pos = Vector2(0, 0);

local objs = {
    groupBtn = { path = "Group", type = "Button" },
    groupTF = { path = "Group", type = "Transform" },
    bxczGO = { path = "Group/BXCZ", type = "GameObject" },
    bxczUnlock = { path = "Group/BXCZ/Unlock", type = "GameObject" },
    bxczLock = { path = "Group/BXCZ/Lock", type = "GameObject" },
    bxczComplete = { path = "Group/BXCZ/Complete", type = "GameObject" },
    bxczName = { path = "Group/BXCZ/Name/Text", type = "GameObject" },
    bxczNum = { path = "Group/BXCZ/Name/Text/Num", type = "Text" },
    bxczName2 = { path = "Group/BXCZ/Name/Text2", type = "GameObject" },
    bxczNum2 = { path = "Group/BXCZ/Name/Text2/Num", type = "Text" },
    bxczNew = { path = "Group/BXCZ/New", type = "GameObject" },
    bxczEvaluate = { path = "Group/BXCZ/Evaluate", type = "GameObject" },
    bxczEvaluateText = { path = "Group/BXCZ/Evaluate/Text", type = "Image" },
    zcyxGO = { path = "Group/ZCYX", type = "GameObject" },
    zcyxUnlock = { path = "Group/ZCYX/Unlock", type = "GameObject" },
    zcyxLock = { path = "Group/ZCYX/Lock", type = "GameObject" },
    zcyxComplete = { path = "Group/ZCYX/Complete", type = "GameObject" },
    zcyxName = { path = "Group/ZCYX/Name/Text", type = "GameObject" },
    zcyxNum = { path = "Group/ZCYX/Name/Text/Num", type = "Text" },
    zcyxName2 = { path = "Group/ZCYX/Name/Text2", type = "GameObject" },
    zcyxNum2 = { path = "Group/ZCYX/Name/Text2/Num", type = "Text" },
    zcyxNew = { path = "Group/ZCYX/New", type = "GameObject" },
    zcyxEvaluate = { path = "Group/ZCYX/Evaluate", type = "GameObject" },
    zcyxEvaluateText = { path = "Group/ZCYX/Evaluate/Text", type = "Image" },
};

function GuoBaoLevelItem.New()
    local self = {};    
    setmetatable(self, GuoBaoLevelItem);
    return self;
end

function GuoBaoLevelItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.itemList = {};
    self.OnClickItem = function()
        if (not DataExHelper.CommonActivityCheck(ActivityKey.GuoBao)) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"));
            return;
        end
        if (self:IsUnlock()) then
            local area = self.data.config.area;
            if (area == GuoBaoActivity.Main) then
                PlayerGuoBaoMgr.SetLevelMainIndex(self.data.num);
            elseif (area == GuoBaoActivity.Battle) then
                PlayerGuoBaoMgr.SetLevelBattleIndex(self.data.num);
            end
            local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
            enterDungeonParams.eventId = self.data.config.id;
            enterDungeonParams.dungeonId = self.data.config.eventParam;
            BattlePrepareMgr.BattlePrepare(enterDungeonParams);
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function GuoBaoLevelItem:SetData(data)   
    self.data = data.data;   
    pos.y = (self.data.num % 2 == 0) and -105 or 109;
    self.groupTF.anchoredPosition = pos;
    SetActive(self.bxczGO, false);
    SetActive(self.zcyxGO, false);
    local config = self.data.config;
    local eventData = PlayerGuoBaoMgr.GetActivityMapEvent(config.area, config.id);
    if (config.area == GuoBaoActivity.Main) then
        SetActive(self.bxczUnlock, false);
        SetActive(self.bxczLock, false);
        SetActive(self.bxczComplete, false);
        SetActive(self.bxczName, false);
        SetActive(self.bxczName2, false);
        SetActive(self.bxczNew, false);
        SetActive(self.bxczEvaluate, false);
        if (self.data.num > 10) then
            self.bxczNum2.text = ConfigGuoBaoMgr.GetNumStr(self.data.num);
            SetActive(self.bxczName2, true);
        else
            self.bxczNum.text = ConfigGuoBaoMgr.GetNumStr(self.data.num);
            SetActive(self.bxczName, true);
        end
        if (eventData ~= nil) then
            if (eventData.complete) then
                local record = DataMgr.Player.dungeonRecords[config.eventParam];
                if (record ~= nil and not IsNullOrEmpty(record.historyRating)) then
                    self.bxczEvaluateText.sprite = LuaMgr.GetSprite("AreaMapRes", "ui_zqzb_pj_" .. record.historyRating);
                    SetActive(self.bxczEvaluate, true);
                end
                SetActive(self.bxczComplete, true);
            else
                SetActive(self.bxczNew, true);
                SetActive(self.bxczUnlock, true);
            end
        else
            SetActive(self.bxczLock, true);
        end
        SetActive(self.bxczGO, true);
    elseif (config.area == GuoBaoActivity.Battle) then
        SetActive(self.zcyxUnlock, false);
        SetActive(self.zcyxLock, false);
        SetActive(self.zcyxComplete, false);
        SetActive(self.zcyxName, false);
        SetActive(self.zcyxName2, false);
        SetActive(self.zcyxNew, false);
        SetActive(self.zcyxEvaluate, false);
        if (self.data.num > 10) then
            self.zcyxNum2.text = ConfigGuoBaoMgr.GetNumStr(self.data.num);
            SetActive(self.zcyxName2, true);
        else
            self.zcyxNum.text = ConfigGuoBaoMgr.GetNumStr(self.data.num);
            SetActive(self.zcyxName, true);
        end
        if (eventData ~= nil) then
            if (eventData.complete) then
                local record = DataMgr.Player.dungeonRecords[config.eventParam];
                if (record ~= nil and not IsNullOrEmpty(record.historyRating)) then
                    self.zcyxEvaluateText.sprite = LuaMgr.GetSprite("AreaMapRes", "ui_zqzb_pj_" .. record.historyRating);
                    SetActive(self.zcyxEvaluate, true);
                end
                SetActive(self.zcyxComplete, true);
            else
                SetActive(self.zcyxNew, true);
                SetActive(self.zcyxUnlock, true);
            end
        else
            SetActive(self.zcyxLock, true);
        end
        SetActive(self.zcyxGO, true);
    end
end

function GuoBaoLevelItem:IsUnlock()
    local eventData = PlayerGuoBaoMgr.GetActivityMapEvent(self.data.config.area, self.data.config.id);
    if (eventData == nil) then      
        local unlockName = ConfigSlgMgr.GetUnlockName(self.data.config.unlockParam);
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("10001"), unlockName));
        return false;
    end
    return true;
end

function GuoBaoLevelItem:Clear()    
    self.data = nil;
    self.bxczEvaluateText.sprite = nil;
    self.zcyxEvaluateText.sprite = nil;
end

function GuoBaoLevelItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end