FriendChatMgr= {
    curChatLocalData=nil;
friendMapList=nil;
    friendsMsgMap=nil;
characterMsgMap={};
characterTypeList={};
    faceTag="<face>&",
    charactersChatPro={},
    currentSelectFriendTitle = "",
}

local CHARATERS_CHAT_PRO="characters_chat_pro";

local isInit=false;
local fileExName="Chat.json";
local chatFilePath=nil;
local fileKeyName=nil;
local isSendingList=false;
local isSendingMsg=false
local red_11002=0;
local red_11003=0;
local red_11004=0;
local red_11005=0;
local lastInitTime=0;

FriendChatMgr.SortType={
    CreateTime=1,
    GroupChat=false,
}

FriendChatMgr.MsgData={
    uid="",
    msgId="",
chatType=0,
position=0,
    name="",
    msg="",
    headPath="",
    headFrame="",
    time=0
}

FriendChatMgr.GetAvatarAndAvatarFramePath=function(pAvatar,pAvatarFrame)
    local avatarPath=nil;
    local avatarFrameName=nil;
    local avatarFrames = ConfigMgr.Config.avatarFrames;
    local avatar = DataMgr.Player.Avatar;
    if pAvatar~=nil then
        avatar=pAvatar
    end
    local avatarFrame = DataMgr.Player.currentAvatarFrame;
    if pAvatarFrame~=nil then
        avatarFrame=pAvatarFrame
    end
    local avatarData;
    local len = #avatarFrames;
    for i = 1, len do
        avatarData = avatarFrames[i];
        if (avatarData.id == avatar) then
            break;
        else
            avatarData = nil;
        end
    end
    local isDynamicAvatar = false
    if (avatarData ~= nil) then
        isDynamicAvatar = avatarData.imgType == 2
        avatarPath = ConfigHelper.GetHeadIconPath(avatarData.img, avatarData.imgId);
    end
    local frameData;
    for i = 1, len do
        frameData = avatarFrames[i];
        if (frameData.id == avatarFrame) then
            break;
        else
            frameData = nil;
        end
    end
    if (frameData ~= nil) then
        avatarFrameName=frameData.img;
    end
    return avatarPath,avatarFrameName,isDynamicAvatar
end


FriendChatMgr.ReadLocalData=function(uid)
    FriendChatMgr.curChatLocalData=nil;
    local fileName=string.format("%sTo%s%s",DataMgr.Player.uid,uid,fileExName)
    fileKeyName=string.format("%sTo%s",DataMgr.Player.uid,uid)
    chatFilePath=UnityEngine.Application.persistentDataPath.."/friendChat/"..fileName;
    local jsonStr=LuaMgr.ReadFileBase64(chatFilePath)
    if not IsNullOrEmpty(jsonStr) and jsonStr~="{}" then
        FriendChatMgr.curChatLocalData=json.decode(jsonStr)
    else
        FriendChatMgr.curChatLocalData={}
    end
    return FriendChatMgr.curChatLocalData;
end


FriendChatMgr.WriteLocalData=function(dataList,groupID)
    if IsNullOrEmpty(chatFilePath) then
        LuaMgr.error("chatFilePath is Error")
        return
    end
    if not IsNull(dataList) and #dataList>0 then
        for i,v in ipairs(dataList) do
            table.insert(FriendChatMgr.curChatLocalData,v);
        end
        local jsonStr=json.encode(FriendChatMgr.curChatLocalData);
        if not IsNullOrEmpty(jsonStr) then
            LuaMgr.WriteFileBase64(chatFilePath,jsonStr);
        end

        if not IsNullOrEmpty(groupID) then
            FriendChatMgr.charactersChatPro[fileKeyName]=NumTool.GetLen(FriendChatMgr.characterMsgMap[groupID]);
            local PrefsStr=json.encode(FriendChatMgr.charactersChatPro);
            PlayerPrefs.SetString(CHARATERS_CHAT_PRO,PrefsStr)
        end
    end
end



FriendChatMgr.DeleteLocalRecordByUid=function(uids)
    for i,uid in ipairs(uids) do
        local fileName=string.format("%sTo%s%s",DataMgr.Player.uid,uid,fileExName)
        local filePath=UnityEngine.Application.persistentDataPath.."/friendChat/"..fileName;
        if LuaMgr.Exists(filePath) then
            LuaMgr.DeleteFile(filePath);
        end
    end
end

