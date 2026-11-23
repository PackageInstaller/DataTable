




local HeroManager = CS.Laigu.ViewModel.Hero.HeroManager;

local voicePath = "Assets/_BundleResources/Character/";
local archivesPath = "Assets/_BundleResources/Images/Archives/";

local this = { vm = nil };

local barNames = nil;
local barKeys = { "HeroInfo", "Assess", "Saying", "Relics" }
local barOnColor = UnityEngine.Color(0.15, 0.14, 0.16, 1);
local barOffColor = UnityEngine.Color(0.65, 0.60, 0.52, 1);

local sayingColor1 = UnityEngine.Color(0.15, 0.14, 0.16, 1);
local sayingColor2 = UnityEngine.Color(0.94, 0.90, 0.80, 1);
local sayingColor3 = UnityEngine.Color(0.76, 0.76, 0.76, 1);

local sayingColorWhite = UnityEngine.Color(1, 1, 1, 1);
local sayingColorGray = UnityEngine.Color(0.64, 0.64, 0.64, 1);

local saying_rawPath = "Assets/_BundleResources/Images/Lines/";
local saying_voiceLength = 0;
local saying_toweener = nil;
local headIconPath1 = "Assets/_BundleResources/Images/MailSender/sender";

local curBarIndex = 0;
local spineUICharacter = nil;

local heroContent = nil;
local heroContentChildText = nil;

local relicsContent = nil;
local relicsPage1ContentChildText = nil;


local assessOffSetY = 72;
local assessIndex = 0;
local assessMoveDir = -1;
local assessBeforeIndex = -1;
local assessMoving = false;

local curSayingIndex;
local lineStartIndex = 0;
local tweener;

local sayingText;
local textSaying = false;

local cfgCharactorFiles = {};
local cfgCharactorFilesText = {};
local cfgLinesUnlock = {};
local dataCharacter = {};
local cfgCharactorSkin = {};
local cfgCharacterTable = {};
local cfgCharacterLines = {}
local cfgHistoricalRelics = {};
local cfgHistoricalText = {};
local dataDungeonRecords = {};
local cfgNarrativeMap = {};
local characterId = nil;
local rootAnimator = nil;
local ANIMATOR_HEROINFO = "UI_ArchivesPanel_ziliao_01";
local ANIMATOR_RELICS = "UI_ArchivesPanel_wenwu_01";
local ANIMATOR_ASSESS = "UI_ArchivesPanel_pinggu_01";
local ANIMATOR_SAYING = "UI_ArchivesPanel_luyin_01";

local relicsKey = nil;
local assessKey = nil;
local sayingKey = nil;
local sayingKey2 = nil;
local isSayVoice = true;
local saying_typeIndex = nil;
local saying_type = "";
local isClearAssessRed = false;
local isClearSayingRed = false;
local sayingResLine = nil;
local data = {
    characterPath = DefaultTexture,
    heroInfoPanel = false,
    culturalRelicsPanel = false,
    assessPanel = false,
    sayingPanel = false,
    left_Charactor = false,
    left_Relics = false,
    left_RelicsICON = DefaultTexture;
    barItemList = { { isOn = false, name = "", icon = DefaultSprite, barColor = UnityEngine.Color(1, 1, 1, 1), redId = "" } },
    relicsItemList = { { year = "", des = "", relicsBool = false } };


    assessList = {
        { index = 0, assessPos = Vector2(0, -50), isActive = true, BG = DefaultSprite, title = "", text = LuaMgr.GetLangText("HeroArchivesViewModel_4"), sprite = "ui_da_pgzp_", contentActive = false, redId = "" },
        { index = 0, assessPos = Vector2(0, -50), isActive = true, BG = DefaultSprite, title = "", text = LuaMgr.GetLangText("HeroArchivesViewModel_5"), sprite = "ui_da_pgjm_", contentActive = false, redId = "" },
        { index = 0, assessPos = Vector2(0, -50), isActive = true, BG = DefaultSprite, title = "", text = LuaMgr.GetLangText("HeroArchivesViewModel_6"), sprite = "ui_da_pgfl_", contentActive = false, redId = "" } };

    baseItemList = { { interactable = true, type = DefaultSprite, info = "", headIcon = DefaultTexture, headIconBool = false, redId = "", active = false ,rewardLock=false }};
    secretItemList = { { interactable = true, type = DefaultSprite, info = "", headIcon = DefaultTexture, headIconBool = false, redId = "", active = false ,rewardLock=false} };
    avgItemList = { { interactable = true, type = DefaultSprite, info = "", redId = "", active = false, rewardLock=false} };

    sayingItemList = { { BG = DefaultSprite, on = false, off = false, suo = false, btnBool = true, progross = 0.0, lineType = "", info = "", unlockConditon = "", textColor = UnityEngine.Color(1, 1, 1, 1), sayingBool = false, redId = "" } };

    hero_ContentAnchor = Vector2(0, 0);
    relicsPage1_ContentAnchor = Vector2(0, 0);
    relicsPage2_ContentAnchor = Vector2(0, 0);
    assess_ContentAnchor = Vector2(0, 0);
    saying_ContentAnchor = Vector2(0, 0);
    bodyPath = "";
    bodyRawBool = false;
    uiSpineMaskEnable = false;
    hero_ContentSizeData = Vector2(422, 300);
    relicsPage1_ContentSizeData = Vector2(438, 300);



    hero_jobBool = false;
    hero_job = LuaMgr.GetLangText("HeroArchivesViewModel_7"),
    hero_name = "",
    hero_number = "",
    hero_state = "",
    hero_team = "",
    hero_safety = "",
    hero_relics = "",
    hero_des = "",
    hero_skinDes = "",
    hero_lineAnchorPos = Vector2(4.5, -24);



    relicslinkList = {
        { des = "", active = true, linkID = "" },
        { des = "", active = false, linkID = "" },
        { des = "", active = false, linkID = "" },
        { des = "", active = false, linkID = "" },
        { des = "", active = false, linkID = "" },
        { des = "", active = false, linkID = "" },
        { des = "", active = false, linkID = "" },
    },
    relics_postion = "",
    relics_type = "",
    relics_era = "",
    relics_Page1 = false,
    relics_Page2 = false,
    relics_Relics = "",
    relics_Des = "",
    relics_lineAnchorPos = Vector2(0, -22);
    relics_historyRouteIsOn = false;


    assess_InfoBool = false;
    assess_baseInfoBool = false;
    assess_secretInfoBool = false;
    assess_ImgBool = false;
    assess_ImgSprite = DefaultTexture;
    assess_Info = "";
    assess_titleInfo = "";
    assess_process = "";
    assessText_contentAnchorPos = Vector2(0, 0);




    saying_cvBool = false;
    saying_process = "";
    saying_cv = "CV";
    saying_cvName = "";
    saying_dialog = false;
    saying_dialogContent = "";
    saying_msgContentSizeFitterBool = false;
    saying_layoutGroupSpacing = -10.0;
    saying_msgContentSizeData = Vector2(567, 170);
    saying_dialogText = false;
    saying_dialogRaw = false;
    saying_Raw = DefaultTexture;
    saying_RawAnchorPos = Vector2(0, 0);
    saying_voiceTypeBool = false;
    saying_voiceAddBool = false;
    saying_voiceList = {
        {
            des = "",
            name = "",
            isOn = false,
            color = sayingColorWhite,
            isLoad = false;
            isTip = false;
            tipText=""
        }
    },
    isShowArrow = false;
    isLanTips = false;
    lanTipsText = "",
    panel_info_team = false,
    panel_info_team_text = "",
    panel_info_team_intro = "",
    msgSkin = DefaultSprite,
    msgTextColor = UnityEngine.Color(255 / 255, 255 / 255, 255 / 255, 1),
}

