require("ViewModel/Rogue/Rogue_ExploreTipItem")

local this = {
    vm = nil,
    tipsVMList={};
    tipsItem=nil;
};
local cokey=nil;

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.goExploreLevel = uiLink:Get("goExploreLevel");
    ui.tranTipContent = uiLink:Get("tranTipContent"):GetComponent("RectTransform");
    ui.txtLevel = uiLink:Get("txtLevel"):GetComponent("Text");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
   
end


local data = {

}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.InitUI(vm.behaviour)
        this.tipsVMList={}
        this.tipsItemObj=vm.behaviour.transform:Find("template/RogueTipItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            LuaMgr.RemoveUIEventListener(UIEventConst.RogueEventTip,this.SetEventTip)
            LuaMgr.AddUIEventListener(UIEventConst.RogueEventTip,this.SetEventTip);
            SetActive(ui.goExploreLevel,false);
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if vm.behaviour.Params == nil then return end;
        LuaMgr.RemoveUIEventListener(UIEventConst.RogueEventTip,this.SetEventTip)
        this.ClearTips();
        if cokey~=nil then
            coroutine_runner.stop(cokey);
        end
    end,
    before_destroy = function()
        this.tipsVMList={}
        this.ClearUI()





    end
}

this.ParseData=function()
   
end

this.SetEventTip=function(params)
    if params.Length==1 then
        this.ShowExploreLevelInfo(params[0])
    elseif params.Length>2 then
        this.SetItemTips(params)
    end
  
end

this.SetItemTips=function(params)
    local tipVM=nil;
    if #this.tipsVMList==0 then
        tipVM=Rogue_ExploreTipItem.New(ui.tranTipContent,this.tipsItemObj);
    else
        tipVM=this.tipsVMList[1];
        table.remove(this.tipsVMList,1);
    end
    local id,count,tip=params[0],params[1],params[2]
    tipVM:SetData(id,count,tip);
    coroutine_runner.start(function()
        coroutine_runner.wait(1.5);
        if tipVM~=nil and this.tipsVMList~=nil then
            SetActive(tipVM.gameObject,false);
            table.insert(this.tipsVMList,tipVM);
        end
    end)
end

this.ClearTips=function()
    if this.tipsVMList~=nil and  #this.tipsVMList>0 then
        for i,v in ipairs(this.tipsVMList) do
            SetActive(v.gameObject,false);
        end
    end
end

this.ShowExploreLevelInfo=function(levelInfo)

    SetActive(ui.goExploreLevel,false);
    SetActive(ui.goExploreLevel,true);
    ui.txtLevel.text=string.format(ConfigMgr.LangGlobal("26525"),levelInfo);
    if cokey~=nil then
        coroutine_runner.stop(cokey);
    end
    cokey=coroutine_runner.start(function()
        coroutine_runner.wait(6)
        if ui~=nil and  ui.goExploreLevel~=nil then
            SetActive(ui.goExploreLevel,false);
        end
    end)
end

return vm({
    data = data,
    command = command,
    hook = hook
})