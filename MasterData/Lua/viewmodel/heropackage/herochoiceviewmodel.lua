




local this = {vm = nil,jobType = nil,sortType = nil,sequenceType = nil,StrFormat = string.format,
              TableInsert = table.insert,TableSort = table.sort,TabRemove = table.remove,
              ToString = tostring,ToNumber = tonumber,scrollRect = nil,content = nil,scrollReuse = nil,
              qSpineCharacter = nil,spineCharacterMask = nil,heroConfig = nil,heroData = nil, originHeroData = nil,
              defaultIndex = nil,heroTable = {},changeAfterTeam = {}, contentAnchorPos = Vector2.zero,
              heroType=1;isAttention = false,
}

local data = {
    viewWidth = Vector2(810,632),
    numPosition = Vector2.zero,numSize = Vector3.zero,moreCount = "",
    rareBtn = Vector3.zero,rareBtnOrder = Vector3.zero,
    levelBtn = Vector3.zero,levelBtnOrder = Vector3.zero,
    detailsNull = Vector3.zero,detailsInfo = Vector3.zero,
    equipNull = Vector3.zero,equipInfo = false,
    equipRare = DefaultSprite,equipIcon = DefaultTexture,equipLevel = "",
    skillName = "",skillLevel = "",skillIntro = "",
    name = "",jobIcon = DefaultSprite,level = "",
    heroList = {{heroPic = DefaultTexture,heroRare = DefaultSprite,heroLevel = "",heroJob = DefaultSprite,heroZZ = DefaultSprite,
                 zzText = "",heroName = "",select = Vector3.zero,num = Vector3.zero,numSprite = DefaultSprite, tryActor=false}},
    attrList = {{attrIcon = DefaultSprite,attrName = "",attrValue = ""}},
    skillList = {{skillIcon = DefaultTexture,ex = Vector3.zero,lock = Vector3.zero,type = DefaultSprite,level = Vector3.zero,levelText = ""}},

    isLeveling=false,

    isNormal=false,
    isCultivate=false,
    isDetail = false,
    leveling_Up=false, 
    leveling_Down=false,
    leveling_tipText="",
    leveling_jointBool=false;
    isBody = true,
    bodyPath = "",
    aniName = "",
    

    training_offset = 0,
    training_tipText = "",
    training_tipShow = false,
    contentAnchorPos = Vector2.zero,
    

assisHeroGroupActive=false;
    assistHeroCountPos=Vector2(640,-330);
    isAssisInquire=false;
    heroType_assis=false;
    heroType_my=false;
    assistHeroCount="",
    assistDailyCount="",

    isDungeon66Tips = false,
    dungeon66Tips = "",

    isMiniBattleTips = false,
    miniBattleTips = "",

    isCrisisContract2Tips = false,
    crisisContract2Tips = "",

    isMiniBattle2Tips = false,
    miniBattle2Tips = "",

    isMiniBattle3Tips = false,
    miniBattle3Tips = "",

    isMiniBattle4Tips = false,
    miniBattle4Tips = "",
    

    isTeamTowerTips = false,
    
    attentionText = "",
    attention = false,
}

local command = {
    levelSortCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.sortType == HeroSortType.Level then
                if this.sequenceType == SequenceType.FromBigToSmall then
                    this.sequenceType = SequenceType.FromSmallToBig
                else
                    this.sequenceType = SequenceType.FromBigToSmall
                end
            else
                this.sortType = HeroSortType.Level
                this.sequenceType = SequenceType.FromBigToSmall
            end
            this.CreateHeroItem()
        end
    },
    rareSortCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.sortType == HeroSortType.Rare then
                if this.sequenceType == SequenceType.FromBigToSmall then
                    this.sequenceType = SequenceType.FromSmallToBig
                else
                    this.sequenceType = SequenceType.FromBigToSmall
                end
            else
                this.sortType = HeroSortType.Rare
                this.sequenceType = SequenceType.FromBigToSmall
            end
            this.CreateHeroItem()
        end
    },
    featureCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local position = 0
            HeroParameter.SaveListParam(this.jobType,this.sortType,this.sequenceType,position,1)
            LuaMgr.ShowLuaPanel(UIName.FilterSortViewModel)
        end
    },
    cancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            HeroParameter.EmptyTeamParam()
            this.VoyageBack();
            this.Dungeon66Back();
            this.TeamTowerBack();
            this.ClosePanel()
            this.CommonSelectCharacterBack();
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.GetChangeAfterTeam()

if HeroParameter.battleBool == true then
if HeroParameter.whetherSave then
                    this.RequestSaveTeam(HeroParameter.SaveTeamChangeParam)
                else
                    if HeroParameter.selectCharacterCallBack~=nil then                        
if HeroParameter.selectType then
HeroParameter.selectCharacterCallBack(HeroParameter.selectCharacterCallBackExtendParams,table.Copy(HeroParameter.battleMembers));
                        else
                            local temp={};
                            table.insert(temp,HeroParameter.clickHero);
HeroParameter.selectCharacterCallBack(HeroParameter.selectCharacterCallBackExtendParams,table.Copy(temp));
                        end
                        
                    end
                    HeroParameter.SaveTeamChangeParam(this.changeAfterTeam)
if HeroParameter.isOnlySelectCharacter then
HeroParameter.EmptyBattlePrepareParam();
HeroParameter.ClearCommonSelectCharacter();
                    end
                end
            else               
                this.RequestSaveTeam(HeroParameter.callback)
                return
            end

            PlayerAssistMgr.SaveAssistMembers();
            this.ClosePanel();
        end
    },
    cultivateCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local type=tonumber(param);
            local position = 0
            local tempList = {}

            if this.heroType==2 then
                PlayerAssistMgr.SetCurAssistData(this.heroData.uid,this.heroData.id);
            end
            table.insert(tempList, this.heroConfig.id)
            HeroParameter.SaveListParam(this.jobType,this.sortType,this.sequenceType,position,1,tempList)
            if HeroParameter.selectType then
                HeroParameter.clickHero = this.heroConfig.id
            end
            PlayerAssistMgr.heroIndex=this.heroType;
            FeatureManager.GotoPanel("1003")
        end
    },
    detailCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local type=tonumber(param);
            if HeroParameter.isRogueTeam then
                RogueMgr.ShowCharacterDetailInfo(this.heroConfig.id)
                return
            end
            
            local position = 0
            local tempList = {}

            if this.heroType==2 then
                PlayerAssistMgr.SetCurAssistData(this.heroData.uid,this.heroData.id);
            end
            table.insert(tempList, this.heroConfig.id)
            HeroParameter.SaveListParam(this.jobType,this.sortType,this.sequenceType,position,1,tempList)
            if HeroParameter.selectType then
                HeroParameter.clickHero = this.heroConfig.id
            end
            PlayerAssistMgr.heroIndex=this.heroType;
            FeatureManager.GotoPanel("1003")
        end
    },
    skillItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = param + 1
            local skillId = this.vm.data.skillList[index].skillId
            local level = this.vm.data.skillList[index].intLevel
            LuaMgr.ShowPanel(UIName.SkillTipsViewModel,SkillType.Character,this.heroConfig.id,skillId,nil,SkillShowType.Team,false,level,BattlePrepareMgr.isLeveling,false,this.heroType==2)
        end
    },
    weaponCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local equipData = BattlePrepareMgr.levelingData.equipmentDataMap[this.heroData.wear]
            if IsNullOrEmpty(equipData) then
                return
            end
            local equipJson = json.encode(equipData)
            LuaMgr.ShowPanel(UIName.WeaponTipsViewModel, "-1", "", false, equipJson)
        end
    },
    SwitchHeroTypeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
           local index=tonumber(param);
            if index==this.heroType then return end;
            this.heroType=index;
            this.SetHeroTypeInfo();
            this.UpdateSelectHero(nil)
            this.InitShowHero()
            this.CreateHeroItem();
        end
    },
    attentionCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.heroType == 2 then
                local tipStr = ConfigMgr.LangGlobal("22665")
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
                return
            end
            if this.isAttention then
                UnityEngine.PlayerPrefs.SetInt("HeroPackageAttention",0)
            else
                UnityEngine.PlayerPrefs.SetInt("HeroPackageAttention",1)
            end
            this.SetAttention()
            this.CreateHeroItem();
        end
    },
}


