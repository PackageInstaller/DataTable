
PlayerAssistMgr = {

    assistMembers={};

    assistMembers_4X4={};

    isSupport=false;

    supportNum=0;

    heroIndex=nil;

    lastOpHeroId=nil;

    curUid=nil;

    isSupport_more=false;

    supportMoreShareNum=0;

    supportShareRecord={};
    otherAssistMember={};
}
local interval=180;
local curStampTime=-180;


local assistCharacter= {}



local assistInfo=nil;

local assistList={};


local tempMember={};


function PlayerAssistMgr.Init()
    curStampTime=-180;
    PlayerAssistMgr.Clear();
    PlayerAssistMgr.UpdateFriendList2();
end


function PlayerAssistMgr.IsOpen()
    if IsNull(ConfigMgr.Config.FriendConstants) then return false end;
    if IsNullOrEmpty(ConfigMgr.Config.FriendConstants.UnlockCondition) then
        return true;
    end
    local dungeonId=ConfigMgr.Config.FriendConstants.UnlockCondition;
    return DataMgr.Player.dungeonRecords[dungeonId]~=nil and DataMgr.Player.dungeonRecords[dungeonId].completeCount>0
end

function PlayerAssistMgr.Clear()
    PlayerAssistMgr.ClearAssistMembers();
    PlayerAssistMgr.ClearCurAssistData()
    PlayerAssistMgr.isSupport=false;
    PlayerAssistMgr.supportNum=0;
    PlayerAssistMgr.heroIndex=nil;
    PlayerAssistMgr.supportMoreShareNum=0;
    PlayerAssistMgr.isSupport_more=false;
    PlayerAssistMgr.supportShareRecord={}
    PlayerAssistMgr.assistMembers_4X4={}
    PlayerAssistMgr.otherAssistMember={};
end


function PlayerAssistMgr.LendFriendsHelp(assistList,callBack)
    local askData={
        CharacterIds=assistList;
    }
    ApiMgr.Request("friendHelp/lend",askData,true,function()
        if callBack~=nil then
            callBack();
        end
    end,function() end,true)
end

function PlayerAssistMgr.UpdateFriendList2(callBack)
    if UnityEngine.Time.realtimeSinceStartup-curStampTime<interval then
        if callBack~=nil then
            callBack();
        end
        return
    end;
    curStampTime=UnityEngine.Time.realtimeSinceStartup;
    PlayerAssistMgr.FriendsHelpList(callBack)
end

function PlayerAssistMgr.FriendsHelpList(callBack)
    ApiMgr.Request("friendHelp/list", {  },true,function(re)
        local re=json.decode(re);
        assistCharacter=re.result.CharacterDatas;
        PlayerAssistMgr.InitAssistList();
        if callBack~=nil then
            callBack();
        end
    end,function() end,true)
end


function PlayerAssistMgr.InitAssistList()
    if IsNull(assistCharacter) then return end;
    assistList={}
    for i,v in pairs(assistCharacter) do
        if not IsNullOrEmpty(i) then
            for p,m in pairs(v.CharacterInfoMap) do
                local value=table.Copy(m.Character);
                value.uid=i;
                value.uidName=v.Name;
                table.insert(assistList,value);
            end
        end
    end
end


function PlayerAssistMgr.FriendHelpReward(callBack)
    ApiMgr.Request("friendHelp/borrowReward", {  },true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if(callBack~=nil) then
            callBack();
        end
    end,function() end,true)
end


function PlayerAssistMgr.GetAssistList()
    return assistList;
end


function PlayerAssistMgr.CheckDungeonIsSupportAssist(dungeon,index,isTwo)
    if dungeon==nil then
        LuaDebug.error("dungeon is nil ")
        return
    end;
    if isTwo then
        index=3-index
        PlayerAssistMgr.otherAssistMember=PlayerAssistMgr.assistMembers_4X4[index];
    end
    if not PlayerAssistMgr.isSupport_more then
        PlayerAssistMgr.isSupport=dungeon.isSupport>0;
        PlayerAssistMgr.supportNum=dungeon.supportNum;
        PlayerAssistMgr.SetTempMembers();
        return;
    end

    PlayerAssistMgr.isSupport=true;
    PlayerAssistMgr.otherTeamAssistCount=0;
    if NumTool.GetLen(PlayerAssistMgr.otherAssistMember)>PlayerAssistMgr.supportMoreShareNum then
        LuaDebug.error("Error:assist hero count > supportMoreShareNum")
    end
    PlayerAssistMgr.supportNum=PlayerAssistMgr.supportMoreShareNum;
    PlayerAssistMgr.SetTempMembers();
    
end



function PlayerAssistMgr.CheckAssistListContainsKeyHero(uid,heroId)
    if assistCharacter==nil or assistCharacter[uid]==nil  then return false end;
    if IsNull(assistCharacter[uid].CharacterInfoMap) then return false end;
    return assistCharacter[uid].CharacterInfoMap[heroId]~=nil ;
end



function PlayerAssistMgr.SetCurAssistData_Strange(assistData)
    assistInfo=assistData;
end