FriendChatMgr.UpdateDataOptionIndex=function(index,value)
    local updateData=FriendChatMgr.curChatLocalData[index];
    if updateData==nil then
        LuaDebug.error("Update Data Error")
        return
    end
    updateData.optionIndex=value;
    local jsonStr=json.encode(FriendChatMgr.curChatLocalData);
    if not IsNullOrEmpty(jsonStr) then
        LuaMgr.WriteFileBase64(chatFilePath,jsonStr);
    end

end


FriendChatMgr.GetFriendByUid=function(uid)
    if #FriendChatMgr.friendMapList.FriendsList>0 then
        for i,v in ipairs(FriendChatMgr.friendMapList.FriendsList) do
            if v.Uid==uid then
                return v;
            end
        end
    end
    return nil;
end

FriendChatMgr.SortFriendList=function(friendList)
    table.sort(friendList,function(a, b)
        if (a.Online and b.Online) or (not a.Online and not b.Online) then
            if (a.Special and b.Special) or  (not a.Special and not b.Special) then
                if a.LastChatTime==b.LastChatTime then
                    if a.AddTime==b.AddTime then
                        return a.OnlineTime>b.OnlineTime
                    else
                        return a.AddTime<=b.AddTime;
                    end
                else
                    return a.LastChatTime>b.LastChatTime
                end
            else
                return a.Special and not b.Special;
            end
        else
            return a.Online and not b.Online
        end
    end)
end


FriendChatMgr.GetFriendList=function()
    local friendList={}
    if not IsNull(FriendChatMgr.friendMapList) and not IsNull(FriendChatMgr.friendMapList.FriendsList) then
        friendList=FriendChatMgr.friendMapList.FriendsList;
        FriendChatMgr.SortFriendList(friendList);
    end
    return friendList;
end

FriendChatMgr.FriendOnlineCount=function()
    if IsNull(FriendChatMgr.friendMapList.FriendsList) then
        return 0;
    end
    local onlineCount=0;
    for i,v in ipairs(FriendChatMgr.friendMapList.FriendsList) do
        if v.Online then
            onlineCount=onlineCount+1;
        end
    end
    return onlineCount;
end

FriendChatMgr.FriendCount=function()
    if IsNull(FriendChatMgr.friendMapList.FriendsList) then
        return 0;
    end
    return #FriendChatMgr.friendMapList.FriendsList
end
FriendChatMgr.CharacterCount=function()
    return #FriendChatMgr.characterTypeList;
end

FriendChatMgr.FriendApplyListCount=function()
    if IsNull(FriendChatMgr.friendMapList.ApplyList) then
        return 0;
    end
    return #FriendChatMgr.friendMapList.ApplyList
end

FriendChatMgr.FriendShieldListCount=function()
    if IsNull(FriendChatMgr.friendMapList.ShieldList) then
        return 0;
    end
    return #FriendChatMgr.friendMapList.ShieldList
end


FriendChatMgr.Init=function()
    if not isInit then
        FriendChatMgr.friendMapList={};
        FriendChatMgr.characterMapList={};
        isInit=true;
    end
    FriendChatMgr.InitCharacterChatData();
    isSendingMsg=false;
    isSendingList=false;

    local prefJson=PlayerPrefs.GetString(CHARATERS_CHAT_PRO)
    if not IsNullOrEmpty(prefJson) then
        FriendChatMgr.charactersChatPro= json.decode(prefJson)
    else
        FriendChatMgr.charactersChatPro={}
    end
    FriendChatMgr.UpdateCharacterRed();
    FriendChatMgr.UpdateFriendPlayerInfoRed()
    if lastInitTime==0 or (UnityEngine.Time.realtimeSinceStartup-lastInitTime>ConfigMgr.Config.FriendConstants.FriendListInterval*2) then
        FriendChatMgr.UpdateFriendList();
        FriendChatMgr.UpdateChatData();
        lastInitTime=UnityEngine.Time.realtimeSinceStartup;
    end


end





FriendChatMgr.ReFresh=function()
    isSendingMsg=false;
    isSendingList=false;
    FriendChatMgr.AddTimer(ConfigMgr.Config.FriendConstants.FriendListInterval
    ,ConfigMgr.Config.FriendConstants.FriendMsgInterval);
end

FriendChatMgr.FriendGroupUnLock=function(friendGroupItem)
    if not IsNullOrEmpty(friendGroupItem.CharacterId) and not DataHelper.CheckNovelComplete(friendGroupItem.CharacterId) then
        return false;
    end
    if LuaMgr.Timestamp()<friendGroupItem.StartTime then
        return false;
    end
    return true;
end

