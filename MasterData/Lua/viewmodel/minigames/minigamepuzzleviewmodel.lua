



local this = {
    vm = nil,
    selectSuc = {},
    clickColored = false,
}
local QSpineChatar
local IconPath = "Assets/_BundleResources/Images/MiniGamePuzzle/ui_hd_hzj_pf_pt%s.png";
local ITEM_ICON_PATH = "Assets/_BundleResources/Images/ItemIcons/itemicon_%s.png";
local UICamera
local onDragBehaviour
local selectPuzzlePos
local ParamThemeId
local ParamEventType
local ParamPuzzleID
local selecRightIndex
local defaultBgTexture
local Rewraditems = {}
local showTipsClode = true
local posGroup = {
    Vector3(-134, 64, 0),
    Vector3(9, 64, 0),
    Vector3(148, 64.5, 0),
    Vector3(-133.5, -23.5, 0),
    Vector3(148, -23.5, 0),

}
local PuzzleGroupType_1 = {
    Vector3(-225, 133, 0),
    Vector3(0, 133, 0),
    Vector3(225, 133, 0),
    Vector3(-225, 0, 0),
    Vector3(0, 0, 0),
    Vector3(225, 0, 0),
    Vector3(-225, -133, 0),
    Vector3(0, -133, 0),
    Vector3(225, -133, 0),
}
local rootPos
local RewardObj
local DragItems
local pointPosition
local currentSelectPuzzle
local LeftPuzzleTable
local RightPuzzleTable
local SkinItem
local totolfail = 0
local totolsuccssful = 0
local middleAnimator = 0
local OpenTimeTempt = 0
local cortinueSaver
local data = {
    skinDebrPosition = { Vector3.zero, Vector3.zero, Vector3.zero, Vector3.zero, Vector3.zero, Vector3.zero, Vector3.zero, Vector3.zero, Vector3.zero },
    skinDebrisHas = {true, true, true, true, true, true, true, true, true },
    skinDebrising = {true, true, true, true, true, true, true, true, true },
    totoBglImagine = DefaultTexture,
    dragImagine = DefaultTexture,
    dragImagineActive = false,
    dragActive = true,
    itemIcon = DefaultTexture,
    itemnum = "",
    answerBgs = false,
    answerThinking = false,
    answerRight = false,
    answerWrong = false,




    questionTiplist = "",
    dragImaginePos = Vector3.zero,
    dragPuzzleList = {
        {
            PuzzleIcon = DefaultTexture,
            Puzzlename = "",
            Puzzleactive = true,
            Puzzlepos = Vector3.zero,
            puzzleBgPosition = Vector3.zero,
            PuzzleBg = DefaultTexture,
        }
    },
    FailStateShow = {
        {
            fail = false,
            unfail = true,
            indexNum = "",
        }
    },
    showPuzzleList = {
        {
            itemIcon = DefaultTexture
        }

    },
    puzzleOpen=false,
}
local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7103"].NameLan)
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, tipStr,this.ClosePuzzleCommand, nil)
        end
    },
    clickPuzzleItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.dragActive = true
            this.vm.data.dragPuzzleList[param + 1].active = false
            this.vm.data.dragImagine = LuaMgr.GetTexture(this.vm.data.dragPuzzleList[param + 1].iconNmme)
        end
    },























}

local hook = {
    before_awake = function(vm)

        this.vm = vm
        rootPos = vm.behaviour.transform:Find("root");
        pointPosition = vm.behaviour.transform:Find("root/Middle/LeftPanel/PuzzList/ViewPort/Constant");
        DragItems = vm.behaviour.transform:Find("root/MoveRawImage");
        SkinItem = vm.behaviour.transform:Find("root/Middle/RightPanel/Skin");
        onDragBehaviour = vm.behaviour.transform:Find("root/Drags"):GetComponent("OnDragBehaviour");
        middleAnimator = vm.behaviour.transform:Find("root/Middle"):GetComponent("Animator");
        onDragBehaviour.onDrag = this.OnDrag;
        onDragBehaviour.onPointerDown = this.PointerDown;
        onDragBehaviour.onPointerUp = this.OnPointerUp;
        onDragBehaviour.onEndDrag = this.OnEndDrag;
        OpenTimeTempt = LuaMgr.Timestamp()
        RewardObj = this.vm.behaviour.transform:Find("root/Middle/LeftPanel/RewardShow"):GetComponent("Animator")

    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            this.RandomFivePage()

            ParamThemeId = vm.behaviour.Params[0]
            ParamEventType = vm.behaviour.Params[1]
            ParamPuzzleID = vm.behaviour.Params[2]

            this.vm.data.answerBgs = false
            this.vm.data.answerRight = false
            this.vm.data.answerWrong = false

            this.InitBigBgSprite(ParamPuzzleID)
            this.InitQuestionAnswer()
            this.InitPuzzlePackage()
            this.InitRightPuzzleGroup()
            this.FailSelectShow()
            totolfail = 0
            totolsuccssful = 0
            this.vm.data.puzzleOpen=false;
local co = coroutine_runner.start(function()
                    coroutine_runner.wait(0.5)
                    this.vm.data.puzzleOpen=true;
            end)



            LuaMgr.AddUIEventListener(UIEventConst.OnApplicationFocus, this.ApplicationFocus);
        end
    end,
    after_awake = function()
        print("after_awake")
    end,
    after_active = function()
        middleAnimator:Play("MiniGamesPuzzleInit", 0, 0);
        print("after_active")
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            defaultBgTexture = nil
            this.selectSuc = {}
            this.clickColored = false
            LuaMgr.InvokeUIEventListeners(UIEventConst.CollectorEventPanelClose);
            LuaMgr.RemoveUIEventListener(UIEventConst.OnApplicationFocus, this.ApplicationFocus);
            if cortinueSaver ~= nil then
                coroutine_runner.stop(cortinueSaver)
                cortinueSaver = nil
            end
            QSpineChatar:Clear()
        end
    end
}


