




require("ViewModel/Terminal/JournalItemModel")
require("ViewModel/Terminal/NumberItemModel")
require("ViewModel/Terminal/TextItem")
require("ViewModel/Terminal/InsetItem")

local this = {
    vm = nil,panelType = nil,
    textConfig = nil,totalWidth = nil,
    tableInsert = table.insert,tableSort = table.sort, toNumber = tonumber,
    journalView = nil,journalTemplate = nil,
    numberView = nil,numberTemplate = nil,
periodNumber = nil,
    labelIndex = nil,
    isDelay = false,isClose = false, gotoId = nil,markersID = nil,
    textView = nil,
    textItemTemplate = nil,textItemTab = nil,
    insetItemTemplate = nil,insetItemTab = nil,
    BGPath = "Assets/_BundleResources/Images/ArchivesBg/"
}

local data = {
    labelList = {{icon = DefaultSprite,text = "",select = false,redPoint = false}},
    journalViewIsShow = false,detailsIsShow = false,
    iconTexture = DefaultTexture,bgTexture = DefaultTexture,
    rootAnimName = "",contentAinmName = "",
    detailsAnimName = "",gotoBtn = false,fileNameLan = "",
}

local command = {
    labelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not HeroParameter.JournalFileClick then return end
            local index = this.toNumber(param + 1)
            if this.labelIndex == index then return end
            this.SwitchLabel(index)
        end
    },
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.isClose then
                this.CloseDetails()
            end
        end
    },
    gotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.gotoId == "" then return end
            if ConfigMgr.Config.areaExplores[this.gotoId] == nil then return end
            HeroParameter.JournalGotoPanel = true
            LuaMgr.ShowLuaPanel(UIName.AreaExploreRecordViewModel, ConfigMgr.Config.areaExplores[this.gotoId].tab,this.gotoId)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.journalView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/JournalView").gameObject)
        this.journalTemplate = vm.behaviour.transform:Find("template/JournalItem").gameObject

        this.numberObject = vm.behaviour.transform:Find("root/Details/NumberView").gameObject
        this.numberView = UIScrollView.New(this.numberObject )
        this.numberTemplate = vm.behaviour.transform:Find("template/NumberItem").gameObject

        this.textView = vm.behaviour.transform:Find("root/Details/TextCont/TextView/View"):GetComponent("ScrollRect")
        this.textItemTemplate = vm.behaviour.transform:Find("template/TextItem").gameObject
        this.insetItemTemplate = vm.behaviour.transform:Find("template/InsetItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
        this.EmptyTextScroll()
    end,
    refresh = function(vm)
        this.Refresh()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("JournalItemModel")
        UIScrollView.ClearItem("NumberItemModel")
        this = nil
    end,
}

this.OnBack = function()
    if this.vm.data.detailsIsShow == true then
        this.EmptyTextScroll()
        this.vm.data.detailsIsShow = false
        this.isDelay = false
        this.CloseDetails()
    else
        LuaMgr.Back()
    end
end

this.AddUIEvent = function()
    LuaMgr.AddUIEventListener(UIEventConst.JournalArchivesClick, this.ItemClickEvent)
    LuaMgr.AddUIEventListener(UIEventConst.NumberItemClick, this.NumberClickEvent)
    LuaMgr.AddUIEventListener(UIEventConst.UpdateLabelGiftRed,this.SetLabelRedPoint)
    LuaMgr.AddUIEventListener(UIEventConst.ArchivesGotoAreaExplore,this.GotoAreaExplore)