FriendChatMgr.InitCharacterChatData=function()
    FriendChatMgr.characterTypeList={};
    FriendChatMgr.characterMsgMap={};

    for i,v in pairs(ConfigMgr.Config.FriendGroupMap) do
        if FriendChatMgr.FriendGroupUnLock(v) then
            if v.ChatType==1  then
                v.createTime=1;
                v.isGroup=true;
                v.Uid=v.GroupID;
                v.headPath=v.GroupHead;
                table.insert(FriendChatMgr.characterTypeList,v);
            elseif v.ChatType==2  then
                v.createTime=DataMgr.Player.characters[v.GroupID].createTime;
                v.isGroup=false;
                v.Uid=v.GroupID;
                v.headPath=ConfigHelper.GetCharacterAvatarPath(v.GroupID);
                table.insert(FriendChatMgr.characterTypeList,v);
            end
        end
    end

    local dataCharacters=DataMgr.Player.characters;
    for i,v in pairs(ConfigMgr.Config.CharacterChatMap) do

        if ConfigMgr.Config.FriendGroupMap[v.GroupType].ChatType==1 and DataHelper.CheckNovelComplete(v.Characterid)then
            if FriendChatMgr.characterMsgMap[v.GroupType]==nil then
                FriendChatMgr.characterMsgMap[v.GroupType]={};
            end
            FriendChatMgr.characterMsgMap[v.GroupType][v.Id]=v;
        elseif ConfigMgr.Config.FriendGroupMap[v.GroupType].ChatType==2 and dataCharacters[v.Characterid]~=nil then
            if FriendChatMgr.characterMsgMap[v.GroupType]==nil then
                FriendChatMgr.characterMsgMap[v.GroupType]={};
            end
            FriendChatMgr.characterMsgMap[v.GroupType][v.Id]=v;
        end
    end
    FriendChatMgr.SortType.CreateTime=1;
    FriendChatMgr.SortType.GroupChat=false;
    FriendChatMgr.SortCharacterChat();
end



FriendChatMgr.SortCharacterChat=function()
    table.sort(FriendChatMgr.characterTypeList,function(a, b)
        if FriendChatMgr.SortType.GroupChat then
            if (a.isGroup and b.isGroup) or (not a.isGroup and not b.isGroup) then
               return FriendChatMgr.SortCreatTime(a,b);
            else
                return a.isGroup and not b.isGroup;
            end
        else
            if (a.isGroup and b.isGroup) or (not a.isGroup and not b.isGroup) then
                return FriendChatMgr.SortCreatTime(a,b);
            else
                return not a.isGroup and b.isGroup;
            end
        end
    end)
end

FriendChatMgr.SortCreatTime=function(a,b)
    if FriendChatMgr.SortType.CreateTime>0 then
        if a.createTime==b.createTime then
            return a.GroupOrder>b.GroupOrder;
        else
            return a.createTime>b.createTime;
        end
    else
        if a.createTime==b.createTime then
            return a.GroupOrder <b.GroupOrder;
        else
            return a.createTime<b.createTime;
        end
    end
end


FriendChatMgr.UpdateChatData=function()
    if isSendingMsg then return end;
    isSendingMsg=true;
    ApiMgr.Request("friends/chat/receiveMsg",{},true,function(re)
        isSendingMsg=false;
        local data=json.decode(re)
        FriendChatMgr.friendsMsgMap=data.result.MsgsMap;

        LuaMgr.InvokeUIEventListeners(UIEventConst.FriendMsg,data.result.MsgsMap);
        FriendChatMgr.UpdateHeroRed();
    end,function()
        isSendingMsg=false;
    end,false)
end

FriendChatMgr.UpdateCharacterRed=function()
    red_11002=0;
    for i,v in ipairs(FriendChatMgr.characterTypeList) do
        local keyUid=string.format("%sTo%s",DataMgr.Player.uid,v.Uid)
        if FriendChatMgr.charactersChatPro[keyUid]==nil then
            red_11002=red_11002+1;
            RedMgr.Singleton:UpdateClientRedData("11002_"..v.Uid,1);
        elseif FriendChatMgr.charactersChatPro[keyUid]<NumTool.GetLen(FriendChatMgr.characterMsgMap[v.Uid]) then
            red_11002=red_11002+1;
            RedMgr.Singleton:UpdateClientRedData("11002_"..v.Uid,1);
        else
            RedMgr.Singleton:UpdateClientRedData("11002_"..v.Uid,0);
        end
    end
    RedMgr.Singleton:UpdateClientRedData("11002",red_11002);
    RedMgr.Singleton:UpdateClientRedData("11001",red_11003+red_11004+red_11002);





    RedMgr.Singleton:Refresh();
end

