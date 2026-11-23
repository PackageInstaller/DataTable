






require("ViewModel/TrainingTower/TrainingTower_CardItem")

local this = {vm=nil};
local battleGroupId=nil;
local dungeonNameSpriteStr=nil;
local heroData=nil;
local heroConfig=nil;
local heroList={};
local battleList={};
local cfgCharacters={};
local sequenceType=nil;
local jobType=nil;
local sortType=nil;
local lastHeadIndex=nil;
local heroCount=nil;
local cfgBattleTower=nil;;
local cfgRuleMap=nil;
local tweener=nil;
local heroContentTf=nil;
local infos1Content=nil;
local infos2Content=nil;
local isFastSelectState=false
local fastSelectList={}
local curEditorIndex=nil;
local formationContent=nil;
local characterItemObj;
local formationUIList=nil;
local middleBgTr = nil;


local data = {
    heroListContentAnchor=Vector2(0,0);
    heroList={
        {
            iconTexture = DefaultTexture,
            jobSprite = DefaultSprite,
            level = "",
            isFastSelect=false,
            index=""
        }
    },
    numList={
        {
            isOn = false;
        }
    },
    numPro="";

    isLevel=false,
    isStart=false,
    isLevelUp=false,
    isLevelDown=false,
    isStarUp=false,
    isStarDown=false,
    
    isConditonInfo=false;

    conditionList={
        {
            isOn=false,
            isOff=false,
            text="",
        }
    },

    rewardList={
        {
            isReward=false;
            showDungeonIndex = false,
            dungeonIndexStr = "",
        }
    },
    bodyPath = "",

    name = "",jobIcon = DefaultSprite,maxLevel = "",level = "",
    equipNull = false,equipInfo = false,
    detailsNull = false,detailsInfo =false,
    skillName = "",skillLevel = "",skillIntro = "",
    equipRare = DefaultSprite,equipIcon = DefaultTexture,equipLevel = "",
    attrList = {{attrIcon = DefaultSprite,attrName = "",attrValue = ""}},
    skillList = {{skillIcon = DefaultTexture,ex = Vector3.zero,lock = Vector3.zero,type = DefaultSprite,level = Vector3.zero,levelText = ""}},
    

    isEnemyInfos=false;
    monsterListContentAnchor=Vector2(0,0);
    monsterListContentHeight = Vector2(420,0),
    enemyDatas = {{ icon = DefaultTexture, border = DefaultSprite, type = DefaultSprite, isType = false, isShow = false }},
    monsterList={
        {
            anchoredPos = Vector2(0, 0),
            sizeData=Vector2(420,150),
            name="",
            enemyDatas={{}}
        }
    },
    infosAnchorPos=Vector2(0,0),
    

    ruleList_1={
        {
            ruleInfo="";
        }
    },
    ruleList_2={
        {
            ruleInfo="";
        }
    },
    ruleIsEmpty_1 = false,
    ruleIsEmpty_2 = false,
    ruleContentAnchorPos=Vector2(0,0);
    heroListScrViewSizeData=Vector2(452,520);
        
    selectBtnText = "",
  
    isShowFastSelectBtn = false,
    isShowNorSelectBtn = false,
  

    isFormationPanel=false;
    isCharacterSelectPanel=false;
    isStartBtnGray=false,
    isStartEffectActive=true,
}

