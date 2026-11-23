





HeroParameter = {}
local TableInsert = table.insert



HeroParameter.paramBool = false
HeroParameter.jobType = nil
HeroParameter.sortType = nil
HeroParameter.sequenceType = nil
HeroParameter.scrollPosition = nil
HeroParameter.characterIndex = nil
HeroParameter.characterList = nil
HeroParameter.characterId = nil

HeroParameter.SaveListParam = function(jobType,sortType,sequenceType,scrollPosition,index,list)
    HeroParameter.paramBool = true
    HeroParameter.jobType = jobType
    HeroParameter.sortType = sortType
    HeroParameter.sequenceType = sequenceType
    HeroParameter.scrollPosition = scrollPosition
    HeroParameter.characterIndex = index
    if (list ~= nil) then
        HeroParameter.characterList = list
        HeroParameter.characterId = list[index]
    end
end


HeroParameter.CheckCharacterListIsNull = function()
    if TableIsNull(HeroParameter.characterList) then
        if not TableIsNull(HeroParameter.IsShowCharacterList) then
            HeroParameter.characterList = HeroParameter.IsShowCharacterList
            HeroParameter.characterIndex = 1
            HeroParameter.characterId = HeroParameter.characterList[HeroParameter.characterIndex]
        else
            HeroParameter.characterId = "V0064"
            HeroParameter.characterList = {"V0064"}
            HeroParameter.characterIndex = 1
        end
    else
        HeroParameter.characterId = HeroParameter.characterList[HeroParameter.characterIndex]
    end
end

HeroParameter.EmptyListParam = function()
    HeroParameter.paramBool = false
    HeroParameter.jobType = nil
    HeroParameter.sortType = nil
    HeroParameter.sequenceType = nil
    HeroParameter.scrollPosition = nil
    HeroParameter.characterIndex = nil
    HeroParameter.characterList = nil
    HeroParameter.characterId = nil
    HeroParameter.IsShowCharacterList = nil
end

HeroParameter.IsShowCharacterList = nil

HeroParameter.EmptyJobSort = function()
    HeroParameter.jobType = nil
    HeroParameter.sortType = nil
    HeroParameter.sequenceType = nil
end




HeroParameter.teamIndex = nil
HeroParameter.selectType = false
HeroParameter.clickHero = nil
HeroParameter.teamMembers = nil
HeroParameter.callback = nil
HeroParameter.isTeamChanged = false

HeroParameter.SaveTeamParam = function(teamIndex,selectType,clickHero,callback)
    HeroParameter.teamIndex = teamIndex
    HeroParameter.selectType = selectType
    HeroParameter.clickHero = clickHero
    HeroParameter.callback = callback
    HeroParameter.isTeamChanged = false
    HeroParameter.teamMembers = {}
    local team = DataMgr.Player.teams[tostring(teamIndex)]
    local length = ConfigHelper.GetTableLength(team.members)
    for i = 0, length - 1 do
        local id = team.members[tostring(i)]
        local uid = team.helps[tostring(i)]
        if IsNullOrEmpty(uid) then
            TableInsert(HeroParameter.teamMembers,id)
        end
    end
end

HeroParameter.EmptyTeamParam = function()
    HeroParameter.teamIndex = nil
    HeroParameter.selectType = false
    HeroParameter.clickHero = nil
    HeroParameter.teamMembers = nil
    HeroParameter.callback = nil
    HeroParameter.isTeamChanged = false
end





HeroParameter.teamIndex = nil
HeroParameter.clickHero = nil
HeroParameter.whetherSave = nil
HeroParameter.battleBool = false
HeroParameter.selectType = false
HeroParameter.membersParam = nil
HeroParameter.battleMembers = nil
HeroParameter.isTraining = false
HeroParameter.trainingTeamIndex = nil
HeroParameter.anotherTeam = nil
HeroParameter.trainingMemberCount = {0, 0}
HeroParameter.heroCount = nil;

