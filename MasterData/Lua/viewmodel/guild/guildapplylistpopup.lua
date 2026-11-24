local this = {
    vm = nil,
    filterBtnClickTime = 0,
}
local objs = {
    filterInput =  { path = "root/Middle/op/searchGuild/FilterInput", type = "InputField" },
}
local data = {
    guildList = {{guildName = "1111111111",guildId = 0,guildLevel = "",guildMember = "",ApplyCondition = 10,GuildAnnounce = "123123123",LeaderName = "222",guildMemberNum = 0,select = false,limit = "",title = ""}};
    showFull = false;
}

local command = {
    CancelApplyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local guild = this.vm.data.guildList[param + 1]
            LuaMgr.ShowLuaPanel(UIName.GuildConfirmPopup,LuaMgr.GetLangText("GuildApplyListPopup_0"),function()
                PlayerGuildMgr.CancelApply(guild.guildId,this.RefreshGuildList)
            end,nil);
        end
    },
    OneKeyCancelApplyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if #PlayerGuildMgr.CancelApplyList <= 0 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("GuildApplyListPopup_2"))
                return
            end
            LuaMgr.ShowLuaPanel(UIName.GuildConfirmPopup,LuaMgr.GetLangText("GuildApplyListPopup_1"),function()
                PlayerGuildMgr.CancelApply("",this.RefreshGuildList)
            end,nil);
        end
    },

    ShowFullCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.vm.data.showFull = not this.vm.data.showFull
            this.RefreshGuildList()
        end
    },

    BackCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.Back();
        end
    },

    SearchCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OnSearchGuild()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour, this, objs);
        this.filterBtnClickTime = 0;
    end,
    before_active = function(vm)
        this.vm.behaviour:UpdateTopBar("")
        this.filterInput.text = ""
        this.RefreshGuildList()
    end,
    before_deactive = function(vm)

    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.RefreshGuildList = function()
    local tempGuildList = {};
    local config = nil;
    if PlayerGuildMgr.CancelApplyList ~= nil then
        for i = 1, #PlayerGuildMgr.CancelApplyList do
            local color = ""
            if tonumber(PlayerGuildMgr.CancelApplyList[i].capacity) > tonumber(PlayerGuildMgr.CancelApplyList[i].memberCount) then
                color = "<color=#4b494e>"
            else
                color = "<color=#b3573a>"
            end
            local isSelect = false;
            local limitStr = ""
            if PlayerGuildMgr.CancelApplyList[i].applyLevelCondition == 0 then
                limitStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23769");
            else
                limitStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30121") .. ":" .. tostring(PlayerGuildMgr.CancelApplyList[i].applyLevelCondition);
            end
            local guildInfo = this.GetGuildInfo(i,color,limitStr,isSelect)
            if this.vm.data.showFull then
                if PlayerGuildMgr.CancelApplyList[i].capacity <= tonumber(PlayerGuildMgr.CancelApplyList[i].memberCount) then
                    table.insert(tempGuildList,guildInfo);
                end
            else
                table.insert(tempGuildList,guildInfo);
            end
        end
    end

    table.sort(tempGuildList,function(a,b)
        if a.isFull ~= b.isFull then
            return a.isFull < b.isFull
        else
            return a.ApplyCondition < b.ApplyCondition
        end

    end)
    this.vm.data.guildList = {};
    this.vm.data.guildList = tempGuildList;
end

this.GetGuildInfo = function(i,color,limitStr,isSelect)
    local guildInfo = {
        guildName = PlayerGuildMgr.CancelApplyList[i].guildName,
        guildId = PlayerGuildMgr.CancelApplyList[i].guildId,
        guildLevel = tostring(PlayerGuildMgr.CancelApplyList[i].level),
        guildMember = color .. tostring(PlayerGuildMgr.CancelApplyList[i].memberCount) ..  '/' .. PlayerGuildMgr.CancelApplyList[i].capacity .. "</color>",
        guildMemberNum = PlayerGuildMgr.CancelApplyList[i].memberCount;
        ApplyCondition = PlayerGuildMgr.CancelApplyList[i].applyLevelCondition,
        limit = limitStr,
        select = isSelect,
        isFull = PlayerGuildMgr.CancelApplyList[i].remainingCount
    }
    return guildInfo
end

this.OnSearchGuild = function()






    this.filterBtnClickTime = curTime;
    local value = this.filterInput.text
    local tempGuildList = {};
    local strArr = split(value,' ')
    for i = 1, #PlayerGuildMgr.CancelApplyList do
        local find = true
        for j = 1, #strArr do
            if not string.find(PlayerGuildMgr.CancelApplyList[i].guildName,strArr[j]) then
                find = false
                break
            end
        end
        if find then
            local limitStr = ""
            if PlayerGuildMgr.CancelApplyList[i].applyLevelCondition == 0 then
                limitStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23769");
            else
                limitStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30121") .. ":" .. tostring(PlayerGuildMgr.CancelApplyList[i].applyLevelCondition);
            end
            local color = ""
            if tonumber(PlayerGuildMgr.CancelApplyList[i].capacity) > tonumber(PlayerGuildMgr.CancelApplyList[i].memberCount) then
                color = "<color=#4b494e>"
            else
                color = "<color=#b3573a>"
            end
            local guildInfo = this.GetGuildInfo(i,color,limitStr,false)
            table.insert(tempGuildList,guildInfo);
        end
    end
    this.vm.data.guildList = {};
    this.vm.data.guildList = tempGuildList;
end

return vm({
    data = data,
    command = command,
    hook = hook
})