local command = {
    headBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;

            if isFastSelectState then
                local fastHero=this.vm.data.heroList[index]
                if not fastHero.isFastSelect then
                    if #fastSelectList>=heroCount then
                        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrainingTowerChoiceViewModel_2"))
                        return
                    end
                    table.insert(fastSelectList,fastHero.id)
                    fastHero.isFastSelect=true
                    fastHero.index=#fastSelectList;
                    this.SetHeroInfo(fastHero.id);
                else
                    fastHero.isFastSelect=false
                    for i,v in ipairs(fastSelectList) do
                        if v==fastHero.id then
                            table.remove(fastSelectList,i);
                            break
                        end
                    end

                    for i,v in ipairs(this.vm.data.heroList) do
                        if v.isFastSelect then
                            this.CheckFastState(v)
                        end
                    end
                end
            else

                if lastHeadIndex~=nil and lastHeadIndex~=index  then
                    this.vm.data.heroList[lastHeadIndex].isSelect=false;
                end
                if this.vm.data.heroList[index].isSelect then
                    this.vm.data.heroList[index].isSelect=false;
                    lastHeadIndex=nil;
                    TrainingTowerHelper.curOperaHeroId="";
                else
                    this.vm.data.heroList[index].isSelect=true;
                    local heroItem=this.vm.data.heroList[index];
                    TrainingTowerHelper.curOperaHeroId =heroItem.id;
                    this.SetHeroInfo(heroItem.id);
                    lastHeadIndex=index;
                end
            end
           
        end
    },
    sortLevelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.isLevel=true;
            this.vm.data.isStart=false;
            this.vm.data.isLevelDown=true;
            this.vm.data.isLevelUp=false;
            sortType=HeroSortType.Level
            sequenceType=SequenceType.FromBigToSmall;
            this.HeroListSort();
            this.SetHeroList();
        end
    },
    sortRareBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.isLevel=false;
            this.vm.data.isStart=true;
            this.vm.data.isStarUp=false;
            this.vm.data.isStarDown=true;
            sortType=HeroSortType.Rare
            sequenceType=SequenceType.FromBigToSmall;;
            this.HeroListSort();
            this.SetHeroList();
        end
    },
    sortMoreBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            HeroParameter.SaveListParam(jobType,sortType,sequenceType,0,1)
            LuaMgr.ShowLuaPanel(UIName.FilterSortViewModel,"tower")
        end
    },
    levelSortSwitch={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local isOn=this.vm.data.isLevelDown;
            this.vm.data.isLevelUp=isOn;
            this.vm.data.isLevelDown=not isOn;
            sequenceType=not isOn and SequenceType.FromBigToSmall or SequenceType.FromSmallToBig;
            this.HeroListSort();
            this.SetHeroList();
        end
    },
    rareSortSwitch={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local isOn=this.vm.data.isStarDown;
            this.vm.data.isStarDown=not isOn
            this.vm.data.isStarUp=isOn;
            sequenceType=not isOn and SequenceType.FromBigToSmall or SequenceType.FromSmallToBig;
            this.HeroListSort();
            this.SetHeroList();
        end
    },
    skillItemCommand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index = tonumber(param) + 1
            local skillId = this.vm.data.skillList[index].skillId
            local level = this.vm.data.skillList[index].intLevel
            LuaMgr.ShowPanel(UIName.SkillTipsViewModel,SkillType.Character,heroConfig.id,skillId,nil,SkillShowType.Team,false,level,false)
        end
    },
    monsterBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.monsterListContentAnchor=Vector2(0,0)
            this.vm.data.isConditonInfo=false;
            this.vm.data.isEnemyInfos=true;
            this.SetEnemysList();
        end
    },
    monsterClose= {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.isConditonInfo=true;
            this.vm.data.isEnemyInfos=false;
        end
    },
    startBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.OnAskTowerOpen();
        end
    },
    cultivateCommand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local position = 0
            local tempList = {}
            table.insert(tempList, heroConfig.id)
            HeroParameter.SaveListParam(jobType,sortType,sequenceType,position,1,tempList)
            TrainingTowerHelper.SetCache(heroConfig.id,battleList,heroContentTf.anchoredPosition)
            TrainingTowerHelper.isJumpCultivate=true;
            TrainingTowerHelper.selectHeroId=heroConfig.id;
            TrainingTowerHelper.battleList=battleList;
            TrainingTowerHelper.fastSelectList=fastSelectList;
            TrainingTowerHelper.isfastSelectState=isFastSelectState;
            FeatureManager.GotoPanel("1003")
        end
    },
    fastSelectBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)

            isFastSelectState=true;
            fastSelectList=table.Copy(battleList)
            this.SetHeroInfo(battleList[1])
            this.SwitchPanel(false)
        end
    },
    selectConfrimBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if isFastSelectState then
                battleList=table.Copy(fastSelectList);
            else
                if lastHeadIndex~=nil and lastHeadIndex~="" then
                    local headItem=this.vm.data.heroList[lastHeadIndex]
                    if battleList[curEditorIndex]==nil then
                        table.insert(battleList,headItem.id);
                    else
                        battleList[curEditorIndex]=headItem.id;
                    end
                else
                    if #battleList>=curEditorIndex then
                        table.remove(battleList,curEditorIndex);
                    end
                end
            end
            this.AutoCheckConditions();
            this.SwitchPanel(true);
        end
    },
    selectCancelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            fastSelectList={};
            lastHeadIndex=nil;
            this.SwitchPanel(true)
        end
    },
    
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        local tf=vm.behaviour.transform;
        heroContentTf=tf:Find("root/Left/Heros/Scroll View/Viewport/Content"):GetComponent("RectTransform");
        infos1Content=tf:Find("root/Right/infos/Content/Role1/rule_info/Scroll View/Viewport/Content"):GetComponent("Transform")
        infos2Content=tf:Find("root/Right/infos/Content/Role2/rule_info/Scroll View/Viewport/Content"):GetComponent("Transform")
        formationContent=tf:Find("root/Middle/formationPanel/content");
        characterItemObj=tf:Find("template/characterItem").gameObject;
        middleBgTr = vm.behaviour.transform:Find("root/Middle/BG")
        formationUIList=UIListView.New(formationContent);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        local data=vm.behaviour.Params;
        if data.Length>0 then
            this.AdjusetScreen();
            battleGroupId=data[0];
            dungeonNameSpriteStr=data[1]
            cfgCharacters=ConfigMgr.Config.characterTable;
            cfgBattleTower=ConfigMgr.Config.BattleTowerMap[battleGroupId];
            cfgRuleMap=ConfigMgr.Config.BTRuleMap
            heroCount=tonumber(cfgBattleTower.Condition[1][2]);
            this.vm.data.isLevel=true;
            this.vm.data.isStart=false;
            this.vm.data.isLevelDown=true;
            this.vm.data.isLevelUp=false;
            this.vm.data.detailsNull=true;
            this.vm.data.detailsInfo=false;
            this.vm.data.isConditonInfo=true;
            this.vm.data.isEnemyInfos=false;
            this.vm.data.infosAnchorPos=Vector2(0,0);
            this.vm.data.monsterList={};
            battleList={};
            fastSelectList={}
            lastHeadIndex=nil;
            if TrainingTowerHelper.isJumpCultivate then
                battleList=TrainingTowerHelper.battleList;
                fastSelectList=TrainingTowerHelper.fastSelectList
                this.SetFastSelectStatus(TrainingTowerHelper.isfastSelectState)
                this.SwitchPanel(false)
                if TrainingTowerHelper.selectHeroId~="" then
                    this.SetHeroInfo(TrainingTowerHelper.selectHeroId)
                end
                TrainingTowerHelper.ClearCache();
            else
                this.SetFastSelectStatus(true);
                this.SwitchPanel(true)
            end
            this.ParseData();
            LuaMgr.RemoveUIEventListener(UIEventConst.UpdateHeroList,this.SetCharacterPanel)
            LuaMgr.AddUIEventListener(UIEventConst.UpdateHeroList,this.SetCharacterPanel)
            this.AutoCheckConditions();
        end
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.UpdateHeroList,this.SetCharacterPanel)
        if TrainingTowerHelper.selectHeroId==nil or TrainingTowerHelper.selectHeroId=="" then
            HeroParameter.EmptyJobSort()
        end
    end,
    before_destroy=function(vm)
        heroContentTf=nil;
        this.vm.data=nil;
        this.vm.behaviour=nil;
        this.vm=nil
        this=nil;
        UIListView.ClearItem("TrainingTower_CardItem")
    end
    
}


