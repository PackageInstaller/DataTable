






TestAutoBattleViewModel = TestAutoBattleViewModel or {}
local this = TestAutoBattleViewModel
TestAutoBattleMgr = TestAutoBattleMgr or {}
this.nextCapter = this.nextCapter or 1
this.nextStageIdx = this.nextStageIdx or 1

function TestAutoBattleMgr.ReStartBattle()
    if not this.bInited or not this.enterBattleData then
        return false
    end

    PlayerAreaMgr.SetAreaDungeonId("-1");
    ApiMgr.Request("enter_dungeon", this.enterBattleData.enterParm, true,function(result)
        local re = json.decode(result)
        this.AddCITIAO(re, this.enterBattleData.stageInfo)
        local data=json.encode(re.result);
        LuaMgr.EnterBattle(data, "");

        local count = 0
        local speed = tonumber(this.vm.data.speed)
        speed = (speed and speed > 0) and speed or 1
        LuaMgr.AddTimer(TimerConst.TestAutoBattleEnterBattleEx + 1, function()
            count = count + 1
            if UnityEngine.Time.timeScale == speed and count > 15 then
                LuaMgr.RemoveTimer(TimerConst.TestAutoBattleEnterBattleEx + 1)
                return
            end
            CS.UnityEngine.Application.targetFrameRate = 1000
            UnityEngine.Time.timeScale = speed
        end, 1, -1, true)
    end,function(failCode)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TestAutoBattleViewModel_31"))
        this.onEnterBattle = false
    end,true)

    return true
end

local AllCapterStageIDs = {

    [1] = {
        'M100001',
        'M100002',
        'J100001',
        'M100003',
        'J100004',
        "M100004",
        "J100002",
        "M100005",
        "J100005",
        "M100006",
        "J100003",
        "M100007",
        "M100008",
        "D100001",
        "D100002",
        "D100003",
        "D100004",
    },
}

function this.EnterBattle()
    this.battleEixtEd = false
    LuaDebug.warn("onEnterBattle1")
    if this.onEnterBattle then
        LuaDebug.warn("onEnterBattle2")
        if this.NoGraphic then
            CS.UnityEngine.Application.targetFrameRate = 60
            UnityEngine.Time.timeScale = 1
            LuaMgr.RemoveTimer(TimerConst.TestAutoBattleEnterBattleEx + 1)
            LuaMgr.RemoveTimer(TimerConst.TestAutoBattleEnterBattle)
            LuaMgr.RemoveTimer(TimerConst.TestAutoBattleEnterBattleEx)
            CS.Laigu.Battle.Logic3.BattleLogic.Singleton:Exit()
            LuaMgr.LoadScene("Home")
            this.ClearEvent()
            this.onEnterBattle = false
            CS.Laigu.Battle.Logic3.BattleLogic.AutoTestBattle = false
        end
        return
    end

    local stageInfo = this.GenerateStage()
    if not stageInfo then
        LuaDebug.error("no stageInfo is nil")
        return
    end

    local selectChars = this.GenerateCharacter()
    if not this.CheckCharacterCount(selectChars) then
        return
    end

    if this.CheckMaxLoopTime() then
        return
    end
    
    this.EnterDungeon(this.currentStageInfo, selectChars)
end

function this.CheckCharacterCount(selectChars)
    local count = 0
    for i, v in pairs(selectChars) do
        count = 1
        break
    end
    if count <= 0 then
        LuaDebug.error("no select character")
        return false
    end
    return true
end

function this.CheckMaxLoopTime()
    local maxTimes = tonumber(this.vm.data.loopMaxTimes)
    LuaDebug.warn("CheckMaxLoopTime 1: " .. this.loopCount .. "_" .. (maxTimes or 0))
    if maxTimes and maxTimes > 0 and this.loopCount > maxTimes then
        LuaDebug.warn("CheckMaxLoopTime 2")
        CS.UnityEngine.Application.targetFrameRate = 60
        UnityEngine.Time.timeScale = 1
        LuaMgr.RemoveTimer(TimerConst.TestAutoBattleEnterBattleEx + 1)
        LuaMgr.RemoveTimer(TimerConst.TestAutoBattleEnterBattle)
        LuaMgr.RemoveTimer(TimerConst.TestAutoBattleEnterBattleEx)
        if CS.Laigu.Battle.Logic3.BattleLogic.Singleton then
            CS.Laigu.Battle.Logic3.BattleLogic.Singleton:Exit()
            LuaMgr.LoadScene("Home")
            LuaDebug.warn("CheckMaxLoopTime 3")
        end
        this.ClearEvent()
        this.onEnterBattle = false
        CS.Laigu.Battle.Logic3.BattleLogic.AutoTestBattle = false
        return true
    end

    if this.ManualStart then
        this.vm.data.loopMaxTimes = "1"
        this.loopCount = 2
    end
    return false
