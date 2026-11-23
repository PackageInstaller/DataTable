



local this = {
    vm = nil,

    starthandAiSteo = false,
    handAiStep = false,

    GridData = {},
    myStep = {},
    aiStep = {},
reqSteps={},
    reqBoard={},
    myFirstStep = true,
    aiFirstStep = false,

    mySelectChessType = 0,
    aiSelectChessType = 1,

    myServiceData = {},

    aiServiceData = {},
    changes = 1,
    QSpineChatar = nil,
    stopChess = false,
    topToBottomAnim = nil,
    weekdayTime = nil,
    rankData = {},

    aiBackPlayeInfo = nil,

    aiInfoBack = nil,

    chessStepEmme = {
        NextStepVictory = "1",
        PlayerStopAiWin = "3",
        AiStopPlayerWin = "2",
        Stalemate = "4",
        SetHalfOfTotolChess = "5",
        ChessGameTimeOut = "6",
        PlayerVictory = "7",
        PlayFail = "8",
        MoreThanThreeRow = "9",
        FirstStep = "10"
    },
    ChessStateData = {},
    currentStateSow = nil,
    aiCortinue = nil,
    playerDoFirstStep = false,
    characterTalkCortinue = nil,
    chessHitCortinue = nil,
    chessTrailCortinue = nil,
    startTemps = 0,
    clickTemps = 0,
    startTime = 0,
    startFirstStepState=1,
}
local tweener
local AnmiatorRoot;
local AnmiatorDefault;

local data = {
    goTitle = false,
    goGetBtn = false,
    goNoReward = false,
    goGmBtn = false,
    goods = { id = "0", count = "0", sizeDelta = Vector2.zero, isCount = true, rare = DefaultSprite, icon = DefaultTexture, scale = Vector3.zero, isClick = true },
    HistoryTotol = "",
    HistoryInverted = "",
    HistoryLevel = "",
    TimeSort = true,
    LevelSort = false,
    UnTimeSort = false,
    UnLevelSort = true,
    rowUp = true,
    rowDown = false,
    chessMian = false,
    beforeChess = true,
    hardSelected = false,
    hardUnselected = true,
    normalSelected = true,
    normalUnSelected = false,
    whiteFirst = false,
    blackFirst = true,
    randomFirst = false,
    showResult = false,
    characterTalk = "",
    showCharacterTalk = false,
isTest = false,
openAiToggle = false,
    CangetReward = false,
    AlreadyReward = false,

    titleTextShow = "",
    ChessItemList = {
        {
            black = false,
            white = false,
            empty = true,
            contentPos = Vector2.zero,
            line = 0,
            row = 0,
            Name = "",
            ui_Chess_trail = false,
            ui_Chess_hit = false,
            ui_Chess_select = false,
        }
    },
}
local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.Back()
        end
    },
    clickChessItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (this.stopChess) then
                return
            end
            if LuaMgr.Timestamp() - this.clickTemps < 2 then
                return
            else
                this.clickTemps = LuaMgr.Timestamp()
            end

            local lua_index = param + 1;
            local row = this.vm.data.ChessItemList[lua_index].row
            if this.vm.data.ChessItemList[lua_index].empty then
                local rowtab = this.GridData[row]
                local index = this.getRowNum(rowtab)
                if index == this.vm.data.ChessItemList[lua_index].line then
                    if this.starthandAiSteo then
                        if this.handAiStep then
                            this.handAiStep = false
                            this.selectChessItem(lua_index, false)
this.ShowPreview(true);
                        else
                            this.handAiStep = true
                            this.selectChessItem(lua_index, true)
