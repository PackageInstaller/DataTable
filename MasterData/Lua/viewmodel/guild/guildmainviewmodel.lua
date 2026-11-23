require("ViewModel/Guild/GuildBuildItem")
local this = {
    vm = nil,
    
}

local data = {
    haveGuildLevelUpPermission = false,
    haveAnnounceChangePermission = false,
}

local objs = {
    uiGoodsItem =  { path = "template/signReward", type = "GameObject" },
    SignInRewardObj =  { path = "root/Right/signReward/ScrollView/Viewport/RewardContent", type = "GameObject" },
}

local goodsListData = {}
local GuildInfo = {}

local command = {
    OpenGuildMemberListCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.GuildMemberListViewModel)
        end
    },

    OpenGuildInfoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.GuildInfoViewModel)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        for i, v in pairs(PlayerGuildMgr.GuildBuildConfig()) do
            local tempData = {}
            local buildsRoot = this.vm.behaviour.transform:Find("root/Middle/Builds")
            local count = buildsRoot.transform.childCount
            if tonumber(i) <= count then
                tempData.path = "root/Middle/Builds/BuildItem" .. i
                tempData.type = UITool.GameObject
                objs["BuildItem" .. i] = tempData
            end
        end
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.BuildItems = {}
        for i, v in pairs(PlayerGuildMgr.GuildBuildConfig()) do
            if this["BuildItem" .. i] ~= nil then
                local buildItem = GuildBuildItem.New(this["BuildItem" .. i], i, this.ClickBuildItem)
                this.BuildItems[i] = buildItem
            end
        end
        RedMgr.Singleton:RegisterViewModel(UIName.GuildMainViewModel);
    end,
    before_active = function(vm)
        this.vm.behaviour:UpdateTopBar("")
        this.RefreshGuildInfo()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.RefreshGuildInfo = function()
    GuildInfo = PlayerGuildMgr.GuildInfo();
    this.RefreshSignInInfo();
    this.RefreshPermission();
    this.RefreshGuildBuild()
    
    local guildConfig = PlayerGuildMgr.GetGuildConfigByLevel(GuildInfo.guildLevel)
    if guildConfig == nil then
        LuaMgr.Back();
        return
    end

    if DataMgr.Player.guildData.sign == false then
        this.SignIn()
    end
end

this.RefreshPermission = function()
    this.vm.data.haveGuildLevelUpPermission = PlayerGuildMgr.GetGuildLevelUpPermission();
    this.vm.data.haveAnnounceChangePermission = PlayerGuildMgr.GetGuildAnnounceChangePermission();
end

this.RefreshSignInInfo = function()
    local config = PlayerGuildMgr.GetGuildConfigByLevel(GuildInfo.guildLevel);
    local rewardConfig = PlayerGuildMgr.GetGuildSignRewardConfigById(config.signinrewardID);
    
    for i = 1, #rewardConfig.RewardID do
        if i># goodsListData then
            local item = LuaMgr.InstantiateGO(this.uiGoodsItem.gameObject, this.SignInRewardObj.transform, false);
            table.insert(goodsListData,item:GetComponentInChildren(typeof(CS.Laigu.ViewModel.Common.GoodsViewModel)))
        end
        SetActive(goodsListData[i].gameObject,true);
        goodsListData[i]:SetData(tostring(rewardConfig.RewardID[i].id),rewardConfig.RewardID[i].count,1,1,true)
        
        local canvasGroup = goodsListData[i]:GetComponent("CanvasGroup");
        local sign = goodsListData[i].transform.parent:Find("sign")
        if DataMgr.Player.guildData.sign then
            canvasGroup.alpha = 0.5;
            SetActive(sign.gameObject,true);
        else
            canvasGroup.alpha = 1;
            SetActive(sign.gameObject,false);
        end
    end

    for i = (#rewardConfig.RewardID+1), #goodsListData do
        SetActive(goodsListData[i].gameObject,false)
    end
end

this.RefreshGuildBuild = function()
    local buildConfig = PlayerGuildMgr.GuildBuildConfig()
    for i, v in pairs(this.BuildItems) do
        if buildConfig[i] ~= nil then
            local info = 
            {
                name = buildConfig[i].name,
                lock = not PlayerGuildMgr.IsGuildBuildUnLock(buildConfig[i].buildingID)
            }
            v:SetData(info)
        end
    end
end


this.SignIn = function()
    DataMgr.Player.guildData.sign = true;
    PlayerGuildMgr.SignIn(function(result)
        if result==nil then return end;
        local re=json.decode(result);
        local resData=json.encode(re.result.Rewards);
        LuaMgr.ShowItemRewared(resData);
        PlayerGuildMgr.RefreshGuildInfo(this.RefreshGuildInfo,nil)
    end);
end

this.ClickBuildItem = function(index)
    local isUnlock = PlayerGuildMgr.IsGuildBuildUnLock(index)
    if not isUnlock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_6901"));
        return
    end
if index == "1" then
        LuaMgr.ShowLuaPanel(UIName.GuildMemberListViewModel)
elseif index == "2" then
        LuaMgr.ShowLuaPanel(UIName.MarketViewModel,"guildstore")
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})