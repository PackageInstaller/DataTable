

require("ViewModel/BattlePrepare/BattlePrepare_HeadItem")

local this = {
    vm = nil,
    data = {
        rewardItemRect = nil,
        characterItemTrList = nil,
        characterListTransform = nil,
        startBattleNumTransform = nil,
        startBattleNumTextComponent = nil,
        rewardDetailsTransform = nil,
        rewardListRect = nil,
        fettersInfoRect = nil,
        actorCount = 0,
        levelingGroupScrollView=nil,
        globalSkillsRect = nil,
		characterRect = nil,
        btn_gallery_bonus = nil,
        editTeamNameInputFiled = nil,
        editTeamNameInputFiledPlaceholder = nil,
        curEditTeamIndex = "",
        reward_obj = nil,
    },
    curTeamWeaponId = "",
    isLimitDungeon = false,
    limitDungeonIndex = 0,
    dungeonLimitTotalCount = 0,
    dungeonLimitUsingCount = 0,
};

local dragIndex = nil
local selectIndex = nil
local downTime = 0
local originPos = nil
local offset = Vector2.zero
local leftBorderX = -388
local rightBorderX = 388

local eventData = nil
local dungeonConfig = nil
local battleTurnEnd = 0
local conditionStatus = ""
local isSaveTeam = false
local isQuickLock = false
local saveTeamAction = nil
local actorList = nil
local teamFormationId = nil
local tempTeam = {}
local isTeamChange = false

local monsterConfigTable = nil

local colorWin = UnityEngine.Color(239 / 255, 229 / 255, 204 / 255, 1)
local colorLose = UnityEngine.Color(141 / 255, 141 / 255, 141 / 255, 1)

local conditionIndex
local isConditionAni = false
local isCharacterAni = false
local isDelayCharacters = false
local addWidth = 0
local formationIndex
local characterIndex
local rewardDetailsIndex
local rewardDetailsCount
local enemyIndex
local itemsIndex

local MaxItemCount = 3
local MaxCharacterCount = 6
local CharacterItemSize = 154
local lastTimeStamp = 0
local ITEM_ICON_FOLDER_PATH = "Assets/_BundleResources/Images/ItemIcons/"

local headItemObj=nil
local cfgRareNumLimit=nil;


local data = {
    typeText = "",
    nameText = "",
    isChallenge = false,
    challengeText = "",
    isChallengeIcon1 = false,
    isChallengeIcon2 = false,
    evaluate = DefaultSprite,
    levelText = "",
    levelChText = "",
    isNotAttribute = false,
    formationText = "",
    formationScale = Vector3.zero,
    isStartBattleNum = false,
    startBattleSize = Vector2.zero,
    startBattlePos = Vector2.zero,
    startBattleNumIcon = DefaultTexture,
    startBattleNumText = "",
    startBattleMsg = "",
    startBattleTextPos = Vector3.zero,
    groupSize = Vector2.zero,
    quickText = "",
    isWin = false,
    winColor = UnityEngine.Color.white,
    isLose = false,
    loseColor = UnityEngine.Color.white,

    evaluateDetailsText1 = "",
    evaluateDetailsText2 = "",
    evaluateDetailsText3 = "",

    isFormations = false,
    isFormationLock = false,
    isFormationText = false,
    isCharacters = false,
    isRewardDetails = false,
    isChallengeDetails = false,
    isEvaluateDetails = false,
    isLockAutoBattle = false,
    isNoPowerEnough = false,
    isLockDelegateBattle = false,
    isSupportDelegateBattle = false,
formationBool = false,
    showRateDropRewardTips = false,


    isLeveling=false,
    leveling_isFree=false,
    offPos=Vector2(0,0),
    conditionDatas = {{ content = "", isShow = false, isAnimator = false, bgRes = DefaultSprite }},
    enemyDatas = {{ icon = DefaultTexture, border = DefaultSprite, type = DefaultSprite, isType = false, isShow = false }},
    itemDatas = {{}},
    formationDatas = {{ text = "", isShow = false }},
    challengeDatas = {{ icon = DefaultTexture, count = "", content = "", alpha = 0.1, isFrame = false, isReceived = false }},
    rewardItems = {{ text = "", isShowTips = false, itemDatas = {}, isShow = false, itemSizeDelta = Vector2.zero, listSizeDelta = Vector2.zero,
                     listAnchoredPos = Vector2.zero }},
    characterItems = {{itemId = "", characterId = "", isLimit = false, isLock = false, isGroup = false, isShow = false, hzActive = false,hzNotActive = false,
                       isSwap = false, isLight = false,isLeveling=false,levelingText="",isShowZZ = true, isShowLevel = true,isAssist=false}},
    

    fettersList = {{fettersId = "", talentIcon = "", showIcon = false}},
    fettersName = "",
    fettersBuffList = {{buffDes = ""}},
    fettersInfoPos = Vector2.zero,
    fettersInfoSize = Vector2.zero,
    fettersInfoActive = false,
    fettersGroupActive = false,


    globalSkillBtnActive = false,
    globalSkillsActive = false,
    globalSkillList = {{ skillId = "", count = "0", icon = DefaultTexture, avaliable = true, disable = false, }},
    globalSkillMarkScale = Vector3.zero,
    
    openStrategyUrlBtnActive = false,
    isDouble=false;
    doubleText="";


    btn_gallery_bonus_active = true,
    
    showEditTeamNamePopup = false,
    showEditTeamNameMask = false,
    

    isAssistDungeon=false;
    assistHeroCount="";
    assistDailyCount="";
    

    novelTipText="";
    novelTipBool=false;

    teamWeaponBtnActive = false,
    teamWeaponSkillIcon = DefaultTexture,
    teamWeaponSkillIconActive = false,
    

    limitRoot = false,
    limitCountText = "",
}

local objs={tipsText={path="root/Middle/Group/Characters/Bottom/leveingGroup/downInfo/tipsText",type="Text"}}

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

    quickCommnad = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickQuick(vm, param)
        end
    },

    enemyCommnad = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickEnemy(vm, param)
        end
    },

    rewardCommnad = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickReward(vm, param)
        end
    },

    closeRewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickCloseReward(vm, param)
        end
    },

    winCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickWin(vm, param)
        end
    },
    
    loseCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickLose(vm, param)
        end
    },

    startBattleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.isLimitDungeon and this.dungeonLimitUsingCount == this.dungeonLimitTotalCount then
                local tips = ConfigMgr.LangGlobal("31155")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips)
                return
            end
            this.OnClickStartBattle(vm, param)
        end
    },

    challengeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickChallenge(vm, param)
        end
    },

    evaluateCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickEvaluate(vm, param)
        end
    },

    challengeDetailsCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickChallengeDetails(vm, param)
        end
    },

    evaluateDetailsCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickEvaluateDetails(vm, param)
        end
    },

    delegateBattleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.isLimitDungeon and this.dungeonLimitUsingCount == this.dungeonLimitTotalCount then
                local tips = ConfigMgr.LangGlobal("31155")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips)
                return
            end
            this.OnClickDelegateBattle(vm, param)
        end
    },

    closeTipsCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickTipsMask(vm, param)
        end
    },

    rateDropRewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showRateDropRewardTips = true
        end
    },
    
    fettersItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            this.OnClickFettersItem(index)
        end
    },
    
    fettersGotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.HideFormations()
            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeTrammelsViewModel)
        end
    },
    
    showGlobalSkillsCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.HideFormations()
            this.SetGlobalSkillsVislble(not this.vm.data.globalSkillsActive)
        end
    },
    
    globalSkillCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            for i, v in ipairs(this.vm.data.globalSkillList) do 
                if i == index then
                    local globalSkillID = v.skillId
                    LuaMgr.ShowPanel(UIName.SkillTipsViewModel, SkillType.FalseCharacter, nil, globalSkillID, nil, 0, 0)
                end
            end
        end
    },

    openStrategyUrlCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local mapWebURL = ConfigMgr.Config.constants.BLineupWeb .. dungeonConfig.id;
            local orientation = ConfigMgr.Config.constants.BLineupWebType
            LuaMgr.OpenURL(mapWebURL,orientation);
        end
    },

    btnGalleryBonusCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.BattlePrepareGalleryBonusPopupViewModel, this.data.btn_gallery_bonus)
        end
    },

    btnChangeTeamNameCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.data.curEditTeamIndex = tostring(param)
            local team = DataMgr.Player.teams[this.data.curEditTeamIndex]
            local teamName = LuaMgr.GetLangText("BattlePrepareViewModel_14") .. (param + 1)
            if team ~= nil then
                teamName= team.name
            end
            this.data.editTeamNameInputFiled.text = ""
            this.data.editTeamNameInputFiled.placeholder.text = teamName .. LuaMgr.GetLangText("BattlePrepareViewModel_1")
            this.vm.data.showEditTeamNamePopup = true
        end
    },
    
    ChangeTeamNameConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local editTeamName = this.data.editTeamNameInputFiled.text
            if editTeamName == "" then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("1020"))
                return
            end
            local originTeam = DataMgr.Player.teams[this.data.curEditTeamIndex]
            local param = {
                battleType = nil,
                teamId = this.data.curEditTeamIndex,
                members = originTeam == nil and {} or originTeam.members,
                helps = originTeam == nil and {} or originTeam.helps,
                teamName = editTeamName
            }
            BattlePrepareMgr.CheckAndSaveTeam(param, this.SaveTeamNameResponse)
        end
    },
    
    ChangeTeamNameCancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showEditTeamNamePopup = false
        end
    },

    EditTeamNameMaskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickFormation(vm, param)
        end
    },
    
    teamWeaponCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if IsNullOrEmpty(this.curTeamWeaponId) then
                LuaMgr.ShowLuaPanel(UIName.TeamWeaponViewModel)
            else
                local weaponCfg = TeamWeaponMgr.GetTeamWeaponCfg(this.curTeamWeaponId)
                local weaponData = TeamWeaponMgr.GetTeamWeaponData(this.curTeamWeaponId)
                local skillLevel = tonumber(weaponCfg.TeamWeaponSkillStar[weaponData.Star])
                LuaMgr.ShowPanel(UIName.SkillTipsViewModel, 5, this.curTeamWeaponId, nil, nil, 5, nil, skillLevel)
            end
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.data.rewardDetailsTransform = vm.behaviour.transform:Find("root/Middle/Group/RewardDetails/ScrollView/Viewport/Content")
        this.data.startBattleNumTransform = vm.behaviour.transform:Find("root/Right/Info/StartBattle/Num")
        this.data.startBattleNumTextComponent =   this.data.startBattleNumTransform:Find("Text"):GetComponent("Text")
        this.data.rewardItemRect = vm.behaviour.transform:Find("template/RewardItem"):GetComponent("RectTransform")
        this.data.rewardListRect = vm.behaviour.transform:Find("template/RewardItem/Group/List"):GetComponent("RectTransform")
        this.data.fettersInfoRect = vm.behaviour.transform:Find("root/Middle/Group/Characters/Bottom/FettersInfo"):GetComponent("RectTransform")
        this.levelingGroupScrollView=UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Group/Characters/Bottom/leveingGroup/downInfo/bg/ScrollView"))
        headItemObj=vm.behaviour.transform:Find("template/headItem").gameObject
        this.data.globalSkillsRect = vm.behaviour.transform:Find("root/Middle/Group/Characters/Bottom/GlobalSkills"):GetComponent("RectTransform")

        if this.data.characterRect == nil then
            this.data.characterRect = vm.behaviour.transform:Find("root/Middle/Group/Characters"):GetComponent("RectTransform")
        end

        this.data.btn_gallery_bonus = vm.behaviour.transform:Find("root/Middle/Group/Characters/Bottom/btn_gallery_bonus").gameObject
        this.data.editTeamNameInputFiled = vm.behaviour.transform:Find("root/Right/EditTeamNamePopup/InputField"):GetComponent("InputField")
        this.data.reward_obj = vm.behaviour.transform:Find("root/Right/Info/Reward").gameObject
        UITool.Parse(vm.behaviour,this,objs)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end;
        if BattlePrepareMgr.isRogue then
            LuaMgr.SetShowRogueCharacterData(true)
        end
        this.Refresh()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.vm.data.fettersInfoActive = false
            LuaMgr.RemoveUpdate(this.UpdateHandler)
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareCharacters)
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareCondition);
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareFormationDelay);
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareCharacterDelay);
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareTuiJianDelay);
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareRewardDetailsDelay);
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareEnemyDelay);
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareItemsDelay);
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareGetItem);
            LuaMgr.RemoveTimer(TimerConst.BattlePreapreStamina)
            LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.UpdateFatigue)
            LuaMgr.RemoveUIEventListener(UIEventConst.FatigueReply, this.UpdateFatigue)
            LuaMgr.RemoveUIEventListener(UIEventConst.GuideClickBattleCharacter, this.OnClickBattleCharacter)
            LuaMgr.RemoveUIEventListener(UIEventConst.OnApplicationFocus, this.ApplicationFocus);
            LuaMgr.RemoveUIEventListener(UIEventConst.BattleReplayLogAvaliable, this.OnBattleReplayLogAvaliable);
            LuaMgr.RemoveUIEventListener(UIEventConst.BattlePrepareFetterRefresh, this.SetFetters)
            LuaMgr.RemoveUIEventListener(UIEventConst.UpdateBattlePrepareInfos,this.UpdateInfos);
            LuaMgr.RemoveDataEventListener(this.OnDataChanged);
            AudioMgr.Singleton:StopVoice();
            this.HideFormations();
            if isTeamChange and not BattlePrepareMgr.isRogue then
                isTeamChange = false
                this.SaveTeamMembers()
            end
            this.vm.data.showRateDropRewardTips = false
            HeroParameter.EmptyJobSort()
            this.levelingGroupScrollView:Clear(false);
            this.SetGlobalSkillsVislble(false)
            LuaMgr.SetShowRogueCharacterData(false)
        end
    end,

    before_destroy = function(vm)
        this.vm.data = nil;
        this.vm.behaviour = nil;
        this.vm = nil;
        this.data=nil;
        UIScrollView.ClearItem("BattlePrepare_HeadItem")
    end
}

