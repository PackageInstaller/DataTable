require("ViewModel/HMWY/Dispatch_HeroItem")
require("ViewModel/HMWY/Dispatch_RewardItem") 
require("ViewModel/HMWY/Dispatch_HeroIcon")
local this = {
    heroScrollView={};
    maxRewardUIList={};
    rewardUIList={};
    heroItemObj=nil;
    rewardItemObj=nil;
    dispatchHeroList={};
    heroIconUIList={};
    heroIconItemObj=nil;
    point1Obj=nil;
    point2Obj=nil;
    point1List={};
    point2List={};
  
};

local color1=UnityEngine.Color(131/255,10/255,10/255)
local color2=UnityEngine.Color(153/255,255/255,204/255,100/255)



local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.goods = uiLink:Get("goods");
    ui.Middle = uiLink:Get("Middle");
    ui.goVfx = uiLink:Get("goVfx");
    ui.goScrollView = uiLink:Get("goScrollView");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnDisPatch = uiLink:Get("btnDisPatch"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtDisPatchInfo = uiLink:Get("txtDisPatchInfo"):GetComponent("Text");
    ui.txtDisPatchTime = uiLink:Get("txtDisPatchTime"):GetComponent("Text");
    ui.txtDisPatchDes = uiLink:Get("txtDisPatchDes"):GetComponent("Text");
    ui.txtAttr1 = uiLink:Get("txtAttr1"):GetComponent("Text");
    ui.txtAttr2 = uiLink:Get("txtAttr2"):GetComponent("Text");
    ui.txtAttr3 = uiLink:Get("txtAttr3"):GetComponent("Text");
    ui.txtAttr4 = uiLink:Get("txtAttr4"):GetComponent("Text");
    ui.txtAttr5 = uiLink:Get("txtAttr5"):GetComponent("Text");
    ui.txtAttr6 = uiLink:Get("txtAttr6"):GetComponent("Text");
    ui.txtPro = uiLink:Get("txtPro"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranMaxRewardContent = uiLink:Get("tranMaxRewardContent"):GetComponent("RectTransform");
    ui.tranPolygon02 = uiLink:Get("tranPolygon02"):GetComponent("RectTransform");
    ui.tranPoint2 = uiLink:Get("tranPoint2"):GetComponent("RectTransform");
    ui.tranPolygon01 = uiLink:Get("tranPolygon01"):GetComponent("RectTransform");
    ui.tranPoint1 = uiLink:Get("tranPoint1"):GetComponent("RectTransform");
    ui.tranHeroList = uiLink:Get("tranHeroList"):GetComponent("RectTransform");
    ui.tranRewardContent = uiLink:Get("tranRewardContent"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
   uiLink:AddClickEvent("btnDisPatch",function()
       if not DataExHelper.CommonActivityCheck(ActivityKey.HMWY) then
           LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"))
           return;
       end
       if #this.dispatchHeroList==0 then
           LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText(LuaMgr.GetLangText("HMWYDispatchViewModel_0")))
           return;
       end
       this.OnAskDispatch();
   end)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.HMWYDispatchViewModel)
    end)
end


this.OnAskDispatch=function()
    local chars={};
    for i,v in ipairs(this.dispatchHeroList) do
        chars[v]=0;
    end
    local askData={Id=this.dispatchId,Chars=chars}
    ApiMgr.Request("HMWYGame/start",askData,true,function(re)

        if HMWYDispatchMgr.dispatchCallBack~=nil then
            HMWYDispatchMgr.dispatchCallBack();
        end
        LuaMgr.HidePanel(UIName.HMWYDispatchViewModel)
    end,function()  end,true)
end