this.OnAskTowerOpen=function()
    local re=this.CheckEnterConditions();
    if not re then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrainingTowerChoiceViewModel_0"));
        return;
    end
    local characters={}
    for i,v in ipairs(battleList) do
        characters[v]=tonumber(this.GetHeroHp(v));
    end
    local askData={};
    askData.GroupId=battleGroupId;
    askData.Choices=characters;
    ApiMgr.Request("tower2/open",askData,true,function(re)
        LuaMgr.ShowLuaPanel(UIName.TrainingTowerLevelViewModel,battleGroupId,dungeonNameSpriteStr);
        HeroParameter.trainingBattleDungeonId=nil;
    end,nil,true)
end


this.SwitchPanel=function(isFormation)
    this.vm.data.isFormationPanel=isFormation;
    this.vm.data.isCharacterSelectPanel=not isFormation;
    if isFormation then
        this.SetFormationPanel();
        this.vm.behaviour:UpdateTopBar("", function()
            LuaMgr.Back();
        end);
    else
        this.SetCharacterPanel();
        this.vm.behaviour:UpdateTopBar("", function()
            this.SwitchPanel(true)
        end);
        
    end
end


this.SetCharacterPanel=function()
    jobType = HeroParameter.paramBool and HeroParameter.jobType or CharacterJob.All
    sortType = HeroParameter.paramBool and HeroParameter.sortType or HeroSortType.Level
    sequenceType = HeroParameter.paramBool and HeroParameter.sequenceType or SequenceType.FromBigToSmall
    this.SetSortBtnState();
    this.InitDataHero();
    this.HeroListSort();
    this.SetHeroList();
    
end


this.ParseData=function() ;
    this.SetOtherInfos();
    this.ShowDropRewards();
end


this.AdjusetScreen=function()
    local scrWidth=LuaMgr.GetScreenWidth();
    local value=scrWidth-450-350;
    local num=math.floor((value-10)/(120-10))
    local width=120*num-(num-1)*10
    this.vm.data.heroListScrViewSizeData=Vector2(width,520)
end