this.UpdateInfos=function()
    this.SetDoubleInfo();
end

this.Refresh = function()
    if (this.vm.behaviour.Params == nil or this.vm.behaviour.Params.Length ~= 1) then
        LuaDebug.error("491===================")
        return
    end
    if BattlePrepareMgr._enterDungeonParams == nil then
        LuaMgr.HidePanel(UIName.BattlePrepareViewModel)
        return
    end
    this.vm.behaviour:UpdateTopBar("", this.OnBack);
    BattlePrepareMgr.isEnterBattle = false
    lastTimeStamp = LuaMgr.Timestamp()
    eventData = this.vm.behaviour.Params[0]
    dungeonConfig = ConfigMgr.Config.dungeonMap[eventData.eventParam]
    PlayerAreaMgr.SetAreaDungeonId(eventData.eventParam);
    if dungeonConfig == nil then
        LuaDebug.error("504===================")
        return
    end

    this.GetActorList()
    this.SetPageInfo()
    
    if not this.vm.behaviour.IsPop or HeroParameter.isTeamChanged then
        this.SelectFormationWithOutParam();

        if not BattlePrepareMgr.isLeveling and not BattlePrepareMgr.isRogue then
            this.vm.data.isCharacters = true;
            PlayerAssistMgr.UpdateFriendList2(function()
                PlayerAssistMgr.Clear();
                this.CheckMemberInvalid(BattlePrepareMgr.formationId);
                this.DelayCharacters(false)
            end)
        else
            this.DelayCharacters(true)
        end
    else
        this.SetFormation()
        this.DelayCharacters(true)
    end

    if HeroParameter.changeAfterTeam ~= nil and HeroParameter.battleMembers ~= nil then
        this.OnTeamChangeCB(HeroParameter.changeAfterTeam)
    end
    this.CheckIsLeveling()
    this.SetTeamWeaponSkill()

    LuaMgr.AddUIEventListener(UIEventConst.HeartBeat, this.UpdateFatigue);
    LuaMgr.AddUIEventListener(UIEventConst.FatigueReply, this.UpdateFatigue);
    LuaMgr.AddUIEventListener(UIEventConst.GuideClickBattleCharacter, this.OnClickBattleCharacter);
    LuaMgr.AddUIEventListener(UIEventConst.OnApplicationFocus, this.ApplicationFocus);
    LuaMgr.AddUIEventListener(UIEventConst.BattleReplayLogAvaliable, this.OnBattleReplayLogAvaliable);
    LuaMgr.AddUIEventListener(UIEventConst.BattlePrepareFetterRefresh, this.SetFetters)
    LuaMgr.AddUIEventListener(UIEventConst.UpdateBattlePrepareInfos,this.UpdateInfos);
    LuaMgr.AddDataEventListener(this.OnDataChanged);
end


this.SetAssistInfo=function()
    local isShow=not BattlePrepareMgr.isRogue and  PlayerAssistMgr.IsOpen() and dungeonConfig.isSupport>0;
    this.vm.data.isAssistDungeon=isShow
    if isShow then
        this.vm.data.assistHeroCount=string.format("%s/%s",NumTool.GetLen(PlayerAssistMgr.assistMembers),dungeonConfig.supportNum);
        this.vm.data.assistDailyCount=string.format("<color=#eccc38>%s</color>/%s",PlayerAssistMgr.RemainAssistCount(),ConfigMgr.Config.FriendConstants.TotalBorrowLimit)
    end
end



this.CheckMemberInvalid=function(teamId)
    local assistMember={};
    if IsNullOrEmpty(teamId) or NumTool.GetLen(BattlePrepareMgr.memberDic)==0 then
        PlayerAssistMgr.SetAssistMembers(assistMember)
        return 
    end;
    local team=DataMgr.Player.teams[tostring(teamId)];
    if team==nil or IsNull(team.helps) then
        PlayerAssistMgr.SetAssistMembers(assistMember)
        return
    end;
    local isHasAssist=false;
    for i,v in pairs(team.helps) do
        if not IsNullOrEmpty(v) then
            isHasAssist=true;
            break;
        end
    end
    if not isHasAssist then
        PlayerAssistMgr.SetAssistMembers(assistMember)
        return 
    end;

    local idToUid={};
    for i,v in pairs(team.members) do
        if team.helps[i]~=nil then
            idToUid[v]=team.helps[i]
        else
            idToUid[v]="";  
        end
    end
    local tempMember={}
    local tempMember2={}
    local type=0;

    for i,v in pairs(BattlePrepareMgr.memberDic) do
        if not IsNullOrEmpty(v) then
            local uid=idToUid[v];
if IsNullOrEmpty(uid) then
                table.insert(tempMember,{index=tonumber(i),id=v,uid=""})
            elseif PlayerAssistMgr.CheckAssistListContainsKeyHero(uid,v) then
                table.insert(tempMember,{index=tonumber(i),id=v,uid=uid})
            else
                type=1;
            end
        end
    end
    table.sort(tempMember,function(a, b) return a.index<b.index end)
    if dungeonConfig.isSupport==0 then

        type=2;
        for i,v in ipairs(tempMember) do
            if IsNullOrEmpty(v.uid) then
                table.insert(tempMember2,v);
            end
        end
    elseif PlayerAssistMgr.RemainAssistCount()==0 then

        type=4;
        for i,v in ipairs(tempMember) do
            if IsNullOrEmpty(v.uid) then
                table.insert(tempMember2,v);
            end
        end
    else
        local index=0;
        for i,v in ipairs(tempMember) do
            if IsNullOrEmpty(v.uid) then
                table.insert(tempMember2,v);
            else

                if index<dungeonConfig.supportNum then

                    if PlayerAssistMgr.FriendRemainAssistCount(v.uid)>0 then
                        index=index+1;
                        table.insert(tempMember2,v);
                        assistMember[v.id]={id=v.id,uid=v.uid};
                    else
                        type=5;
                    end
                else
                   type=3;    
                end
            end
        end
    end

    PlayerAssistMgr.SetAssistMembers(assistMember)
    if #tempMember2>0 then

        table.sort(tempMember2,function(a, b) return a.index<b.index end)
        local newMember={};
        for i,v in ipairs(tempMember2) do
            newMember[tostring(i-1)]=v.id;
        end
        BattlePrepareMgr.memberDic=newMember;
    else
        BattlePrepareMgr.memberDic={}
    end

    if type==0 then return end;
    this.SaveTeamMembers();
    local tip=""
    if type==2 then
        tip=ConfigMgr.LangGlobal("21001")
    elseif type==3 then
        tip=ConfigMgr.LangGlobal("21004")
    elseif type==1 then
        tip=ConfigMgr.LangGlobal("21000")
    elseif type==5 then
        tip=ConfigMgr.LangGlobal("21005")
    elseif type==4 then
        tip=ConfigMgr.LangGlobal("21006")
    end
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tip)
end


this.SetDoubleInfo=function()
    local isDouble=ActivityMgr.DoubleRewards_CheckDungeonID(dungeonConfig.id);
    this.vm.data.isDouble=isDouble;
    if isDouble then
        this.vm.data.doubleText=ActivityMgr.DoubleRewards_ProText();
    end
end

this.SetDungeonLimit = function()
    this.isLimitDungeon,this.limitDungeonIndex = ConfigHelper.IsLimitCount(dungeonConfig.id)
    if this.isLimitDungeon then
        this.dungeonLimitTotalCount = ConfigMgr.Config.constants.LevelWeeklyLimit[this.limitDungeonIndex]
        local dungeonKey = "dungeon_"..dungeonConfig.id
        this.dungeonLimitUsingCount = 0
        if DataMgr.Player.weeklyCount[dungeonKey] ~= nil then
            this.dungeonLimitUsingCount = DataMgr.Player.weeklyCount[dungeonKey]
        end
        local countStr = ""
        local count = 0
        if this.dungeonLimitUsingCount < this.dungeonLimitTotalCount then
            countStr = ConfigMgr.LangGlobal("31154")
            count = this.dungeonLimitTotalCount - this.dungeonLimitUsingCount
            this.vm.data.limitCountText = string.format(countStr,count,this.dungeonLimitTotalCount)
        elseif this.dungeonLimitUsingCount == this.dungeonLimitTotalCount then
            countStr = ConfigMgr.LangGlobal("31155")
            this.vm.data.limitCountText = countStr
        end
    end
    this.vm.data.limitRoot = this.isLimitDungeon
end

this.UpdateHandler = function()









    if this.vm.data.globalSkillsActive and not LuaMgr.IsPanelOpen(UIName.SkillTipsViewModel) and CS.Laigu.Tools.RaycastTool.GetMouseButtonDown(0) then
        local screenPos = CS.Laigu.Tools.RaycastTool.GetMousePosition()
        local localPoint = LuaMgr.Screen2Local(Vector2(screenPos.x, screenPos.y), this.data.globalSkillsRect)
        if not this.data.globalSkillsRect.rect:Contains(localPoint) then
            this.SetGlobalSkillsVislble(false)
        end
    end
end

this.OnBack=function()
    HeroParameter.EmptyTeamParam()
    HeroParameter.EmptyBattlePrepareParam()
    HeroParameter.TeachingReturn=true
    if not BattlePrepareMgr._enterDungeonParams.isActive then
        HeroParameter.EmptyTarItem()
    end
    if BattlePrepareMgr.isRogue then
        RogueExploreMgr.ClearHandlerList()
    end
    if this.vm.data.isRewardDetails then
        this.DelayCharacters(false)
        this.vm.data.showRateDropRewardTips = false
    else
        local params= BattlePrepareMgr._enterDungeonParams
