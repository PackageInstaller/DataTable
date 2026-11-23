






local WordiconPath = "Assets/_BundleResources/Images/ChineseWord/"
local this = {vm = nil}
local NewYearData
local CurrentDayInex
local newCurrentDay
local Painting
local cfgCheckInQuest
local RememberDays
local shareTextur
local data = {
    loadTexture = DefaultTexture,
    NewWriteTexture = DefaultTexture,
    AgainloadTexture = DefaultTexture,
    ChineseWorld1 = DefaultTexture,
    ChineseWorld2 = DefaultTexture,
    ChineseWorld3 = DefaultTexture,
    ChineseWorld4 = DefaultTexture,
    timeShowSprite = DefaultSprite,
    ChineseBrushBg = DefaultSprite,
    dayIndex = DefaultSprite,
    alphawriterTag = true,
    makesure = false,
    writerTag = false,
    MainPageTexture = DefaultTexture,
    DrawLocks = false,
    pageShow = false,
    ChineseBrushDemo = true,
    clear = false,
    shareBtn = false,
    needShowPanel = true
}
local command = {
    activityBarBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.loadSprite()
        end
    },
    activityBack = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.Back()

        end
    },
    shareBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if shareTextur ~= nil then

                this.vm.data.needShowPanel = false
                LuaMgr.ShowPanel("Laigu.ViewModel.SharePopupViewModel", "NY00001", shareTextur, this.CloseShareBtn)
            end
        end
    },
    activityClear = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.alphawriterTag = true
            this.vm.data.makesure = false
            this.vm.data.clear = false
            Painting.Begins = false
        end
    }
}
local hook = {
    before_awake = function(vm)
        this.vm = vm
        Painting =
            this.vm.behaviour.transform:Find("root/Middle/Middle/ChineseBrushOther/RawImage"):GetComponent("UIPainting")
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:UpdateTopBar("", this.ClosePanel)
            LuaMgr.RemoveUIEventListener(UIEventConst.BrushBegin, this.BrushBegin)
            LuaMgr.AddUIEventListener(UIEventConst.BrushBegin, this.BrushBegin)
            LuaMgr.RemoveUIEventListener(UIEventConst.ChineseBrush, this.SavePage)
            LuaMgr.AddUIEventListener(UIEventConst.ChineseBrush, this.SavePage)
            LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.ParseData)
            LuaMgr.AddUIEventListener(UIEventConst.HeartBeat, this.ParseData)
            this.ParseData()
            coroutine_runner.start(
                function()
                    coroutine_runner.wait(1)
                    this.vm.data.ChineseBrushDemo = true
                end
            )
        end
    end,
    before_deactive = function(vm)
        RememberDays = nil
        Painting:OnClickClear()
        this.vm.data.alphawriterTag = true
        this.vm.data.makesure = false
        this.vm.data.clear = false
        Painting.Begins = false
        this.vm.data.ChineseBrushDemo = false
        this.vm.data.shareBtn = false
        shareTextur = nil
        LuaMgr.RemoveUIEventListener(UIEventConst.BrushBegin, this.BrushBegin)
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.ParseData)
        LuaMgr.RemoveUIEventListener(UIEventConst.ChineseBrush, this.SavePage)
    end
}
this.CloseShareBtn = function()
    this.vm.data.shareBtn = true
    this.vm.data.needShowPanel = true
    RememberDays = nil
    this.ParseData()
end

this.ClosePanel = function()

    local re = ActivityMgr.ActivityRuning("newYear")
    if re == nil then
        LuaMgr.Back("cdkey")
    else
        LuaMgr.Back("newYear")
    end
end
this.BrushBegin = function()
    this.vm.data.alphawriterTag = false
    this.vm.data.makesure = true
    this.vm.data.clear = true
end

this.ParseData = function()
    cfgCheckInQuest = DataExHelper.Check_ConfigQuestEventByText("NewYear")
    table.sort(
        cfgCheckInQuest,
        function(a, b)
            return tonumber(a.id) < tonumber(b.id)
        end
    )
    this.NetData()
end

this.PointerDown = function(eventData)
    if not Painting.Locks and not this.vm.data.makesure then
        this.BrushBegin()
    end
end


this.NetData = function()
    local dataQuests = DataMgr.Player.quests
    local Netdata = {}
    for key, value in ipairs(cfgCheckInQuest) do
        table.insert(Netdata, dataQuests[value.id])
    end
    local groupId = ActivityMgr.groupKeyList[ActivityKey.newYear]
    local dataGroup_flower = DataMgr.Player.variables[groupId]
    local startTime = dataGroup_flower.startTime
    local endTime = os.date("*t", dataGroup_flower.expireTime)
    local NowTime = LuaMgr.Timestamp()
    CurrentDayInex =math.floor((NowTime - startTime) / 86400) + 1
    NewYearData = Netdata
    if RememberDays == nil then
        RememberDays = CurrentDayInex
        this.InitNewyaearData()
    elseif RememberDays ~= CurrentDayInex then
        RememberDays = CurrentDayInex
        this.InitNewyaearData()
        Painting:OnClickClear()

    end
