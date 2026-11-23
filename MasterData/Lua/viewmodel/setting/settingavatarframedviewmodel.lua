


local this = {
    vm = nil,
    playerDynamicAvatar = nil,
    playerDynamicAvatar_Frame = nil,
    previewShowAvatarId = "",
    previewShowFrameId = "",
    defaultContentPos = Vector2(0, 0),
    filterContentPos = Vector2(-188.8, 0),
    moveTime = 0.5,

    avatarDic = {},

    frameDic = {},
}
local colorNormal = UnityEngine.Color(1,1,1,1)
local colorHalf = UnityEngine.Color(1,1,1,0.5)

local heroIconPath = "Assets/_BundleResources/Character/"

local changeAvatarSuccessTip = ''
local changeAvatarRepeatTip = ''
local changeAvatarFrameSuccessTip = ''
local changeAvatarFrameRepeatTip = ''

local avatarDataList = nil
local frameDataList = nil
local titleDataList = nil

local selectAvatarIndex = -1
local selectFrameIndex = -1
local isFilterMode = false
local isInOrder = true

local keyList = { "data_1", "data_2", "data_3", "data_4" }

require("ViewModel/Setting/SettingAvatarFramedItem")
require("ViewModel/Setting/SettingAvatarFramedGroup")
require("ViewModel/Setting/SettingPlayerTitleGroup")
require("ViewModel/Setting/SettingPlayerTitleItem")
require("ViewModel/Setting/SettingPlayerTitleLine")

local objs = {    
}


local data = {
    tabAvatarSprite = DefaultSprite,
    tabFrameSprite = DefaultSprite,
    tabTitleSprite = DefaultSprite,
    preAvatarText = DefaultTexture,
    preFrameSprite = DefaultSprite,    
    showAvatar = false,
    showFrame = false,
    showTitle = false,
    avatarName = '',
    avatarDesc = '',
    frameName = '',
    frameDesc = '',
    avatarList = {{redId="",avatarID = "",avatar = DefaultTexture, awatarName = '', avatarDesc = '', lock = false, color = colorNormal, select = false}},
    frameList = {{redId="",frameID = "",frame = DefaultSprite, frameName = '', frameDesc = '', lock = false, select = false}},
    showAvatarChange = false,
    showFrameChange = false,
    showTitleChange = false,
    preAvatarObj = false,
    dynamicAvatarShow = false,
    dynamicAvatarShow_Frame = false,
    noAvatarList = false,
    noAvatarFrameList = false,
    noListIcon = false,
    playerTitle = DefaultSprite,
    playerTitleText = "",
    filterBtnRoot = false,
    titleTextPos = Vector2.zero,
}


local lastSelectAvatarIdx = 1

local lastSelectFrameIdx = 1

local showAvatar = nil
local showType = {avatar = 1, frame = 2, title = 3}
local lastSelectTitleId = nil

this.before_awake = function()
    
end

this.before_active = function()
    this.ResetLeftButtonGroup()
end