if params.themeId~=nil and params.themeId~="" and params.themeId=="MapA" then
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7100"].NameLan)
            local nowEventId="";
            for index, value in ipairs(DataMgr.Player.practicesStage.stages[#DataMgr.Player.practicesStage.stages]) do
                if value.status==1 then
                    nowEventId=value.stageid;
                    break;
                end
            end
            local type=ConfigMgr.Config.InternEventKV[nowEventId].EventType
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, tipStr, function()
                local data = { ThemeId = CollectorPracticeMgr.ThemData.mapType,EventType=type,DungeonID=params.dungeonId}
                local Url = "abandon_dungeon"
                ApiMgr.Request(Url, data, true,
                function(result)
                    local re = json.decode(result)
                    if re.code == 0 then
                        LuaMgr.Back();
                        this.vm.behaviour:UpdateTopBar("", this.OnBack);
                    end
                end,
                function(failCode)
                    print("EnterDungeonError,ErrorCode:", failCode)
                end,
                true
            )
            end, nil)
        else
            LuaMgr.Back()
            this.vm.behaviour:UpdateTopBar("", this.OnBack);
        end
    end
end
    
this.OnClickBattleCharacter = function(args)
    local itemId = args[0];
    local list = NumTool.split(itemId, "_");
    if (list ~= nil and #list == 2) then
        downTime = CS.UnityEngine.Time.realtimeSinceStartup
        dragIndex = tonumber(list[2]);
        this.OnEnd()
    end
end


this.OnClickFormation = function(vm, param)
    if this.vm.data.isFormationLock then
        return
    end
    local status = not this.vm.data.isFormations
    this.vm.data.formationScale = status and Vector3(1, -1, 1) or Vector3.one
    this.SaveTeamMembers()
    if status then
        this.vm.data.isFormations = true
        this.vm.data.showEditTeamNameMask = true
        formationIndex = 1
        LuaMgr.AddTimer(TimerConst.BattlePrepareFormationDelay, this.OnFormationDelay, 0.1, -1, true)
    else
        this.HideFormations()
    end
end

this.OnFormationDelay = function()
    if formationIndex <= #this.vm.data.formationDatas then
        this.vm.data.formationDatas[formationIndex].isShow = true
        formationIndex = formationIndex + 1
        if formationIndex > #this.vm.data.formationDatas then
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareFormationDelay)
        end
    end
end

this.OnClickFormationItem = function(vm, param)
    if BattlePrepareMgr.isEnterBattle then
        return
    end
    local index = param
    this.HideFormations()
    local formationData = this.vm.data.formationDatas[index + 1]
    if formationData == nil then
        return
    end

    this.vm.data.formationScale = Vector3.one
    if BattlePrepareMgr.formationId == tostring(index) then
        return
    end
    this.SelectFormation(index)
    this.CheckMemberInvalid(index)
    this.SetAssistInfo()
    this.OnCharacters()
end

this.OnClickQuick = function(vm, param)
    if BattlePrepareMgr.isEnterBattle then
        return
    end
    this.HideFormations()
    if isQuickLock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("BattlePrepareViewModel_0"))
        return
    end
    
    local CharacterId = ""
    for k, item in pairs(BattlePrepareMgr.memberDic) do
        if item ~= nil and item ~= "" then
            CharacterId = item
            break
        end
    end

    local formationid = IsNullOrEmpty(teamFormationId) and BattlePrepareMgr.formationId or teamFormationId
    
    local teamId = BattlePrepareMgr.formationId
    if not BattlePrepareMgr.IsMoreMod() and not BattlePrepareMgr.isRogue then

        if DataMgr.Player.teams[teamId] == nil then
            DataMgr.Player.teams[teamId] = {members = {}, name = ""}
        end
        DataMgr.Player.teams[teamId].members = BattlePrepareMgr.memberDic
        PlayerCharacterMgr.CheckCharacter()
    end

    local isLock,characterList =BattlePrepareMgr.NeedLockCharacter();
    if isLock then
HeroParameter.InitCommonSelectCharacter(isLock,characterList,#characterList<6 and #characterList or 6);
    end

    if BattlePrepareMgr.isRogue then
        HeroParameter.SaveRogueParam(tempTeam, true, 6, "");
    else
        HeroParameter.SaveBattlePrepareParam(formationid, "",false,true,true, tempTeam)
        PlayerAssistMgr.CheckDungeonIsSupportAssist(dungeonConfig)
    end
    FeatureManager.GotoPanel("1004")
end

this.OnClickEnemy = function(vm, param)
    if monsterConfigTable == nil or next(monsterConfigTable) == nil then
        return
    end
    LuaMgr.ShowLuaPanel("BattlePrepareEnemyViewModel", dungeonConfig, monsterConfigTable)
end

this.OnClickReward = function(vm, param)
    this.HideFormations()
    if #this.vm.data.itemDatas == 0 then
        return
    end
    this.SetRewardDetails()
end

this.OnClickCloseReward = function(vm, param)
    this.DelayCharacters(false)
end

this.OnClickWin = function(vm, param)
    this.HideFormations()
    if conditionStatus == "0" then
        return
    end

    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/DailyDungeon_switch1.mp3");
    conditionStatus = "0"
    this.SetWinLose()
    this.SetConditions(LuaMgr.GetLangText(dungeonConfig.victoryTitleLan))
end

this.OnClickLose = function(vm, param)
    this.HideFormations()
    if conditionStatus == "1" then
        return
    end
    
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/DailyDungeon_switch1.mp3");
    conditionStatus = "1"
    this.SetWinLose()
    this.SetConditions(LuaMgr.GetLangText(dungeonConfig.victoryTitleLan))
end

this.OnClickStartBattle = function(vm, param)
    this.HideFormations()
    if (not LuaMgr.IsGuide()) then
        this.CheckBattleCondition(this.CheckStartBattle)
        return
    end
    this.CheckStartBattle();
end

this.CheckBattleCondition = function(callBack)
    local battleCount=BattlePrepareMgr.GetFastBattleCount(dungeonConfig.id)
    if battleCount~=nil and battleCount==0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("7510"))
        return;
    end
    
    local memberDic=BattlePrepareMgr.memberDic;
    if BattlePrepareMgr.isLeveling then
        memberDic=BattlePrepareMgr.MoreModCheckmemberDic();
    end
    local memberNum=NumTool.GetLen(memberDic)
    if memberNum < 1 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("BattlePrepareViewModel_5"))
        return
    end
    if BattlePrepareMgr.isRogue then
        if callBack ~= nil then
            callBack()
        end
        return;
    end

    if BattlePrepareMgr.IsMoreMod()  then
        local limitCount=ConfigMgr.Config.moreModConstants.MinPeopleLimit
        if memberNum<limitCount then
            local tip=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2459"].NameLan);
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(tip,limitCount));
            return
        elseif memberNum<6 then
            local tip=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2458"].NameLan);
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tip,function()
                if callBack ~= nil then
                    callBack()
                end
            end,nil)
            return
        end
        if callBack ~= nil then
            callBack()
        end
        return;
    end
 
    if memberNum < dungeonConfig.outRoleNum then
        local characterCount = 0
        for k, v in pairs(DataMgr.Player.characters) do
            characterCount = characterCount + 1
        end
        local isTrainingDummy = false
        local params = BattlePrepareMgr._enterDungeonParams
        if (not IsNull(params)) and not IsNull(params.extraParams) then
            for _, v in ipairs(params.extraParams) do
                if tostring(v) == "wood_training" then
                    isTrainingDummy = true
                    break
                end
            end
        end
        if not isTrainingDummy and characterCount > memberNum then
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2031"].NameLan), callBack, function() end)
            return
        end
    end
    local level = this.GetTeamMemberLevel()
    level = level / memberNum
    level = level + ConfigMgr.Config.constants.MinLevelTips
    if level < dungeonConfig.levelShow then
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2032"].NameLan), callBack, function() end)
        return
    end

    if callBack ~= nil then
        callBack()
    end
    
end
    



this.OnClickChallenge = function(vm, param)
    this.HideFormations()
    local status = not this.vm.data.isChallengeDetails
    this.vm.data.isChallengeDetails = status
    if status then
        this.SetChallengeDetails()
    end
end

this.OnClickEvaluate = function(vm, param)
    if PlayerAreaMgr.IsAreaModelNovel() then
        return;
    end
    this.HideFormations();
    LuaMgr.ShowLuaPanel("BattlePrepareEvaluateViewModel",eventData.eventParam)
end

this.OnClickChallengeDetails = function(vm, param)
    this.vm.data.isChallengeDetails = false
end

this.OnClickEvaluateDetails = function(vm, param)

end

this.OnClickDelegateBattle = function(vm, param)
    local battleCount=BattlePrepareMgr.GetFastBattleCount(dungeonConfig.id)
    if battleCount~=nil and battleCount==0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("7510"))
        return;
    end
    
    if this.vm.data.isLockDelegateBattle then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2148"].NameLan))
    elseif this.vm.data.isNoPowerEnough then
        LuaMgr.ShowLuaPanel("FatigueReplyViewModel")
    else

        if this.isLimitDungeon then
            local maxCount = this.dungeonLimitTotalCount - this.dungeonLimitUsingCount
            LuaMgr.ShowLuaPanel("BattleDelegeteSettingViewModel",dungeonConfig.id,maxCount);
        else
            LuaMgr.ShowLuaPanel("BattleDelegeteSettingViewModel",dungeonConfig.id);
        end
    end
end

this.OnBattleReplayLogAvaliable = function(args)



















        

end

this.OnClickTipsMask = function(vm, param)
    this.vm.data.showRateDropRewardTips = false
end

this.OnClickFettersItem = function(index)
    this.HideFormations()
    LuaMgr.ShowLuaPanel(UIName.BattlePrepareFetterViewModel)
end

this.OnCharacterSingleClick = function(index)
    if not isDelayCharacters then
        local clickItem = this.vm.data.characterItems[index]
        if (dungeonConfig.fightType == 1 or dungeonConfig.fightType == 3) and not clickItem.isLock and not clickItem.isLimit then
            local formationid = IsNullOrEmpty(teamFormationId) and BattlePrepareMgr.formationId or teamFormationId

            local isLock,characterList =BattlePrepareMgr.NeedLockCharacter();
            if isLock then
