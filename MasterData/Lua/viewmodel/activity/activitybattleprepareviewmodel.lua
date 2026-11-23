require("ViewModel/Activity/ActivityBattlePrepareCharacterItem")
require("ViewModel/Activity/ActivityBattlePrepareEnemyItem")
require("ViewModel/Activity/ActivityBattlePrepareInfo_MiniBattle")
require("ViewModel/Activity/ActivityBattlePrepareInfo_CrisisContract2")
require("ViewModel/Activity/ActivityBattlePrepareInfo_CrisisContract3")
require("ViewModel/Activity/ActivityBattlePrepareInfo_MiniBattleNew")
require("ViewModel/Activity/ActivityBattlePrepareInfo_BossDummy3")
require("ViewModel/Activity/ActivityBattlePrepareInfo_BossDummy4")
require("ViewModel/Activity/ActivityBattlePrepareInfo_MiniBattle3")
require("ViewModel/Activity/ActivityBattlePrepareInfo_MiniBattle4")
require("ViewModel/Activity/ActivityBattlePrepareInfo_MiniBattle5")
require("ViewModel/SuiChuNaJi/ActivityBattlePrepareInfo_BossRelay")
require("ViewModel/Activity/ActivityBattlePrepareInfo_TeamRelay2")
require("ViewModel/Activity/ActivityBattlePrepareInfo_TeamTower")

local PrefabPath = "Assets/_BundleResources/UI/Activity/ActivityBattlePrepare/ActivityBattlePreparePanel_"
local isQuickLock = false
local this = {
    dungeonConfig = nil,
    characterListView = nil,
    characterDatas = nil,
    characterIndex = 0,

titleStr = "",
heroTips = "",

activityKey = "",
curLoadItemKey = "",
activityInfo = nil,
activityInfoItem = nil,
    contentTr = nil,
    className = "",

    formationIndex = 1,
    filterMembers = {},
    filterMembers_2 = {},
filterMembersTeamMap = {},
    
    curTeamWeaponId = "",
};

local objs = {
    titleTypeText = { path = "root/Middle/Title/Type", type = "Text" },
    nameText = { path = "root/Middle/Title/Name", type = "Text" },
    assistGO = { path = "root/Middle/Title/Assist", type = "GameObject" },
    assistText = { path = "root/Middle/Title/Assist/Text", type = "Text" },
    assistCountGO = { path = "root/Middle/Title/AssistCount", type = "GameObject" },
    assistCountText = { path = "root/Middle/Title/AssistCount/Text", type = "Text" },
    characterItem = { path = "template/CharacterItem", type = "GameObject" },
    charactersListTF = { path = "root/Middle/Characters/List", type = "Transform" },
    charactersBg1 = { path = "root/Middle/Characters/BG/BG1", type = "Button" },
    charactersBg2 = { path = "root/Middle/Characters/BG/BG2", type = "Button" },
    charactersBg3 = { path = "root/Middle/Characters/BG/BG3", type = "Button" },
    charactersBg4 = { path = "root/Middle/Characters/BG/BG4", type = "Button" },
    charactersBg5 = { path = "root/Middle/Characters/BG/BG5", type = "Button" },
    charactersBg6 = { path = "root/Middle/Characters/BG/BG6", type = "Button" },
    quickBtn = { path = "root/Middle/Characters/Quick", type = "Button" },
};

local data = {
    showFormationBtn = false,
    formationName = "",
    formationArrowScale = Vector3.zero,
    showFormationList = false,
    formationDatas = { { text = "", isShow = false } },

    teamWeaponBtnActive = false,
    teamWeaponSkillIcon = DefaultTexture,
    teamWeaponSkillIconActive = false,

    quickText = "",
    isFormationLock = false,
    isFormationText = true,
    
    showUnlockBtn = false,
}

local command = {
    formationCommnad = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickFormation(vm, param)
        end
    },

    formationItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickFormationItem(vm, param)
        end
    },
    teamWeaponCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.TeamWeaponActivityPreparePopup, this.activityInfo.activityDungeonId, this.SetTeamWeaponSkill)
            end
    },
    unlockCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.UnLockTeam();
        end
    }
}

