require("Tools/UITool")

local objs = {
    scoreTxt_1 = { path = "root/Middle/Group/TeamInfoList/TeamInfo_1/Group/Value", type = UITool.Text },
    scoreTxt_2 = { path = "root/Middle/Group/TeamInfoList/TeamInfo_2/Group/Value", type = UITool.Text },
    scoreTxt_3 = { path = "root/Middle/Group/TeamInfoList/TeamInfo_3/Group/Value", type = UITool.Text },
    totalScoreTxt = { path = "root/Middle/Group/Content/TotalScore", type = UITool.Text },
}

local this = {
    vm = nil,
    plotId = "",
};

local data = {}

local command = {
    closeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TeamRelay2ChallengeResultPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        UITool.Parse(vm.behaviour, this, objs);
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
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

this.InitParameter = function()
    this.plotId = this.vm.behaviour.Params[0]
end

this.RefreshData = function()
    local plotData = TeamRelay2Mgr.GetPlotData(this.plotId)
    local score1, score2, score3 = 0, 0, 0
    if plotData ~= nil and not TableIsNull(plotData.Teams) then
        if plotData.Teams["1"] ~= nil then
            score1 = plotData.Teams["1"].Score
        end
        if plotData.Teams["2"] ~= nil then
            score2 = plotData.Teams["2"].Score
        end
        if plotData.Teams["3"] ~= nil then
            score3 = plotData.Teams["3"].Score
        end
    end
    this.scoreTxt_1.text = string.format(LuaMgr.GetLangText("TeamRelay2ChallengeResultPopup_0"), tostring(score1))
    this.scoreTxt_2.text = string.format(LuaMgr.GetLangText("TeamRelay2ChallengeResultPopup_1"), tostring(score2))
    this.scoreTxt_3.text = string.format(LuaMgr.GetLangText("TeamRelay2ChallengeResultPopup_2"), tostring(score3))
    this.totalScoreTxt.text = tostring(score1 + score2 + score3)
end

return vm({
    data = data,
    command = command,
    hook = hook
})