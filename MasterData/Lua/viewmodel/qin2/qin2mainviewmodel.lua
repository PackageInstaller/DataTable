




require("ViewModel/Qin2/Qin2Main_LineType")
require("ViewModel/Qin2/Qin2Main_LineItem")
require("ViewModel/Qin2/Qin2EventMgr")

local this = { vm = nil,
               lineTypeUIList = nil;
               lineItemUIList = nil;
               lineTypeObj = nil;
               lineItemObj = nil;
               scenicList={};
               dataTour={};
               lineIndex=nil;
            
               
};

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local Right = nil;
local Left = nil;
local golineList = nil;
local text = nil;
local btnMask = nil;
local btnTask = nil;
local btnShop = nil;
local btnAutoView = nil;
local tranLineBG = nil;
local tranLineItemContent = nil;
local tranLineTypeContent = nil;
local gofxline01=nil;
local gofxline02=nil;
local gofxline03=nil;



this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    Left = uiLink:Get("Left");
    golineList = uiLink:Get("golineList");
    text = uiLink:Get("text"):GetComponent("Text");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnTask = uiLink:Get("btnTask"):GetComponent("Button");
    btnShop = uiLink:Get("btnShop"):GetComponent("Button");
    btnAutoView = uiLink:Get("btnAutoView"):GetComponent("Button");
    tranLineBG = uiLink:Get("tranLineBG"):GetComponent("RectTransform");
    tranLineItemContent = uiLink:Get("tranLineItemContent"):GetComponent("RectTransform");
    tranLineTypeContent = uiLink:Get("tranLineTypeContent"):GetComponent("RectTransform");
    gofxline01=uiLink:Get("gofxline01");
    gofxline02=uiLink:Get("gofxline02");
    gofxline03=uiLink:Get("gofxline03");
    this.AddRegister(uiLink);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    Right = nil;
    Left = nil;
    golineList = nil;
    text = nil;
    btnMask = nil;
    btnTask = nil;
    btnShop = nil;
    btnAutoView = nil;
    tranLineBG = nil;
    tranLineItemContent = nil;
    tranLineTypeContent = nil;
    gofxline01=nil;
    gofxline02=nil;
    gofxline03=nil;
end





local data={
    locNames={"","","","","","","","" }
}
local command={







}

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnTask",function()
        if this.CheckQin2Running() then
            LuaMgr.ShowLuaPanel(UIName.PassesMainViewModel)
        end
    end)
    uiLink:AddClickEvent("btnShop",function()
        if this.CheckQin2Running() then
            LuaMgr.ShowLuaPanel(UIName.Qin2ShopViewModel)
        end
    end)
    uiLink:AddClickEvent("btnAutoView",function()
        if this.CheckQin2Running() then
            this.AutoViewExecute();
        end
    end)
    uiLink:AddClickEvent("btnMask",function()
        SetActive(golineList,false);
        this.lineIndex=nil;
    end)
end


this.LineClickCallBack=function(index)
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/branch_close.mp3");
    if this.lineIndex==index then
        SetActive(golineList,false);
        this.lineIndex=nil;
        return;
    end
    if this.lineTypeUIList.itemList[index].data.isLock then
        local tipStr=ConfigMgr.LangGlobal("104002");
        local time=ConfigMgr.Config.TourMapMap[tostring(index)].Unlock[2]

        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tipStr,time))
        return;
    end
    this.lineIndex=index;
    this.SetLineItemsList(tostring(index));
    HeroRedDataHelper.SetQinTourRed();
    RedMgr.Singleton:Refresh();
end

this.LocCallBack=function(id,isUnlock)
    if this.CheckQin2Running()  then
        if not isUnlock then
           local UnlockInfo=ConfigMgr.Config.TourSpotMap[id].Unlock
            if UnlockInfo[1]=="2" then
                local spotName=ConfigMgr.Config.TourSpotMap[UnlockInfo[2]].ScenicSpotNameLan;
                spotName=LuaMgr.GetLangText(spotName);
                local novelID=ConfigMgr.Config.TourEventMap[UnlockInfo[3]].FightParameter
                local novelName=ConfigMgr.Config.narrativeMap[novelID].nameLan;
                novelName=LuaMgr.GetLangText(novelName);
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(ConfigMgr.LangGlobal("104008"),spotName,novelName));
            end
            return
        end
        LuaMgr.ShowLuaPanel(UIName.Qin2BuildViewModel,id);
    end
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.lineTypeObj=vm.behaviour.transform:Find("template/lineType").gameObject;
        this.lineItemObj=vm.behaviour.transform:Find("template/lineItem").gameObject;
        this.lineTypeUIList=UIListView.New(tranLineTypeContent);
        this.lineItemUIList=UIListView.New(tranLineItemContent);
        RedMgr.Singleton:RegisterViewModel(UIName.Qin2MainViewModel);
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:UpdateTopBar("", this.OnBack);
            SetActive(golineList,false);
            HeroRedDataHelper.SetQinTourRed();
            this.lineIndex=nil;
            this.ParseCfg();
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end;
        this.lineTypeUIList:Clear();
        this.lineItemUIList:Clear();
      
    end,
    before_destroy=function()
        this.Clear()
        UIListView.ClearItem("Qin2Main_LineType")
        UIListView.ClearItem("Qin2Main_LineItem")
    end
}

