




require("ViewModel/Terminal/Review_WayPathItem")
local this = {vm=nil, 
              wayUIList={},
              wayItemObj=nil;
              activityId=nil;
              activityType = nil;
              callBack=nil;
              cfgActivityTheme=nil;
              isUnlock=false;
};

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local Left = nil;
local Right = nil;
local btnMask = nil;
local btnClose = nil;
local btnCancel = nil;
local btnConfirm = nil;
local txtSurplusNum = nil;
local txtInfo = nil;
local txtCostCount = nil;
local txtUnlockInfo = nil;
local ScrollView = nil;
local tranContent = nil;
local rawImageCostIcon = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    Left = uiLink:Get("Left");
    Right = uiLink:Get("Right");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    btnCancel = uiLink:Get("btnCancel"):GetComponent("Button");
    btnConfirm = uiLink:Get("btnConfirm"):GetComponent("Button");
    txtSurplusNum = uiLink:Get("txtSurplusNum"):GetComponent("Text");
    txtInfo = uiLink:Get("txtInfo"):GetComponent("Text");
    txtCostCount = uiLink:Get("txtCostCount"):GetComponent("Text");
    txtUnlockInfo = uiLink:Get("txtUnlockInfo"):GetComponent("Text");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    rawImageCostIcon = uiLink:Get("rawImageCostIcon"):GetComponent("RawImage");
    this.AddReigister(uiLink);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    Left = nil;
    Right = nil;
    btnMask = nil;
    btnClose = nil;
    btnCancel = nil;
    btnConfirm = nil;
    txtSurplusNum = nil;
    txtInfo = nil;
    txtCostCount = nil;
    txtUnlockInfo = nil;
    ScrollView = nil;
    tranContent = nil;
    rawImageCostIcon = nil;

end



this.AddReigister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.ReViewUnlockViewModel);
    end)
    uiLink:AddClickEvent("btnClose",function()
        LuaMgr.HidePanel(UIName.ReViewUnlockViewModel);
    end)
    uiLink:AddClickEvent("btnCancel",function()
        LuaMgr.HidePanel(UIName.ReViewUnlockViewModel);
    end)
    uiLink:AddClickEvent("btnConfirm",function()
        this.CheckUnlockActivityTheme();
    end)
end


this.CheckUnlockActivityTheme=function()
    if not this.isUnlock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("17326"))
        return
    end
    ApiMgr.Request("activityreview/unlock",{ID=this.activityId},true,function(re)
        if this.callBack~=nil then
            this.callBack();
        end
        LuaMgr.HidePanel(UIName.ReViewUnlockViewModel);
    end,nil,true)
end


local data={}

local command = {

}


local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
        this.Init(vm.behaviour)
        this.wayUIList=UIListView.New(tranContent);
        this.wayItemObj=vm.behaviour.transform:Find("template/wayPathItem").gameObject
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>1 then
            this.activityId=vm.behaviour.Params[0];
            this.activityType = vm.behaviour.Params[1];
            this.callBack=vm.behaviour.Params[2];
            this.cfgActivityTheme=ConfigMgr.Config.ActivityThemeMap[this.activityId];
            this.ParseData();
        end
    end,
   
    before_deactive = function(vm)
        print("before_deactive");
        if (vm.behaviour.Params == nil) then return end
        this.wayUIList:Clear();
    end,
    
    before_destroy=function()
       UIListView.ClearItem("Review_WayPathItem") 
        this.Clear();
    end
}

this.ParseData=function()
    tranContent.anchoredPosition=Vector2(0,0);
    if #this.cfgActivityTheme.Unlock==3 then
        local itemId=this.cfgActivityTheme.Unlock[2];
        local itemConfig=ConfigMgr.Config.itemMap[itemId];
        local myCount=DataHelper.GetItemCountById(itemId);
        txtSurplusNum.text=myCount
        txtInfo.text=LuaMgr.GetLangText(itemConfig.DescriptionLan);
        txtCostCount.text=this.cfgActivityTheme.Unlock[3];
        rawImageCostIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(itemId))
        local name = LuaMgr.GetLangText(ConfigMgr.Config.activityGroup[tostring(this.activityType)].nameLan)
        txtUnlockInfo.text=string.format(ConfigMgr.LangGlobal("17325"),name)
        this.SetWayPathList(itemConfig);
        this.isUnlock=myCount>=tonumber(this.cfgActivityTheme.Unlock[3]);
    end
end


this.SetWayPathList=function(itemConfig)
    if itemConfig==nil then return end;
    this.wayUIList:Clear();

    local list={}
    if not IsNull(itemConfig.Source1) then
        for i,v in ipairs(itemConfig.Source1) do
            local cfgInterface=ConfigInterfaceMgr.GetInterfaceById(v);
            if cfgInterface~=nil then
                local wayItem={
                    wayName=LuaMgr.GetLangText(cfgInterface.NameLan);
                    jumpId=cfgInterface.id;
                    callBack=this.JumpCallBack;
                }
                local wayItemData=UIListData.GetData(this.wayItemObj,"Review_WayPathItem",wayItem);
                table.insert(list,wayItemData);
            end
        end
    end
    if not IsNullOrEmpty(itemConfig.Source3) then
        local wayItem={
            wayName=ConfigMgr.LangGlobal(itemConfig.Source3);
            jumpId=nil;
            callBack=nil;
        }
        local wayItemData=UIListData.GetData(this.wayItemObj,"Review_WayPathItem",wayItem);
        table.insert(list,wayItemData);
    end
    this.wayUIList:SetData(list);
   
end

this.JumpCallBack=function(jumpId)
    if not IsNullOrEmpty(jumpId) and not FeatureManager.IsLock(jumpId)then
        FeatureManager.GotoViewModel(jumpId);
        LuaMgr.HidePanel(UIName.ReViewUnlockViewModel);
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})