this.InitData = function()
    this.vm.data.showFormationBtn = false
    this.vm.data.teamWeaponBtnActive = false
    this.vm.data.showUnlockBtn = false
    if this.activityKey == ActivityKey.MiniBattle then
        this.InitData_MiniBattle()
    elseif this.activityKey == ActivityKey.crisiscontract2 then
        this.InitData_CrisisContract2()
    elseif this.activityKey == ActivityKey.crisiscontract3 then
        this.InitData_CrisisContract3()
    elseif this.activityKey == ActivityKey.MiniBattlenew then
        this.InitData_MiniBattleNew()
    elseif this.activityKey == ActivityKey.MiniBattle5 then
        this.InitData_MiniBattle5()
    elseif this.activityKey == ActivityKey.BossDummy3 then
        this.InitData_BossDummy3()
    elseif this.activityKey == ActivityKey.BossDummy4 then
        this.InitData_BossDummy4()    
    elseif this.activityKey == ActivityKey.BossDummy5 then
        this.InitData_BossDummy5()
    elseif this.activityKey == ActivityKey.DualBattle then
        this.InitData_MiniBattle3()
    elseif this.activityKey == ActivityKey.DualBattle2 then
        this.InitData_MiniBattle4()
    elseif this.activityKey == ActivityKey.TeamRelay then
        this.InitData_ActivityBossRelay()
    elseif this.activityKey == ActivityKey.TeamRelay2 then
        this.InitData_ActivityTeamRelay2()
    elseif this.activityKey == ActivityKey.TeamRelay3 then
        this.InitData_ActivityTeamRelay3()
    elseif this.activityKey == ActivityKey.TeamTower then
        this.InitData_TeamTower()
    end

    local name = LuaMgr.GetLangText(this.dungeonConfig.NameLan)
    this.nameText.text = name
    this.vm.behaviour:UpdateTopBar(this.activityKey, this.OnBack);
    this.InitFilterMembers()
    this.HideFormations()
end

this.InitData_MiniBattle = function()
    require("ViewModel/Activity/ActivityBattlePrepareInfo_MiniBattle")
    this.className = "ActivityBattlePrepareInfo_MiniBattle"
    this.activityInfo.battleIndex = this.vm.behaviour.Params[1];
    this.activityInfo.plotCfg = MiniBattleMgr.GetCurMiniBattleCfg(this.activityInfo.battleIndex)
    local dungeonId = this.activityInfo.plotCfg.DungeonId
    this.dungeonConfig = ConfigMgr.Config.dungeonMap[dungeonId];
    this.titleTypeText.text = LuaMgr.GetLangText("ActivityBattlePrepareViewModel_0")
    this.heroTips = string.format(LuaMgr.GetLangText("MiniBattlePrepareViewModel_0"), this.activityInfo.battleIndex, LuaMgr.GetLangText(this.activityInfo.plotCfg.NameLan));
end

this.InitData_CrisisContract2 = function()
    require("ViewModel/Activity/ActivityBattlePrepareInfo_CrisisContract2")
    this.className = "ActivityBattlePrepareInfo_CrisisContract2"
    local plotId = this.vm.behaviour.Params[1];
    this.activityInfo.plotId = plotId
    this.activityInfo.chooseBuffList = this.vm.behaviour.Params[2]
    this.activityInfo.totalScore = this.vm.behaviour.Params[3]
    this.activityInfo.plotCfg = CrisisContract2Mgr.GetPlotConfig(plotId)
    this.activityInfo.anotherPlotCfg = CrisisContract2Mgr.GetPlotConfig(CrisisContract2Mgr.GetAnotherPlotId(plotId))
    local selfBuff, enemyBuff = CrisisContract2Mgr.GetChooseBuffListByPlotId(plotId)
    this.activityInfo.selfBuff = selfBuff
    this.activityInfo.enemyBuff = enemyBuff
    local dungeonId = this.activityInfo.plotCfg.DungeonId
    this.dungeonConfig = ConfigMgr.Config.dungeonMap[dungeonId];
    AudioMgr.Singleton:PlayBgm("Assets/_BundleResources/Audio/Bgm/bgm_crisisContract2.mp3", true);
    this.titleTypeText.text = LuaMgr.GetLangText("ActivityBattlePrepareViewModel_1")
    this.heroTips = CrisisContract2Mgr.GetPlotIndex(this.activityInfo.plotId)
end

this.InitData_CrisisContract3 = function()
    require("ViewModel/Activity/ActivityBattlePrepareInfo_CrisisContract3")
    this.className = "ActivityBattlePrepareInfo_CrisisContract3"
    local plotId = this.vm.behaviour.Params[1];
    this.activityInfo.plotId = plotId
    this.activityInfo.chooseBuffList = this.vm.behaviour.Params[2]
    this.activityInfo.totalScore = this.vm.behaviour.Params[3]
    this.activityInfo.plotCfg = CrisisContract3Mgr.GetPlotConfig(plotId)
    this.activityInfo.anotherPlotCfg = CrisisContract3Mgr.GetPlotConfig(CrisisContract3Mgr.GetAnotherPlotId(plotId))
    this.activityInfo.buffList = CrisisContract3Mgr.GetChooseBuffListByPlotId(plotId)
    local dungeonId = this.activityInfo.plotCfg.DungeonId
    this.dungeonConfig = ConfigMgr.Config.dungeonMap[dungeonId];
    AudioMgr.Singleton:PlayBgm("Assets/_BundleResources/Audio/Bgm/bgm_crisisContract2.mp3", true);
    this.titleTypeText.text = LuaMgr.GetLangText("ActivityBattlePrepareViewModel_5")
    this.heroTips = CrisisContract3Mgr.GetPlotIndex(this.activityInfo.plotId)
end

