





local this = {
    vm = nil,isPreview = false,isAuto = false,isUpLevel = nil,
    tableInsert = table.insert,callBack = nil,

    diceRoot = nil,choose_diceRoot = nil,coroutine_key = nil,autoDiceCount = nil,
    index_1 = nil,isClose = nil,
    chooseIndex = nil,
    defaultPosition = {Vector2(-1.3,73.6),Vector2(-64.7,-36),Vector2(62.7,-35.8)},
    targetPosition = {Vector2(-1.3,96),Vector2(-82.5,-46.9),Vector2(82.5,-46.9)},
}

local data = {
    titleText = "",tipText = "",
    auto = false,

    a_dice = false,

    a_chooseDice = false,

    a_resultDice = false,
    a_resultDice_Icon_1 = DefaultSprite,

    
    controls = false,
    controlsTipText = "",
    scheduleText = "",
    c_dice_1 = false,
    c_dice_2 = false,
    c_chooseDice_1 = false,
    c_chooseDice_2 = false,
    confirmObj = false,
    c_diceList = {{img = DefaultSprite},{img = DefaultSprite},{img = DefaultSprite},{img = DefaultSprite},{img = DefaultSprite},{img = DefaultSprite}},
    c_chooseList = {{isShow = false},{isShow = false},{isShow = false},{isShow = false},{isShow = false},{isShow = false}},
    c_diceChooseList = {{img = DefaultSprite},{img = DefaultSprite},{img = DefaultSprite},{img = DefaultSprite},{img = DefaultSprite},{img = DefaultSprite}},
    c_dice_Position = {{pos = Vector2.zero},{pos = Vector2.zero},{pos = Vector2.zero}},
    scheduleList = {{nowImg = false,isDown = false,isUp = false}},
    showEffect=false,
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.isPreview or this.isClose then
                local level_1 = DataMgr.Player.practices.grades[tostring(this.index_1)]

                if not this.isPreview then
                    LuaMgr.ShowLuaPanel(UIName.CollectorPracticeChooseBuffViewModel,level_1,this.callBack)
                end
                LuaMgr.HidePanel(UIName.CollectorPracticeStateViewModel)
            end
        end
    },
    diceLevelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param)
            if not this.vm.data.confirmObj then
              return;  
            end
            if this.chooseIndex == index then 
                this.RevertDiceState();
                return;
            end
            local beforeIndex = nil
            local afterIndex = nil
            if this.chooseIndex ~= nil and this.chooseIndex ~= 0 then
                beforeIndex = this.chooseIndex % 3 == 0 and 3 or this.chooseIndex % 3
            end
            this.chooseIndex = index
            afterIndex = this.chooseIndex % 3 == 0 and 3 or this.chooseIndex % 3
            this.AnimatorChoose(beforeIndex,afterIndex)
            this.vm.data.c_chooseDice_1 = index <= 3
            this.vm.data.c_chooseDice_2 = index > 3
            this.vm.data.c_dice_1 = not this.vm.data.c_chooseDice_1
            this.vm.data.c_dice_2 = not this.vm.data.c_chooseDice_2
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.ConfirmChooseDiceLevel()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.GetDiceNode()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
        this.SetLanguageText()
    end,
    refresh = function(vm)
        this.InitParameter()
        this.SetLanguageText()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if not this.isPreview and not this.isAuto and this.callBack ~= nil then
            this.callBack()
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.NeedRefreshState);
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()
    LuaMgr.RemoveTimer(TimerConst.PracticeAutoDice)
    LuaMgr.RemoveTimer(TimerConst.PracticeStateClose)
end

this.RevertDiceState=function ()
    this.vm.data.c_dice_1 = true
    this.vm.data.c_dice_2 = true
    this.vm.data.c_chooseDice_1 = false
    this.vm.data.c_chooseDice_2 = false
    this.chooseIndex=nil;
end


this.InitParameter = function()
    this.chooseIndex = 0
    this.isClose = false
    this.autoDiceCount = 30

    this.isPreview = this.vm.behaviour.Params[0]

    this.isAuto = this.vm.behaviour.Params[1]
    this.callBack = this.vm.behaviour.Params[2]

    this.isUpLevel = this.vm.behaviour.Params[3]
    this.vm.data.a_resultDice = false
