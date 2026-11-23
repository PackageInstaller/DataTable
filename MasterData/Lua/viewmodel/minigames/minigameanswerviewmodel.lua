



local this = {
    vm = nil,
    answercortine = nil,
isDrag = false,
PosLimit = {},
DragBehaviour = nil,
localPosition = nil,
ContentRect = nil,
    isOnRequest=false,
}
local qusetionTab = nil
local TestData = {}
local Currentquestion = nil
local Currentquestionindex = nil
local queshavemum = 0
local selectAnswer = nil
local AnswerMiddleGroup = {}
local AnswerData = {}
local QSpineChatar
local selectiomTitle = {}
local ITEM_ICON_PATH = "Assets/_BundleResources/Images/ItemIcons/itemicon_%s.png";
local Answer_ICON_PATH = "Assets/_BundleResources/Images/MiniGameAnswer/%s.png";
local equipIconPath = "Assets/_BundleResources/Images/ItemIcons/itemicon_"
local RewardObj
local Rewraditems = {}
local showTipsClode = true
local skipAllright = false
local rewardItemParent = {-477, -405, -333, -261, -189 }
local singleselect = 0
local rememberIndex = 1
local themId = ""
local eventType = 0
local data = {
    isTest=false,
    questionconstant = "",
    IsSingle = false,
    IsDouble = DefaultSprite,
    AnswerAll = false,
    answerslider = 0.1,
    showReward = false,
    itemIcon = DefaultTexture,
    itemnum = "",
    questionWithPicture = false,
    questionWithoutPicture = false,
    questionIcon = DefaultTexture,
    answerThinking = true,
    answerRight = false,
    answerWrong = false,
    limitclicks = false,
    lightClicks = true,
    rewardsClose = false,
    rewardPanelShow = false,
    rewardPos = Vector3.zero,
    makseSureLight = true,
    makseSureGray = false,
    skipText = "",
    answerTip = "",
    questionTiplist = "",
    SelectList = {
        {
            name = "",
            OptionText = "",
            ButtonInteractable = false,
            DeactiveEnable = false,
            SelectEnable = false,
            tatleLine = "",

        }
    },
    QuestionStateShow = {
        {

            stateicon = DefaultSprite,
            selectBgs = DefaultSprite,
            currentSate = false,
            playAnimation = false,
            stateName = "",
            tgaindex = "",
            rewards = {},
            rewardShow = false

        }
    },
    bookitemList = {
        {
            itemId = "",
            count = "",
            object = false,
            equipRare = DefaultSprite,
            equipIcon = DefaultTexture,
            already = false,
            isCount = false,
            equipTrue = Vector3.zero,
            equipFalse = Vector3.zero
        }
    },
bigIconActive=false,
sliderValue=0.01,
itemIconScele = Vector3.one,
bodyPos=Vector2.zero,
    showEnterAnmiActive=true,



}   
local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if  this.isOnRequest then
                return;
            end
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7103"].NameLan)
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, tipStr,this.CancelQuestion, nil)
        end
    },
    TimeListSort = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if  this.isOnRequest then
                return;
            end
            this.selectItemRank(param)
        end
    },
    LevelListSort = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if  this.isOnRequest then
                return;
            end
            this.selectItemRank(param)
        end
    }, ClickSelectTalkItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if  this.isOnRequest then
                return;
            end
            if this.vm.data.makseSureGray then
                return
            end
            if this.vm.data.IsSingle then
                local currenselect = function()
                    this.vm.data.SelectList[param + 1].SelectEnable = true
                    this.vm.data.SelectList[param + 1].DeactiveEnable = false
                    table.insert(AnswerMiddleGroup, param + 1)
                    singleselect = param + 1
                end
                if #AnswerMiddleGroup == 0 then
                    currenselect()
                else
                    this.vm.data.SelectList[singleselect].SelectEnable = false
                    this.vm.data.SelectList[singleselect].DeactiveEnable = true
                    table.remove(AnswerMiddleGroup, 1)
                    currenselect()
                end
            else
                table.insert(AnswerMiddleGroup, param + 1)
                this.vm.data.SelectList[param + 1].SelectEnable = true
                this.vm.data.SelectList[param + 1].DeactiveEnable = false
            end
        end

    }
    , ClickCancelTalkItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if  this.isOnRequest then
                return;
            end
            if #AnswerMiddleGroup ~= 0 then
                if this.vm.data.IsSingle then
                    this.vm.data.SelectList[param + 1].SelectEnable = false
                    this.vm.data.SelectList[param + 1].DeactiveEnable = true
                    AnswerMiddleGroup = {}
                else
                    this.vm.data.SelectList[param + 1].SelectEnable = false
                    this.vm.data.SelectList[param + 1].DeactiveEnable = true
                    local middletable = {}
                    for i = 1, #AnswerMiddleGroup, 1 do
                        if param + 1 ~= AnswerMiddleGroup[i] then
                            table.insert(middletable, AnswerMiddleGroup[i])
                        end
                    end
                    AnswerMiddleGroup = middletable
                end
            end
        end

    },
    ClickSendAnswer = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if  this.isOnRequest then
                return;
            end
            if #AnswerMiddleGroup ~= 0 then
                this.NetSelectTalkItem()
            end

        end
    },






    ClickCloseAnswer = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if  this.isOnRequest then
                return;
            end
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7103"].NameLan)
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, tipStr,this.CancelQuestion, nil)
        end
    },






    ClickItemShowReward = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.InitRewardListdata(param + 1)
        end
    },
    ClicRewardClose = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.rewardsClose = false
            this.vm.data.rewardPanelShow = false
        end
    },
showBigIconCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.isDrag = true
            local halfScreenWidth = LuaMgr.ScreenWidth() / 2
            this.PosLimit = { halfScreenWidth, -halfScreenWidth, 512, -512 }
            this.vm.data.bigIconActive = true
            this.vm.data.sliderValue = 0.01
            this.vm.data.itemIconScele = Vector3.one
        end
    },
sliderBigCommand = {
        type = XLuaCommandType.Float,
        execute = function(vm, param)
            this.vm.data.itemIconScele = Vector3.one + Vector3(param, param, 0)
        end
    },
closeBigIconCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.bigIconActive = false
this.vm.data.bodyPos = Vector2.zero
        end
    },
closeEnterAnimCommand = {
    type = XLuaCommandType.Void,
    execute = function(vm, param)
this.vm.data.showEnterAnmiActive = false
    end
},
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RewardObj = this.vm.behaviour.transform:Find("root/Middle/LeftPanel/RewardShow"):GetComponent("Animator")
this.ContentRect = vm.behaviour.transform:Find("root/Middle/MenumItem/Contnet/BodyObject"):GetComponent("RectTransform")
        this.DragBehaviour = vm.behaviour.transform:Find("root/Middle/MenumItem/Contnet/BodyObject"):GetComponent("OnDragBehaviour")
        this.DragBehaviour.onDrag = this.OnDrag
        this.DragBehaviour.onPointerDown = this.PointerDown
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            themId = vm.behaviour.Params[0];
            eventType = vm.behaviour.Params[1];
this.vm.data.showEnterAnmiActive=true;
            selectiomTitle = { LuaMgr.GetLangText("MiniGameAnswerViewModel_16"), LuaMgr.GetLangText("MiniGameAnswerViewModel_17"), LuaMgr.GetLangText("MiniGameAnswerViewModel_18"), LuaMgr.GetLangText("MiniGameAnswerViewModel_19") }
            skipAllright = false
            this.InitAnswerData()
            this.InitQuestionAnswer()
            this.showTips()