this.InitData_MiniBattleNew = function()
    require("ViewModel/Activity/ActivityBattlePrepareInfo_MiniBattleNew")
    this.className = "ActivityBattlePrepareInfo_MiniBattleNew"
    local plotId = this.vm.behaviour.Params[1];
    this.activityInfo.plotId = plotId
    this.activityInfo.plotCfg = ConfigMgr.Config.MiniBattleNewMap[plotId]
    this.activityInfo.anotherPlotCfg = ConfigMgr.Config.MiniBattleNewMap[MiniBattle2Mgr.GetAnotherPlotId(plotId)]
    local selfBuff, enemyLevelId = MiniBattle2Mgr.GetChooseBuffListByPlotId(plotId)
    this.activityInfo.selfBuff = selfBuff
    this.activityInfo.enemyLevelId = enemyLevelId
    local dungeonId = this.activityInfo.plotCfg.DungeonId
    this.dungeonConfig = ConfigMgr.Config.dungeonMap[dungeonId];
    this.titleTypeText.text = LuaMgr.GetLangText("ActivityBattlePrepareViewModel_2")
    this.heroTips = string.format(LuaMgr.GetLangText("ActivityBattlePrepareViewModel_3"), LuaMgr.GetLangText(this.activityInfo.plotCfg.NameLan))
end

this.InitData_MiniBattle5 = function()
    this.className = "ActivityBattlePrepareInfo_MiniBattle5"
    local plotId = this.vm.behaviour.Params[1];
    this.activityInfo.plotId = plotId
    this.activityInfo.plotCfg = ConfigMgr.Config.MiniBattleNewMap[plotId]
    this.activityInfo.anotherPlotCfg = ConfigMgr.Config.MiniBattleNewMap[MiniBattle5Mgr.GetAnotherPlotId(plotId)]
    local selfBuff, enemyLevelId = MiniBattle5Mgr.GetChooseBuffListByPlotId(plotId)
    this.activityInfo.selfBuff = selfBuff
    this.activityInfo.enemyLevelId = enemyLevelId
    local dungeonId = this.activityInfo.plotCfg.DungeonId
    this.dungeonConfig = ConfigMgr.Config.dungeonMap[dungeonId];
    this.titleTypeText.text = LuaMgr.GetLangText("ActivityBattlePrepareViewModel_10")
    this.heroTips = string.format(LuaMgr.GetLangText("ActivityBattlePrepareViewModel_3"), LuaMgr.GetLangText(this.activityInfo.plotCfg.NameLan))
end

this.InitData_BossDummy3 = function()
    require("ViewModel/Activity/ActivityBattlePrepareInfo_BossDummy3")
    this.className = "ActivityBattlePrepareInfo_BossDummy3"
    this.activityInfo.is_boss = (this.vm.behaviour.Params[1] == "boss")
    local config = this.vm.behaviour.Params[2]
    this.activityInfo.config = config
    for i, v in ipairs(ConfigMgr.Config.BossDummy3s) do
        if v.Id == config.BossDummy3Id then
            this.activityInfo.plotCfg = v
            break
        end
    end
    local dungeonId = this.activityInfo.config.DungeonId
    this.dungeonConfig = ConfigMgr.Config.dungeonMap[dungeonId]
    if this.activityInfo.is_boss then
        this.activityInfo.selected_buff = this.vm.behaviour.Params[3]
    end
    this.titleTypeText.text = LuaMgr.GetLangText("ActivityBattlePrepareViewModel_4")
end

this.InitData_BossDummy4 = function()
    require("ViewModel/Activity/ActivityBattlePrepareInfo_BossDummy4")
    this.className = "ActivityBattlePrepareInfo_BossDummy4"
    this.activityInfo.is_boss = (this.vm.behaviour.Params[1] == "boss")
    local levelCfg = this.vm.behaviour.Params[2]
    this.activityInfo.config = levelCfg
    for i, v in ipairs(ConfigMgr.Config.BossDummy3s) do
        if v.Id == levelCfg.BossDummy3Id then
            this.activityInfo.plotCfg = v
            break
        end
    end
    local dungeonId = this.activityInfo.config.DungeonId
    this.dungeonConfig = ConfigMgr.Config.dungeonMap[dungeonId]
    if this.activityInfo.is_boss then
        this.activityInfo.selected_buff = this.vm.behaviour.Params[3]
    end
    this.titleTypeText.text = LuaMgr.GetLangText("ActivityBattlePrepareViewModel_6")
    this.SetFormationList()
end

this.InitData_BossDummy5 = function()
    require("ViewModel/Activity/ActivityBattlePrepareInfo_BossDummy5")
    this.className = "ActivityBattlePrepareInfo_BossDummy5"
    this.activityInfo.is_boss = (this.vm.behaviour.Params[1] == "boss")
    local levelCfg = this.vm.behaviour.Params[2]
    this.activityInfo.config = levelCfg
    this.activityInfo.activityDungeonId = levelCfg.DungeonId
    for i, v in ipairs(ConfigMgr.Config.BossDummy3s) do
        if v.Id == levelCfg.BossDummy3Id then
            this.activityInfo.plotCfg = v
            break
        end
    end
    local dungeonId = this.activityInfo.config.DungeonId
    this.dungeonConfig = ConfigMgr.Config.dungeonMap[dungeonId]
    this.titleTypeText.text = LuaMgr.GetLangText("ActivityBattlePrepareViewModel_13")
    this.vm.data.showUnlockBtn = true
    this.SetFormationList()
    this.SetTeamWeaponSkill(ActivityBattlePrepareMgr.GetTeamWeaponId(dungeonId))
