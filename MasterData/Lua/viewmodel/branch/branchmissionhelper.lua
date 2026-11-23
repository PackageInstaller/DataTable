




BranchMissionHelper = {}
BranchMissionHelper.BranchRedDataTabInit = function(str)
    local SaveData = BranchMissionHelper.initSaveDataForRed()
    local TotolRedData = {}
    for datakey, datavalue in pairs(DataMgr.Player.branch.children) do
        if datavalue.id ~= "Reg1001" and datavalue.id ~= "Reg2001" then
            for childkey, childvalue in pairs(datavalue.children) do

                if BranchMissionHelper.checkStoryTag(childvalue.id) then
                    if SaveData == nil or SaveData[childvalue.id] == nil then
                        if childvalue.unlocked and not childvalue.completed then
                            local function addBattleChildData()
                                TotolRedData[datavalue.id].ChildRedData[childvalue.id] = {
                                    childid = childvalue.id,
                                    tag = "1082",
                                    type = BranchEventType.Battle
                                }
                            end
                            if TotolRedData[datavalue.id] == nil then
                                TotolRedData[datavalue.id] = {
                                    id = datavalue.id,
                                    tag = "1081",
                                    ChildRedData = {}
                                }
                                addBattleChildData()
                            else
                                addBattleChildData()
                            end
                        end
                    end
                else
                    local function addGrandChildData(gridechildrenvalue)
                        TotolRedData[datavalue.id].ChildRedData[childvalue.id]
                                              .GrandSonRedData[gridechildrenvalue.id] = {
                            gridechildid = gridechildrenvalue.id,
                            tag = "1084"
                        }
                    end
                    local function addChildData(gridechildrenvalue)
                        TotolRedData[datavalue.id].ChildRedData[childvalue.id] = {
                            childid = childvalue.id,
                            tag = "1082",
                            type = BranchEventType.AVG,
                            GrandSonRedData = {}
                        }
                        addGrandChildData(gridechildrenvalue)
                    end
                    for gridechildren, gridechildrenvalue in pairs(childvalue.children) do
                        if gridechildrenvalue.unlocked and not gridechildrenvalue.completed and (SaveData == nil or SaveData[gridechildrenvalue.id] == nil) then
                            if TotolRedData[datavalue.id] == nil then
                                TotolRedData[datavalue.id] = {
                                    id = datavalue.id,
                                    tag = "1081",
                                    ChildRedData = {}
                                }
                                addChildData(gridechildrenvalue)
                            else
                                if TotolRedData[datavalue.id].ChildRedData[childvalue.id] == nil then
                                    addChildData(gridechildrenvalue)
                                else
                                    addGrandChildData(gridechildrenvalue)
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    local haveCount = 0
    ComData.branchData.NetredDataTab = TotolRedData
    BranchMissionHelper.BranchViewData()
    for key, value in pairs(ComData.branchData.NetredDataTab) do haveCount = haveCount + 1 end
    return haveCount ~= 0
end

BranchMissionHelper.BranchViewData = function()
    for key, value in pairs(DataMgr.Player.branch.children) do
        for playerkey, Playervalue in pairs(value.children) do
            if Playervalue.unlocked and Playervalue.completed and not Playervalue.received then
                local ChildDta = {}
                for childKey, childvalue in pairs(Playervalue.children) do
                    if childvalue.unlocked and childvalue.completed then
                        table.insert(ChildDta, childvalue.id)
                    end
                end
                local Clear = nil
                local Complete = nil
                local Pagestates = false
                local Textture = ""
                if #ChildDta ~= 0 then
                    Clear, Complete = BranchMissionHelper.checkChildSondata(ChildDta)
                end
                for index, Branchvalue in ipairs(ConfigMgr.Config.branchStoryList) do
                    if Playervalue.id == Branchvalue.ID then

                        local addRedMessage = function()
                            if ComData.branchData.NetredDataTab[value.id] == nil then

                                ComData.branchData.NetredDataTab[value.id] = {
                                    id = value.id,
                                    tag = "1081",
                                    ChildRedData = {}
                                }
                                ComData.branchData.NetredDataTab[value.id].ChildRedData[Branchvalue.ID .. "_reward"] =                            {
                                    childid = Branchvalue.ID,
                                    tag = "1083",
                                }
                            else
                                ComData.branchData.NetredDataTab[value.id].ChildRedData[Branchvalue.ID .. "_reward"] =                            {
                                    childid = Branchvalue.ID,
                                    tag = "1083",
                                }
                            end
                        end

                        if Branchvalue.condition == 1 and Clear or Complete then
                            addRedMessage()
                        end
                        if Branchvalue.condition == 2 and Complete then
                            addRedMessage()
                        end
                    end
                end
            end

        end
    end
end

BranchMissionHelper.BattleResultShow = function(characterID, type)
    local Clear = false
    local nowComplete = false
    local Complete = false
    local PicturePath = ""
    if tonumber(type) == BranchEventType.AVG then
        for key, value in ipairs(DataMgr.Player.completedChapters) do
            if value == characterID then
                Complete = true
                Clear = true
            end
        end
    elseif tonumber(type) == BranchEventType.Battle or tonumber(type) == BranchEventType.Weapon then
        local levelChallenges = nil
        for key, value in pairs(DataMgr.Player.dungeonRecords) do
            if key == characterID then
                PicturePath = "ui_zqzb_pj_" .. value.historyRating
                Clear = (value.historyRating ~= "" and value.historyRating ~= nil)
                if value.historyRating == "S" then
                    nowComplete = true
                    for Levelkey, levelvalue in
                    pairs(ConfigMgr.Config.levelChallenges) do
                        if Levelkey == characterID then
                            levelChallenges = levelvalue
                        end
                    end
                else
                    nowComplete = false
                end
                break
            else
                Clear = false
            end
        end
        if Clear and nowComplete then
            if levelChallenges ~= nil then
                for levelkey, levelvalue in pairs(levelChallenges) do
                    if DataMgr.Player.completedTags[levelvalue] == nil then
                        Complete = false
                    end
                end
            else
                Complete = true
            end
        end
    end
    return Clear, Complete, PicturePath
