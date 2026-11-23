




local this = {
    vm = nil,medalDisplay = nil,
}

local data = {
    resetText = "",addText = "",saveText = "",previewText = "",
    medalIconList = {
        {icon = DefaultSprite,isShow = false},
        {icon = DefaultSprite,isShow = false},
        {icon = DefaultSprite,isShow = false},
        {icon = DefaultSprite,isShow = false},
        {icon = DefaultSprite,isShow = false},
        {icon = DefaultSprite,isShow = false},
        {icon = DefaultSprite,isShow = false},
        {icon = DefaultSprite,isShow = false},
        {icon = DefaultSprite,isShow = false},
    }
}

local command = {
    addMedalCommand = {
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.ZhanXunAddViewModel)
        end
    },
    saveMedalCommand = {
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            PlayerMedalMgr.SaveMedalDisplay()
        end
    },
    resetCommand = {
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            PlayerMedalMgr.ClearMedal()
            this.InitParameter()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.SetLanguageText()
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

this.SetLanguageText = function()
    this.vm.data.resetText = ConfigMgr.LangGlobal("23920")
    this.vm.data.addText = ConfigMgr.LangGlobal("23921")
    this.vm.data.saveText = ConfigMgr.LangGlobal("23922")

end

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.InitParameter = function()
    local sprite = nil
    for i = 1, #this.vm.data.medalIconList do
        if #PlayerMedalMgr.MedalDisplay >= i then
            sprite = LuaMgr.GetSprite("ZhanXunIcon", PlayerMedalMgr.MedalDisplay[i])
            this.vm.data.medalIconList[i].icon = sprite
            this.vm.data.medalIconList[i].isShow = true
        else
            this.vm.data.medalIconList[i].icon = nil
            this.vm.data.medalIconList[i].isShow = false
        end
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})