function PlayerAssistMgr.SetCurAssistData(uid,heroId)
    assistInfo=nil;
    if assistCharacter[uid]~=nil and assistCharacter[uid].CharacterInfoMap[heroId]~=nil then
        assistInfo=assistCharacter[uid].CharacterInfoMap[heroId];
        assistInfo.uid=uid;
    end
end


function PlayerAssistMgr.IsCurAssistCharacter(heroId)
    if assistInfo==nil then 
        return false 
    end;
    return assistInfo.Character.id==heroId
end


function PlayerAssistMgr.GetCurAssist_CharacterData()
    if assistInfo~=nil then
        return assistInfo.Character;
    end
    return nil;
end


function PlayerAssistMgr.GetCurAssist_CharacterDataJson()
    if assistInfo~=nil then
        return json.encode(assistInfo.Character);
    end
    return nil;
end



function PlayerAssistMgr.GetCurAssist_equipData()
    if assistInfo~=nil then
        return assistInfo.Equipment;
    end
    return nil;
end


function PlayerAssistMgr.GetCurAssist_HeroUid()
    if assistInfo~=nil then
        return assistInfo.uid;
    end
    return nil;
end


function PlayerAssistMgr.ClearCurAssistData()
    assistInfo=nil;
end


function PlayerAssistMgr.GetAssistCharacterUID(heroID)
    local dungeonGroupMembersStr = PlayerPrefs.GetString(DataMgr.Player.uid .. "TrainingDungeonLastMembers" , "_")
    if IsNullOrEmpty(dungeonGroupMembersStr) then return nil end;
    local members = json.decode(dungeonGroupMembersStr)
    if IsNull(members) then return nil end;
    for k, v in pairs(members) do
        for k1, v1 in pairs(v) do
            if v1.id == heroID then
                return v1.uid
            end
        end
    end
    return nil;
end


function PlayerAssistMgr.GetAssistCharacters(uid)
    if assistCharacter[uid]==nil then
        return nil;
    end
    return assistCharacter[uid].CharacterInfoMap;
end


function PlayerAssistMgr.GetAssist_Character(uid,heroId)
    if assistCharacter[uid]==nil or  assistCharacter[uid].CharacterInfoMap[heroId]==nil then
        return nil;
    end
    return assistCharacter[uid].CharacterInfoMap[heroId].Character;
end



function PlayerAssistMgr.GetAssist_Equipment(uid,heroId)
    if assistCharacter[uid]==nil or  assistCharacter[uid].CharacterInfoMap[heroId]==nil then
        return nil;
    end
    return assistCharacter[uid].CharacterInfoMap[heroId].Equipment;
end


function PlayerAssistMgr.GetAssist_CharacterJson(uid,heroId)
    if assistCharacter[uid]==nil or  assistCharacter[uid].CharacterInfoMap[heroId]==nil then
        if assistInfo~=nil then

            return json.encode(assistInfo.Character);
        else
            return nil;
        end
    end
    local data= assistCharacter[uid].CharacterInfoMap[heroId].Character;
    local dataJson=json.encode(data);
    return dataJson;
end


function PlayerAssistMgr.GetAssist_EquipmentJson(uid,heroId)
    if assistCharacter[uid]==nil or  assistCharacter[uid].CharacterInfoMap[heroId]==nil then
        if assistInfo~=nil then

            return json.encode(assistInfo.Equipment);
        else
            return nil;
        end
    end
    local data= assistCharacter[uid].CharacterInfoMap[heroId].Equipment;
    if IsNull(data) then
        return nil;
    end
    local dataJson=json.encode(data);
    return dataJson;
end



function PlayerAssistMgr.CheckHeroChoiceMax()
    return PlayerAssistMgr.GetHeroChoiceAssistCount()>=PlayerAssistMgr.supportNum;
end

function PlayerAssistMgr.GetHeroChoiceAssistCount()
    if PlayerAssistMgr.isSupport_more then
       return PlayerAssistMgr.GetTempMemberCount()+NumTool.GetLen(PlayerAssistMgr.otherAssistMember)
    else
        return PlayerAssistMgr.GetTempMemberCount();
    end
end


function PlayerAssistMgr.GetTempMemberCount()
    return NumTool.GetLen(tempMember);
end

function PlayerAssistMgr.SetTempMembers()
    tempMember=table.Copy(PlayerAssistMgr.assistMembers);
end

function PlayerAssistMgr.GetTempMembers()
    if tempMember==nil then
        tempMember={}
    end
    return tempMember;
end

function PlayerAssistMgr.AddTempMembers(assistInfo,isMore)
    tempMember[assistInfo.id]=assistInfo;
    if isMore then
       return
    end
    local lastId=PlayerAssistMgr.lastOpHeroId;
    if lastId~=nil and assistInfo.id~=lastId then
        tempMember[lastId]=nil;
    end
    PlayerAssistMgr.lastOpHeroId=assistInfo.id;
end

function PlayerAssistMgr.RemoveTempMembers(heroId,isMore)
    tempMember[heroId]=nil;
end



function PlayerAssistMgr.SetAssistMembers(member)
    if member==nil then
        member={}
    end
    PlayerAssistMgr.assistMembers=table.Copy(member);