end

function this.EnterDungeon(stageInfo, selectChars)
    if not this.ManualStart then        
        this.battleType = LuaMgr.GetAreaBattleType()
        LuaMgr.SetAreaBattleType(BattleType.Delegate)

        CS.Laigu.Battle.Character.ML_InputAction.CheckStatus = 0
        CS.Laigu.Battle.Character.ML_InputAction.CheckStep = tonumber(this.vm.data.regretStep) or 1
        CS.Laigu.Battle.Character.ML_InputAction.CheckTarget = tonumber(this.vm.data.regretStep) or 1
        CS.Laigu.Battle.Logic3.BattleLogic.AutoTestRegretBattle = this.vm.data.isRegret

        CS.Laigu.Battle.Logic3.BattleLogic.AutoTestBattle = true
    else
        CS.Laigu.Battle.Logic3.BattleLogic.AutoTestBattle = false
    end

    this.NoGraphic = this.vm.data.isNoGraphic
    CS.Laigu.GameMain.Singleton.NoGraphic = this.NoGraphic

    this.onEnterBattle = true

    LuaMgr.RemoveTimer(TimerConst.TestAutoBattleEnterBattle)
    LuaMgr.RemoveTimer(TimerConst.TestAutoBattleEnterBattleEx)

    local askData={activeInfo={},members=selectChars};
    askData.eventId=stageInfo.id
    askData.dungeonId=stageInfo.id
    askData.teamId=""
    askData.isActive= false
    askData.battleType = ""

    askData.extraParams = nil

    if this.ManualStart then
        this.enterBattleData = {enterParm = askData, stageInfo = stageInfo}
        this.ManualStart = false
    end
    PlayerAreaMgr.SetAreaDungeonId("-1")
    ApiMgr.Request("enter_dungeon", askData, true,function(result)
        local re = json.decode(result)
        this.AddCITIAO(re, stageInfo)
        local data=json.encode(re.result);
        LuaMgr.EnterBattle(data, "");

        local count = 0
        local speed = tonumber(this.vm.data.speed)
        speed = (speed and speed > 0) and speed or 1
        LuaMgr.AddTimer(TimerConst.TestAutoBattleEnterBattleEx + 1, function()
            count = count + 1
            if UnityEngine.Time.timeScale == speed and count > 15 then
                LuaMgr.RemoveTimer(TimerConst.TestAutoBattleEnterBattleEx + 1)
                return
            end
            CS.UnityEngine.Application.targetFrameRate = 1000
            UnityEngine.Time.timeScale = speed
        end, 1, -1, true)
    end,function(failCode)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TestAutoBattleViewModel_31"))
        this.onEnterBattle = false
    end,true)
end

function this.AddCITIAO(re, stageInfo)
    if this.IsDungeonIDIsLeveling(stageInfo.id) then
        if this.vm.data.writeLog then
            CS.Laigu.Battle.BattleAutoLog.autoBattleLog = CS.UnityEngine.Application.persistentDataPath .. "/" .. this.vm.data.logFileName .. ".txt"
        end

        re.result.extraParams = {}
        local r = math.random(1,6)
        local idx = 0
        if this.selectCITIAOList then
            for k, v in pairs(this.selectCITIAOList) do
                if v then
                    table.insert(re.result.extraParams, v.Id)
                    idx = idx + 1
                    if idx >= r then
                        break
                    end
                end
            end 
        end
        if #re.result.extraParams <= 0 then
            re.result.extraParams = nil
        end
    end
end

function this.IsDungeonIDIsLeveling(stageID)
    if CS.Laigu.Battle.Logic3.BattleLogic.IsDungeonIDIsLeveling(stageID) then
        return true
    end

    if string.match(stageID,"MM") then
        return true
    end

    return false
end

function this.GenerateStage()
    this.currentStageInfo = this.GenerateSelectStages()
    return this.currentStageInfo





end

function this.GenerateCharacter()
    if not this.currentStageInfo then
        return {}
    end

    local selChars = this.GenerateLevelCharacter()
    if not selChars then
        selChars = this.GenerateSelectCharacter(this.currentStageInfo)
    end
    return selChars

end

