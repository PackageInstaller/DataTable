




local this = {vm=nil};

local callBack=nil;
local data = {

   buffInfo="";
}

local command = {
    stopDelegateBattleBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            DelegateBattleMgr.timeScale=UnityEngine.Time.timeScale;
            UnityEngine.Time.timeScale=0;
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,LuaMgr.GetLangText("BattleDelegetingViewModel_0"),function()
                
                UnityEngine.Time.timeScale=DelegateBattleMgr.timeScale;
                if callBack~=nil then
                    callBack();
                end
                UnityEngine.PlayerPrefs.SetInt("Stop_Delegate", 1)
                DelegateBattleMgr.Clear();
                LuaMgr.HidePanel(UIName.BattleDelegetingViewModel)
            end,function()
                UnityEngine.Time.timeScale=DelegateBattleMgr.timeScale;
            end);
            
        end
    },

}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
      
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            callBack=vm.behaviour.Params[0];

            local total=DelegateBattleMgr.GetDelegateTotalCount();

            local entrustBattleBuff=ConfigMgr.Config.constants.EntrustBattleBuff;
            local buff = ConfigMgr.Config.buffMap[entrustBattleBuff];
            this.vm.data.buffInfo=LuaMgr.GetLangText(buff.DescriptionLan);
        end
    end,
    before_deactive = function(vm)
        callBack=nil;
    end,
}


return vm({
    data = data,
    command = command,
    hook = hook
})