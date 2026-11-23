local this = {
    vm = nil,
    curPage = 1
};

local data = {
    showEnemy = false,
    showSelf = false,
    buffList = {
        { name = "", desc = "", icon = DefaultSprite, animatorObj = false }
    }
}

local command = {
    switchEnemyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curPage == 1 then
                return
            end
            this.curPage = 1
            this.Refresh()
        end
    },
    switchSelfCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curPage == 2 then
                return
            end
            this.curPage = 2
            this.Refresh()
        end
    },
    closeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.Close()
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
        this.SelfBuffList = vm.behaviour.Params[0]
        this.EnemyLevelId = vm.behaviour.Params[1]
        this.curPage = vm.behaviour.Params[2]
        this.Refresh()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveTimer(TimerConst.MiniBattleNewBuffDetailShowDelay)
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

this.Refresh = function()
    local tempList = {}
    local listCount = 0
    if this.curPage == 1 then
        local levelCfg = ConfigMgr.Config.DualBattleBuffMap[this.EnemyLevelId]
        if not TableIsNull(levelCfg) then
            for i, v in ipairs(levelCfg.BuffGroup) do
                local buffCardData = MiniBattle3Mgr.GetBuffCardInfo(v)
                buffCardData.animatorObj = false
                table.insert(tempList, buffCardData)
            end
        end
    elseif this.curPage == 2 then
        for i, v in ipairs(this.SelfBuffList) do
            local buffCardData = MiniBattle3Mgr.GetBuffCardInfo(v)
            buffCardData.animatorObj = false
            table.insert(tempList, buffCardData)
        end
    end
    listCount = #tempList
    this.vm.data.buffList = tempList
    this.vm.data.showEnemy = this.curPage == 1
    this.vm.data.showSelf = this.curPage == 2

    local index = 1
    LuaMgr.RemoveTimer(TimerConst.MiniBattleNewBuffDetailShowDelay)
    LuaMgr.AddTimer(TimerConst.MiniBattleNewBuffDetailShowDelay,function()
        if index > listCount then
            LuaMgr.RemoveTimer(TimerConst.MiniBattleNewBuffDetailShowDelay)
            return
        end
        this.vm.data.buffList[index].animatorObj = true
        index = index + 1
    end,0.05,-1,false)
end

this.Close = function()
    LuaMgr.HidePanel(UIName.MiniBattle3BuffDetailPopup);
end

return vm({
    data = data,
    command = command,
    hook = hook
})