FriendChatMgr.UpdateHeroRed=function()
    red_11003=0;
    if IsNull(FriendChatMgr.friendMapList.FriendsList) then
        RedMgr.Singleton:UpdateClientRedData("11003",red_11003);
        RedMgr.Singleton:UpdateClientRedData("11001",red_11003+red_11004+red_11002+red_11005);
        RedMgr.Singleton:Refresh();
        return
    end;
    for i,v in ipairs(FriendChatMgr.friendMapList.FriendsList) do
        if FriendChatMgr.friendsMsgMap[v.Uid]~=nil and #FriendChatMgr.friendsMsgMap[v.Uid]>0 then
            RedMgr.Singleton:UpdateClientRedData("11003_"..v.Uid,1);
            red_11003=1;
        else
            RedMgr.Singleton:UpdateClientRedData("11003_"..v.Uid,0);
        end
    end
    RedMgr.Singleton:UpdateClientRedData("11003",red_11003);
    RedMgr.Singleton:UpdateClientRedData("11001",red_11003+red_11004+red_11002+red_11005);
    RedMgr.Singleton:Refresh();
end

FriendChatMgr.UpdateFriendRed=function()
    red_11004=0;
    if not IsNull(FriendChatMgr.friendMapList.ApplyList) and #FriendChatMgr.friendMapList.ApplyList>0 then
        red_11004=1;
    end
    RedMgr.Singleton:UpdateClientRedData("11004", red_11004);
    RedMgr.Singleton:UpdateClientRedData("11001", red_11004+red_11003+red_11002+red_11005);
    RedMgr.Singleton:Refresh();
end

FriendChatMgr.UpdateFriendPlayerInfoRed=function()
    red_11005 = FriendChatMgr.CheckFriendPlayerInfoRed_Badge() + FriendChatMgr.CheckFriendPlayerInfoRed_Theme()
    RedMgr.Singleton:UpdateClientRedData("11005", red_11005);
    RedMgr.Singleton:UpdateClientRedData("11001", red_11004+red_11003+red_11002+red_11005);
    RedMgr.Singleton:Refresh();
end


FriendChatMgr.CheckFriendPlayerInfoRed_Badge = function()
    local redCount = 0
    local skinCfgs = ConfigMgr.Config.FriendSkinMap
    for k, v in pairs(skinCfgs) do
        if FriendChatMgr.IsShowBadgeRedIcon(k) then
            redCount = redCount + 1
        end
    end
    return redCount
end
FriendChatMgr.IsShowBadgeRedIcon = function(id)
    local skinCfg = ConfigMgr.Config.FriendSkinMap[id]
    if skinCfg ~= nil and skinCfg.Default ~= 1 then
        local lock = not (IsNullOrEmpty(skinCfg.AvatarFrame) or nil ~= DataMgr.Player.avatarFrameMap[skinCfg.AvatarFrame])
        if not lock then
            local key = DataMgr.Player.uid .. "_FriendChatBadge_" .. id
            if not PlayerPrefs.HasKey(key) or PlayerPrefs.GetInt(key) == 0 then
                return true
            end
        end
    end
    return false
end

FriendChatMgr.CheckFriendPlayerInfoRed_Theme = function()
    local redCount = 0
    local skinCfgs = ConfigMgr.Config.FriendChatSkinMap
    for k, v in pairs(skinCfgs) do
        if FriendChatMgr.IsShowThemeRedIcon(k) then
            redCount = redCount + 1
        end
    end
    return redCount
end
FriendChatMgr.IsShowThemeRedIcon = function(id)
    local skinCfg = ConfigMgr.Config.FriendChatSkinMap[id]
    if skinCfg ~= nil and skinCfg.Default ~= 1 then
        if IsNullOrEmpty(skinCfg.Unlockitem) or DataHelper.GetItemCountById(skinCfg.Unlockitem)>0 then
            local key = DataMgr.Player.uid .. "_FriendChatTheme_" .. id
            if not PlayerPrefs.HasKey(key) or PlayerPrefs.GetInt(key) == 0 then
                return true
            end
        end
    end
    return false
end



FriendChatMgr.UpdateFriendList=function()
    if isSendingList then return end;
    isSendingList=true;
    ApiMgr.Request("friends/list",{},true,function(re)
        isSendingList=false;
        local data=json.decode(re)
        FriendChatMgr.friendMapList=data.result;
        LuaMgr.InvokeUIEventListeners(UIEventConst.FriendList,FriendChatMgr.friendMapList);
        FriendChatMgr.UpdateFriendRed();
    end,function()
        isSendingList=false;
    end,false)
end

