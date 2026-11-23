
local this = {vm=nil};
local data = {
    goods = {
        id = "",
        count = 0,
        rare = DefaultSprite,
        icon = DefaultTexture,
        showType = ItemShowType.NONE,
        sizeDelta = Vector2(128,128),
        scale = Vector3(0.52, 0.52, 1),
        isClick = true,
        isCount = false,
        isShow = true,
    }
}
local command = {
    btnClickCommand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.OpenURL(ConfigMgr.Config.constants.BZHalfYear2);
        end
    }
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        local reward = ConfigMgr.Config.RewardPreviewMap[ActivityKey.BZHalfYear]
        if reward ~= nil and #reward.Reward > 0 then
            local rewardItem = ConfigMgr.Config.itemMap[reward.Reward[1]];
            this.vm.data.goods = {
                id = rewardItem.id,
                count = 0,
                rare = ActivityMgr.GetRareSprite(rewardItem.rare),
                icon = ActivityMgr.GetItemTexture(rewardItem.id),
                showType = ItemShowType.NONE,
                sizeDelta = Vector2(128,128),
                scale = Vector3(0.52, 0.52, 1),
                isClick = true,
                isCount = false,
                isShow = true,
            }
        end
    end,
    before_deactive = function(vm)
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})