HeroParameter.InitCommonSelectCharacter(isLock,characterList,#characterList<6 and #characterList or 6);
            else
                HeroParameter.ClearCommonSelectCharacter();
            end

            if BattlePrepareMgr.isRogue then
                HeroParameter.SaveRogueParam(tempTeam, false, 6, clickItem.characterId);
            else
                HeroParameter.SaveBattlePrepareParam(formationid,clickItem.characterId,false,true,false,tempTeam)
                PlayerAssistMgr.CheckDungeonIsSupportAssist(dungeonConfig)
            end
            FeatureManager.GotoPanel("1004")
        end
        AudioHelper.PlayUISFX(AudioNames.EButtonLight)
        LuaMgr.InvokeUIEventListeners(UIEventConst.GuideClick, this.data.characterItemTrList[index].gameObject)
    end
end

this.OnTeamChangeCB = function(ids)
    LuaMgr.CharacterJoinTeamVoice(ids)
    this.ChangeCharacter(HeroParameter.battleMembers)
end

this.OnDown = function(index, eventData)
    if BattlePrepareMgr.isEnterBattle then
        return
    end
    
    local clickItem = this.vm.data.characterItems[index]
    downTime = CS.UnityEngine.Time.realtimeSinceStartup
    dragIndex = index
    selectIndex = nil
    originPos = clickItem.itemPosition
    if IsNullOrEmpty(clickItem.characterId) or not clickItem.drag then
        return
    end

    local tarPos = LuaMgr.Screen2Local(eventData.position, this.data.characterListTransform)
    offset.x = originPos.x - tarPos.x
    offset.y = originPos.y - tarPos.y
    this.data.characterItemTrList[dragIndex]:SetAsLastSibling()
    AudioHelper.PlayUISFX(Path.audio_PATH.."newUI/plane.mp3");
end

this.OnDrag = function(eventData)
    if BattlePrepareMgr.isEnterBattle then
        return
    end
    if isDelayCharacters or dragIndex == nil then
        return
    end
    
    local clickItem = this.vm.data.characterItems[dragIndex]
    if IsNullOrEmpty(clickItem.characterId) or not clickItem.drag then
        return
    end
    
    local result = RectTool.Screen2Local(eventData.position,  this.data.characterListTransform)
    if result.inRect then
        local pos = Vector3(result.pos.x + offset.x, 0, 0) 

        if pos.x < leftBorderX then
            pos.x = leftBorderX
        elseif pos.x > rightBorderX then
            pos.x = rightBorderX
        end
        this.data.characterItemTrList[dragIndex].localPosition = pos
    end
    
    if selectIndex ~= nil then
        this.vm.data.characterItems[selectIndex].isLight = true
    end
    
    local isSelect = false
    for i, item in ipairs(this.vm.data.characterItems) do
        if i ~= dragIndex then
            if item.swap then
                if not IsNullOrEmpty(item.characterId) then
                    this.vm.data.characterItems[i].isSwap = true
                end

                if this.Intersect(this.data.characterItemTrList[i].localPosition) then
                    if selectIndex ~= nil then
                        this.vm.data.characterItems[selectIndex].isLight = false
                    end
                    
                    selectIndex = i
                    isSelect = true
                    if not IsNullOrEmpty(item.characterId) then
                        this.vm.data.characterItems[i].isLight = true
                    end

                    AudioHelper.PlayUISFX(AudioNames.EHandleAttract2);
                    break
                end
            end

            this.vm.data.characterItems[i].isLight = false
        end
    end

    if not isSelect then
        selectIndex = nil
    end
end

this.OnEnd = function(eventData)
    if isDelayCharacters or dragIndex == nil or BattlePrepareMgr.isEnterBattle then
        return
    end
    if CS.UnityEngine.Time.realtimeSinceStartup - downTime <= 0.2 then
        this.OnCharacterSingleClick(dragIndex)
    else
        this.ChangeMemberPos()
        AudioHelper.PlayUISFX(AudioNames.EDragEnd)
    end

    for i, item in ipairs(this.vm.data.characterItems) do
        this.vm.data.characterItems[i].isLight = false
        this.vm.data.characterItems[i].isSwap = false
    end
    this.vm.data.characterItems[dragIndex].itemPosition = originPos
    dragIndex = nil
    selectIndex = nil
end


this.CheckAcrossDay = function(target)
    local curTimeStamp = LuaMgr.Timestamp()
    local tempTimeStamp = LuaMgr.Timestamp(-1, -1, -1, 4, 0, 0)

    if lastTimeStamp < tempTimeStamp and curTimeStamp > tempTimeStamp then
        lastTimeStamp = curTimeStamp;
        return false;
    end
    
    return true
end


this.GetTeamMemberLevel = function()
    local level = 0
    for k, item in pairs(BattlePrepareMgr.memberDic) do
        local actor = ConfigMgr.Config.actor[item]
        if actor ~= nil then
            level = level + actor.Level
        elseif  PlayerAssistMgr.IsAssistMember(item) then
            local uid=PlayerAssistMgr.GetAssistMemberUid(item);
            if uid~=nil then
                local assistCharacter=PlayerAssistMgr.GetAssist_Character(uid,item)
                if assistCharacter~=nil then
                    level = level + assistCharacter.level;
                end
            end
        else
            level = level + HeroManager.GetCharacterLevel(item)
        end
    end
    return level
end


this.CheckStartBattle = function(target)
    if BattlePrepareMgr.isRogue then
        RogueMgr.CheckSaveTeam(BattlePrepareMgr.memberDic,function()
            this.OnStartBattle();
        end);
        return;
    end
    if this.SaveTeamMembers() then
        saveTeamAction = this.OnStartBattle
    else
        this.OnStartBattle()
    end
end

this.OnStartBattle = function(target)
    local memberList = BattlePrepareMgr.GetMemberList()
    for i = #memberList, dungeonConfig.outRoleNum + 1, -1 do
        BattlePrepareMgr.memberDic[tostring(i - 1)] = nil
    end
    
    local num = tonumber(dungeonConfig.levelNum)
    if num > 0 then
        local count = 0
        local dungeon = DataMgr.Player.dungeonRecords[dungeonConfig.id]
        if dungeon ~= nil then
            count = dungeon.completeCount
        end
        
        num = num - count
        if num <= 0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("BattlePrepareViewModel_6"))
            return
        end
    end

    if not PlayerAreaMgr.IsAreaModelNovel() and  not IsNull(dungeonConfig.consumeItem) and #dungeonConfig.consumeItem > 0 then

        local costIndex=1;
        local records = DataMgr.Player.dungeonRecords[eventData.eventParam]
        if records~=nil then
            costIndex=costIndex+records.completeCount;
            if costIndex>#dungeonConfig.consumeItem then
                costIndex=#dungeonConfig.consumeItem;
            end
        end
        local item = dungeonConfig.consumeItem[costIndex]
        if item ~= nil then
            local config = ConfigMgr.Config.itemMap[item.id]
            if config ~= nil then
                local isMainAreaEvent =  ConfigAreaMgr.IsMainAreaEvent(eventData.id)
                local dungeonRecord = DataMgr.Player.dungeonRecords[eventData.eventParam]
                local completed = dungeonRecord ~= nil and not IsNullOrEmpty(dungeonRecord.historyRating)
                if not (isMainAreaEvent and completed) then
                    if item.id == "101" then
                        num = DataMgr.Player.stamina
                    else
                        local itemData = DataMgr.Player.items[item.id]
                        if itemData ~= nil then
                            num = itemData.count0
                        end
                    end
                    if num < item.count then
                        LuaMgr.ShowLuaPanel("FatigueReplyViewModel")
                        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText(config.nameLan) .. LuaMgr.GetLangText("BattlePrepareViewModel_7"))
                        return
                    end
                end
            end
        end
    end

    if LuaMgr.GetAreaBattleType() == BattleType.Daily or LuaMgr.GetAreaBattleType() == BattleType.HZJ then
        local re = this.CheckAcrossDay()
        if not re then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("BattlePrepareViewModel_8"))
            LuaMgr.Back()
            return
        end
    end
    local memberDic=BattlePrepareMgr.memberDic;
    if BattlePrepareMgr.isLeveling then
        memberDic=BattlePrepareMgr.MoreModCheckmemberDic()
    end
    BattlePrepareMgr._enterDungeonParams.count = 1
    BattlePrepareMgr.EnterBattle(memberDic, BattlePrepareMgr.formationId, dungeonConfig.preAVG)
end
  

this.ChangeCharacter = function(members)
    local oldMemberDic = BattlePrepareMgr.memberDic
    BattlePrepareMgr.memberDic = table.Copy(actorList)

    local oldMemberCount = 0
    local newMemberCount = 0
    for k, v in pairs(oldMemberDic) do
        if not IsNullOrEmpty(v) then
            oldMemberCount = oldMemberCount + 1
        end
    end
    for k, v in ipairs(members) do
        if not IsNullOrEmpty(v) then
            newMemberCount = newMemberCount + 1
        end
    end
    if oldMemberCount ~= newMemberCount then
        isTeamChange = true
    else
        isTeamChange = false
    end
    
    local index = #BattlePrepareMgr.GetMemberList()
    for i, member in ipairs(members) do
        if i > index and not IsNullOrEmpty(member) then
            local oldCharacter = oldMemberDic[tostring(index)]
            if IsNullOrEmpty(oldCharacter) or oldCharacter ~= member then
                isTeamChange = true
            end
            BattlePrepareMgr.memberDic[tostring(index)] = member
            index = index + 1
        end
    end
    if not isTeamChange then
        local isHelpsChange=PlayerAssistMgr.CheckCharacterIsChangeByUid();
        LuaDebug.error(isHelpsChange and "1" or "0");
        isTeamChange=isHelpsChange;
    end
end


this.SetPageInfo = function()
    this.vm.data.typeText = LuaMgr.GetLangText("BattlePrepareViewModel_9")
    this.vm.data.nameText = LuaMgr.GetLangText(dungeonConfig.NameLan)
    isConditionAni = true
    conditionStatus = "0"
    this.vm.data.isChallengeDetails = false
    this.vm.data.isEvaluateDetails = false
    this.vm.data.formationScale = Vector3.one

    this.AdjustScreenWidth()
    this.SetFormationList()
    this.SetChallenge()
    this.SetHistoryRating()
    this.SetRecommandLevel()
    this.SetDeletateBattleButtonState()
    this.SetConsume()
    this.SetWinLose()
    this.GetBattleTurnEnd()
    this.SetConditions(LuaMgr.GetLangText(dungeonConfig.victoryTitleLan))
    this.SetEnemys()
    this.SetRewards()
    this.SetOpenStrategyUrlBtnStatus()
    this.SetFetters()
    this.SetGlobalSkills()
    this.SetDoubleInfo();
    this.vm.data.btn_gallery_bonus_active = this.is_btn_gallery_bonus_active()
    this.SetDungeonLimit()
end


this.GetActorList = function()
    actorList = {}
    this.actorCount = 0
    if dungeonConfig.fightType == 2 or dungeonConfig.fightType == 3 then
        for i, v in ipairs(dungeonConfig.limitOutRole) do
            local actor = ConfigMgr.Config.actor[v]
            if actor ~= nil then
                actorList[tostring(i - 1)] = actor.ID
                this.actorCount = this.actorCount + 1
            end
        end
    end
end


this.AdjustScreenWidth = function()
    addWidth = LuaMgr.GetScreenAddWidth()
    addWidth = addWidth > 200 and 200 or addWidth
    this.vm.data.groupSize = Vector2(926 + addWidth, 452)
    local sizeDelta = this.data.rewardDetailsTransform.sizeDelta
    sizeDelta.x = 840 + addWidth
    this.data.rewardDetailsTransform.sizeDelta = sizeDelta
end

this.SetDeletateBattleButtonState = function()
    local dungeon = ConfigMgr.Config.dungeonMap[dungeonConfig.id]
    if dungeon.entrustBattle ~= 1 then
        this.vm.data.isSupportDelegateBattle = false
        return
    end
    this.vm.data.isSupportDelegateBattle = true
    local dungeonRecord = DataMgr.Player.dungeonRecords[dungeonConfig.id]
    local isLock = dungeonRecord == null or dungeonRecord.historyRating ~= "S"
    this.vm.data.isLockDelegateBattle = isLock
    local stamina = 0
    for i, item in ipairs(dungeon.consumeItem) do
        if item.id == "101" then
            stamina = item.count
            break
        end
    end
    this.vm.data.isNoPowerEnough = DataMgr.Player.stamina < stamina
    LuaMgr.RemoveTimer(TimerConst.BattlePreapreStamina)
    if DataMgr.Player.stamina < stamina then
        local staminaRecoverInterval = ConfigMgr.Config.constants.staminaRecoverInterval * 60
        local lastRecoverStaminaTime = DataMgr.Player.lastRecoverStaminaTime
        local maxValue = ConfigMgr.Config.playerLevelUp[tostring(DataMgr.Player.level)].staminaLimit
        local count = maxValue * staminaRecoverInterval
        LuaMgr.AddTimer(TimerConst.BattlePreapreStamina,function()
            this.UpdateTime(staminaRecoverInterval,lastRecoverStaminaTime) end,1,count,true)
    end
end

this.SetChallenge = function()
    local challengeCount = ConfigAreaMgr.GetChallengeCountById(eventData.eventParam)
    if challengeCount > 0 and not PlayerAreaMgr.IsAreaModelNovel() then
        local completeCount = PlayerAreaMgr.GetChallengeCompleteCountById(eventData.eventParam)
        this.vm.data.challengeText = string.format("%s/%s", completeCount, challengeCount)
        this.vm.data.isChallenge = true
        this.vm.data.isChallengeIcon2 = completeCount >= challengeCount
        this.vm.data.isChallengeIcon1 = completeCount < challengeCount
    else
        this.vm.data.isChallenge = false
    end
end