local command = {
    clickTabAvatar = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

        this.selectAvatarPage()
        this.RefreshToggleItems()
        end
    },
    clickTabFrame = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

        this.selectFramePage()
        this.RefreshToggleItems()
        end
    },
    clickTabTitle = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

            this.selectTitlePage()
            this.RefreshToggleItems()
        end
    },
    clickChangeAvatar = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

            if nil == this.curAvatarList[lastSelectAvatarIdx] then
                print('选中头像错误 '..lastSelectAvatarIdx)
            end
            
            if this.curAvatarList[lastSelectAvatarIdx].avatarID == DataMgr.Player.Avatar then
                LuaMgr.ShowPanel('Laigu.ViewModel.MessageTipsViewModel',  changeAvatarRepeatTip)
                return
            end

            local data = {}
            data.ID = this.curAvatarList[lastSelectAvatarIdx].avatarID
            ApiMgr.Request("select_avatar_frame", data, true, function(result)
                local re = json.decode(result)
                if re.code == 0 then
                    selectAvatarIndex = lastSelectAvatarIdx
                    this.vm.data.showAvatarChange = false
                    
                    HeroRedDataHelper.ClearAvatarFrame(0,data.ID)
                    LuaMgr.ShowPanel('Laigu.ViewModel.MessageTipsViewModel', changeAvatarSuccessTip)
                    LuaMgr.InvokeUIEventListeners(UIEventConst.SettingAvatarChange)
                    return
                end       
                
                print('更换头像失败 '.. result)
            end, nil, true)

        end
    },
    clickChangeFrame = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

            if nil == this.curAvatarFrameList[lastSelectFrameIdx] then
                print('选中头像框错误 '..lastSelectFrameIdx)
            end

            if this.curAvatarFrameList[lastSelectFrameIdx].frameID == DataMgr.Player.currentAvatarFrame then
                LuaMgr.ShowPanel('Laigu.ViewModel.MessageTipsViewModel', changeAvatarFrameRepeatTip)
                return
            end

            local data = {}
            data.ID = this.curAvatarFrameList[lastSelectFrameIdx].frameID
            ApiMgr.Request("select_avatar_frame", data, true, function(result)
                local re = json.decode(result)
                if re.code == 0 then
                    selectFrameIndex = lastSelectFrameIdx
                    this.vm.data.showFrameChange = false

                    HeroRedDataHelper.ClearAvatarFrame(1,data.ID)
                    LuaMgr.ShowPanel('Laigu.ViewModel.MessageTipsViewModel', changeAvatarFrameSuccessTip)
                    LuaMgr.InvokeUIEventListeners(UIEventConst.SettingAvatarChange)   
                    return                 
                end
                print('更换头像框失败 '.. result)
            end, nil, true)

        end
    },
    clickChangeTitle = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if IsNullOrEmpty(lastSelectTitleId) then
                return
            end
            if DataMgr.Player.titleMap[lastSelectTitleId] == nil then
                return
            end
            local tempData = {}
            tempData.id = lastSelectTitleId
            ApiMgr.Request("select_title", tempData,true,function(result)
                local re = json.decode(result)
                if re.code == 0 then
                    local isShow = not IsNullOrEmpty(lastSelectTitleId) and DataMgr.Player.titleMap[lastSelectTitleId] ~= nil and lastSelectTitleId ~= DataMgr.Player.currentTitle
                    this.vm.data.showTitleChange = isShow
                    LuaMgr.InvokeUIEventListeners(UIEventConst.ChangeTitleSettingUpdate)
                end
            end,nil,true)
        end
    },
    clickFilterBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if isFilterMode == true then
                return
            end
            this.RefreshToggleItems()
            isFilterMode = true
            SetActive(this.leftButtonGroup, false)
            SetActive(this.filterButtonObj, false)
            local getter = function()
                return this.normalGroup.anchoredPosition
            end
            local setter = function(pos)
                this.normalGroup.anchoredPosition = pos
            end
            local targetpos = this.filterContentPos
            this.moveTweener = DOTWeen.To(getter, setter, targetpos, this.moveTime)
            this.moveTweener.onComplete = function()
                SetActive(this.filterButtonObj, true)
                SetActive(this.filterGroup, true)
                for i = 1, #this.toggleGetMothedItems do
                    local item = this.toggleGetMothedItems[i]
                    if this.selectTypeIndex == 0 or this.selectTypeIndex == i then
                        item.toggle.isOn = true
                        this.ClickPageToggle(i, true)
                    else
                        item.toggle.isOn = false
                    end
                end
                for key, value in pairs(this.toggleGetMothedItems) do
                    value:SetIsOn()
                end
            end
        end
    },
    clickCancelFilterBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            SetActive(this.filterGroup, false)
            SetActive(this.filterButtonObj, false)
            local getter = function()
                return this.normalGroup.anchoredPosition
            end
            local setter = function(pos)
                this.normalGroup.anchoredPosition = pos
            end
            local targetpos = this.defaultContentPos
            this.moveTweener = DOTWeen.To(getter, setter, targetpos, this.moveTime)
            this.moveTweener.onComplete = function()
                SetActive(this.filterButtonObj, true)
                SetActive(this.leftButtonGroup, true)
                if showAvatar == showType.avatar then
                    this.SetAvatarScrollView(avatarDataList)
                elseif showAvatar == showType.frame then
                    this.SetFrameScrollView(frameDataList)
                end
                isFilterMode = false
            end
        end
    },
    clickSortBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if isInOrder == true then
                isInOrder = false
            else
                isInOrder = true
            end
            this.SortList()
        end
    },
    clickMask = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            HeroRedDataHelper.ClearAvatarFrame()
            LuaMgr.Back()   
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        RedMgr.Singleton:RegisterViewModel(UIName.SettingAvatarFramedViewModel)
        changeAvatarSuccessTip = LuaMgr.GetLangText('LangGlobalLan_LangGlobal_name_1030')
        changeAvatarRepeatTip = LuaMgr.GetLangText('LangGlobalLan_LangGlobal_name_1031')
        changeAvatarFrameSuccessTip = LuaMgr.GetLangText('LangGlobalLan_LangGlobal_name_1030')
        changeAvatarFrameRepeatTip = LuaMgr.GetLangText('LangGlobalLan_LangGlobal_name_1032')
        this.itemGroup = vm.behaviour.transform:Find("template/ItemGroup").gameObject
        this.avatarItem = vm.behaviour.transform:Find("template/Avatar").gameObject
        this.togglePrefab = vm.behaviour.transform:Find("template/MothedItem").gameObject
        this.titleItem = vm.behaviour.transform:Find("template/PlayerTitleItem").gameObject
        this.titleItemLine = vm.behaviour.transform:Find("template/PlayerTitleLine").gameObject
        this.titleGroup = vm.behaviour.transform:Find("template/PlayerTitleGroup").gameObject
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Content/NormalGroup/Scroll View").gameObject)
        this.playerDynamicAvatar = vm.behaviour.transform:Find("root/Middle/Content/NormalGroup/AvatarPanel/PreAwatar/DynamicAvatar"):GetComponent("PlayerDynamicAvatar")
        this.playerDynamicAvatar_Frame = vm.behaviour.transform:Find("root/Middle/Content/NormalGroup/FramePanel/PreAvatar/DynamicAvatar"):GetComponent("PlayerDynamicAvatar")

        this.leftButtonGroup = vm.behaviour.transform:Find("root/Middle/LeftButtonGroup").gameObject
        this.filterGroup = vm.behaviour.transform:Find("root/Middle/Content/FilterGroup").gameObject
        this.filterButtonObj = vm.behaviour.transform:Find("root/Middle/Content/FilterButton").gameObject
        this.normalGroup = vm.behaviour.transform:Find("root/Middle/Content/NormalGroup"):GetComponent(UITool.RectTransform)
        this.mothedToggleParent = vm.behaviour.transform:Find("root/Middle/Content/FilterGroup/MothedToggleParent"):GetComponent(UITool.Transform)
        this.mothedToggleGroup = this.mothedToggleParent:GetComponent(UITool.ToggleGroup)
        this.inputField = vm.behaviour.transform:Find("root/Middle/Content/FilterGroup/InputField"):GetComponent(UITool.InputField)
        this.inputFieldPlaceHold = vm.behaviour.transform:Find("root/Middle/Content/FilterGroup/InputField/Placeholder"):GetComponent(UITool.Text)
        this.avatarPanelFrame = vm.behaviour.transform:Find("root/Middle/Content/NormalGroup/AvatarPanel/PreAwatar/frame"):GetComponent("Image")
        this.framePanelFrame = vm.behaviour.transform:Find("root/Middle/Content/NormalGroup/FramePanel/PreAvatar/frame"):GetComponent("Image")
        this.titlePanelFrame = vm.behaviour.transform:Find("root/Middle/Content/NormalGroup/TitlePanel/PreAvatar/frame"):GetComponent("Image")
        this.InitGetMothed()
        this.inputField.onEndEdit:AddListener(this.OnInputChange)
    end,

    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.before_active()
        this.previewShowAvatarId = ""
        this.previewShowFrameId = ""
        if vm.behaviour.Params.Length>1 then
            local type = vm.behaviour.Params[0]
            if type == 1 then
                this.previewShowAvatarId = vm.behaviour.Params[1]
            elseif type == 2 then
                this.previewShowFrameId = vm.behaviour.Params[1]
            end
        end
         
        this.InitData()


        if showAvatar == showType.avatar then
            this.selectAvatarPage(true)
        elseif showAvatar == showType.frame then
            this.selectFramePage(true)
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.scrollView:Clear(true)
        PlayerAvatarFrameTool.ClearImage(this.avatarPanelFrame)
        PlayerAvatarFrameTool.ClearImage(this.framePanelFrame)
        PlayerAvatarFrameTool.ClearImage(this.titlePanelFrame)
    end,
    after_destroy = function(vm)
        this.playerDynamicAvatar = nil
        this.playerDynamicAvatar_Frame = nil
        UIScrollView.ClearItem("SettingAvatarFramedGroup")
        UIScrollView.ClearItem("SettingPlayerTitleGroup")
        UIScrollView.ClearItem("SettingPlayerTitleLine")
        this.inputField.onEndEdit:RemoveAllListeners()
        this.selectTypeIndex = nil
    end
}


