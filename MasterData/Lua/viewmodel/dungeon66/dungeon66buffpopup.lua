local this = {
    vm = nil,
    campPlotCfg = nil,
};

local data = {
    upDesc = "",
    downDesc = "",
}

local command = {
    closeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.Dungeon66BuffPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        local curSeriesId=TrainingCampMgr.GetCurWheelSeriesID();
        if curSeriesId==nil then
            print("lose config for curSeries")
            return
        end;
        local campSeries = TrainingCampMgr.GetCampSeries(curSeriesId);
        if this.campPlotCfg == nil then
            local levelDatas = TrainingCampMgr.GetCampPlots(campSeries.ID);
            this.campPlotCfg = levelDatas[1]
        end
        this.vm.data.upDesc = LuaMgr.GetLangText(this.campPlotCfg.BuffShow1Lan)
        this.vm.data.downDesc = LuaMgr.GetLangText(this.campPlotCfg.BuffShow2Lan)
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


return vm({
    data = data,
    command = command,
    hook = hook
})