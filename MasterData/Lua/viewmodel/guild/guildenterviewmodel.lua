local this = {
    vm = nil,
    filterBtnClickTime = 0,
}
local objs = {
    filterInput =  { path = "root/Middle/op/searchGuild/FilterInput", type = "InputField" },
    avatarRoot = { path="root/Middle/GangInfo/headInfo", type = "GameObject" },
    defaultAvatar = { path="root/Middle/GangInfo/defaultAvatar", type = "GameObject" },
    avatar = { path="root/Middle/GangInfo/headInfo/avatar", type = "RawImage" },
    avatarFrame = { path = "root/Middle/GangInfo/headInfo/avatarFrame", type = "Image" },
    playerDynamicAvatar = { path = "root/Middle/GangInfo/headInfo/DynamicAvatar", type = "PlayerDynamicAvatar" },
    playerTitle = { path="root/Middle/GangInfo/PlayerTitle", type = "Image" },
    playerTitleText = { path="root/Middle/GangInfo/PlayerTitle/Text", type = "Text" },
    titleTextPos = { path="root/Middle/GangInfo/PlayerTitle/Text", type = "RectTransform" },
}
local data = {
    guildList = {{guildName = "1111111111",guildId = 0,guildLevel = "",guildMember = "",ApplyCondition = 10,GuildAnnounce = "123123123",LeaderName = "222",guildMemberNum = 0,select = false,limit = "",title = ""}};
    showNotFull = false;
    curSelectGuildIndex = 1;
    curGuildName = "";
    curGuildLeaderName = "";
    curGuildApplyCondition = "";
    curGuildAnnounce = "";
    dynamicAvatarShow = false;
}

local command = {
    ApplyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local guild = this.vm.data.guildList[this.vm.data.curSelectGuildIndex]
            if guild == nil then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30195"));
                return;
            end
            local guildConfig = PlayerGuildMgr.GetGuildConfigByLevel(guild.guildLevel);
            local leftTime = DataMgr.Player.guildData.exitCoolDown - LuaMgr.Timestamp();
            if leftTime > 0 then
                local day, hour, minute = GetTimeDHM(leftTime)
                local timeStr = ""
                if IsNullOrEmpty(day) then
                    timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10209"].NameLan), hour, minute)
                else
                    timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10208"].NameLan), day, hour)
                end
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30158"),timeStr));
                return
            end
            
            if tonumber(guild.guildMemberNum) >= tonumber(guildConfig.maximumcapacity) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30135"));
                return;
            elseif guild.ApplyCondition > DataMgr.Player.level then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30136"));
                return;
            end
            PlayerGuildMgr.Apply(guild.guildId,function(isJoin)
                if isJoin then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30196"));
                    LuaMgr.HidePanel(UIName.GuildEnterViewModel);
                    LuaMgr.ShowLuaPanel(UIName.GuildMainViewModel);
                else
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30186"));
                end
            end,nil);
        end
    },
    OneKeyApplyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if #PlayerGuildMgr.GuildList <= 0 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("GuildEnterViewModel_0"));
                return;
            end
            
            local leftTime = DataMgr.Player.guildData.exitCoolDown - LuaMgr.Timestamp();
            if leftTime > 0 then
                local day, hour, minute = GetTimeDHM(leftTime)
                local timeStr = ""
                if IsNullOrEmpty(day) then
                    timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10209"].NameLan), hour, minute)
                else
                    timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10208"].NameLan), day, hour)
                end
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30158"),timeStr));
                return
            end

            PlayerGuildMgr.QuickApply(function(isJoin)
                if isJoin then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30196"));
                    LuaMgr.HidePanel(UIName.GuildEnterViewModel)
                    LuaMgr.ShowLuaPanel(UIName.GuildMainViewModel);
                else
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30186"));
                end
            end ,nil);
        end
    },
    CreateCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.GuildCreateViewModel);
        end
    },

    OnClickGuildItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            print(this.vm.data.curSelectGuildIndex)
            this.vm.data.guildList[this.vm.data.curSelectGuildIndex].select = false
            this.vm.data.curSelectGuildIndex = param + 1;
            this.vm.data.guildList[this.vm.data.curSelectGuildIndex].select = true
            this.RefreshGuildInfo();
        end
    },

    ShowNotFullCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.vm.data.showNotFull = not this.vm.data.showNotFull
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
        this.vm.data.curSelectGuildIndex = 1;
        this.RefreshGuildList()
        this.RefreshGuildInfo()
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
    if PlayerGuildMgr.GuildList ~= nil then
        for i = 1, #PlayerGuildMgr.GuildList do
            config = PlayerGuildMgr.GetGuildConfigByLevel(PlayerGuildMgr.GuildList[i].level);
            local color = ""
            if tonumber(config.maximumcapacity) > tonumber(PlayerGuildMgr.GuildList[i].member) then
                color = "<color=#4b494e>"
            else
                color = "<color=#b3573a>"
            end
            local isSelect = false;
            if this.vm.data.curSelectGuildIndex == i then
                isSelect = true;
            end
            local limitStr = ""
            if PlayerGuildMgr.GuildList[i].applyLevelCondition == 0 then
                limitStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23769");
            else
                limitStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30121") .. ":" .. tostring(PlayerGuildMgr.GuildList[i].applyLevelCondition);
            end
            local guildInfo = this.GetGuildInfo(i,color,config,limitStr,isSelect)
            if this.vm.data.showNotFull then
                if tonumber(config.maximumcapacity) > tonumber(PlayerGuildMgr.GuildList[i].member) then
                    table.insert(tempGuildList,guildInfo);
                end
            else
                table.insert(tempGuildList,guildInfo);
            end
        end
    end
    this.vm.data.guildList = {};
    this.vm.data.guildList = tempGuildList;
