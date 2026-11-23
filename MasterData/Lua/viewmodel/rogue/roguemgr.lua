
RogueMgr = {
    GroupId_1 = 4095,
    GroupId_2 = 4098,
    RogueLevel = 0,
    DefaultBuffList = {},
    ChooseTeamId = 0,
    RogueBuffsMap = nil,
    TalentBuffList = {},
    CurShowPage = 1,
};

local this = {
    customTeamMemebers = nil,
}

RogueMgr.SetCustomTeamMembers = function(members)
    this.customTeamMemebers = {};
    if (members ~= nil) then
        local member;
        local len = #members;
        for i = 1, len do
            member = members[i];
            if (not IsNullOrEmpty(member)) then
                table.insert(this.customTeamMemebers, member);
            end
        end
    end
end

RogueMgr.GetCustomTeamMembers = function()
    return this.customTeamMemebers
end

RogueMgr.ShowCharacterDetailInfo = function(characterId)
    local tempList = {}
    table.insert(tempList, characterId)
    HeroParameter.SaveListParam(nil, nil, nil, 0, 1, tempList)
    HeroParameter.isRogueHeroInfo = true
    FeatureManager.GotoPanel("1003")
end

RogueMgr.GetCharacterDebuffLevel = function(characterId)
    local level = 0
    if not IsNull(DataMgr.Player.Rogue.Characters) then
        local chaData = DataMgr.Player.Rogue.Characters[characterId]
        if not TableIsNull(chaData) then
            level = chaData.FallCount
        end
    end
    return level
end

RogueMgr.GetCharacterExploreLevel = function(characterId)
    local level = ConfigMgr.Config.RogueConstants.RogueInitialDiscoverLevel
    if not IsNull(DataMgr.Player.Rogue.Characters) then
        local chaData = DataMgr.Player.Rogue.Characters[characterId]
        if not TableIsNull(chaData) then
            level = chaData.ExploreLevel
        end
    end
    return level
end


RogueMgr.GetBuffInfoByEntryId = function(entryId)
    local buffInfo = NumTool.split(entryId, "_")
    if RogueMgr.RogueBuffsMap == nil or NumTool.GetLen(RogueMgr.RogueBuffsMap) == 0 then
        RogueMgr.RogueBuffsFormatMap();
    end
    if #buffInfo > 1 and RogueMgr.RogueBuffsMap[buffInfo[1]] ~= nil then
        local buffId = RogueMgr.RogueBuffsMap[buffInfo[1]].GroupBuff[tonumber(buffInfo[2])];
        if not IsNullOrEmpty(buffId) then
            return ConfigMgr.Config.RogueBuffDescMap[buffId];
        end
        return nil;
    end
    return nil;
end

RogueMgr.RogueBuffsFormatMap = function()
    RogueMgr.RogueBuffsMap = {};
    for i, v in ipairs(ConfigMgr.Config.RogueBuffs) do
        RogueMgr.RogueBuffsMap[v.Id] = v;
    end
end


RogueMgr.GetBuffListByGenreBuff=function(buffIds,genreType)
    local buffList={}
    for i,v in ipairs(buffIds) do
        local buffInfo=ConfigMgr.Config.RogueBuffDescMap[v];
        if buffInfo~=nil and (genreType==0 or genreType==buffInfo.Genre) then
            table.insert(buffList,buffInfo);
        end
    end
    return buffList;
end


RogueMgr.GetCharacterDatasByIDList = function(IDList)
    local characterList = {}
    for i, v in ipairs(IDList) do
        local chaData = RogueMgr.GetCharacterDataByID(v)
        table.insert(characterList, chaData)
    end
    return characterList
end

RogueMgr.GetCharacterDataByID = function(characterId)
    local characterData = json.decode(LuaMgr.GetRogueCharacter(characterId))
    return characterData
end

