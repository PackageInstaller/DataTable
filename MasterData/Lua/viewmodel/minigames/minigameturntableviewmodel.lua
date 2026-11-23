



local this = {
    vm = nil,
    themeId = nil,
    eventType = nil,
    BoardId = nil,
    RewardObj = nil,
    Rewraditems = {},
    showTipsClode = true,
    ITEM_ICON_PATH = "Assets/_BundleResources/Images/ItemIcons/itemicon_%s.png",
    complete = false,
    LineData = nil,
    turentableData = nil,
    showsuccdata = {},
    succDataList = {},
    truntablecortine = nil

}
local QSpineChatar
local character3d
local OnPress = false
local TurnTransformTable = {}
local positionGroup = {}
local constanGroup = {}
local clickLimit = false
local heroPos = nil






local TestData = { "A1", "B1", "B2", "B3", "B4", "B5", "B6", "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "C10", "C11", "C12",}
local selectItem
local CircleItemTweener
local InitPosGroup = {}
local succssfulPointGroup = {}
local onDragBehaviour
local turnPropRoot
local tranparent
local succssfulPoint
local CircleStartAngle = 0
local CircleEndAngle = -60
local CirclePosItem = {}
local clockwise = 1
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
    turnValue = Vector3.zero,
    itemnum = "",
    lineEffect = false,
    leftcircle = false,
    leftselect = false,
    rightcircle = false,
    rightselect = false,
    turnTableList = {
        {
            name = "", id = "", icon = DefaultSprite, heroIcon = DefaultTexture, heroIconActive = false, pos = Vector3.zero, currentKey = "", angles = Vector3.zero, heroIconNormal = false, succssfulPoint = false
        }
    },
    succssfulPoint = {
        {
            name = "", id = "", icon = DefaultSprite, heroIcon = DefaultTexture, heroIconActive = false, pos = Vector3.zero, currentKey = "", angles = Vector3.zero
        }
    },
    LineParentItemList = {
        {
            LineposItem = Vector3.zero,
            Lineangles = Vector3.zero,
            Linelength = Vector2.zero,
        },
    },
    LineChildItemList = {
        {
            LineposItem = Vector3.zero,
            Lineangles = Vector3.zero,
            Linelength = Vector2.zero,
        },
    },
    TurnTitleList = {
        {
            name = "", id = "", icon = DefaultSprite, heroIcon = DefaultTexture, heroIconActive = false, pos = Vector3.zero, currentKey = "", angles = Vector3.zero
        },
    }
}
local completedata = {

}
local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.MiniGameTurnTableViewModel)
        end
    },

    ClickTurnTableItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if clickLimit or this.complete then
                return
            else
                this.ShowTurnTableItem()
            end

        end
    },
    ClickClockWish = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            clockwise = 1
            this.ShowLeftSelect()
        end
    },
    ClickAnticlockwise = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            clockwise = -1
            this.ShowRightSelect()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        turnPropRoot = this.vm.behaviour.transform:Find("root/Middle/PointParentTurnList")
        succssfulPoint = this.vm.behaviour.transform:Find("root/Middle/PointSuccssfulList")
        tranparent = this.vm.behaviour.transform:Find("root/Middle/PointParentPoint")
        onDragBehaviour = vm.behaviour.transform:Find("root/Middle/PointParentTurnList"):GetComponent("OnDragBehaviour");
        this.RewardObj = this.vm.behaviour.transform:Find("root/Middle/RewardShow"):GetComponent("Animator")
        onDragBehaviour.onDrag = this.OnDrag;
        onDragBehaviour.onPointerDown = this.PointerDown;
        onDragBehaviour.onPointerUp = this.OnPointerUp;
        onDragBehaviour.onEndDrag = this.OnEndDrag;
        heroPos = this.AngleAndPosition()
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            if heroPos == nil then
                heroPos = this.AngleAndPosition()
            end
            this.BoardId = vm.behaviour.Params[0]
            this.InitConfigData(this.BoardId)
            this.InitQuestionAnswer()
            this.InitTurnTableList()
            this.InitSuccssfuCheck()
            this.ShowLeftSelect()
            clockwise = 1
            this.RewardObj:Play("MiniGamesRewardTip_2", 0, 0)
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if this.truntablecortine ~= nil then
                coroutine_runner.stop(this.truntablecortine)
            end
            this.closeAndAgainInit()
            this.complete = false
            this.vm.data.lineEffect = false
            InitPosGroup = {}
            succssfulPointGroup = {}
            this.succDataList = {}
            clockwise = 1
        end
    end
}