FriendChatMgr.FindFriend=function(uid,callBack)
    local askData={Uid=uid}
    ApiMgr.Request("friends/recommend_friend", askData,true,function(re)
        local data=json.decode(re)
        callBack(data.result.RecommendFriends);
    end,function() callBack(nil); end,true)
end

FriendChatMgr.AddFriend=function(uid,callBack)
    local askData={Uid=uid}
    ApiMgr.Request("friends/apply", askData,true,function(re)
       callBack();
    end,nil,true)
end

FriendChatMgr.AgreeOrRefuseFriend=function(uids,isAgree,callBack)
    local askData={Agree=isAgree,Uids=uids}
    ApiMgr.Request("friends/agree_apply", askData,true,function(re)
        local data=json.decode(re)
        FriendChatMgr.friendMapList.FriendsList=data.result.FriendsList
        FriendChatMgr.friendMapList.ApplyList=data.result.ApplyList;
        callBack();
    end,nil,true)
end


FriendChatMgr.UpdateRemarkNameOrFavor=function(uid,remark,special,callBack)
    local askData={Uid=uid,Remark=remark,Special=special}
    ApiMgr.Request("friends/set_friend_info", askData,true,function(re)
        local data=json.decode(re)
        FriendChatMgr.friendMapList.FriendsList=data.result.FriendsList
        callBack();
    end,nil,true)
end

FriendChatMgr.DeleteFriend=function(uids,callBack)
    local askData={Uids=uids}
    ApiMgr.Request("friends/friend_remove", askData,true,function(re)
        local data=json.decode(re)
        FriendChatMgr.DeleteLocalRecordByUid(uids);
        FriendChatMgr.friendMapList.FriendsList=IsNull(data.result.FriendsList) and {} or data.result.FriendsList
        callBack();
    end,nil,true)
end


FriendChatMgr.ShieldFriend=function(uids,isMask,callBack)
    local askData={Uids=uids,Shield=isMask}
    ApiMgr.Request("friends/shield_player", askData,true,function(re)
        local data=json.decode(re)
        FriendChatMgr.DeleteLocalRecordByUid(uids);
        FriendChatMgr.friendMapList.FriendsList=IsNull(data.result.FriendsList) and {} or data.result.FriendsList;
        FriendChatMgr.friendMapList.ShieldList=IsNull(data.result.ShieldList) and {} or data.result.ShieldList;
        callBack();
    end,nil,true)
end


FriendChatMgr.ReportFriend=function(uid,data,msg,callBack)
    local askData={Uid=uid,ReportType=data,Message=msg}
    ApiMgr.Request("friends/report_player", askData,true,function(re)
        callBack();
    end,nil,true)
end

FriendChatMgr.SendMsg=function(uid,msg,callBack)
    local askData={Uid=uid,Msg=msg}
    ApiMgr.Request("friends/chat/sendMsg", askData,true,function(re)
        callBack(true);
    end,function()
        callBack(false)
    end,true)
end

FriendChatMgr.DeleteFriendMsg=function(uid,callBack)
    local askData={Uid=uid}
    ApiMgr.Request("friends/chat/removeMsg", askData,true,function(re)
        callBack(true);
    end,function()
        callBack(false)
    end,true)
end

FriendChatMgr.FriendPersonalHome=function(uid,callBack)
    ApiMgr.Request("friends/get_friend_info", {FriendUid =uid}, true, function(result)
        local re = json.decode(result)
        if callBack~=nil then
            callBack(re.result);
        end
    end, nil, true, true)
end

FriendChatMgr.AddTimer=function(friendTime,msgTime)
    LuaMgr.RemoveTimer(TimerConst.FriendChatUpdate);
    LuaMgr.RemoveTimer(TimerConst.FriendList);
    LuaMgr.AddTimer(TimerConst.FriendList,FriendChatMgr.UpdateFriendList,friendTime,-1,true);
    LuaMgr.AddTimer(TimerConst.FriendChatUpdate,FriendChatMgr.UpdateChatData,msgTime,-1,true);
end

FriendChatMgr.RemoveTimer=function()
    LuaMgr.RemoveTimer(TimerConst.FriendChatUpdate);
    LuaMgr.RemoveTimer(TimerConst.FriendList);

end

FriendChatMgr.Clear=function()
    LuaMgr.RemoveTimer(TimerConst.FriendChatUpdate);
    LuaMgr.RemoveTimer(TimerConst.FriendList);
end

FriendChatMgr.GetCurrentTheme=function()
    if IsNull(DataMgr.Player.Friends) or IsNullOrEmpty(DataMgr.Player.Friends.ChatSkinId) then
        return "CHAT01";
    end
    return DataMgr.Player.Friends.ChatSkinId;
end

return FriendChatMgr;