local command = {

    barItemTog = {
        type = XLuaCommandType.Bool,
        execute = function(vm, isOn, param)

            this.SwitchPanel(isOn, param);
        end
    },
    heroScrollOnChange = {
        type = XLuaCommandType.Vector2,
        execute = function(vm, vector)
            vm.data.hero_lineAnchorPos = Vector2(4.5, -24 + heroContent.localPosition.y);
        end
    },
    historyBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.relics_Page2 = true;
            this.vm.data.relics_Page1 = false;
            if (relicsKey ~= nil) then
                coroutine_runner.stop(relicsKey);
            end
            relicsKey = coroutine_runner.start(function()
                for i, v in ipairs(this.vm.data.relicsItemList) do
                    coroutine_runner.wait(0.1);
                    v.relicsBool = true;
                end
            end)

        end
    },
    relicInfoBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.relics_Page2 = false;
            this.vm.data.relics_Page1 = true;
            for i, v in ipairs(this.vm.data.relicsItemList) do
                v.relicsBool = false;
            end

        end

    },
    relicslinkBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param);
            local linkID = this.vm.data.relicslinkList[index].linkID;
            LuaMgr.ShowLuaPanel(UIName.HeroArchivesLinkViewModel, index, linkID, function(charId)
                characterId = charId
                HeroRedDataHelper.InitArchivesRedData(characterId);
                HeroManager.UpdateChracterIndex(charId);
                this.ParseData(3);
                RedMgr.Singleton:Refresh();
                local tips = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2318"].NameLan), LuaMgr.GetLangText(cfgCharacterTable.namelan));
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips);
            end);
        end

    },
    relicsScrollOnChange = {
        type = XLuaCommandType.Vector2,
        execute = function(vm, vector)
            vm.data.relics_lineAnchorPos = Vector2(0, -22 + relicsContent.localPosition.y);
        end
    },

    assessItemBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param);
            this.AssessOpen(index);
        end
    },
    assessBaseItemBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param + 1);
            local baseItem=this.vm.data.baseItemList[index];
            if baseItem.headIconBool then
                if baseItem.isRewarding then
                    this.CheckReward(index,0);
                    return;
                end
                this.AssessOpenBaseInfo(index);
            else
                local tip = this.AssessTipMsg(cfgCharactorFiles.basicFileUnlock[index]);
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tip)
            end
        end
    },
    assessSecretItemBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param + 1);
            local secretItem=this.vm.data.secretItemList[index];
            if secretItem.headIconBool then
                if secretItem.isRewarding then
                    this.CheckReward(index,1);
                    return;
                end
                this.AssessOpenSecretInfo(index);
            else
                local tip = this.AssessTipMsg(cfgCharactorFiles.specialFileUnlock[index]);
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tip)
            end
        end
    },
    assessAVGItemBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param + 1);
            if this.vm.data.avgItemList[index].headIconBool then
                this.AssessOpenAVGInfo(index);
            else
                local tip = this.AssessTipMsg(cfgCharactorFiles.AVGFileUnlock[index]);
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tip)
            end
        end
    },
    assessContentPanelCloseBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.assess_InfoBool = false;
            this.vm.data.assess_secretInfoBool = false;
            this.vm.data.assess_baseInfoBool = false;
        end
    },

    sayingPlayBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1;
            this.SayingPreparePlayVoice(index);
        end
    },
    sayingCVCloseBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.saying_voiceTypeBool = false;
        end
    },
    sayingCVBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local resLine = sayingResLine
            if #resLine.Linestype > 1 then
                this.vm.data.saying_voiceTypeBool = true;
                this.SetSayingTypeList()
                local lanRed=PlayerCharacterMgr.ArchivesLanguageTipRed(characterId)
                if lanRed>0 then
                    RedMgr.Singleton:FrushRedCondition("1312");
                    RedMgr.Singleton:UpdateClientRedData("1312",0)
                    PlayerCharacterMgr.CalculateHeroRedCount()
                    RedMgr.Singleton:Refresh();
                end
            end
        end
    },










    sayingTypeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1;
            if saying_typeIndex == index then
                return
            end ;
            saying_typeIndex = index
            saying_type = sayingResLine.Linestype[index]
            for i, v in ipairs(this.vm.data.saying_voiceList) do
                v.isOn = saying_typeIndex == i;
                v.color = saying_typeIndex == i and sayingColorWhite or sayingColorGray
            end
            this.vm.data.saying_cvName = this.vm.data.saying_voiceList[index].name;
            local askData = {
                CharacterID = characterId,
                LinesType = saying_type
            }
            ApiMgr.Request("character/update_linestype", askData, true, function(re)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("1604"))
            end, nil, true);
        end
    },
    lanTipBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param)+1
            this.vm.data.isLanTips=true;
            this.vm.data.lanTipsText=this.vm.data.saying_voiceList[index].tipText;
        end
    },
    closeLanTipBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.isLanTips=false
        end
    },
    leftCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if #HeroParameter.characterList == 1 then
                return
            end
            if HeroParameter.characterIndex - 1 < 1 then
                HeroParameter.characterIndex = #HeroParameter.characterList
            else
                HeroParameter.characterIndex = HeroParameter.characterIndex - 1
            end
            characterId = HeroParameter.characterList[HeroParameter.characterIndex]
            HeroRedDataHelper.InitArchivesRedData(characterId);
            this.ParseData(curBarIndex)
            RedMgr.Singleton:Refresh();
        end
    },
    rightCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if #HeroParameter.characterList == 1 then
                return
            end
            if HeroParameter.characterIndex + 1 > #HeroParameter.characterList then
                HeroParameter.characterIndex = 1
            else
                HeroParameter.characterIndex = HeroParameter.characterIndex + 1
            end
            characterId = HeroParameter.characterList[HeroParameter.characterIndex]
            HeroRedDataHelper.InitArchivesRedData(characterId);
            this.ParseData(curBarIndex)
            RedMgr.Singleton:Refresh();
        end
    },
    Panel_Info_teamCommane = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OpenPanel_Info_team(true)
        end
    },
    closePanel_Info_team = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OpenPanel_Info_team(false)
        end
    }
}


this.CheckReward=function(index,loc)
    local askData={characterId=characterId,unlockIndex=tostring(index-1),unlockType=loc}
    ApiMgr.Request("unlockfile_character",askData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result.fileRewards);
        LuaMgr.ShowItemRewared(data);
        if loc==0 then
            HeroRedDataHelper.Archives_ClearAssessPlayerPrefsFile(characterId, 1, cfgCharactorFiles.basicFileID[index])
            this.ShowBaseAssetItem(1);
        elseif loc==1 then
            HeroRedDataHelper.Archives_ClearAssessPlayerPrefsFile(characterId, 2, cfgCharactorFiles.specialFileID[index])
            this.ShowSecretAssetItem(2);
        end
    end,nil,true);
end



local hook = {
    before_awake = function(vm)
        this.vm = vm;
        print("before_awake");
        RedMgr.Singleton:RegisterViewModel(UIName.HeroArchivesViewModel);
        barNames = { LuaMgr.GetLangText("HeroArchivesViewModel_0"), LuaMgr.GetLangText("HeroArchivesViewModel_2"), LuaMgr.GetLangText("HeroArchivesViewModel_3"), LuaMgr.GetLangText("HeroArchivesViewModel_1"), }
        local tf = vm.behaviour.transform;
        spineUICharacter = tf:Find("root/Middle/Panel/Left_Charactor/Mask/Character/offset/Body"):GetComponent("UISpineCharacter");
        heroContent = tf:Find("root/Middle/Panel/Panel_Info/Right/Content/Scroll View/Viewport/Content");
        heroContentChildText = heroContent:Find("Text"):GetComponent("Text");
        relicsContent = tf:Find("root/Middle/Panel/Panel_CulturalRelics/Right/Page1/Content/Scroll View/Viewport/Content")
        relicsPage1ContentChildText = relicsContent:Find("Text"):GetComponent("Text");
        sayingText = tf:Find("root/Middle/Panel/Left_Saying/dialong/CharacterMsgItem/Content"):GetComponent("Text");
        rootAnimator = tf:Find("root"):GetComponent("Animator");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:UpdateTopBar("", this.OnBack);
            local data = vm.behaviour.Params;
            HeroParameter.CheckCharacterListIsNull()
characterId = HeroParameter.characterList[HeroParameter.characterIndex]
            local NO = 0;
            local dataLen = data.Length;
            if (dataLen == 1) then
                NO = tonumber(data[0]);
            end
            this.vm.data.isShowArrow = #HeroParameter.characterList > 1
            this.ParseData(NO);

            LuaMgr.RemoveNormalPanel(UIName.NovelViewModel);
        end
    end,

    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        print("before_deactive");
        LuaMgr.RemoveTimer(TimerConst.LinesType);
        LuaMgr.RemoveTimer(TimerConst.delayClose);
        relicsKey = nil;
        assessKey = nil;
        sayingKey = nil;
        if spineUICharacter ~= nil then
            spineUICharacter:Clear();
        end
        this.vm.data.bodyPath = "";
        this.OpenPanel_Info_team(false)

    end,
    before_destroy = function()
        spineUICharacter = nil;
        heroContent = nil;
        heroContentChildText = nil;
        relicsContent = nil;
        relicsPage1ContentChildText = nil;
        sayingText = nil;
        rootAnimator = nil;
    end
}

