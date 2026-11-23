TrainingCampMgr = {}

TrainingCamp = {
Series_30001 = "30001",
};

local this = {
selectMembers = {},
assistMembers = {},

    techTypeMap = {},
};

TrainingCampMgr.Init = function()
end

TrainingCampMgr.Clear = function()
    this.techTypeMap = {}
end


TrainingCampMgr.GetCurWheelSeriesID = function()
    local curTime = LuaMgr.Timestamp();
    for i, v in pairs(ConfigMgr.Config.CampSeriesMap) do
        if curTime >= v.OpenTime and curTime < v.EndTime then
            return v.ID;
        end
    end
    return nil;
end


TrainingCampMgr.GetCampSeries = function(id)
    local campSeriesMap = ConfigMgr.Config.CampSeriesMap;
    if (IsNull(campSeriesMap)) then
        return nil
    end

    return campSeriesMap[id];
end


TrainingCampMgr.GetCampSeriesLevelLockState = function(time)
    local id = TrainingCampMgr.GetCurWheelSeriesID()
    local config = TrainingCampMgr.GetCampSeries(id)
    local curTime = LuaMgr.Timestamp();
    return curTime >= config.OpenTime + time * 24*3600
end



TrainingCampMgr.GetCampPlots = function(seriesId)
    local campPlots = {};
    local campPlotMap = ConfigMgr.Config.CampPlotMap;
    if (not IsNull(campPlotMap)) then
        for _, v in pairs(campPlotMap) do
            if (v.SeriesId == seriesId) then
                table.insert(campPlots, v);
            end
        end
        table.sort(campPlots, this.CampPlotSort);
    end
    return campPlots;
end


this.CampPlotSort = function(a, b)
    return string.lower(a.ID) < string.lower(b.ID);
end

TrainingCampMgr.GetTechCfgs = function(seriesId)
    local techCfgs = {};
    local campTechMap = ConfigMgr.Config.CampTechMap;
    for k, v in pairs(campTechMap) do
        if v.Id == seriesId then
            table.insert(techCfgs, v)
        end
    end
    table.sort(techCfgs, this.TechIdListSort);
    return techCfgs;
end

this.TechIdListSort = function(a, b)
    return tonumber(a.TechId) < tonumber(b.TechId);
end


TrainingCampMgr.CheckTechIsUnlock = function(techId)
    local trainingCamp = DataMgr.Player.trainingCamp;
    if (IsNull(trainingCamp)) then
        return false
    end

    local unlockTechMap = DataMgr.Player.trainingCamp.techTreeMap;
    if (IsNull(unlockTechMap) or IsNull(unlockTechMap[techId])) then
        return false;
    end
    return true
end


TrainingCampMgr.CheckTechIsCanUnlock = function(techId)
    if TrainingCampMgr.CheckTechIsUnlock(techId) then
        return false
    end
    local campTechCfg = ConfigMgr.Config.CampTechMap[techId]
    if not IsNullOrEmpty(campTechCfg.Unlock) and not TrainingCampMgr.CheckTechIsUnlock(campTechCfg.Unlock) then
        return false
    end
    return TrainingCampMgr.CheckTechUnlockConsumeEnough(techId)
end

TrainingCampMgr.CheckTechUnlockConsumeEnough = function(techId)
    local campTechCfg = ConfigMgr.Config.CampTechMap[techId]
    local cost = campTechCfg.Consume[1];
    local itemCount = PlayerItemMgr.GetItemCountById(cost.id);
    return itemCount >= cost.count
end

TrainingCampMgr.CheckIsCanUnlockTech = function()
    local techCfgs = TrainingCampMgr.GetTechCfgs("30003")
    for i, v in ipairs(techCfgs) do
        if TrainingCampMgr.CheckTechIsCanUnlock(v.TechId) then
            return true
        end
    end
    return false
end


TrainingCampMgr.CheckTechIsInEffect = function(techId)
    if not TrainingCampMgr.CheckTechIsUnlock(techId) then
        return false
    end
    local techCfgs = TrainingCampMgr.GetTechCfgs("30003")
    if TableIsNull(this.techTypeMap) then
        this.techTypeMap = {}
        for i, v in ipairs(techCfgs) do
            if this.techTypeMap[v.TechType] == nil then
                this.techTypeMap[v.TechType] = {}
            end
            table.insert(this.techTypeMap[v.TechType], v.TechId)
        end
    end

    local isInEffect = false
    local techTypeList = this.techTypeMap[ConfigMgr.Config.CampTechMap[techId].TechType]
    for i, v in ipairs(techTypeList) do
        if isInEffect and TrainingCampMgr.CheckTechIsUnlock(v) then
            return false
        end
        if v == techId then
            isInEffect = true
        end
    end
    return isInEffect
