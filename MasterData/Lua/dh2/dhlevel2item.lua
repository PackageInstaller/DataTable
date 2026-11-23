DHLevel2Item = {};

DHLevel2Item.__index = DHLevel2Item;

local pos = Vector3(0, 0, 0);

local objs = {
    animator = { path = "", type = "Animator" },
    groupBtn = { path = "Group/Btn", type = "Button" },
    groupTF = { path = "Group", type = "Transform" },
    avgGO = { path = "Group/Avg", type = "GameObject" },
    icon1 = { path = "Group/Avg/Icon1", type = "GameObject" },
    icon2 = { path = "Group/Avg/Icon2", type = "GameObject" },
    unLockShow = { path = "Group/Avg/showBox", type = "GameObject" },
    avgName = { path = "Group/Avg/showBox/Image/Name", type = "Text" },
    evaluate = { path = "Group/Avg/showBox/Evaluate", type = "GameObject" },
    evaluateImg = { path = "Group/Avg/showBox/Evaluate/Text", type = "Image" },
    newGo = { path = "Group/Avg/showBox/New", type = "GameObject" },
    avgLock = { path = "Group/Avg/Lock", type = "GameObject" },
    avg2GO = { path = "Group/Avg2", type = "GameObject" },    
    avg2Name = { path = "Group/Avg2/showBox/Image/Name", type = "Text" },
    avg2Evaluate = { path = "Group/Avg2/showBox/Evaluate", type = "GameObject" },

    avg2NewGo = { path = "Group/Avg2/showBox/New", type = "GameObject" },
    avg2Lock = { path = "Group/Avg2/Lock", type = "GameObject" },
    avg2Time = { path = "Group/Avg2/Lock/Image2/OpenTime", type = "Text" },
    avg2TimeBg = { path = "Group/Avg2/Lock/Image2", type = "GameObject" },
    avg2UnLockShow = { path = "Group/Avg2/showBox", type = "GameObject" },
};

function DHLevel2Item.New()
    local self = {};
    setmetatable(self, DHLevel2Item);
    return self;
end

function DHLevel2Item:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.playAnimator = true
    self.itemList = {};
    self.OnClickBtn = function()
        if not DataExHelper.CommonActivityCheck(ActivityKey.RoomShare) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
            return;
        end
        if (self.levelType == 1) then
            if (self:IsUnlock(DH2LevelType.Repeat, true)) then
                self:EnterBattle()
            end
        elseif (self.levelType == 2) then
            if (self:IsUnlock(DH2LevelType.Main, true)) then
                self:EnterBattle()
            end
        elseif (self.levelType == 3) then
            if (self:IsUnlock(DH2LevelType.Difficult, true)) then
                self:EnterBattle()
            end
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickBtn);
end

function DHLevel2Item:EnterBattle()
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
    enterDungeonParams.eventId = self.data.config.id;
    enterDungeonParams.dungeonId = self.data.config.eventParam;
    BattlePrepareMgr.BattlePrepare(enterDungeonParams);
end

function DHLevel2Item:ShowAim(groupIndex)
    if (self.animator == nil) then return end
    self.coroutine = coroutine_runner.start(
        function()
            SetActive(self.animator.gameObject, false)
            coroutine_runner.wait(0.1 * (groupIndex - 1))
            SetActive(self.animator.gameObject, true)
            self.animator.enabled = false;
            self.animator.enabled = true;
            coroutine_runner.wait(3)
            self.animator.enabled = false;
            self.coroutine = nil
        end)
end