this.SetHistoryRating = function()
    local dungeonData = nil;
    if PlayerAreaMgr.IsAreaModelNovel() then
        local nDungeonData=DataMgr.Player.storyModeDungeonRecords[dungeonConfig.id];
        if nDungeonData~=nil then
            dungeonData=table.Copy(nDungeonData);

            dungeonData.historyRating="";
        end
    else
        dungeonData = DataMgr.Player.dungeonRecords[dungeonConfig.id]
    end
    if dungeonData ~= nil and dungeonData.historyRating ~= nil and dungeonData.historyRating ~= "" then
        this.vm.data.evaluate = LuaMgr.GetSprite("AreaMapRes", "ui_zqzb_pj_" .. dungeonData.historyRating)
    else
        this.vm.data.evaluate = LuaMgr.GetSprite("AreaMapRes", "ui_zqzb_pj_wu")
    end
end

this.SetRecommandLevel = function()
    this.vm.data.levelText = dungeonConfig.levelShow

    if this.vm.data.levelBool and dungeonConfig.dynamicLevel and #dungeonConfig.dynamicLevel > 0 then
        this.vm.data.levelBool = false
    end
end


this.SetConsume = function()
    local num = 0
    num = tonumber(dungeonConfig.levelNum)
    if num > 0 then
        local count = 0
        local dungeon = DataMgr.Player.dungeonRecords[dungeonConfig.id]
        if dungeon ~= nil then
            count = dungeon.completeCount
        end
        
        num = num - count
        if num <= 0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("BattlePrepareViewModel_6"))
            return
        end
    end
    if not IsNull(dungeonConfig.consumeItem) and #dungeonConfig.consumeItem > 0 then

        local costIndex=1;
        local records = DataMgr.Player.dungeonRecords[eventData.eventParam]
        if records~=nil then
            costIndex=costIndex+records.completeCount;
            if costIndex>#dungeonConfig.consumeItem then
                costIndex=#dungeonConfig.consumeItem;
            end
        end
        local item = dungeonConfig.consumeItem[costIndex]
        if item ~= nil then
            local config = ConfigMgr.Config.itemMap[item.id]
            if config ~= nil then
                this.vm.data.startBattleNumIcon = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/ItemIcons/itemicon_%s.png", config.id))



                if item.count==0 or PlayerAreaMgr.IsAreaModelNovel() then
                    this.vm.data.startBattleNumText = "<color=#ffffff>0</color>"
                else
                    if item.id == "101" then
                        num = DataMgr.Player.stamina
                    else
                        local itemData = DataMgr.Player.items[item.id]
                        if itemData ~= nil then
                            num = itemData.count0
                        end
                    end
                    this.vm.data.startBattleNumText = string.format("<color=%s>-%s</color>", num >= item.count and "#ffffff" or "#d30320", item.count)
                end
                local width = this.data.startBattleNumTextComponent.preferredWidth + 5
                local sizeDelta = this.data.startBattleNumTransform.sizeDelta
                sizeDelta.x = width + 15
                this.data.startBattleNumTransform.sizeDelta = sizeDelta
                this.vm.data.isStartBattleNum = true
            end
        end
    end
    if this.vm.data.isSupportDelegateBattle then
        this.vm.data.startBattleSize = Vector2(166, 60)
        this.vm.data.startBattlePos = Vector2(50, -299)
        this.vm.data.startBattleTextPos = Vector3(40, 6, 0)
    else
        this.vm.data.startBattleSize = Vector2(280, 60)
        this.vm.data.startBattlePos = Vector2(-7, -299)
        this.vm.data.startBattleTextPos = Vector3(5, 6, 0)
    end
end


this.SetEnemys = function()
    local enemyListData = {} 
    this.UpdateMonsterIdList()
    for i, v in ipairs(monsterConfigTable) do
        local monster = ConfigMgr.Config.monsterMap[v]
        if monster ~= nil and not monster.hideShowinfo then
            local enemyData = {
                icon = LuaMgr.GetTexture("Assets/_BundleResources/Character/" .. monster.monsterModel .. "/Avatar/" .. monster.monsterSkin .. ".png"),
                border = LuaMgr.GetSprite("CommonRes", monster.type == 2 and "ui_ty_txk_guaiwu_hong" or "ui_ty_txk_guaiwu_bai"),
                isShow = false
            }
            if monster.type == 0 then
                enemyData.isType = false
            elseif monster.type == 1 then
                enemyData.type = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_zj")
                enemyData.isType = true
            elseif monster.type == 2 then
                enemyData.type = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_boss")
                enemyData.isType = true
            elseif monster.type == 3 then
                enemyData.type = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_jy")
                enemyData.isType = true
            end
            table.insert(enemyListData, enemyData)
            if #enemyListData >= 3 then
                break
            end
        end
    end
    this.vm.data.enemyDatas = enemyListData
    if #enemyListData > 0 then
        enemyIndex = 1

        LuaMgr.AddTimer(TimerConst.BattlePrepareEnemyDelay, this.OnEnemyDelay, 0.1, -1, false)
    end
end

this.OnEnemyDelay = function()
    if enemyIndex <= #this.vm.data.enemyDatas then
        this.vm.data.enemyDatas[enemyIndex].isShow = true
        enemyIndex = enemyIndex + 1
        if enemyIndex > #this.vm.data.enemyDatas then
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareEnemyDelay)
        end
    end
end


this.AddItem = function(str, limit, isFirst, isFixed, isRate, rateIcon, isReceived, scale, isClick, list, isVisiable)
    if str ~= nil and str ~= "" then
        local strs = NumTool.split(str, ';')
        local len = #strs
        if limit > 0 then
            len = len > limit and limit or len
        end
        if rateIcon == nil then
            rateIcon = LuaMgr.GetDefaultSprite()
        end
        local rewardItems = {};
        for i = 1, len do
            rewardItems[i] = ConfigMgr.Config.itemMap[strs[i]];
        end
        table.sort(rewardItems, this.RewardItemSort);
        for i = 1, len do
            local rewardItem = rewardItems[i];
            local goods = {
                id = rewardItem.id,
                count = 0,
                rare = ActivityMgr.GetRareSprite(rewardItem.rare),
                icon = ActivityMgr.GetItemTexture(rewardItem.id),
                showType = ItemShowType.NONE,
                sizeDelta = Vector2(128 * scale,128 * scale),
                scale = Vector3(scale, scale, 1),
                isClick = isClick,
                isFirst = isFirst,
                isFixed = isFixed,
                isRate = isRate,
                rateIcon = rateIcon,
                isReceived = isReceived,
                isShow = false,
                isVisiable = isVisiable
            }
            table.insert(list, goods)
        end
    end
    return list
end


this.RewardItemSort = function(a, b)
    return a.rare > b.rare;
end

this.SetRewards = function()
    this.vm.data.itemDatas={};

    if PlayerAreaMgr.IsAreaModelNovel() then
        this.vm.data.novelTipText=ConfigMgr.LangGlobal("23681");
        this.vm.data.novelTipBool=true;
        return;
    end
    this.vm.data.novelTipBool=false;
    local rewardItemList = {}
    local dungeonRecord = DataMgr.Player.dungeonRecords[eventData.eventParam]
    local completed = dungeonRecord ~= nil and not IsNullOrEmpty(dungeonRecord.historyRating)
    if not completed and dungeonConfig.firstDropShow ~= nil and dungeonConfig.firstDropShow ~= "" then
        rewardItemList = this.AddItem(dungeonConfig.firstDropShow, MaxItemCount, true, false,
                false, nil, false, 0.55, false, rewardItemList, false)
    else
        local count = MaxItemCount - #rewardItemList
        if count > 0 then
            if dungeonConfig.fixedDropShow ~= nil and dungeonConfig.fixedDropShow ~= "" then
                rewardItemList = this.AddItem(dungeonConfig.fixedDropShow, count, false, true,
                        false, nil, false, 0.55, false, rewardItemList, false)
            end
        end

        count = MaxItemCount - #rewardItemList
        if count > 0 then
            if dungeonConfig.extraDropShow ~= nil and dungeonConfig.extraDropShow ~= "" then
                rewardItemList = this.AddItem(dungeonConfig.extraDropShow, count, false, false,
                        true, nil, false, 0.55, false, rewardItemList, false)
            end
        end

        if #rewardItemList == 0 and completed and dungeonConfig.firstDropShow ~= nil and dungeonConfig.firstDropShow ~= "" then
            rewardItemList = this.AddItem(dungeonConfig.firstDropShow, MaxItemCount, false, false,
                    false, nil, true, 0.55, false, rewardItemList, false)
        end
    end
    this.vm.data.itemDatas = rewardItemList
    if #rewardItemList > 0 then
        itemsIndex = 1
        LuaMgr.AddTimer(TimerConst.BattlePrepareItemsDelay, this.OnItemsDelay, 0.1);
    end

    local params = BattlePrepareMgr._enterDungeonParams
    local isActive = true
    if (not IsNull(params)) and not IsNull(params.extraParams) then
        for _, v in ipairs(params.extraParams) do
            if tostring(v) == "event_boss" then
                isActive = false
                break
            end
        end
    end
    this.data.reward_obj:SetActive(isActive)

end

this.SetOpenStrategyUrlBtnStatus = function()
    this.vm.data.openStrategyUrlBtnActive = dungeonConfig.bLineupTime ~= 0 and LuaMgr.Timestamp() - dungeonConfig.bLineupTime >= 0
end

this.OnItemsDelay = function()
    if itemsIndex <= #this.vm.data.itemDatas then
        this.vm.data.itemDatas[itemsIndex].isShow = true
        itemsIndex = itemsIndex + 1
        if itemsIndex > #this.vm.data.itemDatas then
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareItemsDelay)
        end
    end
end

this.GetBattleTurnEnd = function()
    local strs = NumTool.split(dungeonConfig.battleTurnEnd, ';')
    if (strs ~= nil and #strs == 2) then
        battleTurnEnd = tonumber(strs[2])
    end
    if BattlePrepareMgr._enterDungeonParams.battleTurnEnd ~= nil and tonumber(BattlePrepareMgr._enterDungeonParams.battleTurnEnd) > 0 then
        battleTurnEnd = tonumber(BattlePrepareMgr._enterDungeonParams.battleTurnEnd)
    end
end


this.SetConditions = function(str)
    if conditionStatus == "1" and battleTurnEnd > 0 then
        str = str .. "1_" .. string.format(LuaMgr.GetLangText('LangGlobalLan_LangGlobal_name_5068'),battleTurnEnd)
    end
    local conditionList = {}
    local strs = NumTool.split(str, ';')
    for i, item in ipairs(strs) do
        if IsNullOrEmpty(item) then
            break
        end
        local temps = NumTool.split(item, '_')
        if temps[1] == conditionStatus then
            local conditionData = {
                isAnimator = false,
                isShow = not isConditionAni,
                content = temps[2],
                bgRes = LuaMgr.GetSprite("AreaMapRes", conditionStatus == "0" and "ui_zqzb_tjdi01" or "ui_zqzb_tjdi02")
            }
            table.insert(conditionList, conditionData)
        end
    end
    this.vm.data.conditionDatas = conditionList
    if isConditionAni then
        isConditionAni = false
        conditionIndex = 1
        LuaMgr.AddTimer(TimerConst.BattlePrepareCondition, this.OnCondition, 0.1)
    end
end


this.OnCondition = function()
    if conditionIndex <= #this.vm.data.conditionDatas then
        this.vm.data.conditionDatas[conditionIndex].isAnimator = true
        this.vm.data.conditionDatas[conditionIndex].isShow = true
        conditionIndex = conditionIndex + 1
        if conditionIndex > #this.vm.data.conditionDatas then
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareCondition)
        end
    end
end


this.DelayCharacters = function(isDelay)
    this.vm.data.isCharacters = true
    this.vm.data.isRewardDetails = false
    this.vm.data.groupSize = Vector2(926 + addWidth, 452)
    this.SetAssistInfo();
    this.ClearCharacters()
    if isDelay then
        isDelayCharacters = true
        LuaMgr.AddTimer(TimerConst.BattlePrepareCharacters, this.OnCharacters, 0.5, 1)
    else
        this.OnCharacters()
    end