this.ShowPreview(true);
                        end
                    else
                        this.selectChessItem(lua_index, true)
                    end
                end
            end
        end
    },
    startChessMain = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if #this.vm.data.ChessItemList ~= 42 then
                this.InitChessList()
            end

            AnmiatorRoot:Rebind();
            this.vm.data.chessMian = true
            this.vm.data.beforeChess = false





            AnmiatorRoot:Play("ani_ConnectFourPanel_002")
            this.reqSteps={}
            this.reqBoard={}
            this.ShowPreview(false);

            if this.aiFirstStep and not this.starthandAiSteo then
                if this.aiCortinue ~= nil then
                    coroutine_runner.stop(this.aiCortinue)
                end

                this.clickTemps = LuaMgr.Timestamp()
                this.aiCortinue = coroutine_runner.start(function()
                    coroutine_runner.wait(1)
                    this.clickTemps = LuaMgr.Timestamp()
                    this.getAiRowStep()
                end)
            else
                this.chessTrailCortinue = coroutine_runner.start(function()
                    coroutine_runner.wait(1)
                    this.ShowPreview(true);
                end)
            end
AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/fourInLine_chessboard.mp3");
            this.vm.behaviour:UpdateTopBar("chessMain", this.CancleCurrentFour)
            this.startTime = LuaMgr.Timestamp();
        end
    },
    seletMeStartChess = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.vm.data.blackFirst then
                return
            end
            this.vm.data.whiteFirst = false
            this.vm.data.blackFirst = true
            this.vm.data.randomFirst = false
            this.myFirstStep = true
            this.aiFirstStep = false
this.handAiStep = false
            this.startFirstStepState=1;
        end
    },
    seletAiStartChess = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.vm.data.whiteFirst then
                return
            end
            this.vm.data.whiteFirst = true
            this.vm.data.blackFirst = false
            this.vm.data.randomFirst = false
            this.myFirstStep = false
            this.aiFirstStep = true
this.handAiStep = true
            this.startFirstStepState=2;
        end
    },
    seletRandomStartChess = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local code = math.random(1, 2)
            this.myFirstStep = code == 1
            this.aiFirstStep = code == 2
            this.vm.data.whiteFirst = false
            this.vm.data.blackFirst = false
            this.vm.data.randomFirst = true
this.handAiStep = code == 2
            this.startFirstStepState=3;
        end
    },
    seletNormalAi = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.vm.data.normalSelected then
                return
            end
            this.setNormalAi()
        end
    },
    seletHardAi = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.vm.data.hardSelected then
                return
            end
            this.setHardAi()
        end
    },

    showRewardPanel = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local callbackfun = function(get)
                this.getNetRewardIConSatate(get)
            end
            LuaMgr.ShowLuaPanel(UIName.ConnectFourRewardViewModel, callbackfun)
        end
    },
    closeChessMain = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.closeMainChess()
        end
    },

    showNetRank = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.NetRankData(
                function()
                    LuaMgr.ShowLuaPanel(UIName.ConnectFourRankViewModel, this.rankData)
                end)
        end
    },
    RefushRankData = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.RefushRankData()
        end
    },
    GetFirstRankAward = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.ReqGetFirstReward()
        end
    },

    OnGmClick = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.NetFinishedConnect(function()
                this.stopChess = true
                this.vm.data.showResult = true
                AnmiatorDefault.gameObject:SetActive(true);
                AnmiatorDefault:Play("ani_Default_Victory")
                this.ShowPreview(false);
                this.ShowFirstAwardState();
            end)
        end
    },
    GMAIToggle = {
        type = XLuaCommandType.Bool,
        execute = function(vm, isOn, param)
            this.starthandAiSteo = not isOn;
            this.vm.data.openAiToggle = isOn;
if isOn and this.handAiStep then
                this.getAiRowStep()
                this.handAiStep = false;
            end
        end
    },

}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        AnmiatorRoot = this.vm.behaviour.transform:Find("root"):GetComponent("Animator")
        AnmiatorDefault = this.vm.behaviour.transform:Find("root/Middle/ConnectFourBg/Group/ChessMain/Default")
            :GetComponent("Animator")
        AnmiatorDefault.gameObject:SetActive(false);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.InitChessGrdeData()
            this.vm.behaviour:UpdateTopBar("FoundationTeaRoom", this.OnBack)