local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.scrollRect = vm.behaviour.transform:Find("root/Middle/HeroView"):GetComponent("ScrollRect")
        this.content = vm.behaviour.transform:Find("root/Middle/HeroView/Viewport/Content")
        this.qSpineCharacter = vm.behaviour.transform:Find("root/Left/Details/UISpineCharacterMask/Rect/Body"):GetComponent("UISpineCharacter")
        this.spineCharacterMask = vm.behaviour.transform:Find("root/Left/Details/UISpineCharacterMask"):GetComponent("UISpineCharacterMask")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm.behaviour:UpdateTopBar("", function()
            this.VoyageBack();
            this.Dungeon66Back();
            this.ActivityBattleBack();
            this.RogueBack()
            this.ClosePanel()
            this.CommonSelectCharacterBack();
            PlayerAssistMgr.heroIndex=nil;
        end)
        if (HeroParameter.battleBool and HeroParameter.battleMembers == nil) or (not HeroParameter.battleBool and HeroParameter.teamMembers == nil) then
            LuaMgr.NextFrame(function()
                LuaMgr.Back()
            end)
        end
        if (HeroParameter.activityKey == ActivityKey.crisiscontract2 or HeroParameter.activityKey == ActivityKey.crisiscontract3) then
            AudioMgr.Singleton:PlayBgm("Assets/_BundleResources/Audio/Bgm/bgm_crisisContract2.mp3", true);
        elseif (HeroParameter.isRogueHeroInfo or HeroParameter.isRogueTeam) then
            LuaMgr.SetShowRogueCharacterData(true)
            AudioMgr.Singleton:PlayBgm("Assets/_BundleResources/Audio/Bgm/bgm_RogueActivity.mp3", true);  
        end
        this.vm.data.attentionText = ConfigMgr.LangGlobal("2606")

        this.heroType=1;
        this.vm.data.leveling_tipText=""
        if BattlePrepareMgr.isLeveling then
            this.vm.data.leveling_tipText=ConfigMgr.LangGlobal("2721");
        end
        this.assistHeroUid=nil;
        if vm.behaviour.IsPop and PlayerAssistMgr.heroIndex~=nil and PlayerAssistMgr.heroIndex==2 then
            this.assistHeroUid=PlayerAssistMgr.GetCurAssist_HeroUid();
        end
        PlayerAssistMgr.ClearCurAssistData();
        this.vm.data.isLeveling=BattlePrepareMgr.isLeveling;
        this.vm.data.isNormal=not BattlePrepareMgr.isLeveling;

        this.vm.data.leveling_jointBool=false;
        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish,this.OnAniPlayFinish)
        this.vm.data.aniName = "ani_HeroChoicePanel_root_001";
        this.spineCharacterMask:StartMove();
        LuaMgr.AddUIEventListener(UIEventConst.ScrollRectReuse,this.OnValueChange)
        LuaMgr.AddUIEventListener(UIEventConst.heroCardChoiceClick,this.ChoiceHeroItem)
        this.ViewAdaptive()
        this.InitParameter()

        this.SetAttention()
        this.CreateHeroItem()
        LuaMgr.AddUIEventListener(UIEventConst.UpdateHeroList,this.FilterSortCallBack)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.heroTable = {}
        this.vm.data.bodyPath = "";
        this.qSpineCharacter:Clear()
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        LuaMgr.RemoveUIEventListener(UIEventConst.UpdateHeroList,this.FilterSortCallBack)
        LuaMgr.RemoveUIEventListener(UIEventConst.ScrollRectReuse,this.OnValueChange)
        LuaMgr.RemoveUIEventListener(UIEventConst.heroCardChoiceClick,this.ChoiceHeroItem)
        LuaMgr.CheckRefCount();
        LuaMgr.SetShowRogueCharacterData(false)
    end,
    before_destroy = function(vm)
        this.DeletePanel()
        this = nil
    end,
}


this.OnAniPlayFinish = function(args)

    if args[0] == "ani_HeroChoicePanel_root_001" then
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        LuaMgr.NextFrame(function()
            if this == nil then return end
            this.spineCharacterMask:StopMove();
        end, 20)
    end
end


this.ViewAdaptive = function()
    local addWidth = LuaMgr.GetScreenAddWidth()
    addWidth = addWidth > 0 and addWidth or 0;
    this.vm.data.viewWidth = Vector2(810 + addWidth,632)
    this.vm.data.numPosition = Vector2(-408 - addWidth,-335)
end