end

this.OnCharacters = function()
    LuaMgr.RemoveTimer(TimerConst.BattlePrepareCharacters)
    isCharacterAni = true
    this.SetCharacters()
    characterIndex = 1
    LuaMgr.AddTimer(TimerConst.BattlePrepareCharacterDelay, this.OnCharacterDelay, 0.05, -1, true)
end

this.OnCharactersWithoutAnim = function()
    isCharacterAni = false
    this.SetCharacters()
end

this.OnCharacterDelay = function()
    if characterIndex <= #this.vm.data.characterItems then
        this.vm.data.characterItems[characterIndex].isShow = true
        characterIndex = characterIndex + 1
        if characterIndex > #this.vm.data.characterItems then
            isDelayCharacters = false
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareCharacterDelay)
        end
    end
end


this.SetCharacters = function()
    local isDrag, isSwap, isLimit, isLock, isActor
    local level = 0
    local zz = 0
    local cname = ""
    local pos = Vector3(-CharacterItemSize * MaxCharacterCount * 0.5 - CharacterItemSize * 0.5, 0, 0)
    local tempCharacterItems = {}
    local memberDic=BattlePrepareMgr.memberDic;
    if BattlePrepareMgr.isLeveling then
        memberDic=BattlePrepareMgr.MoreModCheckmemberDic();
    end
    for i = 1, MaxCharacterCount do
        local item = {
            itemId = "CharacterItem_" .. i,
            isAnimator = isCharacterAni,
            isGroup = false,
        }
        local member = memberDic[tostring(i - 1)]
        if member == nil then
            member = ""
        end
        item.isShow = IsNullOrEmpty(member) or not isCharacterAni
        local actor = nil
        isActor = false
        if dungeonConfig.fightType == 2 then
            this.vm.data.isFormationLock = true
            this.vm.data.isFormationText = false
            isDrag = false
            isSwap = false
            isLimit = i > dungeonConfig.outRoleNum
            isLock = not IsNullOrEmpty(member)
            if isLimit then
                isLock = false
            else
                isLock = isLock
            end
            actor = ConfigMgr.Config.actor[member]
            if actor ~= nil then
                member = actor.CharacterId
                level = actor.Level
                zz = actor.CharactRank > 0 and actor.CharactRank or -1
                isActor = true
            end
        elseif dungeonConfig.fightType == 3 then
            this.vm.data.isFormationLock = true
            this.vm.data.isFormationText = false
            isLimit = i > dungeonConfig.outRoleNum
            actor = ConfigMgr.Config.actor[member]
            if actor ~= nil then
                isLock = not IsNullOrEmpty(member)
                if isLimit then
                    isLock = false
                else
                    isLock = isLock
                end
                isDrag = false
                isSwap = false
                member = actor.CharacterId
                level = actor.Level
                zz = actor.CharactRank > 0 and actor.CharactRank or -1
                isActor = true
            else
                isLock = false
                if isLimit then
                    isLock = false
                else
                    isLock = isLock
                end
                isDrag = not IsNullOrEmpty(member)
                isSwap = true
                level = HeroManager.GetCharacterLevel(member)
                zz = HeroManager.GetCharacterZZ(member)
            end
        else
            this.vm.data.isFormationLock = false
            this.vm.data.isFormationText = true
            isSwap = true
            isLimit = i > dungeonConfig.outRoleNum
            if isLimit then
                isDrag = false
            else
                isDrag = not IsNullOrEmpty(member)
            end
            isLock = false
            level = HeroManager.GetCharacterLevel(member)
            zz = HeroManager.GetCharacterZZ(member)
        end
        item.id = tostring(i - 1)
        item.characterId = member
        item.drag = isDrag
        item.swap = isSwap
        if not IsNullOrEmpty(member) then
            local path
            item.isShowLevel = true
            item.isShowZZ = true
            item.level = tostring(level)
            local curRare = HeroMgr.GetHeroNowRare(member)
            local imageRare = curRare >= 5 and 4 or curRare
            if isActor and actor ~= nil then
                if tonumber(actor.SkinType) == 1 and not IsNullOrEmpty(actor.SkinParam) then
                    path = HeroManager.GetCharacterCard(member, actor.SkinParam)
                elseif tonumber(actor.SkinType) == 2 then
                    local curSkinId=nil;
                    local data_playerSkin = DataMgr.Player.playerSkins;
                    for i,v in pairs(data_playerSkin) do
                        if v then
                            curSkinId=i;
                            break;
                        end
                    end
                    if curSkinId==nil then
                        curSkinId=DataMgr.Player.sex>1 and "SCJ202" or "SCJ201";
                    end
                    path = HeroManager.GetCharacterCard(curSkinId)
                    local playerSkinCfg = ConfigMgr.Config.playerSkinMap[curSkinId]
                    if playerSkinCfg ~= nil then
                        cname = LuaMgr.GetLangText(playerSkinCfg.PlayerCardNameLan)
                    end
                    item.isShowZZ = false
                else
                    path = HeroManager.GetCharacterCard(member, member .. "001")
                end
            else
                local curSkin=nil;
                if PlayerAssistMgr.IsAssistMember(member) then
                    local uid=PlayerAssistMgr.GetAssistMemberUid(member)
                    local assistData=PlayerAssistMgr.GetAssist_Character(uid,member);
                    if assistData~=nil then
                       curSkin=assistData.curSkin;
                    end
                end
                path = HeroManager.GetCharacterCard(member,curSkin);
            end
            local characterConfig = ConfigMgr.Config.characterTable[member]
            local brilliantCfg = nil
            if characterConfig ~= nil then
                item.showRare = true
                item.cname = LuaMgr.GetLangText(characterConfig.namelan)
                item.zyIcon = LuaMgr.GetSprite("JobIcon", "job_" .. characterConfig.job)
                item.showZy = true
                brilliantCfg = ConfigMgr.Config.BrilliantMap[member..characterConfig.rare]
                if isActor and actor ~= nil then
                    curRare = characterConfig.rare + actor.RareLevel
                    imageRare = curRare >= 5 and 4 or curRare
                end






            else
                item.showRare = false
                item.showZy = false
                item.cname = cname
            end

            if BattlePrepareMgr.isLeveling  then
                item.isLeveling=true
                local lanID=""
                local tip=""
                local battleCount=BattlePrepareMgr.MoreModGetCharacterBattleCount(member)
                if battleCount==0 then
                    lanID="2700"
                    tip=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal[lanID].NameLan)
                    item.levelingText=tip;
                else
                    lanID="2701"
                    tip=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal[lanID].NameLan)
                    item.levelingText=string.format(tip,battleCount);
                end
                item.level = tostring(BattlePrepareMgr.levelingData.characterDataMap[member].level)
                zz = BattlePrepareMgr.levelingData.characterDataMap[member].star
                imageRare = characterConfig.rare
                brilliantCfg = nil
            elseif BattlePrepareMgr.isRogue then
                local rogueData=RogueMgr.GetCharacterDataByID(member)
                if rogueData~=nil  then
                    item.level=tostring(rogueData.level);
                    zz=rogueData.star>0 and rogueData.star or -1;
                    local rare = characterConfig.rare
                    if not IsNull(rogueData.brilliant) then
                        rare = rare + rogueData.brilliant.RareLevel
                    end
                    curRare=rare;
                    imageRare = rare >= 5 and 4 or rare
                    path = HeroManager.GetCharacterCard(member, rogueData.curSkin)
                end
            else
                item.isLeveling=false

                if PlayerAssistMgr.IsAssistMember(member) then
                    local uid=PlayerAssistMgr.GetAssistMemberUid(member);
                    local assistCharacter=PlayerAssistMgr.GetAssist_Character(uid,member)
                    if assistCharacter~=nil then
                        item.level=tostring(assistCharacter.level);
                        zz=assistCharacter.star>0 and assistCharacter.star or -1;
                        curRare = HeroMgr.GetHeroNowRare(member,uid)
                        imageRare = curRare >= 5 and 4 or curRare
                    end
                end
            end
            item.body = LuaMgr.GetTexture(path)
            item.zzBg = LuaMgr.GetSprite("CommonRes", zz > 0 and "ui_ty_kp_zz1" or "ui_ty_kp_zz2")
            item.zzLevel = string.format("<color=#%s>%s</color>", zz > 0 and "262429" or "aca9a3",
                    HeroManager.GetNumStr(math.abs(zz)))
            item.isGroup =  true
            item.hzActive = not IsNull(brilliantCfg) and curRare > 4
            item.hzNotActive = not IsNull(brilliantCfg) and curRare <= 4
            item.rare = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_"..imageRare)
        end
        item.isLimit = isLimit
        item.isLock = isLock
        item.isSwap = false
        item.isLight = false
        pos = Vector3(pos.x + CharacterItemSize, 0, 0)
        item.itemPosition = pos
        item.isAssist=not BattlePrepareMgr.isLeveling and PlayerAssistMgr.IsAssistMember(member)
        table.insert(tempCharacterItems, item)
    end
    this.vm.data.characterItems = tempCharacterItems
    tempTeam = {}
    for i = 1, #this.vm.data.characterItems do
        if this.vm.data.characterItems[i].characterId ~= "" then
            table.insert(tempTeam,this.vm.data.characterItems[i].characterId)
        end
    end
    isCharacterAni = false

    LuaMgr.AddTimer(TimerConst.BattlePrepareGetItem, function()
        if this.data.characterItemTrList == nil then
            this.data.characterListTransform = this.vm.behaviour.transform:Find("root/Middle/Group/Characters/offpos/List")
            if  this.data.characterListTransform.childCount < MaxCharacterCount then
                return
            end

            this.data.characterItemTrList = {}
            for i = 1, MaxCharacterCount do
                local itemTr =  this.data.characterListTransform:GetChild(i - 1)
                itemTr:GetComponent("OnDragEvent"):SetData(i, this.OnDown, this.OnDrag, this.OnEnd)
                itemTr.transform.localPosition = this.vm.data.characterItems[i].itemPosition
                table.insert(this.data.characterItemTrList, itemTr)
            end
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareGetItem)
        end
    end, 0.2, -1, false)
end


this.ClearCharacters = function()
    for i = 1, #this.vm.data.characterItems do
        this.vm.data.characterItems[i].characterId = ""
        this.vm.data.characterItems[i].isLimit = false
        this.vm.data.characterItems[i].isLock = false
        this.vm.data.characterItems[i].isGroup = false
        this.vm.data.characterItems[i].isSwap = false
        this.vm.data.characterItems[i].isLight = false
    end
end


