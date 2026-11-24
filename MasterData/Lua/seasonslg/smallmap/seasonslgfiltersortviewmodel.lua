local areaType = nil
local gridType = nil

local jobIndex = nil
local sortIndex = nil
local this = {vm = nil}

local data = {
    filterList = {{filterText = "",filterChoose = false}},
    sortList = {{sortText = "",sortChoose = false}},

    isTower=false,
}

local command = {
    closeBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.Back()
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            SeasonSLGSmallMapMgr.filterAreaID = areaType
            SeasonSLGSmallMapMgr.filterGridType = gridType

            LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGFilterSort)
            LuaMgr.Back()
        end
    },
    filterCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SwitchFilter(param + 1)
        end
    },
    sortCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SwitchSort(param + 1)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm.data.isTower=true


        this.InitParameter()
        this.InitFilterRoot()
        this.InitSortRoot()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
}


this.InitParameter = function()
    areaType = SeasonSLGSmallMapMgr.filterAreaID
    gridType = SeasonSLGSmallMapMgr.filterGridType
end

this.InitFilterRoot = function()
    local areaList = SeasonSLGSmallMapMgr.GetCurShowAreaList()

    local tempList = {}
    local tempItem = nil
    table.insert(tempList,{filterText = LuaMgr.GetLangText("SeasonSLGFilterSortViewModel_0"), type = "", filterChoose = "" == SeasonSLGSmallMapMgr.filterAreaID})
    this.selectAreaIndex = 1
    for _, v in ipairs(areaList) do
        local k = v.Id
        tempItem = {filterText = v.Name,filterChoose = k == SeasonSLGSmallMapMgr.filterAreaID,type = k}
        table.insert(tempList,tempItem)
        if k == SeasonSLGSmallMapMgr.filterAreaID then
            this.selectAreaIndex = #tempList
        end
    end

    this.vm.data.filterList = tempList
end

this.InitSortRoot = function()
    local tempList = {}
    local tempItem = nil
    local sft = ConfigMgr.Config.SeasonalConstants.SeasonalMiniMapFilterType

    for i = 1, #sft do
        tempItem = {sortText = ConfigMgr.LangGlobal(sft[i][2]),type = sft[i][1],sortChoose = SeasonSLGSmallMapMgr.filterGridType == sft[i][1]}
        tempItem.sortText = "0" == tempItem.type and LuaMgr.GetLangText("SeasonSLGFilterSortViewModel_1") or tempItem.sortText
        table.insert(tempList,tempItem)
        if SeasonSLGSmallMapMgr.filterGridType == sft[i][1] then
            sortIndex = #tempList
        end
    end

    this.vm.data.sortList = tempList
end

this.SwitchFilter = function(index)
    this.vm.data.filterList[this.selectAreaIndex].filterChoose = false
    this.selectAreaIndex = index
    this.vm.data.filterList[this.selectAreaIndex].filterChoose = true
    areaType = this.vm.data.filterList[this.selectAreaIndex].type
end

this.SwitchSort = function(index)
    if sortIndex == index then

    else
        this.vm.data.sortList[sortIndex].sortChoose = false
        sortIndex = index
        this.vm.data.sortList[sortIndex].sortChoose = true
    end
    gridType = this.vm.data.sortList[sortIndex].type
end

this.GetFilterName = function(type)
    local name = ""

    return type
end

this.GetSortName = function(type)
    local name = ""
    if type == HeroSortType.Level then name = ConfigMgr.LangGlobal("2410") end
    if type == HeroSortType.Star then name = ConfigMgr.LangGlobal("2411") end
    if type == HeroSortType.Time then name = ConfigMgr.LangGlobal("2412") end
    if type == HeroSortType.Rare then name = ConfigMgr.LangGlobal("2413") end
    if type == HeroSortType.Friendly then name = ConfigMgr.LangGlobal("2550") end
    return name
end

return vm({
    data = data,
    command = command,
    hook = hook
})