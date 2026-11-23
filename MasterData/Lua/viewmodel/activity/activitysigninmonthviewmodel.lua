




require("ViewModel/Activity/Month_GoodItem")
require("ViewModel/Activity/Month_RewardItem")
local this = {vm=nil};
local currentDay=nil;
local locDay=nil;
local currentMonth=nil;
local signTextLan=nil;
local terms=nil;
local monthReward={};
local dataMonthSignInRecord={};
local cfgterms=nil;
local cfgSignInNodeList={};
local remedyCheckingDay=nil;
local cfgReSignUpItem=nil;
local registerDay=nil;
local solarIndex=nil;
local animaName_chun="ani_chun";
local animaName_xia="ani_xia";
local animaName_qiu="ani_qiu";
local animaName_dong="ani_dong";

local isStopCheckIn=false;

local goodItemObj=nil
local contentUIList=nil;

local rewardItemObj=nil;
local item1UIList=nil;
local item2UIList=nil;
local coKey=nil;
local stopCoroutine=nil;



local tarGameObject = nil;
local tarRect = nil;
local goodItem = nil;
local root = nil;
local good = nil;
local Left = nil;
local Middle = nil;
local goMiddle = nil;
local goReward2 = nil;
local goNor = nil;
local goSolar = nil;
local goChun = nil;
local goXia = nil;
local goQiu = nil;
local goDong = nil;
local Right = nil;
local text = nil;
local textPoem1 = nil;
local textMonth = nil;
local textPoem2 = nil;
local textCheckIn = nil;
local textDay = nil;
local textLunar = nil;
local textSolarDay = nil;
local textSolarLunar = nil;
local textInfo = nil;
local btnMask = nil;
local btnCheckIn = nil;
local btnClose = nil;
local ScrollView = nil;
local tranItem1 = nil;
local tranItem2 = nil;
local imgSolar1 = nil;
local imgSolar2 = nil;
local textInfo = nil;
local btnMonth=nil;
local goSpecial=nil;
local btnMonthDouble = nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    goodItem = uiLink:Get("goodItem");
    root = uiLink:Get("root");
    good = uiLink:Get("good");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goMiddle = uiLink:Get("goMiddle");
    goReward2 = uiLink:Get("goReward2");
    goNor = uiLink:Get("goNor");
    goSolar = uiLink:Get("goSolar");
    goChun = uiLink:Get("goChun");
    goXia = uiLink:Get("goXia");
    goQiu = uiLink:Get("goQiu");
    goDong = uiLink:Get("goDong");
    Right = uiLink:Get("Right");
    text = uiLink:Get("text"):GetComponent("Text");
    textPoem1 = uiLink:Get("textPoem1"):GetComponent("Text");
    textMonth = uiLink:Get("textMonth"):GetComponent("Text");
    textPoem2 = uiLink:Get("textPoem2"):GetComponent("Text");
    textCheckIn = uiLink:Get("textCheckIn"):GetComponent("Text");
    textDay = uiLink:Get("textDay"):GetComponent("Text");
    textLunar = uiLink:Get("textLunar"):GetComponent("Text");
    textSolarDay = uiLink:Get("textSolarDay"):GetComponent("Text");
    textSolarLunar = uiLink:Get("textSolarLunar"):GetComponent("Text");
    textInfo = uiLink:Get("textInfo"):GetComponent("Text");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnCheckIn = uiLink:Get("btnCheckIn"):GetComponent("Button");
    btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    btnMonth=uiLink:Get("btnMonth"):GetComponent("Button");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    tranItem1 = uiLink:Get("tranItem1"):GetComponent("RectTransform");
    tranItem2 = uiLink:Get("tranItem2"):GetComponent("RectTransform");
    imgSolar1 = uiLink:Get("imgSolar1"):GetComponent("Image");
    imgSolar2 = uiLink:Get("imgSolar2"):GetComponent("Image");
    textInfo = uiLink:Get("textInfo"):GetComponent("UIText");
    goSpecial= uiLink:Get("goSpecial")
    btnMonthDouble = uiLink:Get("btnMonthDouble"):GetComponent("Button");

    uiLink:AddClickEvent("btnCheckIn",this.btnCheckInCommand)
    uiLink:AddClickEvent("btnMask",this.btnCloseCommand)
    uiLink:AddClickEvent("btnClose",this.btnCloseCommand)
    uiLink:AddClickEvent("btnMonth",this.btnGoMonthCommand)
    uiLink:AddClickEvent("btnMonthDouble",this.btnMonthDoubleCommand)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    goodItem = nil;
    root = nil;
    good = nil;
    Left = nil;
    Middle = nil;
    goMiddle = nil;
    goReward2 = nil;
    goNor = nil;
    goSolar = nil;
    goChun = nil;
    goXia = nil;
    goQiu = nil;
    goDong = nil;
    Right = nil;
    text = nil;
    textPoem1 = nil;
    textMonth = nil;
    textPoem2 = nil;
    textCheckIn = nil;
    textDay = nil;
    textLunar = nil;
    textSolarDay = nil;
    textSolarLunar = nil;
    textInfo = nil;
    btnMask = nil;
    btnCheckIn = nil;
    btnClose = nil;
    ScrollView = nil;
    tranItem1 = nil;
    tranItem2 = nil;
    imgSolar1 = nil;
    imgSolar2 = nil;
    textInfo = nil;
    goSpecial=nil;
    btnMonthDouble=nil;
