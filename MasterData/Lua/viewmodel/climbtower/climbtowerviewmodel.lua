






local this = {vm=nil};

local camera_Animator=nil;
local camera_AnimaName_1="UI_pata_xj_01";
local camera_AnimaName_2="UI_pata_xj_02";

local coroutineKey1=nil;
local coroutineKey2=nil;

local animator=nil;

local animator_AnimaName_1="UI_ClimbtowerPanel_pata_01";
local animator_AnimaName_2="UI_ClimbtowerPanel_pata_02";

local stopClick=false;

local data = {
   middleBool=false;
   middleMask=false;
}

local command = {

    simulateBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          if stopClick then return end;
          stopClick=true;
          AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/enter_click.mp3")
          this.PlayEnterAnima();
      end
    },

    destructBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/enter_click.mp3")
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ClimbtowerViewModel_0"));


        end
    },

}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
        camera_Animator=UnityEngine.GameObject.Find("MainCamera"):GetComponent("Animator");
        animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.vm.data.middleBool=false;
        this.vm.data.middleMask=false;
        stopClick=false;
        this.PlayCameraAnima();
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/climb_enter.mp3")
       
    end,
    before_deactive = function(vm)
        if coroutineKey1~=nil then
            coroutine_runner.stop(coroutineKey1);
        end
        print("before_deactive");
        this.vm.data.middleMask=false;
    end,
}

this.OnBack=function()
    LuaMgr.BackScene();
end


this.PlayCameraAnima=function()
    if coroutineKey1~=nil then
        coroutine_runner.stop(coroutineKey1);
    end 
    coroutineKey1=coroutine_runner.start(function()
        camera_Animator:Play(camera_AnimaName_1);
        coroutine_runner.wait(0.6)
        this.vm.data.middleBool=true;
        animator:Play(animator_AnimaName_1);
    end)
   
end

this.PlayEnterAnima=function()

    if coroutineKey2~=nil then
        coroutine_runner.stop(coroutineKey2);
    end
    this.vm.data.middleMask=true;
    coroutineKey2=coroutine_runner.start(function()
        animator:Play(animator_AnimaName_2);
        coroutine_runner.wait(0.5)
        this.vm.data.middleBool=false;
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/climb_access.mp3")
        camera_Animator:Play(camera_AnimaName_2);
        coroutine_runner.wait(1)
        stopClick=false;
        LuaMgr.ShowLuaPanel(UIName.ClimbsimulateViewModel);
    end)
    
end


return vm({
    data = data,
    command = command,
    hook = hook
})