this.SetSortBtnState=function()
    if sortType==HeroSortType.Rare then
        this.vm.data.isLevel=false;
        this.vm.data.isStart=true;
        this.vm.data.isStarUp=false;
        this.vm.data.isStarDown=true;
        local isDown=sequenceType==SequenceType.FromBigToSmall
        this.vm.data.isStarUp=not isDown
        this.vm.data.isStarDown=isDown
    elseif sortType==HeroSortType.Level then
        this.vm.data.isLevel=true;
        this.vm.data.isStart=false;
        this.vm.data.isLevelDown=true;
        this.vm.data.isLevelUp=false;
        local isDown=sequenceType==SequenceType.FromBigToSmall
        this.vm.data.isLevelUp=not isDown;
        this.vm.data.isLevelDown=isDown;
    else
        this.vm.data.isLevel=false;
        this.vm.data.isStart=false;
        this.vm.data.isStarUp=false;
        this.vm.data.isStarDown=true;
        this.vm.data.isLevelUp=false;
        this.vm.data.isLevelDown=true;
    end
end

this.InitDataHero = function()
    heroList = {}
    local heroConfig = nil
    local characters=table.Copy(DataMgr.Player.characters);
    for key,value in pairs(characters) do
        if not this.CheckRemoveBattleHero(value) then
            heroConfig = ConfigMgr.Config.characterTable[key]
            if jobType == CharacterJob.All or jobType == heroConfig.job  then
                if heroConfig ~= nil then
                    value.rare = heroConfig.rare
                    value.name = LuaMgr.GetLangText(heroConfig.namelan)
                    value.job = heroConfig.job
                    value.choice = false
                    value.num = 0
                    table.insert(heroList,value)
                end
            end
        end
        
    end
end

this.CheckRemoveBattleHero=function(value)
    if isFastSelectState then return false end;
    local editorHeroId=nil
    editorHeroId=battleList[curEditorIndex]
    if value.id==editorHeroId then return false end;
    
    for i,v in ipairs(battleList) do
        if value.id==v then
            return true;
        end
    end
    return false;
    
end 
    

this.IsInSelect=function(value)
    if isFastSelectState then
        for i,v in ipairs(fastSelectList) do
            if v==value.id then
                value.battleIndex=i;
                return true;
            end
        end
        return false
    else
        return TrainingTowerHelper.curOperaHeroId==value.id;
    end
end

this.CheckFastState=function(heroItem)
    if #fastSelectList==0 then return  end
    for i,v in ipairs(fastSelectList) do
        if v==heroItem.id then
            heroItem.isFastSelect=true;
            heroItem.index=tostring(i);
            return
        end
    end
end

this.SetHeroList=function()
    local heroItem=nil;
    this.vm.data.heroList={}
    local list={}
    for i,v in ipairs(heroList) do
        heroItem={
            id=v.id,
            iconTexture = LuaMgr.GetTexture(ConfigHelper.GetHeadIconPath(v.id,v.curSkin)),
            jobSprite = LuaMgr.GetSprite("JobIcon","job2_"..v.job),
            level = tostring(v.level),
            isSelect = false,
            isFastSelect = false;
            index=""
        }
        if isFastSelectState then

            this.CheckFastState(heroItem);
        else
            if heroItem.id == TrainingTowerHelper.curOperaHeroId then
                heroItem.isSelect=true;
                lastHeadIndex=i;
            end
        end
        table.insert(list,heroItem);
    end
    this.vm.data.heroList=list;
    this.HeroListDoAnimation();
end


this.HeroListDoAnimation=function()
    if tweener~=nil then
        tweener:Kill();
    end
local tarVector=Vector2(0,0)
    if TrainingTowerHelper.viewPos~=Vector2(0,0) then
        tarVector=TrainingTowerHelper.viewPos;
    end
    tweener=DOTWeen.To(function() return tarVector+Vector2(0,-15) end,function(vector)
        heroContentTf.anchoredPosition=vector
    end,tarVector,0.5);
    
end




this.SetOtherInfos=function()
    this.SetBg();
    this.SetConditions();
    this.SetRuleInfo();
    coroutine_runner.start(function()
        coroutine_runner.wait(0.1)
        RectTransformTool.RebuildLayoutImmediate(infos1Content);
        RectTransformTool.RebuildLayoutImmediate(infos2Content);
    end)
    
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

this.SetRuleInfo=function()
    this.vm.data.ruleContentAnchorPos=Vector2(0,0);
    local rules=TrainingTowerHelper.GetRuleText(cfgBattleTower.RuleShow, 1);
    local list={}
    for i,v in ipairs(rules) do
        table.insert(list,{ ruleInfo=v });
    end
    this.vm.data.ruleIsEmpty_1 = next(list) == nil
    this.vm.data.ruleList_1=list;

    rules=TrainingTowerHelper.GetRuleText(cfgBattleTower.RuleShow, 2);
    list={}
    for i,v in ipairs(rules) do
        table.insert(list,{ ruleInfo=v });
    end    
    this.vm.data.ruleIsEmpty_2 = next(list) == nil
    this.vm.data.ruleList_2=list;