this.InitBigBgSprite = function(id)

    local Name = ConfigMgr.Config.GamePuzzleMap[tostring(id)].PuzzlePic
    defaultBgTexture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/MiniGamePuzzle/%s.png", Name))
    this.vm.data.totoBglImagine = defaultBgTexture
    this.vm.data.questionTiplist = LuaMgr.GetLangText("MiniGameCardViewModel_27")
end

this.ClosePuzzleCommand=function ()
    LuaMgr.NextFrame(function()
        local data = { ThemeId = ParamThemeId, EventType = ParamEventType, IsPrize = false,Win=false }
        local Url = "puzzle/finished"
    ApiMgr.Request(Url, data, true,function ()
local co = coroutine_runner.start(function()
            this.vm.data.answerBgs = true
            this.vm.data.answerRight = false
            this.vm.data.answerWrong = true
            QSpineChatar:Play("lose", true, function()
                QSpineChatar:Play("idle", true, nil)
                this.vm.data.answerBgs = false
                this.vm.data.answerWrong = false
            end)
            this.vm.data.dragImagineActive = false
            coroutine_runner.wait(1)
            LuaMgr.HidePanel(UIName.MiniGamePuzzleViewModel)




            showTipsClode = true
            Rewraditems = {}
        end)
      
    end,
    function(failCode)
        print("EnterDungeonError,ErrorCode:", failCode)
    end,
    true
    )
    end)
end


this.ClosePuzzle = function()
    LuaMgr.NextFrame(function()
        local data = { ThemeId = ParamThemeId, EventType = ParamEventType, IsPrize = false,Win=false }
        local Url = "puzzle/finished"
    ApiMgr.Request(Url, data, true,function ()
        LuaMgr.HidePanel(UIName.MiniGamePuzzleViewModel)




        showTipsClode = true
        Rewraditems = {}
    end,
    function(failCode)
        print("EnterDungeonError,ErrorCode:", failCode)
    end,
    true
    )
    end)
end

this.InitPuzzlePackage = function()
    local tempList = {}
    for i, value in ipairs(LeftPuzzleTable) do
        local Pagpos = 10 - value
        local Items = {
            PuzzleIcon = LuaMgr.GetTexture(string.format(IconPath, i));
            Puzzlename = tostring(i),
            Puzzleactive = true,
            Puzzlepos = posGroup[i],
            puzzleBgPosition = PuzzleGroupType_1[Pagpos],
            PuzzleBg = defaultBgTexture
        }
        table.insert(tempList, Items)
    end
    this.vm.data.dragPuzzleList = tempList
end

this.InitRightPuzzleGroup = function()
    for i = 1, 9, 1 do
        this.vm.data.skinDebrPosition[i] = PuzzleGroupType_1[i]

    end
    this.vm.data.skinDebrPosition[1] = PuzzleGroupType_1[1]
    for index, value in ipairs(LeftPuzzleTable) do
        this.vm.data.skinDebrisHas[value] = false
        this.vm.data.skinDebrising[value] = false
    end
    for index, value in ipairs(RightPuzzleTable) do
        this.vm.data.skinDebrisHas[value] = true
        this.vm.data.skinDebrising[value] = false
    end
end


this.RandomFivePage = function()
    local NumGroup = { 1, 2, 3, 4, 5, 6, 7, 8, 9 }
    local nowTimestamp = LuaMgr.Timestamp()
    local randomseed = nowTimestamp - (nowTimestamp - OpenTimeTempt) * 1000
    local randomHave = {}
    for i = 1, 5, 1 do
        randomseed = randomseed - i
        local length = #NumGroup
        math.randomseed(randomseed)
        local fit = math.random(1, length)
        table.insert(randomHave, NumGroup[fit])
        table.remove(NumGroup, fit)
    end
    LeftPuzzleTable = randomHave
    RightPuzzleTable = NumGroup