this.OnBack = function()
    if isClearAssessRed then
        HeroRedDataHelper.Archives_ClearAssessPlayerPrefsFile(characterId)
    end
    if isClearSayingRed then
        HeroRedDataHelper.Archives_ClearSayingPlayerPrefs(characterId);
    end
    LuaMgr.Back();
end


this.CheckTakeOutRelics = function()
    local hidden = ConfigMgr.Config.constants.ArtifactsHidden;
    if (hidden == nil) then
        return
    end ;

    if (hidden == 1 and #barNames > 3) then
        table.remove(barNames, 4);
        table.remove(barKeys, 4);
    elseif hidden == 0 then
        barNames = { LuaMgr.GetLangText("HeroArchivesViewModel_0"), LuaMgr.GetLangText("HeroArchivesViewModel_2"), LuaMgr.GetLangText("HeroArchivesViewModel_3"), LuaMgr.GetLangText("HeroArchivesViewModel_1"), }

        barKeys = { "HeroInfo", "Assess", "Saying", "Relics" };
    else

    end
end

this.ParseData = function(NO)
    isClearAssessRed = false;
    isClearSayingRed = false;
    isSayVoice = true;
    textSaying = false;
    assessBeforeIndex = -1;
    assessMoving = false;
    this.vm.data.assess_InfoBool = false;
    cfgCharactorFiles = ConfigMgr.Config.characterFiles[characterId];
    cfgCharactorFilesText = ConfigMgr.Config.characterFileTextMap;
    cfgLinesUnlock = ConfigMgr.Config.linesUnlock;
    dataCharacter = DataMgr.Player.characters[characterId];
    cfgCharacterTable = ConfigMgr.Config.characterTable[characterId];
    cfgHistoricalRelics = ConfigMgr.Config.historicalRelicsMap[characterId];
    if TableIsNull(cfgHistoricalRelics) then
        return
    end
    cfgHistoricalText = ConfigMgr.Config.HistoricalTextMap;
    local skin = HeroManager.GetCharacterSkin(characterId);
    cfgCharactorSkin = this.GetCharacterSkin(skin);
    dataDungeonRecords = DataMgr.Player.dungeonRecords;
    cfgNarrativeMap = ConfigMgr.Config.narrativeMap;

    curBarIndex = NO;
    this.CheckTakeOutRelics();
    this.SetCharacterSpine();
    this.InitLeftBar(NO + 1);
    this.ShowPanel(NO + 1);
end


this.SetCharacterSpine = function()
    local path = HeroManager.SetCharacterDrawing(spineUICharacter, characterId);
    if (path ~= "") then
        this.vm.data.bodyRawBool = true;
        this.vm.data.bodyPath = path;
    end
    this.vm.data.uiSpineMaskEnable = false;
    this.vm.data.uiSpineMaskEnable = true;
    this.vm.data.left_RelicsICON = LuaMgr.GetTexture(archivesPath .. characterId .. ".png");
end

this.GetCharacterSkin = function(skin)
    local skins = ConfigMgr.Config.characterSkins[characterId];
    if (skins == nil) then
        return
    end ;
    for i, v in ipairs(skins) do
        if (v.skinID == skin) then
            return v;
        end
    end
end

this.InitLeftBar = function(NO)
    this.vm.data.barItemList = {}
    local list = {};
    for i, v in ipairs(barNames) do
        local baritem = { isOn = NO == i, name = tostring(v),
                          icon = LuaMgr.GetSprite("Archives", "ui_da_tab_" .. i),
                          barColor = NO == i and barOnColor or barOffColor,
                          redId = "1125_" .. i,
        };
        this.SetBarRed(i);
        table.insert(list, baritem);
    end
    this.vm.data.barItemList = list;
end

this.SetBarRed = function(barIndex)
    if barIndex < 3 then
        return
    end ;
    if barIndex == 3 then
        local redNum = this.CalculateAssessRedData();
        RedMgr.Singleton:UpdateClientRedData("1125_2", redNum);
    elseif barIndex == 4 then
        local redNum = this.CalculateSayintRedData();
        
        local lanRed=PlayerCharacterMgr.ArchivesLanguageTipRed(characterId)
        RedMgr.Singleton:UpdateClientRedData("1312", lanRed);
        RedMgr.Singleton:UpdateClientRedData("1125_3", redNum+lanRed);
    end
end

this.CalculateAssessRedData = function()
    local red = 0;
    for i, v in pairs(HeroRedDataHelper.archives_assess_BasicFileIDRedList) do
        if v > 0 then
            red = red + 1;
            break
        end
    end
    for i, v in pairs(HeroRedDataHelper.archives_assess_SpecialFileIDRedList) do
        if v > 0 then
            red = red + 1;
            break
        end
    end
    for i, v in pairs(HeroRedDataHelper.archives_assess_AvgFileIDRedList) do
        if v > 0 then
            red = red + 1;
            break
        end
    end
    return red;
end

this.CalculateSayintRedData = function()
    local red = 0;
    for i, v in pairs(HeroRedDataHelper.archives_saying_redList) do
        if v > 0 then
            red = red + 1;
            break ;
        end
    end
    return red;
end

this.frushLeftBr = function(NO)
    for i, v in ipairs(this.vm.data.barItemList) do
        v.isOn = NO == i;
        v.barColor = NO == i and barOnColor or barOffColor
    end
end

this.SwitchPanel = function(isOn, Index)
    if not isOn or Index == curBarIndex then
        return
    end ;
    curBarIndex = Index;
    this.frushLeftBr(Index + 1);
    this.ShowPanel(Index + 1);

end

this.ShowPanel = function(NO)
    if (barKeys[NO] == "HeroInfo") then
        this.vm.data.hero_ContentAnchor = Vector2(0, 0);
        rootAnimator:Play(ANIMATOR_HEROINFO);
        this.SetHeroInfoData();
    elseif barKeys[NO] == "Relics" then
        this.vm.data.relicsPage1_ContentAnchor = Vector2(0, 0);
        this.vm.data.relicsPage2_ContentAnchor = Vector2(0, 0);
        rootAnimator:Play(ANIMATOR_RELICS, 0, 0);
        this.SetCulturalRelicsData();

    elseif barKeys[NO] == "Assess" then
        this.vm.data.assess_ContentAnchor = Vector2(0, 0);
        rootAnimator:Play(ANIMATOR_ASSESS);
        isClearAssessRed = true;
        this.SetAssessData();
    elseif barKeys[NO] == "Saying" then
        this.vm.data.saying_ContentAnchor = Vector2(0, 0);
        rootAnimator:Play(ANIMATOR_SAYING);
        isClearSayingRed = true;
        this.SetSayingData();
    end
    this.vm.data.saying_voiceTypeBool = false
    this.vm.data.heroInfoPanel = barKeys[NO] == "HeroInfo";
    this.vm.data.culturalRelicsPanel = barKeys[NO] == "Relics";
    this.vm.data.assessPanel = barKeys[NO] == "Assess";
    this.vm.data.sayingPanel = barKeys[NO] == "Saying";

    this.vm.data.left_Charactor = barKeys[NO] ~= "Relics";
    this.vm.data.left_Relics = barKeys[NO] == "Relics";

end


this.SetHeroInfoData = function()

    if not TableIsNull(cfgCharactorSkin) then
        this.vm.data.hero_jobBool = cfgCharactorSkin.designer ~= "";
        this.vm.data.hero_name = LuaMgr.GetLangText(cfgCharactorSkin.designer);
    end
    this.vm.data.hero_job = LuaMgr.GetLangText("HeroArchivesViewModel_12");
    this.vm.data.hero_number = cfgCharactorFiles.recordID;
    this.vm.data.hero_state = LuaMgr.GetLangText(cfgCharactorFiles.stafflan);

    local key = tostring(cfgCharacterTable.typeJJh)

    this.vm.data.hero_team = LuaMgr.GetLangText(ConfigMgr.Config.TypeJJHMap[key].NameLan);
    this.vm.data.hero_safety = LuaMgr.GetLangText(cfgCharactorFiles.storelan);
    this.vm.data.hero_relics = LuaMgr.GetLangText(cfgCharacterTable.namelan);
    this.vm.data.hero_des = LuaMgr.GetLangText(cfgCharactorFiles.cardIntrolan);
    this.vm.data.hero_ContentSizeData = Vector2(422, heroContentChildText.preferredHeight + 100);
    this.vm.data.hero_lineAnchorPos = Vector2(4.5, -24);
    LuaMgr.NextFrame(function()
        SetActive(heroContent.gameObject, false)
        SetActive(heroContent.gameObject, true)
    end);

end

this.OpenPanel_Info_team = function(isShow)
    if isShow then
        local key = tostring(cfgCharacterTable.typeJJh)
        local name = LuaMgr.GetLangText(ConfigMgr.Config.TypeJJHMap[key].NameLan)
        local intro = LuaMgr.GetLangText(ConfigMgr.Config.TypeJJHMap[key].FileLan)
        this.vm.data.panel_info_team_text = name
        this.vm.data.panel_info_team_intro = intro
    end
    this.vm.data.panel_info_team = isShow
end

this.SetCulturalRelicsData = function()
    this.vm.data.relics_Relics = LuaMgr.GetLangText(cfgCharacterTable.FullnameLan);
    this.vm.data.relics_Des = LuaMgr.GetLangText(cfgHistoricalRelics.introductionlan);



    this.vm.data.relics_postion = LuaMgr.GetLangText(cfgHistoricalRelics.museumlan);
    this.vm.data.relics_type = LuaMgr.GetLangText(cfgHistoricalRelics.relicslan);
    this.vm.data.relics_era = LuaMgr.GetLangText(cfgHistoricalRelics.dynastylan);
    this.vm.data.relics_Page1 = true;
    this.vm.data.relics_Page2 = false;
    this.vm.data.relics_lineAnchorPos = Vector2(0, -22);
    this.vm.data.relicsPage1_ContentSizeData = Vector2(438, relicsPage1ContentChildText.preferredHeight + 100);
    this.vm.data.relics_historyRouteIsOn = false;
    this.SetRelicsInfo();
    this.SetRelicsHistoryRoute()
end

this.SetRelicsInfo = function()

    if cfgHistoricalRelics.museum ~= nil and cfgHistoricalRelics.museum ~= "" then
        this.vm.data.relicslinkList[1].des = LuaMgr.GetLangText(cfgHistoricalText[cfgHistoricalRelics.museum].TextLan);
        this.vm.data.relicslinkList[1].active = true;
        this.vm.data.relicslinkList[1].linkID = cfgHistoricalRelics.museum;
    else
        this.vm.data.relicslinkList[1].active = false;
    end

    if cfgHistoricalRelics.relics ~= nil and cfgHistoricalRelics.relics ~= "" then
        this.vm.data.relicslinkList[2].des = LuaMgr.GetLangText(cfgHistoricalText[cfgHistoricalRelics.relics].TextLan);
        this.vm.data.relicslinkList[2].active = true;
        this.vm.data.relicslinkList[2].linkID = cfgHistoricalRelics.relics;
    else
        this.vm.data.relicslinkList[2].active = false;
    end

    if cfgHistoricalRelics.dynasty ~= nil and cfgHistoricalRelics.dynasty ~= "" then
        this.vm.data.relicslinkList[3].des = LuaMgr.GetLangText(cfgHistoricalText[cfgHistoricalRelics.dynasty].TextLan);
        this.vm.data.relicslinkList[3].active = true;
        this.vm.data.relicslinkList[3].linkID = cfgHistoricalRelics.dynasty;
    else
        this.vm.data.relicslinkList[3].active = false;
    end

    if cfgHistoricalRelics.tag2 ~= nil and cfgHistoricalRelics.tag2 ~= "" then
        this.vm.data.relicslinkList[4].des = LuaMgr.GetLangText(cfgHistoricalText[cfgHistoricalRelics.tag2].TextLan);
        this.vm.data.relicslinkList[4].active = true;
        this.vm.data.relicslinkList[4].linkID = cfgHistoricalRelics.tag2;
    else
        this.vm.data.relicslinkList[4].active = false;
    end

    if cfgHistoricalRelics.tag1 ~= nil and cfgHistoricalRelics.tag1 ~= "" then
        this.vm.data.relicslinkList[5].des = LuaMgr.GetLangText(cfgHistoricalText[cfgHistoricalRelics.tag1].TextLan);
        this.vm.data.relicslinkList[5].active = true;
        this.vm.data.relicslinkList[5].linkID = cfgHistoricalRelics.tag1;
    else
        this.vm.data.relicslinkList[5].active = false;
    end

    if cfgHistoricalRelics.tag3 ~= nil and cfgHistoricalRelics.tag3 ~= "" then
        this.vm.data.relicslinkList[6].des = LuaMgr.GetLangText(cfgHistoricalText[cfgHistoricalRelics.tag3].TextLan);
        this.vm.data.relicslinkList[6].active = true;
        this.vm.data.relicslinkList[6].linkID = cfgHistoricalRelics.tag3;
    else
        this.vm.data.relicslinkList[6].active = false;
    end

    if cfgHistoricalRelics.tag4 ~= nil and cfgHistoricalRelics.tag4 ~= "" then
        this.vm.data.relicslinkList[7].des = LuaMgr.GetLangText(cfgHistoricalText[cfgHistoricalRelics.tag4].TextLan);
        this.vm.data.relicslinkList[7].active = true;
        this.vm.data.relicslinkList[7].linkID = cfgHistoricalRelics.tag4;
    else
        this.vm.data.relicslinkList[7].active = false;
    end


end

this.SetRelicsHistoryRoute = function()
    this.vm.data.relicsItemList = {};
    local list = {};
    if (LuaMgr.HasLang(cfgHistoricalRelics.ageAlan)) then
        local relicsA = { year = LuaMgr.GetLangText(cfgHistoricalRelics.ageAlan), des = LuaMgr.GetLangText(cfgHistoricalRelics.ageStoryAlan), relicsBool = false }
        table.insert(list, relicsA);
    end
    if (LuaMgr.HasLang(cfgHistoricalRelics.ageBlan)) then
        local relicsB = { year = LuaMgr.GetLangText(cfgHistoricalRelics.ageBlan), des = LuaMgr.GetLangText(cfgHistoricalRelics.ageStoryBlan), relicsBool = false }
        table.insert(list, relicsB);
    end
    if (LuaMgr.HasLang(cfgHistoricalRelics.ageClan)) then
        local relicsC = { year = LuaMgr.GetLangText(cfgHistoricalRelics.ageClan), des = LuaMgr.GetLangText(cfgHistoricalRelics.ageStoryClan), relicsBool = false }
        table.insert(list, relicsC);
    end
    if (LuaMgr.HasLang(cfgHistoricalRelics.ageDlan)) then
        local relicsD = { year = LuaMgr.GetLangText(cfgHistoricalRelics.ageDlan), des = LuaMgr.GetLangText(cfgHistoricalRelics.ageStoryDlan), relicsBool = false }
        table.insert(list, relicsD);
    end
    if (LuaMgr.HasLang(cfgHistoricalRelics.ageElan)) then
        local relicsD = { year = LuaMgr.GetLangText(cfgHistoricalRelics.ageElan), des = LuaMgr.GetLangText(cfgHistoricalRelics.ageStoryElan), relicsBool = false }
        table.insert(list, relicsD);
    end
    if (LuaMgr.HasLang(cfgHistoricalRelics.ageFlan)) then
        local relicsD = { year = LuaMgr.GetLangText(cfgHistoricalRelics.ageFlan), des = LuaMgr.GetLangText(cfgHistoricalRelics.ageStoryFlan), relicsBool = false }
        table.insert(list, relicsD);
    end
    this.vm.data.relicsItemList = list;
end


this.SetAssessData = function()

    assessIndex = 0;
    assessMoveDir = -1;
    local baseFile = cfgCharactorFiles.basicFileID;
    local baseCount, baseUnlockCount = this.SetAssessPrograss(baseFile, cfgCharactorFiles.basicFileUnlock);
    this.SetAssessItem(baseFile, 1);

    local specialFile = cfgCharactorFiles.specialFileID;
    local speicalCount, speicalUnlockCount = this.SetAssessPrograss(specialFile, cfgCharactorFiles.specialFileUnlock);
    this.SetAssessItem(specialFile, 2);

    local avgFile = cfgCharactorFiles.AVGFileID;
    local avgCount, avgUnlockCount = this.SetAssessPrograss(avgFile, cfgCharactorFiles.AVGFileUnlock);
    this.SetAssessItem(avgFile, 3);

    local totalUnlockCount = baseUnlockCount + speicalUnlockCount + avgUnlockCount;
    local totalCount = baseCount + speicalCount + avgCount;
    this.vm.data.assess_process = totalUnlockCount .. "/" .. totalCount;
    this.SetAssessTitleRed();
    this.AssessOpen(1);
end

this.SetAssessTitleRed = function()
    local basicRedNum = 0;
    local specialRedNum = 0;
    local avgRedNum = 0;
    for i, v in pairs(HeroRedDataHelper.archives_assess_BasicFileIDRedList) do
        if v > 0 then
            basicRedNum = basicRedNum + 1;
            break ;
        end
    end
    for i, v in pairs(HeroRedDataHelper.archives_assess_SpecialFileIDRedList) do
        if v > 0 then
            specialRedNum = specialRedNum + 1;
            break ;
        end
    end
    for i, v in pairs(HeroRedDataHelper.archives_assess_AvgFileIDRedList) do
        if v > 0 then
            avgRedNum = avgRedNum + 1;
            break ;
        end
    end
    RedMgr.Singleton:UpdateClientRedData("1124_1", basicRedNum);
    RedMgr.Singleton:UpdateClientRedData("1124_2", specialRedNum);
    RedMgr.Singleton:UpdateClientRedData("1124_3", avgRedNum);
    RedMgr.Singleton:Refresh();
end

this.SetAssessPrograss = function(fileData, fileUnlock)
    local unlockCount = 0;
    local len = NumTool.GetLen(fileData);
    if len ~= 0 then
        for i, v in ipairs(fileData) do
            local unlock = this.AssessUnlock(fileUnlock[i]);
            if unlock ~= nil and unlock then
                unlockCount = unlockCount + 1;
            end
        end
    end
    return len, unlockCount;
end

this.SetAssessItem = function(files, index)
    if files == nil or #files == 0 then
        this.vm.data.assessList[index].isActive = false;
        return ;
    end
    assessIndex = assessIndex + 1;
    this.vm.data.assessList[index].redId = "1124_" .. index;
    this.vm.data.assessList[index].isActive = true;
    this.vm.data.assessList[index].assessPos = Vector2(0, -50 - assessOffSetY * (assessIndex - 1));
    this.vm.data.assessList[index].BG = LuaMgr.GetSprite("Archives", "ui_da_pgdi_01");
    this.vm.data.assessList[index].index = assessIndex;
    this.vm.data.assessList[index].contentActive = false;
    this.vm.data.assessList[index].title = string.format("<color=#A29A83>%s</color>", this.vm.data.assessList[index].text)
    this.SetAssessTitleRed(index)
end

this.AssessTipMsg = function(data)
    local langGlobalId = nil;
    local text = nil;
    if (tonumber(data.UnlockType) == 1) then
        langGlobalId = 2130;
        text = tostring(data.ElementID)
    elseif (tonumber(data.UnlockType) == 2) then
        langGlobalId = 2131;
        text = tostring(data.ElementID)
    elseif (tonumber(data.UnlockType) == 3) then
        langGlobalId = 2134;
        local dungeon = ConfigMgr.Config.dungeonMap[tostring(data.ElementID)];
        local namelan = dungeon ~= nil and dungeon.NameLan or "";
        text = LuaMgr.GetLangText(namelan);
    elseif (tonumber(data.UnlockType) == 4) then
        langGlobalId = 2132;
        text = LuaMgr.GetLangText(ConfigHelper.GetItemNamelan(tostring(data.ElementID)));
    end
    local langText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal[tostring(langGlobalId)].NameLan);
    if langGlobalId == 2131 then
        return string.format(langText, text, ConfigHelper.GetFriendlyLevelText(data.ElementID))
    else
        return string.format(langText, text)
    end