end

this.SetConditions=function()
    local lanText=LuaMgr.GetLangText(cfgBattleTower.ConditionShowLan);
    local conditions=NumTool.split(lanText,";")
    local list={}
    for i,v in ipairs(conditions) do
        if not IsNullOrEmpty(v) then
            local condiItem={
                text=string.gsub(v,"\n",""),
                isOn=false,
                isOff=true;
            }
            table.insert(list,condiItem);
        end
    end
    this.vm.data.conditionList=list;
end

this.AutoCheckConditions=function()
    local conditions=cfgBattleTower.Condition
    local re=false
    for i,v in ipairs(conditions) do
        if i <= #this.vm.data.conditionList then
            re=this.CheckCondition(v)
            this.vm.data.conditionList[i].isOn=re
            this.vm.data.conditionList[i].isOff=not re
        end
    end
    
    local isEnter = this.CheckEnterConditions()
    this.vm.data.isStartEffectActive = isEnter
    this.vm.data.isStartBtnGray = not isEnter
end



this.CheckEnterConditions=function()
    if battleList==nil or #battleList==0 then return false,LuaMgr.GetLangText("TrainingTowerChoiceViewModel_1") end;
    local conditions=cfgBattleTower.Condition
    for i,v in ipairs(conditions) do
        if not this.CheckCondition(v) then
            return false;
        end
    end
    return true;
    
end

this.CheckCondition=function(v)
    local re=true
    if v[1]=="number" then
        re=TrainingTowerHelper.CheckCondition_HeroNum(battleList,v);
    elseif v[1]=="level" then
        re=TrainingTowerHelper.CheckCondition_HeroLevel(battleList,v);
    elseif v[1]=="job" then
        re=TrainingTowerHelper.CheckCondition_HeroJob(battleList,v);
    elseif v[1]=="quality" then
        re=TrainingTowerHelper.CheckCondition_HeroQuality(battleList,v);
    end
    return re;
end

this.ShowDropRewards=function()
    this.vm.data.rewardList={};
    local list={}
    local rewardItem=nil;
    local rewards=cfgBattleTower.Drop;
    local stageRewards = cfgBattleTower.StageReward
    local record=DataMgr.Player.TowerRewards[cfgBattleTower.GroupId]
    if not IsNull(rewards) then
        for i,v in ipairs(rewards) do
            rewardItem=ConfigHelper.CreateGoodsItem(v.id,v.count,0.52,true,true)
            if rewardItem~=nil then
                rewardItem.isReward=record~=nil and not record;
                rewardItem.showDungeonIndex = false
                table.insert(list,rewardItem);
            end
        end
    elseif not IsNull(stageRewards) then
        local dungeonList = TrainingTowerHelper.GetDungeonListByGroupId(cfgBattleTower.GroupId)
        for i,v in ipairs(stageRewards) do
            if dungeonList[i] ~= nil then
                local dungeonId = dungeonList[i].id
                rewardItem=ConfigHelper.CreateGoodsItem(v.id,v.count,0.52,true,true)
                if rewardItem~=nil then
                    rewardItem.showDungeonIndex = true
                    rewardItem.dungeonIndexStr = HeroMgr.GetNumStr(i)
                    rewardItem.isReward = DataMgr.Player.TowerStageRewards[dungeonId] ~= nil and not DataMgr.Player.TowerStageRewards[dungeonId]
                    table.insert(list,rewardItem);
                end
            end
        end
    end
    this.vm.data.rewardList=list;
end

this.SetHeroInfo=function(heroId)
    if heroId==nil then
        this.vm.data.detailsNull = true;
        this.vm.data.detailsInfo = false;
        return
    end;
    this.vm.data.detailsNull = false
    this.vm.data.detailsInfo = true;
    heroData = table.Copy(DataMgr.Player.characters[heroId])
    heroConfig = ConfigMgr.Config.characterTable[heroId]

    this.vm.data.bodyPath=HeroManager.GetCharacterDrawing(heroData.id);
    this.vm.data.name = LuaMgr.GetLangText(heroConfig.namelan)
    this.vm.data.jobIcon = LuaMgr.GetSprite("JobIcon","job_"..heroConfig.job)
    this.vm.data.maxLevel = string.format("/%d",ConfigMgr.Config.constants.maxCharacterLevel)
    this.vm.data.level=heroData.level;
    this.SetSelectHeroAttr();
    this.SetSelectHeroSkill();
    this.SetSelectHeroEquip();