end


this.btnCheckInCommand=function()
    if isStopCheckIn then return end;
    local remdedyCheckInNum=1;
    for i,v in pairs(dataMonthSignInRecord) do
        if v==2 then
            remdedyCheckInNum=remdedyCheckInNum+1;
        end
    end
    if remdedyCheckInNum>#cfgReSignUpItem then
        remdedyCheckInNum=#cfgReSignUpItem;
    end
    local remedyCost=cfgReSignUpItem[remdedyCheckInNum];
    local data={};
    table.insert(data,{
        id=remedyCost.id,
        count=remedyCost.count;
    });
    local jsonData=json.encode(data);
    LuaMgr.ShowConfirmConsumeViewModel(LuaMgr.GetLangText("ActivitySignInMonthViewModel_28"),jsonData,function()
        this.OnAskRemedyCheckIn();
    end,nil,nil);

end





this.btnCloseCommand=function()
    LuaMgr.HidePanel(UIName.ActivitySignInMonthViewModel);
end

this.btnGoMonthCommand=function()
    LuaMgr.HidePanel(UIName.ActivitySignInMonthViewModel)
    HeroParameter.MonthBuyTipActive=true;
    FeatureManager.GotoViewModel("1213")
end

this.btnMonthDoubleCommand=function()
    LuaMgr.HidePanel(UIName.ActivitySignInMonthViewModel)
    HeroParameter.MonthBuyTipActive=true;
    FeatureManager.GotoViewModel("1223")
end

