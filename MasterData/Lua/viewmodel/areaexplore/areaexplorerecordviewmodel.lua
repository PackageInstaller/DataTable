local this = {vm = nil,eventId = nil,fileId = nil}

local currentMapId = ""
local optionIndex = -1
local contentRect = nil
local listContentRect = nil
local eventType = "204"
local areaEvent = nil
local areaSurvey = nil
local Details_AUDIO_PATH = "Assets/_BundleResources/Audio/newUI/window_S.mp3"
local scrollBarTween = nil

local data = {
    scroolPos = 0,
    details = false,
    fighting = false,
    novel = false,
    options = false,
    optionsAlpha = 0.0,
    eventRare = DefaultSprite,
    eventName = "",
    sceneryName = "",
    eventIntro = "",
    scrollBarAlpha = 0.0,
    scrollBarInteractable = true,
    preogressText = "",
    gotoBtn = false,
    mapItems = {{exploreId = "", mapState = false, notmapState = false, name = "", rare = DefaultSprite, address = "",isArrow = false}},
    countItems = {{countRara = DefaultSprite, countText = ""}},
    optionsItems = {{select = false, lineImage = Vector3.zero, arrow = Vector3.zero, notClick = false, itemSize = Vector2(360, 40),
                     optionsTitle = "", optionsText = "", isOpen = false}},
}

local command = {
    btnClickDetails = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.vm.data.details then
                this.vm.data.details = not this.vm.data.details
                this.vm.data.scrollBarInteractable = true 
            else
                this.OpenDetails(param)
            end
        end
    },
    btnClickClose = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.vm.behaviour.Params.Length > 1 then
                LuaMgr.Back()
            elseif this.vm.behaviour.Params.Length == 1 then
                LuaMgr.HidePanel(UIName.AreaExploreRecordViewModel)
                LuaMgr.ShowLuaPanel(UIName.AreaExploreViewModel, currentMapId)
            end
        end
    },
    btnClickFighting = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local areaEventData = PlayerAreaMgr.GetAreaEvent(areaEvent.area, areaEvent.id);
            if areaEvent == nil then
                return
            end
            BattlePrepareMgr.EnterBattlePrepare(areaEventData.id, areaEventData.eventParam)
            LuaMgr.HidePanel(UIName.AreaExploreRecordViewModel)
            AreaMapSceneMgr.isMapEnter = true;
        end
    },
    btnClickNovel = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)



            LuaMgr.PlayNovel(areaEvent.eventParam,
                    function()
                        FeatureManager.GotoPanel("2000")
                        LuaMgr.ShowLuaPanel(UIName.AreaExploreRecordViewModel,currentMapId)
                    end)
            LuaMgr.HidePanel(UIName.AreaExploreRecordViewModel)
            AreaMapSceneMgr.isMapEnter = true;
        end
    },
    openCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            if this.vm.data.optionsItems[index].isOpen then
                this.CloseItem(index)
            else
                this.OpenItem(index)
            end
            this.UpdateLayout(index)
        end
    },
    gotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.fileId == nil or this.fileId == "" then
                return
            end
            local panelInfo = FeatureManager.GetPanelInfo("4004")
            if FeatureManager.CheckFeatureStatus(panelInfo) then
                LuaMgr.ShowLuaPanel(UIName.JournalFileViewModel,"archives","102",this.fileId)
                LuaMgr.HidePanel(UIName.AreaExploreViewModel)
                LuaMgr.HidePanel(UIName.AreaExploreRecordViewModel)
            else
                local tipStr = FeatureManager.TipStr("4004")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
            end

        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        vm.behaviour.transform:Find("root/Middle/ScrollView"):GetComponent('ScrollRect').onValueChanged:AddListener(function(pos)
            if scrollBarTween ~= nil then
                scrollBarTween:Kill()
                scrollBarTween = nil
            end
            if this.vm.data.scrollBarAlpha ~= 1 then
                scrollBarTween = DOTWeen.To(
                        function()
                            return this.vm.data.scrollBarAlpha
                        end,
                        function(alpha)
                            this.vm.data.scrollBarAlpha = alpha
                        end,
                        1, 0.5)
                scrollBarTween.onComplete=function()
                    scrollBarTween = nil
                end
            end
            LuaMgr.AddTimer(TimerConst.AreaExploreRecordHideScrollBar, this.HideScrollBar, 2, 1, false)
        end)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then return end

        if contentRect == nil then
            contentRect = vm.behaviour.transform:Find("root/Middle/Details/EventType/Options/OptionsView/Viewport/Content"):GetComponent('RectTransform')
        end

        if listContentRect == nil then
            listContentRect = vm.behaviour.transform:Find("root/Middle/ScrollView/Viewport/Content"):GetComponent('RectTransform')
        end
        
        local offsetMax = listContentRect.offsetMax
        offsetMax.y = 0
        listContentRect.offsetMax = offsetMax
        
        this.vm.data.scroolPos = 1
        this.vm.data.scrollBarInteractable = true
        currentMapId = vm.behaviour.Params[0]
        areaSurvey = DataMgr.Player.areaExplores[currentMapId]
        this.eventId = this.vm.behaviour.Params.Length > 1 and vm.behaviour.Params[1] or ""
        this.InitMapView()
        this.InitMapCount()
        if this.vm.behaviour.Params.Length > 1 then
            LuaMgr.NextFrame(function()
                LuaMgr.NextFrame(function()
                    this.MovePosition()
                end)
            end)
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm.data.details = false
        areaEvent = nil
        LuaMgr.RemoveTimer(TimerConst.AreaExploreRecordHideScrollBar)
    end,
}

