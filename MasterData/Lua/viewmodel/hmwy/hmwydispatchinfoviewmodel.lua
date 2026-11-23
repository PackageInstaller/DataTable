
local this = {
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
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnCancelDispatch = uiLink:Get("btnCancelDispatch"):GetComponent("Button");
    ui.txtName = uiLink:Get("txtName"):GetComponent("Text");
    ui.txtTime = uiLink:Get("txtTime"):GetComponent("Text");
    ui.txtDes = uiLink:Get("txtDes"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.ScrollbarVertical = uiLink:Get("ScrollbarVertical"):GetComponent("ScrollRect");
    ui.tranRewards = uiLink:Get("tranRewards"):GetComponent("RectTransform");
   
    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
   uiLink:AddClickEvent("btnCancelDispatch",function()
      this.OnAskCannelDispatch()
   end)
    uiLink:AddClickEvent("btnMask",function()
       LuaMgr.HidePanel(UIName.HMWYDispatchInfoViewModel)
    end)
    
end

this.OnAskCannelDispatch=function()
    if  this.remainTime<=60 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("30261"))
        return
    end
    local askData={Id=this.dispatchId};
    ApiMgr.Request("HMWYGame/cancel",askData,true,function(re)
        if HMWYDispatchMgr.dispatchCallBack~=nil then
            HMWYDispatchMgr.dispatchCallBack();
        end
        LuaMgr.HidePanel(UIName.HMWYDispatchInfoViewModel);
    end,function()  end,true)
end

local data = {}
local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour);
        this.btnCancelUIGray=ui.btnCancelDispatch.transform:GetComponent("UIGray");
        this.itemList={};
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>1 then
            this.dispatchId=vm.behaviour.Params[0];
            this.rewardLevel=vm.behaviour.Params[1];
            this.cfgDispatchEvent=ConfigMgr.Config.HmwyDispatchEventCheckMap[this.dispatchId];
            this.btnCancelUIGray.IsGray=false;
        end
        this.ParseData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.HMWYDispatchTime)
        for i,v in pairs(this.itemList) do
            SetActive(v.gameObject,false);
        end
    end,
    before_destroy = function()
        this.ClearUI()
     
    end
}

this.UpdateTime=function()
    this.btnCancelUIGray.IsGray=this.remainTime<=60;
    this.remainTime=this.remainTime<0 and 0 or this.remainTime;
    local h,m,s=GetTimeHMS2(this.remainTime)
    ui.txtTime.text=string.format("%.2d:%.2d:%.2d",h,m,s);
    this.remainTime=this.remainTime-1;
    if this.remainTime<0 then
        LuaMgr.RemoveTimer(TimerConst.HMWYDispatchTime)
        LuaMgr.HidePanel(UIName.HMWYDispatchInfoViewModel)
        if HMWYDispatchMgr.dispatchCallBack~=nil then
            HMWYDispatchMgr.dispatchCallBack();
        end
    end
end

this.ParseData=function()
    local eventData=HMWYDispatchMgr.GetEventData(this.dispatchId)
    if eventData==nil then
        return
    end
    ui.txtName.text=LuaMgr.GetLangText(this.cfgDispatchEvent.NameLan);
    ui.txtDes.text=LuaMgr.GetLangText(this.cfgDispatchEvent.PlotLan);
    this.SetReward();
    this.remainTime=eventData.EndTime-LuaMgr.Timestamp();
    this.btnCancelUIGray.IsGray=this.remainTime<=60;
    if this.remainTime<0 then
        ui.txtTime.text=string.format("%.2d:%.2d:%.2d",0,0,0);
        LuaMgr.HidePanel(UIName.HMWYDispatchInfoViewModel)
        return;
    end
    LuaMgr.RemoveTimer(TimerConst.HMWYDispatchTime)
    LuaMgr.AddTimer(TimerConst.HMWYDispatchTime, this.UpdateTime,1,-1,true);
end

this.SetReward=function()
    if this.rewardLevel>0 then
        this.rewardLevel=this.rewardLevel>#this.cfgDispatchEvent.RewardItem and #this.cfgDispatchEvent.RewardItem or this.rewardLevel;
        local rewardList =this.cfgDispatchEvent.RewardItem[this.rewardLevel]
        local techTreeType4_Add=HMWYDispatchMgr.CalculateRewardAdd_TechTreeType4();
        local techTreeType6_Add=0
        if this.rewardLevel>=5 then
            techTreeType6_Add=HMWYDispatchMgr.CalculateRewardAdd_TechTreeType6();
        end
        for i,v in ipairs(rewardList) do
            if this.itemList[i]==nil then
                this.itemList[i]=GoodsDataItem.New(ui.tranRewards);
            end
            SetActive(this.itemList[i].gameObject,true);
            local itemData = table.Copy(ConfigMgr.Config.itemMap[v.id]);
            local reCount=v.count*(1+techTreeType6_Add+techTreeType4_Add)
            itemData.count0 = math.floor(reCount);
            this.itemList[i]:SetData(1, itemData, 1, false, Vector3.one*0.5, false, false);
        end
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})