this.selectAvatar = function(idx)
    if(nil ~= this.curAvatarList[lastSelectAvatarIdx]) then
        this.curAvatarList[lastSelectAvatarIdx].select = false
    end
    if nil ~= this.curAvatarList[idx] then
        this.curAvatarList[idx].select = true
        if this.curAvatarList[idx].imgType == 1 then
            this.vm.data.preAvatarText = this.curAvatarList[idx].avatar
        elseif this.curAvatarList[idx].imgType == 2 then
            if showAvatar == showType.avatar then
                this.playerDynamicAvatar:AppointAvatar(this.curAvatarList[idx].avatarID)
            elseif showAvatar == showType.frame then
                this.playerDynamicAvatar_Frame:AppointAvatar(this.curAvatarList[idx].avatarID)
            end
        end
        this.vm.data.preAvatarObj = this.curAvatarList[idx].imgType == 1
        this.vm.data.dynamicAvatarShow = showAvatar == showType.avatar and this.curAvatarList[idx].imgType == 2
        this.vm.data.dynamicAvatarShow_Frame = showAvatar == showType.avatar and this.curAvatarList[idx].imgType == 2
        this.vm.data.avatarName = this.curAvatarList[idx].avatarName
        this.vm.data.avatarDesc = this.curAvatarList[idx].avatarDesc
        lastSelectAvatarIdx = idx
        this.vm.data.showAvatarChange = not this.curAvatarList[idx].lock and idx ~= selectAvatarIndex
    else
        print('selectAvatar error, idx not found '..idx)
    end

    if showAvatar == showType.avatar then
        this.scrollView:Refresh()
    end
end