this.vm.data.showEffect=false;
    if this.isPreview then
        this.InitDiceLevel()
    else
        if this.isAuto then
            this.InitChooseDiceLevel()
            this.vm.data.a_dice = false
            this.vm.data.a_chooseDice = true
            if this.coroutine_key ~= nil then
                coroutine_runner.stop(this.coroutine_key)
            end
            this.coroutine_key = coroutine_runner.start(function()
                coroutine_runner.wait(0.5)
                this.AutoChooseDiceLevel()
                coroutine_runner.wait(this.autoDiceCount * 0.14)
                this.vm.data.a_chooseDice = false

                local sprite = nil
                sprite = LuaMgr.GetSprite("CollectorPracticeState","4_"..DataMgr.Player.practices.grades[tostring(this.index_1)])
                this.vm.data.a_resultDice_Icon_1 = sprite


                this.vm.data.a_resultDice = true
this.vm.data.showEffect=true;
                coroutine_runner.wait(0.3)
                this.isClose = true
            end)
        else
            this.vm.data.confirmObj = true
            this.InitControls()

            for i = 1, #this.vm.data.c_dice_Position do
                this.vm.data.c_dice_Position[i].pos = this.defaultPosition[i]
            end
            this.vm.data.c_dice_1 = true
            this.vm.data.c_dice_2 = true
            this.vm.data.c_chooseDice_1 = false
            this.vm.data.c_chooseDice_2 = false
            this.InitControlsSchedule()
        end
    end
    this.vm.data.auto = this.isPreview or this.isAuto
    this.vm.data.a_dice = this.isPreview
    this.vm.data.controls = not this.isPreview and not this.isAuto
    
end


this.InitDiceLevel = function()
    local nodeName = nil
    local sprite = nil
    for i = 1, #this.diceRoot do
        nodeName = this.diceRoot[i].name
        sprite = LuaMgr.GetSprite("CollectorPracticeState",nodeName.."_"..DataMgr.Player.practices.grades[tostring(i)])
        this.diceRoot[i].sprite = sprite
    end
end

this.InitChooseDiceLevel = function()
    local nodeName = nil
    local sprite = nil
    local chooseSprite = nil
    for i = 1, #this.choose_diceRoot do
        nodeName = this.choose_diceRoot[i].diceSprite.name
        sprite = LuaMgr.GetSprite("CollectorPracticeState",nodeName.."_"..DataMgr.Player.practices.grades[tostring(i)])
        chooseSprite = LuaMgr.GetSprite("CollectorPracticeState","choose_"..nodeName.."_"..DataMgr.Player.practices.grades[tostring(i)])
        this.choose_diceRoot[i].diceSprite.sprite = sprite
        this.choose_diceRoot[i].chooseSprite.sprite = chooseSprite
        SetActive(this.choose_diceRoot[i].choose,false)
    end
end

this.InitControls = function()
    local sprite = nil
    local chooseSprite = nil
    local index = 1
    for i = 1, #this.vm.data.c_diceList do
        sprite = LuaMgr.GetSprite("CollectorPracticeState",index.."_"..DataMgr.Player.practices.grades[tostring(i)])
        chooseSprite = LuaMgr.GetSprite("CollectorPracticeState","choose_"..index.."_"..DataMgr.Player.practices.grades[tostring(i)])
        this.vm.data.c_diceList[i].img = sprite
        this.vm.data.c_diceChooseList[i].img = chooseSprite
        index = index >= 3 and 1 or index + 1
    end
end

this.InitControlsSchedule = function()
    local tempList,tempItem = {},{}
    local tempData = DataMgr.Player.practices.eventinfos
    if TableIsNull(tempData) then
        tempData = {}
    end
    for i = 1, 8 do
        tempItem = {
            nowImg = i == #tempData,
            isDown = tempData[i] ~= nil and not tempData[i].win,
            isUp = tempData[i] ~= nil and tempData[i].win}
        this.tableInsert(tempList,tempItem)
    end
    this.vm.data.scheduleList = tempList
end

this.AnimatorChoose = function(beforeIndex,afterIndex)
    for i = 1, #this.vm.data.c_chooseList do
        this.vm.data.c_chooseList[i].isShow = i == this.chooseIndex
    end
    if beforeIndex ~= nil then
        this.vm.data.c_dice_Position[beforeIndex].pos = this.defaultPosition[beforeIndex]
    end
    this.vm.data.c_dice_Position[afterIndex].pos = this.targetPosition[afterIndex]