function DHLevel2Item:SetData(data)
    self.levelType = PlayerDH2Mgr.GetLevelType();
    self.data = data.data;
    if (self.data.playAni ) then        

        self.data.playAni = false
    end    
    if (self.levelType == 1 or self.levelType == 2) then
        pos.y = (self.data.num % 2 == 0) and -19 or 70;
        self.avgName.text = LuaMgr.GetLangText(self.data.config.namelan);
        self.groupBtn.transform.localPosition = pos;
        self.avgGO.transform.localPosition = pos;
        SetActive(self.avgGO, true);
        SetActive(self.avg2GO, false);
        SetActive(self.avgLock, false);
        SetActive(self.unLockShow, true);
        SetActive(self.icon1, self.levelType == 1);
        SetActive(self.icon2, self.levelType == 2);       
        SetActive(self.evaluate, false);
        local eventData = nil;
        if (self.levelType == 1) then
            eventData = PlayerDH2Mgr.GetActivityMapEvent(DH2LevelType.Repeat, self.data.config.id);
        elseif (self.levelType == 2) then
            eventData = PlayerDH2Mgr.GetActivityMapEvent(DH2LevelType.Main, self.data.config.id);
        end
        if (eventData ~= nil) then
            if (eventData.complete) then
                local record = DataMgr.Player.dungeonRecords[self.data.config.eventParam];
                if (record ~= nil and not IsNullOrEmpty(record.historyRating)) then
                    self.evaluateImg.sprite = LuaMgr.GetSprite("Qin", "ui_qin_pj_" .. record.historyRating);
                    SetActive(self.evaluate, true);
                end
            end
        else
            SetActive(self.avgLock, true);
            SetActive(self.unLockShow, false);           
        end
    elseif (self.levelType == 3) then
        pos.y = (self.data.num % 2 == 0) and -19 or 70;
        self.avg2Name.text = LuaMgr.GetLangText(self.data.config.namelan);
        self.groupBtn.transform.localPosition = pos;
        self.avg2GO.transform.localPosition = pos;
        SetActive(self.avg2GO, true);
        SetActive(self.avgGO, false);
        SetActive(self.avg2Lock, false);
        SetActive(self.avg2UnLockShow, true);
        SetActive(self.avg2Evaluate, false);
        local eventData = PlayerDH2Mgr.GetActivityMapEvent(DH2LevelType.Difficult, self.data.config.id);
        if (self:IsUnlock(DH2LevelType.Difficult, false)) then
            if (eventData ~= nil and eventData.complete) then
                SetActive(self.avg2Evaluate, true);





            end
        else
            SetActive(self.avg2Lock, true);
            SetActive(self.avg2UnLockShow, false);
            local group = nil
            for i, v in ipairs(ConfigMgr.Config.activityMapEventList) do
                if v.id == self.data.config.id then
                    group = v
                    break
                end
            end
            local curTimeStamp = LuaMgr.Timestamp();
            if group ~= nil and curTimeStamp < group.openDate then
                SetActive(self.avg2TimeBg, true)
                self.avg2Time.text = ConfigDH2Mgr.GetUnlockTimeStr(group.openDate)
            else
                SetActive(self.avg2TimeBg, false)
            end          
        end
    end
end

function DHLevel2Item:IsUnlock(type, bShowTips)
    local eventData = PlayerDH2Mgr.GetActivityMapEvent(type, self.data.config.id);
    if (eventData == nil) then
        if (bShowTips) then
            local dungeonConfig = ConfigMgr.Config.dungeonMap[self.data.config.unlockParam];
            local name = ""
            if (dungeonConfig ~= nil) then
                name = LuaMgr.GetLangText(dungeonConfig.NameLan)
            else
                name = ConfigDH2Mgr.GetUnlockName(self.data.config.unlockParam)
            end
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10001"].NameLan)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(tipStr, name))
        end
        return false;
    else
        local group = nil
        for i, v in ipairs(ConfigMgr.Config.activityMapEventList) do
            if v.id == self.data.config.id then
                group = v
                break
            end
        end
        local curTimeStamp = LuaMgr.Timestamp();
        if group.openDate == 0 and group.closeDate == 0 then
            return true;
        end
        local bShow = curTimeStamp >= group.openDate and curTimeStamp <= group.closeDate
        if (not bShow and bShowTips) then
            local str = ""
            if curTimeStamp < group.openDate then
                str = ConfigDH2Mgr.GetUnlockTimeStr(group.openDate)
            end
            if curTimeStamp > group.closeDate then
                str = LuaMgr.GetLangText("DHLevelItem_0")
            end
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, str)
        end
        return bShow;
    end
    return true;
end

function DHLevel2Item:Clear()
    self.data = nil;
    if self.coroutine ~= nil then
        coroutine_runner.stop(self.coroutine);
        self.coroutine = nil;
        SetActive(self.animator.gameObject, true)
    end
end

function DHLevel2Item:Destroy()
    if (self.OnClickBtn ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickBtn);
        self.OnClickBtn = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end