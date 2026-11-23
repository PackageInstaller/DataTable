





local jobType = nil
local sortType = nil
local sequenceType = nil
local jobIndex = nil
local sortIndex = nil
local characterJob = nil
local heroSortType = nil
local this = {vm = nil}

local data = {
    filterList = {{filterText = "",filterChoose = false}},
    sortList = {{sortText = "",sortChoose = false,order = Vector3.zero}},
    isNor=false,
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
            if jobType == HeroParameter.jobType then
                if sortType == HeroParameter.sortType then
                    if sequenceType == HeroParameter.sequenceType then
                        LuaMgr.Back()
                        return
                    end
                end
            end
            HeroParameter.SaveListParam(jobType,sortType,sequenceType,0.0,1)
            LuaMgr.InvokeUIEventListeners(UIEventConst.UpdateHeroList)
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
        this.vm.data.isTower=vm.behaviour.Params.Length>0
        this.vm.data.isNor=vm.behaviour.Params.Length==0
        
        this.InitParameter()
        this.InitFilterRoot()
        this.InitSortRoot()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        characterJob = nil
        heroSortType = nil
    end,
}


this.InitParameter = function()
    jobType = HeroParameter.jobType
    sortType = HeroParameter.sortType
    sequenceType = HeroParameter.sequenceType
    this.InitConfig()
end

this.InitFilterRoot = function()
    local tempList = {}
    local tempItem = nil
    for i = 1, #characterJob do
        tempItem = {filterText = this.GetFilterName(characterJob[i]),type = characterJob[i],
                    filterChoose = jobType == characterJob[i]}
        if jobType == characterJob[i] then
            jobIndex = i
        end
        table.insert(tempList,tempItem)
    end
    this.vm.data.filterList = tempList
end

this.InitSortRoot = function()
    local tempList = {}
    local tempItem = nil
    for i = 1, #heroSortType do
        tempItem = {sortText = this.GetSortName(heroSortType[i]),type = heroSortType[i],
                    sortChoose = sortType == heroSortType[i],order = Vector3.one}
        if sequenceType == SequenceType.FromSmallToBig then
            tempItem.order = Vector3(1,-1,1)
        end
        if sortType == heroSortType[i] then
            sortIndex = i
        end
        table.insert(tempList,tempItem)
    end
    this.vm.data.sortList = tempList
end

this.SwitchFilter = function(index)
    this.vm.data.filterList[jobIndex].filterChoose = false
    jobIndex = index
    this.vm.data.filterList[jobIndex].filterChoose = true
    jobType = this.vm.data.filterList[jobIndex].type
end

this.SwitchSort = function(index)
    if sortIndex == index then
        if sequenceType == SequenceType.FromBigToSmall then
            sequenceType = SequenceType.FromSmallToBig
            this.vm.data.sortList[index].order = Vector3(1,-1,1)
        else
            sequenceType = SequenceType.FromBigToSmall
            this.vm.data.sortList[index].order = Vector3.one
        end
    else
        this.vm.data.sortList[sortIndex].sortChoose = false
        sortIndex = index
        this.vm.data.sortList[sortIndex].order = Vector3.one
        this.vm.data.sortList[sortIndex].sortChoose = true
        sequenceType = SequenceType.FromBigToSmall
    end
    sortType = this.vm.data.sortList[sortIndex].type
end

this.GetFilterName = function(type)
    local name = ""
    if type == CharacterJob.All then name = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2400"].NameLan) end
    if type == CharacterJob.Tank then name = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2401"].NameLan) end
    if type == CharacterJob.RangeAttack then name = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2402"].NameLan) end
    if type == CharacterJob.MeleeAttack then name = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2403"].NameLan) end
    if type == CharacterJob.Magic then name = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2404"].NameLan) end
    if type == CharacterJob.Assistant then name = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2405"].NameLan) end
    return name
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

this.InitConfig = function()
    characterJob = {}
    for key,value in pairs(CharacterJob) do
        table.insert(characterJob,value)
    end
    table.sort(characterJob)
    heroSortType = {}
    for key,value in pairs(HeroSortType) do
        table.insert(heroSortType,value)
    end
    table.sort(heroSortType)
end

return vm({
    data = data,
    command = command,
    hook = hook
})