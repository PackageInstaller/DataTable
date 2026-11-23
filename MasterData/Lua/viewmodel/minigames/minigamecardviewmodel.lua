



local this = { vm = nil }
local qusetionTab = nil
local CardTestData = {}
local NetLocks = false
local QSpineChatar
local totolSuccssful = 0
local character3d
local colorGreen = "<color=#3d7b77>%d</color>"
local colorRed = "<color=#a04141>%d</color>"
local archivesPath = "Assets/_BundleResources/Images/Archives/";
local RememberCard = {}
local totolfail = 0
local EndTimeStamp = nil
local waitTime = nil
local stepindex = 1
local coroutineRemember
local secondCoroutine
local themId = ""
local eventType = 0
local data = {
    itemIcon = DefaultTexture,
    timeShow = "",
    cardTips = "",
    timeLasts = "",
    failTimes = "",
    clickLimit = false,
    answerThinking = false,
    answerRight = false,
    answerWrong = false,
    resultBgs = false,
    miniCardList = {
        {
            itemId = "",
            cardIcon = DefaultTexture,
            animatorname = "",
            objactive = false,
        }
    },
    FailStateShow = {
        {
            fail = false,
            unfail = true,
            indexNum = "",
        }
    },
}
local completedata = {

}
local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7103"].NameLan)
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, tipStr, this.CloseCommand, nil)
        end
    },
    ClickBackToFont = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            for index, value in ipairs(RememberCard) do
                if value.index == param + 1 then
                    return
                end
            end
            this.vm.data.miniCardList[param + 1].animatorname = "MiniGameAnimationFont"
            table.insert(RememberCard, { index = param + 1, type = this.vm.data.miniCardList[param + 1].itemId })
            this.getRewardCard()
        end
    }
    ,
    ClickFontToBack = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if #completedata then
                for index, value in ipairs(completedata) do
                    if param + 1 == value then
                        return
                    end
                end
            end
            this.vm.data.miniCardList[param + 1].animatorname = "MiniGameAnimationBack"
            this.removeCard(param + 1)
            this.vm.data.clickLimit = true
            secondCoroutine = coroutine_runner.start(
                function()
                    coroutine_runner.wait(0.5)
                    this.vm.data.clickLimit = false
                end
            )
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            EndTimeStamp = ConfigMgr.Config.InternConstants.CardsTime[2]
            waitTime = ConfigMgr.Config.InternConstants.CardsTime[1]
            local cardTab = vm.behaviour.Params[0];
            themId = vm.behaviour.Params[1];
            eventType = vm.behaviour.Params[2];
            CardTestData = json.decode(cardTab).result.Cards
            this.InitQuestionAnswer()
            this.teaLevelViewData()
            this.FailSelectShow(0)
            this.vm.data.timeShow = tostring(EndTimeStamp)
            this.InitTimeShow()
            this.InitLangTextShow()
            this.vm.data.cardTips = LuaMgr.GetLangText("MiniGameCardViewModel_24")
            for index, value in ipairs(this.vm.data.miniCardList) do
                value.animatorname = "MiniGameAnimationCardInit"
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.closeAndAgainInit()
            LuaMgr.InvokeUIEventListeners(UIEventConst.CollectorEventPanelClose);
        end
    end
}

this.CloseCommand = function()
    this.NetDataSuccssful(0, 0)
end


this.InitLangTextShow = function()
    this.vm.data.cardTips = LuaMgr.GetLangText("MiniGameCardViewModel_25")
    this.vm.data.timeLasts = LuaMgr.GetLangText("MiniGameCardViewModel_26")
    this.vm.data.failTimes = LuaMgr.GetLangText("MiniGameCardViewModel_27")
end


this.teaLevelViewData = function()
    local tempList = {}
    for key, value in ipairs(CardTestData) do
        local Teas = {
            itemId = value,
            cardIcon = DefaultTexture,
        }
        local carditemtype = math.random(1, 3)
        Teas = {
            itemId = value,
            cardIcon = LuaMgr.GetTexture(archivesPath .. value .. ".png"),
            animatorname = "",
            objactive = true
        }
        table.insert(tempList, Teas)
    end
    this.vm.data.miniCardList = tempList
end


this.StringToTable = function(str, index, needindex)
    local tb = {}
    local resultStr = ""
    for utfChar in string.gmatch(str, "[%z-\127\194-\244][\128-\191]*") do
        table.insert(tb, utfChar)
    end
    for index, value in ipairs(tb) do
        resultStr = resultStr .. value
        if index == 2 then
            resultStr = resultStr .. "\n"
        end
    end
    return resultStr
