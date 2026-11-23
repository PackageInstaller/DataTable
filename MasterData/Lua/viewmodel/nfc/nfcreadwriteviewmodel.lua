local this = {
    vm = nil,
}
local data = {
    readPanelIsOn = false,
    writePanelIsOn = false,
    writeTipsPanelIsOn = false,
    nfcRecordsContent = "",
    inputNfcContent = "",
    nfcTipsContent = "",
}

local command = {
    closeWriteBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.RemoveUIEventListener(UIEventConst.OnNfcWriteFinish, this.OnNfcWriteFinish);
            LuaMgr.HidePanel(UIName.NFCReadWriteViewModel)
        end
    },
    closeReadBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.RemoveUIEventListener(UIEventConst.OnNfcReadFinish, this.OnNfcReadFinish);
            LuaMgr.HidePanel(UIName.NFCReadWriteViewModel)
        end
    },
    closeTipsBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.writeTipsPanelIsOn = false
        end
    },
    startWriteBtn = {
        type = XLuaCommandType.Void,
        execute =function(vm, param)
            local newNfcContent = this.vm.data.inputNfcContent
            this.vm.data.writeTipsPanelIsOn = true

            if(newNfcContent == "") then
                this.vm.data.nfcTipsContent = "no text"
                return
            end

            this.vm.data.nfcTipsContent = "Hold on your nfc to phone"
            LuaMgr.WriteNewNfcDataByString(newNfcContent)
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
    after_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
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
    local openPanelName = this.vm.behaviour.Params[0]

    if openPanelName == "Read" then
        this.vm.data.readPanelIsOn = true
        this.vm.data.writePanelIsOn = false

        LuaMgr.AddUIEventListener(UIEventConst.OnNfcReadFinish, this.OnNfcReadFinish);
    else
        this.vm.data.readPanelIsOn = false
        this.vm.data.writePanelIsOn = true

        LuaMgr.AddUIEventListener(UIEventConst.OnNfcWriteFinish, this.OnNfcWriteFinish);
    end
end

this.OnNfcReadFinish = function(args)
    local tempData = json.decode(args[0])
    local recordsContent = ""
    for i, arg in ipairs(tempData) do
        recordsContent = recordsContent..arg.Type.."\n"..arg.Content.."\n"
    end

    this.vm.data.nfcRecordsContent = recordsContent
end

this.OnNfcWriteFinish = function(args)
    this.vm.data.writeTipsPanelIsOn = true
    this.vm.data.nfcTipsContent = args[0]
end

return vm({
    data = data,
    command = command,
    hook = hook
}) 