end

this.InitData_MiniBattle3 = function()
    require("ViewModel/Activity/ActivityBattlePrepareInfo_MiniBattle3")
    this.className = "ActivityBattlePrepareInfo_MiniBattle3"
    local plotId = this.vm.behaviour.Params[1];
    this.activityInfo.plotId = plotId
    this.activityInfo.plotCfg = ConfigMgr.Config.DualBattleMap[plotId]
    this.activityInfo.anotherPlotCfg = ConfigMgr.Config.DualBattleMap[MiniBattle3Mgr.GetAnotherPlotId(plotId)]
    local selfBuff, enemyLevelId = MiniBattle3Mgr.GetChooseBuffListByPlotId(plotId)
    this.activityInfo.selfBuff = selfBuff
    this.activityInfo.enemyLevelId = enemyLevelId
    local dungeonId = this.activityInfo.plotCfg.DungeonId
    this.dungeonConfig = ConfigMgr.Config.dungeonMap[dungeonId];
    this.titleTypeText.text = LuaMgr.GetLangText("ActivityBattlePrepareViewModel_4")
    this.heroTips = string.format(LuaMgr.GetLangText("ActivityBattlePrepareViewModel_3"), LuaMgr.GetLangText(this.activityInfo.plotCfg.NameLan))
end

this.InitData_MiniBattle4 = function()
    require("ViewModel/Activity/ActivityBattlePrepareInfo_MiniBattle4")
    this.className = "ActivityBattlePrepareInfo_MiniBattle4"
    local plotId = this.vm.behaviour.Params[1];
    local levelId = this.vm.behaviour.Params[2];
    local helpId = this.vm.behaviour.Params[3];
    this.activityInfo.plotId = plotId
    this.activityInfo.plotCfg = MiniBattle4Mgr.GetPlotCfg(plotId)
    this.activityInfo.levelId = levelId
    this.activityInfo.helpId = helpId
    local levelCfg = MiniBattle4Mgr.GetLevelCfg(levelId)
    local dungeonId = levelCfg.LevelDungeonId
    this.dungeonConfig = ConfigMgr.Config.dungeonMap[dungeonId];
    this.titleTypeText.text = LuaMgr.GetLangText("ActivityBattlePrepareViewModel_7")
    this.heroTips = string.format(LuaMgr.GetLangText("ActivityBattlePrepareViewModel_3"), LuaMgr.GetLangText(this.activityInfo.plotCfg.NameLan))
    this.SetFormationList()
end

this.InitData_ActivityBossRelay = function()
    require("ViewModel/SuiChuNaJi/ActivityBattlePrepareInfo_BossRelay")
    this.className = "ActivityBattlePrepareInfo_BossRelay"
    local paramData = this.vm.behaviour.Params[1];
    this.activityInfo.paramData = paramData
    this.activityInfo.plotId = paramData.data.Id
    this.activityInfo.levelId = paramData.diffcultConfig.Id
    this.activityInfo.teamIndex = paramData.data.StageIndex
    this.activityInfo.resetTeamCallback = this.RefreshData
    this.activityInfo.plotCfg = {}
    this.activityInfo.plotCfg.IsCooperate = paramData.diffcultConfig.IsCoopeRate
    this.activityInfo.plotCfg.CooperateLimit = paramData.diffcultConfig.CoopeRateLimit
    local dungeonId = paramData.data.DungeonId
    this.dungeonConfig = ConfigMgr.Config.dungeonMap[dungeonId];
    this.titleTypeText.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29608")
    this.heroTips = "heroTips"
    this.SetFormationList() 
end

this.InitData_ActivityTeamRelay2 = function()
    require("ViewModel/Activity/ActivityBattlePrepareInfo_TeamRelay2")
    this.className = "ActivityBattlePrepareInfo_TeamRelay2"
    this.activityInfo.plotId = this.vm.behaviour.Params[1]
    this.activityInfo.levelId = this.vm.behaviour.Params[2]
    this.activityInfo.activityDungeonId = this.vm.behaviour.Params[3]
    local levelCfg = TeamRelay2Mgr.GetLevelCfg(this.activityInfo.levelId)
    this.activityInfo.plotCfg = {}
    this.activityInfo.plotCfg.IsCooperate = levelCfg.IsCoopeRate
    this.activityInfo.plotCfg.CooperateLimit = levelCfg.CoopeRateLimit
    local activityDungeonCfg = TeamRelay2Mgr.GetDungeonCfg(this.activityInfo.activityDungeonId)
    local dungeonId = activityDungeonCfg.DungeonId
    this.dungeonConfig = ConfigMgr.Config.dungeonMap[dungeonId];
    this.titleTypeText.text = LuaMgr.GetLangText("ActivityBattlePrepareViewModel_9")
    this.heroTips = ""
    this.SetFormationList()
end