end

BranchMissionHelper.checkChildSondata = function(tab)
    local parame = {}
    for key, value in ipairs(tab) do
        for cfgkey, cfgvalue in pairs(ConfigMgr.Config.branchEventList) do
            if value == cfgvalue.ID then
                local battle = { id = cfgvalue.param, type = cfgvalue.type }
                table.insert(parame, battle)
            end
        end
    end
    local Clear = true
    local Complete = true
    for key, value in ipairs(parame) do
        local a, b, c = BranchMissionHelper.BattleResultShow(value.id, value.type)
        if not a then
            Clear = false
            Complete = false
        elseif not b then
            Complete = false
        end
    end
    return Clear, Complete
end

BranchMissionHelper.initSaveDataForRed = function()
    local Data
    local RedTable =    UnityEngine.PlayerPrefs.GetString(DataMgr.Player.uid .. "BranchRedTab")
    if RedTable ~= nil and RedTable ~= "" then Data = json.decode(RedTable) end
    return Data
end

BranchMissionHelper.checkStoryTag = function(id)
    for index, value in ipairs(ConfigMgr.Config.branchStoryList) do
        if id == value.ID then return (value.type == BranchEventType.Battle or value.type == BranchEventType.Weapon) end
    end
end


BranchMissionHelper.BranchChickTips = function(id)
    local ConditionId = "M200003"
    local targetBattleid = "S100101"
    local ConditionIdClear, ConditionIdComplete = BranchMissionHelper.BattleResultShow(ConditionId, 2)
    local targetIdClear, targetIdComplete = BranchMissionHelper.BattleResultShow(targetBattleid, 2)
    if (ConditionIdClear and not targetIdClear) then
        RedMgr.Singleton:UpdateClientRedData("1169", 1);
    else
        RedMgr.Singleton:UpdateClientRedData("1169", 0);
    end
end

BranchMissionHelper.BranchHeroNewRed = function()
    local redPoint = true
    local nowTime = LuaMgr.Timestamp()
    local tempData,time,timeBool = nil,nil,nil
    for i = 1, #ConfigMgr.Config.branchStoryList do
        if ConfigMgr.Config.branchStoryList[i].chapterID == "Reg1001" then
            tempData = ConfigMgr.Config.branchStoryList[i]
            time = tempData.UnlockConditions[1].ElementID == "" and 0 or tonumber(tempData.UnlockConditions[1].ElementID)
            timeBool = time <= nowTime
            if (tempData.UnlockConditions[1].UnlockType == 4 or
                    tempData.UnlockConditions[1].UnlockType == 0) and timeBool then
                redPoint = UnityEngine.PlayerPrefs.HasKey(tempData.ID)
                if not redPoint then
                    return 1
                end
            end
        end
    end
    return 0
end

BranchMissionHelper.BranchHeroRewardRed = function()
    local groupId = ActivityMgr.groupKeyList["Story1"]
    local activityData = DataMgr.Player.variables[groupId]
    if activityData == nil then return 0 end
    local time = activityData.expireTime - LuaMgr.Timestamp()
    if time <= 0 then return 0 end
    local typeId = tonumber(string.sub(groupId,7))
    local questEvents = DataExHelper.Check_ConfigQuestEventByGroupId(typeId)
    local tempData = nil
    for i = 1, #questEvents do
        tempData = DataMgr.Player.quests[questEvents[i].id]
        if tempData.state == 2 and questEvents[i].progress == tempData.progress then
            return 1
        end
    end
    return 0
end

BranchMissionHelper.BranchAnecdoteNewRed = function()
    local redPoint = true
    local nowTime = LuaMgr.Timestamp()
    local tempData,time,timeBool = nil,nil,nil
    for i = 1, #ConfigMgr.Config.branchStoryList do
        if ConfigMgr.Config.branchStoryList[i].chapterID == "Reg2001" then
            tempData = ConfigMgr.Config.branchStoryList[i]
            time = tempData.UnlockConditions[1].ElementID == "" and 0 or tonumber(tempData.UnlockConditions[1].ElementID)
            timeBool = time <= nowTime
            if (tempData.UnlockConditions[1].UnlockType == 4 or
                    tempData.UnlockConditions[1].UnlockType == 0) and timeBool then
                redPoint = UnityEngine.PlayerPrefs.HasKey(DataMgr.Player.uid..tempData.ID)
                if not redPoint then
                    return 1
                end
            end
        end
    end
    return 0
end

BranchMissionHelper.BranchAnecdoteRewardRed = function()
    local tempData = DataMgr.Player.branch.children["Reg2001"].children
    for k,v in pairs(tempData) do
        if v.unlocked then
            for i,t in pairs(v.children) do
                if t.completed and not t.received then
                    return 1
                end
            end
        end
    end
    return 0
end

return BranchMissionHelper