this.selectFrame = function(idx)          
    if(nil ~= this.curAvatarFrameList[lastSelectFrameIdx]) then
        this.curAvatarFrameList[lastSelectFrameIdx].select = false
    end
    if nil ~= this.curAvatarFrameList[idx] then
        this.curAvatarFrameList[idx].select = true       

        PlayerAvatarFrameTool.SetAvatarFrame(this.avatarPanelFrame, this.curAvatarFrameList[idx].frameID)
        PlayerAvatarFrameTool.SetAvatarFrame(this.framePanelFrame, this.curAvatarFrameList[idx].frameID)
        PlayerAvatarFrameTool.SetAvatarFrame(this.titlePanelFrame, this.curAvatarFrameList[idx].frameID)
        this.vm.data.frameName = this.curAvatarFrameList[idx].frameName
        this.vm.data.frameDesc = this.curAvatarFrameList[idx].frameDesc        
        lastSelectFrameIdx = idx
        this.vm.data.showFrameChange = not this.curAvatarFrameList[idx].lock and idx ~= selectFrameIndex
    else
        print('selectFrame error, idx not found '..idx)
    end

    if showAvatar == showType.frame then
        this.scrollView:Refresh()
    end
end


this.selectAvatarPage = function(pInit)
    if not pInit and showAvatar == showType.avatar then
        return
    end
    showAvatar = showType.avatar

    this.vm.data.showAvatar = showAvatar == showType.avatar
    this.vm.data.showFrame = showAvatar == showType.frame
    this.vm.data.showTitle = showAvatar == showType.title
    this.vm.data.filterBtnRoot = true

    this.vm.data.tabAvatarSprite = LuaMgr.GetSprite("SettingAvatar","ui_htx_tab_tx01")
    this.vm.data.tabFrameSprite = LuaMgr.GetSprite("SettingAvatar","ui_htx_tab_txk02")
    this.vm.data.tabTitleSprite = LuaMgr.GetSprite("SettingAvatar","ui_htx_tab_ch02")
    this.curAvatarList = avatarDataList
    this.curAvatarFrameList = frameDataList
    this.SetAvatarScrollView(avatarDataList)
    this.resetSelectAvatar()
    this.resetSelectAvatarFrame()
    this.scrollView:MoveToIndex(math.ceil(selectAvatarIndex / 4))
    lastSelectTitleId = nil
end


this.selectFramePage = function(pInit)
    if not pInit and showAvatar == showType.frame then
        return
    end
    showAvatar = showType.frame

    this.vm.data.showAvatar = showAvatar == showType.avatar
    this.vm.data.showFrame = showAvatar == showType.frame
    this.vm.data.showTitle = showAvatar == showType.title
    this.vm.data.filterBtnRoot = true

    this.vm.data.tabAvatarSprite = LuaMgr.GetSprite("SettingAvatar","ui_htx_tab_tx02")
    this.vm.data.tabFrameSprite = LuaMgr.GetSprite("SettingAvatar","ui_htx_tab_txk01")
    this.vm.data.tabTitleSprite = LuaMgr.GetSprite("SettingAvatar","ui_htx_tab_ch02")
    this.SetFrameScrollView(frameDataList)
    this.resetSelectAvatar()
    this.resetSelectAvatarFrame()
    this.scrollView:MoveToIndex(math.ceil(selectFrameIndex / 4))
    lastSelectTitleId = nil
end


this.selectTitlePage = function(pInit)
    if not pInit and showAvatar == showType.title then
        return
    end
    showAvatar = showType.title

    this.vm.data.showAvatar = showAvatar == showType.avatar
    this.vm.data.showFrame = showAvatar == showType.frame
    this.vm.data.showTitle = showAvatar == showType.title
    this.vm.data.filterBtnRoot = false

    if IsNullOrEmpty(lastSelectTitleId) then
        local title = ConfigHelper.GetTitleConfig(DataMgr.Player.currentTitle)
        if not TableIsNull(title) then
            this.vm.data.playerTitle = LuaMgr.GetSprite("PlayerTitle",title.img)
            this.vm.data.playerTitleText = LuaMgr.GetLangText(title.namelan)
            this.vm.data.frameDesc = LuaMgr.GetLangText(title.descriptionLan)
            if title.img == "Title_40001" then
                this.vm.data.titleTextPos =  Vector2(2,1)
            else
                this.vm.data.titleTextPos =  Vector2(10,1)
            end
        end
    end
    local isShow = not IsNullOrEmpty(lastSelectTitleId) and DataMgr.Player.titleMap[lastSelectTitleId] ~= nil and lastSelectTitleId ~= DataMgr.Player.currentTitle
    this.vm.data.showTitleChange = isShow

    this.vm.data.tabAvatarSprite = LuaMgr.GetSprite("SettingAvatar","ui_htx_tab_tx02")
    this.vm.data.tabFrameSprite = LuaMgr.GetSprite("SettingAvatar","ui_htx_tab_txk02")
    this.vm.data.tabTitleSprite = LuaMgr.GetSprite("SettingAvatar","ui_htx_tab_ch01")
    this.SetTitleScrollView(titleDataList)
end

