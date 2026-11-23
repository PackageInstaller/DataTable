










TeaTastSipViewModel={};
local heroIconPath = "Assets/_BundleResources/Character/"
local this = {
    vm = nil,
}

local spineUICharacter = nil
local FunctionGroup = { funs = nil }
local CloseChatItem = nil
local AnmiatorRoot=nil
local RemerSelectHero = nil
local TalkStateEmm = {
untalk = -1,
current = 0,
talkSuc = 1,
talkdef = 2 }

local heroProp
local currentTemp
local InterestReward = nil

local data = {
    goConnectFourRedPointGroup=false,
    goConnectTurnRedPointGroup=false,
    goConnect2048RedPointGroup=false,
    goConnectPuzzleRedPointGroup=false,
    goConnectMusicRedPointGroup=false,
    goFourGood=false,
    goTurnTableGood=false,
    go2048Good=false,
    goPuzzleGood=false,
    goMusicTableGood=false,
    goPuzzleRed=false,
    goPuzzleTime=false,
    fourGood={id="0",count="0",sizeDelta=Vector2.zero,isCount=true,rare=DefaultSprite,icon=DefaultTexture,scale=Vector3.zero,isClick=true},
    puzzleGood={id="0",count="0",sizeDelta=Vector2.zero,isCount=true,rare=DefaultSprite,icon=DefaultTexture,scale=Vector3.zero,isClick=true},
    turnTableGood={id="0",count="0",sizeDelta=Vector2.zero,isCount=true,rare=DefaultSprite,icon=DefaultTexture,scale=Vector3.zero,isClick=true},
    game2048Good={id="0",count="0",sizeDelta=Vector2.zero,isCount=true,rare=DefaultSprite,icon=DefaultTexture,scale=Vector3.zero,isClick=true},
    musicTableGood={id="0",count="0",sizeDelta=Vector2.zero,isCount=true,rare=DefaultSprite,icon=DefaultTexture,scale=Vector3.zero,isClick=true},
    spineheroPath = "",
    heroTexture = DefaultTexture,
    msgContentText = "",
    msgMakesureSppedUp = "",
    answerselectTitleTip = "",
    msgHeroName = "",
    contentText = "",
    resultShowTitle = "",
    timeshowHour = "",
    timeshowSecond = "",
    timeshowminus = "",
    drinkTeaTimes = "",
    leftDrinkTeaTimes = 0,
    teaEnterOpen = true,
    teaHeroSelectShow = false,
    teaHearoPorup = false,
    teaHeroTalk = false,
    teaHeroBoday = false,
    teaTalkRank = true,
    teaHeroState = false,
    teaHeroStateUp = false,
    teaTalkContent = false,
    showTalkMessage = false,
    heroMaskShow = false,
    interestTopic = false,
    boringTopic = false,
    boringImage=false,
    feedbackText = "",
    donotHaveCharacter = false,

    showSmallHead = DefaultTexture,

    dringTimesLimit = false,

    dringTimesNoLimit = true,
    answerInterestConstant = false,
    answerBoringConstant = false,
    answerInterestAnimator = false,
    goConnectFourLock=false,
    goConnectTurnLock=false,
    goConnect2048Lock=false,
    goConnectPuzzleLock=false,
    goConnectMusicLock=false,
    goConnectBalatroLock = false,
    
    NovelList = {
        {
            OptionText = "",
            c_index=0,
            interesting = false,
        }
    },
    HeroStateShow = {
        {
            UI_Lock_Shine=false;
            goUpLock=false;
            goLock=true;
            goCurrent = false,
            playAnimation = false,
            index = 1,
            state = TalkStateEmm.current,
        },
        {
            UI_Lock_Shine=false;
            goUpLock=false;
            goLock=true;
            goCurrent = false,
            playAnimation = false,
            index = 2,
            state = TalkStateEmm.untalk,
        },
        {
            UI_Lock_Shine=false;
            goUpLock=false;
            goLock=true;
            goCurrent = false,
            playAnimation = false,
            index = 3,
            state = TalkStateEmm.untalk,
        }
    },
}


local defaultTable = {
    teaEnterOpen = true,
    teaHeroSelectShow = false,
    teaHeroTalk = false,
    teaTalkRank = true,

    teaTalkContent = false,
    showTalkMessage = false,
    teaHeroStateUp = false,
    answerInterestAnimator = false,
}

local command = {
    ClickOptionCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.ClickOptionCommand();
        end
    },
    ClickConnectFourOpen = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            
            local unlockLv=ConfigMgr.Config.constants.FourInLineUnlock;
            if this.vm.data.goConnectFourLock then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7056"].NameLan),unlockLv))
                return
            end
            
            LuaMgr.ShowLuaPanel(UIName.ConnectFourViewModel)
        end
    },
    CloseHeroSelectClick = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.teaHeroSelectShow = false
        end
    },
    ClickHeroTalkBefore = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.NetSelectHeros()
        end
    },
    ClickSelectTalkItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

            local lua_Index = param + 1;

            if currentTemp == nil then
                currentTemp = os.time()
            else
                if os.time() - currentTemp <= 1 then
                    return
                else
                    currentTemp = os.time()
                end
            end

            this.vm.data.teaTalkContent = false
            this.NetLastTalkItem(this.vm.data.NovelList[lua_Index])
        end
    },

    ClickRankCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationTeaRoomTeaMain, true, nil)
            LuaMgr.ShowLuaPanel(UIName.TeaTastHistoryViewModel, function()
                LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationTeaRoomTeaMain, false, nil)
            end)
        end
    },

    ClickCloseTalk = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.ClickCloseTalk();
        end
    },
