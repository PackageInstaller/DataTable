





local this = {vm=nil}
local nowStatus = 1

local leftTimeStatus_1 = 11

local data = {
    isShowStatus_1 = false,
    isShowTimeBtnStatus_1 = false,
    isShowConfirmBtnStatus_1 = false,
    titleStatus_1 = "",
    contentStatus_1 = "",
    leftTimeTextStatus_1 = "",
    toggleIsOnStatus_1 = false,

    isShowStatus_2 = false,
    uidStatus_2 = "",
    nameStatus_2 = "",
    levelStatus_2 = "",
    contentStatus_2 = "",

    isShowStatus_3 = false,
    contentStatus_3 = "",

    isShowStatus_4 = false,
    contentStatus_4 = "",
}

local command = {
    toggleStatus_1 = {
        type=XLuaCommandType.Bool,
        execute=function(vm,isOn,param)
            this.vm.data.toggleIsOnStatus_1 = isOn
            if this.vm.data.toggleIsOnStatus_1 == true and leftTimeStatus_1 < 0 then
                this.vm.data.isShowTimeBtnStatus_1 = false
                this.vm.data.isShowConfirmBtnStatus_1 = true
            else
                this.vm.data.isShowTimeBtnStatus_1 = true
                this.vm.data.isShowConfirmBtnStatus_1 = false
            end
        end
    },
    cancelBtnStatus_1={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          LuaMgr.HidePanel(UIName.CancelAccountViewModel);
      end
    },
    confirmBtnStatus_1={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.SetStatus(2)
        end
    },
    cancelBtnStatus_2={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.HidePanel(UIName.CancelAccountViewModel);
        end
    },
    confirmBtnStatus_2={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            ApiMgr.Request("cancellation_account",{},true,this.OnCancelAccountSuccess,nil,false);
        end
    },
    cancelBtnStatus_3={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            ApiMgr.Request("recovery_account",{},true,this.OnRecoveryAccountSuccess,nil,false);
        end
    },
    confirmBtnStatus_3={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.HidePanel(UIName.CancelAccountViewModel);
        end
    },
    cancelBtnStatus_4={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.HidePanel(UIName.CancelAccountViewModel);
        end
    },
    confirmBtnStatus_4={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            ApiMgr.Request("recovery_account",{},true,this.OnRecoveryAccountSuccess,nil,false);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end

        this.vm.data.toggleIsOnStatus_1 = false
        if DataMgr.Player.status == 4 then
            this.SetStatus(4)
        else
            this.SetStatus(1)
        end
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.CancelAccountTimeCount)
        LuaMgr.RemoveTimer(TimerConst.CancelAccountCountDown)
    end,
}