function this.GenerateSelectStages()
    if not this.SelectStages or #this.SelectStages <= 0 then
        return
    end
    if this.nextStageIdx > #this.SelectStages then
        this.loopCount = this.loopCount + 1
        this.nextStageIdx = 1
    end

    local stageInfo = ConfigMgr.Config.dungeonMap[this.SelectStages[this.nextStageIdx].stageID]
    if not stageInfo then
        LuaDebug.error("no stage idx" .. this.nextStageIdx)
    end
    this.nextStageIdx = this.nextStageIdx + 1
    return stageInfo
end

function this.GenerateLevelCharacter()
    if not this.IsDungeonIDIsLeveling(this.currentStageInfo.id) then
        return
    end

    local teamCount = tonumber(this.vm.data.teamCount) or 1

    if this.nextCharacterIdx > #this.SelectCharacters then
        this.nextCharacterIdx = 1
        this.GenerateStage()
    end

    local chaList = {}
    local idx = 0
    for i = this.nextCharacterIdx, this.nextCharacterIdx + teamCount - 1, 1 do
        if i > #this.SelectCharacters then
            break
        end

        local character =  this.SelectCharacters[i]
        this.nextCharacterIdx = this.nextCharacterIdx + 1

        chaList[tostring(idx)] = character.characterID
        idx = idx + 1
    end

    this.nextStageIdx = this.nextStageIdx - 1




    

    return chaList
end

function this.GenerateSelectCharacter(stageInfo)
    if not this.SelectCharacters then
        return
    end
    local selectChars = {}
    local areadys = {}
    local idx = 0
    for i, v in pairs(stageInfo.limitOutRole) do
        local ac = ConfigMgr.Config.actor[v]
        if ac then
            selectChars[tostring(idx)] = ac.CharacterId
            idx = idx + 1
        end
    end

    local len = #this.SelectCharacters
    if len <= 0 then
        return selectChars
    end

    local remian = stageInfo.outRoleNum - idx
    for i = 1, remian do
        local count = 1
        while true do
            local id = math.random(1, len)
            local roleID = this.SelectCharacters[id].characterID
            if not areadys[id] then
                selectChars[tostring(idx)] = roleID
                areadys[id] = true
                idx = idx + 1
                break
            end

            count = count + 1
            if count > 100 then
                break
            end
        end
    end
    return selectChars
end

this.GenerateCapterStageEx = function()
    if not AllCapterStageIDs[this.nextCapter] then
        AllCapterStageIDs[this.nextCapter] = {}

        for i = 1, 100 do
            local stageID = "M" .. (this.nextCapter * 100000 + i)
            local stageInfo = ConfigMgr.Config.dungeonMap[stageID]
            if not stageInfo then
                break
            end
            table.insert(AllCapterStageIDs[this.nextCapter], stageID)
        end

        for i = 1, 100 do
            local stageID = "D" .. (this.nextCapter * 100000 + i)
            local stageInfo = ConfigMgr.Config.dungeonMap[stageID]
            if not stageInfo then
                break
            end
            table.insert(AllCapterStageIDs[this.nextCapter], stageID)
        end
    end

    local IDs = AllCapterStageIDs[this.nextCapter]
    if this.nextStageIdx > #IDs then
        this.nextStageIdx = 1
        this.nextCapter = this.nextCapter + 1
        if this.nextCapter > 3 then
            this.nextCapter = 1
        end
    end

    local stageInfo = ConfigMgr.Config.dungeonMap[IDs[this.nextStageIdx]]
    if not stageInfo then
        LuaDebug.error(area .. this.nextStageIdx)
    end
    this.nextStageIdx = this.nextStageIdx + 1
    return stageInfo
end

this.GenerateCapterStage = function()
    if not this.capterStageIDs then
        this.capterStageIDs = {}
        for i, v in pairs(ConfigMgr.Config.areaEvents) do
            this.capterStageIDs[v.area] = this.capterStageIDs[v.area] or {}
            if v.type == 2 and (not string.match(i, "T")) then
                table.insert(this.capterStageIDs[v.area], i)
            end
        end
    end

    local area = "laigu"
    for i, v in pairs(ConfigMgr.Config.areas) do
        if v.sortNum == this.nextCapter then
            area = i
        end
    end

    local IDs = this.capterStageIDs[area]
    if this.nextStageIdx > #IDs then
        this.nextStageIdx = 1
        this.nextCapter = this.nextCapter + 1
        if this.nextCapter > 3 then
            this.nextCapter = 1
        end
    end

    local stageInfo = ConfigMgr.Config.dungeonMap[IDs[this.nextStageIdx]]
    if not stageInfo then
        LuaDebug.error(area .. this.nextStageIdx)
    end
    this.nextStageIdx = this.nextStageIdx + 1
    return stageInfo
end