this.InitData_ActivityTeamRelay3 = function()
    require("ViewModel/Activity/ActivityBattlePrepareInfo_CrisisContract4")
    this.className = "ActivityBattlePrepareInfo_CrisisContract4"
    local teamRelayDungeonId = this.vm.behaviour.Params[1]
    local activityDungeonCfg = CrisisContract4Mgr.GetDungeonCfg(teamRelayDungeonId)
    local levelCfg = CrisisContract4Mgr.GetLevelCfg(activityDungeonCfg.DiffId)
    local selfBuff, enemyBuff = CrisisContract4Mgr.GetChooseBuffList(teamRelayDungeonId)
    this.activityInfo.activityDungeonId = teamRelayDungeonId
    this.activityInfo.chooseBuffList = this.vm.behaviour.Params[2]
    this.activityInfo.totalScore = this.vm.behaviour.Params[3]
    this.activityInfo.plotCfg = {}
    this.activityInfo.plotCfg.IsCooperate = levelCfg.IsCoopeRate
    this.activityInfo.plotCfg.CooperateLimit = levelCfg.CoopeRateLimit
    this.activityInfo.selfBuff = selfBuff
    this.activityInfo.enemyBuff = enemyBuff
    this.dungeonConfig = ConfigMgr.Config.dungeonMap[activityDungeonCfg.DungeonId];
    this.titleTypeText.text = LuaMgr.GetLangText("ActivityBattlePrepareViewModel_11")
    this.heroTips = ""
    this.SetFormationList()
    this.SetTeamWeaponSkill(ActivityBattlePrepareMgr.GetTeamWeaponId(teamRelayDungeonId))
end

this.InitData_TeamTower = function()
    this.className = "ActivityBattlePrepareInfo_TeamTower"
    local towerId = TeamTowerMgr.GetCurChallengeTowerId();
    this.activityInfo.activityDungeonId = towerId
    local teamTowerConfig = ConfigMgr.Config.TeamTowerFloorMap[towerId];
    this.dungeonConfig = ConfigMgr.Config.dungeonMap[teamTowerConfig.Dungeon];
    this.titleTypeText.text = LuaMgr.GetLangText("ActivityBattlePrepareViewModel_12")
    this.heroTips = ""
    this.SetFormationList()
    this.SetTeamWeaponSkill(ActivityBattlePrepareMgr.GetTeamWeaponId(towerId))
end

this.LoadPanel = function()
    if this.curLoadItemKey == this.activityKey then
        this.activityInfoItem:Init()
    else
        if this.activityInfoItem ~= nil then
            this.activityInfoItem:Clear()
            this.activityInfoItem:Destroy()
            this.activityInfoItem = nil
        end
        local path = string.format("%s%s.prefab", PrefabPath, this.activityKey)
        local prefab = LuaMgr.GetPrefab(path);
        LuaMgr.AddPrefabRefCount(path);
        if (prefab ~= nil) then
            local objTF = prefab.transform;
            objTF:SetParent(this.contentTr, false);
            local objRectTf = prefab:GetComponent("RectTransform")
            objRectTf.localScale = Vector3.one;
            objRectTf.anchoredPosition = Vector2.zero;
            local class = _G[this.className]
            if (class ~= nil) then
                local item = class.New()
                item.path = path
                item.gameObject = prefab;
                item.transform = objTF;
                item:Init();
                this.activityInfoItem = item
                this.curLoadItemKey = this.activityKey
            end
        end
    end
end


this.RefreshData = function()
    this.activityInfoItem:SetData(this.dungeonConfig, this.activityInfo)
    if (not this.vm.behaviour.IsPop) then
        PlayerAssistMgr.UpdateFriendList2(function()
            PlayerAssistMgr.Clear();
            this.SetCharacters()
        end);
    else
        this.SetCharacters();
    end
end

this.InitCharacters = function()
    this.vm.data.isFormationLock = false
    this.vm.data.isFormationText = true
    this.vm.data.quickText = LuaMgr.GetLangText("BattlePrepareViewModel_16")
    isQuickLock = false
    if this.dungeonConfig.fightType == 2 or this.dungeonConfig.fightType == 3 then
        local memberHS = {}
        local configMembers = {}
        local memberlist = {}
        for i, v in ipairs(this.dungeonConfig.limitOutRole) do
            local actor = ConfigMgr.Config.actor[v]
            if actor ~= nil then
                memberHS[actor.CharacterId] = true
                table.insert(configMembers,v)
                table.insert(memberlist,v)
            end
        end
        
        local num = this.dungeonConfig.outRoleNum - #memberlist
        if num > 0 then
            local members = configMembers
            for i = 1, this.dungeonConfig.outRoleNum do
                local member = members[i]
                if #ActivityBattlePrepareMgr.GetSelectMembers() >= this.dungeonConfig.outRoleNum then
                    break
                end
                if not memberHS[member] then
                    table.insert(memberlist,"")
                end
            end
        end
        ActivityBattlePrepareMgr.SetSelectMembers(memberlist)
        this.vm.data.isFormationLock = true
        this.vm.data.isFormationText = false
        this.vm.data.quickText = LuaMgr.GetLangText("BattlePrepareViewModel_15")
        isQuickLock = true
        return
    end
    this.characterListView:Clear();
    if (HeroParameter.battleMembers ~= nil) then
        ActivityBattlePrepareMgr.SetSelectMembers(HeroParameter.battleMembers);
        ActivityBattlePrepareMgr.SetAssistMembers(PlayerAssistMgr.assistMembers);
        HeroParameter.EmptyActivityParam();
    end