this.InitMapView = function()
    local tempList = {}
    local surveyEvents = ConfigAreaMgr.GetAreaMapSurveyEvent(currentMapId)
    if surveyEvents == nil or #surveyEvents == 0 then
        return
    end
    local mapItem = nil
    for i, item in ipairs(surveyEvents or {}) do

        mapItem = {
            exploreId = item.id,
            mapState = areaSurvey.completedExplores[item.id] ~= nil,
            notmapState = areaSurvey.completedExplores[item.id] == nil,
            name = LuaMgr.GetLangText(item.nameTextlan),
            rare = LuaMgr.GetSprite("ExploreRes", "ui_dc_jl_yp" .. item.rare .. item.rare),
            address = LuaMgr.GetLangText(item.ShowTextLan),isArrow = this.eventId == item.id,
        }
        table.insert(tempList, mapItem)
    end
    table.sort(tempList, function(a, b)
        if a.mapState == b.mapState then
            return a.exploreId < b.exploreId
        else
            return a.mapState and not b.mapState
        end
    end)
    this.vm.data.mapItems = tempList
end

this.InitMapCount = function()
    local surveyEvents = ConfigAreaMgr.GetAreaMapSurveyEvent(currentMapId)
    local tempList = {}
    local rareCount = {0, 0, 0, 0}
    local totalCount = {0, 0, 0, 0}
    local allRareCount = 0
    local allTotalCount = 0
    for i, v in ipairs(surveyEvents or {}) do
        totalCount[v.rare] = totalCount[v.rare] + 1
        if areaSurvey.completedExplores[v.id] then
            rareCount[v.rare] = rareCount[v.rare] + 1
        end
    end
    
    for i = 1, 4 do
        local countItem = {}
        countItem.countRara = LuaMgr.GetSprite("ExploreRes", "ui_dc_jl_yp" .. i)
        local countStr
        if rareCount[i] == totalCount[i] then
            countStr = "<color=#316C6A>%s</color>/%s"
        else
            countStr = "<color=#d12a2a>%s</color>/%s";
        end
        allRareCount = allRareCount + rareCount[i]
        allTotalCount = allTotalCount + totalCount[i]
        countItem.countText = string.format(countStr, rareCount[i], totalCount[i])
        table.insert(tempList, countItem)
    end
    this.vm.data.countItems = tempList
    
    this.vm.data.preogressText = string.format(LuaMgr.GetLangText("AreaExploreRecordViewModel_4"), allRareCount, allTotalCount)
end


this.MovePosition = function()
    local lineNum = 0
    for i = 1, #this.vm.data.mapItems do
        if this.vm.data.mapItems[i].exploreId == this.eventId then
            lineNum = math.floor(i / 3)
            break
        end
    end
    if lineNum <= 4 then return end
    local maxY = listContentRect.sizeDelta.y - 550
    local posY = (lineNum - 1) * 119
    local targetPos = posY > maxY and maxY or posY
    listContentRect.anchoredPosition = Vector2(0,targetPos)