ClickConnectTurnTable = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local unlockLv=ConfigMgr.Config.constants.GameBoardUnlock;
            if this.vm.data.goConnectTurnLock then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7056"].NameLan),unlockLv))
                return
            end





            LuaMgr.ShowLuaPanel(UIName.TurnTableMainPageViewModel)


        end
    },
ClickConnect2048 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local unlockLv=ConfigMgr.Config.constants.NumberMergeUnlock;
            if this.vm.data.goConnect2048Lock then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7056"].NameLan),unlockLv))
                return
            end
            LuaMgr.ShowLuaPanel(UIName.MiniGame2048ViewModel)
        end
    },
    ClickConnectSawPuzzle = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local unlockLv=ConfigMgr.Config.constants.PuzzleUnlock;
            if this.vm.data.goConnectPuzzleLock then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7056"].NameLan),unlockLv))
                return
            end
            LuaMgr.ShowLuaPanel(UIName.SawPuzzleSelectViewModel)
        end
    },
    ClickConnectMusic = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local unlockLv=ConfigMgr.Config.constants.TH_MusicUnlock;
            if this.vm.data.goConnectMusicLock then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7056"].NameLan),unlockLv))
                return
            end            
            LuaMgr.ShowLuaPanel(UIName.RhythmGameMusicShortViewModel)
        end
    },
    ClickConnectBalatro = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if BalatroDataMgr.FunctionIsOpen() == false then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6901"].NameLan))
                return
            end
            LuaMgr.ShowLuaPanel(UIName.BalatroLaunchPanel)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.TeaTastSipViewModel)
        AnmiatorRoot = this.vm.behaviour.transform:Find("root"):GetComponent("Animator")
        heroProp = this.vm.behaviour.transform:Find("root/HeroProup"):GetComponent("Animator")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end

        vm.behaviour:UpdateTopBar(FoundationMgr.TeaRoom, this.OnBack)
        this.vm.data.msgMakesureSppedUp = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2119"].NameLan)

        this.vm.data.contentText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2114"].NameLan)
LuaMgr.ShowLuaPanel(UIName.TeaTastTaskPanel)
        this.CheckInitData()
        this.TeaPanelRedRefush()
        this.InitLangueGlobal()
        this.ShowConnectFourRankAward();
        this.PuzzleAwards();
        this.ShowTurnTableAward()
        this.Show2048Award();
        
        LuaMgr.AddUIEventListener(UIEventConst.FoundationTeaRoomCharacterClick, this.OnClickHero);
        LuaMgr.AddUIEventListener(UIEventConst.TeaMainPanelState, this.OnTeaMainPanleState);
        LuaMgr.AddUIEventListener(UIEventConst.TeaSelectTeaResult, this.SelectTeaResult);
        LuaMgr.AddUIEventListener(UIEventConst.TeaViewToOtherView, this.UpdateNextFrame);
        LuaMgr.AddUIEventListener(UIEventConst.TeaResultClose, this.TeaResultClose);
        LuaMgr.AddUIEventListener(UIEventConst.TeaFrequencyPanelClose, this.TeaFrequencyPanelClose);
        LuaMgr.AddUIEventListener(UIEventConst.FoundationUpLevelSuccessfulViewModel, this.FoundationUpLevel);
        
       
    end,
    before_deactive = function(vm)
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationTeaRoomTeaMain, false, nil);
        LuaMgr.RemoveTimer(TimerConst.TeaLastTime)

        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationTeaRoomCharacterClick, this.OnClickHero);
        LuaMgr.RemoveUIEventListener(UIEventConst.TeaMainPanelState, this.OnTeaMainPanleState);
        LuaMgr.RemoveUIEventListener(UIEventConst.TeaSelectTeaResult, this.SelectTeaResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.TeaViewToOtherView, this.UpdateNextFrame);
        LuaMgr.RemoveUIEventListener(UIEventConst.TeaResultClose, this.TeaResultClose);
        LuaMgr.RemoveUIEventListener(UIEventConst.TeaFrequencyPanelClose, this.TeaFrequencyPanelClose);
        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationUpLevelSuccessfulViewModel, this.FoundationUpLevel);
        
        LuaMgr.HidePanel(UIName.TeaTastResultPanel);
        LuaMgr.HidePanel(UIName.TeaBeforSelectPanel);
        LuaMgr.HidePanel(UIName.TeaMainPanel);
        LuaMgr.HidePanel(UIName.TeaFrequencyPanel);
        LuaMgr.HidePanel(UIName.TeaTastTaskPanel)
        this.vm.data.spineheroPath = ""
    end
}


this.FoundationUpLevel=function()
    this.RefushTeaTimes();
    this.ShowConnectFourRankAward();
    this.ShowTurnTableAward();
    this.Show2048Award();
    this.PuzzleAwards();
    HeroRedDataHelper.RefreshMiniGameRed();
    RedMgr.Singleton:Refresh();
end


