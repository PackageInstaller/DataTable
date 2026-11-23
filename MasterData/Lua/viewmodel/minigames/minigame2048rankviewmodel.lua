local this = {
    vm = nil,
    rankData = {},
    scrollViewRank=nil,
}

require("ViewModel/MiniGames/UI2048RankItem")

local tarGameObject = nil;
local tarRect = nil;
local UI2048RankItemPrefab = nil;
local root = nil;
local Middle = nil;
local goRoot = nil;
local scrollViewRank = nil;
local goLeftText=nil;
local goNoData=nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    UI2048RankItemPrefab = uiLink:Get("UI2048RankItem");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    goRoot = uiLink:Get("goRoot");
    goLeftText=uiLink:Get("goLeftText");
    goNoData=uiLink:Get("goNoData");
    scrollViewRank = uiLink:Get("scrollViewRank"):GetComponent("ScrollRect");
    uiLink:AddClickEvent("btnClose", function()
        LuaMgr.Back();
    end)
end

this.InitPanel=function ()
    if #this.rankData==0 or TableIsNull(this.rankData) then
        SetActive(goNoData,true);
        SetActive(goLeftText,false);
    else
        SetActive(goNoData,false);
        SetActive(goLeftText,true);
    end
end

this.ShowSVResult = function()
    local scrollDatas={};
    this.scrollViewRank:Clear(false);
    for index, value in ipairs(this.rankData) do
        local tempData = table.Copy(value);
        tempData.Index = index;
        local scrollData = UIScrollData.GetData(UI2048RankItemPrefab, "UI2048RankItem", 880,
            80, tempData);
        table.insert(scrollDatas, scrollData);
    end
    this.scrollViewRank:SetParams(880, 380);
    this.scrollViewRank:SetData(scrollDatas);
    this.scrollViewRank:Refresh()
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    UI2048RankItemPrefab = nil;
    root = nil;
    Middle = nil;
    goRoot = nil;
    scrollViewRank = nil;
    goLeftText=nil;
    goNoData=nil;
end

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.Init(vm.behaviour.gameObject)
        this.scrollViewRank = UIScrollView.New(scrollViewRank.gameObject)
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            this.rankData = vm.behaviour.Params[0]
            this.InitPanel();
            this.ShowSVResult();
        end
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
            this.scrollViewRank:Clear(true);
        end
    end,
    before_destroy = function(vm)
        if vm.behaviour.Params ~= nil then
            UIScrollView.ClearItem("UI2048RankItem")
        end
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)