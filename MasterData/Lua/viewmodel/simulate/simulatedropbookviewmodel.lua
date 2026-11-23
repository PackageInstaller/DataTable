
require("ViewModel/Simulate/Simulate_DropBookItem")

local this = {
    vm = nil,
    matBookUIList={};
    matBookItemObj=nil;
};

local posList={Vector2(54,-30),Vector2(204,127.7),Vector2(278.6,-186.4),Vector2(425.9,-29.4),Vector2(676.8,93.1),
               Vector2(840,-75.1), Vector2(999.6,100),Vector2(1112,-189),Vector2(1267,0)}

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranMatContent = uiLink:Get("tranMatContent"):GetComponent("RectTransform");

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
        print("before_awake");
        this.InitUI(vm.behaviour)
        this.matBookUIList=UIListView.New(ui.tranMatContent);
        this.matBookItemObj=vm.behaviour.transform:Find("template/matBookItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.matList={}
            for i,v in pairs(ConfigMgr.Config.SimulateCatchMaterialMap) do
                if v.Istrans==0 then
                    table.insert(this.matList,v);
                end
            end
            table.sort(this.matList,function(a, b) return tonumber(a.Id)<tonumber(b.Id) end)
            this.ParseData();
            this.ParseData();
        end
        
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.matBookUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_DropBookItem")
    end
}

this.ParseData=function()
    this.dataGame=DataMgr.Player.SimulateGame;
    this.SetMatBookUIList();
end

this.SetMatBookUIList=function()
    this.matBookUIList:Clear();
    local list={}
    for i,v in ipairs(this.matList) do
        local matItem={
           iconName=v.Icon,
           maxCount=v.Limit,
           pos=posList[i],
           count=this.GetMyCount(v.Id)
        }
        local matData=UIListData.GetData(this.matBookItemObj,"Simulate_DropBookItem",matItem);
        table.insert(list,matData);
    end
    this.matBookUIList:SetData(list);
end

this.GetMyCount=function(id)
    if IsNull(this.dataGame.Items) or this.dataGame.Items[id]==nil then
        return 0;
    end
    return this.dataGame.Items[id];
end

return vm({
    data = data,
    command = command,
    hook = hook
})