this.vm.data.isTest = LuaMgr.IsDebug();
            this.isOnRequest=false;
        end
    end,
    after_active = function()

        RewardObj:Play("MiniGamesRewardTip_2", 0, 0)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if this.answercortine ~= nil then
                coroutine_runner.stop(this.answercortine)
            end
            LuaMgr.InvokeUIEventListeners(UIEventConst.CollectorEventPanelClose);
            this.clearAlldata()
            this.vm.data.itemIconScele = Vector3.one
this.vm.data.bodyPos = Vector2.zero
            this.vm.data.bigIconActive=false
        end
    end,
before_destroy = function(vm)
        this.ContentRect = nil
        this.DragBehaviour = nil
        this.PosLimit = {}
        this.localPosition = nil
    end
}
this.showTips = function()
    this.vm.data.skipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2416"].NameLan)
    this.vm.data.answerTip = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2414"].NameLan)
    this.vm.data.questionTiplist = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2415"].NameLan)
end


this.InitAnswerData = function()
    this.vm.data.AnswerAll = DataMgr.Player.questions.CanSkip
    AnswerData = table.Copy(DataMgr.Player.questions.List)
    this.AnswerStateGroup()
end

this.CreatAnswerString = function(selectindex)

    if selectAnswer == nil then
        selectAnswer = "0000"
    end
    if selectindex > 4 then
        return "0001"
    end
    if selectindex < 1 then
        return "1000"
    end
    local tb = {}
    local resultStr = ""
    for utfChar in string.gmatch(selectAnswer, "%d") do
        table.insert(tb, utfChar)
    end

    tb[selectindex] = "1"
    for index, value in ipairs(tb) do
        resultStr = resultStr .. value
    end
    return resultStr
end


this.GetQuestionData = function()
    local data = {}
    local Url = "monopoly/get_question"
    ApiMgr.Request(
    Url,
    data,
    true,
    function(result)
        
        AnswerData = table.Copy(DataMgr.Player.questions.List)
        this.vm.data.AnswerAll = DataMgr.Player.questions.CanSkip
        Currentquestion = nil
        this.AnswerStateGroup()
    end,
    function(failCode)
        print("EnterDungeonError,ErrorCode:", failCode)
    end,
    true
    )
end
































this.clearAlldata = function()
    this.vm.data.answerThinking = true
    this.vm.data.answerRight = false
    this.vm.data.answerWrong = false
    this.vm.data.rewardPanelShow = false
    qusetionTab = nil
    TestData = {}
    Currentquestion = nil
    Currentquestionindex = nil
    queshavemum = 0
    selectAnswer = nil
    AnswerMiddleGroup = {}
    AnswerData = {}
    Rewraditems = {}
    showTipsClode = true
    skipAllright = false
    singleselect = 0
end


this.CancelQuestion = function()
    local data = {}
    local Url = "monopoly/question/drop"
    ApiMgr.Request(
    Url,
    data,
    true,
    function(result)
local co = coroutine_runner.start(function()
            this.isOnRequest=true;
            this.vm.data.answerThinking = false
            this.vm.data.answerRight = false
            this.vm.data.answerWrong = true
            QSpineChatar:Play("lose", true, function()
                QSpineChatar:Play("idle", true, nil)
                this.vm.data.answerThinking = true
                this.vm.data.answerWrong = false
            end)
            coroutine_runner.wait(1)
            LuaMgr.InvokeUIEventListeners(UIEventConst.CollectorEventPanelClose);
            this.isOnRequest=false;
            this.clearAlldata()
            LuaMgr.HidePanel(UIName.MiniGameAnswerViewModel)
        end)
    end,
    function(failCode)
        print("EnterDungeonError,ErrorCode:", failCode)
    end,
    true
    )
end


