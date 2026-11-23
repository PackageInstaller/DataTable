





local this = {
    vm = nil,skinLogConfig = nil,curSkinIndex = nil,
}

local data = {
    titleText = "",seriesText = "",
    skinLogList = {{choose = false,logIcon = DefaultSprite}}
}

local command = {
    closeBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.Back()
        end
    },
    skinLogCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1
            if this.curSkinIndex == index then
                this.vm.data.skinLogList[this.curSkinIndex].choose = false
                this.curSkinIndex = 0
            else
                if this.curSkinIndex ~= 0 then
                    this.vm.data.skinLogList[this.curSkinIndex].choose = false
                end
                this.curSkinIndex = index
                this.vm.data.skinLogList[this.curSkinIndex].choose = true
            end
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.curSkinIndex == nil or this.curSkinIndex == 0 then
                HeroParameter.CurSkinIndex = nil
                HeroParameter.CurSkinLog = nil
            else
                HeroParameter.CurSkinIndex = this.curSkinIndex
                HeroParameter.CurSkinLog = this.vm.data.skinLogList[this.curSkinIndex].logKey
            end
            LuaMgr.InvokeUIEventListeners(UIEventConst.FilterSkinUpdate)
            LuaMgr.HidePanel(UIName.FilterSkinPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
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
    end,
    before_destroy = function(vm)
        this.vm.data.skinLogList = {}
        this.skinLogConfig = nil
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end

this.SetLanguageText = function()
    this.vm.data.titleText = ConfigMgr.LangGlobal("23870")
    this.vm.data.seriesText = ConfigMgr.LangGlobal("23873")
end


this.InitParameter = function()
    if HeroParameter.CurSkinIndex == nil then
        this.curSkinIndex = 0
    else
        this.curSkinIndex = HeroParameter.CurSkinIndex
    end
    this.GetSkinLogConfig()
    this.CreateSkinLog()
end

this.CreateSkinLog = function()
    if TableIsNull(this.skinLogConfig) then
        return
    end
    local tempList,tempItem = {},nil
    local index = 1
    for key,value in pairs(this.skinLogConfig) do
        tempItem = {choose = index == this.curSkinIndex,logIcon = LuaMgr.GetSprite("SkinLogo","SkinLogo_"..key),logKey = key}
        table.insert(tempList,tempItem)
        index = index + 1
    end
    this.vm.data.skinLogList = tempList
end

this.GetSkinLogConfig = function()
    if not TableIsNull(this.skinLogConfig) then
        return
    end
    this.skinLogConfig = {}
    local nowTime = LuaMgr.Timestamp()
    for key,value in pairs(ConfigMgr.Config.characterSkins) do
        if not TableIsNull(value) then
            for i = 1, #value do
                if nowTime >= value[i].UnlockDate and value[i].skinType == 3 then
                    if value[i].skinLOGO ~= nil and value[i].skinLOGO ~= 0 then
                        if this.skinLogConfig[value[i].skinLOGO] == nil then
                            this.skinLogConfig[value[i].skinLOGO] = value[i].skinLOGO
                        end
                    end
                end
            end
        end
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})