this.RandomPVGStage = function()
    local pvgStages = {}
    for i, v in ipairs(this.allStages) do
        local stageInfo = ConfigMgr.Config.dungeonMap[v]
        if stageInfo.preAVG ~= "" then
            table.insert(pvgStages, v)
        end
    end

    return this.RandomStage(pvgStages)
end

this.RandomStage = function(stageIDs)
    stageIDs = stageIDs or this.allStages
    local len = #stageIDs
    local id = math.random(1, len)
    local stageInfo = ConfigMgr.Config.dungeonMap[stageIDs[id]]
    return stageInfo
end

this.RandomCharacters = function(stageInfo)
    local selectChars = {}
    local areadys = {}
    local idx = 0
    for i, v in pairs(stageInfo.limitOutRole) do
        local ac = ConfigMgr.Config.actor[v]
        if ac then
            selectChars[tostring(idx)] = ac.CharacterId
            idx = idx + 1
        end
    end

    local len = #this.allCharacters
    local remian = stageInfo.outRoleNum - idx
    for i = 1, remian do
        local count = 1
        while true do
            local id = math.random(1, len)
            local roleID = this.allCharacters[id]
            if not areadys[id] and ConfigMgr.Config.characterTable[roleID].aimode ~= "" then
                selectChars[tostring(idx)] = roleID
                areadys[id] = true
                idx = idx + 1
                break
            end

            count = count + 1
            if count > 100 then
                break
            end
        end
    end
    return selectChars
end

local function ClickButton(path)
    local go = CS.UnityEngine.GameObject.Find(path)
    if not go then
        LuaDebug.warn("no go name:" .. path)
        return
    else
        LuaDebug.warn("find go name:" .. path)
    end

    local bu = go:GetComponent("UnityEngine.UI.Button")
    if bu then
        bu.onClick:Invoke()
    else
        LuaDebug.error("no UnityEngine.UI.Button type")
    end
end

this.ClearEvent = function()
    LuaMgr.RemoveUIEventListener(1001, this.OnShowPanel)
    LuaMgr.RemoveUIEventListener(2007, this.OnShowPopRet)
end

function this.OnShowPopRet(param)
    if this.NoGraphic then
        this.onEnterBattle = false
        this.ShowDataPanel(param[3] and param[3] or 0)
    end
    LuaDebug.warn("OnShowPopRet")
    ClickButton("UIRoot(Clone)/Popup/BattleWinPopup(Clone)/root/Middle/Reward/AllRewards/ButtonLayout/Exit")
    this.OnEventReal()
end

this.OnBattleEixt = function()
    local stateValue = UnityEngine.PlayerPrefs.GetInt("Stop_Delegate")
    if (stateValue >= 1) then
        LuaDebug.warn("中途退出不重连")
        this.ClearEvent()
        this.onEnterBattle = false
        CS.Laigu.Battle.Logic3.BattleLogic.AutoTestBattle = false
        UnityEngine.PlayerPrefs.SetInt("Stop_Delegate", 0)
        return
    end

    print("OnBattleEixt1")
    if this.battleEixtEd then
        return
    end
    print("OnBattleEixt")
    this.battleEixtEd = true
    CS.Laigu.Battle.Logic3.BattleLogic.AutoTestBattle = false
    LuaMgr.AddTimer(TimerConst.TestAutoBattleEnterBattleEx, this.EnterBattle, 0.5, 1)
end

this.OnShowPanel = function(args)
    if not args then
        this.ClearEvent()
        return
    end

    local len = args.Length
    if len < 1 then
        LuaDebug.error("no args")

        this.ClearEvent()

        return
    end

    local vmType = args[0]
    if string.match(vmType, "BattleDelegetingViewModel") then
        LuaMgr.HidePanel(vmType)
    end

    if string.match(vmType, "BattleMainViewModel") then
        LuaDebug.warn("onEnterBattle false")
        this.onEnterBattle = false
    end

    if string.match(vmType, "AreaMapViewModel") then
        this.OnBattleEixt()
        this.enterBattleData = nil
        LuaDebug.warn("AreaMapViewModel")
    end

    if string.match(vmType, "BattleLosePopupViewModel") then
        ClickButton("UIRoot(Clone)/Popup/BattleLosePopup(Clone)/root/Middle/Right/btns/Exit")

    end
end