this.bgClickCommand=function(index)
    if isStopCheckIn then return end;
    index=tonumber(index)
    if terms[index]~=0 then
        local rewards={};
        table.insert(rewards,monthReward[index])

    end

    if remedyCheckingDay==index then return end;
    contentUIList.itemList[remedyCheckingDay]:SetCheckingObjVisible(false);
    contentUIList.itemList[index]:SetCheckingObjVisible(true);
    remedyCheckingDay=index;
    this.ShowCheckInRewards(index);
    this.UpdateCheckBtn(index);
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour.gameObject)
        goodItemObj=vm.behaviour.transform:Find("template/goodItem").gameObject
        contentUIList=UIListView.New(vm.behaviour.transform:Find("root/Middle/Content/goMiddle/ScrollView/Viewport/Content"))
        rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject
        item1UIList=UIListView.New(tranItem1)
        item2UIList=UIListView.New(tranItem2);
       

    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            SetActive(goMiddle,false);
            cfgterms=ConfigMgr.Config.termsList;
            cfgReSignUpItem=ConfigMgr.Config.constants.ReSignUpItem;
            cfgSignInNodeList=ConfigMgr.Config.signInNodeList;
            dataMonthSignInRecord=DataMgr.Player.monthlySignInRecords;
            stopCoroutine=false;
            this.OnAskCheckInList();
               
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if vm.behaviour.Params == nil then return end;
        stopCoroutine=true;
        if coKey~=nil then
            coroutine_runner.stop(coKey)
            coKey=nil;
        end
        contentUIList:Clear();
    end,
    before_destroy=function()
        this.Clear()
        UIListView.ClearItem("Month_GoodItem")
    end
}
this.OnAskCheckInList=function()
    ActivityMgr.OnAskSignInMonth(function(data)
        if stopCoroutine then return end;
        registerDay=data.registDay;
        currentDay=data.currentDay;
        remedyCheckingDay=currentDay;
        currentMonth=data.month;
        monthReward=data.reward;
        signTextLan=data.signtextlan;
        terms=data.terms;
        locDay=currentDay;
        this.ParseData();

        if dataMonthSignInRecord[tostring(currentDay)]==nil then
            SetActive(btnCheckIn.transform.gameObject,true)
            this.OnAskCheckIn();
        else
            this.UpdateCheckBtn(currentDay)
        end
    end)
    
end



this.OnAskRemedyCheckIn=function()
    if remedyCheckingDay==nil or remedyCheckingDay==currentDay then
        return
    end
    local data={Day=remedyCheckingDay};
    isStopCheckIn=true
    ApiMgr.Request("monthly_remedy_sign_in", data, true, function(result)
        local re=json.decode(result);
        this.UpdateData(re);
        this.UpdateCheckBtn(currentDay)
        
    end, function()
        isStopCheckIn=false;
    end, true);
end



this.OnAskCheckIn=function()
    isStopCheckIn=true;
    ApiMgr.Request("monthly_sign_in", {}, true, function(result)
        local re=json.decode(result);
        this.UpdateData(re);
        this.UpdateCheckBtn(currentDay)
        HeroRedDataHelper.FrushMainShopRed();
        HeroRedDataHelper.UpdateSettingRed();
        RedMgr.Singleton:Refresh();
    end, nil, true);
    
end



this.UpdateData=function(data)
    contentUIList.itemList[remedyCheckingDay]:SetFXVisible(true)
    if coKey~=nil then
        coroutine_runner.stop(coKey)
    end
    coKey=coroutine_runner.start(function()
        coroutine_runner.wait(0.6)
        if stopCoroutine then return end;
        contentUIList.itemList[remedyCheckingDay]:SetFXVisible(false)
        local data=json.encode(data.result);
        LuaMgr.ShowItemRewared(data);
        locDay=remedyCheckingDay;
        this.ParseData();
    end)
    
end
    




this.ParseData=function()

    SetActive(goMiddle,true);
    isStopCheckIn=false;
    dataMonthSignInRecord=DataMgr.Player.monthlySignInRecords;
    solarIndex=terms[currentDay];
    this.SetMonthInfo()
    this.SetMonthReward();
    this.SetKePuInfo(currentDay);
    this.ShowCheckInRewards(locDay);
    local isDouble=this.CheckHasDoubleBuy();
    SetActive(btnMonthDouble.gameObject,not isDouble);
end

this.CheckHasDoubleBuy=function()

    local purchaseTime=DataMgr.Player.shop.purchaseTime;
    if IsNull(purchaseTime) or purchaseTime["300100501"]==nil then
        return false;
    end
    local payTime=purchaseTime["300100501"]-4*60*60
    local curTime=LuaMgr.Timestamp()-4*60*60;
    local payDate=os.date("*t",payTime);
    local curDate=os.date("*t",curTime);
    return payDate.year==curDate.year and payDate.month==curDate.month