this.ClickOptionCommand=function ()
    if this.vm.data.dringTimesLimit then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TeaTastSipViewModel_2"));
        return
    end
    
    LuaMgr.HidePanel(UIName.FoundationOperateViewModel);
    if PlayerFoundationMgr.IsTeaUpLevel() then
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6902"].NameLan))
        return
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationTeaRoomTeaMain, true, nil);

    if not this.vm.data.teaEnterOpen then
        return
    end

    LuaMgr.ShowLuaPanel(UIName.TeaMainPanel, this.vm.data.leftDrinkTeaTimes);
end

this.ClickCloseTalk=function ()
    if CloseChatItem == nil then
        this.CloseTalkMessage()
        if this.closeTalk then

            this.vm.data.showTalkMessage = false
            this.vm.data.teaTalkContent = false
this.vm.data.teaHeroTalk = false;
            LuaMgr.ShowLuaPanel(UIName.TeaTastResultPanel, InterestReward);
            CloseChatItem = function()
            end
        end
    else
        CloseChatItem()
        CloseChatItem = nil
    end
end


this.OnClickHero = function(args)
    
    if DataMgr.Player.hightea.Stage >= 2 and DataMgr.Player.hightea.Stage <= 4 then
        return
    end

    if LuaMgr.IsPanelOpen(UIName.TeaBeforSelectPanel) then
        return
    end
    
   local heroIndex = args[0];
RemerSelectHero = DataMgr.Player.hightea.Characters[heroIndex]
    this.ShowSelectHero(RemerSelectHero)
    this.vm.data.teaHeroSelectShow = true
    if (not IsObjectNull(AnmiatorRoot)) then
        AnmiatorRoot:Play("UI_TeaTastSipPanel_02")
    end
end

this.OnTeaMainPanleState = function(args)
    local state=args[0];

    if state then
        this.vm.data.teaEnterOpen=false;
LuaMgr.HidePanel(UIName.TeaTastTaskPanel)
    else
        this.vm.data.teaEnterOpen=true;
        if LuaMgr.IsPanelOpen(UIName.TeaTastSipViewModel) and (not LuaMgr.IsPanelOpen(UIName.TeaTastTaskPanel)) then
LuaMgr.ShowLuaPanel(UIName.TeaTastTaskPanel)
        end
    end
end

this.InitLangueGlobal = function()
    this.vm.data.timeshowHour = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2121"].NameLan)
    this.vm.data.timeshowminus = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2122"].NameLan)
    this.vm.data.timeshowSecond = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2271"].NameLan)
end

this.TeaPanelRedRefush = function()
    local ClickTeaTimesamp = UnityEngine.PlayerPrefs.GetString(DataMgr.Player.uid .. "teaLevelHave")
    for key, value in pairs(ConfigMgr.Config.highteaMain) do

        local num=0;
        if DataMgr.Player.items[value.ID] ~= nil then
            num = DataMgr.Player.items[value.ID].count0
        end

        if num > 0 then
            if ClickTeaTimesamp == "" or tonumber(ClickTeaTimesamp) <= LuaMgr.Timestamp() then
                RedMgr.Singleton:UpdateClientRedData("1077", 1)
            else
                return
            end
        end
    end
    end

    this.CheckInitData = function()
        local code = DataMgr.Player.hightea.Stage
        if code == 0 then
            if #DataMgr.Player.hightea.Characters ~= 0 then
                FoundationCharacterMgr.CreatQSpine(false)
            end

            this.RefushTeaTimes()
            return
        else
            this.vm.data.teaEnterOpen = false
LuaMgr.HidePanel(UIName.TeaTastTaskPanel)
            if code == 1 or code == 4 then
                if DataMgr.Player.hightea.Deadline - LuaMgr.Timestamp() > 0 then

                    if #DataMgr.Player.hightea.Characters ~= 0 then
                        FoundationCharacterMgr.CreatQSpine(false)
                    end
                else
                    this.vm.data.teaEnterOpen = false
                    LuaMgr.HidePanel(UIName.TeaTastTaskPanel)
                    if DataMgr.Player.hightea.Stage == 4 then
                        LuaMgr.ShowLuaPanel(UIName.TeaBeforSelectPanel,"");
                    end

                    FoundationCharacterMgr.CreatQSpine(code == 1)
                end

            elseif code == 2  then
                LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationTeaRoomTeaMain, true, nil);
                this.ShowSelectHero(DataMgr.Player.hightea.ChoseCharacter)
                this.SetCharacterSpine()
                this.vm.data.teaEnterOpen = false
LuaMgr.HidePanel(UIName.TeaTastTaskPanel)
                this.vm.data.showTalkMessage = false
                this.vm.data.teaTalkContent = true
                this.vm.data.teaHearoPorup = true
                this.vm.data.teaTalkRank = false
                this.vm.data.heroMaskShow = true
                this.vm.data.teaHeroBoday = true
                this.vm.data.teaHeroTalk = true
                this.vm.data.teaHeroState = true
                this.vm.data.answerselectTitleTip = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2126"].NameLan)
                heroProp:Play("UI_HeroProup_01", 0, 0)