HeroParameter.SaveBattlePrepareParam = function(index,heroId,whetherSave,battleBool,selectType,membersParam)
    HeroParameter.teamIndex = index
    HeroParameter.clickHero = heroId
    HeroParameter.whetherSave = whetherSave
    HeroParameter.battleBool = battleBool
    HeroParameter.selectType = selectType
    HeroParameter.membersParam = membersParam
HeroParameter.isCultivate=true;
    HeroParameter.changeAfterTeam = nil
    HeroParameter.battleMembers = {}
    for i = 1, #membersParam do
        TableInsert(HeroParameter.battleMembers,membersParam[i])
    end
    HeroParameter.isTraining = false
    HeroParameter.trainingMemberCount = {0, 0}
end


HeroParameter.SetTrainingParam = function(trainingTeamIndex, anotherTeam, memberCount, memberLimitCount)
    HeroParameter.isTraining = true
    HeroParameter.trainingTeamIndex = trainingTeamIndex
    HeroParameter.anotherTeam = anotherTeam
    HeroParameter.trainingMemberCount = memberCount
    HeroParameter.heroCount = memberLimitCount[HeroParameter.teamIndex]
end


HeroParameter.SaveTrainingChoice = function(groupId, currentIndex)
    HeroParameter.SaveTrainingChoiceParam = {trainingDungeonGroupId = groupId, currentIndex = currentIndex}
end


HeroParameter.SaveTeamChangeParam = function(changeAfterTeam)
    HeroParameter.changeAfterTeam = changeAfterTeam
end

HeroParameter.EmptyBattlePrepareParam = function()
    HeroParameter.teamIndex = nil
    HeroParameter.clickHero = nil
    HeroParameter.whetherSave = nil
    HeroParameter.battleBool = nil
    HeroParameter.selectType = false
    HeroParameter.membersParam = nil
HeroParameter.isCultivate=true;
    HeroParameter.battleMembers = nil
    HeroParameter.changeAfterTeam = nil
    HeroParameter.isTraining = false
    HeroParameter.heroCount = nil;
end

HeroParameter.EmptyTrainingParam = function()
    HeroParameter.isTraining = false
    HeroParameter.trainingTeamIndex = nil
    HeroParameter.anotherTeam = nil
    HeroParameter.trainingMemberCount = {0, 0}
    HeroParameter.heroCount = nil
end



HeroParameter.label = nil
HeroParameter.relics = false
HeroParameter.collect = false
HeroParameter.SaveTerminalMapParam = function(label,relics,collect)
    HeroParameter.label = label
    HeroParameter.relics = relics
    HeroParameter.collect = collect
end
HeroParameter.EmptyTerminalMapParam = function()
    HeroParameter.label = nil
    HeroParameter.relics = false
    HeroParameter.collect = false
end

HeroParameter.terminalMapList = nil
HeroParameter.terminalMapIndex = nil
HeroParameter.SaveTerminalMapList = function(list,index)
    HeroParameter.terminalMapList = list
    HeroParameter.terminalMapIndex = index
end
HeroParameter.EmptyTerminalMapList = function()
    HeroParameter.terminalMapList = nil
    HeroParameter.terminalMapIndex = nil
end

HeroParameter.NovelTypeLabel = nil
HeroParameter.ReviewActivityBarIndex=nil;
HeroParameter.contentX = nil
HeroParameter.contentY = nil
HeroParameter.SaveNovelEventParam = function(label,x,y)
    HeroParameter.NovelTypeLabel = label
    HeroParameter.contentX = x
    HeroParameter.contentY = y
end
HeroParameter.EmptyNovelEventParam = function()
    HeroParameter.NovelTypeLabel = nil
    HeroParameter.contentX = nil
    HeroParameter.contentY = nil
    HeroParameter.ReviewActivityBarIndex=nil
end

HeroParameter.MainIndexList = nil
HeroParameter.SaveNovelMainIndexList = function(list)
    HeroParameter.MainIndexList = list
end
HeroParameter.EmptyMainIndexList = function()
    HeroParameter.MainIndexList = nil
end

