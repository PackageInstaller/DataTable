require("ViewModel/Rogue/Rogue_TopResItem")

local this = {
    vm = nil,
    resUIList={},
    resItemObj=nil;
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.root = uiLink:Get("root"):GetComponent("UIAnimator");
    ui.tranPrefabRoot = uiLink:Get("tranPrefabRoot"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
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
        print("before_awake");
        this.InitUI(vm.behaviour)
        this.resUIList = UIListView.New(ui.tranPrefabRoot);
        this.resItemObj = vm.behaviour.transform:Find("template/resourseItem").gameObject
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            LuaMgr.RemoveUIEventListener(UIEventConst.RogueUpdateTopRes,this.ParseData)
            LuaMgr.AddUIEventListener(UIEventConst.RogueUpdateTopRes, this.ParseData);
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if this.resUIList~= nil then
            this.resUIList:Clear();
        end
        LuaMgr.RemoveUIEventListener(UIEventConst.RogueUpdateTopRes,this.ParseData)
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Rogue_TopResItem")
    end
}

this.GetResNum=function(id)
    if IsNull(DataMgr.Player.Rogue) then return 0 end;
    if id=="5131" then
        return DataMgr.Player.Rogue.Shell
    elseif id=="5132" then
        return DataMgr.Player.Rogue.StarDust
    elseif id=="5133" then
        return DataMgr.Player.Rogue.Oxygen
    end
end


this.ParseData=function()
    this.resUIList:Clear();
    local list={}
local resIds={"5131","5133"}
    for i,v in ipairs(resIds) do
        local resItem={
            itemId=v,
            num=this.GetResNum(v);
        }
        if resItem.itemId=="5133" then
            resItem.num=resItem.num.."/"..ConfigMgr.Config.RogueConstants.RogueInitialMoveLimit+RogueExploreMgr.CheckIsAddOxygenMaxLimit(); 
        end
        local resData=UIListData.GetData(this.resItemObj,"Rogue_TopResItem",resItem);
        table.insert(list,resData);
    end
    this.resUIList:SetData(list);
end


return vm({
    data = data,
    command = command,
    hook = hook
})