this.SetRewardDetails = function()
    this.ClearCharacters()
    this.vm.data.isCharacters = false
    this.vm.data.isRewardDetails = true
    this.vm.data.groupSize = Vector2(926 + addWidth, 542)
    
    local tempRewardItems = {}
    if not IsNullOrEmpty(dungeonConfig.firstDropShow) then
        local item = {
            text = LuaMgr.GetLangText("BattlePrepareViewModel_11"),
            isShow = false,
            isShowTips = false
        }
        local dungeonRecord = DataMgr.Player.dungeonRecords[eventData.eventParam]
        local completed = dungeonRecord ~= nil and not IsNullOrEmpty(dungeonRecord.historyRating)
        item.itemDatas = this.AddItem(dungeonConfig.firstDropShow, 0, false, 
                false, false, nil, completed, 0.76, true, {}, false)
        local count = math.ceil(#item.itemDatas / 6)
        item.itemSizeDelta = Vector2(this.data.rewardItemRect.sizeDelta.x + addWidth, 100 * count + 20)
        item.listSizeDelta = Vector2( this.data.rewardListRect.sizeDelta.x, 100 * count)
        item.listAnchoredPos = Vector2( this.data.rewardListRect.anchoredPosition.x, ( this.data.rewardListRect.sizeDelta.y - this.data.rewardItemRect.sizeDelta.y) * 0.5)
        for i = 1, #item.itemDatas do
            item.itemDatas[i].isShow = true
        end
        table.insert(tempRewardItems, item)
    end
    if not IsNullOrEmpty(dungeonConfig.fixedDropShow) then
        local item = {
            text = LuaMgr.GetLangText("BattlePrepareViewModel_12"),
            isShow = false,
            isShowTips = false
        }
        local dungeonRecord = DataMgr.Player.dungeonRecords[eventData.eventParam]
        local completed = dungeonRecord ~= nil and not IsNullOrEmpty(dungeonRecord.historyRating)
        item.itemDatas = this.AddItem(dungeonConfig.fixedDropShow, 0, false,
                false, false, nil, false, 0.76, true, {}, false)
        local count = math.ceil(#item.itemDatas / 6)
        item.itemSizeDelta = Vector2(this.data.rewardItemRect.sizeDelta.x + addWidth, 100 * count + 20)
        item.listSizeDelta = Vector2( this.data.rewardListRect.sizeDelta.x, 100 * count)
        item.listAnchoredPos = Vector2( this.data.rewardListRect.anchoredPosition.x, ( this.data.rewardListRect.sizeDelta.y - this.data.rewardItemRect.sizeDelta.y) * 0.5)
        for i = 1, #item.itemDatas do
            item.itemDatas[i].isShow = true
        end
        table.insert(tempRewardItems, item)
    end

    if not IsNullOrEmpty(dungeonConfig.secondDropShow)  then
        local item = {
            text = LuaMgr.GetLangText("BattlePrepareViewModel_13"),
            isShow = false,
            isShowTips = false
        }
        local itemDataList = {}
        local secondDropShow=dungeonConfig.secondDropShow;
        local isWeekEquip,weaponStr=BattlePrepareMgr.AreaDailyWeekEquip(dungeonConfig.id)
        if isWeekEquip then
            secondDropShow=weaponStr;
        end
        itemDataList = this.AddItem(secondDropShow, 0, false,
                    false, false, nil, false, 0.76, true, itemDataList, false)
        item.itemDatas = itemDataList
        local count = math.ceil(#item.itemDatas / 6)
        item.itemSizeDelta = Vector2(this.data.rewardItemRect.sizeDelta.x + addWidth, 100 * count + 20)
        item.listSizeDelta = Vector2( this.data.rewardListRect.sizeDelta.x, 100 * count)
        item.listAnchoredPos = Vector2( this.data.rewardListRect.anchoredPosition.x, ( this.data.rewardListRect.sizeDelta.y - this.data.rewardItemRect.sizeDelta.y) * 0.5)
        for i = 1, #item.itemDatas do
            item.itemDatas[i].isShow = true
        end
        table.insert(tempRewardItems, item)
    end
    this.vm.data.rewardItems = tempRewardItems
    rewardDetailsIndex = 1
    rewardDetailsCount = #this.vm.data.rewardItems
    LuaMgr.AddTimer(TimerConst.BattlePrepareRewardDetailsDelay, this.OnRewardDetailsDelay, 0.1, -1, true)
end

this.OnRewardDetailsDelay = function()
    if rewardDetailsIndex <= rewardDetailsCount then
        this.vm.data.rewardItems[rewardDetailsIndex].isShow = true
        rewardDetailsIndex = rewardDetailsIndex + 1
        if rewardDetailsIndex > #this.vm.data.rewardItems then
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareRewardDetailsDelay)
        end
    end
end


this.SetFormationList = function()

    local isLock,teamId=BattlePrepareMgr.NeedLockFormation();
    if BattlePrepareMgr.IsMoreMod() or isLock or BattlePrepareMgr.isRogue then
        this.vm.data.formationBool=false;
    else
        this.vm.data.formationBool=true;
    end
    local tempList = {}
    local count = ConfigMgr.Config.constants.maxSquadCount
    for i = 0, count - 1 do
        local team = DataMgr.Player.teams[tostring(i)]
        local teamName = LuaMgr.GetLangText("BattlePrepareViewModel_14") .. (i + 1)
        if team ~= nil and team.name ~= "" then
            teamName= team.name
        end
        local formationData = {
            text = teamName,
            isShow = false
        }
        table.insert(tempList, formationData)
    end
    this.vm.data.formationDatas = tempList
end


this.SelectFormationWithOutParam = function()
    this.HideFormations()
    local team
    BattlePrepareMgr.formationId = ""
    BattlePrepareMgr.memberDic = {}
    teamFormationId = nil
    if dungeonConfig.fightType == 2 or dungeonConfig.fightType == 3 then
        local memberHS = {}
        for i, v in ipairs(dungeonConfig.limitOutRole) do
            local actor = ConfigMgr.Config.actor[v]
            if actor ~= nil then
                BattlePrepareMgr.memberDic[tostring(i - 1)] = actor.ID
                memberHS[actor.CharacterId] = true
            end
        end
        local index = #BattlePrepareMgr.GetMemberList()
        local num = dungeonConfig.outRoleNum - index
        if num > 0 then
            local teamId = this.GetTeamId()
            BattlePrepareMgr.formationId=teamId;
            if BattlePrepareMgr.IsMoreMod() then
                team = DataMgr.Player.teamsMoreMod["0"]
                teamFormationId = "0"
            else
                team = DataMgr.Player.teams[teamId]
                teamFormationId = teamId
            end

            if team ~= nil then
                local members = team.members
                for i = 0, dungeonConfig.outRoleNum do
                    local member = members[tostring(i)]
                    if #BattlePrepareMgr.GetMemberList() >= dungeonConfig.outRoleNum then
                        break
                    end
                    if not memberHS[member] then
                        BattlePrepareMgr.memberDic[tostring(index)] = BattlePrepareMgr.CheckMemberInvalid(member)
                        index = index + 1
                    end
                end
            end
        end
        this.vm.data.isFormationLock = true
        this.vm.data.isFormationText = false
        this.vm.data.quickText = LuaMgr.GetLangText("BattlePrepareViewModel_15")
        isQuickLock = true
        isSaveTeam = false
        return
    end
    this.vm.data.isFormationLock = false
    this.vm.data.isFormationText = true
    this.vm.data.quickText = LuaMgr.GetLangText("BattlePrepareViewModel_16")
    isQuickLock = false
    isSaveTeam = true
    this.vm.data.formationScale = Vector3.one
    BattlePrepareMgr.formationId = this.GetTeamId()
    if BattlePrepareMgr.IsMoreMod() then
        team = DataMgr.Player.teamsMoreMod["0"]
    elseif BattlePrepareMgr.isRogue then
        team=RogueExploreMgr.GetTeams();
    else
        team = DataMgr.Player.teams[BattlePrepareMgr.formationId]
    end
    if team ~= nil then
        this.SetFormationName()
        for k, v in pairs(team.members) do
            BattlePrepareMgr.memberDic[k] = BattlePrepareMgr.CheckMemberInvalid(v)
        end
    end
end


this.SetFetters = function()
    if BattlePrepareMgr.IsMoreMod() or this.actorCount >= dungeonConfig.outRoleNum then
        this.vm.data.fettersGroupActive = false
        return
    end
    
    local tempList = {}
    local fetterIndex = 0

    if not IsNull(DataMgr.Player.selectedRelicsTalent) and next(DataMgr.Player.selectedRelicsTalent) then
        for k, v in pairs(DataMgr.Player.selectedRelicsTalent) do
            fetterIndex = fetterIndex + 1
            if fetterIndex <= 6 then
                local fettersCfg = ConfigMgr.Config.OriginsTalentMap[k]
                local talentIdList = fettersCfg.TalentId
                local tempItem = {
                    fettersId = k,
                    order = fettersCfg.OtOrder,
                    showIcon = DataMgr.Player.selectedRelicsTalent[k] ~= nil
                }
                
                if tempItem.showIcon and talentIdList ~= nil and #talentIdList > 0 and talentIdList[1] ~= nil then
                    local talentCfg = ConfigMgr.Config.talentBankMap[talentIdList[1]]
                    tempItem["talentIcon"] = LuaMgr.GetSprite("AttributeIcon",talentCfg.showTypeIcon)
                end
    
                table.insert(tempList, tempItem)
            end
        end
        table.sort(tempList, function(a, b)
            if a.showIcon ~= b.showIcon then
                return a.showIcon
            end
            return a.order < b.order
        end)
    end

    local unLockTalentCount = 0
    if DataMgr.Player.originsTalent ~= nil then
        for k, v in pairs(DataMgr.Player.originsTalent) do
            unLockTalentCount = unLockTalentCount + 1
        end
    end
    for i = #tempList + 1, unLockTalentCount do
        if i > 6 then
            break
        end
        table.insert(tempList, {
            fettersId = "",
            order = 0,
            showIcon = false
        })
    end
    this.vm.data.fettersGroupActive = true
    this.vm.data.fettersList = tempList
end


this.SetGlobalSkills = function()
    local globalSkillsList = {}
    local globalGroup = dungeonConfig.globalSkillGroup
    local globalCnts = NumTool.split(dungeonConfig.globalSkillUsageCount, ',')
    local skillIndex = 1
    local globalSkills = ConfigMgr.Config.GlobalSkills
    for _,item in pairs(globalSkills) do
        if item.GlobalSkillGroupId == globalGroup then
local skillID = item.GroupId
            if skillIndex <= #globalCnts then
                local usageCnt = tonumber(globalCnts[skillIndex])
                local realCnt = 0
                if item.UsageCountCondition == "Dungeon" then
                    realCnt = usageCnt
                elseif item.UsageCountCondition == "Skill" then
                    local characterSkillMap = ConfigMgr.Config.characterSkillMap;
                    for _,skill in pairs(characterSkillMap) do
                        if skill.GroupId == item.GroupId then
                            for _,attr in pairs(skill.Attr) do
                                local start_i, end_j, substr = string.find(attr, "UsageCount")
                                if substr ~= nil then 
                                    local attrStrs = NumTool.split(string.sub(attr, 2, #attr - 1), ',')
                                    if attrStrs ~= nil and #attrStrs >= 3 then
                                        realCnt = tonumber(attrStrs[2])
                                    end
                                end
                            end
                        end
                    end
                elseif item.UsageCountCondition == "Item" then

                end

                print("globalskill ", skillIndex, skillID, realCnt)
                local tempItem = {
                    skillId = skillID,
                    count = tostring(realCnt),
                    icon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(string.gsub(skillID, "ex", ""))),
                    avaliable = realCnt > 0,
                    disable = realCnt < 1,
                }
                table.insert(globalSkillsList, tempItem)
                skillIndex = skillIndex + 1
            end
        end
    end

    if next(globalSkillsList) then 
        this.vm.data.globalSkillBtnActive = true
        this.vm.data.globalSkillMarkScale = Vector3.one
    else
        this.vm.data.globalSkillBtnActive = false
        this.vm.data.globalSkillMarkScale = Vector3(1, -1, 1)
    end
    this.vm.data.globalSkillList = globalSkillsList

end

this.SetGlobalSkillsVislble= function(visible)
    this.vm.data.globalSkillsActive = visible
    this.vm.data.globalSkillMarkScale = visible and Vector3(1, -1, 1) or Vector3.one
    if visible then
        LuaMgr.AddUpdate(this.UpdateHandler)
    else
        LuaMgr.RemoveUpdate(this.UpdateHandler)
    end
end

this.SetFormation = function()
    this.SetFormationName()
    if dungeonConfig.fightType == 2 or dungeonConfig.fightType == 3 then
        this.vm.data.isFormationLock = true
        this.vm.data.isFormationText = false
        this.vm.data.quickText = LuaMgr.GetLangText("BattlePrepareViewModel_15")
        isQuickLock = true
        isSaveTeam = false
        return
    end
    this.vm.data.isFormationLock = false
    this.vm.data.isFormationText = true
    this.vm.data.quickText = LuaMgr.GetLangText("BattlePrepareViewModel_16")
    isQuickLock = false
    isSaveTeam = true
    this.vm.data.formationScale = Vector3.one
end


this.GetTeamId = function()

    local isLock,teamId=BattlePrepareMgr.NeedLockFormation();
    if isLock then
        return teamId;
    end

    if not IsNullOrEmpty(DataMgr.Player.lastTeamID) then
        return DataMgr.Player.lastTeamID;
    end
    local teamId = ""
    local teams = DataMgr.Player.teams
    local index = 0
    for i, v in pairs(teams) do
        teamId = tostring(index)
        if teams[teamId] ~= nil then
            return teamId
        end
        index = index + 1
    end
    return "0"
end


this.SelectFormation = function(id)
    BattlePrepareMgr.formationId = tostring(id)
    this.SetFormationName()
    BattlePrepareMgr.memberDic = {}
    actorList = {}
    this.vm.data.formationScale = Vector3.one
    local teams = DataMgr.Player.teams
    local team = teams[BattlePrepareMgr.formationId]
    if team ~= nil then
        for k, item in pairs(team.members) do
            BattlePrepareMgr.memberDic[k] = BattlePrepareMgr.CheckMemberInvalid(item)
        end
    end
    this.SetTeamWeaponSkill()
end


this.SetFormationName = function()
    local id = tonumber(BattlePrepareMgr.formationId)
    if not IsNullOrEmpty(id) then
        this.vm.data.formationText = this.vm.data.formationDatas[id + 1].text
    end
end


this.HideFormations = function()
    this.vm.data.isFormations = false
    this.vm.data.showEditTeamNameMask = false
    for i, item in ipairs(this.vm.data.formationDatas) do
        item.isShow = false
    end
end


this.ChangeMemberPos = function()
    local dragItem = this.vm.data.characterItems[dragIndex]
    local selectItem = this.vm.data.characterItems[selectIndex]
    if selectItem == nil or IsNullOrEmpty(selectItem.characterId) then
        return
    end

    local dragId = BattlePrepareMgr.memberDic[dragItem.id]
    local selectId = BattlePrepareMgr.memberDic[selectItem.id]
    BattlePrepareMgr.memberDic[dragItem.id] = nil
    BattlePrepareMgr.memberDic[selectItem.id] = nil
    if selectId ~= nil and selectId ~= "" then
        BattlePrepareMgr.memberDic[dragItem.id] = selectId
    end

    if dragId ~= nil and dragId ~= "" then
        BattlePrepareMgr.memberDic[selectItem.id] = dragId
    end
    this.SetCharacters()
end


this.SaveTeamMembers = function()
    if not isSaveTeam or IsNullOrEmpty(BattlePrepareMgr.formationId) then
        return false
    end
    local teamId = nil
    local battleType = nil
    local tempHelps={}
    if BattlePrepareMgr.IsMoreMod() then
        teamId = "0"
        battleType = "moreMod"
    else
        teamId = BattlePrepareMgr.formationId
    end
    local members= BattlePrepareMgr.memberDic;
    if BattlePrepareMgr.isLeveling then
        members=BattlePrepareMgr.MoreModCheckmemberDic();
    else
        tempHelps=this.GetMemberHelps(members);
    end
    local param = {
        battleType = battleType,
        teamId = teamId,
        members = members,
        helps=tempHelps
        
    }
    BattlePrepareMgr.CheckAndSaveTeam(param, this.SaveTeamResponse)
    return true
end

this.GetMemberHelps=function(members)
    local helps={}
    for i,v in pairs(members) do 
        local uid=PlayerAssistMgr.GetAssistMemberUid(v);
        helps[i]=uid~=nil and uid or ""; 
    end
    return helps;
end



this.SaveTeamResponse = function(result)
    if saveTeamAction ~= nil then
        saveTeamAction()
        saveTeamAction = nil
    end
end

this.SaveTeamNameResponse = function(result)
    this.vm.data.showEditTeamNamePopup = false
    this.data.curEditTeamIndex = ""
    this.SetFormationList()
    this.SetFormationName()
    this.OnClickFormation()
end

this.SetChallengeDetails = function()
    local tempChallengeDatas = {}
    local list = ConfigMgr.Config.levelChallenges[eventData.eventParam]
    if list == nil then
        return
    end

    for k, item in pairs(list) do
        local config = ConfigMgr.Config.challengesMap[item]
        if config ~= nil and #config.rewardShow > 0 then
            local itemData = config.rewardShow[1]
            local itemConfig = ConfigMgr.Config.itemMap[itemData.id]
            if itemConfig ~= nil then
                local challengeData = {
                    icon = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/ItemIcons/itemicon_%s.png", itemConfig.id)),
                    count = tostring(itemData.count)
                }
                local isComplete = DataMgr.Player.completedTags[item] ~= nil
                local challengeContent;
                if not isComplete and config.hideDes then
                    challengeContent = LuaMgr.GetLangText("BattlePrepareViewModel_18")
                else
                    challengeContent = LuaMgr.GetLangText(config.desLan)
                end
                if challengeContent:find("{", 1, true) ~= nil then
                    challengeContent = LuaMgr.FindAndReplace(challengeContent,"{","");
                end
                if challengeContent:find("}", 1, true) ~= nil then
                    challengeContent = LuaMgr.FindAndReplace(challengeContent,"}","");
                end
                challengeData.content = challengeContent
                challengeData.isFrame = not isComplete
                challengeData.isReceived = isComplete
                challengeData.alpha = isComplete and 0.5 or 1.0
                table.insert(tempChallengeDatas, challengeData)
            end
        end
    end
    this.vm.data.challengeDatas = tempChallengeDatas
end


this.SetEvaluateDetails = function()
    if IsNullOrEmpty(dungeonConfig.rateShow) then
        this.vm.data.evaluateDetailsText1 = ""
        this.vm.data.evaluateDetailsText2 = ""
        this.vm.data.evaluateDetailsText3 = ""
    else
        local strs = NumTool.split(dungeonConfig.rateShow, ';')
        if #strs >= 3 then
            this.vm.data.evaluateDetailsText1 = strs[1]
            this.vm.data.evaluateDetailsText2 = strs[2]
            this.vm.data.evaluateDetailsText3 = strs[3]
        end
    end
end


this.SetWinLose = function()
    if conditionStatus == "0" then
        this.vm.data.isWin = true
        this.vm.data.isLose = false
        this.vm.data.winColor = colorWin
        this.vm.data.loseColor = colorLose
    else
        this.vm.data.isWin = false
        this.vm.data.isLose = true
        this.vm.data.winColor = colorLose
        this.vm.data.loseColor = colorWin
    end
end


this.UpdateFatigue = function(args)
    this.SetConsume()
    this.SetDungeonLimit()
    this.SetDeletateBattleButtonState()
end

this.UpdateMonsterIdList = function()
    local monsterDicJson = LuaMgr.UpdateMonsterIdList(eventData.eventParam)
    monsterConfigTable = json.decode(monsterDicJson)
end


this.Intersect = function(pos)

    local dragItemTr = this.data.characterItemTrList[dragIndex]
    if dragItemTr == nil then
        return
    end
    local halfSumX = 154 * 0.4
    local halfSumY = 342 * 0.4
    local distX = math.abs(dragItemTr.localPosition.x - pos.x)
    local distY = math.abs(dragItemTr.localPosition.y - pos.y)
    return distX <= halfSumX and distY <= halfSumY
end

this.ApplicationFocus = function(args)
    if (this.vm ~= nil) then
        local hasFocus = args[0];
        if hasFocus and dragIndex ~= nil then

            dragIndex = nil;
            selectIndex = nil;
            this.OnCharactersWithoutAnim();
        end
    end
end

this.CheckIsLeveling=function()
    if BattlePrepareMgr.isLeveling then
        BattlePrepareMgr.MoreModCheckmemberDic(this.vm.behaviour.IsPop)
        this.vm.data.isLeveling=true;
        this.vm.data.offPos=Vector2(0,0);
        cfgRareNumLimit=ConfigMgr.Config.moreModConstants.RareNumLimit;
        this.SetLeveling_HeadList();
    else
        this.vm.data.offPos=Vector2(0,-19);
        this.vm.data.isLeveling=false;
    end
end

function this.is_btn_gallery_bonus_active()

    if this.vm.data.fettersGroupActive == false then
        return false
    end
    

    local config = nil
    local hero_data = nil
    local count = 0
    
    for k, v in pairs(DataMgr.Player.jobExtraAttr) do
        if string.find(k,"_") ~= nil then
            count = count + 1
        end
    end

    return count > 0
end


this.SetLeveling_HeadList=function()

    local roleSheet=BattlePrepareMgr.MoreModRoleSheet();
    this.vm.data.groupSize = Vector2(926 + addWidth,384);
    this.tipsText.text=ConfigMgr.LangGlobal("2721");
    if NumTool.GetLen(roleSheet)==0 then
        this.vm.data.leveling_isFree=true
        return;
    end
    this.vm.data.leveling_isFree=false
    local list={}
    for i,v in pairs(roleSheet) do
        local ch=ConfigMgr.Config.characterTable[i];
        table.insert(list,{id=i,rare=ch.rare,namelan=ch.namelan});
    end
    table.sort(list,function(a, b) 
        return a.rare>b.rare;
    end)
    local dataList={}
    for i,v in ipairs(list) do
        local skinId=nil
        if DataMgr.Player.characters[v.id]~=nil then
            skinId=DataMgr.Player.characters[v.id].curSkin
        end
        if skinId==nil and BattlePrepareMgr.isLeveling and 
                DataMgr.Player.moreModAssist~=nil and 
                DataMgr.Player.moreModAssist[v.id]~=nil then
            skinId=DataMgr.Player.moreModAssist[v.id].character.curSkin;
        end
        local headItem={
            icon = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(v.id,skinId)),
            rare = LuaMgr.GetSprite("AreaMapRes","ui_dzr_tx"..v.rare),
            name = LuaMgr.GetLangText(v.namelan)
        }
        local headData=UIScrollData.GetData(headItemObj,"BattlePrepare_HeadItem",84,100,headItem);
        table.insert(dataList,headData)
    end
    this.levelingGroupScrollView:SetParams(724,110)
    this.levelingGroupScrollView:SetData(dataList,true);
end

this.SetTeamWeaponSkill = function()
    this.curTeamWeaponId = ""
    local formationId = IsNullOrEmpty(teamFormationId) and BattlePrepareMgr.formationId or teamFormationId
    if IsNullOrEmpty(formationId) or FeatureManager.IsLock("33001") or BattlePrepareMgr.IsMoreMod() or
            BattlePrepareMgr.isRogue or formationId == "teamsYX" then
        this.vm.data.teamWeaponBtnActive = false
        return
    end
    local team = DataMgr.Player.teams[formationId]
    if team ~= nil and not IsNullOrEmpty(team.teamWeapon) then
        this.curTeamWeaponId = team.teamWeapon
        local weaponCfg = TeamWeaponMgr.GetTeamWeaponCfg(this.curTeamWeaponId)
        local skillId = weaponCfg.TeamWeaponSkill[1]
        this.vm.data.teamWeaponSkillIcon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(string.gsub(skillId, "ex", "")))
        this.vm.data.teamWeaponSkillIconActive = true
    else
        this.vm.data.teamWeaponSkillIconActive = false
    end
    this.vm.data.teamWeaponBtnActive = true
end



this.UpdateTime = function(staminaRecoverInterval,lastRecoverStaminaTime)
    if LuaMgr.IsPanelOpen(UIName.FatigueReplyViewModel) then
        return
    end
    local pastTime = LuaMgr.Timestamp() - lastRecoverStaminaTime
    if pastTime > staminaRecoverInterval then
        local data = {}
        data.DeviceID = LuaMgr.GetToken()
        ApiMgr.Request("heartbeat",data,true,function(result)
        end,nil,true)
    end
end


this.OnDataChanged = function(args)
    if (this.vm.behaviour.Params == nil) then return end

    local type = args[0];
    if (type == "stamina") then
        this.SetPageInfo()
    end
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)