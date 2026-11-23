require("ViewModel/Guild/GuildMemberItem")
require("ViewModel/Guild/GuildApplyMemberItem")
local UnityEngine = CS.UnityEngine
local EventSystem = UnityEngine.EventSystems.EventSystem
local this = {
    vm = nil,
    labelType = {
        member = 1,
        apply = 2
    },
    applyMemberScroll = nil,
    memberScroll = nil,
}

local data = {
    haveApplyHandlePermission = false,
    haveKickOutPermission = false,
    haveChangeJobPermission = false,
    curSelectName = "",
    curSelectSignature = "",
    curSelectLv = "",
    memberList = {{nil}},
    applyMemberList = {{nil}},
    sortType = 2,
    curLabel = 1,
    curSelectMemberIndex = 1,
    showApplyInfo = false,
    titleList = {{type = 3,order = Vector3.one,choice = true,title = ""},
                 {type = 2,order = Vector3.one,choice = false,title = ""},
                 {type = 5,order = Vector3.one,choice = false,title = ""},
                 {type = 4,order = Vector3.one,choice = false,title = ""},
                 {type = 1,order = Vector3.one,choice = false,title = ""}
    } ,
    labelList = {{type = 1,title = "",choice = true,normal = false,redId = "",normalSpt = nil,selectSpt = nil},
                 {type = 2,title = "",choice = false,normal = false},redId = "",normalSpt = nil,selectSpt = nil},
    changeJobList = {{job = 0,title = "",status = true,jobIcon = nil}}
}

local CurSelectMember = nil;

local objs = {
    filterInput =  { path = "root/Middle/memberObj/search/FilterInput", type = "InputField" },
    memberObj =  { path = "root/Middle/memberObj", type = "GameObject" },
    applyObj =  { path = "root/Middle/applyObj", type = "GameObject" },
    applyMemberScrollObj = { path = "root/Middle/applyObj/MemberList", type = "GameObject" },
    memberScrollObj = { path = "root/Middle/memberObj/MemberList/Viewport/Content", type = "GameObject" },
    guildMemberTemp = { path = "template/GuildMemberInfo", type = "GameObject" },
    guildApplyMemberTemp = { path = "template/GuildApplyMemberInfo", type = "GameObject" },
    memberOpObj = { path = "root/Middle/memberOpObj", type = "GameObject" },
    middle = { path = "root/Middle", type = "RectTransform" },
    goChangeJob = { path = "root/Middle/goChangeJob", type = "GameObject" },
    goMemberInfo = { path = "root/Middle/goMemberInfo", type = "GameObject" },
    selectMemberAvatar = { path = "root/Middle/goMemberInfo/Group/baseInfo/rawImageAvatar", type = "RawImage" },
    selectMemberAvatarFrame = { path = "root/Middle/goMemberInfo/Group/baseInfo/imgAvatarFrame", type = "Image" },
    selectMemberDynamicAvatar = { path = "root/Middle/goMemberInfo/Group/baseInfo/DynamicAvatar", type = "PlayerDynamicAvatar" },
    
    selectChangeJobMemberAvatar = { path = "root/Middle/goChangeJob/Group/baseInfo/rawImageAvatar", type = "RawImage" },
    selectChangeJobMemberAvatarFrame = { path = "root/Middle/goChangeJob/Group/baseInfo/imgAvatarFrame", type = "Image" },
    selectChangeJobMemberDynamicAvatar = { path = "root/Middle/goChangeJob/Group/baseInfo/DynamicAvatar", type = "PlayerDynamicAvatar" },
    
    bg1 = { path = "root/Middle/memberOpObj/bg", type = "GameObject" },
    bg2 = { path = "root/Middle/memberOpObj/bg2", type = "GameObject" },
}

