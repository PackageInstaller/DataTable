local this = {
    vm = nil,
    
}
local objs = {
    costItem = { path = "root/Middle/GoodsItem", type = "GoodsViewModel" },
}
local data = {
    tip = "",
}

local command = {

    ConfirmCommand =
    {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            PlayerGuildMgr.LevelUp(this.OnGuildLevelUp)
            LuaMgr.HidePanel(UIName.GuildLevelUpConfirmViewModel);
        end
    },
    
    ClosePanelCommand =
    {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.GuildLevelUpConfirmViewModel);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour, this, objs);

    end,
    before_active = function(vm)
        this.RefreshCostInfo()
    end,
    before_deactive = function(vm)

    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.OnGuildLevelUp = function()
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("GuildLevelUpConfirmViewModel_0"));
end

this.RefreshCostInfo = function()
    local GuildInfo = PlayerGuildMgr.GuildInfo()
    local item = PlayerGuildMgr.GetGuildConfigByLevel(tostring(GuildInfo.guildLevel)).consume;

    local itemName = ConfigMgr.Config.itemMap[item.id].nameLan
    this.vm.data.tip = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30116"),item.count,tostring(GuildInfo.guildLevel + 1));

    this.costItem:SetData(tostring(item.id),item.count,1,1,true)
end

return vm({
    data = data,
    command = command,
    hook = hook
})