end


this.SetCharacters = function()
    this.InitCharacters()
    local allFilterMembers = this.GetAllFilterMember()
    local memberList = ActivityBattlePrepareMgr.GetSelectMembers(allFilterMembers);
    local len = #memberList;
    if (len > 0) then
        local listData;
        this.characterDatas = {};
        local isLockType = this.dungeonConfig.fightType == 2 or this.dungeonConfig.fightType == 3
        local isLimit = false
        local isLock = false
        for i = 1, 6 do
            local id = "";
            if i <= #memberList then
                id = memberList[i]
            end
            isLimit = IsNullOrEmpty(id) and isLockType
            isLock = not IsNullOrEmpty(id) and isLockType
            listData = UIListData.GetData(this.characterItem, "ActivityBattlePrepareCharacterItem", { id = id, isShow = false,isLock = isLock,isLimit = isLimit });
            table.insert(this.characterDatas, listData);
        end
        this.characterListView:SetData(this.characterDatas);
        this.characterIndex = 1;
        LuaMgr.AddTimer(TimerConst.MiniBattlePrepareCharacterDelay, this.OnCharacterDelay, 0.09, -1, true);
    end
    this.SetAssist();
end


this.OnCharacterDelay = function()
    this.characterDatas[this.characterIndex].data.isShow = true;
    this.characterListView:Refresh();
    this.characterIndex = this.characterIndex + 1;
    if (this.characterIndex > #this.characterDatas) then
        LuaMgr.RemoveTimer(TimerConst.MiniBattlePrepareCharacterDelay);
        this.characterDatas = nil;
    end
end


this.SetAssist = function()
    if (this.dungeonConfig.isSupport > 0) then
        local count = ActivityBattlePrepareMgr.GetAssistMemberCount();
        this.assistText.text = count .. "/" .. this.dungeonConfig.supportNum;
        SetActive(this.assistGO, true);
        local remainAssistCount = PlayerAssistMgr.RemainAssistCount();
        local totalBorrowLimit = ConfigMgr.Config.FriendConstants.TotalBorrowLimit;
        this.assistCountText.text = string.format("<color=#eccc38>%d</color>/%d", remainAssistCount, totalBorrowLimit);
        SetActive(this.assistCountGO, true);
    else
        SetActive(this.assistGO, false);
        SetActive(this.assistCountGO, false);
    end
end

this.CheckDungeonIsSupportShare = function()
    HeroParameter.EmptyActivityParam();
    PlayerAssistMgr.CheckActivityDungeonIsSupportShare(this.activityInfo.plotCfg);
    PlayerAssistMgr.CheckDungeonIsSupportAssist(this.dungeonConfig);
end

this.InitFilterMembers = function()
this.filterMembers = {}
this.filterMembers_2 = {}
this.filterMembersTeamMap = {}
    if this.activityKey == ActivityKey.MiniBattle then
        local anotherBattleIndex = this.activityInfo.battleIndex == 1 and 2 or 1;
        this.filterMembers = ActivityBattlePrepareMgr.GetLockMembers(this.activityKey, MiniBattleMgr.GetCurMiniBattleCfg(anotherBattleIndex).ID);
    elseif this.activityKey == ActivityKey.crisiscontract2 then
        local anotherBattleIndex = CrisisContract2Mgr.GetAnotherPlotId(this.activityInfo.plotId)
        this.filterMembers = ActivityBattlePrepareMgr.GetLockMembers(this.activityKey, anotherBattleIndex);
    elseif this.activityKey == ActivityKey.crisiscontract3 then
        local anotherBattleIndex = CrisisContract3Mgr.GetAnotherPlotId(this.activityInfo.plotId)
        this.filterMembers = ActivityBattlePrepareMgr.GetLockMembers(this.activityKey, anotherBattleIndex);
    elseif this.activityKey == ActivityKey.MiniBattlenew then
        local anotherBattleIndex = MiniBattle2Mgr.GetAnotherPlotId(this.activityInfo.plotId)
        this.filterMembers = ActivityBattlePrepareMgr.GetLockMembers(this.activityKey, anotherBattleIndex);
    elseif this.activityKey == ActivityKey.MiniBattle5 then
        local anotherBattleIndex = MiniBattle5Mgr.GetAnotherPlotId(this.activityInfo.plotId)
        this.filterMembers = ActivityBattlePrepareMgr.GetLockMembers(this.activityKey, anotherBattleIndex);
    elseif this.activityKey == ActivityKey.BossDummy3 then
        local anotherBattleIndex = BossDummy3Mgr.GetAnotherPlotId(this.activityInfo.plotCfg.Id)
        if anotherBattleIndex ~= nil then
            this.filterMembers = ActivityBattlePrepareMgr.GetLockMembers(this.activityKey, anotherBattleIndex)
        end
    elseif this.activityKey == ActivityKey.BossDummy4 then
        this.filterMembers = BossDummy4Mgr.GetFilterMembers(this.activityInfo.plotCfg.Id)
    elseif this.activityKey == ActivityKey.BossDummy5 then
        this.filterMembers = BossDummy5Mgr.GetFilterMembers(this.activityInfo.plotCfg.Id)
    elseif this.activityKey == ActivityKey.DualBattle then
        local anotherBattleIndex = MiniBattle3Mgr.GetAnotherPlotId(this.activityInfo.plotId)
        this.filterMembers = ActivityBattlePrepareMgr.GetLockMembers(this.activityKey, anotherBattleIndex);
    elseif this.activityKey == ActivityKey.DualBattle2 then
        this.filterMembers = MiniBattle4Mgr.GetFilterMembers(this.activityInfo.plotId)
        if not IsNullOrEmpty(this.activityInfo.helpId) then
            local monsterInfo = MiniBattle4Mgr.GetMonsterInfo(this.activityInfo.helpId)
            this.filterMembers_2[monsterInfo.charecterId] = this.activityInfo.plotId
        end
    elseif this.activityKey == ActivityKey.TeamRelay then
        local datas = SCNJData.GetLockMembers(this.activityInfo.plotId, this.activityInfo.levelId, this.activityInfo.teamIndex)
        for i = 1, #datas do
            local memberID = datas[i]
            this.filterMembers[memberID] = memberID
        end
    elseif this.activityKey == ActivityKey.TeamRelay2 then
        this.filterMembers, this.filterMembersTeamMap = TeamRelay2Mgr.GetFilterMembers(this.activityInfo.activityDungeonId)
    elseif this.activityKey == ActivityKey.TeamRelay3 then
        this.filterMembers, this.filterMembersTeamMap = CrisisContract4Mgr.GetFilterMembers(this.activityInfo.activityDungeonId)
    elseif this.activityKey == ActivityKey.TeamTower then
        this.filterMembers = TeamTowerMgr.GetLockMembers();
    end
end


this.ClickCharacter = function(index)
    if this.dungeonConfig.fightType == 2 then
        return
    end
    this.CheckDungeonIsSupportShare()
    local assistMembers = ActivityBattlePrepareMgr.GetAssistMembers();
    PlayerAssistMgr.SetAssistMembers(assistMembers);
    local selectMembers = ActivityBattlePrepareMgr.GetSelectMembers();
    local heroId = nil;
    if (index > 0) then
        heroId = selectMembers[index];
    elseif (#selectMembers > 0) then
        heroId = selectMembers[1];
    end
    HeroParameter.SaveActivityBattleParam(this.activityKey, selectMembers, table.Copy(this.filterMembers), index == 0, 6, this.heroTips, heroId);
    
    if this.activityKey == ActivityKey.DualBattle2 and not IsNullOrEmpty(this.activityInfo.helpId) then
        HeroParameter.SaveMiniBattle4Param(this.filterMembers_2)
    end
    HeroParameter.SaveFilterMemberTeamMap(this.filterMembersTeamMap)
    FeatureManager.GotoPanel("1004");
end


this.OnClickCharacter1 = function()
    this.ClickCharacter(1);
end


this.OnClickCharacter2 = function()
    this.ClickCharacter(2);
end


this.OnClickCharacter3 = function()
    this.ClickCharacter(3);
end


this.OnClickCharacter4 = function()
    this.ClickCharacter(4);
end


this.OnClickCharacter5 = function()
    this.ClickCharacter(5);
end


this.OnClickCharacter6 = function()
    this.ClickCharacter(6);
end


this.OnClickQuick = function()
    if isQuickLock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("BattlePrepareViewModel_0"))
        return
    end
    this.ClickCharacter(0);
end


this.SetFormationList = function()
    local tempList = {}
    local count = ConfigMgr.Config.constants.maxSquadCount
    for i = 0, count - 1 do
        local team = DataMgr.Player.teams[tostring(i)]
        local teamName = LuaMgr.GetLangText("BattlePrepareViewModel_14") .. (i + 1)
        if team ~= nil and team.name ~= "" then
            teamName = team.name
        end
        local formationData = {
            text = teamName,
            isShow = false
        }
        table.insert(tempList, formationData)
    end
    this.vm.data.formationDatas = tempList
    this.vm.data.formationName = LuaMgr.GetLangText("ActivityBattlePrepareViewModel_8")
    this.vm.data.showFormationBtn = true
end

this.OnClickFormation = function(vm, param)
    local status = not this.vm.data.showFormationList
    this.vm.data.formationArrowScale = status and Vector3(1, -1, 1) or Vector3.one
    if status then
        this.vm.data.showFormationList = true
        this.formationIndex = 1
        LuaMgr.AddTimer(TimerConst.BattlePrepareFormationDelay, this.OnFormationDelay, 0.1, -1, true)
    else
        this.HideFormations()
    end
end

this.OnFormationDelay = function()
    if this.formationIndex <= #this.vm.data.formationDatas then
        this.vm.data.formationDatas[this.formationIndex].isShow = true
        this.formationIndex = this.formationIndex + 1
        if this.formationIndex > #this.vm.data.formationDatas then
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareFormationDelay)
        end
    end