end





this.AssessUnlock = function(data)
    local unlock = false;
    local unlockText = "";
    if (tonumber(data.UnlockType) == 1) then
        if (dataCharacter.level >= tonumber(data.ElementID)) then
            unlock = true
        end
    elseif (tonumber(data.UnlockType) == 2) then
        if dataCharacter.prestigeLevel >= tonumber(data.ElementID) then
            unlock = true;
        end
    elseif (tonumber(data.UnlockType) == 3) then
        if dataDungeonRecords[data.ElementID] ~= nil then
            unlock = true;
        end
    elseif (tonumber(data.UnlockType) == 4) then
        local num = DataHelper.GetItemCountById(data.ElementID)
        if num > 0 then
            unlock = true;
        end
    else
        unlock = true;
    end
    return unlock, unlockText;

end





this.AssessHeadIconSprite = function(headIcon)
    local texture = nil;
    if (headIcon[1] == "0") then
        texture = LuaMgr.GetTexture(headIconPath1 .. headIcon[2] .. ".png");
    elseif (headIcon[1] == "1") then
        local path = HeroManager.GetCharacterAvatar(headIcon[2]);
        texture = LuaMgr.GetTexture(path);
    end
    return texture;
end

this.AssessOpenBaseInfo = function(index)
    this.vm.data.assess_InfoBool = true;
    this.vm.data.assess_baseInfoBool = true;
    this.vm.data.assessText_contentAnchorPos = Vector2(0, 0);
    local textId = cfgCharactorFiles.basicFileID[index];
    local textInfo = cfgCharactorFilesText[textId];
    if textInfo ~= nil then
        this.vm.data.assess_Info = LuaMgr.GetLangText(textInfo.textLan);
        this.vm.data.assess_titleInfo = LuaMgr.GetLangText(textInfo.titleLan);
        if textInfo.photo ~= nil and textInfo.photo ~= "" then
            this.vm.data.assess_ImgBool = true;
            this.vm.data.assess_ImgSprite = LuaMgr.GetTexture(Path.FileText_PATH .. textInfo.photo .. "png");
        else
            this.vm.data.assess_ImgBool = false;
        end
    end
    LuaMgr.DelayFrame(function()
        this.vm.data.assess_baseInfoBool = false;
        this.vm.data.assess_baseInfoBool = true;
    end)
