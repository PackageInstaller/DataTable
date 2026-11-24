local this = {
    vm = nil,

}
local objs = {
    filterInput =  { path = "root/Middle/guildName/input", type = "InputField" },
    priceIcon=  { path = "root/Middle/CreateBtn/cost/icon", type = "RawImage" },

}
local data = {
    guildName = "",
    price = "",
}

local command = {
    RenameCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if IsNullOrEmpty(this.filterInput.text) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30138"));
                return;
            end
            PlayerGuildMgr.RenameGuild(this.filterInput.text,function()
                LuaMgr.HidePanel(UIName.GuildRenameViewModel);
            end)
        end
    },

    ClosePanelCommand =
    {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.GuildRenameViewModel);
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

        local config = ConfigMgr.Config.GuildConstants.GuildRenameCost;
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