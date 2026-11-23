

if TrainingDungeonHelper==nil then
    require("ViewModel/TrainingDungeon/TrainingDungeonHelper")
end

local MaxCharacterCount = 8
local CharacterItemSize = 124
local CharacterItemSpacing = 7
local leftBorderX = -3.6
local firstRightBorderX = 0
local secondRightBorderX = 0
local colorWin = UnityEngine.Color(215 / 255, 215 / 255, 214 / 255, 1)
local colorLose = UnityEngine.Color(112 / 255, 108 / 255, 103 / 255, 1)
local assistMember={};

local this = {
    vm=nil,
    data= {
        trainingDungeonGroupId = "",
        trainingDungeonGroupCfg = nil,
dungeonIds = nil,
tempList = nil,
        memberListCount = {0, 0, 0},
        memberLimitCount = {0, 0, 0},
        monsterConfigTables = nil,
        enemyIndex = 1,



        isDelayCharacters = false,
        isCharacterAni = false,
        characterIndex = 1,
        characterItemTrList = {nil, nil, nil},   
        characterListContentTr = nil,
        characterBgListContentTr = nil,
        

        downTime = 0,
        dragIndex = nil,
        dragLocalIndex = nil,
        dragteamIndex = nil,
        clickItem = nil,
        selectIndex = nil,
        originPos = nil,
        offset = Vector2.zero,
        

        curConditionIndex = 1,
        conditionStatus = {"0", "0", "0"},
        
    },

    dungeonCount = 0,
    currentIndex = 1,
    curTeamWeaponId = "",
};

local data = {

    firstEnemyList = {{ icon = DefaultTexture, border = DefaultSprite, type = DefaultSprite, isType = false, isShow = false }},
    secondEnemyList = {{ icon = DefaultTexture, border = DefaultSprite, type = DefaultSprite, isType = false, isShow = false }},
    firstRecommendLevel = "",
    secondRecommendLevel = "",
    

    firstCharacterItems = {{itemId = "", characterId = "", isLimit = false, isLock = false, isGroup = false, isShow = false,
                       isSwap = false, isLight = false,isLeveling=false,levelingText="",isShowZZ = true, isShowLevel = true,isAssistHero=false}},
    secondCharacterItems = {{itemId = "", characterId = "", isLimit = false, isLock = false, isGroup = false, isShow = false,
                            isSwap = false, isLight = false,isLeveling=false,levelingText="",isShowZZ = true, isShowLevel = true,isAssistHero=false}},
    firstCharacterListAnchorPos = Vector2(0, 0),
    secondCharacterListAnchorPos = Vector2(0, 0),
    firstCharacterListSize = Vector2(0, 0),
    secondCharacterListSize = Vector2(0, 0),


    isShowConditionTips = false,
    conditionTipsAnchorPos = Vector2.zero,
    isWin = false,
    winColor = UnityEngine.Color.white,
    isLose = false,
    loseColor = UnityEngine.Color.white,
    conditionDatas = {{ content = "", isAnimator = false, isLose = false, isWin = false }},
    challengeDatas = {{ content = "", isAnimator = false, isGet = false }},
    globalBuffs = {{ content = ""}},
    
    fastBtnTextLineSpacing = 0.84,


isOpenAssist=false;
isAssistType1=false;
isAssistType2_1=false;
    isAssistType2_2=false;
    assistFirstCount="",
    assistSecondCount="",
    assistDailyCount="",


    teamWeaponBtnActive = false,
    teamWeaponSkillIcon = DefaultTexture,
    teamWeaponSkillIconActive = false,
}

local command = {
    enemyCommnad = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = this.currentIndex;
            local monsterConfigTable = this.data.monsterConfigTables[index]
            local dungeonConfig = ConfigMgr.Config.dungeonMap[this.data.dungeonIds[index]]
            if monsterConfigTable == nil or next(monsterConfigTable) == nil then
                return
            end
            LuaMgr.ShowLuaPanel("BattlePrepareEnemyViewModel", dungeonConfig, monsterConfigTable)
        end
    },
    
    enemyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = this.currentIndex;
            if this.data.monsterConfigTables == nil or #this.data.monsterConfigTables < 2 then
                return
            end

            local dungeonConfig = ConfigMgr.Config.dungeonMap[this.data.dungeonIds[index]]
            local monsterConfigTable = this.data.monsterConfigTables[index]
            if monsterConfigTable == nil or next(monsterConfigTable) == nil then
                return
            end
            
            LuaMgr.ShowLuaPanel("BattlePrepareEnemyViewModel", dungeonConfig, monsterConfigTable)
        end
    },
    
    fastCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param) + 1;
            this.OnClickFaskBtn(this.currentIndex)
        end
    },
    
    deleteCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param) + 1;
            this.OnClickDeleteBtn(this.currentIndex)
        end
    },

    titleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

            this.data.curConditionIndex = this.currentIndex
            this.SetWinLose(this.currentIndex)
            this.SetConditions(this.currentIndex)
            this.vm.data.conditionTipsAnchorPos = Vector2(-254.6, -124.3)
            this.vm.data.isShowConditionTips = true
        end
    },
    
    winConditionCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.data.conditionStatus[this.data.curConditionIndex] == "0" then
                return
            end

            this.data.conditionStatus[this.data.curConditionIndex] = "0"
            this.SetWinLose(this.data.curConditionIndex)
            this.SetConditions(this.data.curConditionIndex)
        end
    },
    
    loseConditionCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.data.conditionStatus[this.data.curConditionIndex] == "1" then
                return
            end

            this.data.conditionStatus[this.data.curConditionIndex] = "1"
            this.SetWinLose(this.data.curConditionIndex)
            this.SetConditions(this.data.curConditionIndex)
        end
    },
    
    conditionMaskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.isShowConditionTips = false
        end
    },

    startBattleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnStartBattle()
        end
    },

    continueBattleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnContinueBattle()
        end
    },

    giveupBattleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnGiveUpBattle()
        end
    },

    pageUpCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnPageUp()
        end
    },

    pageDownCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnPageDown()
        end
    },

    teamWeaponCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.TeamWeaponActivityPreparePopup, this.GetTeamWeaponKey(), this.SetTeamWeaponSkillCB)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.data.trainingDungeonGroupId = vm.behaviour.Params[0]
        this.Refresh()
        this.vm.behaviour:UpdateTopBar("", this.OnBack);
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.data.characterItemTrList = {nil, nil, nil}
        LuaMgr.RemoveTimer(TimerConst.TrainingDungeonEnemyDelay)
        LuaMgr.RemoveTimer(TimerConst.TrainingDungeonCharacters)
        LuaMgr.RemoveTimer(TimerConst.TrainingDungeonCharacterDelay)
        LuaMgr.RemoveTimer(TimerConst.TrainingDungeonWaitCreatCharacterItem)
        this.SaveMemberList()
        HeroParameter.SaveTrainingChoice(this.data.trainingDungeonGroupId, this.currentIndex)
    end,
    before_destroy=function(vm)
        this.data=nil;
    end
}