end

this.AssessOpenSecretInfo = function(index)
    this.vm.data.assess_InfoBool = true;
    this.vm.data.assess_secretInfoBool = true;
    this.vm.data.assessText_contentAnchorPos = Vector2(0, 0);
    local textId = cfgCharactorFiles.specialFileID[index];
    local textInfo = cfgCharactorFilesText[textId];
    if textInfo ~= nil then
        this.vm.data.assess_Info = LuaMgr.GetLangText(textInfo.textLan);
        this.vm.data.assess_titleInfo = LuaMgr.GetLangText(textInfo.titleLan);
        if textInfo.photo ~= nil and textInfo.photo ~= "" then
            this.vm.data.assess_ImgBool = true;
            this.vm.data.assess_ImgSprite = LuaMgr.GetTexture(Path.FileText_PATH .. textInfo.photo .. ".png");
        else
            this.vm.data.assess_ImgBool = false;
        end
    end
    LuaMgr.DelayFrame(function()
        this.vm.data.assess_secretInfoBool = false;
        this.vm.data.assess_secretInfoBool = true;
    end)
end

this.AssessOpenAVGInfo = function(index)
    local narrativelId = cfgCharactorFiles.AVGFileID[index]
    HeroRedDataHelper.Archives_ClearAssessPlayerPrefsFile(characterId, 3, cfgCharactorFiles.AVGFileID[index])
    LuaMgr.PlayNovel(narrativelId, function()
        LuaMgr.ShowLuaPanel("HeroArchivesViewModel", characterId, 2);
    end)
