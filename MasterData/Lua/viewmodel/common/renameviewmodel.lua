





local this = {
    vm = nil,randomseed = 0,day = 0,
}

local data = {
    tip_text_1 = "",tip_text_2 = "",inputText = "",placeholderText = "",
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.RenameViewModel)
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local tempName = this.vm.data.inputText
            if tempName == DataMgr.Player.name then
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15957"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
                return
            end
            if this.TimeBool() then
                local tempData = {name = tempName}
                ApiMgr.Request("change_name", tempData, true, function(result)
                    local re = json.decode(result)
                    if re.code == 0 then
                        LuaMgr.InvokeUIEventListeners(UIEventConst.PropUse,"25")
                        LuaMgr.InvokeUIEventListeners(UIEventConst.RenameEvent)
                        LuaMgr.HidePanel(UIName.RenameViewModel)
                        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15955"].NameLan)
                        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
                    end
                end, nil, true);
            end
        end
    },
    randomCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.randomseed = this.randomseed + 1
            math.randomseed(this.randomseed)
            local fit = math.random(1001, 1093)
            local sed = math.random(2001, 2100)
            local fitName=ConfigMgr.Config.rollName[tostring(fit)]
            local sedName=ConfigMgr.Config.rollName[tostring(sed)]
            local nickName = LuaMgr.GetLangText(fitName.NameLan)..LuaMgr.GetLangText(sedName.NameLan)
            this.vm.data.inputText = nickName
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.InitParameter = function()
    this.randomseed = os.time()
    this.SetLanguageText()
end

this.SetLanguageText = function()
    this.vm.data.inputText = ""
    this.vm.data.tip_text_1 = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15951"].NameLan)
    local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15952"].NameLan)
    this.day = 0
    if ConfigMgr.Config.constants.changeName ~= nil then
        this.day = ConfigMgr.Config.constants.changeName
    end
    this.vm.data.tip_text_2 = string.format(tipStr,this.day)
    this.vm.data.placeholderText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15953"].NameLan)
end

this.TimeBool = function()
    local nowTime = LuaMgr.Timestamp()

    local changeTime = DataMgr.Player.lastChangeNameTime

    local coolingTime = this.day * 86400
    if nowTime - changeTime >= coolingTime then
        return true
    end
    local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15956"].NameLan)
    local dayStr = math.ceil((coolingTime - (nowTime - changeTime)) / 86400)
    LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",string.format(tipStr,dayStr))
    return false
end

return vm({
    data = data,
    command = command,
    hook = hook
})