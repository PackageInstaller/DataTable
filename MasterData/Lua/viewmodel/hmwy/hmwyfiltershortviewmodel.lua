local jobType = nil
local jobIndex = nil
local characterJob = nil
local callback = nil
local curJobType = nil
local this = { vm = nil }

local data = {
    filterList = { { filterText = "", filterChoose = false } },
}

local command = {
    closeBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.HMWYFilterShortViewModel)
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if jobType == curJobType then
                LuaMgr.HidePanel(UIName.HMWYFilterShortViewModel)
                return
            end
            if callback then
                callback(jobType)
            end
            LuaMgr.HidePanel(UIName.HMWYFilterShortViewModel)
        end
    },
    filterCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SwitchFilter(param + 1)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if (vm.behaviour.Params.Length == 2) then
            callback = vm.behaviour.Params[0]
            curJobType = vm.behaviour.Params[1]
        elseif (vm.behaviour.Params.Length == 1) then
            callback = vm.behaviour.Params[0]
            curJobType = CharacterJob.All
        end
        this.InitParameter()
        this.InitFilterRoot()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        characterJob = nil
    end,
}


this.InitParameter = function()
    jobType = curJobType
    this.InitConfig()
end

this.InitFilterRoot = function()
    local tempList = {}
    local tempItem = nil
    for i = 1, #characterJob do
        tempItem = {
            filterText = this.GetFilterName(characterJob[i]),
            type = characterJob[i],
            filterChoose = jobType == characterJob[i]
        }
        if jobType == characterJob[i] then
            jobIndex = i
        end
        table.insert(tempList, tempItem)
    end
    this.vm.data.filterList = tempList
end

this.SwitchFilter = function(index)
    this.vm.data.filterList[jobIndex].filterChoose = false
    jobIndex = index
    this.vm.data.filterList[jobIndex].filterChoose = true
    jobType = this.vm.data.filterList[jobIndex].type
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

this.InitConfig = function()
    characterJob = {}
    for key, value in pairs(CharacterJob) do
        table.insert(characterJob, value)
    end
    table.sort(characterJob)
end

return vm({
    data = data,
    command = command,
    hook = hook
})