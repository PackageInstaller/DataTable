XCHDLevelItem = {};

XCHDLevelItem.__index = XCHDLevelItem;

local pos = Vector3(0, 0, 0);

local objs = {
    animator = { path = "", type = "Animator" },
    groupBtn = { path = "Group/Btn", type = "Button" },
    groupTF = { path = "Group", type = "Transform" },
    avgGO = { path = "Group/Avg", type = "GameObject" },
    imgIcon = { path = "Group/Avg/ImgIcon", type = "Image" },
    unLockShow = { path = "Group/Avg/showBox", type = "GameObject" },
    avgName = { path = "Group/Avg/showBox/Image/Name", type = "Text" },
    evaluate = { path = "Group/Avg/showBox/Evaluate", type = "GameObject" },
    evaluateImg = { path = "Group/Avg/showBox/Evaluate/Text", type = "Image" },
    avgLock = { path = "Group/Avg/Lock", type = "GameObject" },
    avgLockImg = { path = "Group/Avg/Lock", type = "Image" },
};

function XCHDLevelItem.New()
    local self = {};
    setmetatable(self, XCHDLevelItem);
    return self;
end

function XCHDLevelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.playAnimator = true
    self.itemList = {};
    self.OnClickBtn = function()
        if not DataExHelper.CommonActivityCheck(ActivityKey.XCHD) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
            return;
        end
        if (self.levelType == 1) then
            if (self:IsUnlock(XCHDMgr.Repeat, true)) then
                self:EnterBattle()
            end
        elseif (self.levelType == 2) then
            if (self:IsUnlock(XCHDMgr.Main, true)) then
                self:EnterBattle()
            end
        elseif (self.levelType == 3) then
            if (self:IsUnlock(XCHDMgr.Difficult, true)) then
                self:EnterBattle()
            end
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickBtn);
end

function XCHDLevelItem:EnterBattle()
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
    enterDungeonParams.eventId = self.data.config.id;
    enterDungeonParams.dungeonId = self.data.config.eventParam;
    BattlePrepareMgr.BattlePrepare(enterDungeonParams);
end

function XCHDLevelItem:ShowAim(groupIndex)
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

function XCHDLevelItem:SetData(data)
    self.levelType = XCHDMgr.GetLevelType();
    self.data = data.data;
    if (self.data.playAni) then

        self.data.playAni = false
    end
    SetActive(self.avgGO, true);   
    SetActive(self.avgLock, false);
    SetActive(self.avgLock, true);
    local iconType = 1;
    local iconStr = "ui_hd_rsrh_gk_sec_pic_gn"
    local lockStr = "ui_hd_rsrh_gk_icon_wjs"
    SetActive(self.evaluate, false);
    local eventData = nil;
    if (self.levelType == 1) then
        eventData = XCHDMgr.GetActivityMapEvent(XCHDMgr.Repeat, self.data.config.id);
        iconType = (self.data.num % 2 == 0) and 2 or 1;
        iconStr = "ui_hd_rsrh_gk_sec_pic_fs";
        lockStr = "ui_hd_rsrh_gk_icon_fs"
    elseif (self.levelType == 2) then
        eventData = XCHDMgr.GetActivityMapEvent(XCHDMgr.Main, self.data.config.id);
        iconType = (self.data.num % 2 == 0) and 2 or 1;
        iconStr = "ui_hd_rsrh_gk_sec_pic_zx";
        lockStr = "ui_hd_rsrh_gk_icon_zx"
    else
        if (self:IsUnlock(XCHDMgr.Difficult, false)) then
            lockStr = "ui_hd_rsrh_gk_icon_gn"
            eventData = XCHDMgr.GetActivityMapEvent(XCHDMgr.Difficult, self.data.config.id);
        end
        iconType = ""
    end
    self.imgIcon.sprite = LuaMgr.GetSprite("XCHD", iconStr .. iconType)
    pos.y = (self.data.num % 2 == 0) and -40 or 100;    
    self.groupBtn.transform.localPosition = pos;
    self.avgGO.transform.localPosition = pos;
    if (eventData ~= nil) then
        self.avgLockImg.sprite = LuaMgr.GetSprite("XCHD", lockStr);
        self.avgName.text = LuaMgr.GetLangText(self.data.config.namelan);
        if (eventData.complete) then
            SetActive(self.evaluate, true);
            if (self.levelType == 1) then
                self.evaluateImg.sprite = LuaMgr.GetSprite("XCHD", "ui_hd_rsrh_gk_sec_tip_fs");
            elseif (self.levelType == 2) then
                self.evaluateImg.sprite = LuaMgr.GetSprite("XCHD", "ui_hd_rsrh_gk_sec_tip_tg");
            else
                local record = DataMgr.Player.dungeonRecords[self.data.config.eventParam];
                if (record ~= nil and not IsNullOrEmpty(record.historyRating)) then
                    self.evaluateImg.sprite = LuaMgr.GetSprite("XCHD", "ui_hd_rsrh_gk_sec_tip_" .. record.historyRating);
                end
            end
        end
    else
        self.avgLockImg.sprite = LuaMgr.GetSprite("XCHD", lockStr);
        self.avgName.text = LuaMgr.GetLangText("XCHDLevelItem_0");
    end
end

function XCHDLevelItem:IsUnlock(type, bShowTips)
    local eventData = XCHDMgr.GetActivityMapEvent(type, self.data.config.id);
    if (eventData == nil) then
        if (bShowTips) then
            local dungeonConfig = ConfigMgr.Config.dungeonMap[self.data.config.unlockParam];
            local name = ""
            if (dungeonConfig ~= nil) then
                name = LuaMgr.GetLangText(dungeonConfig.NameLan)
            else
                name = self:GetUnlockName(self.data.config.unlockParam)
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
                str = self:GetUnlockTimeStr(group.openDate)
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

function XCHDLevelItem:Clear()
    self.data = nil;
    if self.coroutine ~= nil then
        coroutine_runner.stop(self.coroutine);
        self.coroutine = nil;
        SetActive(self.animator.gameObject, true)
    end
end

function XCHDLevelItem:Destroy()
    if (self.OnClickBtn ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickBtn);
        self.OnClickBtn = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

function XCHDLevelItem:GetUnlockName(unlockParam)
    local config = nil
    for i, v in ipairs(ConfigMgr.Config.activityMapEventList) do
        if v.id == unlockParam then
            config = v
            break
        end
    end
    if (config ~= nil) then
        return LuaMgr.GetLangText(config.namelan)
    end
    return "";
end

function XCHDLevelItem:GetUnlockTimeStr(time)
    local curTimeStamp = LuaMgr.Timestamp();
    curTimeStamp = time - curTimeStamp
    if (curTimeStamp <= 0) then
        return LuaMgr.GetLangText("ConfigDHMgr_0")
    end
    local day, hour, minute = GetTimeDHM(curTimeStamp)
    local timeStr = ""
    if IsNullOrEmpty(day) then
        timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10209"].NameLan), hour, minute)
    else
        timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10208"].NameLan), day, hour)
    end
    return timeStr .. LuaMgr.GetLangText("ConfigDHMgr_1")
end