HeroParameter.MissionLabel = nil
HeroParameter.MissionContentX = nil
HeroParameter.MissionContentY = nil
HeroParameter.SaveMissionParam = function(label,x,y)
    HeroParameter.MissionLabel = label
    HeroParameter.MissionContentX = x
    HeroParameter.MissionContentY = y
end
HeroParameter.EmptyMissionParam = function()
    HeroParameter.MissionLabel = nil
    HeroParameter.MissionContentX = nil
    HeroParameter.MissionContentY = nil
end

HeroParameter.effectPoint = nil
HeroParameter.targetPoint = nil
HeroParameter.SaveEffectPoint = function(targetPoint,rect)
    if rect == nil then
        HeroParameter.targetPoint = targetPoint
    elseif targetPoint == nil then
        HeroParameter.effectPoint = LuaMgr.World2Local(HeroParameter.targetPoint,rect)
        local tempX = -810
        local tempY = HeroParameter.effectPoint.y + 31
        if LuaMgr.GetScreenAddWidth() > 0 then
            tempX = HeroParameter.effectPoint.x - LuaMgr.GetScreenAddWidth() - 398 / 2 - 100
        end
        HeroParameter.effectPoint = Vector2(tempX,tempY)
    end
end
HeroParameter.EmptyEffectPoint = function()
    HeroParameter.effectPoint = nil
    HeroParameter.targetPoint = nil
end

HeroParameter.TarItem=nil
HeroParameter.SaveTarItem=function(id,count)
    HeroParameter.TarItem={id=id,count=count}
end
HeroParameter.EmptyTarItem=function()
    HeroParameter.TarItem=nil
end


HeroParameter.ChanganLevelLable=nil
HeroParameter.SaveChanganLevelLable=function(index)
    HeroParameter.ChanganLevelLable=index
end
HeroParameter.EmptyChanganLevelLable=function()
    HeroParameter.ChanganLevelLable=nil
end


HeroParameter.TeachingLevel=nil
HeroParameter.TeachingReturn=false
HeroParameter.SaveTeachingLevel=function(index)
    HeroParameter.TeachingLevel=index
end
HeroParameter.EmptyTeachingLevel=function()
    HeroParameter.TeachingLevel=nil
    HeroParameter.TeachingReturn=false
end

HeroParameter.JoinJobNovelTabIndex=nil;
HeroParameter.SaveJoinJobNovelTab=function(index)
    HeroParameter.JoinJobNovelTabIndex=index
end
HeroParameter.EmptyJoinJobNovelTab=function()
    HeroParameter.JoinJobNovelTabIndex=nil;
end

HeroParameter.JournalFileClick = true
HeroParameter.SaveClickState = function()
    HeroParameter.JournalFileClick = false
end
HeroParameter.EmptyClickState = function()
    HeroParameter.JournalFileClick = true
end 


HeroParameter.AnyssPreArea=nil;
HeroParameter.SetAnyssPreArea=function(area)
    HeroParameter.AnyssPreArea=area;
end
HeroParameter.EmptyAnyssPreArea=function()
    HeroParameter.AnyssPreArea=nil;
end

HeroParameter.collectLabel = nil

HeroParameter.SaveCollectActivityLabel = function(label)
    HeroParameter.collectLabel = label
end


HeroParameter.EmptyCollectActivityLabel = function()
    HeroParameter.collectLabel = nil
end

HeroParameter.nianBeastIndex=nil;
HeroParameter.SaveNianBeastLevelIndex=function(index)
    HeroParameter.nianBeastIndex=index;
end
HeroParameter.EmptyNianBeastLevelIndex=function()
    HeroParameter.nianBeastIndex=nil;;
end


HeroParameter.actors = nil;
HeroParameter.heroCount = nil;
HeroParameter.isVoyage = false;
HeroParameter.SaveVoyageParam = function(members, actors, selectType, heroCount, heroId)
    HeroParameter.isVoyage = true;
    HeroParameter.membersParam = members;
    HeroParameter.actors = actors;
    HeroParameter.selectType = selectType;
    HeroParameter.heroCount = heroCount;
    HeroParameter.clickHero = heroId;
    HeroParameter.battleMembers = {};
    HeroParameter.battleBool = true;
    local len = #members;
    for i = 1, len do
        TableInsert(HeroParameter.battleMembers, members[i]);
    end