this.OnBack=function()
    HeroParameter.SelectAnalectId=nil;
    if not DataExHelper.CommonActivityCheck(ActivityKey.QinTour) then
        LuaMgr.Back();
    else
        LuaMgr.Back(ActivityKey.QinTour);
    end
end

this.ParseCfg=function()
     this.scenicList={}
    for i,v in pairs(ConfigMgr.Config.TourSpotMap) do
        table.insert(this.scenicList,v);
    end
    table.sort(this.scenicList,function(a, b) return tonumber(a.Id)<tonumber(b.Id) end)
end

this.ParseData=function()
    this.dataTour=DataMgr.Player.tour;
    this.SetLocNames();
    this.SetLinesList();
end



this.SetLocNames=function()
    for i,v in ipairs(this.scenicList) do
        this.vm.data.locNames[i]=LuaMgr.GetLangText(v.ScenicSpotNameLan);
    end
end


this.SetLinesList=function()
    local list={}
    for i=1,3,1 do
        local locItem={
            index=i,
            isComplete=this.CheckCompleteEvents(tostring(i)),
            isLock=IsNull(this.dataTour.unlockMap) or this.dataTour.unlockMap[tostring(i)]==nil,
            lineCallBack=this.LineClickCallBack,
            isShowTag=this.CheckShowTag(tostring(i)),
            redId="15003_"..i
        }
        if this.lineIndex==nil and not locItem.isLock and not locItem.isComplete then
            this.lineIndex=i;
        end
        local locData=UIListData.GetData(this.lineTypeObj,"Qin2Main_LineType",locItem);
        table.insert(list,locData)
    end
    SetActive(gofxline01,list[1].data.isComplete);
    SetActive(gofxline02,list[2].data.isComplete);
    SetActive(gofxline03,list[3].data.isComplete);
    this.lineTypeUIList:SetData(list);
    if not IsNullOrEmpty(this.lineIndex) then
        this.SetLineItemsList(tostring(this.lineIndex));
    end
end


this.CheckShowTag=function(lineId)
    for i,v in ipairs(ConfigMgr.Config.TourMapMap[lineId].ScenicSpot) do
        if this.CheckLineItemUnlock(v) then
            return true;
        end
    end
    return false;
end


this.CheckCompleteEvents=function(id)
    local splots=ConfigMgr.Config.TourMapMap[id].ScenicSpot
    for i,v in ipairs(splots) do
        local events=ConfigMgr.Config.TourSpotMap[v].TourEvent
        if not Qin2EventMgr.CheckFinishAreaEvents(events) then
            return false;
        end
    end
    return true;
end


this.GetScenicCompleteEventPro=function(scenicId)
    local events=ConfigMgr.Config.TourSpotMap[scenicId].TourEvent
    local proIndex=Qin2EventMgr.GetFinishEventCountByArea(events);
    return proIndex,#events;
end



this.SetLineItemsList=function(id)
    this.lineItemUIList:Clear();
    SetActive(golineList,true);
    golineList.transform.anchoredPosition=Vector2(124,174-(128*(tonumber(id)-1)))
    local list={}
    local scenicList=ConfigMgr.Config.TourMapMap[id].ScenicSpot
    for i,v in ipairs(scenicList) do
        local scenic=ConfigMgr.Config.TourSpotMap[v];
        local cur,total=this.GetScenicCompleteEventPro(v)
        local scenicItem={
            id=v,
            iconName=scenic.ScenicSpotPic,
            name=LuaMgr.GetLangText(scenic.ScenicSpotNameLan),
            pro=string.format("%.1f",cur/total*100).."%",
            isUnLock=this.CheckLineItemUnlock(v),
            locCallBack=this.LocCallBack
        }
        local scenicData=UIListData.GetData(this.lineItemObj,"Qin2Main_LineItem",scenicItem);
        table.insert(list,scenicData);
    end
    this.lineItemUIList:SetData(list);
    tranLineBG.sizeDelta=Vector2(58+#list*110,112)
    RedMgr.Singleton:FrushRedCondition("15003_"..id);
end

this.CheckLineItemUnlock=function(id)
    local Unlock=ConfigMgr.Config.TourSpotMap[id].Unlock
    if IsNull(Unlock) then return true end;
    if Unlock[1]=="1" then

        return DataMgr.Player.level>=tonumber(Unlock[1]);
    elseif Unlock[1]=="2" then

        if not IsNull(DataMgr.Player.tour.finishEvent) and DataMgr.Player.tour.finishEvent[Unlock[3]]~=nil then
            return true;
        end
        return false;
    end
end




this.AutoViewExecute=function()
    local scenicId=nil
    for i=1,3,1 do
        local tour=ConfigMgr.Config.TourMapMap[tostring(i)];
        if not IsNull(this.dataTour.unlockMap) and this.dataTour.unlockMap[tostring(i)]~=nil then
            for p,m in ipairs(tour.ScenicSpot) do
                local pro,Total=this.GetScenicCompleteEventPro(m);
                if pro~=Total then
                    scenicId=m;
                    break;
                end
            end
        end
        if scenicId~=nil then
            break
        end
    end
    if IsNullOrEmpty(scenicId) then
        scenicId="10001";
    end
    local unlock=this.CheckLineItemUnlock(scenicId)
    this.LocCallBack(scenicId,unlock);
end








this.CheckQin2Running=function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.QinTour) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"))
        return false
    end
    return true;
end


return vm({
    data = data,
    command = command,
    hook = hook
})