end


this.UpdateCheckBtn=function(index)
    local isChecking=index<=currentDay and dataMonthSignInRecord[tostring(index)]==nil;
    SetActive(btnCheckIn.transform.gameObject,isChecking and index >= registerDay)
    SetActive(textInfo.gameObject,not isChecking or  index < registerDay)
    local info=""
    if isChecking and index<currentDay then
        info=LuaMgr.GetLangText("ActivitySignInMonthViewModel_29");
    elseif isChecking and index==currentDay then
        info=LuaMgr.GetLangText("ActivitySignInMonthViewModel_30");
    elseif not isChecking and index<=currentDay then
        info=LuaMgr.GetLangText("ActivitySignInMonthViewModel_31");
    elseif not isChecking and index>currentDay  then
        info=LuaMgr.GetLangText("ActivitySignInMonthViewModel_32");
    end
    textCheckIn.text=info
end

this.SetMonthInfo=function()
    local month=currentMonth
    if month>10 then
        month=currentMonth-10;
        month=LuaMgr.GetLangText("ActivitySignInMonthViewModel_35")..NumTool.GetMaxNum(month);
    else
        month=NumTool.GetMaxNum(month);
    end
    local poem=LuaMgr.GetLangText(signTextLan)
    poem=NumTool.split(poem,";")
    textPoem1.text=poem[1];
    textPoem2.text=poem[2];
    textMonth.text=string.format(LuaMgr.GetLangText("ActivitySignInMonthViewModel_36"),month)  
   
end

this.SetKePuInfo=function(index)
    SetActive(goSolar,solarIndex>0)
    SetActive(goNor,solarIndex==0);
    SetActive(goSpecial,currentMonth==5 and currentDay==18)
    this.SetKePuText();
    textDay.text=string.format(LuaMgr.GetLangText("ActivitySignInMonthViewModel_33"),currentMonth,index);
    textSolarDay.text=textDay.text;
    local date=os.date("*t",LuaMgr.Timestamp()-4*60*60);
    local timeStamp=os.time({year=date.year,month=date.month,day=index,hour=date.hour,min=date.min,sec=date.sec});
    textLunar.text=string.format(LuaMgr.GetLangText("ActivitySignInMonthViewModel_34"),LuaMgr.GetLunarDateByMD(timeStamp));
    textSolarLunar.text=textLunar.text;
    SetActive(goChun,solarIndex>0 and currentMonth>2 and currentMonth<6);
    SetActive(goXia,solarIndex>0 and currentMonth>5 and currentMonth<9);
    SetActive(goQiu,solarIndex>0 and currentMonth>8 and currentMonth<12);
    SetActive(goDong,solarIndex>0 and (currentMonth>11 or currentMonth<3));
    
end