end

TrainingCampMgr.GetInEffectTechBuffList = function()
    local buffList = {}
    local trainingCamp = DataMgr.Player.trainingCamp;
    if IsNull(DataMgr.Player.trainingCamp) or IsNull(DataMgr.Player.trainingCamp.techTreeMap) then
        return buffList
    end

    local unlockTechMap = DataMgr.Player.trainingCamp.techTreeMap;
    for k, v in pairs(unlockTechMap) do
        if TrainingCampMgr.CheckTechIsInEffect(k) then
            local campTechCfg = ConfigMgr.Config.CampTechMap[k]
            if not TableIsNull(campTechCfg.Para) then
                for i, buffId in ipairs(campTechCfg.Para) do
                    table.insert(buffList, buffId)
                end
            end
        end
    end
    return buffList
end

TrainingCampMgr.UnlockTech = function(techId, callback)
    ApiMgr.Request("trainingcamp/techUnlock", { TechId = techId }, true, callback, nil, true, true);
end

TrainingCampMgr.ResetTech = function(callback)
    ApiMgr.Request("trainingcamp/techReset", {}, true, callback, nil, true, true);
end

TrainingCampMgr.GetTechPointItemIdAndCount = function()
    local itemId = ""
    local itemCount = 0
    local campTechMap = ConfigMgr.Config.CampTechMap
    for k, v in pairs(campTechMap) do
        if v.Consume ~= nil and next(v.Consume) ~= nil then
            itemId = v.Consume[1].id
            itemCount = PlayerItemMgr.GetItemCountById(itemId)
        end
    end
    return itemId, itemCount
end


TrainingCampMgr.GetCampRewards = function(seriesId)
    local campRewards = {};
    local campRewardMap = ConfigMgr.Config.CampRewardMap;
    if (not IsNull(campRewardMap)) then
        for _, v in pairs(campRewardMap) do
            if (v.SeriesId == seriesId) then
                table.insert(campRewards, v);
            end
        end
        table.sort(campRewards, this.CampRewardSort);
    end
    return campRewards;
end


this.CampRewardSort = function(a, b)
    return string.lower(a.ID) < string.lower(b.ID);
end


TrainingCampMgr.GetRewards = function(awardId, callback)
    ApiMgr.Request("trainingcamp/getRewards", { AwardId = awardId }, true, callback, nil, true, true);
end


TrainingCampMgr.IsReceiveReward = function(rewardId)
    local trainingCamp = DataMgr.Player.trainingCamp;
    if (IsNull(trainingCamp)) then
        return false
    end

    local rewards = DataMgr.Player.trainingCamp.rewards;
    if (IsNull(rewards) or IsNull(rewards[rewardId])) then
        return false;
    end
    return true;
end


TrainingCampMgr.GetStar = function(dungeonId)
    local challenges = ConfigMgr.Config.levelChallenges[dungeonId];
    if (challenges == nil) then
        return 0
    end

    local count = 0;
    local len = #challenges;
    for i = 1, len do
        if (DataMgr.Player.completedTags[challenges[i]] ~= nil) then
            count = count + 1;
        end
    end
    return count;
end


TrainingCampMgr.GetTotalStar = function(seriesId)
    local trainingCamp = DataMgr.Player.trainingCamp;
    if (IsNull(trainingCamp)) then
        return 0
    end

    local items = DataMgr.Player.trainingCamp.items;
    if (IsNull(items)) then
        return 0
    end

    local item = items[seriesId];
    if (IsNull(item)) then
        return 0
    end

    local star = 0;
    local campPlotMap = ConfigMgr.Config.CampPlotMap;
    for k, _ in pairs(item.records) do
        local campPlot = campPlotMap[k];
        if (campPlot ~= nil) then
            for i, v in pairs(campPlot.DungeonId) do
                star = star + TrainingCampMgr.GetStar(v)
            end
        end
    end
    return star;
end


TrainingCampMgr.IsPass = function(campPlotId)
    local campPlot = ConfigMgr.Config.CampPlotMap[campPlotId];
    if (campPlot ~= nil) then
        local record = DataMgr.Player.dungeonRecords[campPlot.DungeonId[1]];
        if (record == nil or IsNullOrEmpty(record.historyRating)) then
            return false;
        end
        record = DataMgr.Player.dungeonRecords[campPlot.DungeonId[2]];
        if (record == nil or IsNullOrEmpty(record.historyRating)) then
            return false;
        end
        return true;
    end
    return false;
end

