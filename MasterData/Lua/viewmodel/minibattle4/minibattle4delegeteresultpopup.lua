local this = {
    dungeonNameText = nil,
};

local data = {
    totalScore = "",
    dailyLeftCountStr = "",
    resultList = {
        { num1 = "", num2 = "", score = "", animatorObj = false }
    }
}

local command = {
    confirmBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.MiniBattle4DelegeteResultPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.dungeonNameText = vm.behaviour.transform:Find("root/Middle/Group/TotalScore/DungeonName"):GetComponent("Text");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end

        local count = vm.behaviour.Params[0]
        local plotId = vm.behaviour.Params[1]
        local dungeonId = vm.behaviour.Params[2]
        local plotCfg = MiniBattle4Mgr.GetPlotCfg(plotId)
        local dungeonConfig = ConfigMgr.Config.dungeonMap[dungeonId];
        local score = MiniBattle4Mgr.GetPlotBestScore(plotId)
        this.vm.data.totalScore = tostring(score * count)
        local tempList = {}
        for i = 1, count do
            table.insert(tempList, {
                num1 = tostring(0),
                num2 = tostring(i),
                score = tostring(score),
                animatorObj = false,
            })
        end
        this.vm.data.resultList = tempList
        this.dungeonNameText.text = LuaMgr.GetLangText(dungeonConfig.NameLan)
        local dailyLeftCount, dailyTotalCount = MiniBattle4Mgr.GetSeriesLeftChallengeCount(plotCfg.SeriesId)
        this.vm.data.dailyLeftCountStr = string.format(LuaMgr.GetLangText("MiniBattle4DelegeteResultPopup_0"),
                dailyLeftCount, dailyTotalCount)
        this.vm.data.dailyLeftCountStr = leftCountStr

        local listCount = #tempList
        local index = 1
        LuaMgr.RemoveTimer(TimerConst.MiniBattleNewBuffDelegateShowDelay)
        LuaMgr.AddTimer(TimerConst.MiniBattleNewBuffDelegateShowDelay,function()
            if index > listCount then
                LuaMgr.RemoveTimer(TimerConst.MiniBattleNewBuffDelegateShowDelay)
                return
            end
            this.vm.data.resultList[index].animatorObj = true
            index = index + 1
        end,0.05,-1,false)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveTimer(TimerConst.MiniBattleNewBuffDelegateShowDelay)
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})