this.InitRewardListdata = function(index)

    if not this.vm.data.rewardPanelShow then
        local tabs = this.vm.data.QuestionStateShow[index].rewards
        this.vm.data.rewardsClose = true
        this.vm.data.rewardPanelShow = true
        this.vm.data.rewardPos = Vector3(rewardItemParent[index], -292, 0)
        this.showItemReward(tabs)
    else
        this.vm.data.rewardsClose = false
        this.vm.data.rewardPanelShow = false
    end

end

this.showItemReward = function(tabs)
    local tempList = {}
    local reward = json.decode(tabs)
    for key, value in pairs(reward) do
        local items = {
        }
        items = {
            itemId = value.id,
            object = true,
            equipRare = LuaMgr.GetSprite("ItemRare", "itemRare" .. ConfigHelper.GetItemById(value.id).rare),
            already = true,
            equipIcon = LuaMgr.GetTexture(equipIconPath .. value.id .. ".png"),
            equipTrue = Vector3(0.5, 0.5, 0.5),
            equipFalse = Vector3(0.5, 0.5, 0.5),
            rare = ConfigHelper.GetItemById(value.id).rare,
            isCount = true,
            count = tostring(value.count)
        }
        table.insert(tempList, items)
    end
    this.vm.data.bookitemList = tempList
end
















this.checkAnswerResult = function(param)
    local resulttrue = math.random(0, 4)
    if tonumber(param) == resulttrue then
        TestData[Currentquestionindex].Result = true
        QSpineChatar:Play("victory", false, function()
            QSpineChatar:Play("idle", true, nil)
        end)
    else
        TestData[Currentquestionindex].Result = false
        QSpineChatar:Play("lose", true, function()
            QSpineChatar:Play("idle", true, nil)
        end)
    end
    if Currentquestionindex + 1 <= #TestData then
        Currentquestionindex = Currentquestionindex + 1
    end
    Currentquestion = TestData[Currentquestionindex].key
    this.AnswerStateGroup()
end

this.InitQuestionAnswer = function()
    local characterId = DataMgr.Player.sex > 1 and "SCJ202" or "SCJ201"
    QSpineChatar = this.vm.behaviour.transform:Find("root/Middle/LeftPanel/HeroPos/QSpine/Spine/3DObject"):GetComponent("UISpineCharacter")
    QSpineChatar:Clear()
    QSpineChatar:SetBattle(characterId, characterId .. "001", "", ConfigMgr.Config.characterTable[characterId].job)
end


this.CreatQCharacter = function(characterId, skinId, trans, pos)

    this.character = CS.Laigu.Tools.SpineCharacter.Create(characterId, skinId, trans);
    if (this.character ~= nil) then

        this.character:SetDirection(0, 1);
        this.transform.localPosition = pos;
        this.character:Play("house_idle", true, nil);
    end
end


this.ShowSkipsAnswer = function()
    local ids = AnswerData[rememberIndex].ID
    local AnswerResultdata = ConfigMgr.Config.questionMap[ids].Answer
    if AnswerResultdata ~= nil then
        local tb = {}
        for utfChar in string.gmatch(tostring(AnswerResultdata), "%d") do
            table.insert(tb, utfChar)
        end
        for index_, value in ipairs(tb) do
            if value == "1" then
                this.vm.data.SelectList[index_].SelectEnable = true
                this.vm.data.SelectList[index_].DeactiveEnable = false
            end
        end
        this.vm.data.makseSureLight = false
        this.vm.data.makseSureGray = true

    end

end