this.SetKePuText=function()
    local kePu=nil;

    if solarIndex>0 then
        kePu=LuaMgr.GetLangText(cfgterms[solarIndex].SigninNotesLan);
        local term=cfgterms[solarIndex];
        imgSolar1.sprite=LuaMgr.GetSprite("Month",term.NamePic);
        imgSolar2.sprite=LuaMgr.GetSprite("Month",term.QIconPic);
    else

        local randomList={}
        for i,v in ipairs(cfgSignInNodeList) do
            if v.type==1 then
                table.insert(randomList,v);
            elseif v.type==2 and #v.date>1 then
                if currentMonth==tonumber(v.date[1]) and currentDay==tonumber(v.date[2]) then
                    kePu=LuaMgr.GetLangText(v.signinNotesLan)
                    break
                end
            end
        end

        if kePu==nil then

            local osDate=os.date("*t",LuaMgr.Timestamp())
            local numSeed=os.time({year=osDate.year,month=osDate.month,day=osDate.day});
            math.randomseed(numSeed)
            local index=math.random(#randomList)
            kePu=LuaMgr.GetLangText(randomList[index].signinNotesLan)
        end
    end
    SetActive(textInfo.gameObject,true);
    textInfo.text=kePu;
end



this.SetMonthReward=function()

    local datalist={};
    for i,v in ipairs(monthReward) do
        local termIndex=terms[i];
        local isChecking=i>=registerDay and i==currentDay and dataMonthSignInRecord[tostring(i)]==nil;
        local item=ConfigHelper.GetItemById(v.id);
        local checkInItem=
        {
            rare=LuaMgr.GetSprite("ItemRare","itemRare"..item.rare),
            icon=LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(v.id)),
            count=LuaMgr.NumFormat(v.count),
        }
        checkInItem.num = tostring(i);
        checkInItem.lock = i<registerDay;
        checkInItem.nowing=i>=registerDay and i==currentDay and dataMonthSignInRecord[tostring(i)]==nil;
        checkInItem.bg=isChecking and LuaMgr.GetSprite("Month","ui_qd_image_01_2") or LuaMgr.GetSprite("Month","ui_qd_image_01");
        checkInItem.checking = locDay==i;
        checkInItem.checkDone = i>=registerDay and dataMonthSignInRecord[tostring(i)]~=nil;
        checkInItem.reChecking=i>=registerDay and  i<currentDay and dataMonthSignInRecord[tostring(i)]==nil;
        checkInItem.tagBool=termIndex~=0;
        checkInItem.tagSprite=(termIndex~=0) and LuaMgr.GetSprite("Month",cfgterms[termIndex].SIconPic) or DefaultSprite;
        checkInItem.callBack=this.bgClickCommand
        local checkInData=UIListData.GetData(goodItemObj,"Month_GoodItem",checkInItem);
        table.insert(datalist,checkInData);
    end
    contentUIList:SetData(datalist);
end



















































    


this.ShowCheckInRewards=function(index)
    local isMonth=true;

    local vipOrder="300100201";
    local vipCards=DataMgr.Player.vipCards;
    if IsNull(vipCards) or  vipCards==nil  then
       isMonth=false;
    end
    if isMonth then
        vipCards= vipCards[vipOrder];
        if vipCards==nil or vipCards.Deadline<LuaMgr.Timestamp() then
            isMonth=false;
        end
    end
    if isMonth then
        local  yueVipCharge=ConfigMgr.Config.charge[vipOrder];
        if NumTool.GetLen(yueVipCharge.DayGoods)==0 then
           isMonth=false;
        end;
    end
    SetActive(btnMonth.gameObject,not isMonth);
    local reward=monthReward[index];
    local cfgItem=ConfigMgr.Config.itemMap[reward.id];
    local item1DataList={}
    local scale=isMonth and 0.55 or 0.68;
    local item1={
        id=reward.id,
        count=reward.count,
        name=LuaMgr.GetLangText(cfgItem.nameLan),
        type=1,
        scale=scale,
    }
    local item1Data=UIListData.GetData(rewardItemObj,"Month_RewardItem",item1)
    table.insert(item1DataList,item1Data);
    item1UIList:SetData(item1DataList)
    






    local item2DataList={}
    local yueVipCharge=ConfigMgr.Config.charge[vipOrder];
    for i,v in ipairs(yueVipCharge.DayGoods) do
        cfgItem=ConfigMgr.Config.itemMap[v.id];
        local yueItem={
            id=v.id,
            count=v.count,
            name=LuaMgr.GetLangText(cfgItem.nameLan),
            type=2,
            scale=scale,
        }
        local item2Data=UIListData.GetData(rewardItemObj,"Month_RewardItem",yueItem)
        table.insert(item2DataList,item2Data);
    end 
    item2UIList:SetData(item2DataList)
end
    


return vm({
    data = data,
    command = command,
    hook = hook
})