local data = {}
local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour);
        this.heroScrollView=UIScrollView.New(ui.goScrollView);
        this.maxRewardUIList=UIListView.New(ui.tranMaxRewardContent);
        this.rewardUIList=UIListView.New(ui.tranRewardContent);
        this.heroItemObj=vm.behaviour.transform:Find("template/heroItem").gameObject;
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
        this.heroIconUIList=UIListView.New(ui.tranHeroList);
        this.heroIconItemObj=vm.behaviour.transform:Find("template/heroIcon").gameObject;
        this.tranPolygon_di=vm.behaviour.transform:Find("root/Middle/Info2/Attr/tranPolygon01"):GetComponent("LineChat");
        this.tranPolygon=vm.behaviour.transform:Find("root/Middle/Info2/Attr/tranPolygon02"):GetComponent("LineChat");
        this.point1Obj=vm.behaviour.transform:Find("template/point1").gameObject;
        this.point2Obj=vm.behaviour.transform:Find("template/point2").gameObject;
        this.point3Obj=vm.behaviour.transform:Find("template/point3").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>0 then
            this.dispatchId=vm.behaviour.Params[0];
            this.cfgDispatchEvent=ConfigMgr.Config.HmwyDispatchEventCheckMap[this.dispatchId];
            this.hmwyConstant=ConfigMgr.Config.HmwyDispatchConstants;
            this.dispatchHeroList={};
            this.proLevel=0;
            SetActive(ui.goVfx,false);
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.heroScrollView:Clear();
        this.maxRewardUIList:Clear();
        this.rewardUIList:Clear();
        this.heroIconUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIScrollView.ClearItem("Dispatch_HeroItem")
        UIListView.ClearItem("Dispatch_RewardItem")
        UIListView.ClearItem("Dispatch_HeroIcon")
        this.ClearPoint2();
    end
}

this.ParseData=function()
    this.SetBaseInfo();
    this.SetMaxReward();
    this.SetHeroScrollView();
    this.SetHeroIconUIList();
    this.SetAttr();
    this.SetDispatchDegree();
    this.SetAttrReal();
    this.SetProReward();
end

this.SetBaseInfo=function()
    ui.txtDisPatchDes.transform.anchoredPosition=Vector2(11.5,0);
    ui.txtTitle.text=LuaMgr.GetLangText(this.cfgDispatchEvent.NameLan)
    ui.txtDisPatchDes.text=LuaMgr.GetLangText(this.cfgDispatchEvent.PlotLan); 
    local sec=this.cfgDispatchEvent.Duration*60
    local h,m,s=GetTimeHMS2(sec)
    ui.txtDisPatchTime.text=string.format("%.2d:%.2d:%.2d",h,m,s)
    ui.txtPro.text="";
end


this.GetRewardCfgData=function(level)
    if level==nil then

        level=#this.cfgDispatchEvent.RewardItem;
    end
    level=level>#this.cfgDispatchEvent.RewardItem and #this.cfgDispatchEvent.RewardItem or level;
    local rewards=this.cfgDispatchEvent.RewardItem[level];
    return rewards;
end


this.SetMaxReward=function()
    this.maxRewardUIList:Clear();
    local list={};
    local maxRewards=this.GetRewardCfgData();
    for i,v in ipairs(maxRewards) do
        local rewardData=UIListData.GetData(this.rewardItemObj,"Dispatch_RewardItem",v);
        table.insert(list,rewardData);
    end
    this.maxRewardUIList:SetData(list);
end


this.SetProReward=function()
    this.rewardUIList:Clear();
    if this.proLevel>0 then
        local list={};
        local rewards=this.GetRewardCfgData(this.proLevel);
        local techTreeType4_Add=HMWYDispatchMgr.CalculateRewardAdd_TechTreeType4();
        local techTreeType6_Add=0
        if this.proLevel>=5 then
            techTreeType6_Add=HMWYDispatchMgr.CalculateRewardAdd_TechTreeType6();
        end
        for i,v in ipairs(rewards) do
            local reCount=v.count*(1+techTreeType6_Add+techTreeType4_Add)
            local item={
                id=v.id,
                count=math.floor(reCount)
            }
            local rewardData=UIListData.GetData(this.rewardItemObj,"Dispatch_RewardItem",item);
            table.insert(list,rewardData);
        end
        this.rewardUIList:SetData(list);
    end
end