end


this.AutoChooseDiceLevel = function()
    math.randomseed(tostring(os.time()):reverse():sub(1, 5))
    local indexList_1 = {1,3,2,5,4,6}
    this.index_1 = indexList_1[math.random(1, #indexList_1)]

    
    LuaMgr.RemoveTimer(TimerConst.PracticeAutoDice)
    LuaMgr.AddTimer(TimerConst.PracticeAutoDice,function()
        this.index_1 = this.index_1 >= 6 and 1 or this.index_1 + 1

        for i = 1, #this.choose_diceRoot do
            SetActive(this.choose_diceRoot[i].choose,i == this.index_1)
        end
    end,0.1,this.autoDiceCount,false)
end


this.ConfirmChooseDiceLevel = function()
    if this.chooseIndex == nil or this.chooseIndex == 0 then
        local str = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7139"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,str)
        return
    end
    local nowLevel = DataMgr.Player.practices.grades[tostring(this.chooseIndex)]
    local afterLevel = this.isUpLevel and nowLevel + 1 or nowLevel - 1
    local tipStr = ""
    if afterLevel >= 4 or afterLevel <= 0 then
        tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7140"].NameLan)
        this.RevertDiceState();
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr);
        return;
    else
        this.SendDiceLevel(afterLevel)
    end
end

this.SendDiceLevel = function(level)
    this.vm.data.confirmObj = false
    local tempData = {}
    if level > 3 then
        level = 3
    elseif level < 1 then
        level = 1
    end
    tempData["GradeId"] = tostring(this.chooseIndex)
    tempData["Grade"] = level
    ApiMgr.Request("practice/upGrade", tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            this.InitControls()
            LuaMgr.RemoveTimer(TimerConst.PracticeStateClose)
            LuaMgr.AddTimer(TimerConst.PracticeStateClose,function()
                LuaMgr.RemoveTimer(TimerConst.PracticeStateClose)
                LuaMgr.HidePanel(UIName.CollectorPracticeStateViewModel)
            end,1,1,false)
        end
    end,nil,true)
end


this.SetLanguageText = function()
    if this.isPreview then
        this.vm.data.titleText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7118"].NameLan)
        this.vm.data.tipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7123"].NameLan)
    elseif not this.isPreview and this.isAuto then
        this.vm.data.titleText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7117"].NameLan)
        this.vm.data.tipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7123"].NameLan)
    elseif not this.isPreview and not this.isAuto then

        if this.isUpLevel then
            this.vm.data.titleText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7115"].NameLan)
            this.vm.data.controlsTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7119"].NameLan)
        else
            this.vm.data.titleText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7116"].NameLan)
            this.vm.data.controlsTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7120"].NameLan)
        end
        this.vm.data.tipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7122"].NameLan)
        this.vm.data.scheduleText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7121"].NameLan)
    end
end

this.GetDiceNode = function()
    local parentTran = this.vm.behaviour.transform:Find("root/Middle/Auto"):GetComponent("Transform")
    local parent,objectName,tempNode = nil,"A_Dice_",nil
    this.diceRoot = {}
    for i = 1, 2 do
        parent = parentTran:Find(objectName..i.."/Box"):GetComponent("Transform")
        for j = 1, parent.childCount do
            tempNode = parent:Find(j):GetComponent("Image")
            this.tableInsert(this.diceRoot,tempNode)
        end
    end
    this.choose_diceRoot = {}
    parent,objectName,tempNode = nil,"A_ChooseDice_",nil
    for i = 1, 2 do
        parent = parentTran:Find(objectName..i.."/Box"):GetComponent("Transform")
        for j = 1, parent.childCount do
            tempNode = {}
            tempNode.diceSprite = parent:Find(j):GetComponent("Image")
            tempNode.choose = parent:Find(j.."/Choose").gameObject
            tempNode.chooseSprite = parent:Find(j.."/Choose"):GetComponent("Image");
            this.tableInsert(this.choose_diceRoot,tempNode)
        end
    end
    parentTran,parent,objectName,tempNode = nil,nil,nil,nil
end

return vm({
    data = data,
    command = command,
    hook = hook
})