end


this.FailSelectShow = function()
    local tempList = {}
    for i = 1, 3, 1 do
        local Teas = {
            fail = false,
            unfail = true,
            indexNum = ""
        }
        Teas = {
            fail = true,
            unfail = false,
            indexNum = tostring(i)
        }
        table.insert(tempList, Teas)
    end
    this.vm.data.FailStateShow = tempList
end

this.OnDrag = function(eventData)
    print("拖拽中")
    local tarPos = LuaMgr.Screen2Local(eventData.position, rootPos)

    this.vm.data.dragImaginePos = Vector3(tarPos.x, tarPos.y, 0)
end

this.PointerDown = function(eventData)
    local tarPos = LuaMgr.Screen2Local(eventData.position, rootPos)
    local contentPos = LuaMgr.Screen2Local(eventData.position, pointPosition)
    currentSelectPuzzle = this.CheckOnclickPoint(Vector3(contentPos.x, contentPos.y, 0))
    if currentSelectPuzzle ~= nil then
        if this.selectSuc[tostring(currentSelectPuzzle)] ~= nil then
            return
        end
        selecRightIndex = LeftPuzzleTable[currentSelectPuzzle]
        this.vm.data.dragPuzzleList[currentSelectPuzzle].Puzzleactive = false
        selectPuzzlePos = this.vm.behaviour.transform:Find("root/Middle/RightPanel/Skin/SkinIcon" .. selecRightIndex);
        selectPuzzlePos:SetParent(DragItems)
        selectPuzzlePos:SetAsFirstSibling()
        this.vm.data.dragImagineActive = true

        selectPuzzlePos.localPosition = Vector3.zero

        this.vm.data.dragImaginePos = Vector3(tarPos.x, tarPos.y, 0)

        this.vm.data.skinDebrisHas[selecRightIndex] = false
        this.vm.data.skinDebrising[selecRightIndex] = true



    end
end

this.OnPointerUp = function(eventData)
    if currentSelectPuzzle == nil then
        return
    end
    if this.selectSuc[tostring(currentSelectPuzzle)] ~= nil then
        return
    end
    local tarPos = LuaMgr.Screen2Local(eventData.position, rootPos)
    this.vm.data.dragImagineActive = false
    selectPuzzlePos:SetParent(SkinItem)
    selectPuzzlePos.localPosition = PuzzleGroupType_1[selecRightIndex]
    if tarPos.x < -128 then
        this.vm.data.skinDebrisHas[selecRightIndex] = false
        this.vm.data.skinDebrising[selecRightIndex] = false
        this.vm.data.dragPuzzleList[currentSelectPuzzle].Puzzleactive = true
        return
    end
    local upPos = LuaMgr.Screen2Local(eventData.position, SkinItem)


    local cpllider = this.checkDragUpPoint(selecRightIndex, upPos)
    if cpllider then
        this.selectSuc[tostring(currentSelectPuzzle)] = 1
        this.vm.data.answerBgs = true
        this.vm.data.answerRight = true
        this.vm.data.answerWrong = false
        QSpineChatar:Play("victory", false, function()
            this.vm.data.answerBgs = false
            this.vm.data.answerRight = false
            QSpineChatar:Play("idle", true, nil)
        end)
        totolsuccssful = totolsuccssful + 1

    else
        this.vm.data.answerBgs = true
        this.vm.data.answerRight = false
        this.vm.data.answerWrong = true
        QSpineChatar:Play("lose", true, function()
            QSpineChatar:Play("idle", true, nil)
            this.vm.data.answerBgs = false
            this.vm.data.answerWrong = false
        end)
        this.vm.data.skinDebrisHas[selecRightIndex] = false
        this.vm.data.skinDebrising[selecRightIndex] = false
        this.vm.data.dragPuzzleList[currentSelectPuzzle].Puzzleactive = true
        this.vm.data.dragImagineActive = false
        totolfail = totolfail + 1
        this.vm.data.FailStateShow[totolfail].fail = false
        this.vm.data.FailStateShow[totolfail].unfail = true

    end
    this.ChargeFailorSuccsfu()
end

this.OnEndDrag = function(eventData)