this.TitleItemClick = function(titleId)
    if IsNullOrEmpty(titleId) or lastSelectTitleId == titleId then
        return
    end
    lastSelectTitleId = titleId
    local title = ConfigHelper.GetTitleConfig(lastSelectTitleId)
    if not TableIsNull(title) then
        this.vm.data.playerTitle = LuaMgr.GetSprite("PlayerTitle",title.img)
        this.vm.data.playerTitleText = LuaMgr.GetLangText(title.namelan)
        this.vm.data.frameDesc = LuaMgr.GetLangText(title.descriptionLan)
        if title.img == "Title_40001" then
            this.vm.data.titleTextPos =  Vector2(2,1)
        else
            this.vm.data.titleTextPos =  Vector2(10,1)
        end
    end
    local isShow = not IsNullOrEmpty(lastSelectTitleId) and DataMgr.Player.titleMap[lastSelectTitleId] ~= nil and lastSelectTitleId ~= DataMgr.Player.currentTitle
    this.vm.data.showTitleChange = isShow
    for i = 1, #this.scrollView.dataList do
        if this.scrollView.dataList[i].data["title"] ~= nil then
            for j = 1, #this.scrollView.dataList[i].data.title do
                this.scrollView.dataList[i].data.title[j].select = this.scrollView.dataList[i].data.title[j].id == lastSelectTitleId
            end
        end
    end
    this.scrollView:Refresh()
end


this.resetSelectAvatar = function()
    local idx = 1
    local len = #this.curAvatarList
    if len > 0 then
        for i = 1, len do
            if IsNullOrEmpty(this.previewShowAvatarId) then

                if nil ~= DataMgr.Player.Avatar and DataMgr.Player.Avatar ~= '' and DataMgr.Player.Avatar == this.curAvatarList[i].avatarID then
                    selectAvatarIndex = i
                end
            else
                if this.previewShowAvatarId == this.curAvatarList[i].avatarID then
                    selectAvatarIndex = i
                end
            end
        end
    end
    if selectAvatarIndex == -1 then
        selectAvatarIndex = 1
    end
    this.selectAvatar(selectAvatarIndex)
end


this.resetSelectAvatarFrame = function()
    local idx = 1
    local len = #this.curAvatarFrameList
    if len > 0 then
        for i = 1, len do
            if IsNullOrEmpty(this.previewShowFrameId) then

                if nil ~= DataMgr.Player.currentAvatarFrame and DataMgr.Player.currentAvatarFrame ~= '' and DataMgr.Player.currentAvatarFrame == this.curAvatarFrameList[i].frameID then
                    selectFrameIndex = i
                end
            else
                if this.previewShowFrameId == this.curAvatarFrameList[i].frameID then
                    selectFrameIndex = i
                end
            end
        end
    end

    if selectFrameIndex == -1 then
        selectFrameIndex = 1
    end
    this.selectFrame(selectFrameIndex)
end

this.InitData = function()

    local avatarConfigList = {}
    local frameConfigList = {}
    local titleConfigList = {}
    local sysTime = LuaMgr.Timestamp();
    if nil ~= ConfigMgr.Config.avatarFrames then
        local len = #ConfigMgr.Config.avatarFrames
        if (len > 0) then
            for i = 1, len do
                local data = ConfigMgr.Config.avatarFrames[i]
                if data.type == 1 then
                    if (ConfigMgr.Config.characterTable[data.img] == nil or ConfigCharacterMgr.IsShow2(data.img, sysTime)) then
                        if data.hide == 1 then
                            if nil ~= DataMgr.Player.avatarFrameMap[data.id] then
                                table.insert(avatarConfigList, data)
                            end
                        else
                            table.insert(avatarConfigList, data)
                        end
                    end
                elseif  data.type == 2 then
                    if data.hide == 1 then
                        if nil ~= DataMgr.Player.avatarFrameMap[data.id] then
                            table.insert(frameConfigList, data)
                        end
                    else
                        table.insert(frameConfigList, data)
                    end
                elseif data.type == 4 then
                    if titleConfigList[data.Rarity] == nil then
                        titleConfigList[data.Rarity] = {}
                    end
                    table.insert(titleConfigList[data.Rarity], data)
                end
            end
        end

        len = #avatarConfigList
        if len > 0 then
            table.sort(avatarConfigList, function(a,b)
                local unlock_a = nil ~= DataMgr.Player.avatarFrameMap[a.id]
                local unlock_b = nil ~= DataMgr.Player.avatarFrameMap[b.id]
                if not unlock_a and unlock_b then
                    return false
                elseif unlock_a and not unlock_b then
                    return true
                else
                    return tonumber(a.sort) < tonumber(b.sort)
                end
            end)
        end

        len = #frameConfigList
        if len > 0 then
            table.sort(frameConfigList, function(a,b)
                return tonumber(a.sort) < tonumber(b.sort)
            end)
        end

        if not TableIsNull(titleConfigList) then
            for i = 1, #titleConfigList do
                table.sort(titleConfigList[i],function(a, b)
                    return tonumber(a.sort) < tonumber(b.sort)
                end)
            end
        end
    else
        print('ConfigMgr.Config.avatarFrames is null')
    end

    lastSelectAvatarIdx = 1

    lastSelectFrameIdx = 1