this.InitParameter = function()
    this.jobType = HeroParameter.paramBool and HeroParameter.jobType or CharacterJob.All
    this.sortType = HeroParameter.paramBool and HeroParameter.sortType or HeroSortType.Level
    this.sequenceType = HeroParameter.paramBool and HeroParameter.sequenceType or SequenceType.FromBigToSmall
    local heroId = ""
    local tempMembers = {}
    if HeroParameter.battleBool == true then
        tempMembers = HeroParameter.battleMembers
    else
        tempMembers = HeroParameter.teamMembers
    end

    if TableIsNull(tempMembers) then
        tempMembers = {}
    end
    if (HeroParameter.heroCount ~= nil) then
        this.vm.data.moreCount = this.StrFormat("%d/%d",#tempMembers,HeroParameter.heroCount);
    elseif HeroParameter.commonCharacterCount~=nil then
        this.vm.data.moreCount = this.StrFormat("%d/%d",#tempMembers,HeroParameter.commonCharacterCount);
    else

        this.vm.data.moreCount = this.StrFormat("%d/%d",#tempMembers,6)
    end

    this.vm.data.assistHeroCount=this.StrFormat("%d/%d",PlayerAssistMgr.GetTempMemberCount()+NumTool.GetLen(PlayerAssistMgr.otherAssistMember),PlayerAssistMgr.supportNum)
    this.vm.data.assistDailyCount=string.format("<color=#eccc38>%s</color>/%s",PlayerAssistMgr.RemainAssistCount(),ConfigMgr.Config.FriendConstants.TotalBorrowLimit);
    if HeroParameter.selectType then
        if HeroParameter.clickHero == "" then
            if tempMembers[1] ~= nil then
                heroId = tempMembers[1]
            end
        else
            heroId = HeroParameter.clickHero
        end
    else
        heroId = HeroParameter.clickHero
    end
    this.vm.data.training_tipShow = false
    if (HeroParameter.isTraining) then
        local w = NumTool.GetMaxNum(HeroParameter.trainingTeamIndex);
        this.vm.data.training_tipText = string.format(LuaMgr.GetLangText("HeroChoiceViewModel_2"),w);
        this.vm.data.training_tipShow = true
    end
    this.vm.data.isDungeon66Tips = false;
    if (HeroParameter.isDungeon66) then
        this.vm.data.dungeon66Tips = HeroParameter.dungeon66Tips;
        this.vm.data.isDungeon66Tips = true;
    end
    this.vm.data.isMiniBattleTips = false;
    if (HeroParameter.activityKey == ActivityKey.MiniBattle) then
        this.vm.data.miniBattleTips = HeroParameter.activityBattleTips;
        this.vm.data.isMiniBattleTips = true;
    end
    this.vm.data.isCrisisContract2Tips = false
    if (HeroParameter.activityKey == ActivityKey.crisiscontract2 or HeroParameter.activityKey == ActivityKey.crisiscontract3) then
        this.vm.data.crisisContract2Tips = HeroParameter.activityBattleTips;
        this.vm.data.isCrisisContract2Tips = true;
    end
    this.vm.data.isMiniBattle2Tips = false
    if (HeroParameter.activityKey == ActivityKey.MiniBattlenew) then
        this.vm.data.miniBattle2Tips = HeroParameter.activityBattleTips;
        this.vm.data.isMiniBattle2Tips = true;
    end
    this.vm.data.isMiniBattle3Tips = false
    if (HeroParameter.activityKey == ActivityKey.DualBattle) then
        this.vm.data.miniBattle3Tips = HeroParameter.activityBattleTips;
        this.vm.data.isMiniBattle3Tips = true;
    end
    this.vm.data.isMiniBattle4Tips = false
    if (HeroParameter.activityKey == ActivityKey.DualBattle2) then
        this.vm.data.miniBattle4Tips = HeroParameter.activityBattleTips;
        this.vm.data.isMiniBattle4Tips = true;
    end
    this.vm.data.isTeamTowerTips = false
    if (HeroParameter.activityKey == ActivityKey.TeamTower) then
        this.vm.data.isTeamTowerTips = true;
    end
    this.vm.data.numSize = HeroParameter.selectType and Vector3.one or Vector3.zero
    this.CheckHeroType(heroId)
    this.SetHeroTypeInfo();
    this.UpdateSelectHero(heroId,this.assistHeroUid);
    this.InitShowHero()
end


this.CheckHeroType=function(heroId)

    PlayerAssistMgr.lastOpHeroId=nil;
    local isSupport= not BattlePrepareMgr.isLeveling and PlayerAssistMgr.IsOpen() and PlayerAssistMgr.isSupport;
    this.vm.data.assisHeroGroupActive=isSupport;
    if isSupport then
        this.vm.data.assistHeroCountPos=HeroParameter.selectType and Vector2(631,-330) or Vector2(485,-330)
    end
    if not isSupport then
        this.heroType=1;
        return;
    end

    if PlayerAssistMgr.heroIndex~=nil then
        this.heroType=PlayerAssistMgr.heroIndex;
        return
    end

    this.heroType=PlayerAssistMgr.IsAssistMember(heroId) and 2 or 1;
end

this.SetAttention = function()
    if UnityEngine.PlayerPrefs.HasKey("HeroPackageAttention") then
        this.isAttention = UnityEngine.PlayerPrefs.GetInt("HeroPackageAttention") == 1
    else
        this.isAttention = false
    end
    this.vm.data.attention = this.isAttention
end

this.CreateHeroItem = function()

    if TableIsNull(this) then
        return
    end
    if this.scrollReuse == nil then
        this.scrollReuse = ScrollRectReuse.New(this.content,HeroCardItem)
    end
    this.HeroListSort()
    this.scrollReuse:InitContent(#this.heroTable)
    if HeroParameter.IsShowCharacterList == nil then
        local tempIdList = {}
        for i = 1, #this.heroTable do
            this.TableInsert(tempIdList,this.heroTable[i].id)
        end
        HeroParameter.IsShowCharacterList = tempIdList
    end
    this.scrollReuse:HorizontalResetPos()

    LuaMgr.NextFrame(function()
        this.content.anchoredPosition = this.contentAnchorPos
    end)
end

this.UpdateSelectHero = function(heroId,uid)
    if heroId == nil or heroId == "" then
        this.vm.data.detailsNull = Vector3.one
        this.vm.data.detailsInfo = Vector3.zero
        this.vm.data.isBody = false;
    else
        this.vm.data.isBody = true;
        this.heroConfig = ConfigMgr.Config.characterTable[heroId]
        if (this.heroConfig == nil) then
            local actorConfig = ConfigMgr.Config.actor[heroId];
            if (actorConfig ~= nil) then
                this.heroConfig = ConfigMgr.Config.characterTable[actorConfig.CharacterId];
                this.heroData = {};
                this.heroData.id = actorConfig.CharacterId;
                this.heroData.level = actorConfig.Level;
                this.SetSelectHeroInfo();
                this.vm.data.bodyPath = HeroManager.GetCharacterDrawing(actorConfig.CharacterId);
                this.SetSelectActorAttr(actorConfig);
                this.SetSelectActorEquip(actorConfig);
                this.SetSelectActorSkill(actorConfig);
            end
        else
            if BattlePrepareMgr.isLeveling and DataMgr.Player.moreModAssist~=nil then
                local modAssist = DataMgr.Player.moreModAssist[heroId]
                if modAssist ~= nil then
                    this.heroData = modAssist.character
                end
                if this.heroData==nil then
                    this.heroData = table.Copy(DataMgr.Player.characters[heroId])
                end
            elseif HeroParameter.isRogueTeam then
                this.heroData = RogueMgr.GetCharacterDataByID(heroId)
            elseif this.heroType==2 then

                if IsNullOrEmpty(uid) then

                    uid=PlayerAssistMgr.GetAssistMemberUid(heroId);
                end
                local assistData=PlayerAssistMgr.GetAssist_Character(uid,heroId);
                PlayerAssistMgr.SetCurAssistData(uid,heroId);
                if assistData~=nil then
                    this.heroData=table.Copy(assistData);
                    this.heroData.uid=uid;
                end
                PlayerAssistMgr.lastOpHeroId=assistData.id;
            else
                this.heroData = table.Copy(DataMgr.Player.characters[heroId])
            end
            if this.heroData == nil then
                LuaDebug.error("DataMgr.Player.moreModAssist玩家多阵容数据没有找到该器者ID="..heroId)
                return
            end

            if BattlePrepareMgr.isLeveling then
                this.originHeroData = this.heroData
                this.heroData = table.Copy(BattlePrepareMgr.levelingData.characterDataMap[heroId])
            end
            this.SetSelectHeroInfo()
            this.SetSelectHeroSpine()
            this.SetSelectHeroAttr()
            this.SetSelectHeroEquip()
            this.SetSelectHeroSkill()
        end
        this.vm.data.detailsNull = Vector3.zero
        this.vm.data.detailsInfo = Vector3.one
    end
end


this.SetSelectHeroInfo = function()
    this.vm.data.name = LuaMgr.GetLangText(this.heroConfig.namelan)
    this.vm.data.jobIcon = LuaMgr.GetSprite("JobIcon","job_"..this.heroConfig.job)

    if BattlePrepareMgr.isLeveling then
        if this.heroData~=nil then
            this.vm.data.leveling_Up = this.heroData.level > this.originHeroData.level
            this.vm.data.leveling_Down = this.heroData.level < this.originHeroData.level
            this.vm.data.level = string.format("LV.%d", this.heroData.level);
            if BattlePrepareMgr.LevelingWeek_CheckJointCharacter(this.heroConfig.id) then
                this.vm.data.leveling_jointBool=true
            else
                this.vm.data.leveling_jointBool=false
            end
        else
            this.vm.data.leveling_Up =false
            this.vm.data.leveling_Down = false;
            this.vm.data.level="-1"
            this.vm.data.leveling_jointBool=false;
            print("============this.heroData is nil")
        end
        
    else
        local maxCharacterLevel = ConfigMgr.Config.constants.maxCharacterLevel;
        this.vm.data.level = string.format("LV.%d<color=#c8baa2><size=18>/%d</size></color>", this.heroData.level, maxCharacterLevel);
    end
end

this.SetSelectHeroEquip = function()
    local equipId = ""
    local equipData = nil
    if this.heroData.wear ~= "" then
        if BattlePrepareMgr.isLeveling then
            equipData = BattlePrepareMgr.levelingData.equipmentDataMap[this.heroData.wear]
        elseif HeroParameter.isRogueTeam then
            local equipmentData = json.decode(LuaMgr.GetRogueEquipment(this.heroData.id))
            equipData = equipmentData
        elseif this.heroType==2 then
            equipData=PlayerAssistMgr.GetAssist_Equipment(this.heroData.uid,this.heroData.id);
        else
            equipData = DataMgr.Player.equipments[this.heroData.wear]
        end
        equipId = equipData.equipmentId
    end
    if equipId == "" then
        this.vm.data.equipNull = Vector3.one
        this.vm.data.equipRare = LuaMgr.GetSprite("ItemRare","itemRareK")
    else
        local equipConfig = ConfigMgr.Config.equipments[equipId]
        this.vm.data.equipIcon = LuaMgr.GetTexture("Assets/_BundleResources/Images/ItemIcons/itemicon_"..equipId..".png")
        this.vm.data.equipLevel = string.format("lv.%d",equipData.level)
        if equipConfig ~= nil then
            this.vm.data.equipRare = LuaMgr.GetSprite("ItemRare","itemRare"..equipConfig.rare)
            if #equipConfig.equipSkill > 0 then
                local skill = ConfigMgr.Config.equipmentSkills[equipConfig.equipSkill[1]][this.ToString(equipData.star)]
                this.vm.data.skillName = LuaMgr.GetLangText(skill.NameLan)
                this.vm.data.skillLevel = this.ToString(equipData.star)
                if LuaMgr.GetEquipSkillText ~= nil and type(LuaMgr.GetEquipSkillText) == "function" then
                    this.vm.data.skillIntro = LuaMgr.GetEquipSkillText(equipData.equipmentId,equipData.star)
                else
                    this.vm.data.skillIntro = ""
                end
            end
        end
        this.vm.data.equipNull = Vector3.zero
    end
    this.vm.data.equipInfo = equipId ~= ""
end


this.SetSelectActorEquip = function(actorConfig)
    local equipId = actorConfig.WeaponId;
    if equipId == "" then
        this.vm.data.equipNull = Vector3.one
        this.vm.data.equipRare = LuaMgr.GetSprite("ItemRare","itemRareK")
    else
        local equipConfig = ConfigMgr.Config.equipments[equipId]
        this.vm.data.equipIcon = LuaMgr.GetTexture("Assets/_BundleResources/Images/ItemIcons/itemicon_"..equipId..".png")
        this.vm.data.equipLevel = string.format("lv.%d",actorConfig.Level)
        if equipConfig ~= nil then
            this.vm.data.equipRare = LuaMgr.GetSprite("ItemRare","itemRare"..equipConfig.rare)
            if #equipConfig.equipSkill > 0 then
                local skill = ConfigMgr.Config.equipmentSkills[equipConfig.equipSkill[1]][this.ToString(actorConfig.WeaponStar)]
                this.vm.data.skillName = LuaMgr.GetLangText(skill.NameLan)
                this.vm.data.skillLevel = this.ToString(actorConfig.star)
                this.vm.data.skillIntro = LuaMgr.GetEquipSkillText(equipConfig.id, actorConfig.star)
            end
        end
        this.vm.data.equipNull = Vector3.zero
    end
    this.vm.data.equipInfo = equipId ~= ""
end

this.SetSelectHeroSpine = function()
    this.vm.data.bodyPath = HeroManager.GetCharacterDrawing(this.heroData.id,this.heroData.curSkin);
end

this.SetSelectHeroAttr = function()
    local attrTab = {}
    local attrs = HeroMgr.GetMainAttrList()

    if BattlePrepareMgr.isLeveling then
        attrTab = LuaMgr.GetCharacterPropertyCopy(this.heroData.id, "", this.GetHeroAttrKey(attrs), this.heroData.level, 1);
    elseif HeroParameter.isRogueTeam then
        attrTab = LuaMgr.GetCharacterPropertyCopy(this.heroData.id, "", this.GetHeroAttrKey(attrs), this.heroData.level, 2);
    elseif this.heroData.wear ~= "" then
        local dataJson = json.encode(DataMgr.Player.equipments[this.heroData.wear])
        if this.heroType==2 then

            dataJson=PlayerAssistMgr.GetAssist_EquipmentJson(this.heroData.id,this.heroData.id)
        end
        attrTab = LuaMgr.GetCharacterPropertyCopy(this.heroData.id,dataJson,this.GetHeroAttrKey(attrs),-1,0,nil,this.heroData.uid)
    else
        attrTab = LuaMgr.GetCharacterPropertyCopy(this.heroData.id,"",this.GetHeroAttrKey(attrs),-1,0,nil,this.heroData.uid)
    end
    attrTab = json.decode(attrTab)
    local tempList = {}
    local tempItem = {}
    for i = 1, #attrs do
        local tempattrValue = attrTab[attrs[i].id] ~= nil and tonumber(attrTab[attrs[i].id]) or 0
        local _attrValue = LuaMgr.GetShowAttrValue(attrs[i].PanelScopeControl, attrs[i].id, tempattrValue)
        local attrIntValue = math.floor(_attrValue)
        if attrIntValue == _attrValue then
            _attrValue = tostring(attrIntValue)
        else
            _attrValue = tostring(_attrValue)
        end
        
        tempItem = {attrIcon = LuaMgr.GetSprite("AttributeIcon",attrs[i].id),
                    attrName = LuaMgr.GetLangText(attrs[i].NameLan),attrValue =_attrValue}
        this.TableInsert(tempList,tempItem)
    end
    this.vm.data.attrList = tempList
end


this.SetSelectActorAttr = function(actorConfig)
    local attrs = HeroMgr.GetMainAttrList();
    local attrTab = LuaMgr.GetActorPropertyCopy(actorConfig.ID, this.GetHeroAttrKey(attrs));
    attrTab = json.decode(attrTab)
    local tempList = {}
    local tempItem = {}
    for i = 1, #attrs do
        local tempattrValue = attrTab[attrs[i].id] ~= nil and tonumber(attrTab[attrs[i].id]) or 0
        local _attrValue = LuaMgr.GetShowAttrValue(attrs[i].PanelScopeControl, attrs[i].id, tempattrValue)
        local attrIntValue = math.floor(_attrValue)
        if attrIntValue == _attrValue then
            _attrValue = tostring(attrIntValue)
        else
            _attrValue = tostring(_attrValue)
        end
        
        tempItem = {attrIcon = LuaMgr.GetSprite("AttributeIcon",attrs[i].id),
                    attrName = LuaMgr.GetLangText(attrs[i].NameLan),attrValue =_attrValue}
        this.TableInsert(tempList,tempItem)
    end
    this.vm.data.attrList = tempList
end


this.SetSelectHeroSkill = function()
    local key = ""
    local skillData = {}
    local skillConfig = {}
    local tempList = {}
    local tempItem = {}
    for i = 1, #HeroMgr.SkillList do
        key = HeroMgr.SkillList[i]
        skillData = table.Copy(this.heroData.skills[key])
        tempItem = {skillIcon = DefaultTexture,ex = Vector3.zero,lock = Vector3.zero,type = DefaultSprite,level = Vector3.zero,levelText = ""}
        tempItem.skillIcon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(string.gsub(skillData.groupId, "ex", "")))
        if i - 1 < 3 then
            skillConfig = ConfigSkillMgr.GetCharacterSkill(skillData.groupId..skillData.level)
        else
            skillConfig = ConfigSkillMgr.GetCharacterPassiveSkill(skillData.groupId..skillData.level)
        end
        tempItem.ex = string.match(skillData.groupId,"%a%a",-2) == nil and Vector3.zero or Vector3.one
        tempItem.lock = skillData.locking and Vector3.one or Vector3.zero
        if skillConfig ~= nil then
            tempItem.type = LuaMgr.GetSprite("HeroRes","skillType_"..skillConfig.Type)
        end
        tempItem.level = skillData.locking and Vector3.zero or Vector3.one
        tempItem.levelText = this.ToString(skillData.level)
        tempItem.intLevel = skillData.level
        tempItem.skillId = skillData.groupId
        this.TableInsert(tempList,tempItem)
    end
    this.vm.data.skillList = tempList
end


this.SetSelectActorSkill = function(actorConfig)
    local skillData = nil;
    local skillConfig = nil;
    local tempItem = nil;
    local groupId;
    local level;
    local tempList = {}
    for i = 1, #HeroMgr.SkillList2 do
        skillData = actorConfig[HeroMgr.SkillList2[i]];
        groupId = skillData[1];
        level = skillData[2];
        tempItem = {skillIcon = DefaultTexture,ex = Vector3.zero,lock = Vector3.zero,type = DefaultSprite,level = Vector3.zero,levelText = ""}
        tempItem.skillIcon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(string.gsub(groupId, "ex", "")))
        if i - 1 < 3 then
            skillConfig = ConfigSkillMgr.GetCharacterSkill(groupId..level)
        else
            skillConfig = ConfigSkillMgr.GetCharacterPassiveSkill(groupId..level)
        end
        tempItem.ex = string.match(groupId,"%a%a",-2) == nil and Vector3.zero or Vector3.one
        tempItem.lock = Vector3.zero
        if skillConfig ~= nil then
            tempItem.type = LuaMgr.GetSprite("HeroRes","skillType_"..skillConfig.Type)
        end
        tempItem.level = Vector3.one
        tempItem.levelText = level
        tempItem.intLevel = tonumber(level)
        tempItem.skillId = groupId
        this.TableInsert(tempList,tempItem)
    end
    this.vm.data.skillList = tempList
end

this.HeroListSort = function()
    if this.sortType == HeroSortType.Level then
        this.TableSort(this.heroTable,this.LevelSort)
    elseif this.sortType == HeroSortType.Rare then
        this.TableSort(this.heroTable,this.RareSort)
    elseif this.sortType == HeroSortType.Star then
        this.TableSort(this.heroTable,this.StarSort)
    elseif this.sortType == HeroSortType.Time then
        this.TableSort(this.heroTable,this.TimeSort)
    elseif this.sortType == HeroSortType.Friendly then
        this.TableSort(this.heroTable,this.FriendlySort)
    end

    if this.heroType ~= 2 and this.isAttention then
        local tempList = {}
        for i = #this.heroTable, 1, -1 do
            if this.heroTable[i].focus then
                this.TableInsert(tempList,1,this.heroTable[i])
                table.remove(this.heroTable,i)
            end
        end
        for i = #tempList, 1, -1 do
            this.TableInsert(this.heroTable,1,tempList[i])
        end
    end
    

    if BattlePrepareMgr.isLeveling then
        local lockList={}
        local index=1
        for i=1,#this.heroTable do
            if this.heroTable[index].lock then
                this.TableInsert(lockList,this.heroTable[index])
                this.TabRemove(this.heroTable,index);
            else
                index=index+1
            end
        end
        for i,v in ipairs(lockList) do
            table.insert(this.heroTable,v);
        end
    end

    if this.heroType==2 then
        local lockList={}
        for i=#this.heroTable,1,-1 do
            if this.heroTable[i].assistHeroCount==0 then
                this.TableInsert(lockList,this.heroTable[i])
                this.TabRemove(this.heroTable,i);
            end
        end
        for i,v in ipairs(lockList) do
            table.insert(this.heroTable,v);
        end
    end

    this.UpdateGuideSort()
    this.UpdateActorSort();
    this.InitHeroItemState()
    this.TrainingSort()
    this.ActivityBattleSort()
    this.UpdateSortBtn()
end


this.ClearOtherAssistMask=function(heroId)
    for p,m in ipairs(this.heroTable) do
        if m.id~= heroId and (HeroParameter.anotherTeam==nil or HeroParameter.anotherTeam[m.id]==nil) then
            m.assisIsMask=false
        end
    end
    for i,v in ipairs(this.scrollReuse.templateList) do
        if v.itemId~=heroId and (HeroParameter.anotherTeam==nil or HeroParameter.anotherTeam[v.itemId]==nil) then
            v:SetAssistIsMask(false);
        end
    end
end


this.FrushHeroItemState=function(heroId,isAdd)
    if isAdd then
        for p,m in ipairs(this.heroTable) do
            if m.id == heroId then
                local isMask=this.HeroItemCheckAssistMask(m,heroId);
                m.assisIsMask=isMask
                this.SetHeroItemAssistMask(p,isMask);
            end
        end
    else
        for p,m in ipairs(this.heroTable) do
            if m.id == heroId then
                m.assisIsMask=false
                this.SetHeroItemAssistMask(p,false);
            end
        end

    end
end

this.SetHeroItemAssistMask=function(heroTableIndex,isMask)
    for i,v in ipairs(this.scrollReuse.templateList) do
        if v.index==heroTableIndex then
            v:SetAssistIsMask(isMask);
        end
    end
end



this.HeroItemCheckAssistMask=function(heroTableItem,heroId)
    local assistMembers=table.Copy(PlayerAssistMgr.GetTempMembers());

    if not IsNull(PlayerAssistMgr.otherAssistMember) then
        for i,v in pairs(PlayerAssistMgr.otherAssistMember) do
            assistMembers[i]=v;
        end
    end
    if this.heroType==1 and assistMembers[heroId]~=nil then
        return true;
    elseif this.heroType==2 and assistMembers[heroId]==nil or (assistMembers[heroId]~=nil and assistMembers[heroId].uid~=heroTableItem.uid) then
        return true;
    end
    return false;
end





this.InitHeroItemState = function()
    local tempMembers = {}
    if HeroParameter.battleBool then
        tempMembers = HeroParameter.battleMembers
    else
        tempMembers = HeroParameter.teamMembers
    end
    if HeroParameter.selectType then
        local id = ""
        local length = #tempMembers
        for i = length, 1,-1 do
            id = tempMembers[i]
            this.FindEqualHeroId(id,i)
        end
    else
        if HeroParameter.clickHero ~= nil and HeroParameter.clickHero ~= "" then
            this.FindEqualHeroId(HeroParameter.clickHero)
        else
            this.defaultIndex = -1
        end
    end

    if HeroParameter.anotherTeam~=nil then
        for _,v in pairs(HeroParameter.anotherTeam) do
            for i = 1, #this.heroTable do
                if this.heroTable[i].trainingGroupIndex==0 and  this.heroTable[i].id == v.id then
                    if this.HeroItemCheckAssistMask(this.heroTable[i],v.id) then
                        this.heroTable[i].assisIsMask=true;
                    end
                end
            end
        end
    end
end

this.FindEqualHeroId = function(heroId,order)
    for i = 1, #this.heroTable do
        if this.heroTable[i].id == heroId then
            if this.HeroItemCheckAssistMask(this.heroTable[i],heroId) then
                this.heroTable[i].assisIsMask=true;
                goto continue;
            end
            this.heroTable[i].choice = true
            if HeroParameter.selectType then
                this.heroTable[i].num = order
            else
                this.heroTable[i].num = 0

                this.defaultIndex = 1
            end
            this.ChangeSelectHeroPos(i,1)

        end
        ::continue::
    end
end


this.ChangeSelectHeroPos = function(fromIndex,toIndex)
    local item = this.heroTable[fromIndex]
    this.TabRemove(this.heroTable,fromIndex)
    this.TableInsert(this.heroTable,toIndex,item)
end


this.SingleSelectFun = function(template)
    local index,heroId = template.index,template.itemId

    if this.heroTable[index].assisIsMask then
        return;
    end
    if (this.IsActivity() and this.IsLocked(heroId)) then
        return;
    end
    local teamIndex = this.FindTeamIndex(heroId)
    local tempMembers = {}
    if HeroParameter.battleBool then
        tempMembers = HeroParameter.battleMembers
    else
        tempMembers = HeroParameter.teamMembers
    end
    if teamIndex == -1 then
        if HeroParameter.clickHero ~= nil and HeroParameter.clickHero ~= "" then
            teamIndex = this.FindTeamIndex(HeroParameter.clickHero)
        else
            teamIndex = #tempMembers + 1
        end
    end
    if this.defaultIndex == index then
        this.heroTable[this.defaultIndex].num = 0
        this.heroTable[this.defaultIndex].choice = false
        template.choice:SetActive(false)
        this.defaultIndex = -1

        tempMembers[teamIndex] = ""
        HeroParameter.clickHero = ""
        if this.heroType==2 then

            PlayerAssistMgr.RemoveTempMembers(heroId,false)
            this.FrushHeroItemState(heroId,false);
        end
    else
        if this.defaultIndex > 0 and this.heroTable[this.defaultIndex]~=nil then
            this.heroTable[this.defaultIndex].num = 0
            this.heroTable[this.defaultIndex].choice = false
            for i = 1, #this.scrollReuse.templateList do
                if this.scrollReuse.templateList[i].index == this.defaultIndex then
                    this.scrollReuse.templateList[i].choice:SetActive(false)
                    break
                end
            end
            if this.heroType==2 then
                PlayerAssistMgr.RemoveTempMembers(this.heroTable[this.defaultIndex].characterId,false)
            else
                if PlayerAssistMgr.lastOpHeroId~=nil then
                    PlayerAssistMgr.RemoveTempMembers(PlayerAssistMgr.lastOpHeroId,false)
                end
            end
        end
        if this.heroType==2 then
            if PlayerAssistMgr.CheckHeroChoiceMax() then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",ConfigMgr.LangGlobal("21002"))
                return;
            end
            local curUid=this.heroTable[index].uid;
            if not IsNullOrEmpty(curUid) and (PlayerAssistMgr.FriendRemainAssistCount(curUid)-PlayerAssistMgr.GetCurMemberCount(curUid)<=0) then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",ConfigMgr.LangGlobal("22780"));
                return;
            end
        end
        this.defaultIndex = index
        this.heroTable[index].num = 0
        this.heroTable[index].choice = true
        template.choice:SetActive(true)
        HeroParameter.clickHero = heroId
        tempMembers[teamIndex] = heroId
        this.ClearOtherAssistMask(heroId)
        if this.heroType==2 then

            local assisInfo={
                id=heroId,
                uid=this.heroTable[index].uid
            }
            PlayerAssistMgr.AddTempMembers(assisInfo,false)
            this.FrushHeroItemState(heroId,true);
        end
        this.UpdateSelectHero(heroId,template.data.uid)
    end
    this.vm.data.assistHeroCount=this.StrFormat("%d/%d",PlayerAssistMgr.GetHeroChoiceAssistCount(),PlayerAssistMgr.supportNum)
end

this.MoreSelectHeroFun = function(template)
    local index,heroId = template.index,template.itemId

    if this.heroTable[index].assisIsMask then
        return;
    end
    if (this.IsActivity() and this.IsLocked(heroId)) then
        return;
    end
    local teamIndex = this.FindTeamIndex(heroId)
    local tempMembers = {}
    if HeroParameter.battleBool then
        tempMembers = HeroParameter.battleMembers
    else
        tempMembers = HeroParameter.teamMembers
    end
    if teamIndex ~= -1 then
        this.TabRemove(tempMembers,teamIndex)
        this.heroTable[index].num = 0
        this.heroTable[index].choice = false
        template:SetData(template.index,this.heroTable[index],true)
        this.UpdateMoreIndex(teamIndex)
        if this.heroType==2 then

            PlayerAssistMgr.RemoveTempMembers(heroId,true)
            this.FrushHeroItemState(heroId,false);
        end
    else

        if this.heroType==2  then
            if  PlayerAssistMgr.CheckHeroChoiceMax() then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",ConfigMgr.LangGlobal("21002"))
                return
            end
            local curUid=this.heroTable[index].uid;
            if not IsNullOrEmpty(curUid) and (PlayerAssistMgr.FriendRemainAssistCount(curUid)-PlayerAssistMgr.GetCurMemberCount(curUid)<=0) then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",ConfigMgr.LangGlobal("22780"));
                return;
            end
        end
        if (#tempMembers == 6 
        or (HeroParameter.heroCount ~= nil and #tempMembers == HeroParameter.heroCount)
        or (HeroParameter.commonCharacterCount ~= nil and #tempMembers == HeroParameter.commonCharacterCount))
        then
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2168"].NameLan)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
            return
        end
        this.TableInsert(tempMembers,heroId)
        this.heroTable[index].num = #tempMembers
        this.heroTable[index].choice = true
        template:SetData(template.index,this.heroTable[index],true)
        if this.heroType==2 then

            local assisInfo={
                id=heroId,
                uid=this.heroTable[index].uid
            }
            PlayerAssistMgr.AddTempMembers(assisInfo,true)
            this.FrushHeroItemState(heroId,true);
        end
    end
    if (HeroParameter.heroCount ~= nil) then
        this.vm.data.moreCount = this.StrFormat("%d/%d",#tempMembers,HeroParameter.heroCount)
    elseif HeroParameter.commonCharacterCount~=nil then
        this.vm.data.moreCount = this.StrFormat("%d/%d",#tempMembers,HeroParameter.commonCharacterCount);
    else
        this.vm.data.moreCount = this.StrFormat("%d/%d",#tempMembers,6)
    end
    this.vm.data.assistHeroCount=this.StrFormat("%d/%d",PlayerAssistMgr.GetHeroChoiceAssistCount(),PlayerAssistMgr.supportNum)
    this.UpdateSelectHero(heroId,template.data.uid)
end



this.FindTeamIndex = function(heroId)
    local tempMembers = {}
    if HeroParameter.battleBool == true then
        tempMembers = HeroParameter.battleMembers
    else
        tempMembers = HeroParameter.teamMembers
    end
    for i = 1, #tempMembers do
        if tempMembers[i] == heroId or tempMembers[i] == "" then return i end
    end
    return -1
end



this.TeamContainsHero = function(heroId)
    local tempMembers = {}
    if HeroParameter.battleBool == true then
        tempMembers = HeroParameter.battleMembers
    else
        tempMembers = HeroParameter.teamMembers
    end
    if tempMembers == nil then return -1 end
    for i = 1, #tempMembers do
        if tempMembers[i] == heroId then return i end
    end
    return -1
end


this.UpdateMoreIndex = function(changeIndex)
    local tempMembers = {}
    if HeroParameter.battleBool then
        tempMembers = HeroParameter.battleMembers
    else
        tempMembers = HeroParameter.teamMembers
    end
    local index = 0

    for i = changeIndex, #tempMembers do
        for j = 1, #this.scrollReuse.templateList do
            if tempMembers[i] == this.scrollReuse.templateList[j].itemId then
                index = i
                this.scrollReuse.templateList[j].data.num = i
                local sprite = LuaMgr.GetSprite("NumberFont",i)
                this.scrollReuse.templateList[j].numSprite.sprite = sprite
                break
            end
        end
    end
    if index < #tempMembers then

        for i = index + 1, #tempMembers do
            for j = 1, #this.heroTable do
                if tempMembers[i] == this.heroTable[j].id then
                    this.heroTable[j].num = i
                    break
                end
            end
        end
    end
end

this.UpdateSortBtn = function()
    this.vm.data.rareBtn = this.sortType == HeroSortType.Rare and Vector3.one or Vector3.zero
    this.vm.data.levelBtn = this.sortType == HeroSortType.Level and Vector3.one or Vector3.zero
    local vector = this.sequenceType == SequenceType.FromBigToSmall and Vector3.one or Vector3(1,-1,1)
    this.vm.data.rareBtnOrder = vector
    this.vm.data.levelBtnOrder = vector
    this.scrollRect.horizontalNormalizedPosition = 0.0
end

this.TrainingSort = function()

    if not HeroParameter.isTraining then
        this.vm.data.training_offset = 0
        this.contentAnchorPos = Vector2.zero
        return
    end

    local index = 0
    for i=1,#this.heroTable do
        if this.heroTable[i].trainingGroupIndex ~= 0 and this.heroTable[i].trainingGroupIndex ~= HeroParameter.trainingTeamIndex then
            index=index+1
            if index < i then
                this.ChangeSelectHeroPos(i, index)
            end
        end
    end
    this.vm.data.training_offset = index
    local calcIndex = math.floor((index + 2) / 2)
    local x = math.max(calcIndex - 2, 0) * 144 + 10
    this.contentAnchorPos = Vector2(-x, 0)
    if this.defaultIndex ~= nil and this.defaultIndex ~= -1 then
        this.defaultIndex = this.defaultIndex + index
    end
end

this.ActivityBattleSort = function()
    if not this.IsActivity() then
        return
    end
    local index = 0


    if TableIsNull(HeroParameter.filterMembers) then
        HeroParameter.filterMembers = {}
    else
        for i=1,#this.heroTable do
            local uid = HeroParameter.filterMembers[this.heroTable[i].id];
            if uid ~= nil then
                index=index+1
                if index < i then
                    this.ChangeSelectHeroPos(i, index)
                end
            end
        end
    end
    

    if HeroParameter.miniBattle4HelpActors ~= nil then
        for i=1,#this.heroTable do
            local plotId = HeroParameter.miniBattle4HelpActors[this.heroTable[i].id];
            if plotId ~= nil then
                index=index+1
                if index < i then
                    this.ChangeSelectHeroPos(i, index)
                end
            end
        end
    end
    local calcIndex = math.floor((index + 2) / 2)
    local x = math.max(calcIndex - 2, 0) * 144 + 10
    this.contentAnchorPos = Vector2(-x, 0)
    if this.defaultIndex ~= nil and this.defaultIndex ~= -1 then
        this.defaultIndex = this.defaultIndex + index
    end
end

this.OnValueChange = function(args)
    local template,index = args[0],args[1]
    local tempData = this.heroTable[index]
    if tempData == nil then return end
    template:SetData(index,tempData,true)
end


this.FilterSortCallBack = function()
    this.InitParameter()
    this.CreateHeroItem()
end

this.ChoiceHeroItem = function(args)
    local template = args[0]
    if HeroParameter.selectType then
        this.MoreSelectHeroFun(template)
    else
        this.SingleSelectFun(template)
    end
end

this.RequestSaveTeam = function(callback)
    local data = {}
    local tempData = {}
    local tempHelps={}
    if BattlePrepareMgr.isLeveling == true then
        data["battleType"] = "moreMod"
        data["teamId"] = this.ToString(HeroParameter.teamIndex)
        tempData = HeroParameter.battleMembers
    else
        tempData = HeroParameter.teamMembers
        data["teamId"] = this.ToString(HeroParameter.teamIndex)
    end
    
    if(#tempData <= 0)then return end
    data["members"] = {}
    data["helps"]={}

    if not HeroParameter.selectType then
        local index = 0
        for i = 1, #tempData do
            if tempData[i] == "" then
                index = i
                break
            end
        end
        if index > 0 then this.TabRemove(tempData,index) end
    end
    for i = 1, #tempData do
        data["members"][this.ToString(i - 1)] = tempData[i]
        data["helps"][this.ToString(i - 1)]=this.GetMembersHelpUid(tempData[i])
    end

    BattlePrepareMgr.CheckAndSaveTeam(data, function(result)
        if callback ~= nil then
            callback(this.changeAfterTeam)
        end
        this.ClosePanel();
    end)
end

this.GetMembersHelpUid=function(id)
    if PlayerAssistMgr.IsAssistMember(id) then
        return PlayerAssistMgr.GetAssistMemberUid(id)
    else
        return "";
    end
end

this.GetChangeAfterTeam = function()
    this.changeAfterTeam = {}
    local beforeTeam = {}
    local afterTeam = {}
    local length = 0
    if HeroParameter.battleBool == true then
        beforeTeam = HeroParameter.membersParam
        afterTeam = HeroParameter.battleMembers
    else
        beforeTeam = DataMgr.Player.teams[this.ToString(HeroParameter.teamIndex)].members
        afterTeam = HeroParameter.teamMembers
    end
    if ConfigHelper.GetTableLength(beforeTeam) < #afterTeam then
        length = #afterTeam
    else
        length = ConfigHelper.GetTableLength(beforeTeam)
    end
    if HeroParameter.battleBool == true then
        for i = 1, length do
            if beforeTeam[i] ~= afterTeam[i] then
                this.TableInsert(this.changeAfterTeam,afterTeam[i])
            end
        end
    else
        for i = 1, length do
            if beforeTeam[this.ToString(i - 1)] ~= afterTeam[i] then
                this.TableInsert(this.changeAfterTeam,afterTeam[i])
            end
        end
    end
end


this.InitShowHero = function()
    this.heroTable = {}
    local config = nil
    local dataCharacters={};
    local characters=DataMgr.Player.characters;
    if not BattlePrepareMgr.isLeveling and this.heroType==2 then
        characters=PlayerAssistMgr.GetAssistList();
    else
        this.SetActors();
    end

    if HeroParameter.isLockSelectCharacter then
        for index, value in ipairs(HeroParameter.lockCharacterList) do
            dataCharacters[value.heroId]=table.Copy(characters[value.heroId]);
        end
    elseif HeroParameter.isRogueTeam then
        if BattlePrepareMgr.isRogue then
            local memberIds=RogueExploreMgr.GetMembers()
            dataCharacters=RogueMgr.GetCharacterDatasByIDList(memberIds);
        else
            for k, v in pairs(characters) do
                dataCharacters[k] = RogueMgr.GetCharacterDataByID(k)
            end
        end
    else
        dataCharacters=table.Copy(characters)
    end
    if BattlePrepareMgr.isLeveling and  DataMgr.Player.moreModAssist~=nil then

        local jointers=DataMgr.Player.moreModAssist;
        for i,v in pairs(jointers) do
            if dataCharacters[i]==nil then
                dataCharacters[i]=v.character;
            end
        end
    end
    for key,value in pairs(dataCharacters) do
        config = ConfigMgr.Config.characterTable[value.id]

        local index = this.TeamContainsHero(value.id)
        if index == -1 then
            if this.jobType ~= CharacterJob.All and this.jobType ~= config.job then goto continue end
        else
            if not HeroParameter.selectType and value.id ~= HeroParameter.clickHero then goto continue end
        end

        if BattlePrepareMgr.isLeveling then
            local levelCharacterData = BattlePrepareMgr.levelingData.characterDataMap[value.id]
            if levelCharacterData ~= nil then
                value.level = levelCharacterData.level
                value.star = levelCharacterData.star
                local count,recount=BattlePrepareMgr.MoreModGetCharacterBattleCount(value.id)
                value.lock=recount==0 and not BattlePrepareMgr.MoreModCharacterHasBattleRecord(value.id);
            end
        else
            value.lock=false
        end


        if HeroParameter.isTraining then

            if index == -1 then

                local isInAnotherTeam = false
                if HeroParameter.anotherTeam[value.id]~=nil then



                    isInAnotherTeam = true
                end
                if isInAnotherTeam then
                    value.trainingGroupIndex = HeroParameter.anotherTeam[value.id].trainingGroupIndex
                else
                    value.trainingGroupIndex = 0
                end
            else
                value.trainingGroupIndex = HeroParameter.trainingTeamIndex
            end
        elseif (HeroParameter.isDungeon66) then
            
        end
        if config ~= nil and config.Switch == 0 then
            value.rare = config.rare
            value.name = LuaMgr.GetLangText(config.namelan)
            value.job = config.job
            value.choice = false
            value.num = 0
            value.isLeveling=BattlePrepareMgr.isLeveling
            value.isRogue = HeroParameter.isRogueTeam
            value.characterId=value.id
value.isAssis=this.heroType==2;
            value.assistHeroCount=this.heroType==2 and PlayerAssistMgr.FriendRemainAssistCount(value.uid) or -1;
            value.assisIsMask=false,
            this.TableInsert(this.heroTable,value)
        end
        ::continue::
    end
end


this.Dungeon66CharacterIsLock = function(value)
    
end


this.SetActors = function()
    if (HeroParameter.actors == nil) then return end
    
    local actorConfig;
    local actorData;
    local characterConfig;
    local len = #HeroParameter.actors;
    for i = 1, len do
        actorConfig = ConfigMgr.Config.actor[HeroParameter.actors[i]];
        if (actorConfig ~= nil) then
            if (HeroParameter.clickHero == actorConfig.ID or this.TeamContainsHero(actorConfig.ID) == -1) then
                characterConfig = ConfigMgr.Config.characterTable[actorConfig.CharacterId];
                if (characterConfig ~= nil) then
                    actorData = {};
                    actorData.id = actorConfig.ID;
                    actorData.isActor = true;
                    actorData.level = actorConfig.Level;
                    actorData.star = characterConfig.star;
                    actorData.rare = characterConfig.rare;
                    actorData.name = LuaMgr.GetLangText(characterConfig.namelan);
                    actorData.job = characterConfig.job;
                    actorData.choice = false;
                    actorData.num = 0;
                    actorData.characterId = actorConfig.CharacterId;
                    actorData.lock = false;
                    actorData.isLeveling = false;
                    table.insert(this.heroTable, actorData);
                end
            end
        end
    end
end



this.LevelSort = function(a,b)
    if a.level ~= b.level then
        if this.sequenceType == SequenceType.FromBigToSmall then
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
        if this.sequenceType == SequenceType.FromBigToSmall then
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
        if this.sequenceType == SequenceType.FromBigToSmall then
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
        if this.sequenceType == SequenceType.FromBigToSmall then
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


this.UpdateGuideSort = function()
    if not LuaMgr.IsGuide() then return end
    local config = LuaMgr.GetNowConfig()
    if config == nil or config.Data == "" then return end
    for i = 1, #this.heroTable do
        if this.heroTable[i].id == config.Data then
            local item = this.heroTable[i]
            table.remove(this.heroTable,i)
            this.TableInsert(this.heroTable,1,item)
            break
        end
    end
end


this.UpdateActorSort = function()
    if (HeroParameter.actors == nil) then return end
    
    local heroData;
    local actorMap = {};
    local index = 1;
    local len = #this.heroTable;
    while (index <= len) do
        heroData = this.heroTable[index];
        if (heroData.isActor) then
            actorMap[heroData.id] = heroData;
            table.remove(this.heroTable, index);
            len = len - 1;
        else
            index = index + 1;
        end
    end
    index = 1;
    len = #HeroParameter.actors;
    for i = 1, len do
        heroData = actorMap[HeroParameter.actors[i]];
        if (heroData ~= nil) then
            table.insert(this.heroTable, index, heroData);
            index = index + 1;
        end
    end
end

this.GetHeroAttrKey = function(data)
    local attrKey = {}
    for i = 1, #data do
        this.TableInsert(attrKey,data[i].id)
    end
    return attrKey
end

this.ClosePanel = function(isConfirm)
    if HeroParameter.battleBool == true then
        if HeroParameter.selectCharacterFailBack~=nil then
HeroParameter.selectCharacterFailBack(HeroParameter.selectCharacterFailBackExtendParams);
        end
    end
    if(HeroParameter.isQin)then
        if(isConfirm)then
            return
        else
            HeroParameter.EmptyQinParam();
        end
    end
    PlayerAssistMgr.heroIndex=nil;
    LuaMgr.Back(false)
end

this.DeletePanel = function()
    if this.scrollReuse ~= nil then
        for i = #this.scrollReuse.templateList,1,-1  do
            this.scrollReuse.templateList[i]:Clear()
        end
        this.scrollReuse = nil
    end
end

this.VoyageBack = function()
    if (HeroParameter.isVoyage) then
        HeroParameter.EmptyVoyageParam();
    end
end

this.Dungeon66Back = function()
    if (HeroParameter.isDungeon66) then
        HeroParameter.EmptyDungeon66Param();
    end
    if HeroParameter.activityKey == ActivityKey.SpringCamp then
        HeroParameter.EmptySpringCampParam();
    end
end

this.TeamTowerBack = function()
    if (HeroParameter.activityKey == ActivityKey.TeamTower) then
        HeroParameter.EmptyActivityParam();
    end
end

this.ActivityBattleBack = function()
    if this.IsActivity() then
        HeroParameter.EmptyActivityParam();
    end
end

this.RogueBack = function()
    if HeroParameter.isRogueTeam then
        HeroParameter.EmptyRogueParam();
    end
end


this.CommonSelectCharacterBack=function ()



    if HeroParameter.isOnlySelectCharacter or HeroParameter.isLockSelectCharacter then
        HeroParameter.ClearCommonSelectCharacter();
    end
end


this.SetHeroTypeInfo=function()
    this.vm.data.heroType_assis=this.heroType==2;
    this.vm.data.heroType_my=this.heroType==1;
    local isCon1= (not BattlePrepareMgr.isLeveling and not HeroParameter.isVoyage);
    this.vm.data.isCultivate =HeroParameter.isCultivate and this.heroType==1 and isCon1 
    this.vm.data.isAssisInquire=HeroParameter.isCultivate and this.heroType==2
    this.vm.data.isDetail = not HeroParameter.isCultivate and HeroParameter.isDetail
end

this.IsActivity = function()
    return HeroParameter.isDungeon66 or HeroParameter.activityKey == ActivityKey.MiniBattle or HeroParameter.activityKey == ActivityKey.crisiscontract2 or
            HeroParameter.activityKey == ActivityKey.MiniBattleNew or HeroParameter.activityKey == ActivityKey.BossDummy3 or HeroParameter.activityKey == ActivityKey.BossDummy4
            or HeroParameter.activityKey == ActivityKey.DualBattle or HeroParameter.activityKey == ActivityKey.BossDummy5 or
            HeroParameter.activityKey == ActivityKey.crisiscontract3 or HeroParameter.activityKey == ActivityKey.DualBattle or HeroParameter.activityKey == ActivityKey.TeamRelay or
            HeroParameter.activityKey == ActivityKey.TeamRelay2 or HeroParameter.activityKey == ActivityKey.DualBattle2 or HeroParameter.activityKey == ActivityKey.TeamTower
			or HeroParameter.activityKey == ActivityKey.TeamRelay3 or HeroParameter.activityKey == ActivityKey.SpringCamp
end

this.IsLocked = function(characterId)
    return HeroParameter.filterMembers[characterId] ~= nil or (HeroParameter.miniBattle4HelpActors ~= nil and HeroParameter.miniBattle4HelpActors[characterId] ~= nil)
end

return vm({
    data = data,
    command = command,
    hook = hook
})