




local this = {vm = nil,switchBool = false,hidden = false,index = 0,oldindex = 0,
              cgArray = {},isClick = false,AlreadyGet = false,
              cgImagePath = "Assets/_BundleResources/Images/Novel/Background/"}
local data = {
    rawImageBacks = DefaultTexture,
    rawImage = DefaultTexture,
    element = Vector3.one,
    count = "",
    buttons = Vector3.zero,
    switch = true,
    toggle = Vector3.zero,
    shareBtn = false,
    isShareCG = Vector3.zero,
    playerName = '',
    playerLevel = '',
    showQRCode = false,
    qrCodeSprite = DefaultSprite,
    AminatorName = "",
    cgName = "",
    showelement = false,
    showReward = false,
}

local command = {

    clickLeft = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.isClick then return end
            this.oldindex = this.index
            if this.index < #this.cgArray then
                this.index = this.index + 1
            else
                this.index = 1
            end
            this.UpdateCGData()
            this.PlayAnimator()
        end
    },

    clickRight = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.isClick then return end
            this.oldindex = this.index
            if this.index > 1 then
                this.oldindex = this.index
                this.index = this.index - 1
            else
                this.index = #this.cgArray
            end
            this.UpdateCGData()
            this.PlayAnimator()
        end
    },

    clickSwitch = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OpenButtons()
        end
    },

    clickDownload = {
        type = XLuaCommandType.Void,
        execute = function()
            
        end
    },

    clickShare = {
        type = XLuaCommandType.Void,
        execute = function()
            this.Shear()
        end
    },

    clickHidden = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SwitchShow()
        end
    },

    clickMask = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.hidden then
                this.SwitchShow()
            end
        end
    },

    clickToggle = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SettingAtlas()
        end
    },

    backCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.Back()
        end
    },

    clickPopupTips = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.PopupGetTips()
        end
    },

    clickGetReward = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.GetReward()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.index = vm.behaviour.Params[0]
        this.oldindex = this.index
        this.cgArray = vm.behaviour.Params[1]
        this.UpdateCGData()
        this.vm.data.buttons = Vector3.zero
        this.vm.data.switch = true
        this.vm.data.element = Vector3.one
        this.switchBool = false
        this.hidden = false
        this.isClick = true

        local showQR = false
        local channel = LuaMgr.GetChanel()
        local showShare = false
        local channelData = nil
        for key,value in pairs(ConfigMgr.Config.ShareChannel) do
            if value.ChannelId == channel then
                channelData = value
                break
            end
        end
        if nil ~= channelData then
            showShare = not channelData.Close and not ConfigMgr.Config.constants.CloseShare
            if not channelData.Hide then
                local sp = LuaMgr.GetSprite('QRCode', channelData.Icon)
                if nil ~= sp then
                    this.vm.data.qrCodeSprite = sp
                    showQR = true
                end
            end
        end
        
        this.vm.data.showQRCode = showQR
        this.vm.data.shareBtn = showShare
        this.vm.data.count = "<size=28><color=#FFFFFF>"..this.GetTextureCount().."</color></size>/"..ConfigMgr.Config.constants.MaxSelectedCG

        local p = DataMgr.Player
        this.vm.data.playerName = p.name  
        this.vm.data.playerLevel = 'LV '.. p.level
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.cgArray = {}
        LuaMgr.RemoveTimer(TimerConst.CGMapClickTime)
    end,
    before_destroy = function(vm)
        this = nil
    end,
}
this.UpdateCGData = function()
    local texturePath = ""
    local oldtexturePath = ""
    local cgId = this.cgArray[this.index].id
    this.AlreadyGet = DataMgr.Player.collectCGMap[cgId].unlock
    if this.cgArray[this.index] ~= nil then
        texturePath = this.cgArray[this.index].pathCG
        this.vm.data.cgName = LuaMgr.GetLangText(this.cgArray[this.index].nameCGLan)
    end
    if this.cgArray[this.oldindex] ~= nil then
        oldtexturePath = this.cgArray[this.oldindex].pathCG
    end
    if texturePath ~= "" then
        this.vm.data.rawImage = LuaMgr.GetTexture(this.cgImagePath..texturePath)
        this.vm.data.rawImageBacks = LuaMgr.GetTexture(this.cgImagePath .. oldtexturePath)
    end
    this.vm.data.showelement = this.AlreadyGet
    this.vm.data.showReward = not this.AlreadyGet
    if this.AlreadyGet then
        this.vm.data.toggle = this.ToggleState()
    end
    this.vm.data.buttons = Vector3.zero
    this.vm.data.switch = true
    this.switchBool = false