showAvatar = showType.avatar

    this.InitAvatarListData(avatarConfigList)
    this.InitFrameListData(frameConfigList)
    this.InitTitleListData(titleConfigList)
    this.selectTypeIndex = 0
    this.vm.data.noAvatarList = false
    this.vm.data.noAvatarFrameList = false
    this.vm.data.noListIcon = false
    RedMgr.Singleton:Refresh()
end


this.InitAvatarListData = function(avatarConfigList)
    local tmpList = {}
    local len = #avatarConfigList
    if len <= 0 then
        avatarDataList = {}
        return
    end
    this.avatarDic = {}
    for i = 1, len do
        local avatarConfig = avatarConfigList[i]
        local lock = not (nil ~= DataMgr.Player.avatarFrameMap[avatarConfig.id])
        local color = colorNormal
        if lock then
            color = colorHalf
        end
        local name = LuaMgr.GetLangText(avatarConfig.namelan)
        local data = {
            ID = avatarConfig.id,
            avatarID = avatarConfig.id,
            avatar = LuaMgr.GetTexture(ConfigHelper.GetHeadIconPath(avatarConfig.img, avatarConfig.imgId)),
            frameID = "txk_01",
            frame = PlayerAvatarFrameTool.GetStaticSprite("txk_01"),
            avatarName = name,
            name = name,
            avatarDesc = LuaMgr.GetLangText(avatarConfig.descriptionLan),
            select = false,
            color = color,
            lock = lock,
            redId="1117_"..avatarConfig.id,
            OnClickBg = this.OnClickAvatar,
            isAvatar = true,
            order = avatarConfig.sort,
            imgType = avatarConfig.imgType,
            ownerTime = DataMgr.Player.avatarFrameTimeMap[avatarConfig.id] or 0
        }

        local mothedGroup = this.avatarDic[avatarConfig.AccessMethod]
        if mothedGroup == nil then
            mothedGroup = {}
        end
        table.insert(mothedGroup, data)
        this.avatarDic[avatarConfig.AccessMethod] = mothedGroup

        table.insert(tmpList,  data)
        RedMgr.Singleton:UpdateClientRedData("1117_"..avatarConfig.id,HeroRedDataHelper.setting_avatarList[avatarConfig.id])
    end

    table.sort(tmpList, function(a, b)
        if a.lock ~= b.lock then
            return b.lock and not a.lock
        end
        return a.order < b.order
    end)

    for i = 1, len do
        tmpList[i].index = i

        if nil ~= DataMgr.Player.Avatar and DataMgr.Player.Avatar ~= '' and DataMgr.Player.Avatar == tmpList[i].avatarID then
            lastSelectAvatarIdx = i
        end
    end

    avatarDataList = tmpList
end


this.InitFrameListData = function(frameConfigList)
    local tmpList = {}
    local len = #frameConfigList
    if len <= 0 then
        frameDataList = {}
        return
    end
    this.frameDic = {}
    for i = 1, len do
        local frameConfig = frameConfigList[i]
        local lock = not (nil ~= DataMgr.Player.avatarFrameMap[frameConfig.id])
        local name = LuaMgr.GetLangText(frameConfig.namelan)
        local data = {
            ID = frameConfig.id,
            frameID = frameConfig.id,
            avatar = LuaMgr.GetTexture(ConfigHelper.GetHeadIconPath(frameConfig.img, frameConfig.imgId)),
            frame = PlayerAvatarFrameTool.GetStaticSprite(frameConfig.id, frameConfig),
            frameName = name,
            name = name,
            frameDesc = LuaMgr.GetLangText(frameConfig.descriptionLan),
            select = false,
            lock = lock,
            redId="1119_"..frameConfig.id,
            OnClickBg = this.OnClickFrame,
            isAvatar = false,
            order = frameConfig.sort,
            ownerTime = DataMgr.Player.avatarFrameTimeMap[frameConfig.id] or 0
        }

        local mothedGroup = this.frameDic[frameConfig.AccessMethod]
        if mothedGroup == nil then
            mothedGroup = {}
        end
        table.insert(mothedGroup, data)
        this.frameDic[frameConfig.AccessMethod] = mothedGroup

        table.insert(tmpList, data)
        RedMgr.Singleton:UpdateClientRedData("1119_"..frameConfig.id,HeroRedDataHelper.setting_avatarFrameList[frameConfig.id])
    end

    table.sort(tmpList, function(a, b)
        if a.lock ~= b.lock then
            return b.lock and not a.lock
        end
        return a.order < b.order
    end)
    
    for i = 1, len do
        tmpList[i].index = i

        if nil ~= DataMgr.Player.currentAvatarFrame and DataMgr.Player.currentAvatarFrame ~= '' and DataMgr.Player.currentAvatarFrame == tmpList[i].frameID then
            lastSelectFrameIdx = i
        end
    end

    frameDataList = tmpList
end