this.vm.behaviour:UpdateTopBar("talkprop", this.OnBack)
                this.vm.data.resultShowTitle = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2125"].NameLan)
                AnmiatorRoot:Play("UI_TeaTastSipPanel_HeroProup_01")
                AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/curtain_down.mp3")

                this.TestTalkResult(true)

                this.NovelOptioniewData(DataMgr.Player.hightea.Topics)
            end
        end
    end


    this.ShowSelectHero = function(characterId)
        local characterData = DataMgr.Player.characters[characterId]
        local skinId=HeroManager.GetCharacterSkin(characterId);
        this.vm.data.showSmallHead =    LuaMgr.GetTexture(heroIconPath .. characterId .. "/Avatar/" ..skinId..".png")
        this.vm.data.msgHeroName = LuaMgr.GetLangText(ConfigMgr.Config.characterTable[characterId].namelan)
        this.vm.data.donotHaveCharacter = characterData == nil
    end

    this.TeaResultClose= function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.RemoveTeaCharacter)
        this.BeDefaultState()
        this.vm.behaviour:UpdateTopBar(FoundationMgr.TeaRoom, this.OnBack)
        if #DataMgr.Player.hightea.Characters ~= 0 then
            FoundationCharacterMgr.CreatQSpine(false)
        end
    end

    this.UpdateNextFrame= function()
        LuaMgr.NextFrame(function()
            this.BeDefaultState()
        end)
    end

    this.SelectTeaResult = function(args)
        local item=args[0];
        if item==nil then
            return;
        end

        this.vm.data.teaEnterOpen = false
LuaMgr.HidePanel(UIName.TeaTastTaskPanel)
        LuaMgr.ShowLuaPanel(UIName.TeaBeforSelectPanel,item);
    end

    this.FinalTopic = function(states, fun)
        this.vm.data.showTalkMessage = true
        this.vm.data.teaTalkContent = false
        this.vm.data.teaHeroStateUp=false;

        local characterId= DataMgr.Player.hightea.ChoseCharacter;
        local DrinkItem=nil;

        for key, value in pairs(ConfigMgr.Config.highteaCharacterMap) do
            if value.ID == characterId then
                DrinkItem = value
                break;
            end
        end

        if DrinkItem==nil then
            return;
        end

        local Message = ""
        if states then
            Message = HeroManager.CheckCharacterLine(characterId,"TeaVictoryLine",characterId.."001")
        else
            Message = HeroManager.CheckCharacterLine(characterId,"TeaLoseLine",characterId.."001")
        end
        
        this.SetTalkMessage(Message)
        
        local function Sides()
            if states then
                CloseChatItem = nil
                FoundationCharacterMgr.SayingPlayVoice(true, characterId, "teaVictoryLine")
            else
                FoundationCharacterMgr.SayingPlayVoice(true, characterId, "teaLoseLine")
                CloseChatItem = function()
                    if fun ~= nil then
                        fun()
                    end
                end
            end

            this.closeTalk = true
            FunctionGroup.funs = nil
        end
        FunctionGroup.funs = Sides
    end

