local this = {
    plotId = "",
    singleScore = 0,
    confirmFunc = nil,
    inputField = nil,
    battleCount = 1,
    dailyLeftCount = 1,
    miniCount = 0,
};

local data = {
    curScore = "",
    totalScore = "",
    dailyLeftCountStr = "",
    tipsStr = "",
}

local command = {
    addBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local count = this.battleCount + 1
            this.CheckValue(count)
            this.inputField.text = this.battleCount
        end
    },
    delBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local count = this.battleCount - 1
            this.CheckValue(count)
            this.inputField.text = this.battleCount
        end
    },
    maxBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local count = this.dailyLeftCount
            this.CheckValue(count)
            this.inputField.text = this.battleCount
        end
    },
    cancelBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.MiniBattle4DelegetePopup)
        end
    },

    confirmBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.dailyLeftCount == 0 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("25222"));
                return
            end
            if this.confirmFunc ~= nil then
                this.confirmFunc(this.battleCount)
            end
            LuaMgr.HidePanel(UIName.MiniBattle4DelegetePopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.inputField = vm.behaviour.transform:Find("root/Middle/Group/InputField"):GetComponent("InputField")
        this.inputField.onEndEdit:AddListener(this.OnValueChanged)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.plotId = vm.behaviour.Params[0]
        this.confirmFunc = vm.behaviour.Params[1]
        local plotCfg = MiniBattle4Mgr.GetPlotCfg(this.plotId)
        this.singleScore = MiniBattle4Mgr.GetPlotBestScore(this.plotId)
        this.vm.data.curScore = this.singleScore
        local dailyLeftCount, dailyTotalCount = MiniBattle4Mgr.GetSeriesLeftChallengeCount(plotCfg.SeriesId)
        this.vm.data.dailyLeftCountStr = string.format(LuaMgr.GetLangText("MiniBattle4DelegetePopup_0"),
                dailyLeftCount, dailyTotalCount)
        this.OnValueChanged(this.battleCount)
        this.inputField.text = this.battleCount
        this.miniCount = this.dailyLeftCount == 0 and 0 or 1
        this.dailyLeftCount = dailyLeftCount
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

this.OnValueChanged = function(str)
    local count = tonumber(str)
    this.CheckValue(count)
end

this.CheckValue = function(count)
    if count < this.miniCount then
        count = this.miniCount
    elseif count > this.dailyLeftCount then
        count = this.dailyLeftCount
    end
    this.battleCount = count
    this.vm.data.totalScore = this.singleScore * this.battleCount
end

return vm({
    data = data,
    command = command,
    hook = hook
})