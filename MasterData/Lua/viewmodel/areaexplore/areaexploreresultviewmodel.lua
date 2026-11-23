local this = { vm = nil }
local areaMap = nil
local areaExplore = nil
local selectIndex = -1
local eventId = ""
local chatIndex = 0
local showResultItemIndex = -1;
local isFirstShowPanel = false

local selectResultData = nil

local normalColorStr = "262429"
local specialColor = "C3C1AD"

local isOpenFromAreaMap = false
local currentMapId = nil

local BGTexPath = "Assets/_BundleResources/Images/ExplorePics/ui_dc_lb_tu%s.png"

local data = {
    typeIcon = DefaultSprite,
    typeText = "",
    chatTitle = "",
    chatContent = "",
    bgTex = DefaultTexture,
    showResult = false,
    resultText = "",
    chickenIcon = DefaultSprite,
    aniName = "",
    hideBackBtn = true,
    resultDatas = { { id = "", bg = DefaultSprite, type = DefaultSprite, title = "", address = "",
                      icon = DefaultSprite, isNew = false, isSelect = false, alpha = 0.0, animator = false} },
    resultChatDatas = { { id = "", msg = "" } },
}

local command = {
    backCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.AreaExploreResultViewModel)
            if not isOpenFromAreaMap then
                LuaMgr.ShowLuaPanel(UIName.AreaExploreViewModel, currentMapId)
            end
        end
    },
    deleteCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if selectIndex < 0 or selectIndex >= #this.vm.data.resultDatas then
                return
            end 

            local data = {
                ExploreID = this.vm.data.resultDatas[selectIndex + 1].id
            }
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, LuaMgr.GetLangText("AreaExploreResultViewModel_0"), function ()
                ApiMgr.Request("abandon_explore",data,true,function()
                    this.SetData(areaMap.area)
                end, nil, true)
            end, function()  end)
        end
    },
    leftCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            selectIndex = selectIndex - 1
            if selectIndex < 0 then
                selectIndex = #this.vm.data.resultDatas - 1
            end
            this.SelectResult()
        end
    },
    rightCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            selectIndex = selectIndex + 1
            if selectIndex >= #this.vm.data.resultDatas then
                selectIndex = 0
            end
            this.SelectResult()
        end
    },
    resultItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if selectIndex ~= param then
                selectIndex = param
                this.SelectResult()
            end
        end
    },
    chatItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local eventConfig = ConfigMgr.Config.areaEvents[eventId]
            if eventConfig == nil then
                return
            end

            chatIndex = param
            local resultChatData = this.vm.data.resultChatDatas[chatIndex + 1];
            if eventConfig.type == AreaEventType.AVG then
                LuaMgr.ClearNovel()
                local eventData = json.encode(eventConfig);
                LuaMgr.RunNovel(eventData, false, false)
                LuaMgr.HidePanel(UIName.AreaExploreResultViewModel)
                AreaMapSceneMgr.isExplore = true;
                LuaMgr.InvokeUIEventListeners(UIEventConst.AreaExploreRewardRefresh)

            elseif eventConfig.type == AreaEventType.Battle then
                local areaEventData = PlayerAreaMgr.GetAreaEvent(areaMap.area, resultChatData.id);
                if areaEventData == nil then
                    return
                end

                BattlePrepareMgr.EnterBattlePrepare(areaEventData.id, areaEventData.eventParam)
                LuaMgr.HidePanel(UIName.AreaExploreViewModel)
                LuaMgr.HidePanel(UIName.AreaExploreResultViewModel)
                AreaMapSceneMgr.isExplore = true;
                LuaMgr.InvokeUIEventListeners(UIEventConst.AreaExploreRewardRefresh)
            elseif eventConfig.type == AreaEventType.Explore then
                local data = {
                    EventID = eventId,
                    Selected = chatIndex
                }
                ApiMgr.Request("get_area_reward",data,true,this.GetAreaRewardResponse, nil, true)
            end
        end
    },
    MaskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showResult = false
            this.vm.data.hideBackBtn = true
            LuaMgr.SetDropReward(selectResultData, false);
            this.OnResultRefresh()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        math.randomseed(os.time())
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end

        this.vm.data.showResult = false
        this.vm.data.hideBackBtn = true
        isFirstShowPanel = true
        LuaMgr.AddUIEventListener(UIEventConst.AreaExploreResultRefresh, this.OnResultRefresh)
        local area = vm.behaviour.Params[0]
        currentMapId = area
        local exploreId = ""
        if vm.behaviour.Params.Length == 2 then
            exploreId = vm.behaviour.Params[1]
            isOpenFromAreaMap = true
        end
        this.SetData(area, exploreId)
        this.vm.data.aniName = "UI_AreaExploreResultPanel_01"
    end,
    before_deactive = function(vm)
        AreaMapSceneMgr.isExplore = false;
        LuaMgr.RemoveUIEventListener(UIEventConst.AreaExploreResultRefresh, this.OnResultRefresh)

        for i = 1, #this.vm.data.resultDatas do
            this.vm.data.resultDatas[i].alpha = 0.0
            this.vm.data.resultDatas[i].animator = false
        end
    end,
}