this.ShowRightSelect = function()
    this.vm.data.leftcircle = true
    this.vm.data.leftselect = false
    this.vm.data.rightcircle = false
    this.vm.data.rightselect = true
end
this.ShowLeftSelect = function()
    this.vm.data.leftcircle = false
    this.vm.data.leftselect = true
    this.vm.data.rightcircle = true
    this.vm.data.rightselect = false
end


this.AngleAndPosition = function()
    local standardLength = 87
    local PosAngleData = {}

    local function keepDecimalTest(num, n)
        if type(num) ~= "number" then
            return num
        end
        n = n or 2
        return tonumber(string.format("%." .. n .. "f", num))
    end
    PosAngleData["A1"] = Vector3(0, 0, 0)
    for i = 1, 6, 1 do
        local Angle = -(i - 1) * math.pi / 3
        local PosY
        local PosX
        PosY = math.sin(Angle) * standardLength
        PosY = keepDecimalTest(PosY, 3)
        PosX = math.cos(Angle) * standardLength
        PosX = keepDecimalTest(PosX, 3)
        local Index = "B" .. i
        local Nums = {}
        PosAngleData[Index] = Vector3(PosX, PosY, 0)
    end
    local smallAngle = math.pi / 6
    local Longth = standardLength * 2
    local Smalllength = standardLength * 2 * math.cos(smallAngle)
    for i = 1, 12, 1 do
        local Angle = -(i - 1) * math.pi / 6

        local Length = i % 2 == 0 and Smalllength or Longth
        local PosY = math.sin(Angle) * Length
        PosY = keepDecimalTest(PosY, 3)
        local PosX = math.cos(Angle) * Length
        PosX = keepDecimalTest(PosX, 3)
        local Index = "C" .. i
        PosAngleData[Index] = Vector3(PosX, PosY, 0)
    end
    return PosAngleData
end


this.ShowTurnTableItem = function()

    TurnTransformTable = {}
    positionGroup = {}
    CirclePosItem = {}
    local angleGroup = { Vector3(32.5, 56.3, 0), Vector3(65, 0, 0), Vector3(32.5, -56.3, 0), Vector3(-32.5, -56.3, 0), Vector3(-65, 0, 0), Vector3(-32.5, 56.3, 0) }
    local haveItem = 0
    local selectPoinr = Vector3(selectItem.position.x, selectItem.position.y, selectItem.position.z + 1)
    for index, value in ipairs(angleGroup) do
        local obj = RaycastTool.GetRayInfo(selectItem.position, value, 30, "Obs");
        if (obj ~= nil) then
            haveItem = haveItem + 1
            CirclePosItem[obj.name] = { name = obj.name, Angles = value, index = 0 }
        else
        end
    end
    constanGroup = {}
    for index, value in pairs(CirclePosItem) do
        local TurnItem = turnPropRoot:Find(value.name)
        table.insert(TurnTransformTable, TurnItem)
        local constantItem = TurnItem:Find("Content")
        table.insert(constanGroup, constantItem)
        TurnItem:SetParent(selectItem)
        table.insert(positionGroup, TurnItem.localPosition)

    end

    if haveItem < 6 then
        CircleStartAngle = 0
        CircleEndAngle = -30
        CircleStartAngle = CircleStartAngle * clockwise
        CircleEndAngle = CircleEndAngle * clockwise
        this.CircleHalfTweener()
    else
        CircleStartAngle = 0
        CircleEndAngle = -60
        CircleStartAngle = CircleStartAngle * clockwise
        CircleEndAngle = CircleEndAngle * clockwise
        this.CircleItemRootTweener()
    end
    this.ChangeArrowPos(true)


end