function this.OnEventReal()
    LuaDebug.warn("OnEventReal")
    this.enterBattleData = nil
    local stateValue = UnityEngine.PlayerPrefs.GetInt("Stop_Delegate")

    if (stateValue >= 1) then
        LuaDebug.warn("中途退出不重连")
        this.ClearEvent()
        CS.Laigu.Battle.Logic3.BattleLogic.AutoTestBattle = false
        UnityEngine.PlayerPrefs.SetInt("Stop_Delegate", 0)
        return
    end

    if this.battleEixtEd then
        LuaDebug.warn("battleEixtEd is true")
        return
    end
    this.battleEixtEd = true
    LuaDebug.warn("OnEventReal2")
    CS.Laigu.Battle.Logic3.BattleLogic.AutoTestBattle = false
    if this.NoGraphic then
        this.EnterBattle()
    else
        LuaMgr.AddTimer(TimerConst.TestAutoBattleEnterBattle, this.EnterBattle, 1, 1)
    end
end


function this.ShowDataPanel(res)
    if not this.vm.data.isNoGraphic then
        return
    end

    LuaDebug.warn(res and 1 or 0)
    this.vm.data.isShowDataPanel = true
    local maxTimes = this.vm.data.loopMaxTimes == "" and LuaMgr.GetLangText("TestAutoBattleViewModel_32") or this.vm.data.loopMaxTimes
    this.vm.data.loopTimes = (this.loopCount) .. "/" .. maxTimes

    if res then
        if res == 0 then
            res = LuaMgr.GetLangText("TestAutoBattleViewModel_33")
        elseif res == 2 then            
            res = LuaMgr.GetLangText("TestAutoBattleViewModel_34")
        else
            res = LuaMgr.GetLangText("TestAutoBattleViewModel_35")
        end

        local name = this.SelectStages[this.nextStageIdx - 1].stageID .. ":" .. res
        table.insert(this.dataList, { name = name })
        this.vm.data.showDataList = table.Copy(this.dataList)
    end
end

function this.InitWindow()
    this.ClearEvent()
    LuaMgr.AddUIEventListener(1001, this.OnShowPanel)
    LuaMgr.AddUIEventListener(2007, this.OnShowPopRet)
    this.vm.data.randomStage = false
    this.vm.data.reconnection = false

    this.InitStageList()
    this.InitCharacterList(true)

    this.InitShowData()
end

function this.InitShowData()
    local mlai = PlayerPrefs.GetInt("CreateMLAI")
    this.vm.data.isMLAI = mlai == 1 and true or false

    this.vm.data.isRegret = CS.Laigu.Battle.Logic3.BattleLogic.AutoTestRegretBattle
    this.vm.data.regretStep = CS.Laigu.Battle.Character.ML_InputAction.CheckStep

    this.vm.data.writeLog = CS.Laigu.Battle.BattleAutoLog.AutoLogEnable

    this.vm.data.isRecommendLevel = false
    this.vm.data.recommendLevel = ""
    this.vm.data.isRandomLevel = true
    this.vm.data.randomLevel = ""
    this.vm.data.isDiffLevel = true
    this.vm.data.levelDiff = ""
    this.vm.data.isNoGraphic = false

    this.vm.data.isShowStageType = false
    this.vm.data.isShowDataPanel = false
    this.vm.data.loopTimes = "1"

    this.vm.data.showDataList = {}

    this.loopCount = 0
    this.loopCharacter = 0
end

function this.InitCharacterList(myself)
    this.allCharacters = {}
    local characters = ConfigMgr.Config.characterTable
    for i, v in pairs(characters) do
        table.insert(this.allCharacters, i)
    end

    local clist = {}
    local characters = myself and DataMgr.Player.characters or DataMgr.TestPlayer.characters
    local cha = {}
    for key, value in pairs(characters) do
        table.insert(cha, value)
    end

    table.sort(cha, function(a, b)
        return a.level < b.level
    end)

    local characterTable = ConfigMgr.Config.characterTable;
    for key, value in ipairs(cha) do
        local heroName = LuaMgr.GetLangText(characterTable[value.id].namelan);
        local obj = { name = value.id .. heroName .. "_" .. value.level }
        obj.characterID = value.id
        obj.level = value.level
        table.insert(clist, obj)
    end

    table.sort(clist, function(a, b)
        return a.characterID < b.characterID
    end)

    this.characterList = clist
    this.vm.data.characterList = table.Copy(clist)
    this.SelectCharacters = {}

    this.vm.data.selectCharacterList = {}
end

function this.OnCharacterSelect(vm, param)
    param = param + 1
    this.SelectCharacters = this.SelectCharacters or {}
    for index, value in ipairs(this.SelectCharacters) do
        if value == this.characterList[param] then
            return
        end
    end

    this.InsertSelectCharacters(this.characterList[param])
    this.vm.data.selectCharacterList = table.Copy(this.SelectCharacters)
end

function this.InsertSelectCharacters(cha)
    table.insert(this.SelectCharacters, cha)
end