RogueMgr.GetActivityLeftTimeStr_1 = function(expireTime)
    local leftTime = expireTime - LuaMgr.Timestamp()
    local d, h, m = GetTimeDHM2(leftTime);
    local dataStr = ""
    if d > 0 then
        dataStr = string.format(LuaMgr.GetLangText("RogueMgr_0"), d, h);
    elseif h > 0 then
        dataStr = string.format(LuaMgr.GetLangText("RogueMgr_1"), h, m);
    elseif m > 0 then
        dataStr = string.format(LuaMgr.GetLangText("RogueMgr_2"), m);
    end
    return dataStr
end

RogueMgr.GetActivityLeftTimeStr_2 = function(expireTime)
    local leftTime = expireTime - LuaMgr.Timestamp()
    local d, h, m = GetTimeDHM2(leftTime);
    local dataStr = ""
    if d > 0 then
        dataStr = string.format(LuaMgr.GetLangText("RogueMgr_3"), d, h);
    elseif h > 0 then
        dataStr = string.format(LuaMgr.GetLangText("RogueMgr_4"), h, m);
    elseif m > 0 then
        dataStr = string.format(LuaMgr.GetLangText("RogueMgr_5"), m);
    end
    return dataStr
end


RogueMgr.GetHeroNowRare = function(characterId)
    local tempConfig = ConfigCharacterMgr.GetInfo(characterId)
    if not TableIsNull(tempConfig) then
        local rare = tempConfig.rare
        local tempData = RogueMgr.GetCharacterDataByID(characterId)
        if not TableIsNull(tempData) and type(tempData.brilliant) ~= "function" and not TableIsNull(tempData.brilliant) then
            rare = rare + tempData.brilliant.RareLevel
        end
        return rare
    end
    return 0
end

RogueMgr.GetTalentBuffList = function()
    local unlockTechIds = DataMgr.Player.RogueTech
    if IsNull(unlockTechIds) or TableIsNull(unlockTechIds) then
        return {}
    end
    if TableIsNull(RogueMgr.TalentBuffList) then
        local techCfgs = ConfigMgr.Config.RogueTechs
        local tempList = {}
        for i, v in ipairs(techCfgs) do
            if unlockTechIds[v] ~= nil and v.Type == 1 and not TableIsNull(v.Para) then
                for j, n in ipairs(v.Para) do
                    table.insert(tempList, n)
                end
            end
        end
        RogueMgr.TalentBuffList = tempList
    end
    return RogueMgr.TalentBuffList
end


RogueMgr.OnAskGetEventReward = function(eventIds, callBack)
    local askData = { EventIds = eventIds }
    ApiMgr.Request("rogue/handbook", askData, true, function(result)
        local re = json.decode(result);
        local data = re.result;
        LuaMgr.ShowItemRewared(json.encode(re.result))
        if callBack ~= nil then
            callBack(data);
        end
    end, nil, true);
end

RogueMgr.CheckSaveTeam=function(memberDic,callBack)
    RogueMgr.OnAskSaveTeam(memberDic,callBack)
end

RogueMgr.GetTechTreeRed = function()
    local redCount = 0
    local rogueTechCfgs = ConfigMgr.Config.RogueTechs
    local unlockTechMap = DataMgr.Player.RogueTech
    for i, v in ipairs(rogueTechCfgs) do
        local techId = v.Id
        if unlockTechMap[techId] == nil then
            if tonumber(v.Unlock[1]) == 0 then
                local cost = v.Consume[1];
                local costCount = tonumber(v.Consume[2]);
                local item = DataMgr.Player.items[cost];
                local itemCount = item ~= nil and item.count0 or 0;
                if itemCount~=nil and costCount~=nil and itemCount >= costCount then
                    redCount = 1
                    break
                end
            elseif tonumber(v.Unlock[1]) == 1 and unlockTechMap[v.Unlock[2]] ~= nil then
                local cost = v.Consume[1];
                local costCount = tonumber(v.Consume[2]);
                local item = DataMgr.Player.items[cost];
                local itemCount = item ~= nil and item.count0 or 0;
                if itemCount~=nil and costCount~=nil and itemCount >= costCount then
                    redCount = 1
                    break
                end
            end
        end
    end
    return redCount
end