end

this.OnClickFormationItem = function(vm, param)
    local index = param
    this.HideFormations()
    local formationData = this.vm.data.formationDatas[index + 1]
    if formationData == nil then
        return
    end

    local allFilterMembers = this.GetAllFilterMember()
    ActivityBattlePrepareMgr.SetMembersByFormationId(tostring(index), allFilterMembers)
    this.SetCharacters()
end


this.HideFormations = function()
    this.vm.data.showFormationList = false
    this.vm.data.formationArrowScale = Vector3.one
    for i, item in ipairs(this.vm.data.formationDatas) do
        item.isShow = false
    end
end

this.GetAllFilterMember = function()
    local allFilterMembers = table.Copy(this.filterMembers)
    for k, v in pairs(this.filterMembers_2) do
        allFilterMembers[k] = v
    end
    return allFilterMembers
end


this.SetTeamWeaponSkill = function(teamWeaponId)
    this.curTeamWeaponId = teamWeaponId
    if FeatureManager.IsLock("33001") then
    this.vm.data.teamWeaponBtnActive = false
        return
    end
    this.vm.data.teamWeaponBtnActive = true
    if IsNullOrEmpty(this.curTeamWeaponId) then
        this.vm.data.teamWeaponSkillIconActive = false
        return
    end
    local weaponCfg = TeamWeaponMgr.GetTeamWeaponCfg(this.curTeamWeaponId)
    local skillId = weaponCfg.TeamWeaponSkill[1]
    this.vm.data.teamWeaponSkillIcon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(string.gsub(skillId, "ex", "")))
    this.vm.data.teamWeaponSkillIconActive = true