this.vm.data.isTest = LuaMgr.IsDebug();
            this.InitQuestionAnswer()
            this.getMondayTimestep()
            this.NetRankData()
            this.InitChessStateFun()
            this.getRewardIConSatate()
            this.ShowFourInLineFirstVic()
            this.ShowFirstAwardState();
            this.ShowNormalAi();
            this.starthandAiSteo = ComData.ConnectFourAiClose
            this.vm.data.goGmBtn = LuaMgr.IsDebug();
            this.vm.data.openAiToggle = not this.starthandAiSteo
            AnmiatorRoot:Play("ani_ConnectFourPanel_001")

            this.RefreshFirstJoinRed(3);
            HeroRedDataHelper.RefreshMiniGameRed();
        end
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
            this.GridData = {}
            this.ChessStateData = {}
            this.spineCharacter:Clear();
        end
    end,
    before_destroy = function()
        this.spineCharacter = nil;
    end
}

this.RefreshFirstJoinRed=function (type)
    local config=ConfigMgr.Config.constants["GamePoint"]
    for index, value in ipairs(config) do
        if value[1]==tostring(type) and value[2]~="nil" then
PlayerPrefs.SetInt(DataMgr.Player.uid .. "#" .. value[1] .. "#" ..value[2],1);
            break;
        end
    end
end

this.ShowNormalAi = function()
    if (not this.vm.data.normalSelected) and (not this.vm.data.hardSelected) then
        this.vm.data.whiteFirst = false
        this.vm.data.blackFirst = true
        this.vm.data.randomFirst = false
        this.setNormalAi()
    else
        print("normal  is set")
    end
end

this.ShowFirstAwardState = function()
    local firstData = DataMgr.Player.fourInLine.first;

    if firstData ~= nil then
        for i, v in pairs(firstData) do


            if i == tostring(1) then
                if not v then
                    this.vm.data.goTitle = false;
                    this.vm.data.goNoReward = true;
                    this.vm.data.goGetBtn = true;
                else
                    this.vm.data.goTitle = false;
                    this.vm.data.goNoReward = false;
                    this.vm.data.goGetBtn = false;
                end
                return
            end
        end
    end

    this.vm.data.goTitle = true;
    this.vm.data.goNoReward = true;
    this.vm.data.goGetBtn = false;
this.handAiStep = false;
end

this.ShowFourInLineFirstVic = function()
    local itemConfig = ConfigMgr.Config.constants.FourInLineFirstVicNormal;
    local itemRare = ConfigMgr.Config.itemMap[itemConfig.id].rare

    if itemRare == nil then
        return
    end

    local _goods = {
        id = itemConfig.id,
        count = LuaMgr.NumFormat(itemConfig.count),
        isCount = true,
        rare = ActivityMgr.GetRareSprite(itemRare),
        icon = ActivityMgr.GetItemTexture(itemConfig.id),
        scale = Vector3.one,
        sizeDelta = Vector2(128, 128),
        isClick = true
    }

    this.vm.data.goods = _goods;
end


this.getRewardIConSatate = function()
    local getState = TeaTastSipHelper.TeaTastSipHelperTabInit()
    this.vm.data.CangetReward = not getState
    this.vm.data.AlreadyReward = getState
end


this.getNetRewardIConSatate = function(geted)
    this.vm.data.CangetReward = not (geted)
    this.vm.data.AlreadyReward = geted
end


this.InitChessGrdeData = function()
    for i = 1, 7, 1 do
        local lineData = {}
        for j = 1, 6, 1 do
            table.insert(lineData, 0)
        end
        table.insert(this.GridData, lineData)
    end
end
this.InitChessList = function()
    local tempet = {}
    for i = 1, 42, 1 do
        local rowNum = i % 7
        rowNum = rowNum == 0 and 7 or rowNum
        local LinNum = math.ceil(i / 7)
        local chess = {
            playe = false,
            aistep = false,
            black = false,
            white = false,
            empty = true,
            line = LinNum,
            row = rowNum,
            contentPos = Vector2.zero,
            Name = "line :" .. LinNum .. " row :" .. rowNum .. " index :" .. i,
            ui_Chess_trail = false,
            ui_Chess_hit = false,
            ui_Chess_select = false,
        }
        table.insert(tempet, chess)
    end
    this.vm.data.ChessItemList = tempet
end

