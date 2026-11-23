require("ViewModel/SuiChuNaJi/ViewItem/SCNJFastThroughItem")
local objs = {
    fastThrougth = {path = "template/TeamScore", type = UITool.GameObject},
    totalScore = {path = "root/Middle/TotalBG/TotalScore", type = UITool.Text},
    remainFireCount = {path = "root/Middle/RemainFireCount", type = UITool.Text},
    fastGetBtn = {path = "root/Middle/FastGetBtn", type = UITool.Button},
    fastThrougthScroll = {path = "root/Middle/ScrollView", type = UITool.GameObject}
}

local this = {}

this.before_awake = function()
    this.fastThrougthScrollUI = UIScrollView.New(this.fastThrougthScroll)
end

this.BatchInitNode = function()
end

this.before_active = function()
    local totalScore = this.paramData.fastThroughCount * this.paramData.averageScore
    this.totalScore.text = tostring(totalScore)
    local dailyCount, maxCount = SCNJData.GetChallengeCount()
    this.remainFireCount.text = string.format("<color=#6A2507>%d</color>/%d", dailyCount, maxCount)

    this.fastThrougthScrollUI:Clear()
    local dataLen = this.paramData.fastThroughCount
    local scrollDatas = {}
    local itemWidth = 704
    for i = 1, dataLen do
        local data = {}
        if i < 10 then
            data.IndexName = string.format("0%d", i)
        else
            data.IndexName = string.format("%d", i)
        end
        data.Score = this.paramData.averageScore
        local scrollData = UIScrollData.GetData(this.fastThrougth, "SCNJFastThroughItem", itemWidth, 95, data)
        table.insert(scrollDatas, scrollData)
    end
    this.fastThrougthScrollUI:SetParams(itemWidth, 296)
    this.fastThrougthScrollUI:SetData(scrollDatas, true)
end

this.OnClickFastGetBtn = function()
    LuaMgr.Back()
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.BatchInitNode()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.fastGetBtn, this.OnClickFastGetBtn)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.paramData = vm.behaviour.Params[0]
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.fastGetBtn, this.OnClickFastGetBtn)
        UIScrollView.ClearItem("SCNJFastThroughItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)