this.Refresh = function()
    this.data.trainingDungeonGroupCfg = ConfigMgr.Config.TrainingCpointMap[this.data.trainingDungeonGroupId]
    PlayerAssistMgr.CheckDungeonIsSupportShare_More(this.data.trainingDungeonGroupCfg)
    this.data.dungeonIds = this.data.trainingDungeonGroupCfg.DungeonId
    this.dungeonCount = #this.data.dungeonIds
    this.currentIndex = 1
    this.vm.data.isShowConditionTips = false
    BattlePrepareMgr.isEnterBattle = false
    this.data.tempList = {}
    for i = 1, this.dungeonCount do
        table.insert(this.data.tempList, {})
    end

    if HeroParameter.SaveTrainingChoiceParam ~= nil and HeroParameter.SaveTrainingChoiceParam.trainingDungeonGroupId == this.data.trainingDungeonGroupId then
        this.currentIndex = HeroParameter.SaveTrainingChoiceParam.currentIndex
    end

    if this.IsContinueBattle() then
        local currentDungeonId =  DataMgr.Player.Training2.TrainingSeries[this.data.trainingDungeonGroupId].DungeonId

        for i = 1, this.dungeonCount do
            if this.data.dungeonIds[i] == currentDungeonId then
                this.currentIndex = i + 1
                break
            end
        end
    end

    this.GetMemberList()
    this.SetData(this.currentIndex)
    this.SetIsContinueBattle()
    this.SetChallengeList()
    this.SetTeamWeaponSkill()
end

function this.SetData(currentIndex)
    if currentIndex > 0 and currentIndex <= this.dungeonCount then
        this.SetEnemyList(currentIndex)
        this.InitCharacterBgs(currentIndex)
        this.DelayCharacters(currentIndex)
        this.SetPageBtns(currentIndex)
        this.SetTitleText(currentIndex)
        this.SetGlobalBuffs(currentIndex)
        this.SetAssistHeroCount()
        this.SetTeamWeaponSkill()
    end
end

function this.SetEnemyList(currentIndex)
    this.UpdateMonsterIdList()
    if currentIndex > 0 and currentIndex <= this.dungeonCount then
        local enemyListData = {}
        local monsterConfigTable = this.data.monsterConfigTables[currentIndex]
        local dungeonConfig = ConfigMgr.Config.dungeonMap[this.data.dungeonIds[currentIndex]]
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
                if #enemyListData >= 5 then
                    break
                end
            end
        end

        this.vm.data.firstEnemyList = enemyListData
        this.vm.data.firstRecommendLevel = dungeonConfig.levelShow

        if #enemyListData > 0 then
            this.data.enemyIndex = 1
            LuaMgr.RemoveTimer(TimerConst.TrainingDungeonEnemyDelay)
            LuaMgr.AddTimer(TimerConst.TrainingDungeonEnemyDelay, this.OnEnemyDelay, 0.07, -1, false)
        end
    end
end

function this.InitCharacterBgs(currentIndex)
    if this.data.characterBgListContentTr == nil then
        this.data.characterBgListContentTr = {
            this.vm.behaviour.transform:Find("root/Middle/First/Character/BG"),
        }
    end
    
    local limitMemberCount = this.data.memberLimitCount[currentIndex]
    for j = 1, MaxCharacterCount do
        local itemTr = this.data.characterBgListContentTr[1]:GetChild(j - 1)
        itemTr.gameObject:SetActive(j <= limitMemberCount)
    end
end

function this.DelayCharacters(currentIndex)
    this.ClearCharacters()
    this.data.isDelayCharacters = true
    this.OnCharacters(currentIndex)
end

function this.OnCharacters(currentIndex)
    LuaMgr.RemoveTimer(TimerConst.TrainingDungeonCharacters)
    this.data.isCharacterAni = true
    this.SetCharacters(currentIndex)
    this.data.characterIndex = 1
    LuaMgr.AddTimer(TimerConst.TrainingDungeonCharacterDelay, this.OnCharacterDelay, 0.07, -1, false)
end

