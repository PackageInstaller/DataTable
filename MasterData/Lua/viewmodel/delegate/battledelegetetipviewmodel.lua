




local this = {vm=nil};
local callBack=nil;
local exitBattleCallback=nil;
local countTime=nil;
local infoText=nil;
local remainBattleCount=nil;
local data = {
   delegateCount="";
   ResetDelegateBattleTimeInfo="";
   battlingBool=false;
   battleDoneBool=false;
}

local command = {
    stopDelegateBattleBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.RemoveTimer(TimerConst.DelegateRemainTime);
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,LuaMgr.GetLangText("BattleDelegeteTipViewModel_6"),function()
                if exitBattleCallback~=nil then
                    exitBattleCallback();
                end
                DelegateBattleMgr.Clear();
                LuaMgr.HidePanel(UIName.BattleDelegeteTipViewModel);
            end, function()
                LuaMgr.AddTimer(TimerConst.DelegateRemainTime,this.RemainTimer,1,countTime+50,true);
            end)
            
        end
    },
    battleDoneBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.RemoveTimer(TimerConst.DelegateRemainTime);
            if exitBattleCallback~=nil then
                exitBattleCallback();
            end
            DelegateBattleMgr.Clear();
            LuaMgr.HidePanel(UIName.BattleDelegeteTipViewModel);
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
            callBack=vm.behaviour.Params[0]
            exitBattleCallback=vm.behaviour.Params[1];
            countTime=ConfigMgr.Config.constants.EntrustBattleWait;
            if countTime==nil or countTime==0 then
                countTime=5;
            end
            this.ParseData();
        end
    end,
    before_deactive = function(vm)

    end,
}

this.ParseData=function()
    local totalBattleCount=DelegateBattleMgr.GetDelegateTotalCount();
    remainBattleCount=DelegateBattleMgr.GetDelegateRemainCount()
    this.vm.data.battlingBool=remainBattleCount>0;
    this.vm.data.battleDoneBool=remainBattleCount==0;
    this.vm.data.delegateCount=string.format("%s/%s",totalBattleCount-remainBattleCount,totalBattleCount)

    if remainBattleCount>0 then
        infoText=LuaMgr.GetLangText("BattleDelegeteTipViewModel_0");
    else
        infoText=LuaMgr.GetLangText("BattleDelegeteTipViewModel_1");
    end
    LuaMgr.RemoveTimer(TimerConst.DelegateRemainTime);
    LuaMgr.AddTimer(TimerConst.DelegateRemainTime,this.RemainTimer,1,countTime+50,true);
end

this.RemainTimer=function()
    this.vm.data.ResetDelegateBattleTimeInfo=string.format("<color=#ec3839>%s</color>%s",countTime,infoText)
    if countTime<0 then
        LuaMgr.RemoveTimer(TimerConst.DelegateRemainTime);
        if callBack~=nil then
            callBack();
        end
        if remainBattleCount==0 and exitBattleCallback~=nil then
            exitBattleCallback();
        end
        LuaMgr.HidePanel(UIName.BattleDelegeteTipViewModel)
    end
    countTime=countTime-1;
end

return vm({
    data = data,
    command = command,
    hook = hook
})