RogueMgr.GetMedalList = function()
    local medalConfigs = ConfigMgr.Config.Medals
    local medalStepDatas = TableIsNull(DataMgr.Player.MedalStepMap) and {} or DataMgr.Player.MedalStepMap
    local medalDatas = TableIsNull(DataMgr.Player.MedalMap) and {} or DataMgr.Player.MedalMap
    local tempList = {}
    for k, v in pairs(medalConfigs) do
        if (RogueMgr.CurShowPage == 1 and v.Activity == tostring(RogueMgr.GroupId_1)) or (RogueMgr.CurShowPage == 2 and v.Activity == tostring(RogueMgr.GroupId_2)) then
            local item = {
                icon = LuaMgr.GetSprite("ZhanXunIcon", v.Id),
                name = LuaMgr.GetLangText(v.NameLan),
                desc = LuaMgr.GetLangText(v.DesLan),
                remark = LuaMgr.GetLangText(v.RemarksLan),
                progress = 0,
                target = tonumber(v.Condition[1].ElementID),
                finish = medalDatas[v.Id] ~= nil
            }
            if medalStepDatas[v.Id] ~= nil then
                item.progress = medalStepDatas[v.Id].Current
                item.target = medalStepDatas[v.Id].Target
            end
            table.insert(tempList, item)
        end
    end
    return tempList
end

RogueMgr.PlayBgm = function()
    if RogueMgr.CheckRogueLike2IsOpen() then
        AudioMgr.Singleton:PlayBgm("Assets/_BundleResources/Audio/Bgm/bgm_Rogue2Activity.mp3", true);
    else
        AudioMgr.Singleton:PlayBgm("Assets/_BundleResources/Audio/Bgm/bgm_RogueActivity.mp3", true);
    end
end

RogueMgr.Clear = function()
    RogueMgr.RogueLevel = 0
    RogueMgr.DefaultBuffList = {}
    RogueMgr.ChooseTeamId = 0
    RogueMgr.RogueBuffsMap = nil
    RogueMgr.TalentBuffList = {}
    LuaMgr.ClearRogueDataCache()
end


RogueMgr.OnAskResetTech = function(version, callBack)
    local askData = {version = version}
    ApiMgr.Request("rogue/tech_reset", askData, true, function(result)
        HeroRedDataHelper.SetRogueRed()
        if callBack ~= nil then
            callBack(result);
        end
    end, nil, true);
end


RogueMgr.OnAskUnlockTech = function(techId, callBack)
    local askData = { TechId = techId }
    ApiMgr.Request("rogue/tech", askData, true, function(result)
        HeroRedDataHelper.SetRogueRed()
        if callBack ~= nil then
            callBack(result);
        end
    end, nil, true);
end


RogueMgr.OnAskGetEventReward = function(ids, callBack)
    local askData = { HandbookIds = ids }
    ApiMgr.Request("rogue/handbook", askData, true, function(result)
        HeroRedDataHelper.SetRogueRed()
        local re = json.decode(result);
        local data = re.result;
        LuaMgr.ShowItemRewared(json.encode(re.result))
        if callBack ~= nil then
            callBack(data);
        end
    end, nil, true);
end



RogueMgr.OnAskCompleteEvent = function(eventNumber, eventId, optionIndex, callBack)
    local selectStr = eventId;
    if optionIndex ~= nil then
        selectStr = string.format("%s_%s", eventId, optionIndex);
    end
    local data = { EventNumber = eventNumber, Select = selectStr }
    ApiMgr.Request("rogue/event", data, true, function(result)
        local re = json.decode(result);
        local data = re.result;
        if callBack ~= nil then
            callBack(data);
        end
    end, nil, true);
end


RogueMgr.OnAskRefreshCharacterOrBUFF = function(mapId,eventNumber,callBack)
    local askData = {MapId=mapId,EventNumber=eventNumber}
    ApiMgr.Request("rogue/refresh", askData, true, function(result)
        local re = json.decode(result);
        local data = re.result;
        if callBack ~= nil then
            callBack(data);
        end
    end, nil, true);