function this.SetCharacters(currentIndex)
local assistMemberItem=assistMember[currentIndex]
    local dungeonConfig = ConfigMgr.Config.dungeonMap[this.data.dungeonIds[currentIndex]]
    local isDrag, isSwap, isLimit, isLock
    local pos = Vector3(-CharacterItemSize - CharacterItemSpacing + leftBorderX, 0, 0)
    local tempCharacterItems = {}
    local memberDic = BattlePrepareMgr.memberDic[currentIndex];
    for j = 1, MaxCharacterCount do
        local memberIndex = j - 1
        local item = {
            itemId = "CharacterItem_" .. j,
            isAnimator = this.data.isCharacterAni,
            isGroup = false,
            isAssistHero=false;
        }
        local member = ""
        if memberDic ~= nil then
            member = memberDic[tostring(memberIndex)]
            if member == nil then
                member = ""
            end
        end
        if dungeonConfig.fightType == 1 then
            isSwap = true
            isLimit = j > dungeonConfig.outRoleNum
            if isLimit then
                isDrag = false
            else
                isDrag = not IsNullOrEmpty(member)
            end
            isLock = false
        else
            LuaDebug.error("关卡不能配置演员!");
        end
        if not isLimit then
            item.isShow = IsNullOrEmpty(member) or not this.data.isCharacterAni
            item.id = tostring(memberIndex)
            item.characterId = member
            item.drag = isDrag
            item.swap = isSwap
            if not IsNullOrEmpty(member) then
                local path
                item.isShowLevel = true
                item.isShowZZ = true
                item.level = tostring(HeroManager.GetCharacterLevel(member))
                path = HeroManager.GetCharacterCard(member)
                item.body = LuaMgr.GetTexture(path)
                local characterConfig = ConfigMgr.Config.characterTable[member]
                local tempRare = HeroMgr.GetHeroNowRare(member)
                local brilliant = nil
                if characterConfig ~= nil then
                    item.showRare = true
                    item.cname = LuaMgr.GetLangText(characterConfig.namelan)
                    item.zyIcon = LuaMgr.GetSprite("JobIcon", "job_" .. characterConfig.job)
                    item.showZy = true
                    brilliant = ConfigMgr.Config.BrilliantMap[member..characterConfig.rare]
                end
                item.isLeveling=false
                local zz = HeroManager.GetCharacterZZ(member)

                if assistMemberItem~=nil and assistMemberItem[member]~=nil then
                    item.isAssistHero=true;
                    local assistCharacter=PlayerAssistMgr.GetAssist_Character(assistMemberItem[member].uid,assistMemberItem[member].id);
                    if assistCharacter~=nil then
                        tempRare = this.GetHeroRare(assistCharacter)
                        item.level=tostring(assistCharacter.level)
                        zz=assistCharacter.star>0 and assistCharacter.star or -1 ;
                        item.body=LuaMgr.GetTexture(HeroMgr.GetCharacterCard(assistCharacter.id,assistCharacter.curSkin))
                    end
                end
                item.hzActive = not TableIsNull(brilliant) and tempRare > 4
                item.hzNotActive = not TableIsNull(brilliant) and tempRare <= 4
                local imageRare = tempRare >= 5 and 4 or tempRare
                item.rare = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_"..imageRare)
                item.zzBg = LuaMgr.GetSprite("CommonRes", zz > 0 and "ui_ty_kp_zz1" or "ui_ty_kp_zz2")
                item.zzLevel = string.format("<color=#%s>%s</color>", zz > 0 and "262429" or "aca9a3",
                        HeroManager.GetNumStr(math.abs(zz)))
                item.isGroup =  true
            end
            item.isLimit = isLimit
            item.isLock = isLock
            item.isSwap = false
            item.isLight = false
            pos = Vector3(pos.x + CharacterItemSize + CharacterItemSpacing, 0, 0)
            item.itemPosition = pos
            table.insert(tempCharacterItems, item)
        end
    end

    local x = 590.5 - #tempCharacterItems * 65.5
    local width = CharacterItemSize + (#tempCharacterItems - 1) * (CharacterItemSize + CharacterItemSpacing)
    this.vm.data.firstCharacterListAnchorPos = Vector2(x, -2.5)
    this.vm.data.firstCharacterListSize = Vector2(width, 280)
    this.vm.data.firstCharacterItems = tempCharacterItems
    firstRightBorderX = width - CharacterItemSize + leftBorderX

    this.data.tempList[this.currentIndex] = {}
    for i = 1, #this.vm.data.firstCharacterItems do
        if this.vm.data.firstCharacterItems[i].characterId ~= "" then
            table.insert(this.data.tempList[this.currentIndex], this.vm.data.firstCharacterItems[i].characterId)
        end
    end
    this.data.isCharacterAni = false

    LuaMgr.AddTimer(TimerConst.TrainingDungeonWaitCreatCharacterItem, function()
        if this.data.characterListContentTr == nil then
            this.data.characterListContentTr = {
                this.vm.behaviour.transform:Find("root/Middle/First/Character/List")
            }
        end

        local limitMemberCount = this.data.memberLimitCount[currentIndex]
        local childCount = this.data.characterListContentTr[1].childCount
        if childCount < limitMemberCount then
            return
        end

        if this.data.characterItemTrList[currentIndex] == nil then
            this.data.characterItemTrList[currentIndex] = {}
            for j = 1, limitMemberCount do
                local itemTr = this.data.characterListContentTr[1]:GetChild(j - 1)
                itemTr:GetComponent("OnDragEvent"):SetData(this.GetCharacterGlobalIndex(currentIndex, j), this.OnDown, this.OnDrag, this.OnEnd)
                itemTr.transform.localPosition = this.GetCharacterItems(currentIndex)[j].itemPosition
                table.insert(this.data.characterItemTrList[currentIndex], itemTr)
            end
        end

        if this.data.characterItemTrList[currentIndex] ~= nil then
            LuaMgr.RemoveTimer(TimerConst.TrainingDungeonWaitCreatCharacterItem)
        end
    end, 0.2, -1, false)
end















































this.OnEnemyDelay = function()
    if this.data.enemyIndex <= #this.vm.data.firstEnemyList then
        this.vm.data.firstEnemyList[this.data.enemyIndex].isShow = true
    end
    this.data.enemyIndex = this.data.enemyIndex + 1
    if this.data.enemyIndex > #this.vm.data.firstEnemyList then
        LuaMgr.RemoveTimer(TimerConst.TrainingDungeonEnemyDelay)
    end
end

this.UpdateMonsterIdList = function()
    this.data.monsterConfigTables = {}
    for i = 1, this.dungeonCount do
        local monsterDicJson = LuaMgr.UpdateMonsterIdList(this.data.dungeonIds[i])
        this.data.monsterConfigTables[i] = json.decode(monsterDicJson)
    end
end

















this.OnCharacterDelay = function()










    local index = this.data.characterIndex
    if index ~= 0 and index <= this.data.memberListCount[this.currentIndex] then
        this.GetCharacterItems(this.currentIndex)[index].isShow = true
    end
    
    this.data.characterIndex = this.data.characterIndex + 1
    if this.data.characterIndex > #this.vm.data.firstCharacterItems then
        this.data.isDelayCharacters = false
        LuaMgr.RemoveTimer(TimerConst.TrainingDungeonCharacterDelay)
    end
end

























































































































































this.GetHeroRare = function(character)
    local rare = 0
    local tempConfig = ConfigCharacterMgr.GetInfo(character.id)
    if not TableIsNull(tempConfig) then
        rare = tempConfig.rare
        if not TableIsNull(character) and type(character.brilliant) ~= "function" and not TableIsNull(character.brilliant) then
            rare = rare + character.brilliant.RareLevel
        end
    end
    return rare
end








    










this.ClearCharacters = function()
    local i = 1
    for j = 1, #this.GetCharacterItems(i) do
        this.GetCharacterItems(i)[j].characterId = ""
        this.GetCharacterItems(i)[j].isLimit = false
        this.GetCharacterItems(i)[j].isLock = false
        this.GetCharacterItems(i)[j].isGroup = false
        this.GetCharacterItems(i)[j].isSwap = false
        this.GetCharacterItems(i)[j].isLight = false
    end











end

this.GetMemberList = function()
    if HeroParameter.changeAfterTeam ~= nil then
        this.OnTeamChangeCB(HeroParameter.changeAfterTeam)
        HeroParameter.changeAfterTeam = nil
        assistMember[HeroParameter.trainingTeamIndex]=table.Copy(PlayerAssistMgr.assistMembers);
    else
local isOldStr=false;
        local dungeonGroupMembersStr =PlayerPrefs.GetString(DataMgr.Player.uid .. "TrainingDungeonNew" .. this.data.trainingDungeonGroupId, "")
        if IsNullOrEmpty(dungeonGroupMembersStr) then
             dungeonGroupMembersStr =PlayerPrefs.GetString(DataMgr.Player.uid .. "TrainingDungeon" .. this.data.trainingDungeonGroupId, "")
            if not IsNullOrEmpty(dungeonGroupMembersStr) then
                isOldStr=true;



            end
        end
        BattlePrepareMgr.memberDic = {}
        assistMember={}
        if not isOldStr then
            local dungeonGroupMembersArray = json.decode(dungeonGroupMembersStr);
            this.CheckMemberInvalid(dungeonGroupMembersArray);
            for i = 1, this.dungeonCount do
                BattlePrepareMgr.memberDic[i] = {}
                assistMember[i]={}
                local dungeonConfig = ConfigMgr.Config.dungeonMap[this.data.dungeonIds[i]]
                if dungeonGroupMembersArray~=nil then
                    local members = dungeonGroupMembersArray[i];
                    for j = 1, dungeonConfig.outRoleNum do
                        if j <= #members and not IsNullOrEmpty(members[j].id) and not (members[j].id == "nil") then
                            BattlePrepareMgr.memberDic[i][tostring(j - 1)] = members[j].id
                            if(not IsNullOrEmpty(members[j].uid)) then
                                assistMember[i][members[j].id]={id=members[j].id,uid=members[j].uid};
                            end
                        end
                    end
                end
                this.data.memberLimitCount[i] = dungeonConfig.outRoleNum
            end
        else

            local dungeonGroupMembersArray = NumTool.split(dungeonGroupMembersStr,"_")
            for i = 1, this.dungeonCount do
                BattlePrepareMgr.memberDic[i] = {}
                assistMember[i]={}
                local dungeonConfig = ConfigMgr.Config.dungeonMap[this.data.dungeonIds[i]]
                local members = NumTool.split(dungeonGroupMembersArray[i], "-")
                for j = 1, dungeonConfig.outRoleNum do
                    if j <= #members and not IsNullOrEmpty(members[j]) then
                        BattlePrepareMgr.memberDic[i][tostring(j - 1)] = members[j]
                    end
                end
                this.data.memberLimitCount[i] = dungeonConfig.outRoleNum
            end
        end
    end
    for i = 1, #BattlePrepareMgr.memberDic do
        this.data.memberListCount[i] = ConfigHelper.GetTableLength(BattlePrepareMgr.memberDic[i])
        this.data.tempList[i] = {}
        for _, v in pairs(BattlePrepareMgr.memberDic[i]) do
            table.insert(this.data.tempList[i], v)
        end
    end
    this.SetAssistHeroCount()
end


this.SetAssistHeroCount=function()
    this.vm.data.isAssistType2_2=false
    local isOpen=PlayerAssistMgr.IsOpen();
    if not isOpen then

        this.vm.data.isOpenAssist=false;
        return;
    end
local isShare=this.data.trainingDungeonGroupCfg.Iscooperate>0
    local num=0;
    local isAssist=true;
    if isShare then

        this.vm.data.isAssistType2_1=false;
        this.vm.data.isAssistType2_2=false;
        if #assistMember>0 then
            for i, v in ipairs(assistMember) do
                num = num + NumTool.GetLen(assistMember[i])
            end

        end
        this.vm.data.isAssistType1=true
        this.vm.data.assistFirstCount=string.format("%s/%s",num,this.data.trainingDungeonGroupCfg.Cooperatelimit);
    else


        this.vm.data.isAssistType1=false
        local dungeonConfig1 = ConfigMgr.Config.dungeonMap[this.data.dungeonIds[this.currentIndex]]
        local isType2_1=dungeonConfig1.isSupport>0
        this.vm.data.isAssistType2_1=isType2_1;
        if isType2_1 then
            num=0;
            if #assistMember>0 then
                num=NumTool.GetLen(assistMember[1]);
            end
            this.vm.data.assistFirstCount=string.format("%s/%s",num,dungeonConfig1.supportNum);
        end











        isAssist=isType2_1;
    end
    if isAssist then
        this.vm.data.assistDailyCount=string.format("<color=#eccc38>%s</color>/%s",PlayerAssistMgr.RemainAssistCount(),ConfigMgr.Config.FriendConstants.TotalBorrowLimit)
    end
    this.vm.data.isOpenAssist=isAssist;
end



this.CheckMemberInvalid=function(members)
    if members==nil or #members==0 then return nil end;
    local hasAssistHero=false;
    for i,v in ipairs(members) do
        for p,m in pairs(v) do
            if not IsNullOrEmpty(m.uid) then
                hasAssistHero=true;
                break;
            end
        end
    end


    for i = #members, 1, -1 do
        local member = members[i]
        for j = #member, 1, -1 do
            if not IsNullOrEmpty(member[j].id) and HeroManager.GetCharacterLevel(member[j].id) == 0 and IsNullOrEmpty(member[j].uid) then
                table.remove(member, j)
            end
        end
    end

    if not hasAssistHero then
        return nil;
    end
    local invalidMember={};
    local tipsType=0;

    local supportNum=0 ;
    if this.data.trainingDungeonGroupCfg.Iscooperate>0 then
        supportNum=this.data.trainingDungeonGroupCfg.Cooperatelimit;
    end
    local assistIndex=0;
    local assistMemberRemainUsedCountByUid={}
    for i,v in ipairs(members) do
        local member=members[i];
        if #member>0 then

            if this.data.trainingDungeonGroupCfg.Iscooperate==0 then
                assistIndex=0;
                local dungeonConfig=ConfigMgr.Config.dungeonMap[this.data.trainingDungeonGroupCfg.DungeonId[i]];
                if dungeonConfig~=nil then
                    supportNum=dungeonConfig.isSupport>0 and dungeonConfig.supportNum or 0;
                end
            end

            if supportNum==0 then
                tipsType=2;
            end
            if PlayerAssistMgr.RemainAssistCount()==0 then

                supportNum=0;
                tipsType=5;
            end
            for j=#member,1, -1 do
                if not IsNullOrEmpty(member[j].uid) then
                    if  not PlayerAssistMgr.CheckAssistListContainsKeyHero(member[j].uid,member[j].id) then

                        table.insert(invalidMember,member[j]);
                        table.remove(member,j);
                        tipsType=1;
                    elseif PlayerAssistMgr.FriendRemainAssistCount(member[j].uid)==0 then

                        table.insert(invalidMember,member[j]);
                        table.remove(member,j);
                        tipsType=4
                    else

                        local remainCount=PlayerAssistMgr.FriendRemainAssistCount(member[j].uid);
                        if assistMemberRemainUsedCountByUid[member[j].uid]==nil then
                            assistMemberRemainUsedCountByUid[member[j].uid]=remainCount;
                        end
                        assistMemberRemainUsedCountByUid[member[j].uid]=assistMemberRemainUsedCountByUid[member[j].uid]-1;
                        if assistMemberRemainUsedCountByUid[member[j].uid]<0 then
                            tipsType=6;
                            table.insert(invalidMember,member[j]);
                            table.remove(member,j);
                        end
                        

                        if assistIndex>=supportNum then
                            table.insert(invalidMember,member[j]);
                            table.remove(member,j);
                            tipsType=3
                        else
                            assistIndex=assistIndex+1;
                        end
                    end
                end
            end
        end

    end


    if tipsType>0 then
        local tip=""
        if tipsType==3 then
            tip=ConfigMgr.LangGlobal("21004")
        elseif tipsType==2 then
            tip=ConfigMgr.LangGlobal("21001")
        elseif tipsType==1 then
            tip=ConfigMgr.LangGlobal("21000")
        elseif tipsType==4 then
            tip=ConfigMgr.LangGlobal("21005")
        elseif tipsType==5 then
            tip=ConfigMgr.LangGlobal("21006")
        elseif tipsType==6 then
            tip=ConfigMgr.LangGlobal("22781")
        end
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tip)
    end
    return invalidMember;
    
