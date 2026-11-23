




require("ViewModel/Seal/MedalSeriesItem")
require("ViewModel/Seal/MedalItem")

local this = {
    vm = nil,medalConfig = nil,tableInsert = table.insert,
    labelIndex = 1,curViewType = nil,viewEnum = {Theme = 1,Medal = 2},
    seriesScroll = nil,seriesTemplate = nil,
    medalScroll = nil,medalTemplate = nil,
}

local data = {
    allCountText = "",
    themeView = false,
    labelItem = {{normal = false,choose = false,labelText = ""}},
    
    medalView = false,
    series_Name = DefaultTexture,emptyText = "",chooseCountText = "",
    confirmBtnText = "",returnBtnText = "",
}

local command = {
    labelCommand = {
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index = tonumber(param) + 1
            this.vm.data.labelItem[this.labelIndex].choose = false
            this.vm.data.labelItem[this.labelIndex].normal = true
            this.labelIndex = index
            this.vm.data.labelItem[this.labelIndex].choose = true
            this.vm.data.labelItem[this.labelIndex].normal = false
            this.SetSeriesScroll()
        end
    },
    confirmCommand = {
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.Back()
        end
    },
    returnCommand = {
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.Back()
        end
    },
    emptyCommand = {
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            PlayerMedalMgr.ClearMedal()
            this.UpdateChooseCount()
            this.medalScroll:Refresh()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.seriesTemplate = vm.behaviour.transform:Find("template/SeriesItem").gameObject
        this.medalTemplate = vm.behaviour.transform:Find("template/MedalItem").gameObject
        this.seriesScroll = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/ThemeView/SeriesScroll").gameObject)
        this.medalScroll = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/MedalView/MedalScroll").gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.SetLanguageText()
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.seriesScroll:Clear(false)
        this.medalScroll:Clear(false)
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("MedalSeriesItem")
        UIScrollView.ClearItem("MedalItem")
        this = nil
    end,
}

this.SetLanguageText = function()
    this.vm.data.emptyText = ConfigMgr.LangGlobal("24063")
    this.vm.data.confirmBtnText = ConfigMgr.LangGlobal("24062")
    this.vm.data.returnBtnText = ConfigMgr.LangGlobal("24066")
end

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.InitParameter = function()
    this.curViewType = this.viewEnum.Theme
    this.labelIndex = 1
    this.GetMedalConfig()
    this.SetView()
    this.SetLabel()
    this.SetSeriesScroll()
    this.SetAllCount()
end

this.SetAllCount = function()
    local count = ConfigHelper.GetTableLength(DataMgr.Player.MedalMap)
    local countStr = ConfigMgr.LangGlobal("24060")
    this.vm.data.allCountText = countStr..count
end

this.SetView = function()
    this.vm.data.themeView = this.curViewType == this.viewEnum.Theme
    this.vm.data.medalView = this.curViewType == this.viewEnum.Medal
    if this.curViewType == this.viewEnum.Theme then
        this.vm.behaviour:UpdateTopBar("Theme",this.Back)
    else
        this.vm.behaviour:UpdateTopBar("Medal",this.Back)
    end
end

this.SetLabel = function()
    if TableIsNull(this.medalConfig) then return end
    local labelStr = ""
    local tempList,tempItem = {},{}
    for i = 1, #this.medalConfig do
        if i == 1 then labelStr = ConfigMgr.LangGlobal("24051") end
        if i == 2 then labelStr = ConfigMgr.LangGlobal("24050") end
        tempItem = {normal = not(i == this.labelIndex),choose = i == this.labelIndex,labelText = labelStr}
        this.tableInsert(tempList,tempItem)
    end
    this.vm.data.labelItem = tempList
end

this.SetSeriesScroll = function()
    if TableIsNull(this.medalConfig) then return end
    this.seriesScroll:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    for key,value in pairs(this.medalConfig[this.labelIndex]) do
        groupData = {}
        groupData.data = value
        groupData.seriesKey = key
        groupData.callBack = this.SeriesItemClick
        scrollData = UIScrollData.GetData(this.seriesTemplate,"MedalSeriesItem",340 + 10,460,groupData)
        this.tableInsert(scrollDatas,scrollData)
    end
    this.seriesScroll:SetParams(1226,500)
    this.seriesScroll:SetPadding(20,0,0,0)
    this.seriesScroll:SetData(scrollDatas, true)
end

this.SeriesItemClick = function(seriesKey,medalList)
    if IsNullOrEmpty(seriesKey) or TableIsNull(medalList) then
        return
    end
    local texture = LuaMgr.GetTexture(Path.Series_Path..seriesKey.."_Item_Name.png")
    this.vm.data.series_Name = texture
    
    this.medalScroll:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local length = #medalList
    for i = 1, length do
        groupData = {}
        groupData.data = medalList[i]
        groupData.callBack = this.MedalChoose
        scrollData = UIScrollData.GetData(this.medalTemplate,"MedalItem",1138,125 + 30,groupData)
        this.tableInsert(scrollDatas,scrollData)
    end
    this.medalScroll:SetParams(1243,460)
    this.medalScroll:SetPadding(0,0,-28,0)
    this.medalScroll:SetData(scrollDatas, true)
    this.UpdateChooseCount()
    this.curViewType = this.viewEnum.Medal
    this.SetView()
end

this.UpdateChooseCount = function()
    local countStr = "<size=28><color=#007a7e>"..PlayerMedalMgr.Count().."</color></size>/9"
    this.vm.data.chooseCountText = string.format(ConfigMgr.LangGlobal("24061"),countStr)
end


this.MedalChoose = function(type,medalId)
    if type then
        if PlayerMedalMgr.Count() >= 9 then
            return
        end
        PlayerMedalMgr.AddMedal(medalId)
    else
        PlayerMedalMgr.RemoveMedal(medalId)
    end
    this.UpdateChooseCount()
end

this.GetMedalConfig = function()
    if not TableIsNull(this.medalConfig) then
        return
    end
    this.medalConfig = {}
    local tempMedal = nil
    for i = 1, #ConfigMgr.Config.Medals do
        tempMedal = ConfigMgr.Config.Medals[i]
        if #this.medalConfig < tempMedal.Type then

            this.tableInsert(this.medalConfig,tempMedal.Type,{})
        end
        if this.medalConfig[tempMedal.Type][tempMedal.Activity] == nil then

            this.medalConfig[tempMedal.Type][tempMedal.Activity] = {}
        end
        this.tableInsert(this.medalConfig[tempMedal.Type][tempMedal.Activity],tempMedal)
    end
end

this.Back = function()
    if this.curViewType == this.viewEnum.Theme then
        LuaMgr.Back()
    else
        this.curViewType = this.viewEnum.Theme
        this.SetView()
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})