local command = {
    ExitCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.GuildMemberListViewModel);
        end
    },
    ClickMemberCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            
        end
    },
    ClickRefuseAllCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            PlayerGuildMgr.RefusePlayerApply("",function()
                this.RefreshApplyList(PlayerGuildMgr.GuildInfo().applyList)
            end)
        end
    },
    ClickApplyAllCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local GuildInfo = PlayerGuildMgr.GuildInfo();
            local guildConfig = PlayerGuildMgr.GetGuildConfigByLevel(GuildInfo.guildLevel)
            if (tonumber(guildConfig.maximumcapacity) - #GuildInfo.memberList) < #GuildInfo.applyList then
                local data = {}
                data.clickCallbacks = {}
                data.btnTextStrs = {}
                data.contentStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30206")
                data.showCenter = true
                data.btnTextStrs[ConfirmCommonPanel.BtnType.Center] = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7104")
                LuaMgr.ShowLuaPanel(UIName.ConfirmCommonPanel,ConfirmCommonPanel.MsgBoxType.TextButton, data)
                return;
            end
            PlayerGuildMgr.AgreePlayerApply("",function()
                this.RefreshApplyList(PlayerGuildMgr.GuildInfo().applyList)
            end)
        end
    },
    ClickCloseCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.GuildMemberListViewModel);
        end
    },
    ClickLabelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OnClickLabel(param)
        end
    },
    ClickTitleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if param + 1 == data.sortType then
                this.vm.data.sortType = param;
                this.vm.data.titleList[data.sortType].choice = true;
                this.vm.data.titleList[data.sortType].order = Vector3(1,this.vm.data.titleList[data.sortType].order.y * -1 ,1)
            else
                this.vm.data.titleList[data.sortType].choice = false;
                this.vm.data.titleList[data.sortType].order = Vector3.one
                data.sortType = param + 1;
                this.vm.data.titleList[data.sortType].choice = true;
                this.vm.data.titleList[data.sortType].order = Vector3.one
            end
            PlayerGuildMgr.SortBy(this.vm.data.titleList[data.sortType].type,this.vm.data.titleList[data.sortType].order.y)
            this.RefreshMemberList(PlayerGuildMgr.GuildInfo().memberList)
        end
    },

    ClickGetInfoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OnClickGetInfo();
        end
    },

    ClickVisitCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OnClickVisit();
        end
    },

    ClickAddFriendCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OnClickAddFriend();
        end
    },
    
    ClickZoomCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OnClickZoom();
        end
    },

    ClickChangeJobCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OnClickJobItem(param);
        end
    },
    
    ConfirmChangeJobCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OnConfirmChangeJob();
        end
    },

    ClickRemoveCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OnClickRemove();
        end
    },

    ClickExitCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OnClickExit();
        end
    },
    

    SearchCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OnSearCh()
        end
    },  
    
    SettingCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.GuildSettingViewModel)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour, this, objs);
        this.memberScroll = UIListView.New(this.memberScrollObj.transform);
        this.applyMemberScroll = UIScrollView.New(this.applyMemberScrollObj);
        RedMgr.Singleton:RegisterViewModel(UIName.GuildMemberListViewModel);
    end,
    before_active = function(vm)

        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.AddUIEventListener(UIEventConst.UpdateGuild, this.RefreshList);
        PlayerGuildMgr.UpdateRedStatus()
        this.RefreshGuildInfo()
    end,
    before_deactive = function(vm)
        PlayerAvatarFrameTool.ClearImage(this.selectMemberAvatarFrame);
        PlayerAvatarFrameTool.ClearImage(this.selectChangeJobMemberAvatarFrame);


        this.memberScroll:Clear();
        this.applyMemberScroll:Clear();
        LuaMgr.RemoveUIEventListener(UIEventConst.UpdateGuild, this.RefreshList);
    end,
    before_destroy = function(vm)
        PlayerAvatarFrameTool.ClearImage(this.selectMemberAvatarFrame);
        PlayerAvatarFrameTool.ClearImage(this.selectChangeJobMemberAvatarFrame);
        UIListView.ClearItem("GuildMemberItem")
        UIScrollView.ClearItem("GuildApplyMemberItem")
        this = nil
    end,
}
this.RefreshGuildInfo = function()
    SetActive(this.memberOpObj,false)
    SetActive(this.goChangeJob,false)
    SetActive(this.goMemberInfo,false)
    this.InitPermission();
    this.InitTitleList();
    this.OnClickLabel(0)
    this.CurSelectMember = nil;
    this.RefreshList();
end

this.RefreshList = function()
    PlayerGuildMgr.SortBy(this.vm.data.titleList[data.sortType].type,this.vm.data.titleList[data.sortType].order.y)
    this.RefreshMemberList(PlayerGuildMgr.GuildInfo().memberList);
    this.RefreshApplyList(PlayerGuildMgr.GuildInfo().applyList);
end