end


this.closeAndAgainInit = function()
    if coroutineRemember ~= nil then
        coroutine_runner.stop(coroutineRemember)
    end
    if secondCoroutine ~= nil then
        coroutine_runner.stop(secondCoroutine)
    end
    RememberCard = {}
    stepindex = 1
    totolfail = 0
    totolSuccssful = 0
    completedata = {}
    this.vm.data.cardTips = LuaMgr.GetLangText("MiniGameCardViewModel_28")
    NetLocks = false
    LuaMgr.RemoveTimer(TimerConst.TeaLastTime)
end


this.getRewardCard = function()
    if #RememberCard ~= 2 then
        return
    end
    this.vm.data.clickLimit = true
    if secondCoroutine ~= nil then
        coroutine_runner.stop(secondCoroutine)
    end
    secondCoroutine = coroutine_runner.start(
        function()

            coroutine_runner.wait(0.7)
            this.vm.data.clickLimit = false
        end
    )
    coroutineRemember = coroutine_runner.start(
        function()
            this.vm.data.resultBgs = false
            this.vm.data.answerRight = false
            this.vm.data.answerWrong = false

            coroutine_runner.wait(0.5)
            if RememberCard[1].type == RememberCard[2].type then
                table.insert(completedata, RememberCard[1].index)
                table.insert(completedata, RememberCard[2].index)


                this.vm.data.answerRight = true
                this.vm.data.resultBgs = true
                QSpineChatar:Play("victory", false, function()
                    QSpineChatar:Play("idle", true, nil)
                    this.vm.data.resultBgs = false
                    this.vm.data.answerRight = false
                end)
                RememberCard = {}
                totolSuccssful = totolSuccssful + 1
                if totolSuccssful == #CardTestData * 0.5 then
                    this.cardSuccsful()
                end
            else
                this.vm.data.resultBgs = true
                this.vm.data.answerWrong = true
                QSpineChatar:Play("lose", true, function()
                    QSpineChatar:Play("idle", true, nil)
                    this.vm.data.resultBgs = false
                    this.vm.data.answerWrong = false
                end)
                totolfail = totolfail + 1
                if totolfail >= 3 then
                    this.cardFail()
                end
                this.FailSelectShow(totolfail)
                this.vm.data.miniCardList[RememberCard[1].index].animatorname = "MiniGameAnimationBack"
                this.vm.data.miniCardList[RememberCard[2].index].animatorname = "MiniGameAnimationBack"
                RememberCard = {}
            end
        end
    )
end

this.removeCard = function(param)
    local removeindex = 0
    for index, value in ipairs(RememberCard) do
        if param == value.index then
            removeindex = index
        end
    end
    if removeindex ~= 0 then
        table.remove(RememberCard, removeindex)
    end
end

this.ShowTeaMessage = function(tabs)
    local Description = LuaMgr.GetLangText(ConfigMgr.Config.itemMap[tabs.itemId].DescriptionLan)
    local Time = ConfigMgr.Config.highteaMain[tabs.itemId].SpendTime
    local TimeShow = ""
    local line = math.modf(Time / 60)
    local mod = math.fmod(Time, 60)
    TimeShow = (line < 10 and "0" .. tostring(line) or tostring(line)) ..
        LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2121"].NameLan) ..
        (mod < 10 and "0" .. tostring(mod) or tostring(mod)) ..
        LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2122"].NameLan)
    return TimeShow, Description
end

this.InitQuestionAnswer = function()
    local characterId = DataMgr.Player.sex > 1 and "SCJ202" or "SCJ201"
    QSpineChatar = this.vm.behaviour.transform:Find("root/Middle/LeftPanel/HeroPos/QSpine/Spine/3DObject"):GetComponent(
    "UISpineCharacter")
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




this.FailSelectShow = function(totol)
    local tempList = {}
    for i = 1, 3, 1 do
        local Teas = {
            fail = false,
            unfail = true,
            indexNum = ""
        }
        Teas = {
            fail = i <= totol,
            unfail = i > totol,
            indexNum = tostring(i)
        }
        table.insert(tempList, Teas)
    end
    this.vm.data.FailStateShow = tempList
end



this.showRewardResult = function(code)
    LuaMgr.ShowLuaPanel(UIName.MiniGameResultRewardViewModel, 1);
end