end


HeroParameter.EmptyVoyageParam = function()
    HeroParameter.isVoyage = false;
    HeroParameter.membersParam = nil;
    HeroParameter.actors = nil;
    HeroParameter.selectType = nil;
    HeroParameter.heroCount = nil;
    HeroParameter.battleMembers = nil;
    HeroParameter.battleBool = false;
end


HeroParameter.isDungeon66 = false;
HeroParameter.filterMembers = nil;
HeroParameter.dungeon66Tips = "";
HeroParameter.SaveDungeon66Param = function(members, filterMembers, selectType, heroCount, tips, heroId)
    HeroParameter.isDungeon66 = true;
    HeroParameter.membersParam = members;
    HeroParameter.filterMembers = filterMembers;
    HeroParameter.selectType = selectType;
    HeroParameter.heroCount = heroCount;
    HeroParameter.dungeon66Tips = tips;
    HeroParameter.clickHero = heroId;
    HeroParameter.battleMembers = {};
    HeroParameter.battleBool = true;
    local len = #members;
    for i = 1, len do
        TableInsert(HeroParameter.battleMembers, members[i]);
    end
end


HeroParameter.EmptyDungeon66Param = function()
    HeroParameter.isDungeon66 = false;
    HeroParameter.filterMembers = nil;
    HeroParameter.membersParam = nil;
    HeroParameter.selectType = nil;
    HeroParameter.heroCount = nil;
    HeroParameter.dungeon66Tips = "";
    HeroParameter.clickHero = nil;
    HeroParameter.battleMembers = nil;
    HeroParameter.battleBool = false;
end


HeroParameter.filterMembers = nil;
HeroParameter.dungeon66Tips = "";
HeroParameter.filterMemberTeamMap = nil
HeroParameter.SaveSpringCampParam = function(members, filterMembers, selectType, heroCount, tips, heroId,filterMemberTeamMap)
    HeroParameter.activityKey = ActivityKey.SpringCamp;
    HeroParameter.membersParam = members;
    HeroParameter.filterMembers = filterMembers;
    HeroParameter.selectType = selectType;
    HeroParameter.heroCount = heroCount;
    HeroParameter.dungeon66Tips = tips;
    HeroParameter.clickHero = heroId;
    HeroParameter.battleMembers = {};
    HeroParameter.battleBool = true;
    HeroParameter.filterMemberTeamMap = filterMemberTeamMap
    local len = #members;
    for i = 1, len do
        TableInsert(HeroParameter.battleMembers, members[i]);
    end
end


HeroParameter.EmptySpringCampParam = function()
    HeroParameter.isDungeon66 = false;
    HeroParameter.filterMembers = nil;
    HeroParameter.membersParam = nil;
    HeroParameter.selectType = nil;
    HeroParameter.heroCount = nil;
    HeroParameter.dungeon66Tips = "";
    HeroParameter.clickHero = nil;
    HeroParameter.battleMembers = nil;
    HeroParameter.battleBool = false;
end

HeroParameter.isQin = false;

HeroParameter.SaveQinParam = function(callback)
    HeroParameter.selectCharacterCallBack = callback;
    HeroParameter.teamMembers = {};
    HeroParameter.membersParam = {};
    HeroParameter.battleMembers = {};
    HeroParameter.whetherSave = false;
    HeroParameter.selectType = true;
    HeroParameter.heroCount = 6;
    HeroParameter.battleBool = true;
    HeroParameter.isQin = true;
end


HeroParameter.EmptyQinParam = function()
    HeroParameter.selectCharacterCallBack = nil;
    HeroParameter.teamMembers = nil;
    HeroParameter.membersParam = nil;
    HeroParameter.selectType = nil;
    HeroParameter.heroCount = nil;
    HeroParameter.battleMembers = nil;
    HeroParameter.battleBool = false;
    HeroParameter.isQin = false;