this.SetHeroScrollView=function()
    this.heroScrollView:Clear();
    local dispatchHeroList=HMWYDispatchMgr.GetDispatchHeroDataList(this.cfgDispatchEvent.RecHero);
    local list={};
    for i,v in ipairs(dispatchHeroList) do
        v.index=i;
        v.callBack=this.HeroCallBack;
        v.select=false;
        local heroData=UIScrollData.GetData(this.heroItemObj,"Dispatch_HeroItem",110,100,v);
        table.insert(list,heroData);
    end
    this.heroScrollView:SetParams(670,146)
    this.heroScrollView:SetData(list, true)
end

this.HeroCallBack=function(index,id)
    if this.UpdateScrollView(index,id) then
        SetActive(ui.goVfx,false);
        SetActive(ui.goVfx,true);
        this.SetHeroIconUIList();
        this.SetDispatchDegree();
        this.SetAttrReal();
    end
end

this.UpdateScrollView=function(index,id)
    local heroData=this.heroScrollView.dataList[index].data;
    if not heroData.unlock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("HMWYDispatchViewModel_1"))
        return false;
    end
    if  heroData.lockByEventId~=nil then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("HMWYDispatchViewModel_2"))
        return false;
    end
    local findIndex=NumTool.FindIndex(this.dispatchHeroList,id);
    if findIndex>0 then

        table.remove(this.dispatchHeroList,findIndex);
        heroData.select=false;
    else
        if #this.dispatchHeroList>=this.cfgDispatchEvent.MemNum then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("HMWYDispatchViewModel_3"))
            return false;
        end
        heroData.select=true;
        table.insert(this.dispatchHeroList,id);
    end
    this.heroScrollView:Refresh();
    return true;
end

this.SetHeroIconUIList=function()
    this.heroIconUIList:Clear();
    local list={};
    for i=1,6,1 do
        local iconItem={
            index=i,
        }
        if i<=#this.dispatchHeroList then
            iconItem.id=this.dispatchHeroList[i];
            iconItem.callBack=this.HeroIconCallBack;
        end
        iconItem.isLock=i>this.cfgDispatchEvent.MemNum
        local iconData=UIListData.GetData(this.heroIconItemObj,"Dispatch_HeroIcon",iconItem);
        table.insert(list,iconData);
    end
    this.heroIconUIList:SetData(list);
end

this.HeroIconCallBack=function(index)
    local id=this.dispatchHeroList[index]
    local view_index=nil;
    for i,v in ipairs(this.heroScrollView.dataList) do
        if v.data.id==id then
            view_index=i;
        end
    end
    if view_index==nil then
        LuaDebug.error("index is nil Error")
        return;
    end
    this.HeroCallBack(view_index,id)
end

this.SetAttr=function()
    local attrStr=ConfigMgr.LangGlobal("30104")
    local attrArray=NumTool.split(attrStr,"_");
    ui.txtAttr1.text=attrArray[1];
    ui.txtAttr2.text=attrArray[6];
    ui.txtAttr3.text=attrArray[5];
    ui.txtAttr4.text=attrArray[4];
    ui.txtAttr5.text=attrArray[3];
    ui.txtAttr6.text=attrArray[2];


    local patience =this.cfgDispatchEvent.Patience/this.hmwyConstant.DefaultValue;

    local speed=this.cfgDispatchEvent.Speed/this.hmwyConstant.DefaultValue;

    local cooperation=this.cfgDispatchEvent.Cooperation/this.hmwyConstant.DefaultValue;

    local professional=this.cfgDispatchEvent.Professional/this.hmwyConstant.DefaultValue;

    local courage=this.cfgDispatchEvent.Courage/this.hmwyConstant.DefaultValue;

    local optimism=this.cfgDispatchEvent.Optimism/this.hmwyConstant.DefaultValue;
    local lineChat_di={};
    table.insert(lineChat_di,patience)
    table.insert(lineChat_di,speed)
    table.insert(lineChat_di,cooperation)
    table.insert(lineChat_di,professional)
    table.insert(lineChat_di,courage)
    table.insert(lineChat_di,optimism)
    this.SetDrawLine_di(lineChat_di)
end