end


this.SetSelectHeroEquip = function()
    local equipId = ""
    if heroData.wear ~= "" then
        equipId = DataMgr.Player.equipments[heroData.wear].equipmentId
    end
    if equipId == "" then
        this.vm.data.equipNull = true;
        this.vm.data.equipRare = LuaMgr.GetSprite("ItemRare","itemRareK")
    else
        local equipConfig = ConfigMgr.Config.equipments[equipId]
        local equipData = DataMgr.Player.equipments[heroData.wear]
        this.vm.data.equipRare = LuaMgr.GetSprite("ItemRare","itemRare"..equipConfig.rare)
        this.vm.data.equipIcon = LuaMgr.GetTexture("Assets/_BundleResources/Images/ItemIcons/itemicon_"..equipId..".png")
        this.vm.data.equipLevel = string.format("lv.%d",equipData.level)
        if #equipConfig.equipSkill > 0 then
            local skill = ConfigMgr.Config.equipmentSkills[equipConfig.equipSkill[1]][tostring(equipData.star)]
            this.vm.data.skillName = LuaMgr.GetLangText(skill.NameLan)
            this.vm.data.skillLevel = tostring(equipData.star)
            this.vm.data.skillIntro = LuaMgr.GetEquipSkillText(equipData.equipmentId,equipData.star)
        end
        this.vm.data.equipNull = false
    end
    this.vm.data.equipInfo = equipId ~= ""
end


this.GetHeroHp=function(heroID)
    local curHero=DataMgr.Player.characters[heroID];
    if curHero==nil then return 0 end;
    local heroJob = ConfigMgr.Config.characterTable[heroID].job


    if heroJob==nil then return 0 end;
    local attrTab = {}
    local attrs = HeroMgr.GetMainAttrList()
    local fetterCfgMap = ConfigMgr.Config.OriginsTalentMap
    local selectFetterMap = DataMgr.Player.selectedRelicsTalent
    local fetterTalentList = {}
    for k, v in pairs(selectFetterMap) do
        local fetterCfg = fetterCfgMap[k]
        if fetterCfg ~= nil and fetterCfg.TalentId ~= nil and #fetterCfg.TalentId > 0 and fetterCfg.TalentId[1] ~= nil then
            table.insert(fetterTalentList, fetterCfg.TalentId[1])
        end
    end

    local attrList = HeroManager.GetCollectionAddAttr(heroJob)
    if not IsObjectNull(attrList) then
        for i = 1, attrList.Count do
            table.insert(fetterTalentList, attrList[i - 1])
        end
    end

    if curHero.wear ~= "" then
        local dataJson = json.encode(DataMgr.Player.equipments[curHero.wear])
        attrTab = LuaMgr.GetCharacterPropertyCopy(curHero.id,dataJson,this.GetHeroAttrKey(attrs), -1, 0, fetterTalentList)
    else
        attrTab = LuaMgr.GetCharacterPropertyCopy(curHero.id,"",this.GetHeroAttrKey(attrs), -1, 0, fetterTalentList)
    end
    attrTab = json.decode(attrTab)
    
    return attrTab.Hp
end


this.SetSelectHeroAttr = function()
    local attrTab = {}
    local attrs = HeroMgr.GetMainAttrList()
    if heroData.wear ~= "" then
        local dataJson = json.encode(DataMgr.Player.equipments[heroData.wear])
        attrTab = LuaMgr.GetCharacterPropertyCopy(heroData.id,dataJson,this.GetHeroAttrKey(attrs))
    else
        attrTab = LuaMgr.GetCharacterPropertyCopy(heroData.id,"",this.GetHeroAttrKey(attrs))
    end
    attrTab = json.decode(attrTab)
    local tempList = {}
    local tempItem = {}
    for i = 1, #attrs do

        local attrValue = LuaMgr.GetShowAttrValue(attrs[i].PanelScopeControl, attrs[i].id, attrTab[attrs[i].id])
        tempItem = {attrIcon = LuaMgr.GetSprite("AttributeIcon",attrs[i].id),
                    attrName = LuaMgr.GetLangText(attrs[i].NameLan),attrValue = attrValue}
        table.insert(tempList,tempItem)
    end
    this.vm.data.attrList = tempList
end
this.GetHeroAttrKey = function(data)
    local attrKey = {}
    for i = 1, #data do
        table.insert(attrKey,data[i].id)
    end
    return attrKey
end