this.RestChess = function()
    for i = 1, 42, 1 do
        this.vm.data.ChessItemList[i].black = false
        this.vm.data.ChessItemList[i].white = false
        this.vm.data.ChessItemList[i].empty = true
    end
end

this.ShowPreview = function(status)
    local tempet = {}
    for i = 42, 1, -1 do
        local chessItem = this.vm.data.ChessItemList[i];
        chessItem.ui_Chess_select = false;

        if status then
            local row = i % 7;
            if row <= 0 then
                row = 7;
            end

            if (not chessItem.white) and (not chessItem.black) then
                tempet[row] = i;
            end
        else
            chessItem.ui_Chess_select = false;
        end
    end

    if status then
        for i = 1, 7 do
            if tempet[i] ~= nil then
                this.vm.data.ChessItemList[tempet[i]].ui_Chess_select = true;
            end
        end
    end
end


this.closeMainChess = function()
    this.myStep = {}
    this.aiStep = {}
    this.reqSteps={}
    this.reqBoard={}
    this.vm.data.chessMian = false
    this.vm.data.beforeChess = true
    this.stopChess = false
    AnmiatorDefault.gameObject:SetActive(false);
    this.vm.data.showResult = false
this.handAiStep = false;


    this.playerDoFirstStep = false
    this.ShowNormalAi()
    LuaMgr.RemoveTimer(TimerConst.ConnectFourChess)
    if this.characterTalkCortinue ~= nil then
        coroutine_runner.stop(this.characterTalkCortinue)
    end

    if this.chessHitCortinue ~= nil then
        coroutine_runner.stop(this.chessHitCortinue)
    end

    if this.chessTrailCortinue then
        coroutine_runner.stop(this.chessTrailCortinue)
    end

    if (tweener ~= nil) then
        tweener:Kill()
    end
    this.vm.data.showCharacterTalk = false
    this.vm.behaviour:UpdateTopBar("FoundationTeaRoom", this.OnBack)
    this.ClearChessData()
    this.RestChess()
    this.InitChessState()



end


this.setNormalAi = function()
    this.vm.data.hardSelected = false
    this.vm.data.hardUnselected = true
    this.vm.data.normalSelected = true
    this.vm.data.normalUnSelected = false
end


this.setHardAi = function()
    this.vm.data.hardSelected = true
    this.vm.data.hardUnselected = false
    this.vm.data.normalSelected = false
    this.vm.data.normalUnSelected = true
end


this.ClearChessData = function()
    for i = 1, 7, 1 do
        local lineData = {}
        for j = 1, 6, 1 do
            this.GridData[i][j] = 0
        end
    end
end


this.getRowNum = function(rowtab)
    for index, value in ipairs(rowtab) do
        if value == 0 then
            return index
        end
    end
end


this.getAiRowStep = function()
    local type = this.vm.data.hardSelected and 2 or 1

    local configStep = ConfigMgr.Config.constants.FourInLineDepth[type]
    local rowData = LuaMgr.ConnectFourAiFun(configStep, this.myStep, this.aiStep)
    local playerInfo = rowData[0]
    if playerInfo == 2 then
        this.ChangeChessState(this.chessStepEmme.PlayerStopAiWin)
    end
    local AiStep = rowData[1] + 1
    local AiInfo = rowData[2]
    if AiInfo == 1 then
        this.ChangeChessState(this.chessStepEmme.AiStopPlayerWin)
    elseif AiInfo == 3 then
        this.ChangeChessState(this.chessStepEmme.NextStepVictory)
    end
    local rowtab = this.GridData[AiStep]
    local lineTab = this.getRowNum(rowtab)
    local index = (lineTab - 1) * 7 + AiStep
    this.selectChessItem(index, false)
    this.ShowPreview(true);
end

this.InitQuestionAnswer = function()
    local teadata = DataMgr.Player.hightea.Characters
    local HighteaTimesDaily = ConfigMgr.Config.constants.HighteaTimesDaily;
    local id = FoundationMgr.GetCurrBuildingId();
    local building = FoundationBuildingMgr.GetBuildingById(tostring(id));

    if (building == nil) then
        return
    end





















    this.spineCharacter = this.vm.behaviour.transform:Find("root/Middle/HeroPos/QSpine/Spine/JQ005A011"):GetComponent("UISpineCharacter")
    this.spineCharacter:SetDrawing()
    this.spineCharacter:Play("idle_1", true, nil);