end


this.SaveMemberList = function()
    local dungeonGroupMembersStr = this.GetDungeonGroupMembersStr()
    PlayerPrefs.SetString(DataMgr.Player.uid .. "TrainingDungeonNew" .. this.data.trainingDungeonGroupId, dungeonGroupMembersStr)
end

this.GetCharacterItems = function(index)
    return this.vm.data.firstCharacterItems





end

this.OnDown = function(index, eventData)
    if BattlePrepareMgr.isEnterBattle then
        return
    end

    local teamIndex, localIndex = this.GetCharacterLocalIndex(index)
    local clickItem = this.GetCharacterItems(teamIndex)[localIndex]
    this.data.downTime = CS.UnityEngine.Time.realtimeSinceStartup
    this.data.dragIndex = index
    this.data.dragLocalIndex = localIndex
    this.data.dragteamIndex = teamIndex
    this.data.clickItem = clickItem
    this.data.selectIndex = nil
    this.data.originPos = clickItem.itemPosition
    
    if IsNullOrEmpty(clickItem.characterId) or not clickItem.drag then
        return
    end

    local tarPos = LuaMgr.Screen2Local(eventData.position, this.data.characterListContentTr[1])
    this.data.offset.x = this.data.originPos.x - tarPos.x
    this.data.offset.y = this.data.originPos.y - tarPos.y
    this.data.characterItemTrList[teamIndex][localIndex]:SetAsLastSibling()
    AudioHelper.PlayUISFX(Path.audio_PATH.."newUI/plane.mp3");