this.SetSelectHeroSkill = function()
    local key = ""
    local skillData = {}
    local skillConfig = {}
    local tempList = {}
    local tempItem = {}
    for i = 1, #HeroMgr.SkillList do
        key = HeroMgr.SkillList[i]
        skillData = table.Copy(heroData.skills[key])
        tempItem = {skillIcon = DefaultTexture,ex = Vector3.zero,lock = Vector3.zero,type = DefaultSprite,level = Vector3.zero,levelText = ""}
        tempItem.skillIcon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(string.gsub(skillData.groupId, "ex", "")))
        if i - 1 < 3 then
            skillConfig = ConfigSkillMgr.GetCharacterSkill(skillData.groupId..skillData.level)
        else
            skillConfig = ConfigSkillMgr.GetCharacterPassiveSkill(skillData.groupId..skillData.level)
        end
        tempItem.ex = string.match(skillData.groupId,"%a%a",-2) == nil and Vector3.zero or Vector3.one
        tempItem.lock = skillData.locking and Vector3.one or Vector3.zero
        if skillConfig~=nil then
            tempItem.type = LuaMgr.GetSprite("HeroRes","skillType_"..skillConfig.Type)
        else
            LuaDebug.error("skillConfig is nil")
        end
        tempItem.level = skillData.locking and Vector3.zero or Vector3.one
        tempItem.levelText = tostring(skillData.level)
        tempItem.intLevel = skillData.level
        tempItem.skillId = skillData.groupId
        table.insert(tempList,tempItem)
    end
    this.vm.data.skillList = tempList
end