function this.ClearSelectCharacters()
    this.SelectCharacters = {}
    this.vm.data.selectCharacterList = {}
end

function this.OnSelectCharacterList(vm, param)
    param = param + 1
    table.remove(this.SelectCharacters, param)
    this.vm.data.selectCharacterList = table.Copy(this.SelectCharacters)
end

function this.InitStageList()
    this.allStages = {}
    local dmap = ConfigMgr.Config.dungeonMap
    for i, v in pairs(dmap) do
        table.insert(this.allStages, i)
    end


    local list = {}
    this.stageTypeList = {}
    local dmap = ConfigMgr.Config.dungeonMap
    for index, dungeonData in pairs(dmap) do
        local obj = {}
        obj.name = index .. "_" .. dungeonData.name .. "_" .. dungeonData.levelShow
        obj.stageID = index
        obj.type = dungeonData.type
        this.stageTypeList[dungeonData.type] = this.stageTypeList[dungeonData.type] or {}
        table.insert(list, obj)
    end

    table.sort(list, function(a, b)
        return a.stageID < b.stageID
    end)

    this.levelStageType = 3
    this.stageTypeList[this.levelStageType] = {}

    for index, value in pairs(list) do
        local dungeonData = dmap[value.stageID]
        table.insert(this.stageTypeList[dungeonData.type], value)

        if this.IsDungeonIDIsLeveling(value.stageID) then
            table.insert(this.stageTypeList[this.levelStageType], value)
        end
    end

    this.stageList = table.Copy(list)
    this.vm.data.stageList = list
    this.SelectCharacters = {}
    this.vm.data.selectStageList = {}
    this.vm.data.stageTypeSelect = {}
end

function this.OnShowStageTypePanel(self)
    this.vm.data.isShowStageType = not this.vm.data.isShowStageType
    if this.vm.data.isShowStageType then
        local list = {}
        for key, value in pairs(this.stageTypeList) do
            local key1 = tonumber(key)
            local obj = { name = key, key = key }
            if key1 == 1 then
                obj.name = LuaMgr.GetLangText("TestAutoBattleViewModel_36")
            elseif key1 == 0 then
                obj.name = LuaMgr.GetLangText("TestAutoBattleViewModel_37")
            elseif key1 == 2 then
                obj.name = LuaMgr.GetLangText("TestAutoBattleViewModel_38")
            elseif key1 == this.levelStageType then
                obj.name = "LevelStage"
            end
            obj.name = obj.name .. "_" .. key
            table.insert(list, obj)
        end
        this.vm.data.stageTypeSelect = list
    end
end

function this.OnStageTypeSelect(vm, param)
    local a = this.vm.data.stageTypeSelect[param + 1]
    local list = {}
    for index, value in ipairs(this.stageTypeList[a.key]) do
        if a.key == 1 then
            if not string.match(value.stageID, "D")
                and not string.match(value.stageID, "CLAD")
                and not string.match(value.stageID, "T") then
                table.insert(list, value)
            end
        else
            table.insert(list, value)
        end
    end
    this.SelectStages = list
    this.vm.data.selectStageList = table.Copy(this.SelectStages)

    this.vm.data.isShowStageType = false
end

function this.OnStageSelect(vm, param)
    param = param + 1
    this.SelectStages = this.SelectStages or {}
    for index, value in ipairs(this.SelectStages) do
        if value == this.stageList[param] then
            return
        end
    end

    table.insert(this.SelectStages, this.stageList[param])
    this.vm.data.selectStageList = table.Copy(this.SelectStages)

    this.ShowRecommendLevel()
end

function this.OnSelectStageList(vm, param)
    param = param + 1
    table.remove(this.SelectStages, param)
    this.vm.data.selectStageList = table.Copy(this.SelectStages)

    this.ShowRecommendLevel()
end

function this.ShowRecommendLevel()
    if #this.SelectStages == 1 then
        local stageInfo = ConfigMgr.Config.dungeonMap[this.SelectStages[1].stageID]
        this.vm.data.isRecommendLevel = true
        this.vm.data.recommendLevel = stageInfo.levelShow

        local recommendLevel = tonumber(this.vm.data.recommendLevel)
        recommendLevel = (recommendLevel and recommendLevel > 0) and recommendLevel or 0
        if recommendLevel > 0 then
            this.vm.data.randomLevel = recommendLevel
        end

        this.ChangeSelectCharacterList()
    else
        if not this.vm.data.isRecommendLevel then
            return
        end
        this.vm.data.isRecommendLevel = false




    end
end

