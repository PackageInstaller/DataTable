




require("ViewModel/Common/EquipRareItem")
require("ViewModel/Common/EquipSeriesItem")
require("ViewModel/Common/EquipAttrGroup")
require("ViewModel/Common/EquipAttrItem")

local this = {
    vm = nil,TableInsert = table.insert,
    equipRare = nil,equipSeries = nil,equipAttr = nil,
    rareScroll = nil,seriesScroll = nil,attrScroll = nil,
    rareTemplate = nil,seriesTemplate = nil,
    groupTemplate = nil,attrTemplate = nil,
    isChange = false,typeEnum = {simple = 1,detailed = 2},curType = nil,
    equipJob = 0,rareOptions = {},seriesOptions = {},attrOptions = {},includeOptions = 1,excludeOptions = 0
}

local data = {
    rareTipText = "",seriesTipText = "",attrTipText = "",
    includeToggleText = "",excludeToggleText = "",
    closeText = "",resetText = "",confirmText = "",

    includeToggle = false,excludeToggle = false,
    simpleRoot = false,detailedRoot = false,
    simpleText = "",detailedText = "",
    simpleLabel = false,
    job_0 = false,job_1 = false,job_2 = false,
    job_3 = false,job_4 = false,job_5 = false,
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.EquipSiftPopup)
        end
    },
    resetCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.isChange = true
            this.SetEmptyOperation()
            this.equipJob = 0
            this.SetSimple()
            this.UpdateToggle()
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.isChange then
                PlayerBackpackMgr.equipJob = this.equipJob
                PlayerBackpackMgr.rareOptions = this.rareOptions
                PlayerBackpackMgr.seriesOptions = this.seriesOptions
                PlayerBackpackMgr.attrOptions = this.attrOptions
                PlayerBackpackMgr.includeOptions = this.includeOptions
                PlayerBackpackMgr.excludeOptions = this.excludeOptions
                LuaMgr.InvokeUIEventListeners(UIEventConst.EquipSiftConfirmClick)
            end
            LuaMgr.HidePanel(UIName.EquipSiftPopup)
        end
    },
    includeToggleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.includeOptions == 1 then
                return
            end
            this.isChange = true
            this.includeOptions = 1
            this.excludeOptions = 0
            this.UpdateToggle()
        end 
    },
    excludeToggleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.excludeOptions == 1 then
                return
            end
            this.isChange = true
            this.includeOptions = 0
            this.excludeOptions = 1
            this.UpdateToggle()
        end
    },
    jobCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local job = tonumber(param)
            if this.equipJob == job then
                return
            end
            this.isChange = true
            this.equipJob = job
            this.SetSimple()
        end
    },
    labelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local type = tonumber(param)
            if this.curType == type then
                return
            end
            this.curType = type
            this.vm.data.simpleRoot = this.curType == this.typeEnum.simple
            this.vm.data.detailedRoot = this.curType == this.typeEnum.detailed
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.rareTemplate = vm.behaviour.transform:Find("template/RareItem").gameObject
        this.seriesTemplate = vm.behaviour.transform:Find("template/SeriesItem").gameObject
        this.groupTemplate = vm.behaviour.transform:Find("template/AttrGroupItem").gameObject
        this.attrTemplate = vm.behaviour.transform:Find("template/AttrItem").gameObject
        this.rareScroll = UIScrollView.New(vm.behaviour.transform:Find("root/_Middle/Detailed/RareContent/Scroll").gameObject)
        this.seriesScroll = UIScrollView.New(vm.behaviour.transform:Find("root/_Middle/Detailed/SeriesContent/Scroll").gameObject)
        this.attrScroll = UIScrollView.New(vm.behaviour.transform:Find("root/_Middle/Detailed/AttrContent/Scroll").gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.SetLanguageText()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
        this.rareScroll:Clear(false)
        this.seriesScroll:Clear(false)
        this.attrScroll:Clear(false)
        this.equipRare = nil
        this.equipSeries = nil
        this.equipAttr = nil
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("EquipRareItem")
        UIScrollView.ClearItem("EquipSeriesItem")
        UIScrollView.ClearItem("EquipAttrGroup")
        this = nil
    end,
}

