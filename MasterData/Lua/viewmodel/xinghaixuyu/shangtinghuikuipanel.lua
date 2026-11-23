require("ViewModel/XingHaiXuYu/ViewItem/ShangTingItem")

local this = {
    firstProgressData = 0.076,
    deltaProgress = 0.154
}
local objs = {
    itemModel = {path = "template/ItemModel", type = UITool.GameObject},
    downTimeTxt = {path = "root/Middle/DownTimeBG/DownTimeTxt", type = UITool.Text},
    scrollView = {path = "root/Middle/ScrollView", type = UITool.GameObject},
    progress = {path = "root/Middle/ScrollView/Viewport/Content/ProgressBG/Progress", type = UITool.Image},
    scoreText = {path = "root/Left/TotalScore/ScoreText", type = UITool.Text}
}

this.before_awake = function()
    this.scrollViewUI = UIScrollView.New(this.scrollView)
end

this.before_active = function()
    this.RefreshScrollView()
end

this.RefreshScrollView = function()
    this.scrollViewUI:Clear()
    local allDatas, totalProgress = XingHaiData.GetShopFeedDatas()
    if allDatas == nil then
        return
    end
    local needItemId = 0
    local scrollDatas = {}
    local lastFinishIndex = nil
    for i = 1, #allDatas do
        local data = allDatas[i]
        data.onGetCallback = this.GetRewardCallback
        if #data.config.conditionArgs > 0 then
            needItemId = data.config.conditionArgs[1]
        end
        local tempData = UIScrollData.GetData(this.itemModel, "ShangTingItem", 228, 352, data)
        table.insert(scrollDatas, tempData)
        if data.status == CommonRewardItem.Status.CanGet and lastFinishIndex == nil then
            lastFinishIndex = i
        end
    end
    local offsetX = LuaMgr.GetScreenWidth() - 1280
    this.scrollViewUI:SetParams(1150 + offsetX, 417)
    this.scrollViewUI:SetData(scrollDatas, true)
    if lastFinishIndex == nil then
        for i = 1, #allDatas do
            local data = allDatas[i]
            if data.status == CommonRewardItem.Status.Got then
                lastFinishIndex = i
            end
        end
    end
    if lastFinishIndex ~= nil then
        local index = math.max(1, lastFinishIndex - 1)
        this.scrollViewUI:MoveToIndex(index)
    end
    this.progress.fillAmount = this.GetProgress(allDatas)
    this.scoreText.text = tostring(DataMgr.Player.AnniHalfChargePoint or 0)
end

this.GetProgress = function(allDatas)
    local curCharge = DataMgr.Player.AnniHalfChargePoint or 0
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
    DataExHelper.EX_GetAward(item.data.config.id, this.RefreshScrollView)
end

this.OnRefreshTime = function()
    this.downTimeTxt.text = XingHaiData.GetRemainTimeStr()
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
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
        UIScrollView.ClearItem("ShangTingItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)