function this.OnMLAISelect(vm, isOn, param)
    if isOn then
        PlayerPrefs.SetInt("CreateMLAI", 1);
    else
        PlayerPrefs.SetInt("CreateMLAI", 0);
    end
end

function this.OnRegretSelect(vm, isOn, param)
    this.vm.data.isRegret = isOn
end

function this.OnRandomLevel(vm, randomLevel)
    this.ChangeSelectCharacterList()
end

function this.OnDiffLevel(vm, value)
    this.ChangeSelectCharacterList()
end

function this.OnSelectCITIAO(vm, param)
    this.vm.data.isShowCITIAO = true
    this.selectCITIAOList = this.selectCITIAOList or {}

    this.RefreshCITAIOPanel()
end

function this.RefreshCITAIOPanel()
    local ctList = {}
    for i,v in pairs(ConfigMgr.Config.moreModLawMap) do
        local name = CS.Laigu.Manager.LangManager.Singleton:GetData(v.LawNameLan)
        local isSelected = false
        if this.selectCITIAOList[v.Id] then
            isSelected = true
        end
        table.insert(ctList, {Id = v.Id, name = v.Id .. name, isSelected = isSelected})
    end

    table.sort(ctList, function (a,b)
        return a.name < b.name 
    end)

    this.vm.data.citiaoList = ctList
end

function this.OnCITIAOListTogole(vm, isOn, param)
    local citiao = this.vm.data.citiaoList[param+1]
    if isOn then
        this.selectCITIAOList[citiao.Id] = citiao
    else
        this.selectCITIAOList[citiao.Id] = nil
    end
end

function this.OnWriteLog(vm, isOn, param)
    CS.Laigu.Battle.BattleAutoLog.AutoLogEnable = isOn
end

function this.ChangeSelectCharacterList()
    local randomLevel = tonumber(this.vm.data.randomLevel)
    randomLevel = (randomLevel and randomLevel > 0) and randomLevel or 0

    if randomLevel <= 0 then
        return
    end

    local diffLevel = tonumber(this.vm.data.levelDiff)
    diffLevel = (diffLevel and diffLevel > 0) and diffLevel or 0

    this.ClearSelectCharacters()
    for key, value in pairs(this.characterList) do
        if value.level <= randomLevel + diffLevel and value.level >= randomLevel - diffLevel then
            this.InsertSelectCharacters(value)
        end
    end
    this.vm.data.selectCharacterList = table.Copy(this.SelectCharacters)
end

function this.InitUI(self)
    local ui = {}
    this.InitData(ui)
    this.InitCommand(ui)
    this.InitHook(ui)
    return ui
end

function this.InitData(ui)
    ui.data = {
        randomStage = true,
        reconnection = true,
        isMLAI = false,
        isNoGraphic = false,
        loopMaxTimes = "",

        inputAccount = "",
        logFileName = "autoBattleLog",

        isRecommendLevel = false,
        recommendLevel = "",
        isRandomLevel = false,
        randomLevel = "",
        isDiffLevel = false,
        levelDiff = "",
        writeLog = false,

        speed = "",
        teamCount = "",

        isRegret = false,
        regretStep = "",

        stageList = {
            {
                name = ""
            }
        },
        characterList = {
            {
                name = ""
            }
        },
        selectCharacterList = {
            {
                name = ""
            }
        },
        selectStageList = {
            {
                name = ""
            }
        },

        isShowStageType = false,
        stageTypeSelect = {
            {
                name = ""
            }
        },

        isShowDataPanel = false,
        loopTimes = "",
        showDataList = {
            {
                name = ""
            }
        },
        
        isShowCITIAO = false,
        citiaoList = {
            {
                isSelected = false,
                name = ""
            }
        }
    }
end

local function EnterCommandBattle()
    this.nextCapter = 1
    this.nextStageIdx = 1
    this.loopCount = 1
    this.loopCharacter = 1
    this.nextCharacterIdx = 1
    this.dataList = {}
    this.vm.data.showDataList = {}
    this.enterBattleData = nil
    this.EnterBattle()
    this.ShowDataPanel()