end


this.SavePage = function(parames)
    for index, value in ipairs(NewYearData) do
        if index == CurrentDayInex then
            local function callBacks()
                local uid = DataMgr.Player.uid
                local Resulit = LuaMgr.SaveNeedTexture("/Resources/ChineseBrushWord", uid .. value.id, parames[0])
                if Resulit then
                    shareTextur = parames[0]
                    local WorldId = "ChineseWorld" .. index
                    this.vm.data[WorldId] = parames[0]
                    this.vm.data.makesure = false
                    this.vm.data.clear = false
                    this.vm.data.writerTag = true
                    Painting.Locks = true
                    HeroRedDataHelper.NewYearRed()
                    LuaMgr.InvokeUIEventListeners(UIEventConst.NewYearDataRefush)
                    this.SetShareBtnActive(true)
                end
            end
            local runing = ActivityMgr.ActivityRuning(ActivityKey.newYear)
            if runing then
                this.EX_Sign(value.group, callBacks)
            else
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("NewYearViewModel_0"))
            end
        end
    end
end
this.EX_Sign = function(groud_id, callBack)
    local askData = {groupId = groud_id}
    ApiMgr.Request(
        "ex/sign",
        askData,
        true,
        function(result)

            local re = json.decode(result)
            local data = json.encode(re.result)

            LuaMgr.ShowItemRewared(data)
            if (callBack ~= nil) then
                callBack()
            end
        end,
        nil,
        false
    )
end
this.InitNewyaearData = function()
    local LockBrush = false
    for index, value in ipairs(NewYearData) do
        local WorldId = "ChineseWorld" .. index
        local LoadLocal = false
        if value.state == 3 then
            local uid = DataMgr.Player.uid
            local Texture = LuaMgr.LoadNeedTexture(uid .. value.id .. ".png")
            if Texture == nil then
                LoadLocal = true
            else
                this.vm.data[WorldId] = Texture
                if index == CurrentDayInex then
                    shareTextur = Texture
                    LockBrush = Texture
                end
            end
        else
            LoadLocal = true
        end

        if LoadLocal then
            local LocaTexture = LuaMgr.GetTexture(WordiconPath .. "ui_hd_ydkb_txt" .. index .. ".png")

            if LocaTexture ~= nil then

                this.vm.data[WorldId] = LocaTexture
            else

            end
        end
    end
    if NewYearData[CurrentDayInex]~=nil and NewYearData[CurrentDayInex].state == 3 then
        Painting.Locks = true
        this.vm.data.MainPageTexture = nil
        this.vm.data.DrawLocks = false
        this.vm.data.pageShow = true
        this.vm.data.MainPageTexture = LockBrush
        this.vm.data.writerTag = true
        this.SetShareBtnActive(true)
    else
        Painting.Locks = false
        this.vm.data.DrawLocks = true
        this.vm.data.pageShow = false
        this.vm.data.writerTag = false
        this.SetShareBtnActive(false)
        LockBrush = false
    end

    if LuaMgr.GetSprite("NewYear", "ui_hd_ydkb_rq_txt" .. CurrentDayInex) ~= nil then
        this.vm.data.dayIndex = LuaMgr.GetSprite("NewYear", "ui_hd_ydkb_sz" .. CurrentDayInex)
        this.vm.data.timeShowSprite = LuaMgr.GetSprite("NewYear", "ui_hd_ydkb_rq_txt" .. CurrentDayInex)
        this.vm.data.ChineseBrushBg = LuaMgr.GetSprite("NewYear", "ui_hd_ydkb_txt" .. CurrentDayInex)

    end
end
this.RefushNewYearDay = function()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.newYear]
    local dataGroup_flower = DataMgr.Player.variables[groupId]
    local startTime = dataGroup_flower.startTime
    local NowTime = LuaMgr.Timestamp()
    local nowday = math.floor(NowTime / 86400)
    local startday = math.floor(startTime / 86400)
    newCurrentDay = nowday - startday == 0 and 1 or nowday - startday
    if newCurrentDay ~= CurrentDayInex then

        Painting:OnClickClear()
    end
end
this.SetShareBtnActive = function(active)
    local shareStatus = ConfigHelper.GetShareStatus("CloseNewYear");
    this.vm.data.shareBtn = shareStatus and active or false
end

this.ClearDraw = function()
end

this.OnBack = function()
end


return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)