end
this.RemoveUIEvent = function()
    this.textConfig = nil
    this.vm.data.labelList = {}
    this.journalView:Clear(false)
    this.numberView:Clear(false)
    this.vm.data.detailsIsShow = false
    HeroParameter.EmptyClickState()
    LuaMgr.RemoveTimer(TimerConst.FileCloseBook)
    LuaMgr.RemoveTimer(TimerConst.FileUpdateText)
    LuaMgr.RemoveTimer(TimerConst.FileCloseBookAnim)
    LuaMgr.RemoveTimer(TimerConst.JournalAnimFil)
    LuaMgr.RemoveUIEventListener(UIEventConst.JournalArchivesClick, this.ItemClickEvent)
    LuaMgr.RemoveUIEventListener(UIEventConst.NumberItemClick, this.NumberClickEvent)
    LuaMgr.RemoveUIEventListener(UIEventConst.UpdateLabelGiftRed,this.SetLabelRedPoint)
    LuaMgr.RemoveUIEventListener(UIEventConst.ArchivesGotoAreaExplore,this.GotoAreaExplore)
end


this.InitParameter = function()
    this.isDelay = false
    this.totalWidth = 1300 + LuaMgr.GetScreenAddWidth()
    this.labelIndex = 0
    this.panelType = this.vm.behaviour.Params[0]
    this.vm.behaviour:UpdateTopBar(this.panelType,this.OnBack)
    this.GetTextConfig()
    this.SetLabelView()
    this.SetLabelRedPoint()
    if #this.vm.data.labelList > 0 then
        if this.vm.behaviour.Params.Length > 1 then
            this.SwitchLabel(this.GetParamIndex())
            this.MovePosition()
        else
            this.SwitchLabel(1)
        end
    end
end

this.Refresh = function()
    if this.vm.behaviour.Params.Length > 1 then
        local tempId = this.vm.behaviour.Params[2]
        if this.markersID ~= tempId then
            this.PlayCloseBookAnim()
            for i = 1, #this.journalView.dataList do
                if this.journalView.dataList[i].data.data.ID == tempId then
                    this.journalView:MoveToIndex(i)
                    return
                end
            end
        end
    end
end

this.SetLabelView = function()
    this.vm.data.labelList = {}
    local tempList,tempItem = {},nil
    for key,value in pairs(this.textConfig) do
        if ConfigMgr.Config.LabelMap[key] ~= nil then
            tempItem = {
                icon = LuaMgr.GetSprite("JournaLabel",ConfigMgr.Config.LabelMap[key].Icon),
                text = LuaMgr.GetLangText(ConfigMgr.Config.LabelMap[key].MagazineTypeNameLan),
                select = false,sortStr = key,redPoint = false}
            this.tableInsert(tempList,tempItem)
        end
    end
    this.tableSort(tempList,this.LabelListSort)
    this.vm.data.labelList = tempList
end
this.SetLabelRedPoint = function()
    local config = nil
    local isLock,isShow = true,nil
    for i = 1, #this.vm.data.labelList do
        isShow = false
        for j = 1, #this.textConfig[this.vm.data.labelList[i].sortStr] do
            config = this.textConfig[this.vm.data.labelList[i].sortStr][j]
            if config.Unlock[1] == "1" then
                isLock = tonumber(config.Unlock[2]) > DataMgr.Player.level
            elseif config.Unlock[1] == "2" then
                isLock = DataMgr.Player.completedAreaEvents[config.Unlock[2]] == nil
            elseif config.Unlock[1] == "3" then
                isLock = this.GetState(config.Unlock[2])
            elseif config.Unlock[1] == "4" then
                isLock = this.GetAreaEventState(config.Unlock[2])
            end
            if this.panelType == "journal" then
                if not isLock then
                    isShow = type(DataMgr.Player.iceGorge.journalReward) == "function" or DataMgr.Player.iceGorge.journalReward[config.ID] == nil
                    if isShow then break end
                end
            elseif this.panelType == "archives" then
                if not isLock then
                    isShow = type(DataMgr.Player.iceGorge.archivesReward) == "function" or DataMgr.Player.iceGorge.archivesReward[config.ID] == nil
                    if isShow then break end
                end
            end
        end
        this.vm.data.labelList[i].redPoint = isShow
    end
end