this.CircleHalfTweener = function()
    CircleItemTweener = DOTWeen.To(function() return CircleStartAngle end, function(vector)

        selectItem.localEulerAngles = Vector3(0, 0, vector)
        for index, value in ipairs(constanGroup) do
            value.localEulerAngles = Vector3(0, 0, -vector)
        end
    end, CircleEndAngle, 0.5)

    CircleItemTweener.onComplete = function()
        if CircleStartAngle < 0 then
            this.changeParenAndPos()
        end
        CircleStartAngle = -30
        CircleEndAngle = 0
        CircleStartAngle = CircleStartAngle * clockwise
        CircleEndAngle = CircleEndAngle * clockwise
        this.CircleItemRootTweener()
        this.ChangeArrowPos(false)

    end
end

this.CircleItemRootTweener = function()

    local startCloseArrow = false

    CircleItemTweener = DOTWeen.To(function() return CircleStartAngle end, function(vector)

        selectItem.localEulerAngles = Vector3(0, 0, vector)
        for index, value in ipairs(constanGroup) do
            value.localEulerAngles = Vector3(0, 0, -vector)
        end
        if math.abs(vector - CircleStartAngle) > 45 and not OnPress and not startCloseArrow then
            startCloseArrow = true
            this.ChangeArrowPos(false)
        end
    end, CircleEndAngle, 0.5)
    CircleItemTweener:SetEase(Ease.Linear)
    CircleItemTweener.onComplete = function()
        startCloseArrow = false
        if not OnPress then
            CircleStartAngle = 0
            CircleEndAngle = -60
            coroutine_runner.start(function()
                coroutine_runner.wait(0.12)
                this.changeParenAndPos()
            end)
        else
            CircleStartAngle = OnPress and CircleStartAngle - 60 * clockwise or 0
            CircleEndAngle = OnPress and CircleEndAngle - 60 * clockwise or -60 * clockwise
            this.CircleItemRootTweener()


        end

    end
end


this.changeParenAndPos = function()
    for index, value in ipairs(constanGroup) do
        value:SetParent(selectItem)
    end
    for index, value in ipairs(TurnTransformTable) do
        value:SetParent(turnPropRoot)
        value.localEulerAngles = Vector3.zero
    end


    this.vm.data.turnValue = 0
    this.CheckSuccssfulPoint()

    for index = 1, #constanGroup, 1 do
        constanGroup[index]:SetParent(TurnTransformTable[index], true)
    end
    TurnTransformTable = {}
    selectItem.localEulerAngles = Vector3.zero

    CirclePosItem = {}
end


this.ChangeArrowPos = function(open)
    local startCode = open and 1 or 0.8
    local endCode = open and 0.8 or 1
    local tweener = DOTWeen.To(function() return startCode end, function(vector)
        for index, value in ipairs(TurnTransformTable) do
            value.localPosition = positionGroup[index] * vector
        end
    end, endCode, 0.1)
    tweener.onComplete = function()

    end
end


this.InitLineList = function()

end

this.PointerDown = function(eventData)

    local tarPos = LuaMgr.Screen2Local(eventData.position, turnPropRoot)
    tranparent:SetParent(turnPropRoot)
    local PointPos = Vector3(tarPos.x, tarPos.y, -5)
    tranparent.localPosition = PointPos
    local obj = RaycastTool.GetRayInfo(tranparent.position, Vector3(0, 0, 15), 10, "Obs");
    if (obj ~= nil) then
        if clickLimit then
            return
        end
        if this.complete then
            return
        end
        clickLimit = true
        OnPress = true
        selectItem = obj.transform:Find("CircleParent")
        this.ShowTurnTableItem()
    else
        return
    end
end

this.OnPointerUp = function(eventData)
    OnPress = false
end
this.OnEndDrag = function(eventData)

end
this.OnDrag = function(eventData)

end

this.InitConfigData = function(broadId)
    local configData = ConfigMgr.Config.GameBoardMap[broadId]

    for index, value in ipairs(configData.BoardBegin) do
        InitPosGroup[value[1]] = true
    end
    for index, value in ipairs(configData.BoardVic) do
        succssfulPointGroup[value] = true
    end
end



