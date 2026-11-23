






local this = {
    vm=nil,
    rewardMap=nil;
};

local tarGameObject = nil;
local tarRect = nil;
local btnMask = nil;
local btnRestart = nil;
local btnExit = nil;
local imgFlower1 = nil;
local imgFlower11 = nil;
local imgFlower2 = nil;
local imgFlower21 = nil;
local imgFlower3 = nil;
local imgFlower31 = nil;
local txtTimer = nil;
local tranReward = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnRestart = uiLink:Get("btnRestart"):GetComponent("Button");
    btnExit = uiLink:Get("btnExit"):GetComponent("Button");
    imgFlower1 = uiLink:Get("imgFlower1"):GetComponent("Image");
    imgFlower11 = uiLink:Get("imgFlower11"):GetComponent("Image");
    imgFlower2 = uiLink:Get("imgFlower2"):GetComponent("Image");
    imgFlower21 = uiLink:Get("imgFlower21"):GetComponent("Image");
    imgFlower3 = uiLink:Get("imgFlower3"):GetComponent("Image");
    imgFlower31 = uiLink:Get("imgFlower31"):GetComponent("Image");
    txtTimer = uiLink:Get("txtTimer"):GetComponent("Text");
    tranReward = uiLink:Get("tranReward"):GetComponent("RectTransform");
    this.AddRegister(uiLink);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    btnMask = nil;
    btnRestart = nil;
    btnExit = nil;
    imgFlower1 = nil;
    imgFlower11 = nil;
    imgFlower2 = nil;
    imgFlower21 = nil;
    imgFlower3 = nil;
    imgFlower31 = nil;
    txtTimer = nil;
    tranReward = nil;

end




this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()

    end)
    uiLink:AddClickEvent("btnExit",function()
        if this.callBack~=nil then
            this.callBack(true);
            LuaMgr.HidePanel(UIName.RefractionResultViewModel)
        end
    end)
    uiLink:AddClickEvent("btnRestart",function()
        if this.callBack~=nil then
            this.callBack(false);
            LuaMgr.HidePanel(UIName.RefractionResultViewModel)
        end
    end)
   
end


local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>0 then
                AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_failed.mp3");
                this.cfgLevelGame=vm.behaviour.Params[0]
                this.time=vm.behaviour.Params[1];
                this.isShow=vm.behaviour.Params[2];
                this.callBack=vm.behaviour.Params[3];
                this.ParseData();
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if this.rewardMap~=nil then
                for i,v in pairs(this.rewardMap) do
                    SetActive(v.transform.gameObject,false);
                end
            end
        end
    end,
    before_destroy=function()
        this.Clear();
    end
    
    
}

this.ParseData=function()
    imgFlower1.sprite=LuaMgr.GetSprite("Refraction",this.cfgLevelGame.RayTargetPic)
    imgFlower2.sprite=LuaMgr.GetSprite("Refraction",this.cfgLevelGame.RayTargetPic)
    imgFlower3.sprite=LuaMgr.GetSprite("Refraction",this.cfgLevelGame.RayTargetPic)
    imgFlower11.sprite=LuaMgr.GetSprite("Refraction",this.cfgLevelGame.RayTargetPic.."-1")
    imgFlower21.sprite=LuaMgr.GetSprite("Refraction",this.cfgLevelGame.RayTargetPic.."-1")
    imgFlower31.sprite=LuaMgr.GetSprite("Refraction",this.cfgLevelGame.RayTargetPic.."-1")
    txtTimer.text=string.format("%.2f",this.time).."S";
    if not this.isShow then 
        return;
    end
    this.ShowRewards();
end

this.ShowRewards=function()
    if this.rewardMap==nil then
        this.rewardMap={}
    end
    for i,v in ipairs(this.cfgLevelGame.Reward) do
        if this.rewardMap[i]==nil then
            this.rewardMap[i]=GoodsDataItem.New(tranReward)
        end
        SetActive(this.rewardMap[i].transform.gameObject,true)
        local itemConfig = table.Copy(ConfigMgr.Config.itemMap[v.id]);
        itemConfig.count0 =v.count;
        this.rewardMap[i]:SetData(1, itemConfig, 1, false, Vector3.one*0.65, false);
        
    end
end

return vm({
    data = nil,
    command = nil,
    hook = hook
})