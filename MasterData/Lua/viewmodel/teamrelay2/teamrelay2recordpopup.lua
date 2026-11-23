require("Tools/UITool")
require("ViewModel/TeamRelay2/TeamRelay2RecordItem")

local objs = {
    recordItemTemplate = { path = "template/RecordItem", type = UITool.GameObject },
    teamInfoItemTemplate = { path = "template/TeamInfoItem", type = UITool.GameObject },
    headItemTemplate = { path = "template/HeadItem", type = UITool.GameObject },
    recordScrollViewGo = { path = "root/Middle/Group/ScrollView", type = UITool.GameObject },
    recordEmptyGo = { path = "root/Middle/Group/Empty", type = UITool.GameObject },
}

local this = {
    vm = nil,
    plotId = "",
    recordScrollView = nil,
    recordDataList = {},
}

local data = {}

local command = {
    closeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TeamRelay2RecordPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour, this, objs)
        this.recordScrollView = UIScrollView.New(this.recordScrollViewGo)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.InitParameter()
        this.RefreshData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.recordScrollView:Clear(true)
    end,
    before_destroy = function(vm)
        this = nil
        UIScrollView.ClearItem("TeamRelay2RecordItem")
    end
}

this.InitParameter = function()
    this.plotId = this.vm.behaviour.Params[0]
end

this.RefreshData = function()
    local plotData = TeamRelay2Mgr.GetPlotData(this.plotId)
    if plotData == nil or IsNull(plotData.Records) or TableIsNull(plotData.Records) then
        SetActive(this.recordEmptyGo, true)
        return
    end

    this.recordDataList = {}
    for _, recordData in ipairs(plotData.Records) do
        local recordInfo = {
            timestamp = recordData.EndTime,
            totalScore = 0,
            teamInfos = {},
            teamItemTemplate = this.teamInfoItemTemplate,
        }
        if recordData.Teams ~= nil then
            for i = 1, 3 do
                local teamData = recordData.Teams[tostring(i)]
                local teamInfo = {
                    title = string.format(LuaMgr.GetLangText("TeamRelay2RecordPopup_0"), NumTool.GetMaxNum(i)),
                    score = 0,
                    members = {},
                    headItemTemplate = this.headItemTemplate
                }
                if teamData ~= nil then
                    teamInfo.score = teamData.Score
                    teamInfo.members = IsNull(teamData.Members) and {} or teamData.Members
                end
                table.insert(recordInfo.teamInfos, teamInfo)
                recordInfo.totalScore = recordInfo.totalScore + teamInfo.score
            end
        end
        table.insert(this.recordDataList, recordInfo)
    end
    table.sort(this.recordDataList, function(a, b) 
        return a.timestamp > b.timestamp
    end)
    local scrollData, scrollDataList = {}, {}
    for i, v in ipairs(this.recordDataList) do
        local groupData = v
        scrollData = UIScrollData.GetData(this.recordItemTemplate, "TeamRelay2RecordItem", 900, 355, groupData)
        table.insert(scrollDataList, scrollData)
    end

    this.recordScrollView:Clear(false)
    this.recordScrollView:SetParams(900, 445)
    this.recordScrollView:SetPadding(0, 0, 0, 0)
    this.recordScrollView:SetData(scrollDataList, true)

    SetActive(this.recordEmptyGo, #this.recordDataList == 0)
end

return vm({
    data = data,
    command = command,
    hook = hook
})