this.InitTurnTableList = function()



    local tempList = {}
    for index, value in ipairs(TestData) do
        if InitPosGroup[value] ~= nil then
            InitPosGroup[value] = index
        end
        local turentableitem = {
            name = value,
            id = value,
            icon = DefaultSprite,
            heroIcon = DefaultTexture,
            heroIconActive = InitPosGroup[value] ~= nil,
            heroIconNormal = false,
            succssfulPoint = false,
            pos = heroPos[value],
            currentPosKey = value,
            posItemX = heroPos[value].x,
            posItemY = heroPos[value].y,
            angles = Vector3.zero,
            Index = index
        }
        table.insert(tempList, turentableitem)
    end
    this.turentableData = table.Copy(tempList)
    this.vm.data.turnTableList = tempList
end


this.InitSuccssfuCheck = function()



    local Layer = { A = 1, B = 2, C = 3 }
    local tempList = {}
    for index, value in ipairs(TestData) do
        if succssfulPointGroup[value] ~= nil then
            local turentableitem = {
                name = value,
                id = value,
                icon = DefaultSprite,
                heroIcon = DefaultTexture,
                heroIconActive = true,
                pos = heroPos[value],
                currentPosKey = value,
                posItemX = heroPos[value].x,
                posItemY = heroPos[value].y,
                angles = Vector3.zero,
                Index = index
            }
            succssfulPointGroup[value] = index
            this.succDataList[value] = "0"
            table.insert(tempList, turentableitem)
        end
    end
    local SorttempList = {}
    local LineItemList = {}
    for index, value in ipairs(tempList) do
        local itemid = value.id
        local sortItem =        {
            sortindex = string.match(itemid, "%d+"),
            sortlayer = Layer[string.match(itemid, "%u")],
            position = value.pos
        }
        table.insert(SorttempList, sortItem)
    end
    table.sort(SorttempList, function(a, b)
        if a.sortlayer == b.sortlayer then
            return a.sortindex < b.sortindex
        else
            return a.sortlayer < b.sortlayer
        end
    end)
    local tableLeng = #SorttempList
    for i = 1, tableLeng, 1 do
        local linePosition
        local lineangles
        local LineLength
        local currentOne
        local nextOne
        if i + 1 <= tableLeng then
            currentOne = SorttempList[i].position
            nextOne = SorttempList[i + 1].position
            linePosition = 0.5 * (nextOne + currentOne)
            local V2angles = Vector2(nextOne.x - currentOne.x, nextOne.y - currentOne.y)
            local mealu = V2angles:SqrMagnitude()
            LineLength = math.sqrt(mealu)

            lineangles = math.atan(V2angles.y, V2angles.x) * 180 / math.pi
            local LineItem = {
                LineposItem = linePosition,
                Lineangles = Vector3(0, 0, lineangles),
                Linelength = Vector2(LineLength, 30),
                posx = V2angles.x,
                posy = V2angles.y,
            }
            table.insert(LineItemList, LineItem)
        end

    end
    this.vm.data.LineChildItemList = table.Copy(LineItemList)
    this.LineData = table.Copy(LineItemList)
    this.vm.data.TurnTitleList = table.Copy(tempList)
    this.vm.data.succssfulPoint = tempList
    LuaMgr.NextFrame(this.CheckSuccssfulPoint)
end