this.SetJournalView = function(key)
    local tempConfig = this.textConfig[key]
    if tempConfig == nil then return end
    this.journalView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    for i = 1, #tempConfig do
        groupData = {}
        groupData.item = this.journalTemplate
        groupData.index = i
        groupData.data = tempConfig[i]
        scrollData = UIScrollData.GetData(this.journalTemplate,"JournalItemModel",372 - 100,512,groupData)
        this.tableInsert(scrollDatas,scrollData)
    end
    this.journalView:SetParams(this.totalWidth,400)
    this.journalView:SetPadding(15,0,0,0)
    this.journalView:SetData(scrollDatas, true)
end

this.SetNumberView = function(config)
    SetActive(this.numberObject,#config > 1)
    this.numberView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    for i = 1, #config do
        groupData = {}
        groupData.item = this.numberTemplate
        groupData.index = i
        groupData.dataId = config[i]
        scrollData = UIScrollData.GetData(this.numberTemplate,"NumberItemModel",120,60,groupData)
        this.tableInsert(scrollDatas,scrollData)
    end
    this.numberView:SetParams(120,432)
    this.numberView:SetData(scrollDatas, false)
end

this.SwitchLabel = function(index)
    if this.labelIndex ~= 0 then
        this.vm.data.labelList[this.labelIndex].select = false
    end
    this.CloseDetails()
    this.labelIndex = index
    this.vm.data.labelList[this.labelIndex].select = true
    this.SetJournalView(this.vm.data.labelList[this.labelIndex].sortStr)
end


this.GetParamIndex = function()
    local tempLabel = this.vm.behaviour.Params[1]
    for i = 1, #this.vm.data.labelList do
        if this.vm.data.labelList[i].sortStr == tempLabel then
            return i
        end
    end
    return 1
end

this.MovePosition = function()
    local tempId = this.vm.behaviour.Params[2]
    for i = 1, #this.journalView.dataList do
        if this.journalView.dataList[i].data.data.ID == tempId then
            this.journalView:MoveToIndex(i)
            return
        end
    end
end

this.ItemClickEvent = function(args)
    local type,index,callBack = args[0],args[1],args[2]
    local config = this.textConfig[type][index]
    if config == nil then return end
    this.vm.data.fileNameLan = ""
    if config.FileType ~= nil then
        this.vm.data.fileNameLan = LuaMgr.GetLangText(config.FileNameLan)
    end
    this.vm.data.gotoBtn = type == "102"
    this.gotoId = ""
    this.markersID = ""
    if type == "102" then
        this.gotoId = config.Unlock[2]
        this.markersID = config.ID
    end
    if callBack ~= nil then
        callBack()
    end
    local texture = nil
    if this.panelType == "archives" then
        texture = LuaMgr.GetTexture(this.BGPath..config.BgRes..".png")
    else
        texture = LuaMgr.GetTexture(this.BGPath.."ui_archives_hui.png")
    end
    this.vm.data.bgTexture = texture

    this.periodNumber = 0
    this.SetNumberView(config.TextContent)
    this.vm.data.iconTexture = LuaMgr.GetTexture("Images/JournalArchives/"..config.Icon..".png")
    this.PlayOpenBookAnim()
    if #this.numberView.itemMap > 0 then
        this.numberView.itemMap[1].clickCommand()
    end
    this.vm.data.journalViewIsShow = false
    HeroParameter.EmptyClickState()
end

this.NumberClickEvent = function(args)
    this.textView:StopMovement()
    local index,dataId = args[0],args[1]
    if this.periodNumber ~= 0 then
        SetActive(this.numberView.itemMap[this.periodNumber].select,false)
    end
    this.periodNumber = index
    SetActive(this.numberView.itemMap[this.periodNumber].select,true)
    this.UpdateTextContent(dataId)
end
this.GotoAreaExplore = function(args)
    if (args.Length <= 0) then return end
    local id = args[0]
    if ConfigMgr.Config.areaExplores[id] == nil then return end
    LuaMgr.ShowLuaPanel(UIName.AreaExploreRecordViewModel, ConfigMgr.Config.areaExplores[id].tab,id)
end

this.UpdateTextContent = function(dataId)
    if dataId ~= nil then
        this.textView.content.anchoredPosition = Vector2.zero
        
        local txtContent = ConfigMgr.Config.TxtContentMap[dataId]
        if txtContent == nil then return end

        local txtStr = LuaMgr.GetLangText(txtContent.TextContentLan)
        if txtStr == nil or txtStr == "" then return end

        local tempTab = NumTool.split(txtStr, '￥')

        if this.textItemTab == nil then this.textItemTab = {} end
        if this.insetItemTab == nil then this.insetItemTab = {} end
        local tempItem = nil
        for i = 1, #tempTab do

            if #this.textItemTab < i then
                tempItem = TextItem.New(this.textView.content,this.textItemTemplate)
                this.tableInsert(this.textItemTab,tempItem)
            else
                tempItem = this.textItemTab[i]
            end
            this.textItemTab[i]:SetData(tempTab[i])

            if txtContent.Sprite[i] ~= nil then
                if #this.insetItemTab < i then
                    tempItem = InsetItem.New(this.textView.content,this.insetItemTemplate)
                    this.tableInsert(this.insetItemTab,tempItem)
                else
                    tempItem = this.insetItemTab[i]
                end
                this.insetItemTab[i]:SetData(txtContent.Sprite[i])
            end
        end
        for i = #tempTab + 1, #this.textItemTab do
            this.textItemTab[i]:Clear()
            this.textItemTab[i] = nil
        end
        for i = #txtContent.Sprite + 1, #this.insetItemTab do
            this.insetItemTab[i]:Clear()
            this.insetItemTab[i] = nil
        end
        this.CalculateHeight()
    end
end
this.CalculateHeight = function()
    local tempHeight = 0
    for i = 1, #this.textItemTab do
        tempHeight = tempHeight + this.textItemTab[i].transform.sizeDelta.y
    end
    tempHeight = tempHeight + #this.insetItemTab * 278
    tempHeight = tempHeight + ((#this.textItemTab + #this.insetItemTab) * 5) - 5
    this.textView.content.sizeDelta = Vector2(650,tempHeight)
end

this.CloseDetails = function()
    this.PlayCloseBookAnim()
end

this.PlayOpenBookAnim = function()
    this.vm.data.detailsIsShow = true
    this.isClose = true
    this.vm.data.rootAnimName = "UI_Journal_Book_appear"
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/File_open.mp3")
end

this.PlayCloseBookAnim = function()
    HeroParameter.EmptyClickState()
    this.isClose = false
    if this.isDelay then
        if this.vm.data.journalViewIsShow == false then
            LuaMgr.AddTimer(TimerConst.FileCloseBookAnim,function()
                this.SetJournalView()
                this.vm.data.journalViewIsShow = true
            end,0.25,1,false)
        end
    else
        this.SetJournalView()
        this.vm.data.journalViewIsShow = true
        this.isDelay = true
    end
    if this.vm.data.journalViewIsShow == false then
        this.vm.data.rootAnimName = "UI_Journal_Book_disppear"
        LuaMgr.AddTimer(TimerConst.FileCloseBook,function()
            this.isClose = true
            this.vm.data.detailsIsShow = false
            this.EmptyTextScroll()
        end,0.56,1,false)
    end
end

this.GetTextConfig = function()
    if this.textConfig == nil then
        this.textConfig = {}
        if this.panelType == "journal" then
            for key,value in pairs(ConfigMgr.Config.MagazineMap) do
                if this.textConfig[value.MagazineType] == nil then
                    this.textConfig[value.MagazineType] = {}
                end
                this.tableInsert(this.textConfig[value.MagazineType],value)
            end
        elseif this.panelType == "archives" then
            local activityId = nil
            local isActivity = nil
            for key,value in pairs(ConfigMgr.Config.FileMap) do

                local isBanned = FeatureManager.UnifyVerControls("areamap",value.MainType)
                if isBanned then
                    if this.textConfig[value.FileType] == nil then
                        this.textConfig[value.FileType] = {}
                    end
                    activityId = value.ActivityId ~= 0 and tostring(value.ActivityId) or nil
                    if activityId ~= nil then
                        isActivity = ActivityMgr.ActivityRuning(ConfigMgr.Config.activityGroup[activityId].key)
                    end
                    if activityId ~= nil and isActivity then
                        this.tableInsert(this.textConfig[value.FileType],value)
                    elseif activityId ~= nil and not isActivity then
                        if this.GetFileState(value.Unlock) then
                            this.tableInsert(this.textConfig[value.FileType],value)
                        end
                    elseif activityId == nil then
                        this.tableInsert(this.textConfig[value.FileType],value)
                    end
                end
            end
        end
        for key,value in pairs(this.textConfig) do
            this.tableSort(this.textConfig[key],this.JournalItemSort)
        end
    end
end
this.GetFileState = function(Unlock)
    local tempLock = false
    if Unlock[1] == "1" then
        tempLock = tonumber(Unlock[2]) <= DataMgr.Player.level
    elseif Unlock[1] == "2" then
        tempLock = DataMgr.Player.completedAreaEvents[Unlock[2]] ~= nil
    elseif Unlock[1] == "3" then
        tempLock = this.GetNovelState(Unlock)
    elseif Unlock[1] == "4" then

        tempLock = this.GetAreaEventState(Unlock[2])
    end
    return tempLock
end

this.GetNovelState = function(Unlock)
    for i = 1, #DataMgr.Player.completedChapters do
        if DataMgr.Player.completedChapters[i] == Unlock[2] then
            return true
        end
    end
    return false
end

this.GetAreaEventState = function(eventId)
    if ConfigMgr.Config.areaExplores[eventId] == nil then return false end
    local areaName = nil
    areaName = ConfigMgr.Config.areaExplores[eventId].tab
    if areaName == nil then return false end
    if DataMgr.Player.areaExplores[areaName].completedExplores[eventId] == nil then
        return false
    else
        return true
    end
end

this.GetAreaEventState = function(eventId)
    if ConfigMgr.Config.areaExplores[eventId] == nil then return true end
    local areaName = nil
    areaName = ConfigMgr.Config.areaExplores[eventId].tab
    if areaName == nil then return true end
    if DataMgr.Player.areaExplores[areaName].completedExplores[eventId] == nil then
        return true
    else
        return false
    end
end
this.GetState = function(unlock)
    for i = 1, #DataMgr.Player.completedChapters do
        if DataMgr.Player.completedChapters[i] == unlock then
            return false
        end
    end
    return true
end

this.LabelListSort = function(item1,item2)
    return item1.sortStr < item2.sortStr
end

this.JournalItemSort = function(item1,item2)
    if this.GetFileState(item1.Unlock) == this.GetFileState(item2.Unlock) then
        return tonumber(item1.ID) < tonumber(item2.ID)
    else
        if item1.ContentType == 1 then
            return not this.GetFileState(item1.Unlock) and this.GetFileState(item2.Unlock)
        else
            return this.GetFileState(item1.Unlock) and not this.GetFileState(item2.Unlock)
        end
    end

end

this.EmptyTextScroll = function()
    if this.textItemTab ~= nil then
        for i = 1, #this.textItemTab do
            this.textItemTab[i]:Clear()
        end
        this.textItemTab = nil
    end
    if this.insetItemTab ~= nil then
        for i = 1, #this.insetItemTab do
            this.insetItemTab[i]:Clear()
        end
        this.insetItemTab = nil
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})