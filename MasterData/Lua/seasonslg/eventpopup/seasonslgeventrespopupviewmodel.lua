require("SeasonSLG/EventPopUp/ResItem")
local this = {
   resUIList={},
   resItemObj=nil;
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.rawIcon = uiLink:Get("rawIcon"):GetComponent("RawImage");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnComfrim = uiLink:Get("btnComfrim"):GetComponent("Button");
    ui.btnDispatch = uiLink:Get("btnDispatch"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtAdd = uiLink:Get("txtAdd"):GetComponent("Text");
    ui.txtButtonName = uiLink:Get("txtButtonName"):GetComponent("Text");
    ui.text = uiLink:Get("text"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
       LuaMgr.HidePanel(UIName.SeasonSlGEventResPopupViewModel)
    end)
    uiLink:AddClickEvent("btnComfrim",function()
        SeasonSLGAPI.OnAskResourceDispatchProgress(tostring(SeasonSLGEventMgr.curGridIndex),this.resId,function(re)
                    LuaMgr.HidePanel(UIName.SeasonSlGEventResPopupViewModel)
                    LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventResUpLevelPopupViewModel,this.resId,re)
                end)
    end)







end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.resUIList=UIListView.New(ui.tranContent)
        this.resItemObj= vm.behaviour.transform:Find("template/resItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>0 then
            this.resId=vm.behaviour.Params[0];
            this.cfgGirdRes=ConfigMgr.Config.SeasonalGridResourceMap[this.resId];
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.resUIList:Clear();
    end,
    before_destroy = function()
       UIListView.ClearItem("ResItem")
        this.ClearUI();
    end
}

this.ParseData=function()
    ui.txtTitle.text=SeasonSLGMapMgr.GetGridName(SeasonSLGEventMgr.curGridIndex)
    local dataResLevel=SeasonSLGEventMgr.GetGridResLevel(SeasonSLGEventMgr.curGridIndex);
    local resLevelId=this.cfgGirdRes.Level[dataResLevel];
    local cfgResLevel =ConfigMgr.Config.SeasonalGridResourceLevelMap[resLevelId]
    local itemIdList={};
    for i,v in ipairs(cfgResLevel.ProduceItem) do
        table.insert(itemIdList,v.id);
    end
    local addValue=SeasonSLGEventMgr.GetProductByBuff(itemIdList)
    ui.txtAdd.text=string.format(LuaMgr.GetLangText("SeasonSlGEventResPopupViewModel_0").."%.1f%%",addValue);
    this.SetResUIList(cfgResLevel.ProduceItem)
end

this.SetResUIList=function(itemList)
    this.resUIList:Clear();
    local list={}
    for i,v in pairs(itemList) do
        local item={
            itemId=v.id,
            name=string.format(LuaMgr.GetLangText("SeasonSlGEventResPopupViewModel_1"),ConfigHelper.ItemName(v.id)),
            des=string.format(LuaMgr.GetLangText("SeasonSlGEventResPopupViewModel_2"),v.count)
        }
        local itemData=UIListData.GetData(this.resItemObj,"ResItem",item);
        table.insert(list,itemData);
    end
    this.resUIList:SetData(list);
end



return vm({
    data = data,
    command = command,
    hook = hook
})