end

this.OnDrag = function(eventData)
    if BattlePrepareMgr.isEnterBattle or this.data.isDelayCharacters or this.data.dragIndex == nil then
        return
    end
    
    if IsNullOrEmpty(this.data.clickItem.characterId) or not this.data.clickItem.drag then
        return
    end

    local result = RectTool.Screen2Local(eventData.position, this.data.characterListContentTr[1])
    if result.inRect then
        local pos = Vector3(result.pos.x + this.data.offset.x, 0, 0)

        if pos.x < leftBorderX then
            pos.x = leftBorderX
        else
            if pos.x > firstRightBorderX then
                pos.x = firstRightBorderX
            end





        end
        this.data.characterItemTrList[this.data.dragteamIndex][this.data.dragLocalIndex].localPosition = pos
    end

    local characterItems = this.GetCharacterItems(this.data.dragteamIndex)
    if this.data.selectIndex ~= nil then
        characterItems[this.data.selectIndex].isLight = true
    end

    local isSelect = false
    for i, item in ipairs(characterItems) do
        if i ~= this.data.dragLocalIndex then
            if item.swap then
                if not IsNullOrEmpty(item.characterId) then
                    characterItems[i].isSwap = true
                end

                if this.Intersect(this.data.characterItemTrList[this.data.dragteamIndex][i].localPosition) then
                    if this.data.selectIndex ~= nil then
                        characterItems[this.data.selectIndex].isLight = false
                    end

                    this.data.selectIndex = i
                    isSelect = true
                    if not IsNullOrEmpty(item.characterId) then
                        characterItems[i].isLight = true
                    end

                    AudioHelper.PlayUISFX(AudioNames.EHandleAttract2);
                    break
                end
            end

            characterItems[i].isLight = false
        end
    end

    if not isSelect then
        this.data.selectIndex = nil
    end
end

this.OnEnd = function(eventData)
    if this.data.isDelayCharacters or this.data.dragIndex == nil or BattlePrepareMgr.isEnterBattle then
        return
    end
    if CS.UnityEngine.Time.realtimeSinceStartup - this.data.downTime <= 0.2 then
        this.OnCharacterSingleClick(this.data.dragIndex)
    else
        this.ChangeMemberPos()
        AudioHelper.PlayUISFX(AudioNames.EDragEnd)
    end

    local characterItems = this.GetCharacterItems(this.data.dragteamIndex)
    for i, item in ipairs(characterItems) do
        characterItems[i].isLight = false
        characterItems[i].isSwap = false
    end
    characterItems[this.data.dragLocalIndex].itemPosition = this.data.originPos
    this.data.downTime = 0
    this.data.dragIndex = nil
    this.data.dragLocalIndex = nil
    this.data.dragteamIndex = nil
    this.data.clickItem = nil
    this.data.selectIndex = nil
end