end


HeroParameter.activityKey = ""
HeroParameter.isTeamRelay3 = false
HeroParameter.filterMembers = nil
HeroParameter.activityBattleTips = "";
HeroParameter.SaveActivityBattleParam = function(activityKey, members, filterMembers, selectType, heroCount, tips, heroId)
    HeroParameter.activityKey = activityKey;
    HeroParameter.membersParam = members;
    HeroParameter.filterMembers = filterMembers;
    HeroParameter.selectType = selectType;
    HeroParameter.heroCount = heroCount;
    HeroParameter.activityBattleTips = tips;
    HeroParameter.clickHero = heroId;
    HeroParameter.battleMembers = {};
    HeroParameter.battleBool = true;
    local len = #members;
    for i = 1, len do
        TableInsert(HeroParameter.battleMembers, members[i]);
    end
end

HeroParameter.miniBattle4HelpActors = nil;
HeroParameter.SaveMiniBattle4Param = function(helpActors)
    HeroParameter.miniBattle4HelpActors = helpActors
end

HeroParameter.filterMemberTeamMap = nil
HeroParameter.SaveFilterMemberTeamMap = function(filterMembersTeamMap)
    HeroParameter.filterMemberTeamMap = filterMembersTeamMap
end


HeroParameter.EmptyActivityParam = function()
    HeroParameter.activityKey = ""
    HeroParameter.isTeamRelay3 = false
    HeroParameter.miniBattle4HelpActors = nil
    HeroParameter.filterMembers = nil;
    HeroParameter.filterMemberTeamMap = nil;
    HeroParameter.membersParam = nil;
    HeroParameter.selectType = nil;
    HeroParameter.heroCount = nil;
    HeroParameter.activityBattleTips = "";
    HeroParameter.clickHero = nil;
    HeroParameter.battleMembers = nil;
    HeroParameter.battleBool = false;
end


HeroParameter.isRogueHeroInfo = false
HeroParameter.isRogueTeam = false
HeroParameter.isDetail = false
HeroParameter.SaveRogueParam = function(members, selectType, heroCount, heroId)
    HeroParameter.isRogueTeam = true;
    HeroParameter.membersParam = members;
    HeroParameter.selectType = selectType;
    HeroParameter.heroCount = heroCount;
    HeroParameter.clickHero = heroId;
    HeroParameter.isCultivate = false;
    HeroParameter.isDetail = true;
    HeroParameter.battleMembers = {};
    HeroParameter.battleBool = true;
    local len = #members;
    for i = 1, len do
        TableInsert(HeroParameter.battleMembers, members[i]);
    end
end

HeroParameter.EmptyRogueParam = function()
    HeroParameter.isRogueTeam = false;
    HeroParameter.membersParam = nil;
    HeroParameter.selectType = nil;
    HeroParameter.heroCount = nil;
    HeroParameter.isCultivate = true;
    HeroParameter.isDetail = false;
    HeroParameter.battleMembers = nil;
    HeroParameter.battleBool = false;
end


HeroParameter.isOnlySelectCharacter=false;
HeroParameter.isLockSelectCharacter = false;


HeroParameter.lockCharacterList={};



HeroParameter.selectCharacterCallBack=nil;

HeroParameter.selectCharacterCallBackExtendParams=nil;
HeroParameter.commonCharacterCount=nil;
HeroParameter.selectCharacterFailBack=nil;

HeroParameter.selectCharacterFailBackExtendParams=nil;

HeroParameter.isCultivate=true;


