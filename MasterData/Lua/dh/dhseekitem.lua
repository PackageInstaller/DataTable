DHSeekItem = {};

DHSeekItem.__index = DHSeekItem;

local objs = {
    animator = { path = "", type = "Animator" },
    groupBtn = { path = "Group/Btn", type = "Button" },
    groupTF = { path = "Group", type = "Transform" },
    avgGO = { path = "Group/Avg", type = "GameObject" },
    finishiImg = { path = "Group/Avg/unLockShow/FinishiImg", type = "GameObject" },
    imgIcon = { path = "Group/Avg/ImgIcon", type = "Image" },
    avgNum = { path = "Group/Avg/unLockShow/UnfinishImg/Num", type = "Text" },
    avgName = { path = "Group/Avg/Name", type = "Text" },
    avgNew = { path = "Group/Avg/New", type = "GameObject" },
    avgLock = { path = "Group/Avg/Lock", type = "GameObject" },
    unLockShow = { path = "Group/Avg/unLockShow", type = "GameObject" },
    avgLockTextDay = { path = "Group/Avg/Lock/TextDay", type = "Text" },
    BtnRecover = { path = "Group/Avg/unLockShow/BtnRecover", type = "Button" },
    BtnCollect = { path = "Group/Avg/unLockShow/BtnCollect", type = "Button" },
    ImgRed = { path = "Group/Avg/unLockShow/BtnRecover/ImgRed", type = "GameObject" },
    imgSelect = { path = "Group/Avg/ImgSelect", type = "GameObject" },
};

function DHSeekItem.New()
    local self = {};
    setmetatable(self, DHSeekItem);
    return self;
end

function DHSeekItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.playAnimator = true
    self.itemList = {};
    self.OnClickRecover = function()
        if not DataExHelper.CommonActivityCheck(ActivityKey.DunHuang) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
            return;
        end

        self:RefreshNew()
        LuaMgr.ShowLuaPanel(UIName.DHSurveyDrawViewModel, self.data.config);
    end
    self.OnClickCollect = function()
        if not DataExHelper.CommonActivityCheck(ActivityKey.DunHuang) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
            return;
        end        
        self:RefreshNew()
        local stageId = DataMgr.Player.DunHuang.StageId;       
        if (stageId ~= "") then
            if (stageId == self.data.config.Id) then                
                PlayerQinMgr.SetPlayAudio(true)
                LuaMgr.ShowLuaPanel(UIName.DHSurveyViewModel);
            else
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("QinLevelItem_0"));
            end
        else
            PlayerDHMgr.EnterStage(self.data.config.Id)
        end
    end

    self.OnCickGroup = function()
        if (self.GroupClickType == 1) then
            self.OnClickRecover()
        else
            self.OnClickCollect()
        end
    end
    LuaMgr.AddClick(self.BtnRecover, self.OnClickRecover);
    LuaMgr.AddClick(self.BtnCollect, self.OnClickCollect);
    LuaMgr.AddClick(self.groupBtn, self.OnCickGroup)
end

function DHSeekItem:SetData(data)
    if self.coroutine ~= nil then
        coroutine_runner.stop(self.coroutine);
        self.coroutine = nil;
    end
    self.data = data.data;
    self.animator.enabled = self.data.playAni
    self.animator:Rebind();
    self.animator:Play("ani_AQinLevelStoryPanel_01");
    SetActive(self.avgGO, true);
    SetActive(self.avgLock, false);
    self.avgName.text = LuaMgr.GetLangText(self.data.config.NameLan);
    local dhMap = PlayerDHMgr.GetCurDrawOpenList(self.data.config.Id)
    local openNum = 0
    for k, v in pairs(dhMap) do
        openNum = openNum + 1
    end
    local needGet = openNum / self.data.config.DebrisNum * 100;
    self.avgNum.text = needGet .. "%"
    local finish = openNum >= self.data.config.DebrisNum
    SetActive(self.finishiImg, finish)
    local gridType = ConfigDHMgr.GetGridType(DHSurveyGrid.Box2);
    local curGet = PlayerDHMgr.GetBoxToolsCount(self.data.config.Id, gridType.ItemsID);
    self.GroupClickType = 0
    if (curGet == self.data.config.DebrisNum / 5 and not finish) then
        self.GroupClickType = 1
    end
    local curGetNum = PlayerDHMgr.GetCurExploreReward(self.data.config.Id)
    SetActive(self.ImgRed, false)
    if (curGetNum > 0 and not finish) then
        SetActive(self.ImgRed, true)
        self.coroutine = coroutine_runner.start(
            function()
                coroutine_runner.wait(1)
                self.animator.enabled = true
                self.animator:Rebind();
                self.animator:Play("ani_QinLevelStoryPanel_LevelItem_loop");
            end)
    end
    self.imgIcon.sprite = LuaMgr.GetSprite("DunHuang", "ui_hd_dh_ch_main_pic_" .. self.data.config.SortId)
    SetActive(self.imgSelect, DataMgr.Player.DunHuang.StageId == self.data.config.Id)  
    self:CheckUnLock()
    self:RefreshNew()
end

function DHSeekItem:CheckUnLock()
    if (self.data.config.UnlockType == 0) then
        SetActive(self.avgLock, false);
        SetActive(self.unLockShow, true)
        return
    end
    local type = self.data.config.UnlockType
    local parem = self.data.config["Unlock_" .. type]
    local isLock = PlayerDHMgr.CheckDHSeekLock(self.data.config)
    SetActive(self.avgLock, isLock);
    SetActive(self.unLockShow, not isLock)
    self.groupBtn.interactable = not isLock
    if (type == 1) then
        local config = ConfigMgr.Config.DHLevelMap[parem]
        local name = LuaMgr.GetLangText(config.NameLan)
        self.avgLockTextDay.text = string.format(LuaMgr.GetLangText("DHSeekItem_0"), name);
    else
        local timestamp = LuaMgr.Timestamp()
        local interval = parem - timestamp
        if (interval < 0) then interval = 0 end
        local timeStr = TimeString(interval)
        self.avgLockTextDay.text = string.format(LuaMgr.GetLangText("DHSeekItem_1"), timeStr);
    end
end

function DHSeekItem:RefreshNew()





end

function DHSeekItem:IsUnlock(type)
    local eventData = PlayerQinMgr.GetActivityMapEvent(type, self.data.config.Id);
    if (eventData == nil) then
        local dungeonConfig = ConfigMgr.Config.dungeonMap[self.data.config.unlockParam];
        local name = ""
        if (dungeonConfig ~= nil) then
            name = LuaMgr.GetLangText(dungeonConfig.NameLan)
        else
            name = ConfigSlgMgr.GetUnlockName(self.data.config.unlockParam)
        end
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10001"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(tipStr, name))
        return false;
    end
    return true;
end

function DHSeekItem:Clear()
    self.data = nil;
    if self.coroutine ~= nil then
        coroutine_runner.stop(self.coroutine);
        self.coroutine = nil;
    end
end

function DHSeekItem:Destroy()
    if (self.OnClickRecover ~= nil) then
        LuaMgr.RemoveClick(self.BtnRecover, self.OnClickRecover);
        self.OnClickRecover = nil;
    end
    if (self.OnClickCollect ~= nil) then
        LuaMgr.RemoveClick(self.BtnCollect, self.OnClickCollect);
        self.OnClickCollect = nil;
    end
    if (self.OnCickGroup ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnCickGroup);
        self.OnCickGroup = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end