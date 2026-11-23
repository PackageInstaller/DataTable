






local this = {vm=nil};
local battleGroupId=nil;
local dungeonNameSpriteStr=nil;
local dataTower=nil;
local curDungeon;
local cfgBattleTower;
local dataTowerRecords=nil;
local dataTowerCharAttrs={};
local dataTowerCharCopy={};
local monsterConfigTable={};
local conditions={};
local members={};
local color_red=UnityEngine.Color(173/255,36/255,30/255,1)
local color_green=UnityEngine.Color(0/255,141/255,122/255,1)
local color_yellow=UnityEngine.Color(195/255,144/255,55/255,1)
local levelName={}
local ruleTitle={}
local isKeeping=false;
local cokey=nil
local ruleList_1 = {};
local ruleList_2 = {};
local curRulePageIndex=1;
local ruleContentRect = nil;
local isShowPoint = false;
local fettersListRect = nil
local fettersInfoRect = nil
local rightRect = nil
local middleBgTr = nil
local dungeonNameImg = nil
local isPassAllDungeons=false;
local data = {
    levelList={
        {
            num="",
            icon=DefaultSprite,
            sizeData=Vector3.one*0.8,
            isName=false;
            isCur=false,
            isLock=false,
            isPass=false,
            isActive=false,
            isBtn=false,
        }
    },
    heroList={
        {
            isFree=false,
            isActive=false,
            iconTexture=DefaultTexture,
            jobSprite=DefaultSprite,
            level="",
            hpSlider=0.0,
            isUp=false,
            isDown=false,
            isUpDown=false,
            lockSprite=DefaultSprite,
            isLock=false,
            isSelecting=false,
            isHp=false,
            color=color_red,
            isPro=false;
            proList={};
        }
    },
    heroingList={
        {
            isFree=false,
            isActive=false,
            iconTexture=DefaultTexture,
            jobSprite=DefaultSprite,
            level="",
            hpSlider=0.0,
            isUp=false,
            isDown=false,
            isUpDown=false,
            lockSprite=DefaultSprite,
            isLock=false,
            isSelecting=false,
            isHp=false,
            color=color_red,
            isPro=false;
            isPro_1=false;
            isPro_2=false;
            isPro_3=false;
            isPro4_isOn=false;
            isPro_4=false;
        }
    },
    proItemList={
        {
            isOn=false;
            sizeData=Vector2.zero;
        }  
    },

    dungeonName=DefaultSprite,
    dungeonLevel="",
    conditionList={
        {
            text="",
        }
    },
    monsterList={
        {
            sizeData=Vector2(420,150),
            name="",
            enemyDatas={{}}
        }
    },
    sucessConditionIsOn=true;
    isPopRuleInfo=false;

    ruleList={{ruleInfo=""}},
    ruleTextAnchor=Vector2(0,0),
    ruleTitle = "",
    isShowPoint = false,
    pointLight_1 = false,
    pointLight_2 = false,
    
    isNor = false,
    isShowNextRuleBtn = false,
    isShowPreRuleBtn = false,

    fettersList = {{fettersId = "", talentIcon = "", showIcon = false}},
    fettersName = "",
    fettersBuffList = {{buffDes = ""}},
    fettersInfoPos = Vector2.zero,
    fettersInfoSize = Vector2.zero,
    fettersInfoArrowPos = Vector2.zero,
    fettersInfoActive = false,
    fettersGroupActive = false,

    isTireBuffText=false;
    isTiredTips=false;
    tiredText1="",
    tiredText2="",
    tiredText3="",
    tiredTipsText="",


    teamWeaponBtnActive = false,
    teamWeaponSkillIcon = DefaultTexture,
    teamWeaponSkillIconActive = false,
}

