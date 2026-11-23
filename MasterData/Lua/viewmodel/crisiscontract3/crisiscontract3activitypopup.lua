local this = {
    vm = nil,
    data = {
        activityData = nil,
    }
}

local data = {
    leftTimeStr = "",
    rewardTipsList = { {} },
}

local command = {
    gotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.CrisisContract3ActivityPopup)
            LuaMgr.ShowLuaPanel(UIName.CrisisContract3MainViewModel);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.CrisisContract3ActivityPopup);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.InitParameter()
        local reward = ConfigMgr.Config.RewardPreviewMap[ActivityKey.crisiscontract3]
        if reward ~= nil then
            local tempList = {}
            for i, v in ipairs(reward.Reward) do
                local rewardItem = ConfigMgr.Config.itemMap[v];
                table.insert(tempList, {
                    id = rewardItem.id,
                    count = 0,
                    rare = ActivityMgr.GetRareSprite(rewardItem.rare),
                    icon = ActivityMgr.GetItemTexture(rewardItem.id),
                    showType = ItemShowType.NONE,
                    sizeDelta = Vector2(128,128),
                    scale = Vector3(1, 1, 1),
                    isClick = true,
                    isCount = false,
                    isShow = true,
                })
            end
            this.vm.data.rewardTipsList = tempList
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveTimer(TimerConst.CrisisContract3Timer)
        RedMgr.Singleton:RemoveViewModel(UIName.CrisisContract3ActivityPopup);
    end,
}


this.InitParameter = function()
    this.activityData = DataExHelper.GetDataExByTag(ActivityKey.crisiscontract3)
    if this.activityData ~= nil then
        this.leftTime = this.activityData.expireTime - LuaMgr.Timestamp();
        LuaMgr.AddTimer(TimerConst.CrisisContract3Timer, this.UpdateLeftTimer, 1, -1, true)
    end
end

this.UpdateLeftTimer = function()
    if this.leftTime <= 0 then
        LuaMgr.RemoveTimer(TimerConst.CrisisContract3Timer)
        return
    end

    this.vm.data.leftTimeStr = CrisisContract3Mgr.GetLeftTimeStr(this.leftTime)
    this.leftTime = this.leftTime - 1
end

return vm({
    data = data,
    command = command,
    hook = hook
})