end

this.selectChessItem = function(param, me)
    this.vm.data.ChessItemList[param].empty = false
    local lines = this.vm.data.ChessItemList[param].line
    local rows = this.vm.data.ChessItemList[param].row
    if me then
        this.vm.data.ChessItemList[param].black = true
        table.insert(this.myStep, rows - 1)
        table.insert(this.reqSteps,rows-1);
        this.GridData[rows][lines] = 1
        local funs = function()
            local victory = this.SuccssfulState(1)
            if victory then
                this.NetFinishedConnect(function()
                    this.stopChess = true
                    this.vm.data.showResult = true
                    AnmiatorDefault.gameObject:SetActive(true);
                    AnmiatorDefault:Play("ani_Default_Victory")
                    this.ShowPreview(false);
                    this.ShowFirstAwardState();
                end)

                this.ChangeChessState(this.chessStepEmme.PlayerVictory)
            else
                local MychessItemNum = #this.myStep
                local AiChessIyemNum = #this.aiStep
                if AiChessIyemNum + MychessItemNum == 42 then
                    this.vm.data.showResult = true
                    this.stopChess = true
                    AnmiatorDefault.gameObject:SetActive(true);
                    AnmiatorDefault:Play("ani_Default_stalemate")
                    this.ChangeChessState(this.chessStepEmme.Stalemate)
                    this.ShowPreview(false);
                    this.ShowFirstAwardState();
                else
                    if not this.starthandAiSteo then
                        this.getAiRowStep()
                    end
                end

            end
        end
        this.TopToBottomAnimation(param, lines, funs, me, this.SuccssfulState(1))
    else
        this.vm.data.ChessItemList[param].white = true
        table.insert(this.aiStep, rows - 1)
        table.insert(this.reqSteps,rows-1);
        this.GridData[rows][lines] = -1
        local funs = function()
            local victory = this.SuccssfulState(-1)
            if victory then
                this.stopChess = true
                this.vm.data.showResult = true
                AnmiatorDefault.gameObject:SetActive(true);
                AnmiatorDefault:Play("ani_Default_Fail")
                this.ChangeChessState(this.chessStepEmme.PlayFail)
                this.ShowPreview(false);
                this.ShowFirstAwardState();
                this.BiliLog(0, nil, this.vm.data.hardSelected and "2" or "1");
            else
                local MychessItemNum = #this.myStep
                local AiChessIyemNum = #this.aiStep
                if AiChessIyemNum + MychessItemNum == 42 then
                    this.vm.data.showResult = true
                    this.stopChess = true
                    AnmiatorDefault:Play("ani_Default_stalemate")
                    AnmiatorDefault.gameObject:SetActive(true);
                    this.ChangeChessState(this.chessStepEmme.Stalemate)
                    this.ShowPreview(false);
                    this.ShowFirstAwardState();
                end
            end
        end
        this.TopToBottomAnimation(param, lines, funs, me, this.SuccssfulState(-1))
    end
    local successBoard={};
    for i,v in ipairs(this.vm.data.ChessItemList)  do
        local key=100*(v.line)+(v.row-1);
        local value=v.black and 1 or 0;
        if v.black or v.white then
            successBoard[key]=value;
        end
    end
    if not this.playerDoFirstStep then
        this.playerDoFirstStep = true
        this.ChangeChessState(this.chessStepEmme.FirstStep)
    end
end


this.CheckAiAndPlayerLastTree = function()
    local myStepLeength = #this.myStep
    if this.myStep[myStepLeength] == this.myStep[myStepLeength - 1] == this.myStep[myStepLeength - 2] then
        this.ChangeChessState(this.chessStepEmme.MoreThanThreeRow)
    end
end