local command = {
    heroingBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
            this.HeroingList_Remove(index,nil);
        end
    },
    heroBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
           this.FreshHeroList(index);
        end
    },
    sucessConditionTog={
        type=XLuaCommandType.Bool,
        execute=function(vm,isOn,param)
            if isOn then
                this.SetConditions("0");
            end
        end
    },
    failConditonTog={
        type=XLuaCommandType.Bool,
        execute=function(vm,isOn,param)
            if isOn then
                this.SetConditions("1")
            end
        end
    },
    ruleBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.isPopRuleInfo=true;
            this.ShowRule();
        end
    },
    closeRuleBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.isPopRuleInfo=false;
        end
    },
    moreMonsterBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if monsterConfigTable == nil or next(monsterConfigTable) == nil then
                return
            end
            isKeeping=true;
            LuaMgr.ShowLuaPanel(UIName.TrainingTowerEnemyViewModel, curDungeon, monsterConfigTable, cfgBattleTower)
        end
    },
    startBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if #members==0 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrainingTowerLevelViewModel_0"));
                return
            end
            local memberDic={}
            for i,v in ipairs(members) do
                memberDic[tostring(i-1)]=v.id;
            end
            local  isOutOfPower=TrainingTowerHelper.CheckOutOfPower(memberDic);
            if not isPassAllDungeons and isOutOfPower then
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,ConfigMgr.LangGlobal("23761"),function()
                    TrainingTowerHelper.EnterDungeon(curDungeon.id, memberDic, battleGroupId, this.curTeamWeaponId);
                    TrainingTowerHelper.ClearCurTowerCache()
                end,nil);
            elseif (not FeatureManager.IsLock("33001")) and (IsNullOrEmpty(this.curTeamWeaponId)) then
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, LuaMgr.GetLangText("TrainingTowerLevelViewModel_9"),function()
                    TrainingTowerHelper.EnterDungeon(curDungeon.id, memberDic, battleGroupId, this.curTeamWeaponId);
                    TrainingTowerHelper.ClearCurTowerCache()
                end,nil);
            else
                TrainingTowerHelper.EnterDungeon(curDungeon.id, memberDic, battleGroupId, this.curTeamWeaponId);
                TrainingTowerHelper.ClearCurTowerCache()
            end
            if isPassAllDungeons then
                HeroParameter.trainingBattleDungeonId=curDungeon.id;
            end
        end
    },
    rulePointBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param);
            if curRulePageIndex == index then
                return  
            end
            curRulePageIndex = index
            local ruleList = {}
            if index == 1 then
                this.vm.data.pointLight_1 = true
                this.vm.data.pointLight_2 = false
                this.vm.data.isShowNextRuleBtn = isShowPoint
                this.vm.data.isShowPreRuleBtn = false
                ruleList = ruleList_1
            elseif index == 2 then
                this.vm.data.pointLight_1 = false
                this.vm.data.pointLight_2 = true
                this.vm.data.isShowNextRuleBtn = false
                this.vm.data.isShowPreRuleBtn = isShowPoint
                ruleList = ruleList_2
            end
            this.vm.data.ruleTitle = ruleTitle[index]

            local list={}
            for i,v in ipairs(ruleList) do
                table.insert(list,{ruleInfo=v})
            end
            this.vm.data.ruleList=list;
            LuaMgr.NextFrame(function()
                RectTool.RebuildLayoutImmediate(ruleContentRect);
            end)
        end
    },
    fettersItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            this.OnClickFettersItem(index)
        end
    },
    triedTipConfrimCommand={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.isTiredTips=false;
        end
    },
    clickHeadingTriedCommand={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param)+1;
            local hero_Id=this.vm.data.heroingList[index].heroId;
            this.ShowTiredTips(hero_Id);
        end
    },
    clickHeadTriedCommand={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param)+1;
            local hero_Id=this.vm.data.heroList[index].heroId;
            this.ShowTiredTips(hero_Id);
        end
    },
    btnPassCommand={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param)+1;
            for i,v in ipairs(this.vm.data.levelList) do
                v.sizeData=i==index and Vector3.one or Vector3.one*0.8;
                v.isCur=i==index;
            end
            local levelDungeonId=this.vm.data.levelList[index].dungeonId
            curDungeon=ConfigMgr.Config.dungeonMap[levelDungeonId];
            this.SetRightInfo();
        end
    },
    teamWeaponCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.TeamWeaponActivityPreparePopup, battleGroupId, this.SetTeamWeaponSkillCB)
        end
    },
}