end

this.GetGuildInfo = function(i,color,config,limitStr,isSelect)
    local guildInfo = {
        guildName = PlayerGuildMgr.GuildList[i].name,
        guildId = PlayerGuildMgr.GuildList[i].guildId,
        guildLevel = tostring(PlayerGuildMgr.GuildList[i].level),
        guildMember = color .. tostring(PlayerGuildMgr.GuildList[i].member) ..  '/' .. config.maximumcapacity .. "</color>",
        guildMemberNum = PlayerGuildMgr.GuildList[i].member;
        ApplyCondition = PlayerGuildMgr.GuildList[i].applyLevelCondition,
        limit = limitStr,
        GuildAnnounce = PlayerGuildMgr.GuildList[i].notice,
        LeaderName = PlayerGuildMgr.GuildList[i].chiefName,
        title = PlayerGuildMgr.GuildList[i].title,
        select = isSelect,
        leaderAvatar = PlayerGuildMgr.GuildList[i].chiefAvatar,
        leaderAvatarFrame = PlayerGuildMgr.GuildList[i].chiefAvatarFrame,
    }
    return guildInfo
end

this.RefreshGuildInfo = function()
    local guild = this.vm.data.guildList[this.vm.data.curSelectGuildIndex];
    if guild == nil then
        PlayerAvatarFrameTool.ClearImage(this.avatarFrame);
        SetActive(this.avatarRoot,false);
        SetActive(this.defaultAvatar,true);
        this.vm.data.curGuildName = "";
        this.vm.data.curGuildLeaderName = "";
        this.vm.data.curGuildApplyCondition = "";
        this.vm.data.curGuildAnnounce = "";
        return
    end
    SetActive(this.avatarRoot,true);
    SetActive(this.defaultAvatar,false);
    this.vm.data.curGuildName = guild.guildName;
    this.vm.data.curGuildLeaderName = guild.LeaderName;
    if guild.ApplyCondition == 0 then
        this.vm.data.curGuildApplyCondition = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23769");
    else
        this.vm.data.curGuildApplyCondition = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30121") .. ":" .. tostring(guild.ApplyCondition);
    end
    this.vm.data.curGuildAnnounce = guild.GuildAnnounce;

    local length = #ConfigMgr.Config.avatarFrames
    local avatarConfig = nil
    if not IsNullOrEmpty(guild.leaderAvatar) then
        for i = 1, length do
            if ConfigMgr.Config.avatarFrames[i].id == guild.leaderAvatar then
                avatarConfig = ConfigMgr.Config.avatarFrames[i]
                break
            end
        end
    end
    SetActive(this.avatar.gameObject,false)
    this.vm.data.dynamicAvatarShow = false
    if not TableIsNull(avatarConfig) then
        if avatarConfig.imgType == 1 then
            local avatarPath = ConfigHelper.GetHeadIconPath(avatarConfig.img, avatarConfig.imgId);
            this.avatar.texture = LuaMgr.GetTexture(avatarPath);
            SetActive(this.avatar.gameObject,true)
        elseif avatarConfig.imgType == 2 then
            this.playerDynamicAvatar:AppointAvatar(avatarConfig.id)
        end
        this.vm.data.dynamicAvatarShow = avatarConfig.imgType == 2
    end

    local title = ConfigHelper.GetTitleConfig(guild.title)
    if not TableIsNull(title) then
        this.playerTitle.sprite = LuaMgr.GetSprite("PlayerTitle",title.img)
        this.playerTitleText.text = LuaMgr.GetLangText(title.namelan)
        if title.img == "Title_40001" then
            this.titleTextPos.anchoredPosition =  Vector2(2,1)
        else
            this.titleTextPos.anchoredPosition =  Vector2(10,1)
        end
    end

    avatarConfig = nil
    for i = 1, length do
        if ConfigMgr.Config.avatarFrames[i].id == guild.leaderAvatarFrame then
            avatarConfig = ConfigMgr.Config.avatarFrames[i]
            break
        end
    end
    if not TableIsNull(avatarConfig) then
        PlayerAvatarFrameTool.SetAvatarFrame(this.avatarFrame, avatarConfig.id);
    else
        PlayerAvatarFrameTool.ClearImage(this.avatarFrame);
    end
end

this.OnSearchGuild = function()
    local interval = ConfigMgr.Config.constants.GuildFilterInterval;
    local curTime = LuaMgr.Timestamp()
    if curTime - this.filterBtnClickTime < interval then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("GuildEnterViewModel_1"));
        return;
    end
    this.filterBtnClickTime = curTime;
    local value = this.filterInput.text
    if value == "" then
        PlayerGuildMgr.GetGuildList(this.RefreshGuildList)
        return
    end
    PlayerGuildMgr.GetGuildFilterList(this.RefreshGuildList,value)

    
    
    
    




























    this.vm.data.curSelectGuildIndex = 1


end

return vm({
    data = data,
    command = command,
    hook = hook
})