this.OnCharacterSingleClick = function(index)
    if not this.data.isDelayCharacters then
        local teamIndex, localIndex = this.GetCharacterLocalIndex(index)
        local clickItem = this.GetCharacterItems(teamIndex)[localIndex]
        if not clickItem.isLock and not clickItem.isLimit then
            local anotherTeam= {}
            for i, team in ipairs(this.data.tempList) do
                if i ~= this.currentIndex and team ~= nil then
                    local anotherAssistTeam = assistMember[i]
                    for j, v in ipairs(team) do
                        if anotherAssistTeam ~= nil and anotherAssistTeam[v] ~= nil then
                            anotherTeam[v] = {id=v, uid=anotherAssistTeam[v].uid, trainingGroupIndex = i}
                        else
                            anotherTeam[v] = {id=v, uid="", trainingGroupIndex = i}
                        end
                    end 
                end
            end
            HeroParameter.SaveBattlePrepareParam(teamIndex,clickItem.characterId,false,true,false, this.data.tempList[teamIndex])
            HeroParameter.SetTrainingParam(teamIndex, anotherTeam, this.data.memberListCount, this.data.memberLimitCount)
            this.SetAssistInfo(teamIndex)
            FeatureManager.GotoPanel("1004")
        end
        AudioHelper.PlayUISFX(AudioNames.EButtonLight)
    end
end

this.OnClickFaskBtn = function(index)
    local anotherTeam= {}
    for i, team in ipairs(this.data.tempList) do
        if i ~= this.currentIndex and team ~= nil then
            local anotherAssistTeam = assistMember[i]
            for j, v in ipairs(team) do
                if anotherAssistTeam ~= nil and anotherAssistTeam[v] ~= nil then
                    anotherTeam[v] = {id=v, uid=anotherAssistTeam[v].uid, trainingGroupIndex = i}
                else
                    anotherTeam[v] = {id=v, uid="", trainingGroupIndex = i}
                end
            end 
        end
    end
    HeroParameter.SaveBattlePrepareParam(index, "",false,true,true, this.data.tempList[index])
    HeroParameter.SetTrainingParam(index, anotherTeam, this.data.memberListCount, this.data.memberLimitCount)
    this.SetAssistInfo(index)
    FeatureManager.GotoPanel("1004")
    AudioHelper.PlayUISFX(AudioNames.EButtonLight)
end


this.SetAssistInfo=function(index)
    local dungeon=ConfigMgr.Config.dungeonMap[this.data.dungeonIds[index]]
    PlayerAssistMgr.assistMembers_4X4=table.Copy(assistMember);
    PlayerAssistMgr.SetAssistMembers(assistMember[index])
    PlayerAssistMgr.CheckDungeonIsSupportAssist(dungeon,index,true)
end

this.OnClickDeleteBtn = function(index)
    HeroParameter.EmptyBattlePrepareParam()
    BattlePrepareMgr.memberDic[index] = {}
    local dungeonGroupMembersStr = this.GetDungeonGroupMembersStr()
    PlayerPrefs.SetString(DataMgr.Player.uid .. "TrainingDungeonNew" .. this.data.trainingDungeonGroupId, dungeonGroupMembersStr)

    this.GetMemberList()
    this.SetCharacters(this.currentIndex)
end


this.ChangeMemberPos = function()
    local characterItems = this.GetCharacterItems(this.data.dragteamIndex)
    local dragItem = characterItems[this.data.dragLocalIndex]
    local selectItem = characterItems[this.data.selectIndex]
    if selectItem == nil or IsNullOrEmpty(selectItem.characterId) then
        return
    end

    local dragLocalIndexSrt = tostring(this.data.dragLocalIndex - 1)
    local selectIndexSrt = tostring(this.data.selectIndex - 1)
    local dragId = BattlePrepareMgr.memberDic[this.data.dragteamIndex][dragLocalIndexSrt]
    local selectId = BattlePrepareMgr.memberDic[this.data.dragteamIndex][selectIndexSrt]
    BattlePrepareMgr.memberDic[this.data.dragteamIndex][dragLocalIndexSrt] = nil
    BattlePrepareMgr.memberDic[this.data.dragteamIndex][selectIndexSrt] = nil
    if selectId ~= nil and selectId ~= "" then
        BattlePrepareMgr.memberDic[this.data.dragteamIndex][dragLocalIndexSrt] = selectId
    end

    if dragId ~= nil and dragId ~= "" then
        BattlePrepareMgr.memberDic[this.data.dragteamIndex][selectIndexSrt] = dragId
    end
    this.SetCharacters(this.currentIndex)
end

this.OnTeamChangeCB = function(ids)
    LuaMgr.CharacterJoinTeamVoice(ids)
    this.ChangeCharacter(HeroParameter.battleMembers)
    this.data.memberListCount = HeroParameter.trainingMemberCount
    for i = 1, this.dungeonCount do
        local dungeonConfig = ConfigMgr.Config.dungeonMap[this.data.dungeonIds[i]]
        this.data.memberLimitCount[i] = dungeonConfig.outRoleNum
    end
end


this.ChangeCharacter = function(members)
    local index = 0
    BattlePrepareMgr.memberDic[HeroParameter.trainingTeamIndex] = {}
    for i, member in ipairs(members) do
        if not IsNullOrEmpty(member) then
            BattlePrepareMgr.memberDic[HeroParameter.trainingTeamIndex][tostring(index)] = member
            index = index + 1
        end
    end
end

this.GetCharacterGlobalIndex = function(i, j)



    return j
end

this.GetCharacterLocalIndex = function(index)
    local i = this.currentIndex
    local j = index




    return i, j
end


this.Intersect = function(pos)

    local dragItemTr = this.data.characterItemTrList[this.data.dragteamIndex][this.data.dragLocalIndex]
    if dragItemTr == nil then
        return
    end
    local halfSumX = 154 * 0.4
    local halfSumY = 342 * 0.4
    local distX = math.abs(dragItemTr.localPosition.x - pos.x)
    local distY = math.abs(dragItemTr.localPosition.y - pos.y)
    return distX <= halfSumX and distY <= halfSumY
end

this.SetWinLose = function(index)
    if this.data.conditionStatus[index] == "0" then
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

