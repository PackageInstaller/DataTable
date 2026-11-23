local this = {
   
};
local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local btnEnter = nil;
local textTime = nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    btnEnter = uiLink:Get("btnEnter"):GetComponent("Button");
    textTime = uiLink:Get("textTime"):GetComponent("Text");
    uiLink:AddClickEvent("btnEnter",this.BtnEnterCommand)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    btnEnter = nil;

end

this.BtnEnterCommand=function()
    LuaMgr.ShowLuaPanel(UIName.MiniBattle5ViewModel,"MiniBattle5")
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            local groupId = ActivityMgr.groupKeyList["MiniBattle5"]
            local activityData = DataMgr.Player.variables[groupId]
            local startTimeStr = ""
            local delayTimeStr = ""
            if activityData ~= nil then
                startTimeStr = string.format(LuaMgr.GetLangText("ActivityMiniBattle5ViewModel_0"),os.date("%m",activityData.startTime),os.date("%d",activityData.startTime))
                delayTimeStr = string.format(LuaMgr.GetLangText("ActivityMiniBattle5ViewModel_1"),os.date("%m",activityData.delTime),os.date("%d",activityData.delTime))
            end
            local tipStr = ConfigMgr.LangGlobal("15014")
            local timeStr = string.format("%s-%s",startTimeStr,delayTimeStr)
            textTime.text = tipStr .. timeStr
        end
    end,
    before_deactive = function(vm)
      
    end,
    before_destroy=function()
     
        this.Clear()
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})