this.ShowTiredTips=function(heroId)
    this.vm.data.isTiredTips=true;
    local heroAttr=DataMgr.Player.TowerCharAttrs[heroId];
    local FightNum=IsNull(heroAttr.FightNum) and 0 or heroAttr.FightNum;
    local maxFightNum=IsNull(ConfigMgr.Config.constants.TiredLimit) and 0 or ConfigMgr.Config.constants.TiredLimit;
    this.vm.data.tiredText1=string.format("%s",ConfigMgr.LangGlobal("23764"))
    this.vm.data.tiredText2=string.format("%s",ConfigMgr.LangGlobal("23765"))
    local tips=ConfigMgr.LangGlobal("23769");

    if cfgBattleTower~=nil and not IsNull(cfgBattleTower.ActiveBuff) and  #cfgBattleTower.ActiveBuff>0 and FightNum<3 then
        if FightNum==0 then
            tips=ConfigMgr.LangGlobal("23771");
        elseif FightNum==1 then
            tips=ConfigMgr.LangGlobal("23772");
        end
        this.vm.data.tiredText3=string.format("%s%s",ConfigMgr.LangGlobal("23766"),tips)
        return;
    end
    if maxFightNum>0 then
        if FightNum==maxFightNum then
            tips=ConfigMgr.LangGlobal("23767");
        elseif FightNum-maxFightNum>=1 then
            tips=ConfigMgr.LangGlobal("23768");
        end
    end
    this.vm.data.tiredText3=string.format("%s%s",ConfigMgr.LangGlobal("23766"),tips)
end



local hook = {
    before_awake = function(vm)
        this.vm=vm;
        isKeeping=false;
        middleBgTr = vm.behaviour.transform:Find("root/Middle/BG")
        dungeonNameImg = vm.behaviour.transform:Find("root/Right/dungenName/X"):GetComponent("Image");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        local data=vm.behaviour.Params;

        if ruleContentRect == nil then
            ruleContentRect = vm.behaviour.transform:Find("root/Middle/ruleInfo/BG/Scroll View/Viewport/Content"):GetComponent('RectTransform')
        end
        if fettersListRect == nil then
            fettersListRect = vm.behaviour.transform:Find("root/Right/FettersGroup/Scroll View/Viewport/fettersList"):GetComponent("RectTransform")
        end
        if fettersInfoRect == nil then
            fettersInfoRect = vm.behaviour.transform:Find("root/Right/FettersInfo"):GetComponent("RectTransform")
        end
        if rightRect == nil then
            rightRect = vm.behaviour.transform:Find("root/Right"):GetComponent("RectTransform")
        end
        
        if data.Length>0 then
            battleGroupId=data[0];
            dungeonNameSpriteStr=data[1];
            if isKeeping then
                isKeeping=false;
                return;
            end
            this.ParseData();
        end
        LuaMgr.AddUIEventListener(UIEventConst.EnterBattleTowerError, this.OnAskRefreshRotation)
        LuaMgr.AddUIEventListener(UIEventConst.BattlePrepareFetterRefresh, this.SetFetters)
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.EnterBattleTowerError, this.OnAskRefreshRotation);
        LuaMgr.RemoveUIEventListener(UIEventConst.BattlePrepareFetterRefresh, this.SetFetters)
        LuaMgr.RemoveUpdate(this.UpdateHandler)
    end,
}

this.OnBack=function()
    LuaMgr.ShowLuaPanel(UIName.TrainingTowerViewModel)
end
this.CheckOnBack=function()
    if HeroParameter.trainingBattleDungeonId~=nil then
        return false;
    end
    if  DataMgr.Player.Tower.Dungeon=="" and DataMgr.Player.TowerRecords[battleGroupId]~=nil then
        LuaMgr.Back();
        return true;
    end
    return false
end


this.ParseData=function()
    this.vm.data.isPopRuleInfo=false;
    this.vm.data.isTiredTips=false;
    dataTower=DataMgr.Player.Tower;
    dataTowerRecords=DataMgr.Player.TowerRecords;
    dataTowerCharCopy=DataMgr.Player.TowerCharsCopy;
    curDungeon=ConfigMgr.Config.dungeonMap[dataTower.Dungeon];
    cfgBattleTower=ConfigMgr.Config.BattleTowerMap[battleGroupId];
    if this.CheckOnBack() then
        return;
    end
    members={};
    dataTowerCharAttrs={};
    if not IsNull(dataTower.Members) and dataTower.Members~=nil  then
        for i,v in pairs(dataTower.Members) do
            if DataMgr.Player.TowerCharAttrs[v].LockRound==0 then
                table.insert(members,{loc=i,id=v})
            end
        end
        table.sort(members,function(a, b)  return a.loc<b.loc end)
    end
    local attrs=DataMgr.Player.TowerCharAttrs;
    for i,v in pairs(attrs) do
        table.insert(dataTowerCharAttrs,v);
    end
    table.sort(dataTowerCharAttrs,function(a, b) return a.ID<b.ID end);
    isPassAllDungeons=TrainingTowerHelper.CheckIsPassBattle(battleGroupId);
    this.SetBg();
    this.SetLeftInfo();
    this.SetRightInfo();