this.OnResultRefresh = function(args)
    this.SetData(areaMap.area, "")
end

this.GetAreaRewardResponse = function(result)
    local data = this.vm.data.resultChatDatas[chatIndex + 1]
    if data == nil then
        return
    end
    
    local config = ConfigMgr.Config.areaRewardMap[data.id]
    if config == nil then
        return
    end

    local re=json.decode(result);
    local resultData=json.encode(re.result);
    AreaMapSceneMgr.isExplore = true;
    if config.TestShowLan and config.TestShowLan ~= "" then

        this.vm.data.resultText = LuaMgr.GetLangText(config.TestShowLan)
        this.vm.data.showResult = true
        this.vm.data.chickenIcon = LuaMgr.GetSprite("ExploreRes", "ui_dc_lb_ji" .. math.random(1, 3))
        selectResultData = resultData

        this.vm.data.aniName = "UI_AreaExploreResultPanel_02"
        this.vm.data.hideBackBtn = false
    else

        LuaMgr.SetDropReward(resultData, false);
        this.OnResultRefresh()
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.AreaExploreRewardRefresh)
end

this.SetData = function(area, exploreId)
    areaMap = ConfigMgr.Config.areas[area]
    if not areaMap then
        return
    end

    areaExplore = DataMgr.Player.areaExplores[area]
    if not areaExplore then
        return
    end

    if next(areaExplore.currentExplores or {}) == nil then
        LuaMgr.HidePanel(UIName.AreaExploreResultViewModel)
        return
    end

    this.SetResults(area)
    selectIndex = 0
    if exploreId and exploreId ~= "" then
        for i = 1, #this.vm.data.resultDatas do
            if this.vm.data.resultDatas[i].id == exploreId then
                selectIndex = i - 1
                break
            end
        end
    end
    this.SelectResult()
end

this.SetResults = function(area)
    local tempList = {}
    local areaExplores = ConfigMgr.Config.areaExplores
    local areaSurvey = DataMgr.Player.areaExplores[area]
    local index = 1
    for k, item in pairs(areaExplore.currentExplores) do
        if item.status == 0 then
            local exploreConfig = areaExplores[k]
            if exploreConfig == nil then
                return
            end
            
            local eventConfig = ConfigMgr.Config.areaEvents[exploreConfig.firstEventID]
            if eventConfig == nil then
                return
            end

            local titleColorStr = exploreConfig.rare == 4 and specialColor or normalColorStr
            local data = {
                id = k,
                bg = LuaMgr.GetSprite("ExploreRes", "ui_dc_lb" .. exploreConfig.rare),
                type = LuaMgr.GetSprite("ExploreRes", "ui_dc_lb_icon" .. exploreConfig.rare),
                title = string.format("<color=#%s>%s</color>", titleColorStr ,LuaMgr.GetLangText(exploreConfig.nameTextlan)),
                address = LuaMgr.GetLangText(exploreConfig.ShowTextLan),
                isNew = areaSurvey.completedExplores[item.exploreId] == nil,
                isSelect = index == 1,
                alpha = 0.0,
                animator = false
            }
            if eventConfig.type == 1 then
                data.icon = LuaMgr.GetSprite("ExploreRes", "ui_dc_lb_jq" .. exploreConfig.rare)
            elseif eventConfig.type == 2 then
                data.icon = LuaMgr.GetSprite("ExploreRes", "ui_dc_lb_zd" .. exploreConfig.rare)
            elseif eventConfig.type == 3 then
                data.icon = LuaMgr.GetSprite("ExploreRes", "ui_dc_lb_jl" .. exploreConfig.rare)
            end
            index = index + 1
            table.insert(tempList, data)
        end
    end

    this.vm.data.resultDatas = tempList

    if isFirstShowPanel then
        isFirstShowPanel = false
        showResultItemIndex = -1
        LuaMgr.AddTimer(TimerConst.AreaExploreResultItemDelay, this.ShowResultItemAnim, 0.1, -1, false)
    else
        for i = 1, #this.vm.data.resultDatas do
            this.vm.data.resultDatas[i].alpha = 1.0
            this.vm.data.resultDatas[i].animator = true
        end
    end