end

this.AssessOpen = function(index)
    if assessMoving then
        return
    end ;
    if assessKey ~= nil then
        coroutine_runner.stop(assessKey);
    end
    assessKey = coroutine_runner.start(function()
        if assessBeforeIndex > 0 and assessBeforeIndex ~= index and assessMoveDir > 0 then
            this.vm.data.assessList[assessBeforeIndex].contentActive = false;
            this.vm.data.assessList[assessBeforeIndex].BG = LuaMgr.GetSprite("Archives", "ui_da_pgdi_01");
            this.vm.data.assessList[assessBeforeIndex].title = string.format("<color=#A29A83>%s</color>", this.vm.data.assessList[assessBeforeIndex].text);
            this.AssessDoMove(assessBeforeIndex);
            coroutine_runner.wait(0.08);
        end
        assessBeforeIndex = index;
        if assessMoveDir < 0 then
            if index == 1 then
                this.ShowBaseAssetItem(index);
            elseif index == 2 then
                this.ShowSecretAssetItem(index);
            elseif index == 3 then
                this.ShowAcgAssetItem(index);
            end
        end
        this.vm.data.assessList[index].contentActive = assessMoveDir < 0;
        this.vm.data.assessList[index].BG = assessMoveDir < 0
                and LuaMgr.GetSprite("Archives", "ui_da_pgdi_02") or LuaMgr.GetSprite("Archives", "ui_da_pgdi_01");
        this.vm.data.assessList[index].title = assessMoveDir < 0 and
                string.format("<color=#efe5cc>%s</color>", this.vm.data.assessList[index].text)
                or string.format("<color=#A29A83>%s</color>", this.vm.data.assessList[index].text);
        this.AssessDoMove(index);
    end)

end

