
local this = {vm = nil}

local cfgSetting=nil;
local rectTransform=nil;
local callBack = nil
local normalLenMax = 22
local normalLenMin = 16

local data = {
    settingTipsWidth=Vector2(300,70);
    settingTipsPos=Vector2(0,0);
    settingTipsText="";
}

local command = {
    clickMask = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.AttrDescTipsViewModel);
            if callBack then
                callBack()
            end
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
        local text = vm.behaviour.Params[1]
        callBack = vm.behaviour.Params[2]
        this.ParseData(worldPos, text);
    end,
    before_deactive = function(vm)
       
    end,
}

this.ParseData=function(worldPos, des)
local listDes=Split(des,"\n");
    local len=0;
for i = 1, #listDes, 1 do
        len=math.max(LuaMgr.GetStringLength(listDes[i]),len);
    end
    local lineBreaksValue=0
for word in string.gmatch(des, "\n") do
        lineBreaksValue = lineBreaksValue + 1
    end
    
    local scrPos=LuaMgr.World2Local(worldPos,rectTransform);
    local width = 345
    local lenMax = normalLenMax
    local i, j = string.find(des, "\n")
    if i then
        local index = math.ceil((i - 1) / 3)
        if index >= normalLenMin and index <= normalLenMax then
            lenMax = index
            print("index:" .. index)
        end
    end
    if len > 16 then
        width = width + ((len > lenMax and lenMax or len) - 16) * 20
    end
    this.vm.data.settingTipsPos=scrPos+Vector2(200,-80);
    this.vm.data.settingTipsText=des;
    this.vm.data.settingTipsWidth=Vector2(width,30+20*math.ceil(len/lenMax)+(20*lineBreaksValue))
end

return vm({
    data = data,
    command = command,
    hook = hook,
})