this.SetDrawLine_di=function(chatList)
    this.tranPolygon_di:SetPoints(chatList);

    local points=HMWYDispatchMgr.GetPolygonPoints(chatList,ui.tranPoint1.sizeDelta.x)
    for i=1,#points,1 do
        local obj=this.point1List[i];
        if obj==nil then
            this.point1List[i]=LuaMgr.InstantiateGO(this.point1Obj,ui.tranPoint1, false);
            obj=this.point1List[i];
        end
        obj.transform.anchoredPosition=points[i];
    end
    
end

this.CheckChangeColor=function(attr)
    if attr[1]>=this.cfgDispatchEvent.Patience and attr[2]>=this.cfgDispatchEvent.Speed and attr[3]>=this.cfgDispatchEvent.Cooperation and
            attr[4]>=this.cfgDispatchEvent.Professional and attr[5]>=this.cfgDispatchEvent.Courage and attr[6]>=this.cfgDispatchEvent.Optimism then
        return true;
    end
    return false;
end

this.SetAttrReal=function()
    local mergeAttr={0,0,0,0,0,0};
    for i,v in ipairs(this.dispatchHeroList) do
        local attrList=HMWYDispatchMgr.GetHeroAttrList(v);
        if #attrList>0 then
            for j=1,#mergeAttr,1 do
                mergeAttr[j]=mergeAttr[j]+attrList[j];
            end
        end
    end
    local pointObj=nil;
    if this.pro~=nil and this.pro>=1 then
        if not this.isColorRed then
            this.ClearPoint2();
        end
        this.isColorRed=true;
        pointObj=this.point2Obj;
        this.tranPolygon.topColor=color2
        this.tranPolygon.bottomColor=color2
        this.tranPolygon.edgeColor=color2;
    else
        if  this.isColorRed then
            this.ClearPoint2();
        end
        this.isColorRed=false;
        pointObj=this.point3Obj;
        this.tranPolygon.topColor=color1
        this.tranPolygon.bottomColor=color1
        this.tranPolygon.edgeColor=color1;
    end
    this.attrReal={};
    local maxRate=this.hmwyConstant.MaxValue/10000;
    for i,v in ipairs(mergeAttr) do
        local rate=v/this.hmwyConstant.DefaultValue;
        rate=rate>maxRate and maxRate or rate; ;
        table.insert(this.attrReal,rate);
    end
    this.tranPolygon:SetPoints(this.attrReal);
    SetActive(ui.tranPolygon02.gameObject,false);
    SetActive(ui.tranPolygon02.gameObject,true);
    if #this.dispatchHeroList==0 then
        for i,v in pairs(this.point2List) do
            SetActive(v.gameObject,false);
        end
        return;
    end

    local points=HMWYDispatchMgr.GetPolygonPoints(this.attrReal,ui.tranPoint2.sizeDelta.x)
    for i=1,#points,1 do
        local obj=this.point2List[i];
        if obj==nil then
            this.point2List[i]=LuaMgr.InstantiateGO(pointObj, ui.tranPoint2, false);
            obj=this.point2List[i];
        end
        SetActive(obj,true);
        obj.transform.anchoredPosition=points[i];
    end
end

this.ClearPoint2=function()
    for i,v in ipairs(this.point2List) do
        LuaMgr.DestroyImmediateGO(v);
    end
    this.point2List={};
end


this.SetDispatchDegree=function()
    this.proLevel=0;
    if #this.dispatchHeroList==0 then
        ui.txtPro.text="0%";
        this.pro=0;
        SetActive(ui.tranRewardContent.gameObject,false)
        return;
    end
    this.proLevel,this.pro=HMWYDispatchMgr.CalculateDispatchRate(this.dispatchHeroList,this.dispatchId);
    ui.txtPro.text=string.format("%.2f",this.pro*100).."%";
    if  this.proLevel==0 then
        SetActive(ui.tranRewardContent.gameObject,false)
        return;
    end


    SetActive(ui.tranRewardContent.gameObject,true)
    this.SetProReward();
end


return vm({
    data = data,
    command = command,
    hook = hook
})