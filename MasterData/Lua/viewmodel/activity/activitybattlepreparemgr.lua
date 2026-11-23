ActivityBattlePrepareMgr = {}

local this = {
selectMembers = {},
assistMembers = {},
teamWeaponIdMap = {},
};

ActivityBattlePrepareMgr.Init = function()
end

ActivityBattlePrepareMgr.Clear = function()
end


ActivityBattlePrepareMgr.GetLockMembersAndHelps = function(activityKey, Id)
    local members = {};
    local helps = {};
    if activityKey == ActivityKey.MiniBattle then
        members, helps = MiniBattleMgr.GetLockMembersAndHelps(Id)
    elseif activityKey == ActivityKey.crisiscontract2 then
        members, helps = CrisisContract2Mgr.GetLockMembersAndHelps(Id)
    elseif activityKey == ActivityKey.crisiscontract3 then
        members, helps = CrisisContract3Mgr.GetLockMembersAndHelps(Id)
    elseif activityKey == ActivityKey.MiniBattlenew then
        members, helps = MiniBattle2Mgr.GetLockMembersAndHelps(Id)
    elseif activityKey == ActivityKey.MiniBattle5 then
        members, helps = MiniBattle5Mgr.GetLockMembersAndHelps(Id)
    elseif activityKey == ActivityKey.BossDummy3 then
        members, helps = BossDummy3Mgr.GetLockMembersAndHelps(Id)
    elseif activityKey == ActivityKey.BossDummy4 then
        members, helps = BossDummy3Mgr.GetLockMembersAndHelps(Id)
    elseif activityKey == ActivityKey.BossDummy5 then
        members, helps = BossDummy3Mgr.GetLockMembersAndHelps(Id)
    elseif activityKey == ActivityKey.DualBattle then
        members, helps = MiniBattle3Mgr.GetLockMembersAndHelps(Id)
    elseif activityKey == ActivityKey.DualBattle2 then
        members, helps = MiniBattle4Mgr.GetLockMembersAndHelps(Id)
    elseif activityKey == ActivityKey.TeamRelay then
        members, helps = SCNJData.GetLockMembersAndHelps(Id)
    elseif activityKey == ActivityKey.TeamRelay2 then
        members, helps = TeamRelay2Mgr.GetLockMembersAndHelps(Id)
    elseif activityKey == ActivityKey.TeamRelay3 then
        members, helps = CrisisContract4Mgr.GetLockMembersAndHelps(Id)
    end
    return members, helps
end


ActivityBattlePrepareMgr.GetLockMembers = function(activityKey, Id)
    local memberDic = {};
    local members, helps = ActivityBattlePrepareMgr.GetLockMembersAndHelps(activityKey, Id)
    for k, v in pairs(members) do
        local uid = helps[k];
        if (IsNull(uid)) then
            uid = "";
        end
        memberDic[v] = uid;
    end
    return memberDic;
end


ActivityBattlePrepareMgr.SetSelectMembers = function(members)
    this.selectMembers = {};
    if (members ~= nil) then
        local member;
        local len = #members;
        for i = 1, len do
            member = members[i];
            if (not IsNullOrEmpty(member)) then
                table.insert(this.selectMembers, member);
            end
        end
    end
end


ActivityBattlePrepareMgr.GetSelectMembers = function(filterMemberMap)
    local characterId;
    local assistMember;
    local index = 1;
    local len = #this.selectMembers;
    while (index <= len) do
        characterId = this.selectMembers[index];
        assistMember = this.assistMembers[characterId];
        if not TableIsNull(filterMemberMap) and filterMemberMap[characterId] ~= nil then
            table.remove(this.selectMembers, index);
            len = len - 1;
        elseif (assistMember ~= nil) then
            if (PlayerAssistMgr.CheckAssistListContainsKeyHero(assistMember.uid, characterId)
                    and PlayerAssistMgr.FriendRemainAssistCount(assistMember.uid) > 0
                    and PlayerAssistMgr.RemainAssistCount() > 0) then
                index = index + 1;
            else
                this.assistMembers[characterId] = nil;
                table.remove(this.selectMembers, index);
                len = len - 1;
            end
        else
            index = index + 1;
        end
    end
    PlayerAssistMgr.SetAssistMembers(this.assistMembers);
    return this.selectMembers;
end


ActivityBattlePrepareMgr.SetAssistMembers = function(members)
    this.assistMembers = members or {};
end


ActivityBattlePrepareMgr.GetAssistMembers = function()
    return this.assistMembers;
end


ActivityBattlePrepareMgr.GetAssistMemberCount = function()
    return NumTool.GetLen(this.assistMembers);
end


ActivityBattlePrepareMgr.SetMembers = function(activityKey, battleId)
    this.selectMembers = {};
    this.assistMembers = {};
    local members, helps = ActivityBattlePrepareMgr.GetLockMembersAndHelps(activityKey, battleId)
    for i = 1, 6 do
        local key = tostring(i - 1);
        local characterId = members[key];
        if (not IsNullOrEmpty(characterId)) then
            table.insert(this.selectMembers, characterId);
            if (not IsNullOrEmpty(helps[key])) then
                this.assistMembers[characterId] = { id = characterId, uid = helps[key] };
            end
        end
    end
    PlayerAssistMgr.SetAssistMembers(this.assistMembers);
end

ActivityBattlePrepareMgr.SetMembersByFormationId = function(formationId, filterMemberMap)
    this.selectMembers = {};
    this.assistMembers = {};
    local team = DataMgr.Player.teams[formationId]
    if team ~= nil then
        local tempMembers = {}
        for k, item in pairs(team.members) do
            if not IsNullOrEmpty(ActivityBattlePrepareMgr.CheckMemberInvalid(item, formationId)) and filterMemberMap[item] == nil then
                table.insert(tempMembers, { index = tonumber(k), id = item })
                if not IsNullOrEmpty(team.helps[k]) then
                    this.assistMembers[item] = { id = item, uid = team.helps[k] };
                end
            end
        end
        table.sort(tempMembers, function(a, b)
            return a.index < b.index
        end)
        for i, v in ipairs(tempMembers) do
            table.insert(this.selectMembers, v.id)
        end
        if next(filterMemberMap) ~= nil and next(team.members) ~= nil and next(tempMembers) == nil then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityBattlePrepareMgr_0"))
        end
    end
    PlayerAssistMgr.SetAssistMembers(this.assistMembers);
end

ActivityBattlePrepareMgr.CheckMemberInvalid = function(member, formationId)
    local team=DataMgr.Player.teams[formationId];
    if team == nil or team.members == nil then
        return ""
    end
    for i, v in pairs(team.members) do
        if v == member then
            local heroData = DataMgr.Player.characters[v]
            if heroData == nil and (team.helps == nil or team.helps[i] == nil or IsNullOrEmpty(team.helps[i])) then
                return ""
            end
        end
    end
    return member
end

ActivityBattlePrepareMgr.SetTeamWeaponId = function(activityDungeonId, teamWeaponId) 
    this.teamWeaponIdMap[activityDungeonId] = teamWeaponId
end

ActivityBattlePrepareMgr.GetTeamWeaponId = function(activityDungeonId)
    local teamWeaponId = ""
    if this.teamWeaponIdMap[activityDungeonId] ~= nil then
        teamWeaponId = this.teamWeaponIdMap[activityDungeonId]
    end
    return teamWeaponId
end