this.AnswerStateGroup = function()
    local sortindex = 0
    local tempList = {}
    local currentindex = nil
    for index, value in ipairs(AnswerData) do
        sortindex = sortindex + 1
        if qusetionTab == nil then
            qusetionTab = {}
        end
        if Currentquestion == nil and value.Result == 0 then
            Currentquestion = value.ID
            Currentquestionindex = index
        end
        if this.CheckCompleteNum() then
            Currentquestion = AnswerData[#AnswerData]
            Currentquestionindex = #AnswerData + 1
        end

        if Currentquestionindex ~= nil then
            this.vm.data.answerslider = (Currentquestionindex / #AnswerData)
        end

        local iconstate
        local iconBgs
        if value.Result == 1 then
            iconstate = "ui_xwf_dt_box01"
            iconBgs = "ui_xwf_dt_jdt_dian_01"
        elseif value.Result == 2 then
            iconstate = "ui_xwf_dt_box03"
            iconBgs = "ui_xwf_dt_jdt_dian_03"
        elseif value.Result == 0 then
            iconstate = "ui_xwf_dt_box02"
            iconBgs = "ui_xwf_dt_jdt_dian_02"
        end
        local reward = json.encode(ConfigMgr.Config.questionMap[value.ID].Rewards)
        local showIcons = LuaMgr.GetSprite("MiniGameAnswer", iconstate)
        local showState = LuaMgr.GetSprite("MiniGameAnswer", iconBgs)
        local questionTemir = {
            name = tostring(index),
            tgaindex = tostring(index),
            currentSate = (Currentquestionindex ~= nil and Currentquestionindex == index),
            stateicon = showIcons,
            selectBgs = showState,
            rewards = reward,
            rewardShow = false
        }
        table.insert(tempList, questionTemir)
    end
    if Currentquestionindex ~= nil and Currentquestionindex > #AnswerData then
        this.vm.data.makseSureLight = false
        this.vm.data.makseSureGray = true
    else
        this.vm.data.makseSureLight = true
        this.vm.data.makseSureGray = false
    end
    if skipAllright then
        this.ShowSkipsAnswer()
    end
    this.vm.data.QuestionStateShow = tempList

    this.NovelOptioniewData(Currentquestion)
end


this.NetSelectTalkItem = function()
    local answerNet
    for index, value in ipairs(AnswerMiddleGroup) do
        selectAnswer = this.CreatAnswerString(value)
    end
    local data = { Idx = Currentquestionindex - 1, Answer = selectAnswer }
    AnswerMiddleGroup = {}
    local Url = "monopoly/answer"
    ApiMgr.Request(
    Url,
    data,
    true,
    function(result)
        local re = json.decode(result)
        if re.code == 0 then
            this.isOnRequest=true;
            selectAnswer = "0000"
            if re.result.Right then
                this.AnswerRightShow(re)
            else
                this.vm.data.answerThinking = false
                this.vm.data.answerRight = false
                this.vm.data.answerWrong = true
                QSpineChatar:Play("lose", true, function()
                    QSpineChatar:Play("idle", true, nil)
                    this.vm.data.answerThinking = true
                    this.vm.data.answerWrong = false
                end)
            end
            AnswerData = DataMgr.Player.questions.List
            Currentquestion = nil
            Currentquestionindex = nil
            this.AnswerStateGroup()
            this.isOnRequest=false;
            if this.CheckCompleteNum() then
                this.answercortine = coroutine_runner.start(function()
                    coroutine_runner.wait(1.5)
                    this.isOnRequest=false;
                    LuaMgr.HidePanel(UIName.MiniGameAnswerViewModel)
                end)
            end
        end
    end,
    function(failCode)
        print("EnterDungeonError,ErrorCode:", failCode)
    end,
    true
    )
end

this.AnswerRightShow = function(re)
    this.vm.data.answerThinking = false
    this.vm.data.answerRight = true
    this.vm.data.answerWrong = false
    QSpineChatar:Play("victory", false, function()
        this.vm.data.answerThinking = true
        this.vm.data.answerRight = false
        QSpineChatar:Play("idle", true, nil)
    end)
    if type(re.result.Rewards) == "table" then
        local reward = re.result.Rewards.Items
        for i, v in pairs(reward) do
            local item = { ID = v.id, Count = v.count }
            table.insert(Rewraditems, item);
        end
        if showTipsClode then
            this.ShowRewardTips()
        end

    end
end

this.ShowRewardTips = function()
    if #Rewraditems ~= 0 then
        showTipsClode = false
        local value = Rewraditems[1]
        local config = ConfigMgr.Config.itemMap[value.ID];
        if (type(config) == "table") then
            this.vm.data.itemnum = "+" .. value.Count
            this.vm.data.itemIcon = LuaMgr.GetTexture(string.format(ITEM_ICON_PATH, value.ID));
            RewardObj:Play("MiniGamesRewardTip_1", 0, 0)
        end
        table.remove(Rewraditems, 1)
        if #Rewraditems ~= 0 then
            coroutine_runner.start(
            function()

                coroutine_runner.wait(3)
                this.ShowRewardTips()
            end
            )
        else
            showTipsClode = true
        end
    else
        showTipsClode = true
    end

end

this.CheckCompleteNum = function()
    local completenum = 0
    local uncomplete = 0
    if type(DataMgr.Player.questions.List) == "table" then

        for index, value in ipairs(DataMgr.Player.questions.List) do
            if value.Result ~= 0 then
                completenum = completenum + 1
            end
            if value.Result == 0 then
                uncomplete = uncomplete + 1
            end
        end
    end
    return completenum >= 5, uncomplete == 0
end

this.NovelOptioniewData = function(id)
    local tempList = {}
    local selecttab = nil

    local value = ConfigMgr.Config.questionMap[id]
    if value ~= nil then
        selecttab = {}
        local valePicture = value.QuestionPic ~= nil and value.QuestionPic ~= ""
        this.vm.data.questionWithPicture = valePicture
        this.vm.data.questionWithoutPicture = not valePicture
        if valePicture then
            this.vm.data.questionIcon = LuaMgr.GetTexture(string.format(Answer_ICON_PATH, value.QuestionPic))
        end
        table.insert(selecttab, value.OptionALan)
        table.insert(selecttab, value.OptionBLan)
        table.insert(selecttab, value.OptionCLan)
        table.insert(selecttab, value.OptionDLan)
        this.vm.data.IsSingle = value.IsSingle
        this.vm.data.IsDouble = not value.IsSingle and LuaMgr.GetSprite("MiniGameAnswer", "ui_xwf_dt_duox") or LuaMgr.GetSprite("MiniGameAnswer", "ui_xwf_dt_danx")
        this.vm.data.questionconstant = value.Content
    end





    if selecttab == nil then
        return
    end
    for _key, _value in ipairs(selecttab) do
        local Novelitem = {
            OptionText = LuaMgr.GetLangText(_value),
            ButtonInteractable = true,
            DeactiveEnable = true,
            SelectEnable = false,
            AskValue = _value,
            tatleLine = selectiomTitle[_key]
        }
        table.insert(tempList, Novelitem)
    end
    this.vm.data.SelectList = tempList

end

this.PointerDown = function(eventData)

    this.localPosition = LuaMgr.Screen2Local(eventData.position, this.ContentRect)
end

this.OnDrag = function(eventData)

    local tarPos = LuaMgr.Screen2Local(eventData.position, this.ContentRect)
    local dirVector = tarPos - this.localPosition
    if this.vm.data.bodyPos.x > this.PosLimit[1] and dirVector.x > 0 then
        dirVector = Vector2(0, dirVector.y)
    end
    if this.vm.data.bodyPos.x < this.PosLimit[2] and dirVector.x < 0 then
        dirVector = Vector2(0, dirVector.y)
    end
    if this.vm.data.bodyPos.y > this.PosLimit[3] and dirVector.y > 0 then
        dirVector = Vector2(dirVector.x, 0)
    end
    if this.vm.data.bodyPos.y < this.PosLimit[4] and dirVector.y < 0 then
        dirVector = Vector2(dirVector.x, 0)
    end
    this.vm.data.bodyPos = this.vm.data.bodyPos + dirVector
end

return vm({
    data = data,
    command = command,
    hook = hook
})