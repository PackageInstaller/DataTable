local this = {
    vm = nil,
    rewardJson = "",
}

local data = {
    playerName = "",
    itemData = {id="0",count="0",sizeDelta=Vector2.zero,isCount=true,rare=DefaultSprite,icon=DefaultTexture,scale=Vector3.zero,isClick=true};
}


this.SetItem = function(rewards)
    this.rewardJson = json.encode(rewards);
    local reward = rewards.Items;
    for _, v in pairs(reward) do
        local itemConfig = ConfigMgr.Config.itemMap[v.id];
        if (itemConfig ~= nil) then
            local itemData = {id=itemConfig.id,
                              count=tostring(v.count),
                              sizeDelta=Vector2(100,100),scale=Vector3(0.78,0.78,1),isCount=true,
                              rare=GetRareSprite(itemConfig.rare),
                              icon=GetItemTexture(itemConfig.id),
                              isClick=true};
            this.vm.data.itemData = itemData;
        end
        break;
    end
end


this.OnClose = function()
    LuaMgr.HidePanel(UIName.FoundationSurpriseViewModel);
end

local command = {
    OnClickConfirm = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowItemRewared(this.rewardJson);
            LuaMgr.NextFrame(this.OnClose);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.vm.data.playerName = string.format(LuaMgr.GetLangText("FoundationSurpriseViewModel_1"), DataMgr.Player.name);
        this.SetItem(vm.behaviour.Params[0]);
    end,
    before_deactive = function(vm)
        this.rewardJson = "";
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})