this.InitTitleList = function()
    this.vm.data.titleList = {
        {type = 3,order = Vector3.one,choice = false,title = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30121")},
        {type = 2,order = Vector3(1,-1,1),choice = true,title = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30122")},
        {type = 5,order = Vector3.one,choice = false,title = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30123")},
        {type = 4,order = Vector3.one,choice = false,title = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30124")},
        {type = 1,order = Vector3.one,choice = false,title = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30125")} 
    }
    data.sortType = 2
    local tempLableList = {
        {type = 1,title = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30117"),choice = true,normal = false,redId = "",
         normalSpt = LuaMgr.GetSprite("UIGuildSprite","ui_gh_cyjsq_icon_cy_01"),
         selectSpt = LuaMgr.GetSprite("UIGuildSprite","ui_gh_cyjsq_icon_cy_02")}
    }
    if this.vm.data.haveApplyHandlePermission then
        local info = {type = 2,title = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30118"),choice = false,normal = true,redId = "17832",
                      normalSpt = LuaMgr.GetSprite("UIGuildSprite","ui_gh_cyjsq_icon_sq_01"),
                      selectSpt = LuaMgr.GetSprite("UIGuildSprite","ui_gh_cyjsq_icon_sq_02")}
        table.insert(tempLableList,info);
    end
    this.vm.data.labelList = tempLableList;
    PlayerGuildMgr.SortBy(2,-1)
end

this.InitPermission = function()
    this.vm.data.haveApplyHandlePermission = PlayerGuildMgr.GetGuildApplyHandlePermission();
    this.vm.data.haveChangeJobPermission = PlayerGuildMgr.GetGuildJobChangePermission();
    this.vm.data.haveKickOutPermission = PlayerGuildMgr.GetGuildKickOutPermission();
    
    local count = (this.vm.data.haveApplyHandlePermission and 1 or 0) + (this.vm.data.haveChangeJobPermission and 1 or 0) + (this.vm.data.haveKickOutPermission and 1 or 0)
    SetActive(this.bg1,count > 1)
    SetActive(this.bg2,count <= 1)
end

this.OnSearCh = function()
    local value = this.filterInput.text
    if value == "" then
        this.RefreshMemberList(PlayerGuildMgr.GuildInfo().memberList);
        return
    end
    local tempList = {};
    local strArr = split(value,' ')
    for i = 1, #PlayerGuildMgr.GuildInfo().memberList do
        local find = true
        for j = 1, #strArr do
            if not string.find(PlayerGuildMgr.GuildInfo().memberList[i].name,strArr[j]) then
                find = false
                break
            end
        end
        if find then
            table.insert(tempList,PlayerGuildMgr.GuildInfo().memberList[i]);
        end
    end
    this.RefreshMemberList(tempList);
end

this.RefreshMemberList = function(memberList)
    local scrollData,scrollDatas = {},{}
    for i = 1, #memberList do
        local memberData = {info = {},CallBack = nil};
        memberData.info = memberList[i]
        memberData.CallBack = function(item)
            this.OnClickMember(i,item);
        end;
        scrollData = UIListData.GetData(this.guildMemberTemp,"GuildMemberItem",memberData)
        table.insert(scrollDatas,scrollData)
    end

    this.memberScroll:SetData(scrollDatas)
    this.vm.data.memberList = memberList;
end

this.RefreshApplyList = function(applyMemberList)
    local scrollData,scrollDataList = {},{}
    for i = 1, #applyMemberList do
        local memberData = {info = {},ApplyCallBack = nil,RefuseCallBack = nil};
        memberData.info = applyMemberList[i]
        memberData.ApplyCallBack = function()
            this.OnClickApplyMember(i);
        end;
        memberData.RefuseCallBack = function()
            this.OnClickRefuseMember(i);
        end;
        scrollData = UIScrollData.GetData(this.guildApplyMemberTemp,"GuildApplyMemberItem",908,82,memberData)
        table.insert(scrollDataList,scrollData)
    end
    this.applyMemberScroll:SetParams(908, 400);
    this.applyMemberScroll:SetData(scrollDataList,true)
    this.vm.data.applyMemberList = applyMemberList;
end

this.RefreshChangeJobList = function()
    local memberInfo = this.vm.data.memberList[this.vm.data.curSelectMemberIndex];
    if not this.vm.data.haveChangeJobPermission then
        return;
    end
    local tempList = {};
    local canChangeJobs = PlayerGuildMgr.GetGuildChangeJobList()
    for i = 1, #canChangeJobs do
        if memberInfo.job ~= canChangeJobs[i] then
            local jobInfo = {
                job = canChangeJobs[i],
                title = PlayerGuildMgr.GetJobName(canChangeJobs[i]),
                status = false,
                jobIcon = LuaMgr.GetSprite("UIGuildSprite",job == 1 and "ui_gh_cyjsq_icon_zrhz" or "ui_gh_cyjsq_icon_cy_03");
            }
            table.insert(tempList,jobInfo);
        end
    end
    this.vm.data.changeJobList = tempList;
end

this.OnClickMember = function(index,item)
    this.vm.data.curSelectMemberIndex = index
    if this.CurSelectMember ~= nil then
        this.CurSelectMember:Select(false)
    end
    this.CurSelectMember = item
    local memberInfo = this.vm.data.memberList[this.vm.data.curSelectMemberIndex];
    if memberInfo == nil or memberInfo.playerId == DataMgr.Player.uid then
        return;
    end
    this.CurSelectMember:Select(true)
    local eventSystem = EventSystem.current
    if eventSystem then
        local clickPos = eventSystem.currentInputModule.input.mousePosition
        local screenPos = LuaMgr.World2Screen(item.gameObject.transform.position)
        local Pos = LuaMgr.Screen2Local(Vector2(screenPos.x, screenPos.y),this.middle)
        local screenWidth = LuaMgr.GetScreenWidth()
        local posX = math.min(screenWidth / 2 - 150, Pos.x)
        SetActive(this.memberOpObj,true);
        this.memberOpObj.transform.anchoredPosition = Vector2(437, Pos.y - 40);
    end
    
    this.vm.data.curSelectName = memberInfo.name;
    this.vm.data.curSelectLv = memberInfo.level;
    this.vm.data.curSelectSignature = memberInfo.motto;
    
    local length = #ConfigMgr.Config.avatarFrames
    local avatarConfig = nil
    for i = 1, length do
        if ConfigMgr.Config.avatarFrames[i].id == memberInfo.avatar then
            avatarConfig = ConfigMgr.Config.avatarFrames[i]
            break
        end
    end
    SetActive(this.selectMemberAvatar.gameObject,false)
    SetActive(this.selectChangeJobMemberAvatar.gameObject,false)
    SetActive(this.selectMemberDynamicAvatar.gameObject,false)
    SetActive(this.selectChangeJobMemberDynamicAvatar.gameObject,false)
    if not TableIsNull(avatarConfig) then
        if avatarConfig.imgType == 1 then
            local avatarPath = ConfigHelper.GetHeadIconPath(avatarConfig.img, avatarConfig.imgId);
            this.selectMemberAvatar.texture = LuaMgr.GetTexture(avatarPath);
            this.selectChangeJobMemberAvatar.texture = LuaMgr.GetTexture(avatarPath);
            SetActive(this.selectMemberAvatar.gameObject,true)
            SetActive(this.selectChangeJobMemberAvatar.gameObject,true)
        elseif avatarConfig.imgType == 2 then
            this.selectMemberDynamicAvatar:AppointAvatar(avatarConfig.id)
            SetActive(this.selectMemberDynamicAvatar.gameObject,true)
            this.selectChangeJobMemberDynamicAvatar:AppointAvatar(avatarConfig.id)
            SetActive(this.selectChangeJobMemberDynamicAvatar.gameObject,true)
        end
    end

    avatarConfig = nil
    for i = 1, length do
        if ConfigMgr.Config.avatarFrames[i].id == memberInfo.avatarFrame then
            avatarConfig = ConfigMgr.Config.avatarFrames[i]
            break
        end
    end
    if not TableIsNull(avatarConfig) then
        PlayerAvatarFrameTool.SetAvatarFrame(this.selectMemberAvatarFrame, avatarConfig.id);
        PlayerAvatarFrameTool.SetAvatarFrame(this.selectChangeJobMemberAvatarFrame, avatarConfig.id);
    else
        PlayerAvatarFrameTool.ClearImage(this.selectMemberAvatarFrame);
        PlayerAvatarFrameTool.ClearImage(this.selectChangeJobMemberAvatarFrame);
    end

    this.RefreshChangeJobList()
end

this.OnClickApplyMember = function(index)
    local applyMember = this.vm.data.applyMemberList[index]
    local config = PlayerGuildMgr.GetGuildConfigByLevel(PlayerGuildMgr.GuildInfo().guildLevel)
    if tonumber(config.maximumcapacity) <= #PlayerGuildMgr.GuildInfo().memberList then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("GuildMemberListViewModel_0"));
        return;
    end
    if applyMember ~= nil then
        PlayerGuildMgr.AgreePlayerApply(applyMember.playerId,function()
            this.RefreshApplyList(PlayerGuildMgr.GuildInfo().applyList)
            PlayerGuildMgr.UpdateRedStatus();
            RedMgr.Singleton:SetRedState("17832",PlayerGuildMgr.red_17832_apply,UIName.GuildMemberListViewModel)
            RedMgr.Singleton:SetRedState("17836",PlayerGuildMgr.red_17836_build1,UIName.GuildMainViewModel)
        end)
    end
    
end

this.OnClickRefuseMember = function(index)
    local applyMember = this.vm.data.applyMemberList[index]
    if applyMember ~= nil then
        PlayerGuildMgr.RefusePlayerApply(applyMember.playerId,function()
            this.RefreshApplyList(PlayerGuildMgr.GuildInfo().applyList)
        end)
    end
end

this.OnClickApplySetting = function()
    
end

this.OnClickGetInfo = function()
    local memberInfo = this.vm.data.memberList[this.vm.data.curSelectMemberIndex];
    FriendChatMgr.FriendPersonalHome(memberInfo.playerId,function(res)
        LuaMgr.ShowLuaPanel(UIName.FriendPlayerInfoViewModel,res)
    end)
end

this.OnClickVisit = function()
    local memberInfo = this.vm.data.memberList[this.vm.data.curSelectMemberIndex];
    PlayerFoundationMgr.VisitFriend(memberInfo.playerId,false);
end

this.OnClickZoom = function()
    local memberInfo = this.vm.data.memberList[this.vm.data.curSelectMemberIndex];
    FriendChatMgr.FriendPersonalHome(memberInfo.playerId,function(data)
        LuaMgr.HidePanel(UIName.GuildMemberListViewModel);
        LuaMgr.ShowLuaPanel(UIName.FriendPlayerInfoViewModel,data)
    end)
end

this.OnClickAddFriend = function()
    local memberInfo = this.vm.data.memberList[this.vm.data.curSelectMemberIndex];
    if FriendChatMgr.FriendCount() >= ConfigMgr.Config.FriendConstants.MaxFriends then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("17016"))
        return
    end
    local uid = memberInfo.playerId;
    FriendChatMgr.AddFriend(uid,function()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30207"))
    end)
end

this.OnClickJobItem = function(index)
    for i = 1, #this.vm.data.changeJobList do
        if i == index + 1 then
            this.vm.data.changeJobList[i].status = true;
        else
            this.vm.data.changeJobList[i].status = false;
        end
    end
end

this.OnClickRemove = function()
    local memberInfo = this.vm.data.memberList[this.vm.data.curSelectMemberIndex];
    LuaMgr.ShowConfirmSmallViewModel(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30144"),function ()
        PlayerGuildMgr.KickOut(memberInfo.playerId,function()
            this.RefreshList()
        end)
    end,nil);

end

this.OnClickExit = function()
    local strKey = "";
    if DataMgr.Player.guildData.exitGuildNum == 0 then
        strKey = "LangGlobalLan_LangGlobal_name_30142"
    else
        strKey = "LangGlobalLan_LangGlobal_name_30143"
    end
    LuaMgr.ShowConfirmSmallViewModel(LuaMgr.GetLangText(strKey),function ()
        PlayerGuildMgr.Exit(function()
            LuaMgr.HidePanel(UIName.GuildMemberListViewModel)
            LuaMgr.Back();
        end);
    end);

end

this.OnConfirmChangeJob = function()
    for i = 1, #this.vm.data.changeJobList do
        if this.vm.data.changeJobList[i].status then
            local memberInfo = this.vm.data.memberList[this.vm.data.curSelectMemberIndex];
            if this.vm.data.changeJobList[i].job == 1 then
                LuaMgr.ShowConfirmSmallViewModel(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30187"),function ()
                    PlayerGuildMgr.TransferGuild(memberInfo.playerId,function()
                        this.InitPermission();
                        this.InitTitleList();
                        this.RefreshList()
                        SetActive(this.memberOpObj,false)
                        SetActive(this.goChangeJob,false)
                        SetActive(this.goMemberInfo,false)
                    end)
                end,nil);
            else
                LuaMgr.ShowConfirmSmallViewModel(string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30188"),memberInfo.name,this.vm.data.changeJobList[i].title),function ()
                    PlayerGuildMgr.ChangeJob(memberInfo.playerId,this.vm.data.changeJobList[i].job,function()
                        this.RefreshList()
                        SetActive(this.memberOpObj,false)
                        SetActive(this.goChangeJob,false)
                        SetActive(this.goMemberInfo,false)
                    end)
                end,nil);
            end
        end
    end
end

this.OnClickLabel = function(param)
    if this.vm.data.curLabel == param + 1 then
        return;
    end
    for i, v in ipairs(this.vm.data.labelList) do
        if v.type == param + 1 then
            v.choice = true
            v.normal = false
            this.vm.data.curLabel = param + 1;
        else
            v.choice = false
            v.normal = true
        end
    end
    SetActive(this.applyObj,this.vm.data.curLabel == this.labelType.apply);
    SetActive(this.memberObj,this.vm.data.curLabel == this.labelType.member);
    this.RefreshList()
end

return vm({
    data = data,
    command = command,
    hook = hook
})