require("ViewModel/TRJ/TRJMarketItem")

local this = {
    firstProgressData = 0.1,
    deltaProgress = 0.2
}
local objs = {
    itemModel = {path = "template/ItemModel", type = UITool.GameObject},
    downTimeTxt = {path = "root/Middle/DownTimeBG/DownTimeTxt", type = UITool.Text},
    scrollView = {path = "root/Middle/ScrollView", type = UITool.GameObject},
    progress = {path = "root/Middle/ScrollView/Viewport/Content/SliderScore", type = UITool.Slider},
    scoreText = {path = "root/Middle/TotalScore/ScoreText", type = UITool.Text},
    jumpBtn={path = "root/Middle/_JumpBtn", type = UITool.Button},
}

this.before_awake = function()
    this.scrollViewUI = UIScrollView.New(this.scrollView)
end

this.before_active = function()
    this.ParseData()
    this.RefreshScrollView()
end

this.ParseData=function()
    HeroRedDataHelper.SetZNFLRechargeRed();
    if this.QuestCelebrationRecharge == nil then
        this.QuestCelebrationRecharge = DataExHelper.Check_ConfigQuestEventByText("ZNFLRecharge")
    end
    local quests = DataMgr.Player.quests
    local len = #this.QuestCelebrationRecharge
    this.allDatas = {}
    this.totalProgress = 0
    this.canGetCount = 0
    for i = 1, len do
        local questConfig = this.QuestCelebrationRecharge[i]
        local questData = quests[questConfig.id]
        local data = {}
        data.config = questConfig
        data.rewards = questConfig.showReward
        data.goalProgress = questConfig.progress
        data.status = questData and questData.state or (CommonRewardItem.Status.None + 1)
        data.questData = questData
        if data.status > 1 then
            this.totalProgress = this.totalProgress + 1
        end
        if (data.status - 1) == CommonRewardItem.Status.CanGet then
            this.canGetCount = this.canGetCount + 1
        end
        table.insert(this.allDatas, data)
    end
    return this.allDatas, this.totalProgress, this.canGetCount
end
    



this.RefreshScrollView = function()
    this.scrollViewUI:Clear()
    if this.allDatas == nil then
        return
    end
    local needItemId = 0
    local scrollDatas = {}
    local lastFinishIndex = nil
    for i = 1, #this.allDatas do
        local data = this.allDatas[i]
        data.onGetCallback = this.GetRewardCallback
        if #data.config.conditionArgs > 0 then
            needItemId = data.config.conditionArgs[1]
        end
        local tempData = UIScrollData.GetData(this.itemModel, "TRJMarketItem", 204, 372, data)
        table.insert(scrollDatas, tempData)
        if data.status == CommonRewardItem.Status.CanGet and lastFinishIndex == nil then
            lastFinishIndex = i
        end
    end
    this.scrollViewUI:SetParams(1060 , 450)
    this.scrollViewUI:SetData(scrollDatas, true)
    if lastFinishIndex == nil then
        for i = 1, #this.allDatas do
            local data = this.allDatas[i]
            if data.status == CommonRewardItem.Status.Got then
                lastFinishIndex = i
            end
        end
    end
    if lastFinishIndex ~= nil then
        local index = math.max(1, lastFinishIndex - 1)
        this.scrollViewUI:MoveToIndex(index) 
    end
    this.progress.value = this.GetProgress(this.allDatas)
    this.scoreText.text = tostring(DataMgr.Player.Anniversary2Point or 0)
end

this.GetProgress = function(allDatas)
    local curCharge = DataMgr.Player.Anniversary2Point or 0
    if this.areaDatas == nil then
        this.areaDatas = {}
        for i = 0, #allDatas - 1 do
            local dataStart = allDatas[i]
            local dataEnd = allDatas[i + 1]
            local startGoal, endGoal = 0, 0
            if dataStart ~= nil then
                startGoal = dataStart.goalProgress
            end
            if dataEnd ~= nil then
                endGoal = dataEnd.goalProgress
            end
            local areaData = {}
            areaData.startGoal = startGoal
            areaData.endGoal = endGoal
            areaData.deltaCharge = endGoal - startGoal
            if i == 0 then
                areaData.totalProgress = this.firstProgressData
            else
                areaData.totalProgress = this.deltaProgress
            end
            table.insert(this.areaDatas, areaData)
        end
    end

    local totalProgress = 0
    for i = 1, #this.areaDatas do
        local data = this.areaDatas[i]
        if curCharge >= data.endGoal then
            totalProgress = totalProgress + data.totalProgress
        elseif curCharge >= data.startGoal and curCharge < data.endGoal then
            local delta = (curCharge - data.startGoal) / data.deltaCharge
            totalProgress = totalProgress + data.totalProgress * delta
            break
        else
            break
        end
    end
    return totalProgress
end



this.GetRewardCallback = function(item)
    DataExHelper.EX_GetAward(item.data.config.id, function()
        this.ParseData();
        this.RefreshScrollView();
    end)
end

this.OnRefreshTime = function()
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.ZNFL)
    local time = activityData.expireTime - LuaMgr.Timestamp()
    if time <= 0 then
        return LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_18344")
    end
    local timeStr = ""
    local d, h, m = GetTimeDHM(time)
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"))
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"))
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"))
    end
    this.downTimeTxt.text = timeStr
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.jumpBtn,function()
            LuaMgr.ShowLuaPanel(UIName.MainShopViewModel,"charge")
            HeroParameter.SaveActivityKey(ActivityKey.ZNFL)
        end)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.AddTimer(TimerConst.ShangTingHuiKuiTimer, this.OnRefreshTime, 60, -1, true)
        this.before_active()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.ShangTingHuiKuiTimer)
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("TRJMarketItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)