this.AssessDoMove = function(index)
    local offHight = assessMoveDir * 150;
    assessMoveDir = -assessMoveDir;
    if index == #this.vm.data.assessList then
        return
    end ;
    local moveLength = 0;
    if index == 1 then
        moveLength = math.ceil(#cfgCharactorFiles.basicFileID / 2) * offHight;
    elseif index == 2 then
        moveLength = math.ceil(#cfgCharactorFiles.specialFileID / 2) * offHight;
    elseif index == 3 then
        moveLength = math.ceil(#cfgCharactorFiles.AVGFileID / 2) * offHight;
    end
    for i = index + 1, #this.vm.data.assessList, 1 do
        if this.vm.data.assessList[i].isActive then
            assessMoving = true;
            DOTWeen                                                                       .To(function()
                return this.vm.data.assessList[i].assessPos
            end,
                    function(vect)
                        this.vm.data.assessList[i].assessPos = vect
                    end,
                    Vector2(0, this.vm.data.assessList[i].assessPos.y + moveLength), 0.05).onComplete = function()
                assessMoving = false;
            end;
        end

    end

end

this.ShowAssetAnima = function(list)
    for i, v in ipairs(list) do
        v.active = true;
    end
end


this.IsReward=function(type,index)
    local characterData=DataMgr.Player.characters[characterId];
    if not IsNull(characterData) then
        local rewardList={};
        if type==0 then
            if not IsNull(characterData.fileUnlock) then
                rewardList=characterData.fileUnlock.BaseUnlock;
            else
                LuaDebug.error("器者档案评估报告页签数据为空characterData.fileUnlock.BaseUnlock")
            end
        elseif type==1 then
            if not IsNull(characterData.fileUnlock) then
                rewardList=characterData.fileUnlock.SpecialUnlock;
            else
                LuaDebug.error("器者档案评估报告页签数据为空characterData.fileUnlock.SpecialUnlock")
            end
        end
        if rewardList~=nil and #rewardList>0 then
            for i,v in ipairs(rewardList) do
                if index==tonumber(v) then
                    return true;
                end
            end
        end
    end
    return false;
end



this.ShowBaseAssetItem = function(index)
    this.vm.data.baseItemList = {};
    local list = {};
    
    local rewardList={};
    if cfgCharactorFiles.basicFileUnlockReward~=nil and #cfgCharactorFiles.basicFileUnlockReward>0 then
        for i,v in ipairs(cfgCharactorFiles.basicFileUnlockReward) do
            if v.id~="0" and v.count~=0 then
                local rewardItem=ConfigHelper.CreateGoodsItem(v.id,v.count,0.4,true,true);
                table.insert(rewardList,rewardItem);
            end
        end
    end

    for i, v in ipairs(cfgCharactorFiles.basicFileID) do
        local baseText = cfgCharactorFilesText[v];
        if baseText ~= nil then
            local unlock, lockInfo = this.AssessUnlock(cfgCharactorFiles.basicFileUnlock[i]);
            local iconIndex = unlock and 1 or 3;
            local baseItem={};
            local isRewarded=this.IsReward(0,i-1);
            if cfgCharactorFiles.basicFileUnlockReward~=nil and #cfgCharactorFiles.basicFileUnlockReward>0 and not isRewarded then
                local item=cfgCharactorFiles.basicFileUnlockReward[i]
                if item.id~="0" and item.count~=0 then
                    baseItem=ConfigHelper.CreateGoodsItem(item.id,item.count,0.4,true,true);
                else
                    isRewarded=true;
                end
            end
            baseItem.info = LuaMgr.GetLangText(baseText.titleLan);
            baseItem.type = LuaMgr.GetSprite("Archives", this.vm.data.assessList[index].sprite .. iconIndex);
            baseItem.headIconBool = unlock;
            baseItem.headIcon = this.AssessHeadIconSprite(baseText.headPhoto);
            baseItem.redId = "1124_" .. v;
            baseItem.active = false;
            baseItem.isRewarding=unlock and not isRewarded;
            baseItem.rewardLock=not unlock;
            table.insert(list, baseItem);
        end
    end
    
    this.vm.data.baseItemList = list;
    this.ShowAssetAnima(this.vm.data.baseItemList)
    this.SetAssessItemRed(cfgCharactorFiles.basicFileID, index)


end

this.ShowSecretAssetItem = function(index)
    this.vm.data.secretItemList = {};
    local list = {};
    for i, v in ipairs(cfgCharactorFiles.specialFileID) do
        local baseText = cfgCharactorFilesText[v];
        if baseText ~= nil then
            local unlock, lockInfo = this.AssessUnlock(cfgCharactorFiles.specialFileUnlock[i]);
            local iconIndex = unlock and 1 or 3;
            local isRewarded=this.IsReward(1,i-1);
            local baseItem={}
            if cfgCharactorFiles.specialFileUnlockReward~=nil and #cfgCharactorFiles.specialFileUnlockReward>0 and not isRewarded then
                local item=cfgCharactorFiles.specialFileUnlockReward[i]
                if item.id~="0" and item.count~=0 then
                    baseItem=ConfigHelper.CreateGoodsItem(item.id,item.count,0.4,true,true);
                else
                    isRewarded=true;
                end
            end
            baseItem.info = LuaMgr.GetLangText(baseText.titleLan);
            baseItem.type = LuaMgr.GetSprite("Archives", this.vm.data.assessList[index].sprite .. iconIndex);
            baseItem.headIconBool = unlock;
            baseItem.headIcon = this.AssessHeadIconSprite(baseText.headPhoto);
            baseItem.redId = "1124_" .. v;
            baseItem.active = false
            baseItem.isRewarding=unlock and not isRewarded;
            baseItem.rewardLock=not unlock;
            table.insert(list, baseItem);
        end
    end
    this.vm.data.secretItemList = list;
    this.ShowAssetAnima(this.vm.data.secretItemList)
    this.SetAssessItemRed(cfgCharactorFiles.specialFileID, index)

end

this.ShowAcgAssetItem = function(index)
    this.vm.data.avgItemList = {};
    local list = {};
    for i, v in ipairs(cfgCharactorFiles.AVGFileID) do
        local unlock, lockInfo = this.AssessUnlock(cfgCharactorFiles.AVGFileUnlock[i]);
        local nameLan = cfgNarrativeMap[v].nameLan;
        local iconIndex = unlock and 1 or 3;
        local baseItem = {
            info = LuaMgr.GetLangText(nameLan),
            headIconBool = unlock;
            type = LuaMgr.GetSprite("Archives", this.vm.data.assessList[index].sprite .. iconIndex);
            redId = "1124_" .. v;
            active = false
        }
        table.insert(list, baseItem);
    end
    this.vm.data.avgItemList = list;
    this.ShowAssetAnima(this.vm.data.avgItemList)
    this.SetAssessItemRed(cfgCharactorFiles.AVGFileID, index)
end

this.SetAssessItemRed = function(files, index)
    if index == 1 then
        for i, v in pairs(files) do
            local redNum = HeroRedDataHelper.archives_assess_BasicFileIDRedList[v];
            if redNum ~= nil then
                RedMgr.Singleton:UpdateClientRedData("1124_" .. v, redNum);
            end
        end
    elseif index == 2 then
        for i, v in pairs(files) do
            local redNum = HeroRedDataHelper.archives_assess_SpecialFileIDRedList[v];
            if redNum ~= nil then
                RedMgr.Singleton:UpdateClientRedData("1124_" .. v, redNum);
            end
        end
    elseif index == 3 then
        for i, v in pairs(files) do
            local redNum = HeroRedDataHelper.archives_assess_AvgFileIDRedList[v];
            if redNum ~= nil then
                RedMgr.Singleton:UpdateClientRedData("1124_" .. v, redNum);
            end
        end
    end
    RedMgr.Singleton:Refresh();
end


this.SetSayingData = function()
    curSayingIndex = 0;
    sayingResLine = ConfigMgr.Config.RESLinesMap[characterId]
    if dataCharacter.LinesType ~= nil then
        saying_type = dataCharacter.LinesType;
        if saying_type == "" then
            saying_type = sayingResLine.Linestype[1]
        end
        local index = 1;
        for i, v in ipairs(sayingResLine.Linestype) do
            if v == saying_type then
                index = i
                break
            end
        end
        local cvNames = LuaMgr.GetLangText(sayingResLine.CvLan)
        cvNames = NumTool.split(cvNames, ";");
        this.vm.data.saying_cvName = cvNames[index];
        this.vm.data.saying_cvBool = cvNames[index] ~= "";


    end
    this.vm.data.saying_voiceAddBool = #sayingResLine.Linestype > 1;
    this.vm.data.hero_relics = LuaMgr.GetLangText(cfgCharacterTable.namelan);
    if not TableIsNull(cfgCharactorSkin) then
        this.vm.data.hero_skinDes = LuaMgr.GetLangText(cfgCharactorSkin.skinNamelan);
    end
    this.vm.data.saying_dialog = false;
    this.vm.data.saying_process = "";
    this.vm.data.sayingItemList = {};
    local list = {};
    local process = 0;
    for i, v in ipairs(cfgLinesUnlock) do
        local unlock = this.SayingUnlock(v.linesType)
        process = unlock and process + 1 or process;
        local bgName = unlock and "ui_da_yldi_1" or "ui_da_yldi_3";
        local sayingItem = { BG = LuaMgr.GetSprite("Archives", bgName),
                             on = false, off = unlock,
                             suo = not unlock,
                             btnBool = unlock,
                             progross = 0.0,
                             lineType = v.linesType,
                             info = LuaMgr.GetLangText(v.typeNamelan),
                             unlockConditon = LuaMgr.GetLangText(v.unLockTextlan),
                             textColor = unlock and sayingColor2 or sayingColor3,
                             num = v.num,
                             sayingBool = false,
                             redId = "1126_" .. v.linesType;
        };
        table.insert(list, sayingItem);
        this.SetSayingRed(v)
    end
    list = this.sayingSort(list);
    this.vm.data.saying_process = "<color=#efe5cc><size=28>" .. process .. "</size></color>" .. "<color=#c1c0c0><size=24> /" .. #cfgLinesUnlock .. "</size></color>";
    this.vm.data.sayingItemList = list;
    RedMgr.Singleton:Refresh();

    if (sayingKey ~= nil) then
        coroutine_runner.stop(sayingKey);
    end
    coroutine_runner.start(function()
        for i, v in ipairs(this.vm.data.sayingItemList) do
            coroutine_runner.wait(0.03);
            v.sayingBool = true;
        end
    end)

end

this.SetSayingRed = function(sayingItem)
    local redNum = HeroRedDataHelper.archives_saying_redList[sayingItem.linesType];
    RedMgr.Singleton:UpdateClientRedData("1126_" .. sayingItem.linesType, redNum);

end
this.sayingSort = function(list)
    local locklist = {};
    table.sort(list, function(a, b)
        return a.num <= b.num;
    end)
    for i = #list, 1, -1 do
        if (list[i].suo) then
            table.insert(locklist, list[i]);
            table.remove(list, i);
        end
    end
    table.sort(locklist, function(a, b)
        return a.num < b.num;
    end)
    for i, v in ipairs(locklist) do
        table.insert(list, v);
    end
    return list;
end

this.SayingUnlock = function(type)
    local unlockLines = dataCharacter.unlockedLines;
    local re = unlockLines[type];
    return re ~= nil;
end

this.SayingPreparePlayVoice = function(index)
    if (curSayingIndex == index) then
        local isOn = this.vm.data.sayingItemList[index].on;
        if (isOn) then
            this.SayingPlayVoice(false, index);
        else
            this.SayingPrepareLinesType(index);
            this.SayingPlayVoice(true, index);
        end
        return ;
    end
    if (curSayingIndex ~= 0) then
        this.SayingPlayVoice(false, curSayingIndex, true);
    end
    curSayingIndex = index;
    this.SayingPlayVoice(true, index);
    this.SayingPrepareLinesType(index);


end

this.SayingItemOn = function(index)
    this.vm.data.sayingItemList[index].BG = LuaMgr.GetSprite("Archives", "ui_da_yldi_2");
    this.vm.data.sayingItemList[index].textColor = sayingColor1;
    this.vm.data.sayingItemList[index].on = true;
    this.vm.data.sayingItemList[index].off = false;
end
this.SayingItemOff = function(index)
    this.vm.data.sayingItemList[index].BG = LuaMgr.GetSprite("Archives", "ui_da_yldi_1");
    this.vm.data.sayingItemList[index].textColor = sayingColor2;
    this.vm.data.sayingItemList[index].on = false;
    this.vm.data.sayingItemList[index].off = true;
    this.vm.data.sayingItemList[index].progross = 0.0;
end


this.SayingGetSkinID = function()
    local skinID = HeroManager.GetCharacterSkin(characterId);
    cfgCharacterLines = ConfigMgr.Config.characterLines[skinID];
    if (cfgCharacterLines == nil) then
        skinID = characterId .. "001";
    end
    return skinID;
end



this.SayingPrepareLinesType = function(index)
    local skinID = this.SayingGetSkinID();
    local text = nil;
    cfgCharacterLines = ConfigMgr.Config.characterLines[skinID];
    if saying_type == sayingResLine.Linestype[1] then
        if (cfgCharacterLines == nil) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("HeroArchivesViewModel_13"));
            return
        end ;
        local type = this.vm.data.sayingItemList[index].lineType .. "Lan";
        local lang = LuaMgr.HasLang(cfgCharacterLines[type]);
        if (not lang) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("HeroArchivesViewModel_13"));
            return ;
        end
        text = LuaMgr.GetLangText(cfgCharacterLines[type]);
    else
        local key = skinID .. "_" .. saying_type
        local characterLineLan = ConfigMgr.Config.CharacterLinesLanMap[key]
        if characterLineLan == nil then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("HeroArchivesViewModel_13"));
            return
        end
        local lineType = this.vm.data.sayingItemList[index].lineType;

        text = characterLineLan[lineType]
    end
    this.vm.data.saying_dialogContent = "";
    this.vm.data.saying_msgContentSizeFitterBool = false;
    this.vm.data.saying_msgContentSizeData = Vector2(567, 170);
    this.vm.data.saying_dialog = true;

    if (text ~= nil) then
        local usingID = HeroMgr.GetHeroMsgUsingID(characterId)
        this.vm.data.msgSkin = LuaMgr.GetSprite("HeroMsgBg","Msg_"..usingID)
        local color = "FFFFFF"
        if not TableIsNull(ConfigMgr.Config.DialogFrameMap) and not ConfigMgr.Config.DialogFrameMap[usingID] ~= nil then
            color = ConfigMgr.Config.DialogFrameMap[usingID].RGB
        end
        local r,g,b = hexToRGB(color)
        this.vm.data.msgTextColor = UnityEngine.Color(r / 255, g / 255, b / 255, 1)
        this.vm.data.saying_dialogText = cfgCharacterLines.lineType ~= 2;
        this.vm.data.saying_dialogRaw = cfgCharacterLines.lineType == 2;
        if cfgCharacterLines.lineType == 2 then
            this.SayingRawImageType(text);
            return ;
        end
        if string.match(text, "player") then
            text = string.gsub(text, "player", DataMgr.Player.name);
        end
        lineStartIndex = 0;
        if sayingKey2 ~= nil then
            coroutine_runner.stop(sayingKey2);
        end
        local endLenth = LuaMgr.GetStringLength(text);
        LuaMgr.RemoveTimer(TimerConst.LinesType);
        LuaMgr.AddTimer(TimerConst.LinesType, function()
            this.SayingPlayLinesType(text, endLenth);
        end, 0.1);
    end