this.SetStatus = function(status)
    if status == nil then
        nowStatus = 1
    else
        nowStatus = status
    end

    if nowStatus == 1 then
        this.vm.data.isShowStatus_1 = true
        this.vm.data.isShowStatus_2 = false
        this.vm.data.isShowStatus_3 = false
        this.vm.data.isShowStatus_4 = false

        this.vm.data.titleStatus_1 = LuaMgr.GetLangText('privacypolicylan_privacypolicy_titlelan_6')
        this.vm.data.contentStatus_1 = LuaMgr.GetLangText('privacypolicylan_privacypolicy_contentlan_6')

        this.vm.data.isShowTimeBtnStatus_1 = true
        this.vm.data.isShowConfirmBtnStatus_1 = false
        leftTimeStatus_1 = 11
        LuaMgr.AddTimer(TimerConst.CancelAccountTimeCount, this.OnTimerStatus_1, 1, -1, true)
    elseif nowStatus == 2 then
        this.vm.data.isShowStatus_1 = false
        this.vm.data.isShowStatus_2 = true
        this.vm.data.isShowStatus_3 = false
        this.vm.data.isShowStatus_4 = false

        this.vm.data.contentStatus_2 = string.format(LuaMgr.GetLangText('LangGlobalLan_LangGlobal_name_1205'), LuaMgr.UnixToDateTimeStr(LuaMgr.TimeStamp(-1, -1, -1, -1, -1, -1) + 7 * 24 * 60 * 60))

        this.vm.data.uidStatus_2 = string.format("UID：<color=#ffffff>%s</color>", DataMgr.Player.uid)
        this.vm.data.nameStatus_2 = string.format(LuaMgr.GetLangText("CancelAccountPanel_0"), DataMgr.Player.name)
        this.vm.data.levelStatus_2 = string.format(LuaMgr.GetLangText("CancelAccountPanel_1"), DataMgr.Player.level)
    elseif nowStatus == 3 then
        this.vm.data.isShowStatus_1 = false
        this.vm.data.isShowStatus_2 = false
        this.vm.data.isShowStatus_3 = true
        this.vm.data.isShowStatus_4 = false

        this.vm.data.contentStatus_2 = string.format(LuaMgr.GetLangText('LangGlobalLan_LangGlobal_name_1206'), LuaMgr.UnixToDateTimeStr(DataMgr.Player.cancellationTime))
    elseif nowStatus == 4 then
        this.vm.data.isShowStatus_1 = false
        this.vm.data.isShowStatus_2 = false
        this.vm.data.isShowStatus_3 = false
        this.vm.data.isShowStatus_4 = true

        this.vm.data.uidStatus_2 = string.format("UID：<color=#ffffff>%s</color>", DataMgr.Player.uid)
        this.vm.data.nameStatus_2 = string.format(LuaMgr.GetLangText("CancelAccountPanel_2"), DataMgr.Player.name)
        this.vm.data.levelStatus_2 = string.format(LuaMgr.GetLangText("CancelAccountPanel_3"), DataMgr.Player.level)
        
        LuaMgr.AddTimer(TimerConst.CancelAccountCountDown, this.OnTimerStatus_4, 1, -1, true)
    end
end

this.OnTimerStatus_1 = function()
    leftTimeStatus_1 = leftTimeStatus_1 - 1
    if leftTimeStatus_1 < 0 then
        if this.vm.data.toggleIsOnStatus_1 then
            this.vm.data.isShowTimeBtnStatus_1 = false
            this.vm.data.isShowConfirmBtnStatus_1 = true
        else
            this.vm.data.isShowTimeBtnStatus_1 = true
            this.vm.data.isShowConfirmBtnStatus_1 = false
        end
        this.vm.data.leftTimeTextStatus_1 = LuaMgr.GetLangText("CancelAccountPanel_4")
        LuaMgr.RemoveTimer(TimerConst.CancelAccountTimeCount)
        return
    end
    this.vm.data.leftTimeTextStatus_1 = string.format(LuaMgr.GetLangText("CancelAccountPanel_5"), leftTimeStatus_1)
end

this.OnTimerStatus_4 = function()
    local leftTime = tonumber(DataMgr.Player.cancellationTime - LuaMgr.TimeStamp(-1, -1, -1, -1, -1, -1))
    if leftTime < 0 then
        LuaMgr.RemoveTimer(TimerConst.CancelAccountCountDown)
    end
    this.vm.data.contentStatus_4 = string.format(LuaMgr.GetLangText('LangGlobalLan_LangGlobal_name_1207'), LuaMgr.SecondTo_HMS2(leftTime))
end

this.OnCancelAccountSuccess = function(result)
    this.SetStatus(3)
    LuaMgr.InvokeUIEventListeners(UIEventConst.CancelAccountRefresh);
end

this.OnRecoveryAccountSuccess = function(result)
    LuaMgr.InvokeUIEventListeners(UIEventConst.CancelAccountRefresh);
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("CancelAccountPanel_6"));
    LuaMgr.HidePanel(UIName.CancelAccountViewModel);
end

return vm({
    data = data,
    command = command,
    hook = hook
})