require("Qin/QinMainResItem")
require("Qin/QinMainProgressItem")
require("Qin/QinMapItem")

local this = {
    mapItem = nil,
    groupId = 222,
    resList = nil,
    progressList = nil,
    showProgress = false,
    eventList = nil,
};

local objs = {
    aniRoot = { path = "root", type = "Animator" },
    mapTF = { path = "root/Map", type = "Transform" },
    progressCloseGO = { path = "root/ProgressCloseBtn", type = "GameObject" },
    ProgressCloseBtn = { path = "root/ProgressCloseBtn", type = "Button" },
    unifyBtn = { path = "root/Left/Unify", type = "Button" },
    unifyText = { path = "root/Left/Unify/Text", type = "Text" },
    unifyProgressBar = { path = "root/Left/Unify/ProgressBar", type = "Image" },
    collectBtn = { path = "root/Left/CollectBtn", type = "Button" },
    resItem = { path = "template/ResItem", type = "GameObject" },
    resTF = { path = "root/Right/Res", type = "Transform" },
    progressItem = { path = "template/ProgressItem", type = "GameObject" },
    progressGO = { path = "root/Left/Progress", type = "GameObject" },
    progressTF = { path = "root/Left/Progress", type = "Transform" },
    reviewGO = { path = "root/Right/ReviewBtn", type = "GameObject" },
    reviewBtn = { path = "root/Right/ReviewBtn", type = "Button" },
    startEffect = { path = "root/fx_start", type = "GameObject" },
    mask = { path = "root/mask", type = "GameObject" },
    qinAllBtn={ path = "root/QinAllBtn", type = "Button" },
};


this.SetRes = function()
    this.resList:Clear();
    local listData;
    local listDatas = {};
    local initialResourcesMax = ConfigMgr.Config.QinTimesConstants.InitialResourcesMax;
    local len = #initialResourcesMax;
    for i = 1, len do
        listData = UIListData.GetData(this.resItem, "QinMainResItem", initialResourcesMax[i][1]);
        table.insert(listDatas, listData);
    end
    this.resList:SetData(listDatas);
end


this.SetProgress = function()
    this.progressList:Clear();
    local questData;
    local questConfig;
    local listData;
    local listDatas = {};
    local currentUnify = 0;
    local totalUnify = 0;
    local questEvent = ConfigMgr.Config.questEvent;
    local questEvents = DataExHelper.Check_DataExByGroupId(this.groupId);
    table.sort(questEvents, this.SortQuestEvent);
    local len = #questEvents;
    for i = 1, len do
        questData = questEvents[i];
        questConfig = questEvent[questData.id];
        if (#questConfig.special > 0 and questConfig.special[1] == "mainTask") then
            listData = UIListData.GetData(this.progressItem, "QinMainProgressItem", questData);
            local num = tonumber(questConfig.special[2])
            listDatas[num] = listData           
            if (questData.state == 2 or questData.state == 3) then
                currentUnify = currentUnify + 1;
            end
            totalUnify = totalUnify + 1;
        end
    end
    this.progressList:SetData(listDatas);
    this.SetUnify(currentUnify, totalUnify);
    SetActive(this.reviewGO, currentUnify > 0);
    SetActive(this.qinAllBtn.gameObject,currentUnify>=totalUnify);
end


this.SortQuestEvent = function(a, b)
    return a.idx < b.idx;
end


this.SetUnify = function(currentUnify, totalUnify)
    local unify = currentUnify / totalUnify;
    this.unifyText.text = math.ceil(unify * 100) .. "%";
    this.unifyProgressBar.fillAmount = unify;
end


this.OnClickUnify = function()
    this.showProgress = not this.showProgress; 
    SetActive(this.progressCloseGO,this.showProgress)  
    SetActive(this.progressGO, this.showProgress);
    if(this.showProgress)then
        this.aniRoot:Rebind();       
    end
end


this.OnClickCollect = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.daqin) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"))
        return ;
    end
    LuaMgr.ShowLuaPanel(UIName.SlgCollectViewModel);
end


this.OnClickReview = function()
    LuaMgr.ShowLuaPanel(UIName.QinBattleViewModel, true, 1);
end

this.OnClickQinAll=function()
    local cache = {}
    cache.tipslan = ConfigMgr.LangGlobal("10432")
    cache.descriptionlan = ConfigMgr.LangGlobal("10433")
    LuaMgr.ShowLuaPanel(UIName.QinResultViewModel,cache,true);
end

this.OnMapRefresh = function ()
    if(this.mapItem)then
        this.mapItem:SetData();
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.mapItem = QinMapItem.New(this.mapTF);
        this.resList = UIListView.New(this.resTF);
        this.progressList = UIListView.New(this.progressTF);
        LuaMgr.AddClick(this.ProgressCloseBtn, this.OnClickUnify)
        LuaMgr.AddClick(this.unifyBtn, this.OnClickUnify);
        LuaMgr.AddClick(this.collectBtn, this.OnClickCollect);
        LuaMgr.AddClick(this.reviewBtn, this.OnClickReview);
        LuaMgr.AddClick(this.qinAllBtn,this.OnClickQinAll);
        RedMgr.Singleton:RegisterViewModel(UIName.QinMainViewModel);
    end,
    before_active = function(vm)      
        if (vm.behaviour.Params == nil) then return end   
		SetActive(this.mask,false)
        PlayerSlgMgr.CheckMainTaskEntranceRedDot()  
        RedMgr.Singleton:Refresh()  
        LuaMgr.AddUIEventListener(UIEventConst.QinRewardRefresh, this.SetProgress);
        LuaMgr.AddUIEventListener(UIEventConst.QinSurveyMapRefresh, this.OnMapRefresh);
        this.showProgress = false;
        SetActive(this.progressGO, this.showProgress);
        SetActive(this.progressCloseGO, this.showProgress);        
        this.SetRes();
        this.SetProgress();
        this.mapItem:SetData();
        local bShow = PlayerQinMgr.GetPlayAudio()
        SetActive(this.startEffect,bShow)
        if(bShow)then
            SetActive(this.mask,true)
            PlayerQinMgr.SetPlayAudio(false)
            AudioMgr.Singleton:PlayVoice(Path.audio_PATH.."DaQin/DQ_YP_01.mp3");   
            if this.startDelay ~= nil then
                coroutine_runner.stop(this.startDelay)
            end
            this.startDelay = coroutine_runner.start(function()        
                coroutine_runner.wait(2)
                SetActive(this.mask,false)
            end)           
        end 
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.QinRewardRefresh, this.SetProgress);
        LuaMgr.RemoveUIEventListener(UIEventConst.QinSurveyMapRefresh, this.OnMapRefresh);
        this.resList:Clear();
        this.progressList:Clear();
        if this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay)
        end
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.ProgressCloseBtn, this.OnClickUnify)
        LuaMgr.RemoveClick(this.unifyBtn, this.OnClickUnify);
        LuaMgr.RemoveClick(this.collectBtn, this.OnClickCollect);
        LuaMgr.RemoveClick(this.reviewBtn, this.OnClickReview);
        if (this.mapItem ~= nil) then
            this.mapItem:Destroy();
            this.mapItem = nil;
        end
        UIListView.ClearItem("QinMainResItem");
        UIListView.ClearItem("QinMainProgressItem");
        RedMgr.Singleton:RemoveViewModel(UIName.QinMainViewModel);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})