end

this.UnLockTeam = function()
    local memberList,helpList = {}
    local memberCount,helperCount = 0;
    local requestFunc = nil
    if this.activityKey == ActivityKey.BossDummy5 then
        memberList,helpList=BossDummy5Mgr.GetLockMembersAndHelps(this.activityInfo.plotCfg.Id)
        requestFunc = function()
            BossDummy5Mgr.UnlockMembers(this.activityInfo.config.BossDummy3Id,function()
                ActivityBattlePrepareMgr.SetMembers(ActivityKey.BossDummy5, this.activityInfo.config.BossDummy3Id)
                this.RefreshData();
            end)
        end
    end
    for i, v in ipairs(memberList) do
        if v ~= "" then
            memberCount = memberCount + 1
        end
    end
    for i, v in ipairs(helpList) do
        if v ~= "" then
            helperCount = helperCount + 1
        end
    end
    if memberCount == 0 and helperCount == 0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("23762"));
        return;
    end
    if requestFunc ~= nil then
        LuaMgr.ShowLuaPanel(UIName.ConfirmTipViewModel,ConfigMgr.LangGlobal("30270"),ConfigMgr.LangGlobal("30271"),function()
            requestFunc()
        end,nil)
    end
end

this.OnBack = function()
    LuaMgr.Back();
end

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.quickBtn, this.OnClickQuick);
        LuaMgr.AddClick(this.charactersBg1, this.OnClickCharacter1);
        LuaMgr.AddClick(this.charactersBg2, this.OnClickCharacter2);
        LuaMgr.AddClick(this.charactersBg3, this.OnClickCharacter3);
        LuaMgr.AddClick(this.charactersBg4, this.OnClickCharacter4);
        LuaMgr.AddClick(this.charactersBg5, this.OnClickCharacter5);
        LuaMgr.AddClick(this.charactersBg6, this.OnClickCharacter6);
        this.characterListView = UIListView.New(this.charactersListTF);
        this.contentTr = vm.behaviour.transform:Find("root/Middle/Content")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.activityInfo = {}
        this.activityKey = vm.behaviour.Params[0];
        this.InitData()
        this.LoadPanel()
        this.RefreshData()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.MiniBattlePrepareCharacterDelay);
        this.activityInfo = {}
        this.dungeonConfig = nil;
        this.characterListView:Clear();

        if this.activityInfoItem ~= nil then
            this.activityInfoItem:Clear()
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.quickBtn, this.OnClickQuick);
        LuaMgr.RemoveClick(this.charactersBg1, this.OnClickCharacter1);
        LuaMgr.RemoveClick(this.charactersBg2, this.OnClickCharacter2);
        LuaMgr.RemoveClick(this.charactersBg3, this.OnClickCharacter3);
        LuaMgr.RemoveClick(this.charactersBg4, this.OnClickCharacter4);
        LuaMgr.RemoveClick(this.charactersBg5, this.OnClickCharacter5);
        LuaMgr.RemoveClick(this.charactersBg6, this.OnClickCharacter6);
        UIListView.ClearItem("ActivityBattlePrepareEnemyItem");
        UIListView.ClearItem("ActivityBattlePrepareCharacterItem");

        if this.activityInfoItem ~= nil then
            this.activityInfoItem:Destroy()
            this.activityInfoItem = nil
        end
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})