this.CheckSuccssfulPoint = function()
    local succssfulTab = {}
    local checkPointPos = table.Copy(InitPosGroup)
    local configData = ConfigMgr.Config.GameBoardMap[this.BoardId].BoardVic
    local succssfulNum = 0
    for key, value in pairs(succssfulPointGroup) do
        succssfulNum = succssfulNum + 1
    end
    local CompleteNum = 0
    local PlayJumpAnimation = false

    for key, value in pairs(succssfulPointGroup) do
        print("KEY是"..tostring(key));
        local PointItem = succssfulPoint:Find(key)
        print("PointItem"..tostring(PointItem.name))
        local obj = RaycastTool.GetRayInfo(PointItem.position, Vector3(0, 0, -15), 10, "Obs");
        if obj~=nil then
            print("OBJName"..tostring(obj.name))
        end
        print("OBJ空的")
        if (obj ~= nil) then
            if InitPosGroup[obj.name] ~= nil then
                succssfulTab[key] = obj.name
                local InitValue = InitPosGroup[obj.name]
                CompleteNum = CompleteNum + 1
                if this.turentableData[InitValue].id == obj.name then

                    this.vm.data.turnTableList[InitValue].heroIconActive = false
                    this.vm.data.turnTableList[InitValue].succssfulPoint = true
                    checkPointPos[obj.name] = nil
                end

            end
        else

        end
    end

    local pointNum = 0
    for _key, _value in pairs(succssfulTab) do
        pointNum = pointNum + 1
    end
    PlayJumpAnimation = this.ActionCheckSuccssful(succssfulTab, pointNum)
    for index, value in pairs(checkPointPos) do
        if value ~= nil then
            if this.vm.data.turnTableList[value].succssfulPoint then
                this.vm.data.turnTableList[value].heroIconActive = true
                this.vm.data.turnTableList[value].succssfulPoint = false
            end
        end
    end
    if PlayJumpAnimation then
        QSpineChatar:Play("victory", false, function()
            QSpineChatar:Play("idle", true, nil)
        end)
    end
    if succssfulNum == CompleteNum then
        this.NetDataSuccssful(true)
    end
    clickLimit = false
end


this.NetDataSuccssful = function(finish)

    local data = { ThemeId = this.themeId, EventType = this.eventType, IsPrize = finish }
    local Url = "board/finished"
    ApiMgr.Request(Url, data, true,
    function(result)
        local re = json.decode(result)
        if re.code == 0 then
            if type(re.result.Items) == "table" then
                local reward = re.result.Items
                for i, v in pairs(reward) do
                    local item = { ID = v.id, Count = v.count }
                    table.insert(this.Rewraditems, item);
                end
                this.complete = true
                this.vm.data.lineEffect = true
                this.vm.data.LineParentItemList = this.LineData
                if this.showTipsClode then
                    this.ShowRewardTips()
                end

                this.truntablecortine = coroutine_runner.start(function()
                    coroutine_runner.wait(1.5)
                    LuaMgr.HidePanel(UIName.MiniGameTurnTableViewModel)
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


this.ActionCheckSuccssful = function(tab, pointNum)
    local PlayAnimation = false
    local ChangeKeys = {}
    for key, value in pairs(this.succDataList) do
        if tab[key] == nil then
            local state = { needkey = key, needvalue = nil }
            table.insert(ChangeKeys, state)
        else
            if tab[key] ~= value then
                PlayAnimation = true
                local state = { needkey = key, needvalue = tab[key] }
                table.insert(ChangeKeys, state)
            end


        end
    end
    for index, value in ipairs(ChangeKeys) do
        if value.needvalue == nil then
            this.succDataList[value.needkey] = "0"
        else
            this.succDataList[value.needkey] = value.needvalue
        end
    end
    return PlayAnimation
end




this.closeAndAgainInit = function()
    LuaMgr.InvokeUIEventListeners(UIEventConst.CollectorEventPanelClose);
end


this.ShowRewardTips = function()
    if #this.Rewraditems ~= 0 then
        this.showTipsClode = false
        local value = this.Rewraditems[1]
        local config = ConfigMgr.Config.itemMap[value.ID];
        if (type(config) == "table") then
            this.vm.data.itemnum = "+" .. value.Count
            this.vm.data.itemIcon = LuaMgr.GetTexture(string.format(this.ITEM_ICON_PATH, value.ID));
            this.RewardObj:Play("MiniGamesRewardTip_1", 0, 0)
        end
        table.remove(this.Rewraditems, 1)
        if #this.Rewraditems ~= 0 then
            coroutine_runner.start(
            function()

                coroutine_runner.wait(3)
                this.ShowRewardTips()
            end
            )
        else
            this.showTipsClode = true
        end
    else
        this.showTipsClode = true
    end

end




this.InitQuestionAnswer = function()
    local characterId = DataMgr.Player.sex > 1 and "SCJ202" or "SCJ201"
    character3d = this.vm.behaviour.transform:Find("root/Middle/HeroPos/QSpine/Spine/3DObject")
    QSpineChatar = character3d:GetComponent("UISpineCharacter")
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



return vm({
    data = data,
    command = command,
    hook = hook
})