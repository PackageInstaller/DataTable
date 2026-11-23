require("ViewModel/Activity/BetaList_ActItem")

local this = {
    vm=nil,
    versionRewardVMList={};
    activeUIList={},
    activeItemObj=nil;
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
    ui.rectBgInfo = uiLink:Get("rectBgInfo"):GetComponent("RectTransform");
    ui.tranTopContent = uiLink:Get("tranTopContent"):GetComponent("RectTransform");
    ui.tranActivityContent = uiLink:Get("tranActivityContent"):GetComponent("RectTransform");
    ui.txtInfo = uiLink:Get("txtInfo"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.ScrollbarVertical = uiLink:Get("ScrollbarVertical"):GetComponent("ScrollRect");

    this.AddRegister(uiLink)
end

this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    
end


local data = {};

local command = {};

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitUI(vm.behaviour)
        this.activeUIList=UIListView.New(ui.tranActivityContent);
        this.activeItemObj=vm.behaviour.transform:Find("template/activityItem").gameObject;
        this.versionRewardVMList={}
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        HeroParameter.SaveActivityKey(nil)
        this.ParseData();
    end,
    before_deactive = function(vm)
      
    end,
    before_destroy=function()
        UIListView.ClearItem("BetaList_ActItem");
        this.versionRewardVMList={};
    end
}

this.ParseData=function()
    local curTime=LuaMgr.Timestamp();
    this.curVersion=nil;
    for i,v in pairs(ConfigMgr.Config.ActivityVersionMap) do
        if curTime>=v.StartTime and curTime<v.EndTime then
            this.curVersion=v;
        end
    end
    if this.curVersion~=nil then
        this.SetVersionInfo();
        this.SetVersionActiveData();
    end
    
end

this.SetVersionInfo=function()
    ui.txtInfo.text=LuaMgr.GetLangText(this.curVersion.NameLan)
    local ver_RewardIds=this.curVersion.Reward
    if #this.versionRewardVMList>0 and #this.versionRewardVMList>#ver_RewardIds then
        for i=#ver_RewardIds+1,#this.versionRewardVMList,1 do
            SetActive(this.versionRewardVMList[i].transform.gameObject,false);
        end
    end
    if #ver_RewardIds>0 then
        for i=1,#ver_RewardIds,1 do
            if i>#this.versionRewardVMList then
                local vmItem=GoodsDataItem.New(ui.tranTopContent)
                table.insert(this.versionRewardVMList,vmItem);
            end
            local itemVM=this.versionRewardVMList[i];
            local itemConfig = table.Copy(ConfigMgr.Config.itemMap[ver_RewardIds[i]]);
            itemConfig.count0 = 0;
            itemVM:SetData(1, itemConfig, 1, false, Vector3(0.56,0.56,1), false,true);
        end
    end
end

this.SetVersionActiveData=function()
    local curTime=LuaMgr.Timestamp();
    this.versionActiveList={};
    for i,v in pairs(ConfigMgr.Config.ActivityOverAllMap) do

        if v.Version==this.curVersion.Version and curTime<=v.EndTime then
            table.insert(this.versionActiveList,v);
        end
    end
    if #this.versionActiveList>0 then
        table.sort(this.versionActiveList,function(a, b)
            return a.Order<b.Order
        end)
        this.SetVersionActiveList();
    end
end

this.SetVersionActiveList=function()
    local list={};
    local curTime=LuaMgr.Timestamp();
    for i,v in ipairs(this.versionActiveList) do

        if not v.Open or curTime>=v.StartTime then
            local activeItem={
                index=i,
                tagName=LuaMgr.GetLangText(v.DescLan),
                name=LuaMgr.GetLangText(v.NameLan),
                rewardIds=v.Reward,
                tagType=v.PicId,
                jumpCallBack=this.JumpCallBack
            }
            if v.TimerBool==0 then
                activeItem.endTime=v.EndTime;
            end
            local activeData=UIListData.GetData(this.activeItemObj,"BetaList_ActItem",activeItem);
            table.insert(list,activeData);
        end
    end
    this.activeUIList:SetData(list);
end

this.JumpCallBack=function(index)
    local activeItem=this.versionActiveList[index];
    if LuaMgr.Timestamp() - activeItem.StartTime <= 0  then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("7206"))
        return;
    end
    if  activeItem.EndTime-LuaMgr.Timestamp()<=0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("27105"))
        return;
    end
    if not IsNullOrEmpty(activeItem.InterFace) then
        HeroParameter.SaveActivityKey(ActivityKey.BetaActivity)
        FeatureManager.GotoViewModel(activeItem.InterFace)
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})