end


function PlayerAssistMgr.SaveAssistMembers()
    PlayerAssistMgr.assistMembers=table.Copy(tempMember);
end


function PlayerAssistMgr.IsAssistMember(heroId)
    return PlayerAssistMgr.assistMembers~=nil and PlayerAssistMgr.assistMembers[heroId]~=nil;
end


function PlayerAssistMgr.GetAssistMemberUid(heroId)
    if PlayerAssistMgr.assistMembers[heroId]==nil then
        return nil;
    end
    return PlayerAssistMgr.assistMembers[heroId].uid
end

function PlayerAssistMgr.ClearAssistMembers()
    PlayerAssistMgr.assistMembers={};
    tempMember={}
end


function PlayerAssistMgr.CheckCharacterIsChangeByUid()
    local team=DataMgr.Player.teams[BattlePrepareMgr.formationId]
    if team==nil then return false end;
    local helpsLen=0;
    if not IsNull(team.helps)  then
        for i,v in pairs(team.helps) do
            if not IsNullOrEmpty(v) then
                helpsLen=helpsLen+1;
            end
        end
    end
    if helpsLen~=NumTool.GetLen(PlayerAssistMgr.assistMembers) then
        return true;
    end
    for i,v in pairs(team.members) do
        local curUid=PlayerAssistMgr.assistMembers[v]~=nil and PlayerAssistMgr.assistMembers[v].uid or ""
        local tUid="";
        if not IsNull(team.helps) and IsNullOrEmpty(team.helps[i]) then
            tUid=team.helps[i];
        end
        if curUid~=tUid then
            return true;
        end
    end
    return false;
    
end



function PlayerAssistMgr.CheckDungeonIsSupportShare_More(dungeonMore)
    if dungeonMore~=nil then
        PlayerAssistMgr.isSupport_more=dungeonMore.Iscooperate>0;
        PlayerAssistMgr.supportMoreShareNum=dungeonMore.Cooperatelimit;
        PlayerAssistMgr.supportShareRecord={};
        if PlayerAssistMgr.isSupport_more then
            for i,v in ipairs(dungeonMore.DungeonId) do
                PlayerAssistMgr.supportShareRecord[v]=0;
            end
        end
    end
end



function PlayerAssistMgr.CheckDungeonIsSupportShare66(campPlot)
    if (campPlot ~= nil) then
        PlayerAssistMgr.isSupport_more = campPlot.IsCooperate>0;
        PlayerAssistMgr.supportMoreShareNum = campPlot.CooperateLimit;
        PlayerAssistMgr.supportShareRecord = {};
    end
end


function PlayerAssistMgr.CheckActivityDungeonIsSupportShare(cfg)
    if (cfg ~= nil) then
        PlayerAssistMgr.isSupport_more = cfg.IsCooperate>0;
        PlayerAssistMgr.supportMoreShareNum = cfg.CooperateLimit;
        PlayerAssistMgr.supportShareRecord = {};
    end
end


function PlayerAssistMgr.GoToPanel_HeroInfo(id,uid)
    local tempList = {}

    if uid~=nil  then
        PlayerAssistMgr.SetCurAssistData(uid,id);
    end
    table.insert(tempList, id)
    HeroParameter.SaveListParam(nil,nil,nil,0,1,tempList)
    FeatureManager.GotoPanel("1003")
end 

function PlayerAssistMgr.GoToPanel_HeroInfoStrange(assistData)
    local tempList = {}
    PlayerAssistMgr.SetCurAssistData_Strange(assistData);
    table.insert(tempList, assistData.Character.id)
    HeroParameter.SaveListParam(nil,nil,nil,0,1,tempList)
    FeatureManager.GotoPanel("1003")
end 


function PlayerAssistMgr.FriendRemainAssistCount(uid)
    local hasCount=0;
    if  not IsNull(DataMgr.Player.FriendHelp.FriendUseCountMap) and  DataMgr.Player.FriendHelp.FriendUseCountMap[uid]~=nil then
        hasCount=DataMgr.Player.FriendHelp.FriendUseCountMap[uid];
    end
    local reCount=ConfigMgr.Config.FriendConstants.PlayerBorrowLimit-hasCount;;
    reCount=reCount<0 and 0 or reCount;
    return reCount;
end 


function PlayerAssistMgr.GetCurMemberCount(uid)
local memberCount=0;

    if not IsNull(tempMember) then
        for i,v in pairs(tempMember) do
            if v.uid==uid then
                memberCount=memberCount+1;
            end
        end
    end

    if not IsNull(PlayerAssistMgr.otherAssistMember) then
        for i,v in pairs(PlayerAssistMgr.otherAssistMember) do
            if v.uid==uid then
                memberCount=memberCount+1;
            end
        end
    end
    return memberCount;
end



function PlayerAssistMgr.RemainAssistCount()
    local reCount=ConfigMgr.Config.FriendConstants.TotalBorrowLimit-DataMgr.Player.FriendHelp.DailyUseCount;
    reCount=reCount<0 and 0 or reCount;
    return reCount
end 