this.FirstTalkClick = function()

        local answerRight=DataMgr.Player.hightea.AnswerRight;

        if answerRight~=nil and (#answerRight+1)==3 then
            LuaMgr.ShowLuaPanel(UIName.TeaFrequencyPanel,2);
        end
        
        this.NovelOptioniewData(DataMgr.Player.hightea.Topics)
        this.TestTalkResult(true)
        this.vm.data.showTalkMessage = false
        this.vm.data.teaTalkContent = true
        this.vm.data.teaHeroStateUp = false
        this.vm.data.teaHeroState = true
    end

    this.OnBack = function()
        if LuaMgr.IsPanelOpen(UIName.TeaMainPanel) or LuaMgr.IsPanelOpen(UIName.TeaBeforSelectPanel) then
            return
        end
        if DataMgr.Player.hightea.Stage > 1 then
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2114"].NameLan)
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, tipStr, function() this.CancleTea() end, nil)
elseif DataMgr.Player.hightea.Stage ==0 and this.vm.data.teaHearoPorup and not LuaMgr.IsPanelOpen(UIName.TeaTastResultPanel) then
this.ClickCloseTalk()
        else
            FoundationMgr.Enter(FoundationMgr.Outside)
            this.BeDefaultState()
        end
    end

    this.CancleTea = function()
        local data = {}
        ApiMgr.Request(
                "hightea/give_up",
                data,
                true,
                function(result)
                    this.vm.behaviour:UpdateTopBar(FoundationMgr.TeaRoom, this.OnBack)
                    this.BeDefaultState()
                    LuaMgr.InvokeUIEventListeners(UIEventConst.RemoveTeaCharacter)
                    FoundationCharacterMgr.CreatQSpine(false)
                end,
                nil,
                true
        )
    end

    this.NetSelectHeros = function()
        local data = {}
        data.Character = RemerSelectHero
        ApiMgr.Request(
"hightea/choose_character",
                data,
                true,
                function(result)

                    
                    this.vm.data.heroMaskShow = true
                    this.vm.data.teaHeroSelectShow = false
                    this.vm.data.teaHeroTalk = false
                    this.vm.data.teaEnterOpen = false
LuaMgr.HidePanel(UIName.TeaTastTaskPanel)
                    this.vm.data.teaHearoPorup = true
                    this.vm.data.answerselectTitleTip = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2126"].NameLan)
                    this.vm.data.teaTalkRank = false
this.vm.data.answerInterestConstant=false;
                    heroProp:Play("UI_HeroProup_01", 0, 0)
                    LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationTeaRoomTeaMain, true, nil);
                    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/curtain_down.mp3")
                    this.vm.behaviour:UpdateTopBar("talkprop", this.OnBack)
                    this.vm.data.resultShowTitle = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2125"].NameLan)
                    this.SetCharacterSpine()
                    local re = json.decode(result)
                    local interested = re.result.Interesting
                    if interested then
                        this.vm.data.showTalkMessage = true
                        this.SetTalkMessage(LuaMgr.GetLangText(re.result.Comment))
                        FunctionGroup = {}
                        FunctionGroup.funs = function()
                            CloseChatItem = this.FirstTalkClick
                        end
                    else
                        this.FirstTalkClick()
                    end
                    

                    this.clearCharacter()
                    this.ShowSelectHero(re.data.hightea.ChoseCharacter)
                    LuaMgr.InvokeUIEventListeners(UIEventConst.TeaFrequencyPanelClose)
                end,
                nil,
                true
        )
    end


    this.TeaFrequencyPanelClose=function()
        this.vm.data.teaHeroTalk = true;
    end


    this.clearCharacter = function()
        local building = FoundationBuildingMgr.GetBuildingByType(3);
        if (building ~= nil and building.config ~= nil) then
            FoundationCharacterMgr.RemoveBuildingCharacters(building.id);
        end
    end

    this.NetLastTalkItem = function(tab)
        local data = {}
        data.TopicIdx = tab.c_index
        ApiMgr.Request(
                "hightea/choose_topic",
                data,
                true,
                function(result)
                    local re = json.decode(result)

                    if re.result.Interesting then
                        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_correct.mp3")
                    else
                        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_wrong.mp3")
                    end

                    
                    local interesting= tab.AskValue.Trend ==1;

                    this.vm.data.teaHeroStateUp = true
                    this.vm.data.interestTopic = interesting
                    this.vm.data.boringTopic = not interesting

                    local textStr = tab.currentTopicAnswer
                    if string.match(textStr, "player") then
                        textStr = string.gsub(textStr, "player", DataMgr.Player.name);
                    end
                    this.vm.data.feedbackText = textStr
                    this.vm.data.boringImage = tab.AskValue.Trend==2;
                    
                    this.vm.data.answerBoringConstant = not re.result.Interesting

                    this.TestTalkResult(false)
                    
                    if interesting then

                        this.vm.data.answerInterestConstant=true
                        this.vm.data.answerInterestAnimator = false
                        LuaMgr.NextFrame(function()
                            this.vm.data.answerInterestAnimator = true
                        end)
                        
                        if DataMgr.Player.hightea.Stage <= 0 then

                            local function Sides()
                                CloseChatItem = function()
                                    this.vm.data.answerInterestConstant = false
                                    this.vm.data.answerBoringConstant = false
                                    this.vm.data.showTalkMessage = false
                                    this.vm.data.teaTalkContent = true

                                    this.FinalTopic(true, nil)
                                end
                            end
                            FunctionGroup.funs = Sides

                        else

                            FunctionGroup = {}
                            FunctionGroup.funs = function()
                                CloseChatItem = this.FirstTalkClick
                            end

                        end

                    else
                        this.vm.data.answerInterestConstant=false
                        
                        if DataMgr.Player.hightea.Stage <= 0 then

                            local NeedFun = function()
                                this.vm.data.showTalkMessage = false
                                this.vm.data.teaTalkContent = false
this.vm.data.teaHeroTalk=false;
                                LuaMgr.ShowLuaPanel(UIName.TeaTastResultPanel,InterestReward)
                            end

                            local function Sides()
                                CloseChatItem = function()
                                    this.vm.data.answerInterestConstant = false
                                    this.vm.data.answerBoringConstant = false
                                    this.vm.data.teaHeroStateUp = false

                                    this.FinalTopic(false, NeedFun)
                                end
                            end

                            FunctionGroup.funs = Sides

                        else

                            FunctionGroup = {}
                            FunctionGroup.funs = function()
                                CloseChatItem = this.FirstTalkClick
                            end

                        end
                    end

                    if type(re.result.Rewards) == "table" then
                        if re.result.Rewards.Items ~= nil then
                            InterestReward = re.result.Rewards.Items
                        end
                    end
                end ,
                function(failCode)
                    print("EnterDungeonError,ErrorCode:", failCode)
                end,
                true
        )
    end

    this.TestTalkResult = function(showCurrr)

        local answerRight=DataMgr.Player.hightea.AnswerRight;

        local stateItemNum= #this.vm.data.HeroStateShow;
        for i = 1, stateItemNum do

            local showEffect=false;
            local stateItem= this.vm.data.HeroStateShow[i];
            stateItem.UI_Lock_Shine=false;
            if answerRight~=nil and  #answerRight>0 then
                if i<=#answerRight then
