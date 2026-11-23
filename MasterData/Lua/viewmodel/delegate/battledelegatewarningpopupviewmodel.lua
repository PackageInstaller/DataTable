




local this = {vm=nil};

local stopCallBack=nil;
local continueCallBack=nil;
local countTime=nil;
local againBool=false;

local data = {
    timeInfo="";
}

local command = {
    stopBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if stopCallBack~=nil then
                stopCallBack(againBool);
            end
          LuaMgr.HidePanel(UIName.BattleDelegateWarningPopupViewModel);
        end
    },
    continueBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if continueCallBack~=nil then
                continueCallBack(againBool);
            end
            LuaMgr.HidePanel(UIName.BattleDelegateWarningPopupViewModel);
        end
    },
    
    againBool={
        type=XLuaCommandType.Bool,
        execute=function(vm,isOn)
            againBool=isOn;
        end
    }
    

}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            continueCallBack=vm.behaviour.Params[0];
            stopCallBack=vm.behaviour.Params[1]
            countTime=ConfigMgr.Config.constants.EntrustBattleWait;
            if countTime==nil or countTime==0 then
                countTime=5;
            end
            againBool=false;
            LuaMgr.RemoveTimer(TimerConst.DelegateRemainTime);
            LuaMgr.AddTimer(TimerConst.DelegateRemainTime,this.RemainTimer,1,countTime+50,true);
            
        end
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.DelegateRemainTime);
        stopCallBack=nil;
        continueCallBack=nil;
        countTime=nil;
        againBool=nil;
    end,
}

this.RemainTimer=function()
    this.vm.data.timeInfo=string.format(LuaMgr.GetLangText("BattleDelegateWarningPopupViewModel_0"),countTime)
    if countTime<0 then
        LuaMgr.RemoveTimer(TimerConst.DelegateRemainTime);
        if continueCallBack~=nil then
            continueCallBack(againBool);
        end
        LuaMgr.HidePanel(UIName.BattleDelegateWarningPopupViewModel)
    end
    if countTime~=nil then
        countTime=countTime-1;
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})