end

this.SetBg=function()
    local themeName = ""
    if cfgBattleTower.RotationType == 1 then
        themeName = "sui"
    elseif cfgBattleTower.RotationType == 2 or cfgBattleTower.RotationType == 3 then
        themeName = "shou"
    elseif cfgBattleTower.RotationType == 4 then
        themeName = TrainingTowerHelper.GetThemeGroupNameByThemeName(cfgBattleTower.RotationUI)
    end
    for i = 1, middleBgTr.childCount do
        local child = middleBgTr:GetChild(i - 1)
        child.gameObject:SetActive(child.name == themeName);
    end
end

this.SetLeftInfo=function()
    levelName = {LuaMgr.GetLangText("TrainingTowerLevelViewModel_2"),LuaMgr.GetLangText("TrainingTowerLevelViewModel_3"),
                 LuaMgr.GetLangText("TrainingTowerLevelViewModel_4"),LuaMgr.GetLangText("TrainingTowerLevelViewModel_5"),
                 LuaMgr.GetLangText("TrainingTowerLevelViewModel_6")}
    ruleTitle = {LuaMgr.GetLangText("TrainingTowerLevelViewModel_7"), LuaMgr.GetLangText("TrainingTowerLevelViewModel_8")}
    this.SetLevelList();

    this.SetHeroingList();
    this.SetHeroList();
    this.SetTeamWeaponSkill()
end


this.SetLevelList=function()
    this.vm.data.levelList={};
    local list={};
    local levelItem=nil;
    local dungeonList={};
    for i,v in pairs(ConfigMgr.Config.dungeonMap) do
        if string.match(v.id,battleGroupId)~=nil then
            table.insert(dungeonList,v);
        end
    end
    table.sort(dungeonList,function(a, b) return a.id<b.id end)
    if not isPassAllDungeons then
        for i,v in ipairs(dungeonList) do
            levelItem={
                dungeonId=v.id;
                num=levelName[i],
                icon=LuaMgr.GetSprite("TrainingTower","ui_pt_gk_yuan"..i),
                sizeData=v.id==dataTower.Dungeon and Vector3.one or Vector3.one*0.8,
                isName=v.id==dataTower.Dungeon,
                isCur=v.id==dataTower.Dungeon,
                isLock=v.id>dataTower.Dungeon,
                isPass=v.id<dataTower.Dungeon,
                isBtn=false,
                isActive=false,
            }
            table.insert(list,levelItem);
        end
    else
        local curIndex=this.GetCurIndexByPassAllDungeons(dungeonList);
        for i,v in ipairs(dungeonList) do
            levelItem={
                dungeonId=v.id,
                num=levelName[i],
                icon=LuaMgr.GetSprite("TrainingTower","ui_pt_gk_yuan"..i),
                sizeData=i==curIndex and Vector3.one or Vector3.one*0.8,
                isCur=i==curIndex,
                isLock=false,
                isPass=false,
                isName=true,
                isBtn=true,
                isActive=false,
            }
            table.insert(list,levelItem);
        end
        curDungeon=dungeonList[curIndex];
    end
    this.vm.data.levelList=list;
    if cokey~=nil then
        coroutine_runner.stop(cokey)
    end
    cokey=coroutine_runner.start(function()
        coroutine_runner.wait(0.2)
        for i,v in ipairs(this.vm.data.levelList) do
            v.isActive=true
            coroutine_runner.wait(0.05)
        end
    end)
end

this.GetCurIndexByPassAllDungeons=function(dungeonList)
    local curIndex=1;
    if HeroParameter.trainingBattleDungeonId~=nil then
        for i,v in ipairs(dungeonList) do
            if v.id==HeroParameter.trainingBattleDungeonId then
                curIndex=i;
                break;
            end
        end
    end
    return curIndex;
