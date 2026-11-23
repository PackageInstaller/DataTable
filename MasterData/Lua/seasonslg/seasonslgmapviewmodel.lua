require("SeasonSLG/MapBlockGroup")
require("SeasonSLG/MapBlockItem")
require("SeasonSLG/SeasonSLGMapMgr")

local this = {
   blockScrollView=nil;
   blockItemObj=nil;
   blockGroupObj=nil;

};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.Middle = uiLink:Get("Middle");
    ui.Right = uiLink:Get("Right");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranLayer1 = uiLink:Get("tranLayer1"):GetComponent("RectTransform");
    ui.tranLayer2 = uiLink:Get("tranLayer2"):GetComponent("RectTransform");
    ui.rawBg = uiLink:Get("rawBg"):GetComponent("RawImage");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.blockScrollView=UIScrollView.New(ui.ScrollView.transform.gameObject);
        this.blockGroupObj=vm.behaviour.transform:Find("template/blockGroup").gameObject;
        this.blockItemObj=vm.behaviour.transform:Find("template/block").gameObject;
        SeasonSLGMapMgr.scrollView=ui.ScrollView;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.AddUpdate(this.Update)
        this.ParseData();
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUpdate(this.Update)
    end,
    before_destroy = function()
        UIScrollView.ClearItem("MapBlockGroup")
        UIListView.ClearItem("MapBlockItem")
    end
}
this.Update=function()
    ui.tranLayer2.anchoredPosition=ui.tranLayer1.anchoredPosition;
end

this.ParseData=function()
    this.blockScrollView:Clear();
    local testDataList={};
    for i=1,264,1 do
        table.insert(testDataList,i);
    end

    this.blockGroupList = {};
    local groupCount = math.ceil(#testDataList / SeasonSLGMapMgr.mapConfig.col);
    for i = 1, groupCount do
        local startIdx = (i - 1) * SeasonSLGMapMgr.mapConfig.col + 1;
        local endIdx = math.min(startIdx + SeasonSLGMapMgr.mapConfig.col-1, #testDataList);
        local group = {};
        for j = startIdx, endIdx do
            table.insert(group, testDataList[j]);
        end
        table.insert(this.blockGroupList, group);
    end

    local list={}
    for i,v in ipairs(this.blockGroupList) do
        local groupItem={
            groupIndex=i,
            list=v;
            blockItemObj=this.blockItemObj,
            callBack=this.GroupCallBack,
        }
        local groupData=UIScrollData.GetData(this.blockGroupObj,"MapBlockGroup",3360,92,groupItem);
        table.insert(list,groupData);
    end
    this.blockScrollView:SetParams(LuaMgr.ScreenWidth(), 720);
    this.blockScrollView:SetPadding(0,0,-150,0)
    this.blockScrollView:SetData(list);
    this.blockScrollView.content.sizeDelta = SeasonSLGMapMgr.mapConfig.mapSize;
end


this.GroupCallBack=function(rowIndex,colIndex)
    local dataIndex=(rowIndex-1)*SeasonSLGMapMgr.mapConfig.col+colIndex;
    LuaDebug.error(dataIndex);
end

return vm({
    data = data,
    command = command,
    hook = hook
})