this.InitTitleListData = function(titleConfigList)
    local tmpList = {}
    local len = #titleConfigList
    if len <= 0 then
        titleDataList = {}
        return
    end
    titleDataList = titleConfigList
end


this.SetAvatarScrollView = function(allDatas)
    this.scrollView:Clear(false)
    this.vm.data.noAvatarList = false
    this.vm.data.noListIcon = false
    if allDatas == nil or #allDatas == 0 then
        this.vm.data.noAvatarList = true
        this.vm.data.noListIcon = true
        return
    end
    local avatarData
    local groupData
    local scrollData
    local scrollDatas = {}
    local len = #allDatas
    local index = 1
    while (index <= len) do
        groupData = {}
        groupData.item = this.avatarItem
        for i = 1, 4 do
            avatarData = allDatas[index + i - 1]
            if (avatarData ~= nil) then
                groupData[keyList[i]] = avatarData
            end
        end
        scrollData = UIScrollData.GetData(this.itemGroup, "SettingAvatarFramedGroup", 530, 127, groupData)
        table.insert(scrollDatas, scrollData)
        index = index + 4
    end
    this.scrollView:SetParams(530, 375)
    this.scrollView:SetData(scrollDatas, true)
end


this.SetFrameScrollView = function(allDatas)
    this.scrollView:Clear(false)
    this.vm.data.noAvatarFrameList = false
    this.vm.data.noListIcon = false
    if allDatas == nil or #allDatas == 0 then
        this.vm.data.noAvatarFrameList = true
        this.vm.data.noListIcon = true
        return
    end
    local frameData
    local groupData
    local scrollData
    local scrollDatas = {}
    local len = #allDatas
    local index = 1
    while (index <= len) do
        groupData = {}
        groupData.item = this.avatarItem
        for i = 1, 4 do
            frameData = allDatas[index + i - 1]
            if (frameData ~= nil) then
                groupData[keyList[i]] = frameData
            end
        end
        scrollData = UIScrollData.GetData(this.itemGroup, "SettingAvatarFramedGroup", 530, 127, groupData)
        table.insert(scrollDatas, scrollData)
        index = index + 4
    end
    this.scrollView:SetParams(530, 375)
    this.scrollView:SetData(scrollDatas, true)
end


