






local this = {vm = nil}

local data = {
    inputValue="",
}

local command = {
    cancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
           LuaMgr.HidePanel(UIName.CharageCDKeyViewModel)
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.vm.data.inputValue=="" then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("1018"))
                return
            end
            this.CharageCDKey();
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm.data.inputValue="";
        this.CheckOpenByNFC()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    refresh = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.CheckOpenByNFC()
    end,
}

this.CharageCDKey=function()
    local data={
        Code=this.vm.data.inputValue
    }
    ApiMgr.Request("cdkey/reward",data,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        LuaMgr.HidePanel(UIName.CharageCDKeyViewModel)
    end,nil,true);
end

this.CheckOpenByNFC = function()
    if this.vm.behaviour.Params.Length > 0 and this.vm.behaviour.Params[0] == "NFC" then
        this.vm.data.inputValue = this.vm.behaviour.Params[1]
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})