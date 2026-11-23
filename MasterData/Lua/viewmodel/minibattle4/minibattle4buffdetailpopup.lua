local this = {
    vm = nil,
};

local data = {
    buffList = {
        { name = "", desc = "", icon = DefaultTexture, kuang1 = false, kuang2 = false, animatorObj = false }
    }
}

local command = {
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
        this.levelId = vm.behaviour.Params[0]
        this.Refresh()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveTimer(TimerConst.MiniBattle4BuffDetailShowDelay)
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

this.Refresh = function()
    local tempList = {}
    local levelCfg = MiniBattle4Mgr.GetLevelCfg(this.levelId)
    if not TableIsNull(levelCfg) then
        for i, v in ipairs(levelCfg.BuffGroup) do
            local buffCardData = MiniBattle4Mgr.GetBuffCardInfo(v)
            if buffCardData ~= nil then
                buffCardData.animatorObj = false
                table.insert(tempList, buffCardData)
            end
        end
    end
    this.vm.data.buffList = tempList

    local listCount = #tempList
    local index = 1
    LuaMgr.RemoveTimer(TimerConst.MiniBattle4BuffDetailShowDelay)
    LuaMgr.AddTimer(TimerConst.MiniBattle4BuffDetailShowDelay,function()
        if index > listCount then
            LuaMgr.RemoveTimer(TimerConst.MiniBattle4BuffDetailShowDelay)
            return
        end
        this.vm.data.buffList[index].animatorObj = true
        index = index + 1
    end,0.05,-1,false)
end

this.Close = function()
    LuaMgr.HidePanel(UIName.MiniBattle4BuffDetailPopup);
end

return vm({
    data = data,
    command = command,
    hook = hook
})