end



this.CheckHeroInMemers=function(heroId)
    for i,v in ipairs(members) do
        if v.id==heroId then
            return true;
        end
    end
    return false;
end


this.HeroingList_Remove=function(index,heroId)
    local hero_Id=heroId;
    if hero_Id==nil then
        hero_Id=this.vm.data.heroingList[index].heroId;
    end
    if hero_Id~=nil then
        for i,v in pairs(members) do
            if v.id==hero_Id then
                table.remove(members,i);
            end
        end
    end
    this.SetHeroingList();

    if heroId==nil then
        for i,v in ipairs(this.vm.data.heroList) do
            if v.heroId==hero_Id then
                v.isSelecting=false;
                break
            end
        end
    end
end


this.HeroingList_Add=function(heroId)
    if #members==6 then
        print("waring members count>6")
        return;
    end
    local index=#members+1;
    table.insert(members,{loc=index,id=heroId});
    this.SetHeroingList();
end


this.FreshHeroList=function(index)
    local heroItem=this.vm.data.heroList[index];
    if heroItem.isSelecting then
        heroItem.isSelecting=false;
        this.HeroingList_Remove(index,heroItem.heroId)
    else
        if #members>=6 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrainingTowerLevelViewModel_1"));
            return
        end
        heroItem.isSelecting=true;
        this.HeroingList_Add(heroItem.heroId);
    end
end


this.SetHeroingList=function()

    local list={}
    local heroItem=nil;
    local isShowTiredBuff=TrainingTowerHelper.CheckIsTiredBuff(battleGroupId);
    if isPassAllDungeons then
        isShowTiredBuff=false;
    end
    for i=1,6,1 do
        local heroAttr=nil;
        if members[i]~=nil then
            heroAttr=DataMgr.Player.TowerCharAttrs[members[i].id];
        end
        if heroAttr==nil or heroAttr.LockRound~=0 then
            heroItem={
                heroId="",
                isFree=true,
                isActive=false,
                iconTexture=DefaultSprite,
                jobSprite=DefaultSprite,
                level="1",
                hpSlider=0.0,
                isUp=false,
                isDown=false,
                isUpDown=false,
                isLock=false,
                isSelecting=false,
                orderNum=7;
                
            }
        else
            heroItem=TrainingTowerHelper.CreateHeroItem(heroAttr,isShowTiredBuff);
            if heroItem.isPro then

                local remainCount=ConfigMgr.Config.constants.TiredLimit-heroAttr.FightNum;
                heroItem.isPro4_isOn=ConfigMgr.Config.constants.TiredLimit>3;
                heroItem.isPro_1=remainCount>=1
                heroItem.isPro_2=remainCount>=2
                heroItem.isPro_3=remainCount>=3
                heroItem.isPro_4=remainCount>=4
            end
            if heroItem.hpSlider<0.2 then
                heroItem.color=color_red
            elseif heroItem.hpSlider<0.5 then
                heroItem.color=color_yellow
            else
                heroItem.color=color_green;
            end
            heroItem.orderNum=i;
        end
        table.insert(list,heroItem);
    end
    table.sort(list,function(a, b) return a.orderNum<b.orderNum end)
    this.vm.data.heroingList=list;
end


this.SetHeroList=function()
    this.vm.data.heroList={};
    local list={};
    local heroItem=nil;
    local isShowTiredBuff=TrainingTowerHelper.CheckIsTiredBuff(battleGroupId);
    this.vm.data.isTireBuffText=isShowTiredBuff;
    this.vm.data.tiredTipsText=isPassAllDungeons and ConfigMgr.LangGlobal("23770") or ConfigMgr.LangGlobal("23763");
    if isPassAllDungeons then
        isShowTiredBuff=false;
    end
    for i,v in ipairs(dataTowerCharAttrs) do
        heroItem=TrainingTowerHelper.CreateHeroItem(v,isShowTiredBuff);
        if heroItem.hpSlider<0.2 then
            heroItem.color=color_red
        elseif heroItem.hpSlider<0.5 then
            heroItem.color=color_yellow
        else
            heroItem.color=color_green;
        end
        if heroItem.isLock then
            heroItem.lockSprite=LuaMgr.GetSprite("TrainingTower","ui_pt_jxz_tx_zbz"..v.LockRound)
        end
        heroItem.isSelecting=this.CheckHeroInMemers(v.ID);
        table.insert(list,heroItem);
    end
    this.vm.data.heroList=list;