this.NovelOptioniewData = function(id)
    local tempList = {}
    local selecttab = nil


    for key, value in pairs(ConfigMgr.Config.questionMap) do
        if value.Id == id then
            selecttab = {}
            table.insert(selecttab, value.OptionA)
            table.insert(selecttab, value.OptionB)
            table.insert(selecttab, value.OptionC)
            table.insert(selecttab, value.OptionD)
        end
    end
    if selecttab == nil then
        return
    end
    for _key, _value in ipairs(selecttab) do
        local Novelitem = {
            OptionText = _value,
            ButtonInteractable = true,
            DeactiveEnable = false,
            SelectEnable = false,
            AskValue = _value
        }
        table.insert(tempList, Novelitem)
    end
    this.vm.data.FailStateShow = tempList
end


this.ShowQuestionState = function()
    local tempList = {}
    for index, value in ipairs(qusetionTab) do
        local iconstate = value.current and "ui_pm_htjd_1" or (value.answerTrue and "ui_pm_htjd_4" or "ui_pm_htjd_2")
        local questionTemir = {
            name = tostring(index),
            currentSate = value.current,
            stateicon = LuaMgr.GetSprite("TeaTastSip", "iconstate"),
            selectLight = LuaMgr.GetSprite("TeaTastSip", "ui_pm_htjd_g1"),

        }
    end
end

this.InitTimeShow = function()
    LuaMgr.RemoveTimer(TimerConst.TeaLastTime)
    LuaMgr.AddTimer(TimerConst.TeaLastTime, this.TimeTextShow, 1, 72000, true)
end

this.TimeTextShow = function()
    if stepindex == 1 then
        if waitTime >= 0 then
            this.vm.data.clickLimit = true
            this.vm.data.timeShow = tostring(waitTime)
        else
            LuaMgr.RemoveTimer(TimerConst.TeaLastTime)
            stepindex = 2
            for index, value in ipairs(this.vm.data.miniCardList) do
                value.animatorname = "MiniGameAnimationBack"
            end
            if coroutineRemember ~= nil then
                coroutine_runner.stop(coroutineRemember)
            end
            coroutineRemember = coroutine_runner.start(
                function()

                    coroutine_runner.wait(1)
                    this.vm.data.clickLimit = false
                    this.vm.data.timeShow = tostring(EndTimeStamp)
                    this.vm.data.cardTips = LuaMgr.GetLangText("MiniGameCardViewModel_29")
                    LuaMgr.AddTimer(TimerConst.TeaLastTime, this.TimeTextShow, 1, 72000, true)
                end
            )
        end
        waitTime = waitTime - 1
    else
        if EndTimeStamp >= 0 then
            if EndTimeStamp > 3 then
                this.vm.data.timeShow = string.format(colorGreen, tostring(EndTimeStamp))
            else
                this.vm.data.timeShow = string.format(colorRed, tostring(EndTimeStamp))
            end
        else
            LuaMgr.RemoveTimer(TimerConst.TeaLastTime)
            this.cardFail()
        end
        EndTimeStamp = EndTimeStamp - 1
    end
end

this.cardSuccsful = function()
    this.NetDataSuccssful(1, EndTimeStamp)
end
this.cardFail = function()
    this.NetDataSuccssful(0, 0)
end
this.NetDataSuccssful = function(code, time)
    LuaMgr.RemoveTimer(TimerConst.TeaLastTime)
    if not NetLocks then
        NetLocks = true
    else
        return
    end
    local data = { Success = code == 1, RemainderSec = time >= 0 and time or 0, EventType = eventType, ThemeId = themId }
    local Url = "monopoly/flipcard/finish"
    ApiMgr.Request(Url, data, true,
        function(result)
            local re = json.decode(result)
            if code ~= 1 then
                QSpineChatar:Play("lose", true, function()
                    QSpineChatar:Play("idle", true, nil)
                    this.vm.data.resultBgs = false
                    this.vm.data.answerWrong = false
                end)
            end
            this.succssfulNet(re)
        end,
        function(failCode)
            print("EnterDungeonError,ErrorCode:", failCode)
        end,
        true
    )
end


this.succssfulNet = function(re)
    local codes = re.result.Level
    local reward = {};
    if not IsNull(re.result.Rewards) then
        reward = re.result.Rewards.Items
    end
    local id
    local num
    if reward ~= {} then
        for key, value in pairs(reward) do
            id = value.id
            num = value.count
        end
        LuaMgr.ShowLuaPanel(UIName.MiniGameResultRewardViewModel, codes, function()
            LuaMgr.HidePanel(UIName.MiniGameCardViewModel)
        end, id, num);
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})