this.AddUIEvent = function()
    
end
this.RemoveUIEvent = function()
    
end


this.SetLanguageText = function()
    this.vm.data.rareTipText = ConfigMgr.LangGlobal("16101")
    this.vm.data.seriesTipText = ConfigMgr.LangGlobal("16102")
    this.vm.data.attrTipText = ConfigMgr.LangGlobal("16103")
    this.vm.data.includeToggleText = ConfigMgr.LangGlobal("16104")
    this.vm.data.excludeToggleText = ConfigMgr.LangGlobal("16105")
    this.vm.data.closeText = ConfigMgr.LangGlobal("16106")
    this.vm.data.resetText = ConfigMgr.LangGlobal("16107")
    this.vm.data.confirmText = ConfigMgr.LangGlobal("2119")
    this.vm.data.simpleText = ConfigMgr.LangGlobal("23650")
    this.vm.data.detailedText = ConfigMgr.LangGlobal("23651")
end


this.InitParameter = function()

    local isShow = this.vm.behaviour.Params.Length == 0
    this.vm.data.simpleLabel = isShow
    
this.isChange = false

    this.equipJob = PlayerBackpackMgr.equipJob
    this.rareOptions = table.Copy(PlayerBackpackMgr.rareOptions)
    this.seriesOptions = table.Copy(PlayerBackpackMgr.seriesOptions)
    this.attrOptions = table.Copy(PlayerBackpackMgr.attrOptions)
    this.includeOptions = PlayerBackpackMgr.includeOptions
    this.excludeOptions = PlayerBackpackMgr.excludeOptions


    this.curType = this.typeEnum.detailed
    if isShow and TableIsNull(this.rareOptions) and TableIsNull(this.seriesOptions) and TableIsNull(this.attrOptions) then
        this.curType = this.typeEnum.simple
    end
    if this.curType == this.typeEnum.simple then
        this.SetSimple()
    end
    this.vm.data.simpleRoot = this.curType == this.typeEnum.simple
    this.vm.data.detailedRoot = this.curType == this.typeEnum.detailed
    
    this.UpdateToggle()
    this.InitEquipConfig()
    this.InitEquipAttr()
    this.CreateEquipRare()
    this.CreateEquipSeries()
    this.CreateEquipAttr()
end

this.SetSimple = function()
    this.vm.data.job_0 = this.equipJob == CharacterJob.All
    this.vm.data.job_1 = this.equipJob == CharacterJob.Tank
    this.vm.data.job_2 = this.equipJob == CharacterJob.MeleeAttack
    this.vm.data.job_3 = this.equipJob == CharacterJob.RangeAttack
    this.vm.data.job_4 = this.equipJob == CharacterJob.Magic
    this.vm.data.job_5 = this.equipJob == CharacterJob.Assistant
end

this.UpdateToggle = function()
    this.vm.data.includeToggle = this.includeOptions == 1
    this.vm.data.excludeToggle = this.excludeOptions == 1
end


this.CreateEquipRare = function()
    this.rareScroll:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    for i = 1, #this.equipRare do
        groupData = {}
        groupData.data = this.equipRare[i]
        groupData.callback = this.RareItemClick
        groupData.rareOptions = this.rareOptions
        scrollData = UIScrollData.GetData(this.rareTemplate,"EquipRareItem",220,40 + 8,groupData)
        this.TableInsert(scrollDatas,scrollData)
    end
    this.rareScroll:SetParams(240,495)
    this.rareScroll:SetPadding(0,0,-8,0)
    this.rareScroll:SetData(scrollDatas, true)
end


