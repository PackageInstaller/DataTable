



local this = {vm = nil}

local cfgSetting=nil;
local rectTransform=nil;

local data = {

    settingTipsWidth=Vector2(300,70);
    settingTipsPos=Vector2(0,0);
    settingTipsText="";
}

local command = {
    clickMask = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TextTipsViewModel);
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        rectTransform=vm.behaviour.transform:Find('root/Middle'):GetComponent('RectTransform')
    end,

    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
       local worldPos = vm.behaviour.Params[0]
        local id = vm.behaviour.Params[1]
        cfgSetting=ConfigMgr.Config.settings;
        this.ParseData(worldPos,id);
    end,
    before_deactive = function(vm)
       
    end,
}

this.ParseData=function(worldPos,id)
    local setting=cfgSetting[tonumber(id)+1];
    local des=LuaMgr.GetLangText(setting.settingsDescriptionLan);
    local len=LuaMgr.GetStringLength(des);
    local scrPos=LuaMgr.World2Local(worldPos,rectTransform);
    scrPos.x = scrPos.x + 53;
    scrPos.y = scrPos.y + 65;
    this.vm.data.settingTipsPos=scrPos;
    this.vm.data.settingTipsText=des;
    this.vm.data.settingTipsWidth=Vector2(300,30+20*math.ceil(len/17))
end

return vm({
    data = data,
    command = command,
    hook = hook,
})