HeroParameter.InitCommonOpenSelectQuickCharacter=function (nowTeam,commonCharacterCount,isLockSelectCharacter,lockCharacterList,extendParams,callBack,extendFailParams,failBack)

    HeroParameter.SaveBattlePrepareParam(nil, "",false,true,true, nowTeam)
    HeroParameter.isOnlySelectCharacter=true;
    HeroParameter.isLockSelectCharacter = isLockSelectCharacter;
    HeroParameter.lockCharacterList=lockCharacterList;
    HeroParameter.commonCharacterCount=commonCharacterCount;
    HeroParameter.selectCharacterCallBackExtendParams=extendParams;
    HeroParameter.selectCharacterCallBack=callBack;
    HeroParameter.selectCharacterFailBack=failBack;
    HeroParameter.selectCharacterFailBackExtendParams=extendFailParams;
    HeroParameter.isCultivate=false;
end




HeroParameter.InitCommonOpenSelectOneCharacter=function (nowHero,nowTeam,commonCharacterCount,isLockSelectCharacter,lockCharacterList,extendParams,callBack,extendFailParams,failBack)

    HeroParameter.SaveBattlePrepareParam(nil, nowHero,false,true,false, nowTeam)
    HeroParameter.isOnlySelectCharacter=true;
    HeroParameter.isLockSelectCharacter = isLockSelectCharacter;
    HeroParameter.lockCharacterList=lockCharacterList;
    HeroParameter.selectCharacterCallBack=callBack;
    HeroParameter.selectCharacterCallBackExtendParams=extendParams;
    HeroParameter.commonCharacterCount=commonCharacterCount;
    HeroParameter.selectCharacterFailBack=failBack;
    HeroParameter.selectCharacterFailBackExtendParams=extendFailParams;
    HeroParameter.isCultivate=false;
end


HeroParameter.InitCommonSelectCharacter=function (isLockSelectCharacter,lockCharacterList,commonCharacterCount)
    HeroParameter.isOnlySelectCharacter=false;
    HeroParameter.isLockSelectCharacter = isLockSelectCharacter;
    HeroParameter.lockCharacterList=lockCharacterList;
    HeroParameter.selectCharacterCallBackExtendParams=nil;
HeroParameter.selectCharacterCallBack=nil;
    HeroParameter.commonCharacterCount=commonCharacterCount;
    HeroParameter.isCultivate=false;
end

HeroParameter.ClearCommonSelectCharacter=function ()
    HeroParameter.isOnlySelectCharacter=false;
    HeroParameter.isLockSelectCharacter = false;
    HeroParameter.lockCharacterList={};
    HeroParameter.selectCharacterCallBack=nil;
    HeroParameter.selectCharacterCallBackExtendParams=nil;
    HeroParameter.commonCharacterCount=nil;
    HeroParameter.selectCharacterFailBack=nil;
    HeroParameter.selectCharacterFailBackExtendParams=nil;
    HeroParameter.isCultivate=true;
end




HeroParameter.panelType = nil
HeroParameter.branchId = nil
HeroParameter.branchHeroId = nil
HeroParameter.branchGroupId = nil
HeroParameter.anecdoteIndex = nil

HeroParameter.activityGotoPanel = nil

HeroParameter.SavePanelType = function(type,branchId,branchHeroId,branchGroupId)
    HeroParameter.panelType = type
    HeroParameter.branchId = branchId
    HeroParameter.branchHeroId = branchHeroId
    HeroParameter.branchGroupId = branchGroupId
end

HeroParameter.EmptyPanelType = function()
    HeroParameter.panelType = nil
    HeroParameter.branchId = nil
    HeroParameter.branchHeroId = nil
    HeroParameter.branchGroupId = nil
    HeroParameter.anecdoteIndex = nil
    HeroParameter.activityGotoPanel = nil
end 


HeroParameter.travelLevelGroupId=nil;
HeroParameter.SaveTravelLevelGroupId=function(groupId)
    HeroParameter.travelLevelGroupId=groupId;
end

HeroParameter.EmptyTravelLevelGroupId=function()
    HeroParameter.travelLevelGroupId=nil;
end


HeroParameter.activityKey=nil;
HeroParameter.SaveActivityKey=function(key)
    HeroParameter.activityKey=key;
end
HeroParameter.EmptyActivityKey=function()
    HeroParameter.activityKey=nil;