end

this.ShowResultItemAnim = function()
    if showResultItemIndex <= #this.vm.data.resultDatas then
        if showResultItemIndex > 0 then
            this.vm.data.resultDatas[showResultItemIndex].alpha = 1.0
            this.vm.data.resultDatas[showResultItemIndex].animator = true
        end
        showResultItemIndex = showResultItemIndex + 1
        if showResultItemIndex > #this.vm.data.resultDatas then
            LuaMgr.RemoveTimer(TimerConst.AreaExploreResultItemDelay)
        end
    end
end

this.SelectResult = function()
    for i = 1, #this.vm.data.resultDatas do
        if i == (selectIndex + 1) then
            this.vm.data.resultDatas[i].isSelect = true
            this.SetChatMsg(this.vm.data.resultDatas[i].id)
        else
            this.vm.data.resultDatas[i].isSelect = false
        end
    end
end

this.SetChatMsg = function(id)
    local exploreConfig = ConfigMgr.Config.areaExplores[id]
    if exploreConfig == nil then
        return
    end
    this.vm.data.typeIcon = LuaMgr.GetSprite("ExploreRes", "ui_dc_icon" .. exploreConfig.showType)
    this.vm.data.typeText = LuaMgr.GetLangText(exploreConfig.ShowTextLan)
    this.vm.data.chatTitle = LuaMgr.GetLangText(exploreConfig.nameTextlan)
    this.vm.data.chatContent = LuaMgr.GetLangText(exploreConfig.exploreTextlan)
    eventId = exploreConfig.firstEventID

    local completedAreaEvent = DataMgr.Player.completedAreaEvents[eventId]
    if completedAreaEvent then
        eventId = exploreConfig.eventID
    end

    local eventConfig = ConfigMgr.Config.areaEvents[eventId]
    if eventConfig == nil then
        return
    end

    local tempList = {}
    if eventConfig.type == AreaEventType.AVG then
        table.insert(tempList, {
            id = eventConfig.eventParam,
            msg = LuaMgr.GetLangText("AreaExploreResultViewModel_1")
        })
    elseif eventConfig.type == AreaEventType.Battle then
        table.insert(tempList, {
            id = eventConfig.id,
            msg = LuaMgr.GetLangText("AreaExploreResultViewModel_2")
        })
    elseif eventConfig.type == AreaEventType.Explore then
        local strs = NumTool.split(eventConfig.eventParam, ';')
        for i, v in ipairs(strs) do
            local reward = ConfigMgr.Config.areaRewardMap[v]
            if reward then
                table.insert(tempList, {
                    id = v,
                    msg = LuaMgr.GetLangText(reward.NameLan)
                })
            end
        end
    end

    this.vm.data.resultChatDatas = tempList
    this.vm.data.bgTex = LuaMgr.GetTexture(string.format(BGTexPath, exploreConfig.photoType))
end

return vm({
    data = data,
    command = command,
    hook = hook,
})