this.CancleCurrentFour = function()
    if this.vm.data.showResult then
        this.closeMainChess()
        return
    end
    local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7055"].NameLan)
    LuaMgr.ShowPanel(
        UIName.ConfirmSmallViewModel,
        tipStr,
        function()
            this.BiliLog(-1, nil, this.vm.data.hardSelected and "2" or "1");
            this.closeMainChess()
        end,
        nil
    )
end



this.OnBack = function()
    LuaMgr.Back()
end


this.ReqGetFirstReward = function()
    local data = {


        Type = "1"
    }
    local Url = "fourInLine/getFirstReward"
    ApiMgr.Request(Url, data, true,
        function(result)
            local re = json.decode(result)
            this.ShowFirstAwardState();

            if re.result.Items ~= nil then
                local items = {};
                local reward = re.result.Items
                for i, v in pairs(reward) do
                    local item = { ID = v.id, Count = v.count }
                    table.insert(items, item);
                end

                LuaMgr.ShowItemGetPanel(items);
            end
        end,
        function(failCode)
            print("EnterDungeonError,ErrorCode:", failCode)
        end,
        true
    )
end


this.RefushRankData = function()
    local data = {}
    local Url = "admin/genRank"
    ApiMgr.Request(Url, data, true,
        function(result)
        end,
        function(failCode)
            print("EnterDungeonError,ErrorCode:", failCode)
        end,
        true
    )
end


this.OnAvatarRefresh = function(currentavaratr, currentframe)
    local avatarTexture = nil
    local avatarFrameId = nil
    local avatarData = nil;
    local frameData = nil;
    for i, v in ipairs(ConfigMgr.Config.avatarFrames) do
        if v.id == currentavaratr then
            avatarData = v;
        elseif v.id == currentframe then
            frameData = v;
        end
        if avatarData ~= nil and frameData ~= nil then
            break;
        end
    end
    if avatarData ~= nil then
        local avatarPath = ConfigHelper.GetHeadIconPath(avatarData.img, avatarData.imgId);
        avatarTexture = LuaMgr.GetTexture(avatarPath);
    end
    if frameData ~= nil then
        avatarFrameId = frameData.id;
    end
    return avatarTexture, avatarFrameId
end




this.TopToBottomAnimation = function(param, index, funs, me, victory)
    local pos3
    if index == 6 then
        funs()
        this.startTemps = LuaMgr.Timestamp()
        this.ChessLastTime()
        LuaMgr.NextFrame(this.RefushCharacterState)
        return
    else
        pos3 = Vector2(0, -72 * (6 - index))
        this.vm.data.ChessItemList[param].contentPos = pos3
        pos3 = Vector2(0, -72 * (6 - index))
    end
    local pos1 = Vector2(0, 0)

    if (tweener ~= nil) then
        tweener:Kill()
    end

    this.chessTrailCortinue = coroutine_runner.start(function()
        this.vm.data.ChessItemList[param].ui_Chess_trail = false;
        coroutine_runner.wait(0.1)
        this.vm.data.ChessItemList[param].ui_Chess_trail = true;
    end)
AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/fourInLine_drop.mp3");
    tweener = DOTWeen.To(
        function()
            return pos3
        end,
        function(vector)
            this.vm.data.ChessItemList[param].contentPos = vector
        end,
        pos1,
        0.5
    )
    tweener:SetEase(Ease.InQuart)
    tweener.onComplete = function()
AudioMgr.Singleton:StopVoice()
        funs()
        this.startTemps = LuaMgr.Timestamp()
        this.ChessLastTime()

        local forceCheck = false;
        for index, value in ipairs(this.ChessStateData) do
if value.Id == "4" and value.StepData == 1 then
                forceCheck = true;
                break;
elseif value.Id == "3" and value.StepData == 1 then
                forceCheck = true;
                break;
elseif value.Id == "5" and value.StepData == 1 then
                forceCheck = true;
                break;
elseif value.Id == "10" and value.StepData == 1 then
                forceCheck = true;
                break;
            elseif value.StepData == 1 then
                break;
            end
        end
        if forceCheck then
            LuaMgr.NextFrame(this.RefushCharacterState)