end

this.SayingRawImageType = function(imageName)
    local path = string.format("%s%s.png", saying_rawPath, imageName);
    this.vm.data.saying_ContentAnchor = Vector2(0, 0);
    local texture = LuaMgr.GetTexture(path);
    if texture == nil then
        return
    end ;
    this.vm.data.saying_Raw = texture;
    if saying_toweener ~= nil then
        saying_toweener:Kill();
    end
    saying_toweener = DOTWeen                                .To(function()
        return Vector2(0, 0)
    end, function(vector)
        this.vm.data.saying_RawAnchorPos = vector;
    end, Vector2(0, texture.height - 80), saying_voiceLength):SetEase(Ease.Linear);

end

this.SayingPlayLinesType = function(line, endLenth)
    textSaying = true;
    if (lineStartIndex <= endLenth) then
        local value = LuaMgr.Substring(line, lineStartIndex);
        this.vm.data.saying_dialogContent = value;
        this.SayingMsgTextAdjustSize();
        lineStartIndex = lineStartIndex + 1;
    else
        textSaying = false;
        LuaMgr.RemoveTimer(TimerConst.LinesType);
        if not isSayVoice then
            sayingKey2 = coroutine_runner.start(function()
                coroutine_runner.wait(2)
                this.vm.data.saying_dialog = false;
            end)

        end
    end

end

this.SayingMsgTextAdjustSize = function()
    local lineCount = sayingText.cachedTextGenerator.lineCount;
    if (lineCount > 3) then
        this.vm.data.saying_msgContentSizeFitterBool = true;
    else
        this.vm.data.saying_msgContentSizeFitterBool = false;
        this.vm.data.saying_msgContentSizeData = Vector2(567, 170);
    end
end





this.SayingPlayVoice = function(isOn, index, noClose)
    if (isOn) then
        local andioSkin = this.SayingGetSkinID()
        local linetype = this.vm.data.sayingItemList[index].lineType;
        local audioName = "character_" .. linetype .. "_" .. andioSkin;
        local audioType = saying_type == sayingResLine.Linestype[1] and "Audio" or "Audio_" .. saying_type;
        local path = string.format("%s%s/%s/%s.mp3", voicePath, characterId, audioType, audioName);
        local audioSource = AudioMgr.Singleton:PlayVoice(path)

        HeroRedDataHelper.Archives_ClearSayingPlayerPrefs(characterId, linetype);
        if audioSource==nil then
             audioName = "character_" .. linetype .. "_" .. characterId.."001";
             audioType = saying_type == sayingResLine.Linestype[1] and "Audio" or "Audio_" .. saying_type;
             path = string.format("%s%s/%s/%s.mp3", voicePath, characterId, audioType, audioName);
             audioSource = AudioMgr.Singleton:PlayVoice(path)
        end
        if (audioSource == nil) then
            isSayVoice = false;
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("HeroArchivesViewModel_15"));
            return
        end ;
        isSayVoice = true;
        saying_voiceLength = audioSource.clip.length;
        if (tweener ~= nil) then
            tweener:Kill();
        end
        LuaMgr.RemoveTimer(TimerConst.DelayClose);
        tweener = DOTWeen.To(function() return 0.0 end, function(o)
                    this.vm.data.sayingItemList[index].progross = o;
                end, 1, saying_voiceLength):SetEase(Ease.Linear);
        tweener.onComplete = function()
            isSayVoice = false;
            this.vm.data.sayingItemList[index].progross = 0;
            this.SayingItemOff(index);
            this.DelayCloseSayingDiaog();
        end
        this.SayingItemOn(index);
    else
        if (tweener ~= nil) then
            tweener:Kill();
        end
        AudioMgr.Singleton:StopVoice(false);
        this.DelayCloseSayingDiaog();
        this.SayingItemOff(index);
        if (noClose ~= nil and noClose) then
            this.DelayCloseSayingDiaog();
        end
        this.DelayCloseSayingDiaog();
    end

end

this.DelayCloseSayingDiaog = function()
    if this.vm.data.saying_dialog == false or textSaying then
        return
    end ;
    LuaMgr.RemoveTimer(TimerConst.DelayClose);
    LuaMgr.AddTimer(TimerConst.DelayClose, function()
        this.vm.data.saying_dialog = false;
        LuaMgr.RemoveTimer(TimerConst.DelayClose);
    end, 2, 10, false);

end

this.SetSayingTypeList = function()
    this.vm.data.saying_voiceList = {};
    local cvNames = LuaMgr.GetLangText(sayingResLine.CvLan)
    cvNames = NumTool.split(cvNames, ";");
    local list = {}
    for i, v in ipairs(sayingResLine.Linestype) do
        local typeItem = {
            isOn = saying_type == v,
            des = LuaMgr.GetLangText(ConfigMgr.Config.RESDownloadMap[v].RESNameLan),
            name = cvNames[i],
            color = saying_type == v and sayingColorWhite or sayingColorGray,
            isLoad = false,
            tipText=LuaMgr.GetLangText(ConfigMgr.Config.RESDownloadMap[v].TipsLan),
        }
        typeItem.isTip=typeItem.tipText~=nil and typeItem.tipText~=""
        if saying_type == v then
            saying_typeIndex = i;
        end
        table.insert(list, typeItem)
    end

    this.vm.data.saying_voiceList = list;
    this.vm.data.isLanTips=false;

end

return vm({
    data = data,
    command = command,
    hook = hook
})