this.SetConditions = function(index)
    local conditionStatus = this.data.conditionStatus[index]
    local dungeonConfig = ConfigMgr.Config.dungeonMap[this.data.dungeonIds[index]]
    local str = LuaMgr.GetLangText(dungeonConfig.victoryTitleLan)
    local battleTurnEnd = 0
    local strs = NumTool.split(dungeonConfig.battleTurnEnd, ';')
    if (strs ~= nil and #strs == 2) then
        battleTurnEnd = tonumber(strs[2])
    end
    if conditionStatus == "1" and battleTurnEnd > 0 then
        str = str .. "1_" .. string.format(LuaMgr.GetLangText('LangGlobalLan_LangGlobal_name_5068'), battleTurnEnd)
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
                content = temps[2],
                isWin  = conditionStatus == "0",
                isLose = conditionStatus == "1",
            }
            table.insert(conditionList, conditionData)
        end
    end
    this.vm.data.conditionDatas = conditionList
end

this.SetChallengeList = function()
    local challengeList = {}
    local item_1 = {
        content = LuaMgr.GetLangText(this.data.trainingDungeonGroupCfg.Challenge1DesLan),
        isAnimator = false,
        isGet = TrainingDungeonHelper.GetChallengeStatus(this.data.trainingDungeonGroupCfg.Challenge1, this.dungeonCount)
    }
    local item_2 = {
        content = LuaMgr.GetLangText(this.data.trainingDungeonGroupCfg.Challenge2DesLan),
        isAnimator = false,
        isGet = TrainingDungeonHelper.GetChallengeStatus(this.data.trainingDungeonGroupCfg.Challenge2, this.dungeonCount)
    }
    local item_3 = {
        content = LuaMgr.GetLangText(this.data.trainingDungeonGroupCfg.Challenge3DesLan),
        isAnimator = false,
        isGet = TrainingDungeonHelper.GetChallengeStatus(this.data.trainingDungeonGroupCfg.Challenge3, this.dungeonCount)
    }
    table.insert(challengeList, item_1)
    table.insert(challengeList, item_2)
    table.insert(challengeList, item_3)

    this.vm.data.challengeDatas = challengeList
end

this.SetGlobalBuffs = function(currentIndex)
    local globalBuffList = {}
    local buffConfig = json.decode(LuaMgr.GetBuffDes(this.data.trainingDungeonGroupCfg["GroupBuff" .. currentIndex][2]))
    local item = {
        content = LuaMgr.GetLangText(buffConfig.DescriptionLan)
    }
    table.insert(globalBuffList, item)
    this.vm.data.globalBuffs = globalBuffList
end

this.GetTeamWeaponKey = function()
    return this.data.trainingDungeonGroupId
end

this.GetTeamWeaponId = function()
    if FeatureManager.IsLock("33001") then
        return ""
    end
    local teamWeaponKey = this.GetTeamWeaponKey()
    local teamWeaponId = UnityEngine.PlayerPrefs.GetString(DataMgr.Player.uid .. "TrainingDungeonViewModel.SetTeamWeaponSkill" .. teamWeaponKey)
    return IsNullOrEmpty(teamWeaponId) and "" or teamWeaponId
end

this.SetTeamWeaponSkill = function()
    if FeatureManager.IsLock("33001") then
        this.curTeamWeaponId = ""
        this.vm.data.teamWeaponBtnActive = false
        this.vm.data.teamWeaponSkillIconActive = false
        return
    end

    this.vm.data.teamWeaponBtnActive = true
    local teamWeaponKey = this.GetTeamWeaponKey()
    this.curTeamWeaponId = this.GetTeamWeaponId()
    ActivityBattlePrepareMgr.SetTeamWeaponId(teamWeaponKey, this.curTeamWeaponId)

    if IsNullOrEmpty(this.curTeamWeaponId) then
        this.vm.data.teamWeaponSkillIconActive = false
        return
    end

    local weaponCfg = TeamWeaponMgr.GetTeamWeaponCfg(this.curTeamWeaponId)
    local skillId = weaponCfg.TeamWeaponSkill[1]
    this.vm.data.teamWeaponSkillIcon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(string.gsub(skillId, "ex", "")))
    this.vm.data.teamWeaponSkillIconActive = true
end

this.SetTeamWeaponSkillCB = function(teamWeaponId)
    local teamWeaponKey = this.GetTeamWeaponKey()
    UnityEngine.PlayerPrefs.SetString(DataMgr.Player.uid .. "TrainingDungeonViewModel.SetTeamWeaponSkill" .. teamWeaponKey, teamWeaponId)
    ActivityBattlePrepareMgr.SetTeamWeaponId(teamWeaponKey, teamWeaponId)
    this.SetTeamWeaponSkill()
end

function this.SetIsContinueBattle()
    if this.IsContinueBattle() then
        this.vm.behaviour.transform:Find("root/Middle/Info/StartBattle").gameObject:SetActive(false)
        this.vm.behaviour.transform:Find("root/Middle/Info/ContinueBattle").gameObject:SetActive(true)

        local w = NumTool.GetMaxNum(this.GetNextTrainingDungeonIndex())
        this.vm.behaviour.transform:Find("root/Middle/Info/ContinueBattle/Image/text").gameObject:GetComponent("Text").text = string.format("继续挑战第%s阵", w)
    else
        this.vm.behaviour.transform:Find("root/Middle/Info/StartBattle").gameObject:SetActive(true)
        this.vm.behaviour.transform:Find("root/Middle/Info/ContinueBattle").gameObject:SetActive(false)
    end
end


this.OnStartBattle = function()
    if this.data.memberListCount[1] <= 0 and this.dungeonCount >= 1 then
        local msg = LuaMgr.GetLangText("TrainingDungeonViewModel_0")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, msg);
        return
    elseif this.data.memberListCount[2] <= 0 and this.dungeonCount >= 2 then
        local msg = LuaMgr.GetLangText("TrainingDungeonViewModel_1")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, msg);
        return
    elseif this.data.memberListCount[3] <= 0 and this.dungeonCount >= 3 then
        local msg = LuaMgr.GetLangText(LuaMgr.GetLangText("TrainingDungeonViewModel_4"))
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, msg);
        return
    end
    local memberDic = BattlePrepareMgr.memberDic;
    local dungeonGroupMembersStr = this.GetDungeonGroupMembersStr()
    PlayerPrefs.SetString(DataMgr.Player.uid .. "TrainingDungeonLastMembers" , dungeonGroupMembersStr)
    BattlePrepareMgr.TrainingDungeonEnterBattle(this.data.trainingDungeonGroupId, this.GetNextTrainingDungeonIndex(), memberDic)
end

function this.OnContinueBattle()
    this.OnStartBattle()
end

