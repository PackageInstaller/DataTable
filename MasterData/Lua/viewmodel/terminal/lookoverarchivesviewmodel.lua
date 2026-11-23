





local this = {
    vm = nil,
    TEXTURE_PATH = "Images/JournalArchives/%s.png",
    contentIcon = nil,contentRect = nil,contentScroll = nil,
    scaleValue = nil,scaleMax = nil,scaleMin = nil,
    nowScaleValue = 0,
    rotationValue = -90,
    input = UnityEngine.Input,
    scrollWheel = nil,
    callBack = nil,
}

local data = {
    
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.LookOverArchivesViewModel)
        end
    },
    restoreCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.InitContentState()
        end
    },
    bigCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.ScaleOnValueChanged(true)
        end
    },
    smallCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.ScaleOnValueChanged(false)
        end
    },
    rotationCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.RotationOnValueChanged()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.contentScroll = this.vm.behaviour.transform:Find("root/Middle/ContentView"):GetComponent("ScrollRect")
        this.contentIcon = this.vm.behaviour.transform:Find("root/Middle/ContentView/Viewport/Content/Content"):GetComponent("RawImage")
        this.contentRect = this.vm.behaviour.transform:Find("root/Middle/ContentView/Viewport/Content/Content"):GetComponent("RectTransform")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.contentScroll.content.anchoredPosition = Vector2.zero
        HeroParameter.EmptyClickState()
        if LuaMgr.IsEmulator() then
            LuaMgr.RemoveUpdate(this.UpdateOnValueChanged)
        end
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
    if this.vm.behaviour.Params.Length == 0 then
        return
    end
    local iconName = this.vm.behaviour.Params[0]
    if iconName == nil or iconName == "" then
        return
    end
    this.callBack = this.vm.behaviour.Params[1]
    if this.callBack ~= nil then
        this.callBack()
    end
    local path = string.format(this.TEXTURE_PATH,iconName)
    this.contentIcon.texture = LuaMgr.GetTexture(path)
    this.scaleValue = ConfigMgr.Config.constants.scaling / 10
    this.scaleMax = ConfigMgr.Config.constants.scalingMax
    this.scaleMin = ConfigMgr.Config.constants.scalingMin / 10
    this.InitContentState()
    if LuaMgr.IsEmulator() then
        LuaMgr.AddUpdate(this.UpdateOnValueChanged)
    end
end


this.UpdateOnValueChanged = function()
    this.scrollWheel = this.input.GetAxis("Mouse ScrollWheel")
    if this.scrollWheel ~= 0 then
        this.nowScaleValue = this.nowScaleValue + this.scrollWheel * 1
        if this.nowScaleValue > this.scaleMax then
            this.nowScaleValue = this.scaleMax
            this.PopupTip(true)
        elseif this.nowScaleValue < this.scaleMin then
            this.nowScaleValue = this.scaleMin
            this.PopupTip(false)
        end
        this.contentScroll.content.localScale = Vector3(this.nowScaleValue,this.nowScaleValue,1)
    end
end


this.InitContentState = function()
    this.nowScaleValue = 1.0
    this.contentScroll.content.localScale = Vector3.one
    
    this.contentRect.localEulerAngles = Vector3.zero
end


this.ScaleOnValueChanged = function(type)
    local scale = this.contentScroll.content.localScale.x
    if type then
        scale = scale + this.scaleValue
        if scale > this.scaleMax then
            scale = this.scaleMax
            this.PopupTip(true)
        end
    else
        scale = scale - this.scaleValue
        if scale < this.scaleMin then
            scale = this.scaleMin
            this.PopupTip(false)
        end
    end
    this.nowScaleValue = scale
    this.contentScroll.content.localScale = Vector3(scale,scale,1)
end


this.RotationOnValueChanged = function()
    local rotation = this.contentRect.localEulerAngles.z
    rotation = rotation + this.rotationValue
    this.contentRect.localEulerAngles = Vector3(0,0,rotation)
end


this.PopupTip = function(type)
    local tipStr = ""
    if type then
        tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["13206"].NameLan)
    else
        tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["13207"].NameLan)
    end
    LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
end

return vm({
    data = data,
    command = command,
    hook = hook
})