elseif (not me) or victory then
            LuaMgr.NextFrame(this.RefushCharacterState)
        end

        this.chessHitCortinue = coroutine_runner.start(function()
            this.vm.data.ChessItemList[param].ui_Chess_hit = true;
            coroutine_runner.wait(1)
            this.vm.data.ChessItemList[param].ui_Chess_hit = false;
            this.vm.data.ChessItemList[param].ui_Chess_trail = false;
        end)
    end
end



this.SuccssfulState = function(steps)
    local MychessItemNum = #this.myStep
    local AiChessIyemNum = #this.aiStep

    if AiChessIyemNum + MychessItemNum == 21 then
        this.ChangeChessState(this.chessStepEmme.SetHalfOfTotolChess)
    end
    for i = 1, 7, 1 do
        for j = 1, 6, 1 do

            if j + 3 <= 6 then
                if this.GridData[i][j] == steps and this.GridData[i][j + 1] == steps and this.GridData[i][j + 2] == steps and this.GridData[i][j + 3] == steps then
                    return true
                end
            end

            if i + 3 <= 7 then
                if this.GridData[i][j] == steps and this.GridData[i + 1][j] == steps and this.GridData[i + 2][j] == steps and this.GridData[i + 3][j] == steps then
                    return true
                end
            end

            if i <= 4 and j <= 3 then
                if this.GridData[i][j] == steps and this.GridData[i + 1][j + 1] == steps and this.GridData[i + 2][j + 2] == steps and this.GridData[i + 3][j + 3] == steps then
                    return true
                end
            end

            if (i >= 4 and i <= 7) and j <= 3 then
                if this.GridData[i][j] == steps and this.GridData[i - 1][j + 1] == steps and this.GridData[i - 2][j + 2] == steps and this.GridData[i - 3][j + 3] == steps then
                    return true
                end
            end
        end
    end
    return false
end


this.InitChessStateFun = function()
    local actorData = ConfigMgr.Config.FourInLineActMap
    for key, value in pairs(actorData) do
        local data = table.Copy(value)
        data["StepData"] = 0
        table.insert(this.ChessStateData, data)
    end
    table.sort(this.ChessStateData, function(a, b)
        return a.Order < b.Order
    end)
end


this.ChangeChessState = function(Id)
    for index, value in ipairs(this.ChessStateData) do
        if value.Id == Id then
            value.StepData = 1
            return
        end
    end
end


this.InitChessState = function()
    for index, value in ipairs(this.ChessStateData) do
        value.StepData = 0
    end
end


this.RefushCharacterState = function()
    for index, value in ipairs(this.ChessStateData) do
        if value.StepData == 1 then
            value.StepData = 0;
            this.currentStateSow = table.Copy(value)
            break;
        end
    end
    this.InitChessState();
    if this.currentStateSow == nil then
        return
    end
    this.spineCharacter:Play(this.currentStateSow.ActionName, false, function()
        this.spineCharacter:Play("idle_1", true, nil)
    end)

    if this.characterTalkCortinue ~= nil then
        coroutine_runner.stop(this.characterTalkCortinue)
    end
    this.vm.data.showCharacterTalk = true
    this.vm.data.characterTalk = this.currentStateSow.WarningDes
    this.currentStateSow = nil
    this.characterTalkCortinue = coroutine_runner.start(function()
        coroutine_runner.wait(3)
        this.vm.data.showCharacterTalk = false
    end)
end



this.closeNetRank = function()
    this.vm.behaviour:UpdateTopBar("connectFourRank", this.OnBack)
    LuaMgr.HidePanel(UIName.ConnectFourRankViewModel)
end

this.getMondayTimestep = function()
    this.weekdayTime = DataMgr.Player.fourInLine.resetTime
end


this.ChessLastTime = function()
    LuaMgr.AddTimer(TimerConst.ConnectFourChess, function() this.TimereleaseFun() end, 1, 72000, true)
end


this.TimereleaseFun = function()
    if this.stopChess then
        LuaMgr.RemoveTimer(TimerConst.ConnectFourChess)
        return
    end
    local nowTemp = LuaMgr.Timestamp()
    if nowTemp - this.startTemps >= 15 then
        this.ChangeChessState(this.chessStepEmme.ChessGameTimeOut)
        LuaMgr.NextFrame(this.RefushCharacterState)
    end