end
function this.InitCommand(ui)
    local commondNames = {
        EnterBattle = function(vm, param)
            EnterCommandBattle()
        end,
        ManualEnterBattle = function(vm, param)
            this.ManualStart = true
            EnterCommandBattle()
        end,
        HideSelf = function(vm, param)
            CS.Laigu.GameMain.Singleton.NoGraphic = false
            LuaMgr.HidePanel(UIName.TestAutoBattleViewModel)
        end,
        HideStageType = function()
            this.vm.data.isShowStageType = false
        end,
        HideDataPanel = function()
            if CS.Laigu.Manager.LoadingManager.Singleton.Loading then
                return
            end
            CS.UnityEngine.Application.targetFrameRate = 60
            UnityEngine.Time.timeScale = 1
            LuaMgr.RemoveTimer(TimerConst.TestAutoBattleEnterBattleEx + 1)
            if CS.Laigu.Battle.Logic3.BattleLogic.Singleton then
                CS.Laigu.Battle.Logic3.BattleLogic.Singleton:Exit()
            end
            LuaMgr.LoadScene("Home")
            this.onEnterBattle = false

            this.vm.data.isShowDataPanel = false
        end,
        HideCITIAOPanel = function()
            this.vm.data.isShowCITIAO = false
        end,
        GetPalyerData = function(vm, param)
            if this.vm.data.inputAccount == "" then
                return
            end
            CS.Laigu.Battle.Logic3.BattleLogic.AutoTestBattle = true
            CS.Laigu.Manager.DataManager.ParsePlayer = true
            CS.Laigu.Manager.ApiManager.Singleton.dataVersion = ""
            this.encryptToken = CS.Laigu.Manager.ApiManager.Singleton:GetEncryptToken()
            this.plainToken = CS.Laigu.Manager.ApiManager.Singleton:GetPlainToken()
            CS.Laigu.Manager.ApiManager.Singleton:SetTestToken(this.vm.data.inputAccount, "")

            ApiMgr.Request("login", {
                ApkVersion = "",
                Brand = "",
                Language = "",
                Manufacturer = "",
                PackageId = "",
                Platform = 0,
                Resolution = "",
                DeviceID = this.vm.data.inputAccount or "player1"
            }, true, function()
                CS.Laigu.Manager.DataManager.ParsePlayer = false
                print(this.encryptToken)
                print(this.plainToken)
                CS.Laigu.Manager.ApiManager.Singleton:SetTestToken(this.plainToken, this.encryptToken)
                this.InitCharacterList()
                this.InitShowData()
            end, function()
                CS.Laigu.Manager.ApiManager.Singleton:SetTestToken(this.plainToken, this.encryptToken)
                CS.Laigu.Battle.Logic3.BattleLogic.AutoTestBattle = false
                CS.Laigu.Manager.DataManager.ParsePlayer = false
            end, true, false);
        end,
        OnSelectAllCITIAO = function()
            for i,v in pairs(ConfigMgr.Config.moreModLawMap) do
                local name = CS.Laigu.Manager.LangManager.Singleton:GetData(v.LawNameLan)
                this.selectCITIAOList[v.Id] = {Id = v.Id, name = v.Id .. name, isSelected = true}
            end
            this.RefreshCITAIOPanel()
        end,
        OnCancelAllCITIAO = function()
            this.selectCITIAOList = {}
            this.RefreshCITAIOPanel()
        end,
        OnStageSelect = this.OnStageSelect,
        OnStageTypeSelect = this.OnStageTypeSelect,
        OnShowStageTypePanel = this.OnShowStageTypePanel,
        OnCharacterSelect = this.OnCharacterSelect,
        OnSelectStageList = this.OnSelectStageList,
        OnSelectCharacterList = this.OnSelectCharacterList,
        OnSelectCITIAO = this.OnSelectCITIAO,
        OnWriteLog = {this.OnWriteLog, XLuaCommandType.Bool},
        OnMLAISelect = { this.OnMLAISelect, XLuaCommandType.Bool },
        OnRandomLevel = { this.OnRandomLevel, XLuaCommandType.String },
        OnDiffLevel = { this.OnDiffLevel, XLuaCommandType.String },
        OnCITIAOListTogole = { this.OnCITIAOListTogole, XLuaCommandType.Bool },
        OnRegretSelect = {this.OnRegretSelect, XLuaCommandType.Bool}
    }

    ui.command = {}
    for i, v in pairs(commondNames) do
        local ctype = XLuaCommandType.Void
        if type(v) == "table" then
            ctype = v[2] or ctype
            v = v[1]
        end
        ui.command[i] = {
            type = ctype,
            execute = v
        }
    end
end

function this.Update()
    
end

function this.InitHook(ui)
    ui.hook = {
        before_awake = function(vm)
            this.vm = vm
            this.transform = vm.behaviour.transform
            this.behaviour = vm.behaviour
        end,
        before_active = function(vm)
            this.InitWindow()
            this.bInited = true

            LuaMgr.AddUpdate(this.Update);
        end,
        before_deactive = function(vm)
            LuaMgr.RemoveUpdate(this.Update)
        end,
        before_destroy = function(vm)
            LuaMgr.RemoveUpdate(this.Update)
        end
    }
end

return vm(
    this.InitUI()
)