TrainingCampMgr.GetLockMembersById = function(seriesId, dungeonId)
    local members = {};
    local filterMemberTeamMap = {};
    local trainingCamp = DataMgr.Player.trainingCamp;
    if (IsNull(trainingCamp)) then
        return members,filterMemberTeamMap
    end

    local items = DataMgr.Player.trainingCamp.items;
    if (IsNull(items)) then
        return members,filterMemberTeamMap
    end

    local item = items[seriesId];
    if (IsNull(item)) then
        return members,filterMemberTeamMap
    end

    local help = {};
    if (not IsNull(item.help)) then
        for i, v in pairs(item.help) do
            for k, id in pairs(v) do
                help[k] = id
            end
        end
    end
    for i, lock in pairs(item.lock) do
        if i == dungeonId then
            for k, v in pairs(lock) do
                local uid = help[k];
                if (IsNull(uid)) then
                    uid = "";
                end
                members[v] = uid;
            end
        end
    end
    return members;
end


TrainingCampMgr.GetLockMembers = function(seriesId, dungeonId,config)
    local members = {};
    local filterMemberTeamMap = {};
    local trainingCamp = DataMgr.Player.trainingCamp;
    if (IsNull(trainingCamp)) then
        return members,filterMemberTeamMap
    end

    local items = DataMgr.Player.trainingCamp.items;
    if (IsNull(items)) then
        return members,filterMemberTeamMap
    end

    local item = items[seriesId];
    if (IsNull(item)) then
        return members,filterMemberTeamMap
    end

    local help = {};
    if (not IsNull(item.help)) then
        for i, v in pairs(item.help) do
            for k, id in pairs(v) do
                help[k] = id
            end
        end
    end
    local index = -1;
    for i, lock in pairs(item.lock) do
        if i ~= dungeonId then
            for k, v in pairs(lock) do
                local uid = help[k];
                if (IsNull(uid)) then
                    uid = "";
                end

                if not TableIsNull(config) then
                    index = table.findIndex(config.DungeonId,i)
                end
                if index ~= nil and index >= 0 then
                    members[v] = uid;
                    filterMemberTeamMap[v] = index
                end
            end
        end
    end
    return members,filterMemberTeamMap;
end

function table.findIndex(tab, value)
    for i, v in ipairs(tab) do
        if v == value then
            return i
        end
    end
    return nil
end

TrainingCampMgr.SetMembersByFormationId = function(formationId, filterMemberMap)
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
    TrainingCampMgr.SetAssistMembers(this.assistMembers);
end


TrainingCampMgr.SetSelectMembers = function(members)
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


TrainingCampMgr.GetSelectMembers = function()
    local characterId;
    local assistMember;
    local index = 1;
    local len = #this.selectMembers;
    while (index <= len) do
        characterId = this.selectMembers[index];
        assistMember = this.assistMembers[characterId];
        if (assistMember ~= nil) then
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


TrainingCampMgr.SetAssistMembers = function(members)
    this.assistMembers = members or {};
end


TrainingCampMgr.GetAssistMembers = function()
    return this.assistMembers;
end


TrainingCampMgr.GetAssistMemberCount = function()
    return NumTool.GetLen(this.assistMembers);
end


TrainingCampMgr.SetMembers = function(seriesId, dungeonId)
    this.selectMembers = {};
    this.assistMembers = {};
    local trainingCamp = DataMgr.Player.trainingCamp;
    if (IsNull(trainingCamp)) then
        return
    end

    local items = DataMgr.Player.trainingCamp.items;
    if (IsNull(items)) then
        return
    end

    local item = items[seriesId];
    if (IsNull(item)) then
        return
    end

    local help;
    if (IsNull(item.help)) then
        help = {};
    else
        help = item.help[dungeonId] or {};
    end
    local lock;
    if (IsNull(item.lock)) then
        lock = {};
    else
        lock = item.lock[dungeonId] or {};
    end
    for i = 1, 6 do
        local key = tostring(i - 1);
        local characterId = lock[key];
        if (not IsNullOrEmpty(characterId)) then
            table.insert(this.selectMembers, characterId);
            if (not IsNullOrEmpty(help[key])) then
                this.assistMembers[characterId] = { id = characterId, uid = help[key] };
            end
        end
    end
    PlayerAssistMgr.SetAssistMembers(this.assistMembers);
end


TrainingCampMgr.UnlockMembers = function(dungeonId, campPlotId, callBack)
    local askData = {
        ID = campPlotId,
        DungeonId = dungeonId;
    }
    ApiMgr.Request("trainingcamp/clear", askData, true, function()
        if callBack ~= nil then
            callBack();
        end
    end, nil, true);
end