end
this.NetDataSuccssful = function(finish, fun)
    local data = { ThemeId = ParamThemeId, EventType = ParamEventType, IsPrize = finish,Win=finish }
    local Url = "puzzle/finished"
    ApiMgr.Request(Url, data, true,
    function(result)
        local re = json.decode(result)


        if re.code == 0 then
            this.selectSuc = {}
            if fun ~= nil then
                fun()
            end
            if type(re.result.Items) == "table" and finish then
                local reward = re.result.Items
                for i, v in pairs(reward) do
                    local item = { ID = v.id, Count = v.count }
                    table.insert(Rewraditems, item);
                end

                if showTipsClode then

                    this.ShowRewardTips()
                end
            end
        end

    end,
    function(failCode)
        print("EnterDungeonError,ErrorCode:", failCode)
    end,
    true
    )
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
        cortinueSaver = coroutine_runner.start(
        function()

            coroutine_runner.wait(2)
            this.ShowRewardTips()
        end)

    else

        LuaMgr.HidePanel(UIName.MiniGamePuzzleViewModel)




        showTipsClode = true
        Rewraditems = {}
    end

end


this.succssfulNet = function(re)
    local codes = re.result.Level
    local reward = re.result.Rewards.Items
    local id
    local num
    for key, value in pairs(reward) do
        id = value.id
        num = value.count
    end
    LuaMgr.ShowLuaPanel(UIName.MiniGameResultRewardViewModel, codes, function()
        LuaMgr.HidePanel(UIName.MiniGameCardViewModel)
    end, id, num);
end

this.ChargeFailorSuccsfu = function()
    if totolfail >= 3 then
        cortinueSaver = coroutine_runner.start(
        function()
            coroutine_runner.wait(1)
            this.ClosePuzzle()
        end)

    end
if totolsuccssful >= 5 then
local co = coroutine_runner.start(function()
            coroutine_runner.wait(0.1)
            middleAnimator:Play("MiniGamesPuzzleBrush_1", 0, 0);
            coroutine_runner.wait(0.3)
            middleAnimator:Play("MiniGamesPuzzlePigment_1", 0, 0);
            coroutine_runner.wait(0.3)
            this.NetDataSuccssful(true)
        end)
    end
end


this.CheckOnclickPoint = function(inputpos)
    for index, value in ipairs(posGroup) do
        if inputpos.x >= value.x - 56.25 and inputpos.x <= value.x + 56.25 and inputpos.y >= value.y - 33.25 and inputpos.y <= value.y + 33.25 then

            return index
        end
    end
    return nil
end

this.checkDragUpPoint = function(index, inputPos)
    local pos = PuzzleGroupType_1[index]
    local TargetPosGroup = {
        { pos.x + 112.5, pos.y + 66.5 },
        { pos.x + 112.5, pos.y - 66.5 },
        { pos.x - 112.5, pos.y + 66.5 },
        { pos.x - 112.5, pos.y - 66.5 },
    }
    local CurrentPosGroup = {
        { inputPos.x + 56.25, inputPos.y + 33.25 },
        { inputPos.x + 56.25, inputPos.y - 33.25 },
        { inputPos.x - 56.25, inputPos.y + 33.25 },
        { inputPos.x - 56.25, inputPos.y - 33.25 },
    }
    for index, value in ipairs(CurrentPosGroup) do
        if value[1] > TargetPosGroup[3][1] and value[1] < TargetPosGroup[1][1] and value[2] > TargetPosGroup[2][2] and value[2] < TargetPosGroup[1][2] then
            return true
        end
    end
    return false
end


this.CheckClick = function()
    if (CS.Laigu.Tools.RaycastTool.GetMouseButton(0)) then

        local obj = CS.Laigu.Tools.RaycastTool.GetClickInfo(UICamera, -1000, "Obs");
        if (obj ~= nil) then


        end
    end
    if (CS.Laigu.Tools.RaycastTool.GetMouseButtonUp(0)) then
        local obj = CS.Laigu.Tools.RaycastTool.GetClickInfo(UICamera, 1000, "Obs");
        if (obj ~= nil) then


        end
    end
end


this.OnUpdate = function()
    this.CheckClick()
end

this.InitQuestionAnswer = function()
    local characterId = DataMgr.Player.sex > 1 and "SCJ202" or "SCJ201"
    QSpineChatar = this.vm.behaviour.transform:Find("root/Middle/LeftPanel/HeroPos/QSpine/Spine/3DObject"):GetComponent("UISpineCharacter")
    QSpineChatar:Clear()
    QSpineChatar:SetBattle(characterId, characterId .. "001", "", ConfigMgr.Config.characterTable[characterId].job)
end

this.ApplicationFocus = function(args)
    if (this.vm ~= nil) then
        local hasFocus = args[0];
        if hasFocus and currentSelectPuzzle ~= nil then
            this.vm.data.dragImagineActive = false
            selectPuzzlePos:SetParent(SkinItem)
            selectPuzzlePos.localPosition = PuzzleGroupType_1[selecRightIndex]
            this.vm.data.skinDebrisHas[selecRightIndex] = false
            this.vm.data.skinDebrising[selecRightIndex] = false
            this.vm.data.dragPuzzleList[currentSelectPuzzle].Puzzleactive = true
        end
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})