this.SetTitleScrollView = function(allDatas)
    this.scrollView:Clear(false)
    this.vm.data.noAvatarFrameList = false
    this.vm.data.noListIcon = false
    if allDatas == nil or #allDatas == 0 then
        this.vm.data.noAvatarFrameList = true
        this.vm.data.noListIcon = true
        return
    end
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local tempData = nil
    for i = 1, #allDatas do
        if #allDatas[i] > 0 then
            index = 1
            while (index <= #allDatas[i]) do
                groupData = {}
                groupData.item = this.titleItem
                groupData.title = {}
                groupData.call = this.TitleItemClick
                for j = 1, 3 do
                    if allDatas[i][index + j - 1] ~= nil then
                        tempData = allDatas[i][index + j - 1]
                        tempData.select = allDatas[i][index + j - 1].id == DataMgr.Player.currentTitle
                        table.insert(groupData.title,tempData)
                    end
                end
                scrollData = UIScrollData.GetData(this.titleGroup,"SettingPlayerTitleGroup",530,96,groupData)
                table.insert(scrollDatas,scrollData)
                index = index + 3
            end
            groupData = {}
            groupData.item = this.titleItemLine
            scrollData = UIScrollData.GetData(this.titleItemLine,"SettingPlayerTitleLine",532,4,groupData)
            table.insert(scrollDatas,scrollData)
        end
    end
    this.scrollView:SetParams(530, 375)
    this.scrollView:SetData(scrollDatas, true)
end



this.ResetLeftButtonGroup = function()
    SetActive(this.filterGroup, false)
    SetActive(this.filterButtonObj, true)
    SetActive(this.leftButtonGroup, true)
    isFilterMode = false
    this.normalGroup.anchoredPosition = this.defaultContentPos
end

this.InitGetMothed = function()
    local allMothedIndexs = ConfigMgr.Config.constants.AccessMethodTyp1

    this.toggleGetMothedItems = {}
    for i = 1, #allMothedIndexs do
        local item = CommonToggleItem.New(this.togglePrefab, this.mothedToggleParent, true, i, this.ClickPageToggle, this.mothedToggleGroup)
        this.toggleGetMothedItems[i] = item
        local data = {}
        local lanKey = "LangGlobalLan_LangGlobal_name_2963" .. i
        data.nocheckText = LuaMgr.GetLangText(lanKey)
        data.checkText = LuaMgr.GetLangText(lanKey)
        item:SetData(data)
    end
end

this.RefreshToggleItems = function()
    local allMothedIndexs = ConfigMgr.Config.constants.AccessMethodTyp1
    if showAvatar == showType.frame then
        allMothedIndexs = ConfigMgr.Config.constants.AccessMethodTyp2
    end
    for i, v in ipairs(this.toggleGetMothedItems) do
        SetActive(v.gameObject, false)
    end
    for i, v in ipairs(allMothedIndexs) do
        local item = this.toggleGetMothedItems[v]
        SetActive(item.gameObject, true)
    end
    local placeholder = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29657")
    if showAvatar == showType.frame then
        placeholder = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29658")
    end
    this.inputFieldPlaceHold.text = placeholder
end

this.ClickPageToggle = function(index, value)
    if value == true then
        for i = 1, #this.toggleGetMothedItems do
            local toggleNode = this.toggleGetMothedItems[i]
            toggleNode:SetIsOn(index == i)
        end
        this.selectTypeIndex = index
        local list = this.GetListByToggle()
        if showAvatar == showType.avatar then
            this.SetAvatarScrollView(list)
        elseif showAvatar == showType.frame then
            this.SetFrameScrollView(list)
        end
    end
end

this.OnInputChange = function(value)
    local list = this.FindHeadByName(value)
    if showAvatar == showType.avatar then
        this.SetAvatarScrollView(list)
    elseif showAvatar == showType.frame then
        this.SetFrameScrollView(list)
    end
end

this.GetListByToggle = function()
    local dic = showAvatar == showType.avatar and this.avatarDic or this.frameDic
    if this.selectTypeIndex == nil then
        return {}
    end
    return dic[this.selectTypeIndex]
end

this.FindHeadByName = function(inputStr)
    local dic = showAvatar == showType.avatar and this.avatarDic or this.frameDic
    if dic == nil or #dic == 0 then
        return {}
    end
    local tempDatas = dic[this.selectTypeIndex]
    local targetStr = inputStr
    if targetStr == nil or targetStr == "" then
        return tempDatas
    end
    local datas = {}
    if tempDatas ~= nil then
        for i = 1, #tempDatas do
            local data = tempDatas[i]
            local isSuccess = this.IsMathSucc(targetStr, data.name)
            if isSuccess then
                table.insert(datas, data)
            end
        end
    end
    return datas
end

this.SortList = function()
    local dic = showAvatar == showType.avatar and this.avatarDic or this.frameDic
    local list = dic[this.selectTypeIndex]
    if list == nil or #list < 2 then
        return
    end
    if isInOrder == true then
        table.sort(list, this.SortByTimeAsc)
    else
        table.sort(list, this.SortByTimeDesc)
    end
end

this.SortByTimeAsc = function(data1, data2)
    if data1.ownerTime ~= data2.ownerTime then
        return data1.ownerTime < data2.ownerTime
    end
    if data1.lock ~= data2.lock then
        return not data1.lock and data2.lock
    end
    return data1.ID < data2.ID
end

this.SortByTimeDesc = function(data1, data2)
    if data1.ownerTime ~= data2.ownerTime then
        return data1.ownerTime > data2.ownerTime
    end
    if data1.lock ~= data2.lock then
        return data1.lock and not data2.lock
    end
    return data1.ID > data2.ID
end


this.SplitUtf8 = function(str)
    local char_list = {}
    if type(str) ~= "string" or str == "" then
        return char_list
    end
    local i = 1
    while i <= #str do
        local byte = string.byte(str, i)
        local char_len = 1
        if byte >= 0xE0 then
            char_len = 3
        elseif byte >= 0xC0 then
            char_len = 2
        end
        local char = string.sub(str, i, i + char_len - 1)
        table.insert(char_list, char)
        i = i + char_len
    end
    return char_list
end

this.IsMathSucc = function(targetStr, matchStr)
    if (type(targetStr) ~= "string" or targetStr == "") or (type(matchStr) ~= "string" or matchStr == "") then
        return false, 0
    end
    local level = 1
    local levelNum = tonumber(level) or 1
    if levelNum ~= 1 and levelNum ~= 7 and levelNum ~= 10 then
        levelNum = 1
    end

    local targetChars = this.SplitUtf8(targetStr)
    local targetTotal = #targetChars
    local matchChars = this.SplitUtf8(matchStr)

    local target_char_set = {}
    for _, char in ipairs(targetChars) do
        target_char_set[char] = true
    end

    local matched_chars = {}
    local matchCount = 0
    for _, char in ipairs(matchChars) do
        if target_char_set[char] and not matched_chars[char] then
            matchCount = matchCount + 1
            matched_chars[char] = true
        end
    end

    local matchRate = targetTotal > 0 and (matchCount * 10000 // targetTotal) / 100 or 0
    local isMatch = false
    if levelNum == 1 then
        isMatch = matchCount >= 1
    elseif levelNum == 7 then
        isMatch = matchRate >= 80
    elseif levelNum == 10 then
        local matchTotal = #matchChars
        isMatch = (targetTotal == matchTotal)
        if isMatch then
            for i = 1, targetTotal do
                if targetChars[i] ~= matchChars[i] then
                    isMatch = false
                    break
                end
            end
        end
        matchRate = isMatch and 100 or 0
    end
    return isMatch, matchRate
end



this.OnClickAvatar = function(index)
    this.selectAvatar(index)
end

this.OnClickFrame = function(index)
    this.selectFrame(index)
end

return vm({
    data = data,
    command = command,
    hook = hook,
})