






local this = {
    vm=nil,
    reward=nil,
    voicePath=nil,
   
};
local cfgLottery=nil;
local isVoicePlay=false
local callBack=nil;

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local btnVoice = nil;
local btnClose = nil;
local tranReward=nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    tranReward=uiLink:Get("tranReward"):GetComponent("RectTransform");
    btnVoice = uiLink:Get("btnVoice"):GetComponent("Button");
    btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    
    uiLink:AddClickEvent("btnVoice",function()
        if isVoicePlay then return end;
        AudioMgr.Singleton:PlayVoice(this.voicePath);
    end)
    uiLink:AddClickEvent("btnClose",function()
        if isVoicePlay then return end;
        LuaMgr.HidePanel(UIName.WalkMountCardViewModel)
        if callBack~=nil then
            callBack()
        end
    end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    btnVoice = nil;
    btnClose = nil;

end



local data = {
}


local command = {
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
     
      
    end,
    before_active = function(vm)
        if vm.behaviour.Params ~= nil and vm.behaviour.Params.Length>1 then
            local  id=vm.behaviour.Params[0]
            callBack=vm.behaviour.Params[1]
            cfgLottery=ConfigMgr.Config.LotteryMap[id];
            isVoicePlay=false;
           this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
            AudioMgr.Singleton:StopVoice(false);
        end
    end,
    before_destroy=function()
       
    end
        
    
}

this.ParseData=function()
    if cfgLottery.Voice~=nil and  cfgLottery.Voice~="" then
        this.voicePath=string.format("%sTourismVoice/%s.mp3",Path.audio_PATH,cfgLottery.Voice)
        isVoicePlay=true;
        local audioSource=AudioMgr.Singleton:PlayVoice(this.voicePath);
        coroutine_runner.start(function()
            coroutine_runner.wait(audioSource.clip.length)
            isVoicePlay=false;
        end);
    end

    local reward=cfgLottery.Reward[1]
    if this.reward==nil then
        this.reward=GoodsDataItem.New(tranReward)
    end
    local itemConfig = ConfigMgr.Config.itemMap[reward.id]
    itemConfig["count0"] = reward.count
    this.reward:SetData(1,itemConfig,1,false,Vector3(1,1,1),false)
end



return vm({
    data = data,
    command = command,
    hook = hook
})