if i==3 and #answerRight==4 then
                        stateItem.state=answerRight[4] and TalkStateEmm.talkSuc or TalkStateEmm.talkdef;

                        showEffect= stateItem.state== TalkStateEmm.talkSuc

                    else
                        stateItem.state=answerRight[i] and TalkStateEmm.talkSuc or TalkStateEmm.talkdef;

                        showEffect=i==#answerRight and stateItem.state== TalkStateEmm.talkSuc
                    end
                else
                    stateItem.state = (#answerRight + 1 == i) and TalkStateEmm.current or TalkStateEmm.untalk;
                end
            else
                stateItem.state = (#answerRight + 1 == i) and TalkStateEmm.current or TalkStateEmm.untalk;
            end

            if showCurrr then
                stateItem.goCurrent =  (#answerRight + 1 < i)
            end

            if stateItem.state == TalkStateEmm.untalk then
                stateItem.goLock=true;
                stateItem.goUpLock=false;
                stateItem.UI_Lock_Shine=false;
            elseif stateItem.state == TalkStateEmm.current then
                stateItem.goLock=true;
                stateItem.goUpLock=false;
                stateItem.UI_Lock_Shine=false;
            elseif stateItem.state == TalkStateEmm.talkSuc then
                stateItem.goLock=false;
                stateItem.goUpLock=true;

                if not showCurrr and showEffect then
                    stateItem.UI_Lock_Shine=true;
                else
                    stateItem.UI_Lock_Shine=false;
                end

            elseif stateItem.state == TalkStateEmm.talkdef then
                stateItem.goLock=true;
                stateItem.goUpLock=false;
                stateItem.UI_Lock_Shine=false;
            else
                stateItem.UI_Lock_Shine=false;
            end
        end

    end

this.NovelOptioniewData = function(TopicIDtab)
        local tempList = {}
        local _value=TopicIDtab[#TopicIDtab];
        local index=0;
        for _key2,_value2  in pairs(_value) do
            for _key3, _value3 in pairs(ConfigMgr.Config.playerAskMap) do
                if _value2 == _value3.ID then

                    local random=math.random(0, 10);
                    local addHead=((random%2)>0) and  true or false;

                    local Novelitem = {
                        OptionText = LuaMgr.GetLangText(_value3.TopicContentLan),
                        currentTopicAnswer = LuaMgr.GetLangText(_value3.TopicRespLan),
                        TopicID = _value3.ID,
                        AskValue = _value3,
                        c_index=index,
                        interesting = DataMgr.Player.HighteaBestTopics ~= nil and DataMgr.Player.HighteaBestTopics[_value3.ID] ~= nil
                    }

                    local num=#tempList

                    if num <=0 then
                        table.insert(tempList, Novelitem)
                    else
                        if addHead then
                            table.insert(tempList, 1,Novelitem)
                        else
                            table.insert(tempList, 2,Novelitem)
                        end

                    end

                    index=index+1;

                end
            end
        end

        this.vm.data.NovelList = tempList
end

this.SetCharacterSpine = function()
        spineUICharacter = this.vm.behaviour.transform:Find("root/HeroProup/AskAndTalk/HeroGroup/Body/SpineBody"):GetComponent("UISpineCharacter")
        local characterId = DataMgr.Player.hightea.ChoseCharacter
        local skinId=HeroManager.GetCharacterSkin(characterId);
        local path = CS.Laigu.ViewModel.Hero.HeroManager.SetCharacterDrawing(spineUICharacter, characterId, skinId)
        if (path ~= "") then
            this.vm.data.spineheroPath = path
        end
        this.vm.data.heroTexture =    LuaMgr.GetTexture(heroIconPath .. characterId .. "/Cards/" .. skinId .. ".png")
        this.vm.data.teaHeroBoday = true
        AnmiatorRoot:Play("UI_TeaTastSipPanel_HeroProup_01")
end

this.SetTalkMessage = function(Content, talkParam)
    local textStr = Content == nil and LuaMgr.GetLangText("TeaTastSipViewModel_1") or Content
    if string.match(textStr, "player") then
        textStr = string.gsub(textStr, "player", DataMgr.Player.name);
    end
    this.msgText = textStr
    this.msgIndex = 0
    LuaMgr.RemoveTimer(TimerConst.CharacterLinesShow)
    LuaMgr.RemoveTimer(TimerConst.CharacterLinesClose)
    LuaMgr.AddTimer(TimerConst.CharacterLinesShow, function() this.SetMsgText(talkParam) end, 0.035, 72000, true)
end

this.CloseTalkMessage = function(Content)
        if this.closeTalk then
            return
        end
        this.vm.data.msgContentText = this.msgText
        LuaMgr.RemoveTimer(TimerConst.CharacterLinesShow)
        LuaMgr.AddTimer(TimerConst.CharacterLinesClose, this.ClearTalkMessage, 0.02, 72000, false)
end

this.SetMsgText = function(talkParam)
        local _, Length2 = string.gsub(this.msgText, "[^\128-\193]", "")
        if this.msgIndex < Length2 then
            this.msgIndex = this.msgIndex + 1
            local textStr = LuaMgr.Substring(this.msgText, this.msgIndex)
            if string.match(textStr, "player") then
                textStr = string.gsub(textStr, "player", DataMgr.Player.name);
            end
            if talkParam ~= nil then
                this.vm.data.feedbackText = textStr
            else
                this.vm.data.msgContentText = textStr
            end
        else
            LuaMgr.RemoveTimer(TimerConst.CharacterLinesShow)
            LuaMgr.AddTimer(TimerConst.CharacterLinesClose, this.ClearTalkMessage, 0.02, 72000, false)
        end
end

this.ClearTalkMessage = function()
        LuaMgr.RemoveTimer(TimerConst.CharacterLinesShow)
        LuaMgr.RemoveTimer(TimerConst.CharacterLinesClose)
        if this.closeTalk then
            return
        end
        if FunctionGroup.funs ~= nil then
            FunctionGroup.funs()
        end
end


this.RefushTeaTimes = function()
        local id = FoundationMgr.GetCurrBuildingId();
        local building = FoundationBuildingMgr.GetBuildingById(tostring(id));
        if (building == nil) then
            return
        end

        local unlockFourLv=ConfigMgr.Config.constants.FourInLineUnlock;
        local unlockTurnLv=ConfigMgr.Config.constants.GameBoardUnlock;
        local unlock2048Lv=ConfigMgr.Config.constants.NumberMergeUnlock;
        local unlockPuzzleLv=ConfigMgr.Config.constants.PuzzleUnlock;
        local unlockMusicLv=ConfigMgr.Config.constants.TH_MusicUnlock;        
        this.vm.data.goConnectFourLock=building.config.Level<unlockFourLv;
        this.vm.data.goConnectTurnLock=building.config.Level<unlockTurnLv;
        this.vm.data.goConnect2048Lock=building.config.Level<unlock2048Lv;
        this.vm.data.goConnectPuzzleLock=building.config.Level<unlockPuzzleLv;
        this.vm.data.goConnectMusicLock=building.config.Level<unlockMusicLv;     
        this.vm.data.goConnectBalatroLock = ActivityMgr.ActivityRuning(ActivityKey.BalatroBrand) == false
        this.vm.data.goConnectFourRedPointGroup=building.config.Level>=unlockFourLv;
        this.vm.data.goConnectTurnRedPointGroup=building.config.Level>=unlockTurnLv;
        this.vm.data.goConnect2048RedPointGroup=building.config.Level>=unlock2048Lv;
        this.vm.data.goConnectPuzzleRedPointGroup=building.config.Level>=unlockPuzzleLv;
        this.vm.data.goConnectMusicRedPointGroup=building.config.Level>=unlockMusicLv;
        
        local HighteaTimesDaily= ConfigMgr.Config.constants.HighteaTimesDaily;
        local HighteaTimesDailyCount=#HighteaTimesDaily;
        local highteaTimes = DataMgr.Player.dailyCount.HighteaTimes ~= nil and DataMgr.Player.dailyCount.HighteaTimes or 0
        
        local lv= building.config.Level
        if lv<=0 then
            lv =1;
        end

        if lv>=HighteaTimesDailyCount then
            lv=HighteaTimesDailyCount;
        end

        local Num=0;
        if HighteaTimesDailyCount>0 then
             Num=HighteaTimesDaily[lv];
        end
        
        this.vm.data.drinkTeaTimes = highteaTimes .. "/" .. Num
        this.vm.data.dringTimesLimit = highteaTimes >= Num
        this.vm.data.dringTimesNoLimit = highteaTimes < Num
        this.vm.data.leftDrinkTeaTimes = Num - highteaTimes
end

this.Show2048Award=function()
    if this.vm.data.goConnect2048Lock then
        this.vm.data.go2048Good=false;
        return
    end
    this.openModeMap={};
    local config=ConfigMgr.Config.NumberMainMap;
    local nowTime = LuaMgr.Timestamp();
    for key, value in pairs(config) do
       if value.OpenDate<=nowTime and value.CloseDate>=nowTime then
        this.openModeMap[value.ID]=true;
       end 
    end
    local config2=ConfigMgr.Config.NumberRewardMap;
    local itemCount=0;
    local itemId="";
    local itemRare="";

    for key, value in pairs(config2) do
if DataMgr.Player.numberMergeV2[value.Group].reward==nil or DataMgr.Player.numberMergeV2[value.Group].reward[value.ID]==nil then
            if value.RewardShow==1 then
                itemId=value.Reward[1].id;
                itemCount=itemCount+value.Reward[1].count;
            end
        end 
     end
    
    if itemCount~=0 then
        this.vm.data.go2048Good=true;
        itemRare = ConfigMgr.Config.itemMap[itemId].rare;
        local _goods= {
            id = itemId,
            count = LuaMgr.NumFormat( itemCount),
            isCount = true,
            rare = ActivityMgr.GetRareSprite(itemRare),
            icon = ActivityMgr.GetItemTexture( itemId),
            scale = Vector3.one,
            sizeDelta=Vector2(128,128),
            isClick = true}
        
        this.vm.data.game2048Good =_goods;
    else
        this.vm.data.go2048Good=false;
    end
end

this.ShowTurnTableAward=function()
    if this.vm.data.goConnectTurnLock then
        this.vm.data.goTurnTableGood=false;
        return
    end    
    local levelData = ConfigMgr.Config.GameBoardMap;
    local itemCount=0;
    local itemId="";
    local itemRare="";
    local board = DataMgr.Player.board;
    for key, value in pairs(levelData) do
        if value.RewardShow~=nil and value.RewardShow>0 then
            if IsNull(board.finishMainStageId) or ((not board.finishMainStageId[value.Level]) and value.VicReward~=nil and #value.VicReward>0) then
                itemRare = ConfigMgr.Config.itemMap[value.VicReward[1].id].rare;
                itemId=value.VicReward[1].id;
                itemCount=itemCount+value.VicReward[1].count;
            end
            
        end
    end
    if itemCount~=0 then
        this.vm.data.goTurnTableGood=true;
                
        local _goods= {
            id = itemId,
            count = LuaMgr.NumFormat( itemCount),
            isCount = true,
            rare = ActivityMgr.GetRareSprite(itemRare),
            icon = ActivityMgr.GetItemTexture( itemId),
            scale = Vector3.one,
            sizeDelta=Vector2(128,128),
            isClick = true}
        
        this.vm.data.turnTableGood =_goods;
    else
        this.vm.data.goTurnTableGood=false;
    end
end

this.ShowConnectFourRankAward=function()
    
    if this.vm.data.goConnectFourLock then
        this.vm.data.goFourGood=false;
        return
    end
    
    local itemConfig=ConfigMgr.Config.constants.FourInLineFirstVicNormal;
    local itemRare = ConfigMgr.Config.itemMap[itemConfig.id].rare

    if itemRare==nil then
        return
    end
    
    local firstData=  DataMgr.Player.fourInLine.first;

    if firstData~=nil then
        for i, v in pairs(firstData) do
if i== tostring(1) then
                if v then
                    this.vm.data.goFourGood=false;
                    return
                end
            end
        end
    end
    
    this.vm.data.goFourGood=true;

    local _goods= {
        id = itemConfig.id,
        count = LuaMgr.NumFormat(itemConfig.count),
        isCount = true,
        rare = ActivityMgr.GetRareSprite(itemRare),
        icon = ActivityMgr.GetItemTexture(itemConfig.id),
        scale = Vector3.one,
        sizeDelta=Vector2(128,128),
        isClick = true}

    this.vm.data.fourGood =_goods;
    
end

this.PuzzleAwards=function()
    if this.vm.data.goConnectPuzzleLock then
        this.vm.data.goPuzzleGood=false;
        this.vm.data.goPuzzleTime=false;
        return
    end
    if not IsNull(ConfigMgr.Config.constants.PuzzleEndTime) and 
            ConfigMgr.Config.constants.PuzzleEndTime>0 
            and LuaMgr.Timestamp()<ConfigMgr.Config.constants.PuzzleEndTime then
        this.vm.data.goPuzzleTime=true;
    else
        this.vm.data.goPuzzleTime=false;
    end
    
    local award=nil;
    for i,v in pairs(ConfigMgr.Config.PuzzleMap) do
        if v.Show==1 and DataMgr.Player.puzzleStatus[v.ID]==nil then
            if award==nil then
                award={id=v.Reward[1].id,count=v.Reward[1].count}
            else
                award.count=award.count+v.Reward[1].count;
            end
        end
    end
    if award==nil then
        this.vm.data.goPuzzleGood=false;
        return 
    end;
    this.vm.data.goPuzzleGood=true;
    local itemRare = ConfigMgr.Config.itemMap[award.id].rare
    local _goods= {
        id = award.id,
        count = LuaMgr.NumFormat(award.count),
        isCount = true,
        rare = ActivityMgr.GetRareSprite(itemRare),
        icon = ActivityMgr.GetItemTexture(award.id),
        scale = Vector3.one,
        sizeDelta=Vector2(128,128),
        isClick = true}

    this.vm.data.puzzleGood =_goods;
end

this.ShowMusicAward=function()
    if this.vm.data.goConnectMusicLock then
        this.vm.data.goMusicTableGood=false;
        return
    end    
    local levelData = ConfigMgr.Config.GameBoardMap;
    local itemCount=0;
    local itemId="";
    local itemRare="";
    local board = DataMgr.Player.board;
    for key, value in pairs(levelData) do
        if value.RewardShow~=nil and value.RewardShow>0 then
            if IsNull(board.finishMainStageId) or ((not board.finishMainStageId[value.Level]) and value.VicReward~=nil and #value.VicReward>0) then
                itemRare = ConfigMgr.Config.itemMap[value.VicReward[1].id].rare;
                itemId=value.VicReward[1].id;
                itemCount=itemCount+value.VicReward[1].count;
            end
            
        end
    end
    if itemCount~=0 then
        this.vm.data.goMusicTableGood=true;
                
        local _goods= {
            id = itemId,
            count = LuaMgr.NumFormat( itemCount),
            isCount = true,
            rare = ActivityMgr.GetRareSprite(itemRare),
            icon = ActivityMgr.GetItemTexture( itemId),
            scale = Vector3.one,
            sizeDelta=Vector2(128,128),
            isClick = true}
        
        this.vm.data.musicTableGood =_goods;
    else
        this.vm.data.goMusicTableGood=false;
    end
end

this.BeDefaultState = function()

        if this.vm.data.teaHearoPorup then
            heroProp:Play("UI_HeroProup_02", 0, 0)
        end

        for key, value in pairs(defaultTable) do
            this.vm.data[key] = value
        end
        if LuaMgr.IsPanelOpen(UIName.TeaTastSipViewModel) and (not LuaMgr.IsPanelOpen(UIName.TeaTastTaskPanel)) then
LuaMgr.ShowLuaPanel(UIName.TeaTastTaskPanel)
        end

        coroutine_runner.start(
                function()
                    coroutine_runner.wait(0.5)
                    this.vm.data.teaHearoPorup = false
                    this.vm.data.heroMaskShow = false
                    this.vm.data.teaHeroState =false;
                end
        )

        LuaMgr.RemoveTimer(TimerConst.TeaLastTime)
        
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationTeaRoomTeaMain, false, nil);
        this.vm.data.msgMakesureSppedUp = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2119"].NameLan)
        spineUICharacter = nil
        CloseChatItem = nil
        RemerSelectHero = nil
        this.closeTalk = false
        InterestReward = nil
        this.RefushTeaTimes() 
end

TeaTastSipViewModel.ClickOptionCommand=this.ClickOptionCommand;
return vm(
        {
            data = data,
            command = command,
            hook = hook
        }
)