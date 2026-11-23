require("ViewModel/Guild/GuildBuildItem")
local this = {
    vm = nil,
    
}

local data = {
    haveGuildLevelUpPermission = false,
    haveAnnounceChangePermission = false,
    guildName = "",
    guildLevel = "",
    guildAnnounce = "",
    guildHonor = "",
    guildMember = "",
    leaderName = "",
    guildMsgData = {{msg = ""}},
}

local objs = {
    guildInfo =  { path = "root/Left/GuildInfo", type = "GameObject" },
    filterInput =  { path = "root/Left/GuildInfo/scrollrect/Viewport/FilterInput", type = "InputField" },
}

local GuildInfo = {}

local command = {
    GuildLevelUpCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)


            if GuildInfo.guildLevel >= PlayerGuildMgr.GetGuildMaxLevel() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30194"));
                return;
            end






            local consume = PlayerGuildMgr.GetGuildConfigByLevel(tostring(GuildInfo.guildLevel)).levelUpConsume;
            LuaMgr.ShowConfirmSmallViewModel(string.format(LuaMgr.GetLangText("GuildInfoViewModel_1"),tostring(consume)),function ()
                PlayerGuildMgr.LevelUp(function()
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("GuildLevelUpConfirmViewModel_0"));
                end)
            end,nil);
        end
    },
    GuildChangeAnnounceCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if IsNullOrEmpty(this.filterInput.text) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("GuildInfoViewModel_0"));
                return
            end
            PlayerGuildMgr.ChangeAnnounce(this.filterInput.text, function()
                this.RefreshGuildInfo();
                this.filterInput.text = GuildInfo.guildAnnounce;
            end)
        end
    },

    OpenGuildMemberListCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.GuildMemberListViewModel)
        end
    },
    
    CloseGuildInfoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.GuildInfoViewModel);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour, this, objs);
    end,
    before_active = function(vm)
        this.RefreshGuildInfo()
        this.filterInput.text = GuildInfo.guildAnnounce;
        this.filterInput.onEndEdit:AddListener(this.OnFilterEndEdit);
        LuaMgr.AddUIEventListener(UIEventConst.UpdateGuild, this.RefreshGuildInfo);
        RedMgr.Singleton:RegisterViewModel(UIName.GuildInfoViewModel);
    end,
    before_deactive = function(vm)
        this.filterInput.onEndEdit:RemoveListener(this.OnFilterEndEdit);
        LuaMgr.RemoveUIEventListener(UIEventConst.UpdateGuild, this.RefreshGuildInfo);
        PlayerGuildMgr.GuildRefreshSuccessCallBack = nil
        PlayerGuildMgr.GuildRefreshFailCallBack = nil
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.RefreshGuildInfo = function()
    GuildInfo = PlayerGuildMgr.GuildInfo();
    this.RefreshMsgInfo();
    this.RefreshPermission();
    
    local guildConfig = PlayerGuildMgr.GetGuildConfigByLevel(GuildInfo.guildLevel)
    if guildConfig == nil then
        LuaMgr.Back();
        return
    end
    this.vm.data.guildName = GuildInfo.guildName;
    this.vm.data.guildLevel = "Lv." .. GuildInfo.guildLevel;
    this.vm.data.guildMember = #GuildInfo.memberList .. "/" .. guildConfig.maximumcapacity;
    this.vm.data.leaderName = GuildInfo.leaderName;
    this.vm.data.guildHonor = GuildInfo.guildHonor;
    
end

this.OnGuildLevelUp = function()
    this.RefreshGuildInfo()
    this.filterInput.text = GuildInfo.guildAnnounce;
end

this.RefreshPermission = function()
    this.vm.data.haveGuildLevelUpPermission = PlayerGuildMgr.GetGuildLevelUpPermission();
    this.vm.data.haveAnnounceChangePermission = PlayerGuildMgr.GetGuildAnnounceChangePermission();
end

this.OnFilterEndEdit = function(value)
    this.vm.data.guildAnnounce = value;
end


this.RefreshMsgInfo = function()
    this.vm.data.guildMsgData = {};
    local tempList = {};
    if GuildInfo.msg == nil then
        return;
    end
    local len = #GuildInfo.msg
    for i = 1, len do
        local msgData = {msg = ""};
        msgData.msg = GuildInfo.msg[i].msg
        table.insert(tempList,msgData)
    end
    this.vm.data.guildMsgData = tempList;
end


return vm({
    data = data,
    command = command,
    hook = hook
})