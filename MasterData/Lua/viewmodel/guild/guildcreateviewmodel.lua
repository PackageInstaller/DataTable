local this = {
    vm = nil,
    
}
local objs = {
    limitToggle = { path = "root/Middle/Condition/limit", type = "Toggle" },
    noLimitToggle = { path = "root/Middle/Condition/Nolimit", type = "Toggle" },
    filterInput =  { path = "root/Middle/guildName/input", type = "InputField" },
    priceIcon=  { path = "root/Middle/cost/icon", type = "RawImage" },
    
}
local data = {
    levelLimit = "0",
    guildName = "",
    price = "",
}

local command = {
    CreateCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if IsNullOrEmpty(this.filterInput.text) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30138"));
                return;
            end
            PlayerGuildMgr.CreateGuild(this.filterInput.text,this.limitToggle.isOn,tonumber(this.vm.data.levelLimit),function()
                LuaMgr.HidePanel(UIName.GuildCreateViewModel);
                LuaMgr.HidePanel(UIName.GuildEnterViewModel);
                LuaMgr.ShowLuaPanel(UIName.GuildMainViewModel);
            end)
        end
    },
    
    ChangeLevelLimitCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local num = tonumber(param);
            local level = tonumber(this.vm.data.levelLimit) + num;
            local cfgMaxLevel = ConfigMgr.Config.constants.maxPlayerLevel
            if level <= 0 then
                level = 0;
            end
            if level > cfgMaxLevel then
                level = cfgMaxLevel
            end
            this.vm.data.levelLimit = tostring(level)
        end
    },
    
    ClosePanelCommand =
    {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.GuildCreateViewModel);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour, this, objs);

    end,
    before_active = function(vm)
        this.vm.behaviour:UpdateTopBar("")
        this.guildName = "";
        this.limitToggle.isOn = true;
        this.noLimitToggle.isOn = false;
        local config = ConfigMgr.Config.constants.GuildCreationCost;
        if config ~= nil and ConfigHelper.GetTableLength(config) > 0 then
            this.priceIcon.texture = LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(config[1].id))
            this.vm.data.price = tostring(config[1].count)
        end
        this.filterInput.onValueChanged:AddListener(this.OnFilterValueChanged)
    end,
    before_deactive = function(vm)
        this.filterInput.onValueChanged:RemoveListener(this.OnFilterValueChanged)
    end,
    before_destroy = function(vm)
        this = nil
    end,
}
this.OnFilterValueChanged = function(str)
    this.filterInput.onValueChanged:RemoveListener(this.OnFilterValueChanged)
    this.filterInput.text = this.FilterSymbol(str)
    this.filterInput.onValueChanged:AddListener(this.OnFilterValueChanged)
end

this.FilterSymbol = function(str)
    if not str then return "" end
    local result = ""
    local i = 1
    local len = #str

    while i <= len do
        local b = string.byte(str, i)


        if (b >= 48 and b <= 57) or
                (b >= 65 and b <= 90) or
                (b >= 97 and b <= 122) then
            result = result .. string.sub(str, i, i)
            i = i + 1
            

        elseif b >= 228 and b <= 233 and i+2 <= len then
            result = result .. string.sub(str, i, i+2)
            i = i + 3


        else
            i = i + 1
        end
    end
    return result
end

return vm({
    data = data,
    command = command,
    hook = hook
})