end

this.OpenDetails = function(index)
    optionIndex = -1
    local tempId = this.vm.data.mapItems[index + 1].exploreId
    local areaExplore = ConfigMgr.Config.areaExplores[tempId]
    if areaExplore == nil then
        return
    end
    this.fileId = areaExplore.fileId
    this.vm.data.gotoBtn = areaExplore.fileId ~= ""
    areaEvent = ConfigMgr.Config.areaEvents[areaExplore.firstEventID]
    local eventType = areaEvent.type
    this.vm.data.novel = eventType == AreaEventType.AVG
    this.vm.data.fighting = eventType == AreaEventType.Battle
    this.vm.data.options = eventType == AreaEventType.Explore
    this.vm.data.eventRare = LuaMgr.GetSprite("ExploreRes", "ui_dc_lb_yp" .. areaExplore.rare)
    this.vm.data.eventName = LuaMgr.GetLangText(areaExplore.nameTextlan)
    this.vm.data.sceneryName = LuaMgr.GetLangText(areaExplore.ShowTextLan)
    this.vm.data.eventIntro = LuaMgr.GetLangText(areaExplore.exploreTextlan)
    this.vm.data.details = true
    this.vm.data.scrollBarInteractable = false
    AudioMgr.Singleton:PlayUISFX(Details_AUDIO_PATH);

    if eventType == AreaEventType.Explore then
        local eventConfig = ConfigMgr.Config.areaEvents[areaExplore.firstEventID]
        if eventConfig == nil then
            return
        end
        local strs = NumTool.split(eventConfig.eventParam, ';')
        local tempItemList = {}
        local tempItem = {}
        for tempIndex, item in ipairs(strs) do
            local reward = ConfigMgr.Config.areaRewardMap[item]
            if reward then
                local notClick = reward.TestShowLan ~= nil and reward.TestShowLan ~= ""
                tempItem = {
                    select = false, 
                    lineImage = Vector3.one, 
                    arrow = notClick and Vector3.one or Vector3.zero, 
                    notClick = notClick, 
                    itemSize = Vector2(360, 40),
                    optionsTitle = LuaMgr.GetLangText(reward.NameLan), 
                    optionsText = LuaMgr.GetLangText(reward.TestShowLan),
                    isOpen = false
                }
                table.insert(tempItemList, tempItem)
            end
        end
        this.vm.data.optionsItems = tempItemList
        this.vm.data.optionsAlpha = 0
        LuaMgr.NextFrame(function()
            this.vm.data.optionsAlpha = 1
            RectTool.RebuildLayoutImmediate(contentRect);
        end)
    end
end

this.UpdateLayout = function(index)
    if optionIndex ~= -1 then
        this.CloseItem(optionIndex)
    end
    if optionIndex == index then
        optionIndex = -1
    else
        optionIndex = index
    end
    RectTool.RebuildLayoutImmediate(contentRect);
end

this.OpenItem = function(index)
    this.vm.data.optionsItems[index].isOpen = true
    this.vm.data.optionsItems[index].select = true
    this.vm.data.optionsItems[index].lineImage = Vector3.zero 
    local openTr = contentRect:GetChild(index - 1):Find("Open"):GetComponent('RectTransform')
    RectTool.RebuildLayoutImmediate(openTr);
    this.vm.data.optionsItems[index].itemSize = openTr.sizeDelta
end

this.CloseItem = function(index)
    this.vm.data.optionsItems[index].isOpen = false
    this.vm.data.optionsItems[index].select = false
    this.vm.data.optionsItems[index].lineImage = Vector3.one
    this.vm.data.optionsItems[index].itemSize = Vector2(360, 40)
end

this.HideScrollBar = function()
    if scrollBarTween ~= nil then
        scrollBarTween:Kill()
        scrollBarTween = nil
    end
    scrollBarTween = DOTWeen.To(
            function()
                return this.vm.data.scrollBarAlpha
            end,
            function(alpha)
                this.vm.data.scrollBarAlpha = alpha
            end,
            0, 0.5)
    scrollBarTween.onComplete=function()
        scrollBarTween = nil
    end
end

return vm({
data = data,
command = command,
hook = hook,
})