end

this.ToggleState = function()
    for i = 1, #DataMgr.Player.selectedCG do
        if DataMgr.Player.selectedCG[i] == this.cgArray[this.index].id then
            return Vector3.one
        end
    end
    return Vector3.zero
end

this.SwitchShow = function()
    if this.hidden then
        this.hidden = false
        this.vm.data.element = Vector3.one
    else
        this.hidden = true
        this.vm.data.element = Vector3.zero
    end
end

this.SettingAtlas = function()
    local type = false
    for i = 1, #DataMgr.Player.selectedCG do
        if DataMgr.Player.selectedCG[i] == this.cgArray[this.index].id then
            type = true
            break
        end
    end
    if type then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2206"].NameLan)
        if this.GetTextureCount() < 2 then
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr);
            return
        end
    else
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2205"].NameLan)
        if this.GetTextureCount() == ConfigMgr.Config.constants.MaxSelectedCG then
            tipStr = string.format(tipStr,ConfigMgr.Config.constants.MaxSelectedCG)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr);
            return
        end
    end
    local tempData = {}
    tempData.ID = this.cgArray[this.index].id
    ApiMgr.Request("select_cg", tempData, true, function(result)
        local re = json.decode(result)
        if re.code == 0 then
            this.vm.data.toggle = this.ToggleState()
            LuaMgr.InvokeUIEventListeners(UIEventConst.CGNetRewardRefush,false)
            this.vm.data.count = "<size=28><color=#FFFFFF>"..this.GetTextureCount().."</color></size>/"..ConfigMgr.Config.constants.MaxSelectedCG
            if type then
               LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",LuaMgr.GetLangText("CGMapViewModel_3")); 
            else
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",LuaMgr.GetLangText("CGMapViewModel_4"));
            end
        end
    end, nil, true)
end

this.GetTextureCount = function()
    unlockCount = #DataMgr.Player.selectedCG






    return unlockCount
end

this.PopupGetTips = function()
    local tipStr = LuaMgr.GetLangText(this.cgArray[this.index].sourceTipLan)
    LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
end
this.GetReward = function()
    local tempData = {}
    tempData.ID = this.cgArray[this.index].id
    ApiMgr.Request("unlock_cg", tempData, true, function(result)
        local re = json.decode(result)
        if re.code == 0 then
            local rewared = json.encode(re.result)
            LuaMgr.ShowItemRewared(rewared)
            this.vm.data.showReward = false
            this.vm.data.showelement = true
            this.vm.data.toggle = this.ToggleState()
            this.vm.data.count = "<size=28><color=#FFFFFF>"..this.GetTextureCount().."</color></size>/"..ConfigMgr.Config.constants.MaxSelectedCG
            LuaMgr.InvokeUIEventListeners(UIEventConst.CGNetRewardRefush,true)
        end
    end, nil, true)
end
this.PlayAnimator = function()
    this.isClick = false
    LuaMgr.AddTimer(TimerConst.CGMapClickTime,function()
        this.isClick = true
    end,0.8,1,false)
    if this.vm.data.AminatorName == "UI_CGMapPopup_02" then
        this.vm.data.AminatorName = "UI_CGMapPopup_03"
    else
        this.vm.data.AminatorName = "UI_CGMapPopup_02"
    end
end

this.Shear = function()
    this.vm.data.element = Vector3.zero
    LuaMgr.HidePanel(UIName.MessageTipsViewModel)
    LuaMgr.HidePanel(UIName.NoticeRollhorseViewModel)
    local filename = "screenshot/shareScreenshot.png"
    LuaMgr.NextFrame(function()
        LuaMgr.CaptureScreenshot(filename)
        local path = UnityEngine.Application.persistentDataPath..'/'..filename
        LuaMgr.NextFrame(function()
            LuaMgr.ShowPanel("Laigu.ViewModel.SharePopupViewModel","collect",path,function()
                this.vm.data.element = Vector3.one
            end)
        end)
    end)
end
this.OpenButtons = function()
    if this.switchBool then
        this.vm.data.buttons = Vector3.zero
        this.vm.data.switch = true
        this.switchBool = false
    else
        this.vm.data.buttons = Vector3.one
        this.vm.data.switch = false
        this.switchBool = true
    end
end
return vm({
    data = data,
    command = command,
    hook = hook
})