end



this.NetFinishedConnect = function(fun)
    this.reqBoard={}







    for i,v in ipairs(this.GridData) do
        for p,m in ipairs(v) do
            local key=p*100+(i-1);
            if m~=0 then
                this.reqBoard[tostring(key)]=m;
            end
        end
    end
    local type = this.vm.data.hardSelected and "2" or "1"
    local askData = { 
        Type = type,
        Step={
Start=this.myFirstStep and 1 or 0,
Lines=this.reqSteps,
Board=this.reqBoard
        },
    }
    print("NetFinishedConnect  type : " .. type)
    local Url = "fourInLine/finished"
    LuaDebug.Nerror(askData);
    ApiMgr.Request(Url, askData, true,
        function(result)
            local re = json.decode(result)

            if re.result.Items ~= nil and (not IsNull(re.result.Items)) then
                this.characterTalkCortinue = coroutine_runner.start(function()
                    coroutine_runner.wait(1)

                    if not LuaMgr.IsPanelOpen(UIName.ConnectFourViewModel) then
                        return
                    end

                    local items = {};
                    local reward = re.result.Items
                    for i, v in pairs(reward) do
                        local item = { ID = v.id, Count = v.count }
                        table.insert(items, item);
                    end

                    LuaMgr.ShowItemGetPanel(items);
                end)
            end
            AudioHelper.PlayUISFX(AudioNames.Equip_levelup);
            if re.code == 0 then
                if fun ~= nil then
                    fun()
                end
            end
            this.BiliLog(1, re.result.Items, type);
        end,
        function(failCode)
            print("EnterDungeonError,ErrorCode:", failCode)
        end,
        true
    )
end

this.BiliLog = function(winType, Items, levelType)

    local firstItem = nil;
    if Items ~= nil and (not IsNull(Items)) then
        for i, v in pairs(Items) do
            firstItem = { ID = v.id, Count = v.count }
        end
    end
    local askData = {}
    askData["game_uid"] = (tostring(DataMgr.Player.uid) .. "|" .. tostring(this.startTime) .. "|" .. "foundation_tearoom_connectfour_end")
    askData["game_result"] = winType;
    askData["before_wins"] = -1
    askData["after_wins"] = -1
    askData["item_id"] = firstItem == nil and "" or firstItem.ID
    askData["item_num"] = firstItem == nil and "" or firstItem.Count
    askData["complete_time"] = tostring(LuaMgr.Timestamp() - this.startTime);
    askData["game_order"] = this.startFirstStepState;
    askData["game_diff"] = levelType;
    DataReportMgr.RequestBiliData("foundation_tearoom_connectfour_end", askData, nil, nil);
    this.startTime = LuaMgr.Timestamp();
end


this.NetRankData = function(fun)
    local data = { Key = "fourInLine", StartTime = this.weekdayTime }
    local Url = "rank/getRankInfo"
    ApiMgr.Request(Url, data, true,
        function(result)
            local re = json.decode(result)
            local rankResult = re.result

            this.rankData = {};
            if type(rankResult.Self) == "table" and rankResult.Self.Rank > 0 then
                this.vm.data.titleTextShow = string.format(LuaMgr.GetLangText("ConnectFourViewModel_0"),
                    rankResult.Self.Rank)
            else
                this.vm.data.titleTextShow = LuaMgr.GetLangText("ConnectFourViewModel_1")
            end

            if type(rankResult.List) == "table" then
                table.sort(rankResult.List, function(a, b)
                    return a.Rank < b.Rank
                end)

                local num = #rankResult.List;

                if num > 20 then
                    for i = 1, 20 do
                        table.insert(this.rankData, rankResult.List[i])
                    end
                else
                    for i = 1, num do
                        table.insert(this.rankData, rankResult.List[i])
                    end
                end
            end

            if re.code == 0 then
                if fun ~= nil then
                    fun()
                end
            end
        end,
        function(failCode)
            print("EnterDungeonError,ErrorCode:", failCode)
        end,
        true
    )
end


return vm({
    data = data,
    command = command,
    hook = hook
})