this.SetEnemysList=function()
    if #this.vm.data.monsterList>1 then return end;
    local dungeonList={};
    for i,v in pairs(ConfigMgr.Config.dungeonMap) do
        if string.match(v.id,battleGroupId)~=nil then
            table.insert(dungeonList,v);
        end
    end
    table.sort(dungeonList,function(a, b) return a.id<b.id end)
    this.vm.data.monsterList={}
    local list={};
    local monsterItem=nil;
    local height = 0
    for i,v in ipairs(dungeonList) do
        monsterItem={
            name=LuaMgr.GetLangText(v.NameLan),
            enemyDatas=TrainingTowerHelper.GetDuneonEnemys(v)
        }


        local itemHeight = 0
        if #monsterItem.enemyDatas <= 4 then
            itemHeight = 121
            monsterItem.anchoredPos= Vector2(0, -height)
            monsterItem.sizeData= Vector2(420, itemHeight)
            height = height + itemHeight
        else
            local row = math.ceil(#monsterItem.enemyDatas / 4)
            itemHeight = 121 + (row - 1) * 71
            monsterItem.anchoredPos= Vector2(0, -height)
            monsterItem.sizeData= Vector2(420, itemHeight)
            height = height + itemHeight
        end
        
        table.insert(list,monsterItem);
    end
    this.vm.data.monsterList=list;
    this.vm.data.monsterListContentHeight = Vector2(420, height + 10)
end

this.HeroListSort = function()
    if sortType == HeroSortType.Level then
        table.sort(heroList,this.LevelSort)
    elseif sortType == HeroSortType.Rare then
        table.sort(heroList,this.RareSort)
    elseif sortType == HeroSortType.Star then
        table.sort(heroList,this.StarSort)
    elseif sortType == HeroSortType.Time then
        table.sort(heroList,this.TimeSort)
    elseif sortType == HeroSortType.Friendly then
        table.sort(heroList,this.FriendlySort)
    end
   

    local hasList={}
    local list={}
    for i,v in ipairs(heroList) do
        if this.IsInSelect(v) then
            table.insert(hasList,v)
        else
            table.insert(list,v)
        end
    end
    table.sort(hasList,function(a, b) return a.battleIndex<b.battleIndex end)
    for i,v in ipairs(list) do
        table.insert(hasList,v);
    end
    heroList={}
    heroList=hasList;
end


this.SetFastSelectStatus = function(isOn)
    isFastSelectState = isOn
    this.vm.data.isShowFastSelectBtn = not isFastSelectState
    this.vm.data.isShowNorSelectBtn = isFastSelectState
end




this.LevelSort = function(a,b)
    if a.level ~= b.level then
        if sequenceType == SequenceType.FromBigToSmall then
            return HeroMgr.LevelSortBigToSmall(a,b)
        else
            return HeroMgr.LevelSortSmallToBig(a,b)
        end
    elseif HeroMgr.GetHeroRareSort(a.id) ~= HeroMgr.GetHeroRareSort(b.id) then
        return HeroMgr.RareSortBigToSmall(a,b)
    elseif a.star ~= b.star then
        return HeroMgr.StarSortBigToSmall(a,b)
    else
        return HeroMgr.HeroIdSort(a,b)
    end
end


this.RareSort = function(a,b)
    if HeroMgr.GetHeroRareSort(a.id) ~= HeroMgr.GetHeroRareSort(b.id) then
        if sequenceType == SequenceType.FromBigToSmall then
            return HeroMgr.RareSortBigToSmall(a,b)
        else
            return HeroMgr.RareSortSmallToBig(a,b)
        end
    elseif a.level ~= b.level then
        return HeroMgr.LevelSortBigToSmall(a,b)
    elseif a.star ~= b.star then
        return HeroMgr.StarSortBigToSmall(a,b)
    else
        return HeroMgr.HeroIdSort(a,b)
    end
end


this.StarSort = function(a,b)
    if a.star ~= b.star then
        if sequenceType == SequenceType.FromBigToSmall then
            return HeroMgr.StarSortBigToSmall(a,b)
        else
            return HeroMgr.StarSortSmallToBig(a,b)
        end
    elseif a.level ~= b.level then
        return HeroMgr.LevelSortBigToSmall(a,b)
    elseif HeroMgr.GetHeroRareSort(a.id) ~= HeroMgr.GetHeroRareSort(b.id) then
        return HeroMgr.RareSortBigToSmall(a,b)
    else
        return HeroMgr.HeroIdSort(a,b)
    end
end


this.TimeSort = function(a,b)
    if a.time ~= b.time then
        if sequenceType == SequenceType.FromBigToSmall then
            return HeroMgr.TimeSortEarlyToLate(a,b)
        else
            return HeroMgr.TimeSortLateToEarly(a,b)
        end
    elseif a.star ~= b.star then
        return HeroMgr.StarSortBigToSmall(a,b)
    elseif a.level ~= b.level then
        return HeroMgr.LevelSortBigToSmall(a,b)
    elseif HeroMgr.GetHeroRareSort(a.id) ~= HeroMgr.GetHeroRareSort(b.id) then
        return HeroMgr.RareSortBigToSmall(a,b)
    else
        return HeroMgr.HeroIdSort(a,b)
    end
end


this.FriendlySort = function(a,b)
    if a.prestigeLevel ~= b.prestigeLevel then
        if this.sequenceType == SequenceType.FromBigToSmall then
            return HeroMgr.FriendlySortBigToSmall(a,b)
        else
            return HeroMgr.FriendlySortSmallToBig(a,b)
        end
    elseif a.prestige ~= b.prestige then
        if this.sequenceType == SequenceType.FromBigToSmall then
            return HeroMgr.FriendlyExpSortBigToSmall(a,b)
        else
            return HeroMgr.FriendlyExpSortSmallToBig(a,b)
        end
    elseif a.level ~= b.level then
        return HeroMgr.LevelSortBigToSmall(a,b)
    elseif a.star ~= b.star then
        return HeroMgr.StarSortBigToSmall(a,b)
    elseif HeroMgr.GetHeroRareSort(a.id) ~= HeroMgr.GetHeroRareSort(b.id) then
        return HeroMgr.RareSortBigToSmall(a,b)
    else
        return HeroMgr.HeroIdSort(a,b)
    end
end




this.SetFormationPanel=function()
    local list={}
    for i=1,12,1 do
        local cardItem={index=i,isLock=false,isAdd=false,isCard=false,heroData=nil,callBack=this.formationItemClick}
        if i>heroCount then
            cardItem.isLock=true;
            cardItem.isAdd=false;
            cardItem.isCard=false;
        elseif i>#battleList and i<=heroCount then
            cardItem.isLock=false;
            cardItem.isAdd=true;
            cardItem.isCard=false;
        else
            cardItem.isLock=false;
            cardItem.isAdd=false;
            cardItem.isCard=true;
            cardItem.heroData={};
            if DataMgr.Player.characters[battleList[i]]~=nil then
                heroConfig = ConfigMgr.Config.characterTable[battleList[i]]
                cardItem.heroData=table.Copy(DataMgr.Player.characters[battleList[i]])
                cardItem.heroData.rare=heroConfig.rare;
                cardItem.heroData.name = LuaMgr.GetLangText(heroConfig.namelan)
                cardItem.heroData.job = heroConfig.job
            end
        end
        local cardData=UIListData.GetData(characterItemObj,"TrainingTower_CardItem",cardItem);
        table.insert(list,cardData);
    end
    formationUIList:SetData(list);
end


this.formationItemClick=function(index)
    isFastSelectState=false;
    curEditorIndex=index;
    lastHeadIndex=nil;
    this.SetHeroInfo(battleList[index])
    if battleList[index]~=nil then
        TrainingTowerHelper.curOperaHeroId=battleList[index];
    end
    this.SwitchPanel(false)
    
end



return vm({
    data = data,
    command = command,
    hook = hook
})