end

function this.SetTeamWeaponSkill()
    if FeatureManager.IsLock("33001") or cfgBattleTower == nil then
        this.vm.data.teamWeaponBtnActive = false
        return
    end
    this.vm.data.teamWeaponBtnActive = true

    local savedTeamSkillId = UnityEngine.PlayerPrefs.GetString(DataMgr.Player.uid .. "TrainingTowerLevelViewModel.SetTeamWeaponSkill" .. battleGroupId)
    if IsNullOrEmpty(savedTeamSkillId) then
        this.curTeamWeaponId = ""
    else
        this.curTeamWeaponId = savedTeamSkillId
    end
    ActivityBattlePrepareMgr.SetTeamWeaponId(battleGroupId, this.curTeamWeaponId)
    if IsNullOrEmpty(this.curTeamWeaponId) then
        this.vm.data.teamWeaponSkillIconActive = false
    else
        this.vm.data.teamWeaponSkillIconActive = true
        local teamWeaponCfg = TeamWeaponMgr.GetTeamWeaponCfg(this.curTeamWeaponId)
        local skillId = teamWeaponCfg.TeamWeaponSkill[1]
        this.vm.data.teamWeaponSkillIcon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(string.gsub(skillId, "ex", "")))
    end
end

function this.SetTeamWeaponSkillCB(teamWeaponId)
    UnityEngine.PlayerPrefs.SetString(DataMgr.Player.uid .. "TrainingTowerLevelViewModel.SetTeamWeaponSkill" .. battleGroupId, teamWeaponId)
    this.SetTeamWeaponSkill()
end