end


HeroParameter.abyssBuildIndex = nil
HeroParameter.abyssDungeonIndex = nil
HeroParameter.SaveAbyssIndex = function(buildIndex,dungeonIndex)
    HeroParameter.abyssBuildIndex = buildIndex
    HeroParameter.abyssDungeonIndex = dungeonIndex
end
HeroParameter.EmptyAbyssIndex = function()
    HeroParameter.abyssBuildIndex = nil
    HeroParameter.abyssDungeonIndex = nil
end


HeroParameter.kanBanNiang_character = nil
HeroParameter.kanBanNiang_characterSkin=nil;

HeroParameter.SaveKanBanNiang = function(character,characterSkin)
    HeroParameter.kanBanNiang_character = character
    HeroParameter.kanBanNiang_characterSkin = characterSkin
end

HeroParameter.EmptyKanBanNiang=function()
    HeroParameter.kanBanNiang_character = nil;
    HeroParameter.kanBanNiang_characterSkin = nil;
end


HeroParameter.moremodeTeaching=nil;
HeroParameter.moreModeTheme=nil;



HeroParameter.huazhaoLevel=nil;
HeroParameter.huazhaoChapter=nil;


HeroParameter.JournalGotoPanel = nil



HeroParameter.TrafficPermitTabIndex=nil;


HeroParameter.dailyType=nil;
HeroParameter.dailyStyle=nil;
HeroParameter.SaveDailyFB=function(type,style)
    HeroParameter.dailyType=type
    HeroParameter.dailyStyle=style;
end

HeroParameter.EmptyDailyFB=function()
    HeroParameter.dailyType=nil
    HeroParameter.dailyStyle=nil;
end


HeroParameter.sealChangeList= nil;


HeroParameter.MountPoem=nil;
HeroParameter.SaveMountPoem=function(mType,mTag)
    HeroParameter.MountPoem={type=mType,tag=mTag};
end
HeroParameter.EmptyMountPoem=function()
    HeroParameter.MountPoem=nil;
end


HeroParameter.comeBackLabel = nil
HeroParameter.comeBackDayIndex = nil
HeroParameter.SaveComeBackParam = function(label,dayIndex)
    HeroParameter.comeBackLabel = label
    HeroParameter.comeBackDayIndex = dayIndex
end
HeroParameter.EmptyComeBackParam = function()
    HeroParameter.comeBackLabel = nil
    HeroParameter.comeBackDayIndex = nil
end


HeroParameter.SawPuzzleBarIndex=nil;

HeroParameter.TravelBossBarIndex=nil;


HeroParameter.TargetCount = nil
HeroParameter.EquipRefineAttrTarget = nil
HeroParameter.SaveAttrTarget = function(attrDic,targetCount)
    HeroParameter.TargetCount = targetCount
    HeroParameter.EquipRefineAttrTarget = attrDic
end
HeroParameter.EmptyAttrTarget = function()
    HeroParameter.TargetCount = nil
    HeroParameter.EquipRefineAttrTarget = nil
end


HeroParameter.SelectTargetIndex = nil
HeroParameter.Last_BossChallenge_Timestamp = nil


HeroParameter.SelectAnalectId=nil;
HeroParameter.AnalectHandBookID=nil;
HeroParameter.HandBook_AnalectId=nil;



HeroParameter.FriendSkipInfo=nil;

HeroParameter.MonthBuyTipActive=nil;

HeroParameter.Qin2ScenicId=nil;


HeroParameter.IsBatch = false
HeroParameter.IsRed = nil
HeroParameter.IsBrilliant = nil

HeroParameter.OnYearBarIndex=nil;


HeroParameter.SettingHeroData=nil;


HeroParameter.BossDummy_Select_Tab = nil


HeroParameter.CurSkinLog = nil
HeroParameter.CurSkinIndex = nil


HeroParameter.trainingBattleDungeonId=nil;

HeroParameter.KZRYGroupId=nil;

HeroParameter.update_background=nil;

HeroParameter.giftJump=nil;