this.CreateEquipSeries = function()
    this.seriesScroll:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    for i = 1, #this.equipSeries do
        groupData = {}
        groupData.data = this.equipSeries[i]
        groupData.callback = this.SeriesItemClick
        groupData.seriesOptions = this.seriesOptions
        scrollData = UIScrollData.GetData(this.seriesTemplate,"EquipSeriesItem",220,40 + 8,groupData)
        this.TableInsert(scrollDatas,scrollData)
    end
    this.seriesScroll:SetParams(240,495)
    this.seriesScroll:SetPadding(0,0,-8,-8)
    this.seriesScroll:SetData(scrollDatas, true)
end


this.CreateEquipAttr = function()
    this.attrScroll:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local index = 1
    while (index <= #this.equipAttr) do
        groupData = {}
        groupData.item = this.attrTemplate
        groupData.attrs = {}
        groupData.callback = this.AttrItemClick
        groupData.attrOptions = this.attrOptions
        for i = 1, 2 do
            if this.equipAttr[index + i - 1] ~= nil then
                this.TableInsert(groupData.attrs,this.equipAttr[index + i - 1])
            end
        end
        scrollData = UIScrollData.GetData(this.groupTemplate,"EquipAttrGroup",478,40 + 8,groupData)
        this.TableInsert(scrollDatas,scrollData)
        index = index + 2
    end
    this.attrScroll:SetParams(478,440)
    this.attrScroll:SetPadding(0,0,-2,-8)
    this.attrScroll:SetData(scrollDatas, true)
end


this.RareItemClick = function(param)
    this.isChange = true
    if param == nil then
        return
    end
    if this.rareOptions[param] == nil then
        this.rareOptions[param] = param
    else
        this.rareOptions[param] = nil
    end
    this.rareScroll:Refresh()
end


this.SeriesItemClick = function(param)
    this.isChange = true
    if param == nil then
        return
    end
    if this.seriesOptions[param] == nil then
        this.seriesOptions[param] = param
    else
        this.seriesOptions[param] = nil
    end
    this.seriesScroll:Refresh()
end


this.AttrItemClick = function(param)
    this.isChange = true
    if param == nil then
        return
    end
    if this.attrOptions[param] == nil then
        local length = ConfigHelper.GetTableLength(this.attrOptions)
        if length >= ConfigMgr.Config.equipConstants.ChooseNum then
            local tipStr = ConfigMgr.LangGlobal("16112")
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
            return
        end
        this.attrOptions[param] = param
    else
        this.attrOptions[param] = nil
    end
    this.attrScroll:Refresh()
end


this.InitEquipConfig = function()
    this.equipRare = {}
    this.equipSeries = {}
    for key, value in pairs(ConfigMgr.Config.equipments) do

        if this.equipRare[value.rare - 1] == nil then
            this.equipRare[value.rare - 1] = value.rare
        end
        if this.equipSeries[value.Series] == nil then
            this.equipSeries[value.Series] = value.Series
        end
    end
end

this.InitEquipAttr = function()
    this.equipAttr = {}
    for key,value in pairs(ConfigMgr.Config.additionalAttrs) do
        this.TableInsert(this.equipAttr,value)
    end
    table.sort(this.equipAttr,this.AttrSort)
end
this.AttrSort = function(item1,item2)
    return item1.id < item2.id
end

this.SetEmptyOperation = function()
    for key,value in pairs(this.rareOptions) do
        this.rareOptions[key] = nil
    end
    for key,value in pairs(this.seriesOptions) do
        this.seriesOptions[key] = nil
    end
    for key,value in pairs(this.attrOptions) do
        this.attrOptions[key] = nil
    end
    this.includeOptions = 1
    this.excludeOptions = 0
    this.rareScroll:Refresh()
    this.seriesScroll:Refresh()
    this.attrScroll:Refresh()
end

return vm({
    data = data,
    command = command,
    hook = hook
})