end


RogueMgr.OnAskConfrimCharacterOrBUFF = function(mapId,eventNumber,heroID, callBack)
    local askData = { MapId=mapId,EventNumber=eventNumber,EventConfirm = heroID }
    ApiMgr.Request("rogue/confirm", askData, true, function(result)
        local re = json.decode(result);
        local data = re.result;
        if callBack ~= nil then
            callBack(data);
        end
    end, nil, true);
end


RogueMgr.OnAskExitCharacterOrBuff = function(mapId,eventNumber,callBack)
    local askData = {MapId=mapId,EventNumber=eventNumber}
    ApiMgr.Request("rogue/exit", askData, true, function(result)
        local re = json.decode(result);
        local data = re.result;
        if callBack ~= nil then
            callBack(data);
        end
    end, nil, true);
end

RogueMgr.OnAskSaveTeam = function(memberDic, callBack)
    local askData = { Members = memberDic }
    ApiMgr.Request("rogue/members", askData, true, function(result)
        local re = json.decode(result);
        local data = re.result;
        if callBack ~= nil then
            callBack(data);
        end
    end, nil, true);
end


RogueMgr.OnAskBuyShop=function(mapId,eventNumber,values,callBack)
    local askData={MapId=mapId,EventNumber=eventNumber,Goods=values}
    ApiMgr.Request("rogue/shop",askData,true,function(result)
        local re=json.decode(result);
        local data=re.result;
        if callBack~=nil then
            callBack(data);
        end
    end,nil,true);
end


RogueMgr.OnAskExploreStart=function(param, callBack)
    ApiMgr.Request("rogue/start",param,true,function(result)
        if callBack~=nil then
            callBack(result);
        end
    end,nil,true);
end


RogueMgr.OnAskExploreEnd=function(callBack)
    local askData={}
    ApiMgr.Request("rogue/end",askData,true,function(result)
        local re=json.decode(result);
        local data=re.result;
        if callBack~=nil then
            callBack(data);
        end
    end,nil,true);
end


RogueMgr.GMAddBuff=function(buffIds,callBack)
    local askData={BuffIds=buffIds}
    ApiMgr.Request("gm/rogue/add_buff",askData,true,function(result)
        local re=json.decode(result);
        local data=re.result;
        if callBack~=nil then
            callBack(data);
        end
    end,nil,true);
end

RogueMgr.GMAddCharacter=function(characterId,callBack)
    local askData={CharacterId=characterId}
    ApiMgr.Request("gm/rogue/add_character",askData,true,function(result)
        local re=json.decode(result);
        local data=re.result;
        if callBack~=nil then
            callBack(data);
        end
    end,nil,true);
end

RogueMgr.GMChangeItems=function(itemID,count,callBack)
    local askData={ItemId=itemID,Count=count}
    ApiMgr.Request("gm/rogue/item",askData,true,function(result)
        local re=json.decode(result);
        local data=re.result;
        if callBack~=nil then
            callBack(data);
        end
    end,nil,true);
end


RogueMgr.GetGlobalBuffsLevel=function()
    local buffMapLevel={}
    for i,v in ipairs(ConfigMgr.Config.RogueBuffs) do
        for p,m in ipairs(v.GroupBuff) do
            buffMapLevel[m]=p;
        end
    end
    if IsNull(DataMgr.Player.Rogue) or IsNull(DataMgr.Player.Rogue.GlobalBuffIds) then
      return 0;
    end
    local buffLevel=0;
    for i,v in ipairs(DataMgr.Player.Rogue.GlobalBuffIds) do
        if buffMapLevel[v]~=nil then
            buffLevel=buffLevel+buffMapLevel[v];
        end
    end
    return buffLevel;
end

RogueMgr.CheckRogueLike2IsOpen = function()
    if ConfigMgr.Config.RogueConstants.RogueNextTime ~= nil and LuaMgr.Timestamp() >= ConfigMgr.Config.RogueConstants.RogueNextTime then
        return true
    end
    return false
end

return RogueMgr