this.SetRightInfo=function()
    if curDungeon==nil then return end;
    conditions={};

    this.vm.data.dungeonName=LuaMgr.GetSprite("TrainingTower", dungeonNameSpriteStr == "" and "ui_pt_btz1" or dungeonNameSpriteStr)
    dungeonNameImg:SetNativeSize();
    LuaMgr.NextFrame(function()
        dungeonNameImg:SetNativeSize();
    end)
    this.vm.data.isNor = cfgBattleTower.RotationType == 1
    this.vm.data.dungeonLevel=tostring(curDungeon.levelShow);
    this.vm.data.sucessConditionIsOn=true;
    local victory=LuaMgr.GetLangText(curDungeon.victoryTitleLan);
    local strs = NumTool.split(curDungeon.battleTurnEnd, ';')
    if (strs ~= nil and #strs == 2) then
        local battleTurnEnd = tonumber(strs[2])
        if battleTurnEnd > 0 then
            victory = victory .. "1_" .. string.format(LuaMgr.GetLangText('LangGlobalLan_LangGlobal_name_5068'),battleTurnEnd)
        end
    end
    local cons=NumTool.split(victory,";");
    local type_c={};
    for i,v in ipairs(cons) do
        type_c=NumTool.split(v,"_");
        if #type_c>1 then
            if conditions[type_c[1]]==nil then
                conditions[type_c[1]]={};
            end
            table.insert(conditions[type_c[1]],type_c[2]);
        end
    end
    this.SetConditions("0");

    local list,monsterTable=TrainingTowerHelper.GetDuneonEnemys(curDungeon);;
    monsterConfigTable=monsterTable;
    this.vm.data.monsterList=list;
    this.SetFetters()
end


this.SetConditions=function(type)
    local con_type=conditions[type];
    if con_type==nil or #con_type==0 then return end;
    local list={};
    for i,v in ipairs(con_type) do
        local textItem={
            text=v;
        }
        table.insert(list,textItem);
    end
    this.vm.data.conditionList=list;
end

this.ShowRule=function()
    this.vm.data.ruleTextAnchor=Vector2(0,0);
    
    local ruleList
    ruleList_1 = TrainingTowerHelper.GetRuleText(cfgBattleTower.RuleShow, 1)
    ruleList_2 = TrainingTowerHelper.GetRuleText(cfgBattleTower.RuleShow, 2)

    curRulePageIndex = 1
    if next(ruleList_1) == nil then
        ruleList = ruleList_2
        isShowPoint = false
        this.vm.data.isShowPoint = false
    elseif next(ruleList_2) == nil then
        ruleList = ruleList_1
        isShowPoint = false
        curRulePageIndex = 2
        this.vm.data.isShowPoint = false
    else
        ruleList = ruleList_1
        isShowPoint = true
        this.vm.data.pointLight_1 = true
        this.vm.data.pointLight_2 = false
        this.vm.data.isShowNextRuleBtn = true
        this.vm.data.isShowPreRuleBtn = false
    end
    this.vm.data.isShowPoint = isShowPoint
    this.vm.data.isShowNextRuleBtn = isShowPoint
    this.vm.data.isShowPreRuleBtn = false
    this.vm.data.ruleTitle = ruleTitle[curRulePageIndex]
    local list={}
    for i,v in ipairs(ruleList) do
        table.insert(list,{ruleInfo=v})
    end
    this.vm.data.ruleList=list;
    list=nil;
end

this.OnAskRefreshRotation = function()
    TrainingTowerHelper.OnAskGetCurrentRotation(function()
        this.OnBack()
    end)
end


this.SetFetters = function()
    local tempList = {}
    local fetterIndex = 0
    if not IsNull(DataMgr.Player.TowerSelectedRelicsTalent) and next(DataMgr.Player.TowerSelectedRelicsTalent) then
        for k, v in pairs(DataMgr.Player.TowerSelectedRelicsTalent) do
            fetterIndex = fetterIndex + 1
            if fetterIndex <= 6 then
                local fettersCfg = ConfigMgr.Config.OriginsTalentMap[k]
                local talentIdList = fettersCfg.TalentId
                local tempItem = {
                    fettersId = k,
                    order = fettersCfg.OtOrder,
                    showIcon = DataMgr.Player.TowerSelectedRelicsTalent[k] ~= nil
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
    this.vm.data.fettersGroupActive = true
    this.vm.data.fettersList = tempList
end

this.OnClickFettersItem = function(index)
    local fettersId = this.vm.data.fettersList[index].fettersId
    local fettersCfg = ConfigMgr.Config.OriginsTalentMap[fettersId]
    local width, height = 0, 0
    if fettersCfg == nil or not this.vm.data.fettersList[index].showIcon then
        return
    end

    local itemRect = fettersListRect:GetChild(index - 1):GetComponent("RectTransform")
    local itemPosInRightRect = LuaMgr.World2Local(itemRect.position, rightRect)

    local name = LuaMgr.GetLangText(fettersCfg.OtNameLan)
    local nameLength = LuaMgr.GetStringLength(name)
    this.vm.data.fettersName = name
    width = 170 + nameLength * 17

    local teleten = ConfigMgr.Config.talentBankMap

    local tempList = {}
    for i, v in ipairs(fettersCfg.TalentId) do
        local tempItem = {}
        tempItem.buffDes = LuaMgr.GetLangText(teleten[v].DescriptionLan)
        local buffLength = LuaMgr.GetStringLength(tempItem.buffDes)
        width = math.max(width, 220 + buffLength * 8)
        table.insert(tempList, tempItem)
    end
    height = 95 + #tempList * 15

    local infoPosX = itemPosInRightRect.x - 60
    if -infoPosX - width <= 10 then
        infoPosX = - width - 10
    end

    this.vm.data.fettersBuffList = tempList
    this.vm.data.fettersInfoPos = Vector2(infoPosX, itemPosInRightRect.y + 40)
    this.vm.data.fettersInfoArrowPos = Vector2(itemPosInRightRect.x, itemPosInRightRect.y + 34)
    this.vm.data.fettersInfoSize = Vector2(width, height)
    this.vm.data.fettersInfoActive = true
    LuaMgr.AddUpdate(this.UpdateHandler)
end

this.UpdateHandler = function()
    if (this.vm.data.fettersInfoActive and CS.Laigu.Tools.RaycastTool.GetMouseButtonDown(0)) then
        local screenPos = CS.Laigu.Tools.RaycastTool.GetMousePosition()
        local localPoint = LuaMgr.Screen2Local(Vector2(screenPos.x, screenPos.y), fettersInfoRect)
        if not fettersInfoRect.rect:Contains(localPoint) then
            this.vm.data.fettersInfoActive = false
            LuaMgr.RemoveUpdate(this.UpdateHandler)
        end
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})