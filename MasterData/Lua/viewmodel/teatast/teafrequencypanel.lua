







local this = {
    vm = nil,
}

local playing=false;
local rectOne=nil;
local rectTwo=nil;
local clickNum=0;
local status=0;

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

            clickNum=clickNum+1;
            
            if clickNum<=3 then
                return
            end
            
            LuaMgr.HidePanel(UIName.TeaFrequencyPanel)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm

        rectOne = this.vm.behaviour.transform:Find("root/rectOne"):GetComponent("Transform")
        rectTwo = this.vm.behaviour.transform:Find("root/rectTwo"):GetComponent("Transform")

        rectOne.gameObject:SetActive(false);
        rectTwo.gameObject:SetActive(false);
    end,

    before_active = function(vm)
        local params = vm.behaviour.Params;
        clickNum = 0;
        status = 0;
        if (params == nil) then
            return
        end

        status = params[0];
        playing = true;
        coroutine_runner.start(function()

            rectOne.gameObject:SetActive(status == 1);
            rectTwo.gameObject:SetActive(status == 2);
            if status == 1 then
AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_maketea.mp3");
            elseif status == 2 then
AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_levelup.mp3");
            end
            
            coroutine_runner.wait(3.0)

            LuaMgr.HidePanel(UIName.TeaFrequencyPanel)
            AudioMgr.Singleton:StopVoice();
            playing = false;
        end)

    end,
    before_deactive = function(vm)

        if status == 1 then
            LuaMgr.InvokeUIEventListeners(UIEventConst.TeaFrequencyPanelClose)
        end
        
        clickNum = 0;
        status = 0;
    end,

    before_destroy = function(vm)
        rectOne = nil;
        rectTwo = nil;
    end
}

return vm(
{
    data = data,
    command = command,
    hook = hook
}
)