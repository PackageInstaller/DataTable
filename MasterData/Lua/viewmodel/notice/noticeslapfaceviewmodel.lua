





local this = {vm=nil};

local ANIMA_OPEN = "UI_NoticeSlapfacePanel_01";
local ANIMA_CLOSE = "UI_NoticeSlapfacePanel_02";
local callBack=nil;
local tar_Url=nil;
local delayTime=0;
local slapfaceId=nil;


local data = {
    imageTexture=DefaultTexture,
    showAgainisOn=true,
    animaName="";
}

local command = {
    gotoBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          if tar_Url~=nil and tar_Url~="" then
              NoticeMgr.CompleteAD(1,2,slapfaceId);
              NoticeMgr.GoToPanel(tar_Url);
              delayTime=1;
              LuaMgr.HidePanel(UIName.NoticeSlapfaceViewModel)
          end
      end
    },
    closeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.animaName=ANIMA_CLOSE;
            coroutine_runner.start(function()
                coroutine_runner.wait(0.2)
                delayTime=0;
                LuaMgr.HidePanel(UIName.NoticeSlapfaceViewModel);
            end)
        end
    },
    showAgainBool={
        type=XLuaCommandType.Bool,
        execute=function(vm,ison,param)

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
        this.vm.data.showAgainisOn=true;
        if  vm.behaviour.Params.Length>0 then
            this.vm.data.animaName=ANIMA_OPEN;
            local data=vm.behaviour.Params;
            tar_Url=data[0];
            this.vm.data.imageTexture = data[1];
            slapfaceId=data[2];
            callBack = data[3]
        end

    end,
    before_deactive = function(vm)
        if callBack~=nil then
            callBack(this.vm.data.showAgainisOn,delayTime);
        end
    end,
}


return vm({
    data = data,
    command = command,
    hook = hook
})