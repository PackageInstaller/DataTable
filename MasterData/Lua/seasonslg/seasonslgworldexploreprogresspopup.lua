require("SeasonSLG/SeasonSLGWorldExploreProgressRewardItem")

local this = {
    vm = nil,
    limitRewardTemp = nil,
    limitRewardScroll = nil,
    config = nil,
};

local data =
{
    progress = 0.0,
    progressText = "0%",
    toggleList = {{select = false,title = "",tag = 1}},
    eventList = {{time = "", content = "",jumpGrid = ""}},
    resAddList = {{progress = "", icon = DefaultTexture, addition = ""}},
    fightAddList = {{progress = "", buffInfo = "",buffName = "",buffIcon = DefaultSprite}},
    showEvent = true,
    showResAdd = false,
    showFightAdd = false,
    showLimitReward = false,
}

local curProgress = 0;

local command =
{
    OnClickTag = {
    type = XLuaCommandType.Void,
    execute = function(vm, param)
        for i, v in ipairs(this.vm.data.toggleList) do
            v.select = false
        end
        this.vm.data.toggleList[param + 1].select = true
        this.SetContent(this.vm.data.toggleList[param + 1].tag)
    end },
    gotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local event = this.vm.data.eventList[param + 1];
            SeasonSLGMapMgr.JumpToMapGrid(event.jumpGrid)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.limitRewardTemp = vm.behaviour.transform:Find("template/LimitRewardItem").gameObject;
        local limitRewardScrollGo = vm.behaviour.transform:Find("root/Middle/content/LimitRewardScrollView").gameObject;
        this.limitRewardScroll = UIScrollView.New(limitRewardScrollGo)
        this.config = ConfigMgr.Config.SeasonalProgressReward
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        vm.behaviour:UpdateTopBar("", LuaMgr.Back);
        curProgress = SeasonSLGTimeEventMgr.GetWorldProgress()
        this.vm.data.progress = curProgress / 10000.0
        this.vm.data.progressText = tostring(curProgress / 100.0) .. "%"
        this.InitScrollView();

        LuaMgr.AddUIEventListener(UIEventConst.SeasonSLGTimedEventTrigger, this.InitScrollView)
        LuaMgr.AddUIEventListener(UIEventConst.SeasonSLGWorldProgressChange, this.InitScrollView)
        LuaMgr.AddUIEventListener(UIEventConst.SeasonSLGTimedEventEnd, this.InitScrollView)

        LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGWorldProgressChange, 0, nil)

        local tempList = {
            {select = true,title = LuaMgr.GetLangText("SeasonSLGWorldExploreProgressPopup_0"),tag = 1},
            {select = false,title = LuaMgr.GetLangText("SeasonSLGWorldExploreProgressPopup_1"),tag = 2},
            {select = false,title = LuaMgr.GetLangText("SeasonSLGWorldExploreProgressPopup_2"),tag = 3},
            {select = false,title = LuaMgr.GetLangText("SeasonSLGWorldExploreProgressPopup_3"),tag = 4},
        }
        this.vm.data.toggleList = tempList

        this.SetContent(1)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if this.limitRewardScroll ~= nil then
            this.limitRewardScroll:Clear(false)
        end
        LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGTimedEventTrigger, this.InitScrollView)
        LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGWorldProgressChange, this.InitScrollView)
        LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGTimedEventEnd, this.InitScrollView)
    end,
    before_destroy = function()
        UIScrollView.ClearItem("SeasonSLGWorldExploreProgressRewardItem")
    end
}

this.InitScrollView = function()
    if this.config == nil then
        return;
    end
    this.limitRewardScroll:Clear(false)
    local scrollDatas = {};;
    local fightAddDatas = {};
    local resAddDatas = {};
    local timedEventDatas = {};
    local timedEventData = {};
    local itemData = {};
    local fightAddData = {};
    local resAddData = {};

    local timedEventList = SeasonSLGTimeEventMgr.GetActiveEventList()
    for i = 1, #timedEventList do
        timedEventData = {};
        local time = Get_Beijing_Time(SeasonSLGTimeEventMgr.activityInfo.startTime + SeasonSLGTimeEventMgr.GetTimedEventTriggerTime(timedEventList[i]))
        timedEventData.time = string.format(LuaMgr.GetLangText("SeasonSLGWorldExploreProgressPopup_4"),time.month,time.day,time.hour,time.min)
        timedEventData.content = LuaMgr.GetLangText(timedEventList[i].DescLan)
        timedEventData.jumpGrid = timedEventList[i].CoverGridID[1]
        table.insert(timedEventDatas,timedEventData)
    end

    for k, v in pairs(this.config) do
        for i = 1, #v.AreaBuff do
            local buffConfig = ConfigMgr.Config.SeasonalProduceBuffMap[v.AreaBuff[i]]
            resAddData =
            {
                progress = string.format(LuaMgr.GetLangText("SeasonSLGWorldExploreProgressPopup_5"),tostring(v.Progress / 100.0) .. "%"),
                icon = LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(buffConfig.Type[1]));
                addition = string.format(LuaMgr.GetLangText(buffConfig.NameLan),buffConfig.Para1)
            }
            table.insert(resAddDatas,resAddData)
        end

        for i = 1, #v.DungeonBuff do
            local buffConfig = ConfigMgr.Config.SeasonalBuffMap[v.DungeonBuff[i]]
            if buffConfig ~= nil then
                fightAddData =
                {
                    progress = string.format(LuaMgr.GetLangText("SeasonSLGWorldExploreProgressPopup_6"),tostring(v.Progress / 100.0) .. "%"),
                    buffInfo = LuaMgr.GetLangText(buffConfig.BuffDesLan),
                    buffIcon = LuaMgr.GetSprite("BuffIcon",buffConfig.BuffIcon),
                    buffName = LuaMgr.GetLangText(buffConfig.BuffNameLan)
                }
                table.insert(fightAddDatas,fightAddData)
            end
        end

        itemData = {};
        local item = {}
        for key, value in pairs(v) do
            item[key] = value
        end
        itemData.item = item
        itemData.currentProgress = curProgress
        itemData.targetProgress = v.Progress
        itemData.onClick = this.GetReward
        itemData = UIScrollData.GetData(this.limitRewardTemp, "SeasonSLGWorldExploreProgressRewardItem", 1200, 100, itemData)
        table.insert(scrollDatas, itemData)
    end
    this.limitRewardScroll:SetParams(1200, 390)
    this.limitRewardScroll:SetData(scrollDatas, true)
    this.vm.data.fightAddList = fightAddDatas;
    this.vm.data.resAddList = resAddDatas;
    this.vm.data.eventList = timedEventDatas;
end

this.GetReward = function(progress)
    ApiMgr.Request("seasonal/progress/reward", {Progress = tonumber(progress)}, true, function(result)
        local re=json.decode(result);
        local rewardData=json.encode(re.result);
        LuaMgr.ShowItemRewared(rewardData);
        this.InitScrollView()
    end, function(code)
    end, true,false);
end

this.SetContent = function(tag)
    this.vm.data.showEvent = tag == 1
    this.vm.data.showResAdd = tag == 2
    this.vm.data.showFightAdd = tag == 3
    this.vm.data.showLimitReward = tag == 4
end

return vm({
    data = data,
    command = command,
    hook = hook
})