function this.OnGiveUpBattle()
    LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, LuaMgr.GetLangText("TrainingDungeonViewModel_5"), this.OnGiveUpConfirm, nil);
end

function this.OnGiveUpConfirm()
    local data = 
    {
        CPointId = this.data.trainingDungeonGroupId,
    }
    ApiMgr.Request("training2/cancel", data, true, function(result)
        local re = json.decode(result)
        if re.code == 0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrainingDungeonViewModel_6"))
            LuaMgr.Back()


        end
    end, nil, true)
end

function this.SetTitleText(currentIndex)
    local w = NumTool.GetMaxNum(currentIndex)
    this.vm.behaviour.transform:Find("root/Middle/First/TitleImage/title").gameObject:GetComponent("Text").text = string.format(LuaMgr.GetLangText("TrainingDungeonViewModel_7"), w)
end

function this.SetPageBtns(currentIndex)
    if this.IsContinueBattle() then
        this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/PageUpBtn/On").gameObject:SetActive(false)
        this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/PageUpBtn/Off").gameObject:SetActive(true)
        this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/PageDownBtn/On").gameObject:SetActive(false)
        this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/PageDownBtn/Off").gameObject:SetActive(true)
    else
        if currentIndex == 1 then
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/PageUpBtn/On").gameObject:SetActive(false)
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/PageUpBtn/Off").gameObject:SetActive(true)
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/PageDownBtn/On").gameObject:SetActive(true)
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/PageDownBtn/Off").gameObject:SetActive(false)
        elseif currentIndex == this.dungeonCount then
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/PageUpBtn/On").gameObject:SetActive(true)
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/PageUpBtn/Off").gameObject:SetActive(false)
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/PageDownBtn/On").gameObject:SetActive(false)
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/PageDownBtn/Off").gameObject:SetActive(true)
        else
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/PageUpBtn/On").gameObject:SetActive(true)
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/PageUpBtn/Off").gameObject:SetActive(false)
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/PageDownBtn/On").gameObject:SetActive(true)
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/PageDownBtn/Off").gameObject:SetActive(false)
        end
    end
    this.SetPagePoints(currentIndex)
end

function this.SetPagePoints(currentIndex)
    for i = 1, 5 do
        if i <= this.dungeonCount then
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/Points/Point" .. i).gameObject:SetActive(true)
        else
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/Points/Point" .. i).gameObject:SetActive(false)
        end
    end

    for i = 1, this.dungeonCount do
        if i == currentIndex then
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/Points/Point" .. i .. "/On").gameObject:SetActive(true)
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/Points/Point" .. i .. "/Off").gameObject:SetActive(false)
        else
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/Points/Point" .. i .. "/On").gameObject:SetActive(false)
            this.vm.behaviour.transform:Find("root/Middle/First/PageBtns/Points/Point" .. i .. "/Off").gameObject:SetActive(true)
        end
    end
end

function this.OnPageUp()
    if this.currentIndex - 1 >= 1 and not this.IsContinueBattle() then
        this.currentIndex = this.currentIndex - 1
        this.SetData(this.currentIndex)
    end
end

function this.OnPageDown()
    if this.currentIndex + 1 <= this.dungeonCount and not this.IsContinueBattle() then
        this.currentIndex = this.currentIndex + 1
        this.SetData(this.currentIndex)
    end
end

this.GetDungeonGroupMembersStr1 = function()
    local dungeonGroupMembersStr = ""
    for i = 1, this.dungeonCount do
        for j = 1, this.data.memberListCount[i] do
            local member = BattlePrepareMgr.memberDic[i][tostring(j - 1)]
            if member == nil then
                member = ""
            end
            dungeonGroupMembersStr = dungeonGroupMembersStr .. member
            if j ~= this.data.memberListCount[i] then
                dungeonGroupMembersStr = dungeonGroupMembersStr .. "-"
            end
        end
        if i == 1 then
            dungeonGroupMembersStr = dungeonGroupMembersStr .. "_"
        end
    end
    return dungeonGroupMembersStr
end


this.GetDungeonGroupMembersStr = function()
    local dungeonGroupMembersStr = ""
    local memberList={}
    if BattlePrepareMgr.memberDic ~= nil then
        for i = 1, this.dungeonCount do
            memberList[i]={}
            if BattlePrepareMgr.memberDic[i] ~= nil then
                local tempAssist=assistMember[i];
                for j = 1, this.data.memberListCount[i] do
                    local member = BattlePrepareMgr.memberDic[i][tostring(j - 1)]
                    if member~=nil then
                        local tempUid=""
                        if tempAssist~=nil and tempAssist[member]~=nil then
                            tempUid=tempAssist[member].uid;
                        end
                        table.insert(memberList[i],{id=member,uid=tempUid})
                    end
                end
            end
        end
    end
    dungeonGroupMembersStr=json.encode(memberList);
    return dungeonGroupMembersStr
end

function this.IsContinueBattle()
    if not TrainingDungeonHelper.IsTraining2DungeonGroup(this.data.trainingDungeonGroupId) then
        return false
    else
        if DataMgr.Player.Training2 
            and DataMgr.Player.Training2.TrainingSeries[this.data.trainingDungeonGroupId] ~= nil 
            and not IsNullOrEmpty(DataMgr.Player.Training2.TrainingSeries[this.data.trainingDungeonGroupId].DungeonId) then
            return true
        else
            return false
        end
    end
end

function this.GetNextTrainingDungeonIndex()
    if DataMgr.Player.Training2 
        and DataMgr.Player.Training2.TrainingSeries[this.data.trainingDungeonGroupId] ~= nil 
        and not IsNullOrEmpty(DataMgr.Player.Training2.TrainingSeries[this.data.trainingDungeonGroupId].DungeonId) then
        local dungeonId = DataMgr.Player.Training2.TrainingSeries[this.data.trainingDungeonGroupId].DungeonId


        for i, id in ipairs(this.data.trainingDungeonGroupCfg.DungeonId) do
            if id == dungeonId then
                return i + 1
            end
        end
    end
    return 1
end

this.ApplicationFocus = function(args)
    local hasFocus = args[0];
    if hasFocus and dragIndex ~= nil then
        dragIndex = nil;
        selectIndex = nil
    end
end

this.OnBack=function()
    HeroParameter.EmptyBattlePrepareParam()
    HeroParameter.EmptyTrainingParam()
    LuaMgr.Back()
end

return vm({
    data = data,
    command = command,
    hook = hook
})